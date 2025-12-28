
-- Know who the patients are: age, gender, region, insurance.

-- patient gender
select 
Patients.Gender,
count(Patients.PatientID) as Total_patients
from
Patients
group by 
Patients.Gender;

-- region
select 
Patients.Region,
count(Patients.PatientID) as Total_patients
from 
Patients
group by 
Patients.Region
order by Total_patients desc;

-- Insurence
select
Patients.InsuranceType,
count(Patients.PatientID) as Total_patients
from
Patients
group by
Patients.InsuranceType
order by
Total_patients desc ;

-- Age
select
case
when Patients.Age < 18 then 'child'
when Patients.Age between 19 and 40 then 'adult'
when Patients.Age between 41 and 60 then 'middle_age'
else 'senior'
end as age_group,
count(Patients.PatientID) as total_patient
from
Patients
group by 
case
when Patients.Age < 18 then 'child'
when Patients.Age between 19 and 40 then 'adult'
when Patients.Age between 41 and 60 then 'middle_age'
else 'senior'
end
order by
total_patient desc;

-- See how often a patient visits the hospital.
select 
max(total_visit) as max_visit,
min(Total_visit) as min_visit,
round(avg(total_visit),0) as avg_visit
from(
select 
Patients.PatientID,
count(Appointments.AppointmentID) as total_visit
from
Patients
join Appointments
on Patients.PatientID = Appointments.PatientID
group by
Patients.PatientID
) visit_counts;

-- Identify patients who come often 
select 
Patients.PatientID,
concat(Patients.FirstName,' ',Patients.LastName) as full_name,
count(Appointments.AppointmentID) as total_visit
from
Patients
join Appointments
on Patients.PatientID = Appointments.PatientID
group by 
Patients.PatientID,
concat(Patients.FirstName,' ',Patients.LastName)
having 
count(Appointments.AppointmentID) >=5
order by
total_visit desc;


-- See how many patients each doctor treats.
select 
Doctors.DoctorID,
concat(Doctors.FirstName,' ',Doctors.LastName) as full_name,
count(distinct Appointments.PatientID) as total_patients
from
Doctors
join Appointments
on Doctors.DoctorID = Appointments.DoctorID
group by 
Doctors.DoctorID,
concat(Doctors.FirstName,' ',Doctors.LastName) 
order by 
total_patients desc;


-- Know which treatments each doctor does most.
select 
Doctors.DoctorID,
concat(Doctors.FirstName,' ',Doctors.LastName) as_full_name,
Treatments.TreatmentName,
count(Appointments.TreatmentID) as total_treatments
from
Appointments
join Doctors
on Appointments.DoctorID = Doctors.DoctorID
join Treatments
on Appointments.TreatmentID = Treatments.TreatmentID
group by
Doctors.DoctorID,
concat(Doctors.FirstName,' ',Doctors.LastName),
Treatments.TreatmentName
order by 
total_treatments desc;


-- Check doctor schedules and appointments.
select Doctors.DoctorID,
concat(Doctors.FirstName,' ',Doctors.LastName) as full_name,
Appointments.AppointmentDate,
Appointments.DurationMinutes
from
Doctors
join Appointments
on Doctors.DoctorID = Appointments.DoctorID
order by 
Appointments.AppointmentDate desc;


-- Find most common treatments.
select 
Treatments.TreatmentID,
Treatments.TreatmentName,
count(Appointments.AppointmentID) as total_perform
from
Treatments
join Appointments
on Treatments.TreatmentID = Appointments.TreatmentID
group by 
Treatments.TreatmentID,
Treatments.TreatmentName
order by
total_perform desc;

-- Know cost of treatments.
select
Treatments.TreatmentID,
Treatments.TreatmentName,
Treatments.Cost
from
Treatments;


-- Check department workload (like Cardiology, Pediatrics).
select 
Treatments.Department,
count(Appointments.AppointmentID) as total_appointment
from
Treatments
join Appointments
on Treatments.TreatmentID = Appointments.TreatmentID
group by
Treatments.Department
order by
total_appointment desc;

-- Monthly appointment trends
select 
year(Appointments.AppointmentDate) as year,
month(Appointments.AppointmentDate) as month,
count(Appointments.AppointmentID) total_appointments
from
Appointments
group by 
year(Appointments.AppointmentDate) ,
month(Appointments.AppointmentDate) 
order by
year, month;

-- Appointment duration analysis
select
max(Appointments.DurationMinutes) as maxduration,
avg(Appointments.DurationMinutes) as avgduration,
min(Appointments.DurationMinutes) as minduration
from
Appointments;

-- Missed appointments
SELECT *
FROM Appointments
WHERE DurationMinutes IS NULL
   OR DurationMinutes = 0;


-- Average cost per patient
SELECT
    Patients.PatientID,
    CONCAT(Patients.FirstName, ' ', Patients.LastName) AS full_name,
    CAST(
        ROUND(AVG(CAST(Treatments.Cost AS DECIMAL(10,2))), 2)
        AS DECIMAL(10,2)
    ) AS avg_cost
FROM Patients
JOIN Appointments
    ON Patients.PatientID = Appointments.PatientID
JOIN Treatments
    ON Appointments.TreatmentID = Treatments.TreatmentID
GROUP BY
    Patients.PatientID,
    CONCAT(Patients.FirstName, ' ', Patients.LastName)
    order by
    Patients.PatientID;


    --  cost per treatment
    select 
    Treatments.TreatmentID,
    Treatments.TreatmentName,
    Treatments.Cost
    from
    Treatments;

-- Revenue by department
select
Treatments.Department,
sum(Treatments.Cost) as total_revenue
from
Treatments
join Appointments
on Treatments.TreatmentID = Appointments.TreatmentID
group by 
Treatments.Department
order by
total_revenue desc;

-- Revenue by doctor
select
Doctors.DoctorID,
concat(Doctors.FirstName,' ',Doctors.LastName) as full_name,
sum(Treatments.Cost) as total_revenue
from 
Doctors
join Appointments
on Doctors.DoctorID = Appointments.DoctorID
join Treatments
on Appointments.TreatmentID = Treatments.TreatmentID
group by
Doctors.DoctorID,
concat(Doctors.FirstName,' ',Doctors.LastName);