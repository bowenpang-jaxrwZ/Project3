
from sqlalchemy import create_engine, Table, func, desc
from sqlalchemy.orm import Session
from flask import Flask, jsonify, request, render_template
from flask_cors import CORS
from sqlalchemy.ext.automap import automap_base

engine = create_engine('postgresql://postgres:531614@127.0.0.1/crime')
session = Session(bind=engine)
Base = automap_base()
Base.prepare(autoload_with=engine)

## Mirror the database
assault = Base.classes.assault
auto_theft = Base.classes.auto_theft
bike_theft = Base.classes.bike_theft
break_and_enter = Base.classes.break_and_enter
homicide = Base.classes.homicide
neighbourhoods = Base.classes.neighbourhoods
robbery = Base.classes.robbery
shooting = Base.classes.shooting
theft_from_vehicle = Base.classes.theft_from_vehicle
theft_over = Base.classes.theft_over

table_list = ['assault','auto_theft','bike_theft','break_and_enter','homicide','robbery','shooting','theft_from_vehicle','theft_over']

app = Flask(__name__)
CORS(app)

@app.route('/crime_data')
## use this in d3.json --> 127.0.0.1/crime_data?crime_type=x&?neighborhood=y&?start_year=z&?end_year=zz
def crime_data():
    # Retrieve user-selected filters from request parameters
    neighborhood = request.args.get('neighborhood')
    crime_type = request.args.get('crime_type')
    start_year = request.args.get('start_year')
    end_year = request.args.get('end_year')

    # Retrieve data from database using filters
    if neighborhood and start_year and end_year:
        # Construct query for selected crime_type table
        table = Table(crime_type, Base.metadata, autoload=True, autoload_with=engine)
        query = session.query(table).filter(table.columns.HOOD_158 == neighborhood, table.columns.REPORT_YEAR >= start_year, table.columns.REPORT_YEAR <= end_year)
        rows = query.all()

        # Convert rows to a list of dictionaries
        data = [row._asdict() for row in rows]
        # Return data as JSON object
        response = jsonify({'data': data})
        response.headers.add('Access-Control-Allow-Origin', '*')
        return response
    else:
        # Return error message if required filters are not present
        return jsonify({'error': 'Please select a neighborhood and a start year and end year range.'})
    
@app.route('/neighborhoods')
def get_neighborhoods():
    # Retrieve list of neighborhoods and ID to populate drop down
    query = session.query(neighbourhoods)
    rows = query.all()
    # Convert rows to a list of dictionaries
    data = [{'value': row.HOOD_158, 'text': row.NEIGHBOURHOOD_158} for row in rows]
    # Return data as JSON object
    response = jsonify({'data': data})
    response.headers.add('Access-Control-Allow-Origin', '*')
    return response

@app.route('/radial')
def get_radial():
    # Retrieve user-selected filters from request parameters
    neighborhood = request.args.get('neighborhood')
    start_year = request.args.get('start_year')
    end_year = request.args.get('end_year')
    results = {}
    # Loop through the tables in the database
    for table_name in table_list:
        # Convert table strings into classes, putting classes in list caused errors.
        table_class = getattr(Base.classes, table_name)
        # Find the selected neighborhood within year range of each table
        query=session.query(func.count(table_class.HOOD_158)).filter(table_class.HOOD_158 == neighborhood, table_class.REPORT_YEAR >= start_year, table_class.REPORT_YEAR <= end_year)
        # Count the number of times the neighborhood appeared in each table
        count = query.scalar()
        # store the crime and count in results
        results[table_name] = count
    response = jsonify({'data':results})
    response.headers.add('Access-Control-Allow-Origin', '*')
    return response

@app.route('/top5')
def get_top5():
    # Retrieve user-selected filters from request parameters
    crime_type = request.args.get('crime_type')
    start_year = request.args.get('start_year')
    end_year = request.args.get('end_year')
    # Construct query for selected crime_type table
    table = Table(crime_type, Base.metadata, autoload=True, autoload_with=engine)
    # Search selected crime type table and count how many times each neighborhood is present within the range of years
    # Return only the top 5 safest neighborhoods
    query = session.query(table.columns.NEIGHBOURHOOD_158, func.count(table.columns.NEIGHBOURHOOD_158).label('count')).\
                filter(table.columns.REPORT_YEAR >= start_year, table.columns.REPORT_YEAR <= end_year).\
                group_by(table.columns.NEIGHBOURHOOD_158).\
                order_by('count').\
                limit(5).\
                all()
        
    results = {row.NEIGHBOURHOOD_158: row.count for row in query}
    response = jsonify({'data': results})
    response.headers.add('Access-Control-Allow-Origin', '*')
    return response


if __name__ == '__main__':
    app.run(debug=True)
