--------------------------------2
CREATE TABLE jobs(
  job_id NUMBER(4) CONSTRAINT jobs_pk PRIMARY KEY,
  job_title VARCHAR2(35) CONSTRAINT jobs_nn NOT NULL,
  min_salary NUMBER(6),
  max_salary NUMBER(6)
);

CREATE TABLE employees(
  employee_id NUMBER(6) CONSTRAINT employees_pk PRIMARY KEY,
  first_name VARCHAR2(20),
  last_name VARCHAR2(20) CONSTRAINT employees_nn1 NOT NULL,
  email VARCHAR2(25) CONSTRAINT employees_nn2 NOT NULL
        CONSTRAINT employee_uk1 UNIQUE,
  phone_number VARCHAR2(20),
  hire_date DATE CONSTRAINT employees_nn3 NOT NULL,
  job_id NUMBER(4)  CONSTRAINT employees_nn4 NOT NULL
      CONSTRAINT employees_fk1 REFERENCES jobs,
  salary NUMBER(8,2),
  commision_pct NUMBER(2,2),
  manager_id NUMBER(6) CONSTRAINT employees_fk2 REFERENCES employees,
  department_id NUMBER(4)
);

CREATE TABLE departments(
  department_id NUMBER(4) CONSTRAINT departments_pk PRIMARY KEY,
  department_name VARCHAR2(30) CONSTRAINT departments_nn1 NOT NULL,
  location_id NUMBER(4),
  manager_id NUMBER(6) CONSTRAINT departments_fk2 REFERENCES employees
);

ALTER TABLE employees ADD CONSTRAINT employees_fk3 FOREIGN KEY(department_id) REFERENCES departments;

CREATE TABLE job_history(
  department_id NUMBER(4) CONSTRAINT job_history_fk1  REFERENCES departments,
  employee_id NUMBER(6) CONSTRAINT job_history_fk2 REFERENCES employees,
  start_date DATE,
  end_date DATE CONSTRAINT job_history_nn1 NOT NULL,
  job_id NUMBER(4) CONSTRAINT job_history_nn2 NOT NULL
      CONSTRAINT job_history_fk3 REFERENCES jobs,
  CONSTRAINT job_history_pk PRIMARY KEY(employee_id,start_date)
);

---------------------------3
INSERT INTO jobs values(1,'Jefe de Departamento',35000,50000);
INSERT INTO jobs values(2,'Técnico Superior',25000,40000);
INSERT INTO jobs values(3,'Operador',20000,32000);
commit;
INSERT INTO employees values(1,'Alfonso','García Bravo','alnfo_bravo@gmail.com',
                      '979777777','14/04/2016',1,5000,.05,null,null);
INSERT INTO employees values(2,'María','Sánchez Cabrito',
                       'marta_ole_yo@hotmail.com','979797979',
                       '1/04/2016',1,5000,0,null,null);
COMMIT;
INSERT INTO departments VALUES(1,'Ventas',null,1);
INSERT INTO departments VALUES(2,'Mantenimiento',null,2);
INSERT INTO departments VALUES(3,'Producción',null,null);
COMMIT;
/* Indicación de los departamentos a los que pertenecen los trabajadores*/
UPDATE employees SET department_id=1 WHERE employee_id=1;
UPDATE employees SET department_id=2 WHERE employee_id=2;
COMMIT;

INSERT INTO job_history VALUES(3,1,'10/1/2016','17/3/2016',2);
INSERT INTO job_history VALUES(2,1,'17/3/2016','14/4/2016',3);
commit;

