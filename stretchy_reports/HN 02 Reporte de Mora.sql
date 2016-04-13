SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, c.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_client AS c ON c.id = l.client_id
WHERE laa.overdue_since_date_derived <= DATE('${endDate}') AND l.loan_status_id = 300 AND o.id = 2
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 1 And 30
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, g.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_group AS g ON g.id = l.group_id
WHERE     laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 2
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 1 And 30
UNION
SELECT "$$$$$$$$" AS 'No Prestamo',     "$$$$$$$$$$$$$$$" AS AREA, "$$$$$$$$$$$$$$$$$$$$--MORA POTRERILLOS DE 1-30 DIAS --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(laa.principal_overdue_derived) AS 'Capital Atrasado', SUM(laa.total_overdue_derived) AS 'Total Atrasado', "$$$$$$$$$$" AS 'Dias Atrasados'

FROM    m_loan_arrears_aging AS laa
        INNER JOIN     m_loan AS l ON l.id = laa.loan_id
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 2
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 1 And 30
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, c.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_client AS c ON c.id = l.client_id
WHERE laa.overdue_since_date_derived <= DATE('${endDate}') AND l.loan_status_id = 300 AND o.id = 2
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 31 And 120
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, g.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_group AS g ON g.id = l.group_id
WHERE     laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 2
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 31 And 120
UNION
SELECT "$$$$$$$$" AS 'No Prestamo',     "$$$$$$$$$$$$$$$" AS AREA, "$$$$$$$$$$$$$$$$$$$$--MORA POTRERILLOS DE 31-120 DIAS --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(laa.principal_overdue_derived) AS 'Capital Atrasado', SUM(laa.total_overdue_derived) AS 'Total Atrasado', "$$$$$$$$$$" AS 'Dias Atrasados'

FROM    m_loan_arrears_aging AS laa
        INNER JOIN     m_loan AS l ON l.id = laa.loan_id
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 2
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 31 And 120
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, c.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_client AS c ON c.id = l.client_id
WHERE laa.overdue_since_date_derived <= DATE('${endDate}') AND l.loan_status_id = 300 AND o.id = 2
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 120
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, g.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_group AS g ON g.id = l.group_id
WHERE     laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 2
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 120
UNION
SELECT "$$$$$$$$" AS 'No Prestamo',     "$$$$$$$$$$$$$$$" AS AREA, "$$$$$$$$$$$$$$$$$$$$--MORA POTRERILLOS DE MAS DE 120 DIAS --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(laa.principal_overdue_derived) AS 'Capital Atrasado', SUM(laa.total_overdue_derived) AS 'Total Atrasado', "$$$$$$$$$$" AS 'Dias Atrasados'

FROM    m_loan_arrears_aging AS laa
        INNER JOIN     m_loan AS l ON l.id = laa.loan_id
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 2
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 120
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, c.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_client AS c ON c.id = l.client_id
WHERE laa.overdue_since_date_derived <= DATE('${endDate}') AND l.loan_status_id = 300 AND o.id = 2
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 30
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, g.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_group AS g ON g.id = l.group_id
WHERE     laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 2
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 30
UNION
SELECT "$$$$$$$$" AS 'No Prestamo',     "$$$$$$$$$$$$$$$" AS AREA, "$$$$$$$$$$$$$$$$$$$$--MORA POTRERILLOS DE MAS DE 30 DIAS --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(laa.principal_overdue_derived) AS 'Capital Atrasado', SUM(laa.total_overdue_derived) AS 'Total Atrasado', "$$$$$$$$$$" AS 'Dias Atrasados'

FROM    m_loan_arrears_aging AS laa
        INNER JOIN     m_loan AS l ON l.id = laa.loan_id
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 2
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 30
UNION
SELECT "$$$$$$$$" AS 'No Prestamo',     "$$$$$$$$$$$$$$$" AS AREA, "$$$$$$$$$$$$$$$$$$$$--TOTAL CARTERA ACTIVA POTRERILLOS --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(l.principal_outstanding_derived) AS 'Capital Atrasado', 0 AS 'Total Atrasado', "$$$$$$$$$$" AS 'Dias Atrasados'

FROM    m_loan  AS l
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    l.loan_status_id = 300         AND o.id = 2


UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, c.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_client AS c ON c.id = l.client_id
WHERE laa.overdue_since_date_derived <= DATE('${endDate}') AND l.loan_status_id = 300 AND o.id = 3
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 1 And 30
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, g.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_group AS g ON g.id = l.group_id
WHERE     laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 3
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 1 And 30
UNION
SELECT "$$$$$$$$" AS 'No Prestamo',     "$$$$$$$$$$$$$$$" AS AREA, "$$$$$$$$$$$$$$$$$$$$--MORA RIO LINDO DE 1-30 DIAS --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(laa.principal_overdue_derived) AS 'Capital Atrasado', SUM(laa.total_overdue_derived) AS 'Total Atrasado', "$$$$$$$$$$" AS 'Dias Atrasados'

FROM    m_loan_arrears_aging AS laa
        INNER JOIN     m_loan AS l ON l.id = laa.loan_id
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 3
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 1 And 30
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, c.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_client AS c ON c.id = l.client_id
WHERE laa.overdue_since_date_derived <= DATE('${endDate}') AND l.loan_status_id = 300 AND o.id = 3
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 31 And 120
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, g.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_group AS g ON g.id = l.group_id
WHERE     laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 3
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 31 And 120
UNION
SELECT "$$$$$$$$" AS 'No Prestamo',     "$$$$$$$$$$$$$$$" AS AREA, "$$$$$$$$$$$$$$$$$$$$--MORA RIO LINDO DE 31-120 DIAS --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(laa.principal_overdue_derived) AS 'Capital Atrasado', SUM(laa.total_overdue_derived) AS 'Total Atrasado', "$$$$$$$$$$" AS 'Dias Atrasados'

FROM    m_loan_arrears_aging AS laa
        INNER JOIN     m_loan AS l ON l.id = laa.loan_id
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 3
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 31 And 120
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, c.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_client AS c ON c.id = l.client_id
WHERE laa.overdue_since_date_derived <= DATE('${endDate}') AND l.loan_status_id = 300 AND o.id = 3
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 120
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, g.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_group AS g ON g.id = l.group_id
WHERE     laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 3
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 120
UNION
SELECT "$$$$$$$$" AS 'No Prestamo',     "$$$$$$$$$$$$$$$" AS AREA, "$$$$$$$$$$$$$$$$$$$$--MORA RIO LINDO DE MAS DE 120 DIAS --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(laa.principal_overdue_derived) AS 'Capital Atrasado', SUM(laa.total_overdue_derived) AS 'Total Atrasado', "$$$$$$$$$$" AS 'Dias Atrasados'

FROM    m_loan_arrears_aging AS laa
        INNER JOIN     m_loan AS l ON l.id = laa.loan_id
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 3
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 120
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, c.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_client AS c ON c.id = l.client_id
WHERE laa.overdue_since_date_derived <= DATE('${endDate}') AND l.loan_status_id = 300 AND o.id = 3
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 30
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, g.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_group AS g ON g.id = l.group_id
WHERE     laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 3
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 30
UNION
SELECT "$$$$$$$$" AS 'No Prestamo',     "$$$$$$$$$$$$$$$" AS AREA, "$$$$$$$$$$$$$$$$$$$$--MORA RIO LINDO DE MAS DE 30 DIAS --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(laa.principal_overdue_derived) AS 'Capital Atrasado', SUM(laa.total_overdue_derived) AS 'Total Atrasado', "$$$$$$$$$$" AS 'Dias Atrasados'

FROM    m_loan_arrears_aging AS laa
        INNER JOIN     m_loan AS l ON l.id = laa.loan_id
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 3
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 30
UNION
SELECT "$$$$$$$$" AS 'No Prestamo',     "$$$$$$$$$$$$$$$" AS AREA, "$$$$$$$$$$$$$$$$$$$$--TOTAL CARTERA ACTIVA RIO LINDO --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(l.principal_outstanding_derived) AS 'Capital Atrasado', 0 AS 'Total Atrasado', "$$$$$$$$$$" AS 'Dias Atrasados'

FROM    m_loan  AS l
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    l.loan_status_id = 300         AND o.id = 3



UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, c.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_client AS c ON c.id = l.client_id
WHERE laa.overdue_since_date_derived <= DATE('${endDate}') AND l.loan_status_id = 300 AND o.id = 4
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 1 And 30
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, g.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_group AS g ON g.id = l.group_id
WHERE     laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 4
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 1 And 30
UNION
SELECT "$$$$$$$$" AS 'No Prestamo',     "$$$$$$$$$$$$$$$" AS AREA, "$$$$$$$$$$$$$$$$$$$$--MORA SAN PEDRO SULA DE 1-30 DIAS --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(laa.principal_overdue_derived) AS 'Capital Atrasado', SUM(laa.total_overdue_derived) AS 'Total Atrasado', "$$$$$$$$$$" AS 'Dias Atrasados'

FROM    m_loan_arrears_aging AS laa
        INNER JOIN     m_loan AS l ON l.id = laa.loan_id
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 4
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 1 And 30
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, c.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_client AS c ON c.id = l.client_id
WHERE laa.overdue_since_date_derived <= DATE('${endDate}') AND l.loan_status_id = 300 AND o.id = 4
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 31 And 120
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, g.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_group AS g ON g.id = l.group_id
WHERE     laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 4
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 31 And 120
UNION
SELECT "$$$$$$$$" AS 'No Prestamo',     "$$$$$$$$$$$$$$$" AS AREA, "$$$$$$$$$$$$$$$$$$$$--MORA SAN PEDRO SULA DE 31-120 DIAS --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(laa.principal_overdue_derived) AS 'Capital Atrasado', SUM(laa.total_overdue_derived) AS 'Total Atrasado', "$$$$$$$$$$" AS 'Dias Atrasados'

FROM    m_loan_arrears_aging AS laa
        INNER JOIN     m_loan AS l ON l.id = laa.loan_id
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 4
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 31 And 120
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, c.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_client AS c ON c.id = l.client_id
WHERE laa.overdue_since_date_derived <= DATE('${endDate}') AND l.loan_status_id = 300 AND o.id = 4
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 120
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, g.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_group AS g ON g.id = l.group_id
WHERE     laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 4
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 120
UNION
SELECT "$$$$$$$$" AS 'No Prestamo',     "$$$$$$$$$$$$$$$" AS AREA, "$$$$$$$$$$$$$$$$$$$$--MORA SAN PEDRO SULA DE MAS DE 120 DIAS --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(laa.principal_overdue_derived) AS 'Capital Atrasado', SUM(laa.total_overdue_derived) AS 'Total Atrasado', "$$$$$$$$$$" AS 'Dias Atrasados'

FROM    m_loan_arrears_aging AS laa
        INNER JOIN     m_loan AS l ON l.id = laa.loan_id
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 4
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 120
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, c.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_client AS c ON c.id = l.client_id
WHERE laa.overdue_since_date_derived <= DATE('${endDate}') AND l.loan_status_id = 300 AND o.id = 4
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 30
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, g.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_group AS g ON g.id = l.group_id
WHERE     laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 4
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 30
UNION
SELECT "$$$$$$$$" AS 'No Prestamo',     "$$$$$$$$$$$$$$$" AS AREA, "$$$$$$$$$$$$$$$$$$$$--MORA SAN PEDRO SULA DE MAS DE 30 DIAS --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(laa.principal_overdue_derived) AS 'Capital Atrasado', SUM(laa.total_overdue_derived) AS 'Total Atrasado', "$$$$$$$$$$" AS 'Dias Atrasados'

FROM    m_loan_arrears_aging AS laa
        INNER JOIN     m_loan AS l ON l.id = laa.loan_id
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 4
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 30
UNION
SELECT "$$$$$$$$" AS 'No Prestamo',     "$$$$$$$$$$$$$$$" AS AREA, "$$$$$$$$$$$$$$$$$$$$--TOTAL CARTERA ACTIVA SAN PEDRO SULA --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(l.principal_outstanding_derived) AS 'Capital Atrasado', 0 AS 'Total Atrasado', "$$$$$$$$$$" AS 'Dias Atrasados'

FROM    m_loan  AS l
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    l.loan_status_id = 300         AND o.id = 4




UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, c.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_client AS c ON c.id = l.client_id
WHERE laa.overdue_since_date_derived <= DATE('${endDate}') AND l.loan_status_id = 300 AND o.id = 6
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 1 And 30
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, g.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_group AS g ON g.id = l.group_id
WHERE     laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 6
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 1 And 30
UNION
SELECT "$$$$$$$$" AS 'No Prestamo',     "$$$$$$$$$$$$$$$" AS AREA, "$$$$$$$$$$$$$$$$$$$$--MORA SAN MANUEL DE 1-30 DIAS --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(laa.principal_overdue_derived) AS 'Capital Atrasado', SUM(laa.total_overdue_derived) AS 'Total Atrasado', "$$$$$$$$$$" AS 'Dias Atrasados'

FROM    m_loan_arrears_aging AS laa
        INNER JOIN     m_loan AS l ON l.id = laa.loan_id
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 6
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 1 And 30
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, c.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_client AS c ON c.id = l.client_id
WHERE laa.overdue_since_date_derived <= DATE('${endDate}') AND l.loan_status_id = 300 AND o.id = 6
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 31 And 120
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, g.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_group AS g ON g.id = l.group_id
WHERE     laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 6
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 31 And 120
UNION
SELECT "$$$$$$$$" AS 'No Prestamo',     "$$$$$$$$$$$$$$$" AS AREA, "$$$$$$$$$$$$$$$$$$$$--MORA SAN MANUEL DE 31-120 DIAS --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(laa.principal_overdue_derived) AS 'Capital Atrasado', SUM(laa.total_overdue_derived) AS 'Total Atrasado', "$$$$$$$$$$" AS 'Dias Atrasados'

FROM    m_loan_arrears_aging AS laa
        INNER JOIN     m_loan AS l ON l.id = laa.loan_id
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 6
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 31 And 120
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, c.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_client AS c ON c.id = l.client_id
WHERE laa.overdue_since_date_derived <= DATE('${endDate}') AND l.loan_status_id = 300 AND o.id = 6
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 120
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, g.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_group AS g ON g.id = l.group_id
WHERE     laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 6
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 120
UNION
SELECT "$$$$$$$$" AS 'No Prestamo',     "$$$$$$$$$$$$$$$" AS AREA, "$$$$$$$$$$$$$$$$$$$$--MORA SAN MANUEL DE MAS DE 120 DIAS --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(laa.principal_overdue_derived) AS 'Capital Atrasado', SUM(laa.total_overdue_derived) AS 'Total Atrasado', "$$$$$$$$$$" AS 'Dias Atrasados'

FROM    m_loan_arrears_aging AS laa
        INNER JOIN     m_loan AS l ON l.id = laa.loan_id
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 6
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 120
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, c.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_client AS c ON c.id = l.client_id
WHERE laa.overdue_since_date_derived <= DATE('${endDate}') AND l.loan_status_id = 300 AND o.id = 6
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 30
UNION
SELECT laa.loan_id AS 'No Prestamo', o.name AS AREA, g.display_name AS NOMBRE, laa.overdue_since_date_derived AS 'Atrasado desde',
    laa.principal_overdue_derived AS 'Capital Atrasado', laa.total_overdue_derived AS 'Total Atrasado', DATEDIFF(DATE('${endDate}'),
    laa.overdue_since_date_derived) AS 'Dias Atrasados'
FROM m_loan_arrears_aging AS laa
        INNER JOIN m_loan AS l ON l.id = laa.loan_id
        INNER JOIN m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN m_office AS o ON o.id = s.office_id
        INNER JOIN m_group AS g ON g.id = l.group_id
WHERE     laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 6
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 30
UNION
SELECT "$$$$$$$$" AS 'No Prestamo',     "$$$$$$$$$$$$$$$" AS AREA, "$$$$$$$$$$$$$$$$$$$$--MORA SAN MANUEL DE MAS DE 30 DIAS --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(laa.principal_overdue_derived) AS 'Capital Atrasado', SUM(laa.total_overdue_derived) AS 'Total Atrasado', "$$$$$$$$$$" AS 'Dias Atrasados'

FROM    m_loan_arrears_aging AS laa
        INNER JOIN     m_loan AS l ON l.id = laa.loan_id
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.id = 6
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 30
UNION
SELECT "$$$$$$$$" AS 'No Prestamo',     "$$$$$$$$$$$$$$$" AS AREA, "$$$$$$$$$$$$$$$$$$$$--TOTAL CARTERA ACTIVA SAN MANUEL --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(l.principal_outstanding_derived) AS 'Capital Atrasado', 0 AS 'Total Atrasado', "$$$$$$$$$$" AS 'Dias Atrasados'

FROM    m_loan  AS l
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    l.loan_status_id = 300         AND o.id = 6


UNION 
SELECT "==========" AS 'No Prestamo',     "===============" AS AREA, "==================================================" AS NOMBRE, "==========" AS 'Atrasado desde', 0 AS 'Capital Atrasado', 0 AS 'Total Atrasado', "=============" AS 'Dias Atrasados'

FROM    m_loan  AS l


UNION
SELECT "==========" AS 'No Prestamo',     "===============" AS AREA, "=================MORA HONDURAS DE 1-30 DIAS --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(laa.principal_overdue_derived) AS 'Capital Atrasado', SUM(laa.total_overdue_derived) AS 'Total Atrasado', "=============" AS 'Dias Atrasados'

FROM    m_loan_arrears_aging AS laa
        INNER JOIN     m_loan AS l ON l.id = laa.loan_id
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.parent_id = 8
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 1 AND 30

UNION
SELECT "==========" AS 'No Prestamo',     "===============" AS AREA, "=================MORA HONDURAS MAS DE 31-120 DIAS --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(laa.principal_overdue_derived) AS 'Capital Atrasado', SUM(laa.total_overdue_derived) AS 'Total Atrasado', "=============" AS 'Dias Atrasados'

FROM    m_loan_arrears_aging AS laa
        INNER JOIN     m_loan AS l ON l.id = laa.loan_id
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.parent_id = 8
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) BETWEEN 31 AND 120

UNION
SELECT "==========" AS 'No Prestamo',     "===============" AS AREA, "=================MORA HONDURAS MAS DE 120 DIAS --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(laa.principal_overdue_derived) AS 'Capital Atrasado', SUM(laa.total_overdue_derived) AS 'Total Atrasado', "=============" AS 'Dias Atrasados'

FROM    m_loan_arrears_aging AS laa
        INNER JOIN     m_loan AS l ON l.id = laa.loan_id
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.parent_id = 8
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 120

UNION
SELECT "==========" AS 'No Prestamo',     "===============" AS AREA, "=================MORA HONDURAS MAS DE 30 DIAS --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(laa.principal_overdue_derived) AS 'Capital Atrasado', SUM(laa.total_overdue_derived) AS 'Total Atrasado', "=============" AS 'Dias Atrasados'

FROM    m_loan_arrears_aging AS laa
        INNER JOIN     m_loan AS l ON l.id = laa.loan_id
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    laa.overdue_since_date_derived <= DATE('${endDate}')         AND l.loan_status_id = 300         AND o.parent_id = 8
AND DATEDIFF(DATE('${endDate}'),laa.overdue_since_date_derived) > 30

UNION
SELECT "==========" AS 'No Prestamo',     "===============" AS AREA, "=================CARTERA ACTIVA HONDURAS --" AS NOMBRE, COUNT(l.id) AS 'Atrasado desde',
    SUM(l.principal_outstanding_derived) AS 'Capital Atrasado', 0 AS 'Total Atrasado', "=============" AS 'Dias Atrasados'

FROM    m_loan  AS l
        INNER JOIN    m_staff AS s ON s.id = l.loan_officer_id
        INNER JOIN    m_office AS o ON o.id = s.office_id
        WHERE    l.loan_status_id = 300         AND o.parent_id=8
