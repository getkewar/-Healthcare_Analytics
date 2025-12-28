# 📊 Healthcare Analytics – SQL & Excel Data Analysis Project

### 👤 Author – **Gajanan Getkewar**
**Role:** Data Analyst  
**Tech Stack:** SQL Server, Excel  
**Project Type:** Healthcare Data Analytics

---

## 🏥 Project Overview
This project analyzes hospital operational data including patients, doctors, treatments, appointments, insurance usage, and department-level revenue.  
Using SQL queries and Excel data cleaning, I transformed raw data into actionable insights that can help hospitals improve:

- Patient care
- Doctor workload distribution
- Financial planning
- Operational decision-making

---

## 🛠 Tools & Skills Used
| Tool / Skill | Description |
|--------------|-------------|
| **SQL Server Management Studio** | Query execution & testing |
| **Excel (Data Cleaning)** | Removed blanks, duplicates, corrected age formats |
| **SQL Techniques** | SELECT, JOIN, GROUP BY, HAVING, CASE, CAST(), COUNT(), SUM(), AVG(), ROUND() |
| **Analytics Skills** | Trend analysis, revenue analysis, segmentation, healthcare interpretation |

---

## 📂 Dataset Description
This project includes the following tables:

- `Patients`
- `Doctors`
- `Treatments`
- `Appointments`
- `Departments`
- `Insurance`

> If uploaded, dataset file: `HealthcareAnalytics.xlsx`

---

## 🧠 Key Insights Summary

### 👨‍⚕️ Patient Insights
- Largest patient segment → **Adults (19–40 years)**
- Most patients come from **Central region**
- Majority of patients have **no insurance**
- Average visits: **2 per patient**, frequent visitors: **≥5 visits**

### 🩺 Doctor Insights
| Metric | Result |
|--------|--------|
| Doctor with most patients | **Bob Wilson – 413** |
| Highest Revenue Doctor | **Jane Smith – ₹598,100** |
| Appointment monitoring | Duration & schedule extracted |

### 🏥 Treatment Insights
- **Most common**: Pediatric Vaccination (431)
- **Most expensive**: Cardiac Surgery (₹5,000)
- **Department workload**: Pediatrics busiest

### 📆 Appointment Patterns
- Monthly trends → peak visits **March–August**
- Longest appointment → **134 min**
- Missed appointments → **None found**

### 💰 Financial Insights
- Top earning department → **Cardiology (₹1,970,000+)**
- Average cost per patient calculated and compared by segment

---

## 🧪 Example SQL Query

```sql
-- Find most common treatments
SELECT Treatments.TreatmentID,
       Treatments.TreatmentName,
       COUNT(Appointments.AppointmentID) AS total_perform
FROM Treatments
JOIN Appointments
ON Treatments.TreatmentID = Appointments.TreatmentID
GROUP BY Treatments.TreatmentID, Treatments.TreatmentName
ORDER BY total_perform DESC;
