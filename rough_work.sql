USE vaccident;
SELECT * FROM accident;
SELECT * FROM vehicle;
Alter table vehicle
Rename column ï»¿VehicleID to VehicleID; 

#set primary key 
ALTER TABLE accident
MODIFY COLUMN AccidentIndex VARCHAR(255) NOT NULL;
SELECT AccidentIndex, COUNT(*) FROM accident GROUP BY AccidentIndex HAVING COUNT(*) > 1;
ALTER TABLE accident
ADD PRIMARY KEY (AccidentIndex);

SELECT Area,
COUNT(AccidentIndex) AS "Total Accident"
FROM accident
GROUP BY Area;

SELECT Day,
       COUNT(AccidentIndex) AS `Total Accident`
FROM accident
GROUP BY Day
ORDER BY `Total Accident` DESC;

Select VehicleType,
	count(AccidentIndex) as 'Total Accident',
	round(avg(AgeVehicle)) as 'Average Year'
from vehicle
where AgeVehicle is not null
group by VehicleType
ORDER BY `Total Accident` DESC;

select AgeGroup,
	count(AccidentIndex) as "Total Accident",
    round(avg(AgeVehicle)) as "Average Age"
from(
	  select AccidentIndex,
			 AgeVehicle,
			case
				when AgeVehicle between 0 and 5 then 'New'
				when AgeVehicle between 6 and 10 then 'Regular'
				else 'Old'
				end as AgeGroup
		from vehicle
	) as SubQuery
group by AgeGroup;

set @Severity :="Fatal";
SELECT WeatherConditions,
       COUNT(Severity) AS "Total Accident"
FROM accident
where Severity= @Severity
GROUP BY WeatherConditions
ORDER BY `Total Accident` DESC;

select
	LeftHand,
    count(AccidentIndex) as "Total Accidents"
from
	vehicle
where LeftHand is not null
group by
	LeftHand;

SELECT
    A.LightConditions,
    V.PointImpact,
    ROUND(AVG(V.AgeVehicle)) AS "Average Year"
FROM
    accident A
JOIN
    vehicle V ON V.AccidentIndex = A.AccidentIndex
GROUP BY
    A.LightConditions, V.PointImpact
ORDER BY
    `Average Year` DESC;

    
SELECT
    V.JourneyPurpose,
    COUNT(A.Severity) AS "Total Accident",
    CASE
        WHEN COUNT(A.Severity) BETWEEN 0 AND 1000 THEN 'Low'
        WHEN COUNT(A.Severity) BETWEEN 1001 AND 3000 THEN 'Moderate'
        ELSE 'High'
    END AS "Level"
FROM
    accident A
JOIN
    vehicle V ON V.AccidentIndex = A.AccidentIndex
GROUP BY
    V.JourneyPurpose
ORDER BY
    "Total Accident" DESC;