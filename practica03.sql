---------------1
SELECT* from employees
WHERE EXTRACT(MONTH FROM hire_date)=8;

---------------2
SELECT e.first_name, DEPARTMENT_NAME, j.first_name,STREET_ADDRESS,
  COUNTRY_NAME,REGION_NAME
FROM employees e
JOIN DEPARTMENTS d USING(DEPARTMENT_ID)
JOIN employees j ON (d.MANAGER_ID=j.EMPLOYEE_ID)
JOIN locations USING(LOCATION_ID)
JOIN COUNTRIES USING(COUNTRY_ID)
JOIN REGIONS USING(REGION_ID);


----------------3
SELECT COUNTRY_NAME, TO_CHAR(AVG(SALARY),'99G990D00$')
FROM EMPLOYEES
JOIN departments USING(DEPARTMENT_ID)
JOIN locations USING(LOCATION_ID)
JOIN COUNTRIES USING(COUNTRY_ID)
GROUP BY COUNTRY_NAME;

----------------3
SELECT COUNTRY_NAME, TO_CHAR(AVG(SALARY),'99G990D00$')
FROM EMPLOYEES
JOIN departments USING(DEPARTMENT_ID)
JOIN locations USING(LOCATION_ID)
JOIN COUNTRIES USING(COUNTRY_ID)
GROUP BY COUNTRY_NAME;

----------------4
SELECT first_name,SALARY
FROM EMPLOYEES
WHERE SALARY> (
  SELECT SALARY
  FROM EMPLOYEES
  WHERE FIRST_NAME = 'Guy' AND LAST_NAME = 'Himuro'
);

----------------5
SELECT first_name,LAST_NAME, count(*)
FROM EMPLOYEES
JOIN job_history USING(EMPLOYEE_ID)
GROUP BY first_name,LAST_NAME
HAVING COUNT(*)>1;

----------------6
SELECT first_name,LAST_NAME, count(*)
FROM EMPLOYEES e
JOIN job_history j USING(EMPLOYEE_ID)
JOIN departments d ON(d.DEPARTMENT_ID=e.DEPARTMENT_ID)
JOIN locations USING(location_id)
JOIN countries USING(country_id)
WHERE COUNTRY_NAME='United Kingdom'
GROUP BY first_name,LAST_NAME
HAVING COUNT(*)>1;

---------------------------7
----Opción 1
SELECT j.FIRST_NAME,j.LAST_NAME
FROM employees e
RIGHT OUTER JOIN employees j ON(e.manager_id=j.employee_id)
WHERE e.FIRST_NAME is null;

----Opción 2
SELECT FIRST_NAME,LAST_NAME
FROM EMPLOYEES
where (first_name,last_name) not in (
  SELECT j.first_name,j.last_name
  FROM employees j
  join employees e on (j.employee_id=e.manager_id)
);