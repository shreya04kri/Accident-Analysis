#1.How many accidents occur in urban area vs in rural area
SELECT Area,
COUNT(AccidentIndex) AS "Total Accident"
FROM accident
GROUP BY Area;

#2. Which day of week has heighest number of accidents?
SELECT Day,
       COUNT(AccidentIndex) AS `Total Accident`
FROM accident
GROUP BY Day
ORDER BY `Total Accident` DESC;

#3. What is the average age of the vehicles involved in accidents based on their type?
Select VehicleType,
	count(AccidentIndex) as 'Total Accident',
	round(avg(AgeVehicle)) as 'Average Year'
from vehicle
where AgeVehicle is not null
group by VehicleType
ORDER BY `Total Accident` DESC;

#4. Can we identify any trend involved in accidents based on the age of vehicles involved?
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

#5. Are there any specific weather conditions that contribute to severe accidents?
set @Severity :="Fatal";
SELECT WeatherConditions,
       COUNT(Severity) AS "Total Accident"
FROM accident
where Severity= @Severity
GROUP BY WeatherConditions
ORDER BY `Total Accident` DESC;

#6. Do accidents often involve impacts on the left hand side of vehicles?
select
	LeftHand,
    count(AccidentIndex) as "Total Accidents"
from
	vehicle
where LeftHand is not null
group by
	LeftHand;

#7. Are there any relationships between journey purposes and severity of accients?
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
    
#8. Calculate average age of vehicles involved in accidents, considering daylight and point of impact.
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