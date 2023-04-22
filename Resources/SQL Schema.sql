-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/4DT5uN
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "neighbourhoods" (
    "HOOD_158" int   NOT NULL,
    "NEIGHBOURHOOD_158" varchar   NOT NULL,
    CONSTRAINT "pk_neighbourhoods" PRIMARY KEY (
        "HOOD_158"
     )
);

CREATE TABLE "assault" (
    "EVENT_UNIQUE_ID" varchar   NOT NULL,
    "HOOD_158" int   NOT NULL,
    "NEIGHBOURHOOD_158" varchar   NOT NULL,
    "X" FLOAT   NOT NULL,
    "Y" FLOAT   NOT NULL,
    "REPORT_YEAR" int   NOT NULL,
    "REPORT_MONTH" varchar   NOT NULL,
    "OFFENCE" varchar   NOT NULL,
    "MCI_CATEGORY" varchar   NOT NULL,
    CONSTRAINT "pk_assault" PRIMARY KEY (
        "EVENT_UNIQUE_ID"
     )
);

CREATE TABLE "auto_theft" (
    "EVENT_UNIQUE_ID" varchar   NOT NULL,
    "HOOD_158" int   NOT NULL,
    "NEIGHBOURHOOD_158" varchar   NOT NULL,
    "X" FLOAT   NOT NULL,
    "Y" FLOAT   NOT NULL,
    "REPORT_YEAR" int   NOT NULL,
    "REPORT_MONTH" varchar   NOT NULL,
    "OFFENCE" varchar   NOT NULL,
    "MCI_CATEGORY" varchar   NOT NULL,
    CONSTRAINT "pk_auto_theft" PRIMARY KEY (
        "EVENT_UNIQUE_ID"
     )
);

CREATE TABLE "bike_theft" (
    "EVENT_UNIQUE_ID" varchar   NOT NULL,
    "HOOD_158" int   NOT NULL,
    "NEIGHBOURHOOD_158" varchar   NOT NULL,
    "X" FLOAT   NOT NULL,
    "Y" FLOAT   NOT NULL,
    "PRIMARY_OFFENCE" varchar   NOT NULL,
    "REPORT_YEAR" int   NOT NULL,
    "REPORT_MONTH" varchar   NOT NULL,
    CONSTRAINT "pk_bike_theft" PRIMARY KEY (
        "EVENT_UNIQUE_ID"
     )
);

CREATE TABLE "break_and_enter" (
    "EVENT_UNIQUE_ID" varchar   NOT NULL,
    "HOOD_158" int   NOT NULL,
    "NEIGHBOURHOOD_158" varchar   NOT NULL,
    "X" FLOAT   NOT NULL,
    "Y" FLOAT   NOT NULL,
    "REPORT_YEAR" int   NOT NULL,
    "REPORT_MONTH" varchar   NOT NULL,
    "OFFENCE" varchar   NOT NULL,
    "MCI_CATEGORY" varchar   NOT NULL,
    CONSTRAINT "pk_break_and_enter" PRIMARY KEY (
        "EVENT_UNIQUE_ID"
     )
);

CREATE TABLE "homicide" (
    "EVENT_UNIQUE_ID" varchar   NOT NULL,
    "HOOD_158" int   NOT NULL,
    "NEIGHBOURHOOD_158" varchar   NOT NULL,
    "X" FLOAT   NOT NULL,
    "Y" FLOAT   NOT NULL,
    "REPORT_YEAR" int   NOT NULL,
    "REPORT_MONTH" varchar   NOT NULL,
    CONSTRAINT "pk_homicide" PRIMARY KEY (
        "EVENT_UNIQUE_ID"
     )
);

CREATE TABLE "robbery" (
    "EVENT_UNIQUE_ID" varchar   NOT NULL,
    "HOOD_158" int   NOT NULL,
    "NEIGHBOURHOOD_158" varchar   NOT NULL,
    "X" FLOAT   NOT NULL,
    "Y" FLOAT   NOT NULL,
    "REPORT_YEAR" int   NOT NULL,
    "REPORT_MONTH" varchar   NOT NULL,
    "OFFENCE" varchar   NOT NULL,
    "MCI_CATEGORY" varchar   NOT NULL,
    CONSTRAINT "pk_robbery" PRIMARY KEY (
        "EVENT_UNIQUE_ID"
     )
);

CREATE TABLE "shooting" (
    "EVENT_UNIQUE_ID" varchar   NOT NULL,
    "HOOD_158" int   NOT NULL,
    "NEIGHBOURHOOD_158" varchar   NOT NULL,
    "X" FLOAT   NOT NULL,
    "Y" FLOAT   NOT NULL,
    "REPORT_YEAR" int   NOT NULL,
    "REPORT_MONTH" varchar   NOT NULL,
    CONSTRAINT "pk_shooting" PRIMARY KEY (
        "EVENT_UNIQUE_ID"
     )
);

CREATE TABLE "theft_over" (
    "EVENT_UNIQUE_ID" varchar   NOT NULL,
    "HOOD_158" int   NOT NULL,
    "NEIGHBOURHOOD_158" varchar   NOT NULL,
    "X" FLOAT   NOT NULL,
    "Y" FLOAT   NOT NULL,
    "REPORT_YEAR" int   NOT NULL,
    "REPORT_MONTH" varchar   NOT NULL,
    "OFFENCE" varchar   NOT NULL,
    "MCI_CATEGORY" varchar   NOT NULL,
    CONSTRAINT "pk_theft_over" PRIMARY KEY (
        "EVENT_UNIQUE_ID"
     )
);

CREATE TABLE "theft_from_vehicle" (
    "EVENT_UNIQUE_ID" varchar   NOT NULL,
    "HOOD_158" int   NOT NULL,
    "NEIGHBOURHOOD_158" varchar   NOT NULL,
    "X" FLOAT   NOT NULL,
    "Y" FLOAT   NOT NULL,
    "REPORT_YEAR" int   NOT NULL,
    "REPORT_MONTH" varchar   NOT NULL,
    "OFFENCE" varchar   NOT NULL,
    "MCI_CATEGORY" varchar   NOT NULL,
    CONSTRAINT "pk_theft_from_vehicle" PRIMARY KEY (
        "EVENT_UNIQUE_ID"
     )
);

ALTER TABLE "assault" ADD CONSTRAINT "fk_assault_HOOD_158" FOREIGN KEY("HOOD_158")
REFERENCES "neighbourhoods" ("HOOD_158");

ALTER TABLE "auto_theft" ADD CONSTRAINT "fk_auto_theft_HOOD_158" FOREIGN KEY("HOOD_158")
REFERENCES "neighbourhoods" ("HOOD_158");

ALTER TABLE "bike_theft" ADD CONSTRAINT "fk_bike_theft_HOOD_158" FOREIGN KEY("HOOD_158")
REFERENCES "neighbourhoods" ("HOOD_158");

ALTER TABLE "break_and_enter" ADD CONSTRAINT "fk_break_and_enter_HOOD_158" FOREIGN KEY("HOOD_158")
REFERENCES "neighbourhoods" ("HOOD_158");

ALTER TABLE "homicide" ADD CONSTRAINT "fk_homicide_HOOD_158" FOREIGN KEY("HOOD_158")
REFERENCES "neighbourhoods" ("HOOD_158");

ALTER TABLE "robbery" ADD CONSTRAINT "fk_robbery_HOOD_158" FOREIGN KEY("HOOD_158")
REFERENCES "neighbourhoods" ("HOOD_158");

ALTER TABLE "shooting" ADD CONSTRAINT "fk_shooting_HOOD_158" FOREIGN KEY("HOOD_158")
REFERENCES "neighbourhoods" ("HOOD_158");

ALTER TABLE "theft_over" ADD CONSTRAINT "fk_theft_over_HOOD_158" FOREIGN KEY("HOOD_158")
REFERENCES "neighbourhoods" ("HOOD_158");

ALTER TABLE "theft_from_vehicle" ADD CONSTRAINT "fk_theft_from_vehicle_HOOD_158" FOREIGN KEY("HOOD_158")
REFERENCES "neighbourhoods" ("HOOD_158");
