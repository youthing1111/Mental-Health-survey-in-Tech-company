create table Health_survey(
    Timestamp VARCHAR(max),
    ID VARCHAR(max),
    Age VARCHAR(max),
    Gender VARCHAR(max),
    Country VARCHAR(max),
    state VARCHAR(max),
    self_employed VARCHAR(max),
    family_history VARCHAR(max),
    treatment VARCHAR(max),
    work_interfere VARCHAR(max),
    no_employees VARCHAR(max),
    remote_work VARCHAR(max),
    tech_company VARCHAR(max),
    benefits VARCHAR(max),
    care_options VARCHAR(max),
    wellness_program VARCHAR(max),
    seek_help VARCHAR(max),
    anonymity VARCHAR(max),
    leave VARCHAR(max),
    mental_health_consequence VARCHAR(max),
    phys_health_consequence VARCHAR(max),
    coworkers VARCHAR(max),
    supervisor VARCHAR(max),
    mental_health_interview VARCHAR(max),
    phys_health_interview VARCHAR(max),
    mental_vs_physical VARCHAR(max),
    obs_consequence VARCHAR(max),
    comment VARCHAR(max)
);

bulk insert Health_survey from 'E:\Health_survey.csv'
with (
    format = 'csv',
    FIRSTROW = 4,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a'
);

alter table Health_survey
drop COLUMN TIMESTAMP,Comment;

ALTER table Health_survey alter COLUMN age float;

-- Check for not suitable value 

select distinct Gender
from Health_survey

-- Update answer 

update Health_survey
set Gender = 'Male'
WHERE  
    (Gender = 'Cis Male') or 
    (Gender = 'Cis Man') or
    (Gender = 'Guy (-ish) ^_^') or 
    (Gender = 'm') or 
    (Gender = 'Mail') or 
    (Gender = 'maile') or 
    (Gender = 'Make') or
    (Gender = 'Mal')or
    (Gender = 'male') or
    (Gender = 'Male (CIS)') or
    (Gender = 'male leaning androgynous') or
    (Gender = 'Male-ish') or
    (Gender = 'Malr') or
    (Gender = 'Man') or
    (Gender = 'msle') or
    (Gender = 'ostensibly male, unsure what that really means') or
    Gender = 'something kinda male?';

update Health_survey
set Gender = 'Female'
WHERE
    (Gender = 'F') OR
    (Gender = 'femail') OR
    (Gender = 'Femake') OR
    (Gender = 'Female') OR
    (Gender = 'Female (cis)') OR
    (Gender = 'Female (trans)') OR
    (Gender = 'queer') OR
    (Gender = 'queer/she/they') OR
    (Gender = 'Trans woman') OR
    (Gender = 'Trans-female') OR
    (Gender = 'Woman') OR
    (Gender = 'Cis Female') OR
    (Gender = 'cis-female/femme');

update Health_survey
set Gender = 'Not indentified'
WHERE
    (Gender = 'A little about you') OR
    (Gender = 'Agender') OR
    (Gender = 'All') OR
    (Gender = 'Androgyne') OR
    (Gender = 'Enby') OR
    (Gender = 'fluid') OR
    (Gender = 'Genderqueer') OR
    (Gender = 'Nah') OR
    (Gender = 'Neuter') OR
    (Gender = 'non-binary') OR
    (Gender = 'p');

-- This code make the following code easier

select *
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'Health_survey'

-- Check for NULL value

select * from Health_survey 
where  
    ID is NULL or
    Age is NULL or
    Gender is NULL or
    Country is NULL or
    state is NULL or
    self_employed is NULL or
    family_history is NULL or
    treatment is NULL or
    work_interfere is NULL or
    no_employees is NULL or
    remote_work is NULL or
    tech_company is NULL or
    benefits is NULL or
    care_options is NULL or
    wellness_program is NULL or
    seek_help is NULL or
    anonymity is NULL or 
    leave is NULL or
    mental_health_consequence is NULL or
    phys_health_consequence is NULL or
    coworkers is NULL or
    supervisor is NULL or
    mental_health_interview is NULL or
    phys_health_interview is NULL or
    mental_vs_physical is NULL or
    obs_consequence is NULL;

-- Check for note suitable value in Age

select distinct Age
from Health_survey

-- Show median value of Age

SELECT
(
 (SELECT MAX(Age) FROM
   (SELECT TOP 50 PERCENT Age FROM Health_survey ORDER BY Age) AS BottomHalf)
 +
 (SELECT MIN(Age) FROM
   (SELECT TOP 50 PERCENT Age FROM Health_survey ORDER BY Age DESC) AS TopHalf)
) / 2 AS Median


-- Replace unsuit value with median 

update Health_survey
set Age = '31'
where 
    Age >= 60 or 
    Age <=18;
