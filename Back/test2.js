// Setup the selectors used for building the URL

//const neighborhood = $('#select-neighborhood')
const neighborhood = d3.select('#neighborhood');
const crimeType = d3.select('#crime-type');
const yearStart = d3.select('#start-year');
const yearEnd = d3.select('#end-year');
//const submit = d3.select('#submit-button');

//neighborhood.on("select2:select", handleChange)
//neighborhood.on("select2:unselect", handleChange)
//neighborhood.on("select2:clear", handleChange)

//neighborhood.on("change", handleChange)
//crimeType.on("change", handleChange)
//yearStart.on("change", handleChange)
//yearEnd.on("change", handleChange)
//submit.on("click", handleChange);
d3.select('form')
  .on('submit', function (event) {
    event.preventDefault(); // Prevent the form from submitting and resetting options
    handleChange(); // Call your function to handle the form submission
  });


let crimeData = null;

function plotCharts() {
  // Create a dynamic link based on user input
  let url = `http://localhost:5000/crime_data?crime_type=${crimeType.property("value")}&neighborhood=${neighborhood.property("value")}&start_year=${yearStart.property("value")}&end_year=${yearEnd.property("value")}`;
  fetch(url)
    .then(response => response.json())
    .then(data => {
      console.log(data);
      let crimeData = data.data;
      let counts = {};




      crimeData.forEach((crime) => {
        let year = crime.REPORT_YEAR;
        counts[year] = (counts[year] || 0) + 1;


      });

      const yearlyCrimeTrace =
      {
        x: Object.keys(counts),
        y: Object.values(counts),
        type: "line",
        name: "Yearly"

      };
      const yearlyCrimeLayout =
      {
        title: `${crimeType.property("value")} from ${yearStart.property("value")}-${yearEnd.property("value")}`,
        xaxis:
        {
          title: "Year"
        },
        yaxis:
        {
          title: "Number of Crimes each Year"
        }
      };

      console.log('Plotly:', Plotly);
      let lineData = [yearlyCrimeTrace];
      Plotly.newPlot("yearly-line-plot", lineData, yearlyCrimeLayout);




    });
}

function plotRadialCharts() {
  // Create a dynamic link based on user input
  let url = `http://localhost:5000/radial?neighborhood=${neighborhood.property("value")}&start_year=${yearStart.property("value")}&end_year=${yearEnd.property("value")}`;

  fetch(url)
    .then(response => response.json())
    .then(data => {

      let crimes = ['Auto Theft', 'Assault', 'Bike Theft', 'Homicide', 'Robbery', 'Shooting', 'Theft from MV', 'Theft Over', 'B&E'];
      let crimeKeys = ['auto_theft', 'assault', 'bike_theft', 'homicide', 'robbery', 'shooting', 'theft_from_vehicle', 'theft_over', 'break_and_enter'];
      let crimeCounts = data.data;
      console.log(crimeCounts);

      let radialData = [{
        r: crimeKeys.map(key => crimeCounts[key]),
        theta: crimes,
        name: "Crimes",
        type: "scatterpolar",
        fill: "toself"
      }];

      const radialLayout = {
        title: `Crime breakdown from ${yearStart.property("value")}-${yearEnd.property("value")}`,
        polar: {
          radialaxis: {
            visible: true,
            range: [0, Math.max(...radialData[0].r)],
          },
        },
      };

      Plotly.newPlot("radial-chart", radialData, radialLayout);
    });
}

function plotBarChart() {
  url = `http://localhost:5000/top5?crime_type=${crimeType.property("value")}&start_year=${yearStart.property("value")}&end_year=${yearEnd.property("value")}`;
  fetch(url)
    .then(response => response.json())
    .then(data => {
      let top5Data = data.data;
      let barTrace = {
        x: Object.keys(top5Data).reverse(),
        y: Object.values(top5Data).reverse(),
        type: 'bar'
      };
      let barLayout = {
        title: `Lowest ${crimeType.property("value")} occurence from ${yearStart.property("value")}-${yearEnd.property("value")}`
      };

      let barData = [barTrace];

      Plotly.newPlot("bar-chart", barData, barLayout);

    });

}


function map() {
  // Initialize the map
  var mymap = L.map("mapid").setView([43.6532, -79.3832], 10);
  // Add the tile layer to the map
  L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution:
      'Map data © <a href="https://openstreetmap.org">OpenStreetMap</a> contributors',
    maxZoom: 18,
  }).addTo(mymap);


  // Load the crime data from the specified URL and plot markers on the map
  $.getJSON(
    `http://localhost:5000/crime_data?crime_type=${crimeType.property("value")}&neighborhood=${neighborhood.property("value")}&start_year=${yearStart.property("value")}&end_year=${yearEnd.property("value")}`,

    function (data) {
      console.log("data1");
      console.log(data.data);

      // let marker = [];

      data.data.map((row) => {
        // console.log(row.X);
        var lat = row.Y;
        var lng = row.X;
        marker = L.marker([lat, lng]).addTo(mymap);
        var popupContent =
          "<div class='marker-popup'>" +
          "<h3>Crime Info</h3>" +
          // "<br> --------- </br>" +
          "Neighbourhood: " +
          row.NEIGHBOURHOOD_158 +

          "<p>Report Year: " +
          row.REPORT_YEAR +
          "</p>" +

          "<p>Report Month: " +
          row.REPORT_MONTH +
          "</p>"
        "</div>";
        marker.bindPopup(popupContent);

        // // Add the marker to the array
        // marker.push(marker);

        // mymap.clearLayers();
        // mymap.addLayer(marker);

      })
    }
  );
}




function handleChange() {
  console.log("Handling changes");
  // let neighborhoodVal = neighborhood.property("value");
  // let crimeTypeVal = crimeType.property("value");
  // let yearStartVal = yearStart.property("value");
  // let yearEndVal = yearEnd.property("value");
  plotCharts();
  plotRadialCharts();
  plotBarChart();
  map();
}


function setup() {
  fetch('http://localhost:5000/neighborhoods')
    .then(response => response.json())
    .then(data => {
      neighborhood.selectAll("option")
        .data(data.data)
        .enter()
        .append("option")
        .attr("value", d => d.value)
        .text(d => d.text);
    });

}

setup();