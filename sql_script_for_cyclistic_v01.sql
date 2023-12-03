-- Create table under public schemas 

CREATE TABLE "202211_to_202310" (
    ride_id VARCHAR(255),
    rideable_type VARCHAR(255),
    started_at TIMESTAMP,
	ended_at TIMESTAMP,
	start_station_name VARCHAR(255),
	start_station_id VARCHAR(255),
	end_station_name VARCHAR(255),
	end_station_id VARCHAR(255),
	start_lat DOUBLE PRECISION,
	start_lng DOUBLE PRECISION,
	end_lat DOUBLE PRECISION,
	end_lng DOUBLE PRECISION,
	member_casual VARCHAR(255)
);

-- CREATE TABLE with all 12 tables from 2022-11 to 2023-10

COPY public."202211_to_202310" FROM 'C:\Users\men_k\Desktop\G_Drive_Sync\Projects\Cyclistic\Datasets\202211-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
COPY public."202211_to_202310" FROM 'C:\Users\men_k\Desktop\G_Drive_Sync\Projects\Cyclistic\Datasets\202212-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
COPY public."202211_to_202310" FROM 'C:\Users\men_k\Desktop\G_Drive_Sync\Projects\Cyclistic\Datasets\202301-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
COPY public."202211_to_202310" FROM 'C:\Users\men_k\Desktop\G_Drive_Sync\Projects\Cyclistic\Datasets\202302-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
COPY public."202211_to_202310" FROM 'C:\Users\men_k\Desktop\G_Drive_Sync\Projects\Cyclistic\Datasets\202303-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
COPY public."202211_to_202310" FROM 'C:\Users\men_k\Desktop\G_Drive_Sync\Projects\Cyclistic\Datasets\202304-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
COPY public."202211_to_202310" FROM 'C:\Users\men_k\Desktop\G_Drive_Sync\Projects\Cyclistic\Datasets\202305-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
COPY public."202211_to_202310" FROM 'C:\Users\men_k\Desktop\G_Drive_Sync\Projects\Cyclistic\Datasets\202306-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
COPY public."202211_to_202310" FROM 'C:\Users\men_k\Desktop\G_Drive_Sync\Projects\Cyclistic\Datasets\202307-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
COPY public."202211_to_202310" FROM 'C:\Users\men_k\Desktop\G_Drive_Sync\Projects\Cyclistic\Datasets\202308-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
COPY public."202211_to_202310" FROM 'C:\Users\men_k\Desktop\G_Drive_Sync\Projects\Cyclistic\Datasets\202309-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;
COPY public."202211_to_202310" FROM 'C:\Users\men_k\Desktop\G_Drive_Sync\Projects\Cyclistic\Datasets\202310-divvy-tripdata.csv' DELIMITER ',' CSV HEADER;

-- CHECK for duplicates in "ride_id" column
SELECT ride_id, COUNT(*)
FROM public."202211_to_202310"
GROUP BY ride_id
HAVING COUNT(*) > 1;
	--- NO DUPLICATES

-- COUNTS the number rides from 2022-11 to 2023-10
SELECT COUNT(DISTINCT ride_id) AS rides
FROM public."202211_to_202310";
	--- Rides = 5652827

-- COUNT number of casual and member users from 2022-11 to 2023-10
SELECT member_casual, COUNT(*)
FROM public."202211_to_202310"
GROUP BY member_casual;
	--- member_casual	| count
	--- 1 casual 		| 2054781
	--- 2 member 		| 3598046

-- Busiest day of the week based on COUNTS
	
SELECT
    member_casual,
    TO_CHAR(started_at, 'Day') AS day_of_week,
    COUNT(*) AS ride_count
FROM
    public."202211_to_202310"
WHERE
    member_casual IS NOT NULL
GROUP BY
    member_casual, day_of_week
ORDER BY
    member_casual,
    MAX(EXTRACT(ISODOW FROM started_at)) DESC;
	
	--- member_casual	| day_of_week	| ride_count
	--- casual			| Sunday		| 332368
	--- casual			| Saturday		| 402227
	--- casual			| Monday		| 233981
	--- casual			| Tuesday		| 251929
	--- casual			| Wednesday		| 251865
	--- casual			| Thursday		| 271122
	--- casual			| Friday		| 311289
	--- member			| Sunday		| 398305
	--- member			| Saturday		| 456473
	--- member			| Monday		| 487185
	--- member			| Tuesday		| 582871
	--- member			| Wednesday		| 578393
	--- member			| Thursday		| 576276
	--- member			| Friday		| 518543

-- Busiest hour of the day based on COUNTS
	
SELECT
EXTRACT(HOUR FROM started_at) AS hour_of_day,
COUNT(*) AS ride_count
FROM
    public."202211_to_202310"
WHERE
    member_casual IS NOT NULL
GROUP BY
    hour_of_day
ORDER BY
    hour_of_day DESC
	
	---  	hour_of_day	| ride_count
	---	1 	23			| 105096
	---	2	22			| 155216
	--- 	3  	21			| 194077
	---	4	20			| 241990
	--- 	5	19			| 343591
	---  	6	18			| 476535
	--- 	7	17			| 582899
	--- 	8	16			| 506995
	--- 	9	15			| 400805
	--- 	10	14			| 338407
	--- 	11	13			| 329336
	--- 	12	12			| 325480
	--- 	13	11			| 282449
	--- 	14	10			| 231312
	--- 	15	9			| 230613
	--- 	16	8			| 310105
	--- 	17	7			| 244484
	--- 	18	6			| 134214
	--- 	19	5			| 45062
	--- 	20	4			| 14836
	--- 	21	3			| 15848
	--- 	22	2			| 26571
	--- 	23	1			| 45004
	--- 	24	0			| 71902


-- Find the average ride duration in minutes for casual vs member riders	
SELECT
    member_casual,
    AVG(EXTRACT(EPOCH FROM (ended_at - started_at)) / 60.0) AS avg_ride_duration_minutes
FROM
    public."202211_to_202310"
WHERE
    member_casual IS NOT NULL
GROUP BY
    member_casual;
	--- member_casual	| avg_ride_duration_minutes
	--- 1 casual		| 28
	--- 2 member		| 12

-- CHECK
SELECT *
FROM public."202211_to_202310"
LIMIT 1

-- EXPORT TABLE excluding Station Information, columns 





