SELECT c.id AS "ID"
,c.display_name AS Nombre
,c.activation_date AS "Fecha de Ingreso"
,o.name AS Area
,c.gender_cv_id  AS GENERO
FROM m_client AS c
INNER JOIN m_office AS o ON o.id=c.office_id
WHERE activation_date BETWEEN date('${startDate}') AND  date('${endDate}')
AND o.name = "Potrerillos"
AND c.status_enum = 300

UNION

SELECT "TOTALES POTRERILLOS" AS ID
,"======(Hombres--Mujeres--TODOS) " AS Nombre
,"HOMBRES " + COUNT(IF(c.gender_cv_id = 30, c.id , NULL)) AS "Fecha de Ingreso"
,"MUJERES " + COUNT(IF(c.gender_cv_id = 31, c.id , NULL)) AS AREA
,COUNT(c.id) AS gender
FROM m_client AS c
INNER JOIN m_office AS o ON o.id=c.office_id
WHERE activation_date BETWEEN date('${startDate}') AND  date('${endDate}')
AND o.name = "Potrerillos"
AND c.status_enum = 300

UNION

SELECT c.id AS "ID"
,c.display_name AS Nombre
,c.activation_date AS "Fecha de Ingreso"
,o.name AS Area
,c.gender_cv_id AS gender
FROM m_client AS c
INNER JOIN m_office AS o ON o.id=c.office_id
WHERE activation_date BETWEEN date('${startDate}') AND  date('${endDate}')
AND o.name = "RIO LINDO"
AND c.status_enum = 300

UNION

SELECT "TOTALES RIO LINDO" AS ID
,"======(Hombres--Mujeres--TODOS) " AS Nombre
,"HOMBRES " + COUNT(IF(c.gender_cv_id = 30, c.id , NULL)) AS "Fecha de Ingreso"
,"MUJERES " + COUNT(IF(c.gender_cv_id = 31, c.id , NULL)) AS AREA
,COUNT(c.id) AS gender
FROM m_client AS c
INNER JOIN m_office AS o ON o.id=c.office_id
WHERE activation_date BETWEEN date('${startDate}') AND  date('${endDate}')
AND o.name = "RIO LINDO"
AND c.status_enum = 300

UNION

SELECT c.id AS "ID"
,c.display_name AS Nombre
,c.activation_date AS "Fecha de Ingreso"
,o.name AS Area
,c.gender_cv_id AS gender
FROM m_client AS c
INNER JOIN m_office AS o ON o.id=c.office_id
WHERE activation_date BETWEEN date('${startDate}') AND  date('${endDate}')
AND o.name = "SAN MANUEL"
AND c.status_enum = 300

UNION

SELECT "TOTALES SAN MANUEL" AS ID
,"======(Hombres--Mujeres--TODOS) " AS Nombre
,"HOMBRES " + COUNT(IF(c.gender_cv_id = 30, c.id , NULL)) AS "Fecha de Ingreso"
,"MUJERES " + COUNT(IF(c.gender_cv_id = 31, c.id , NULL)) AS AREA
,COUNT(c.id) AS gender
FROM m_client AS c
INNER JOIN m_office AS o ON o.id=c.office_id
WHERE activation_date BETWEEN date('${startDate}') AND  date('${endDate}')
AND o.name = "SAN MANUEL"
AND c.status_enum = 300

UNION

SELECT c.id AS "ID"
,c.display_name AS Nombre
,c.activation_date AS "Fecha de Ingreso"
,o.name AS Area
,c.gender_cv_id AS gender
FROM m_client AS c
INNER JOIN m_office AS o ON o.id=c.office_id
WHERE activation_date BETWEEN date('${startDate}') AND  date('${endDate}')
AND o.name = "SAN PEDRO SULA"
AND c.status_enum = 300

UNION

SELECT "TOTALES SAN PEDRO SULA" AS ID
,"======(Hombres--Mujeres--TODOS) " AS Nombre
,"HOMBRES " + COUNT(IF(c.gender_cv_id = 30, c.id , NULL)) AS "Fecha de Ingreso"
,"MUJERES " + COUNT(IF(c.gender_cv_id = 31, c.id , NULL)) AS AREA
,COUNT(c.id) AS gender
FROM m_client AS c
INNER JOIN m_office AS o ON o.id=c.office_id
WHERE activation_date BETWEEN date('${startDate}') AND  date('${endDate}')
AND o.name = "SAN PEDRO SULA"
AND c.status_enum = 300

UNION

SELECT "=====TOTAL GENERAL=====" AS ID
,"======(Hombres--Mujeres--TODOS) " AS Nombre
,"HOMBRES " + COUNT(IF(c.gender_cv_id = 30, c.id , NULL)) AS "Fecha de Ingreso"
,"MUJERES " + COUNT(IF(c.gender_cv_id = 31, c.id , NULL)) AS AREA
,COUNT(c.id) AS gender
FROM m_client AS c
INNER JOIN m_office AS o ON o.id=c.office_id
WHERE activation_date BETWEEN date('${startDate}') AND  date('${endDate}')
AND c.status_enum = 300 and
c.office_id<8
