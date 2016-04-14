SELECT "" as 'ID', NULL as 'External ID',  NULL AS Estado, "TOTALES" as 'Mentor', NULL AS Area, ""  as Nombre, "" as Integrantes, NULL AS 'Fecha de Desembolso', 
NULL AS 'Cuotas', SUM(m_loan.approved_principal) AS 'Monto Aprobado',  SUM(m_loan.principal_outstanding_derived) AS 'Capital Pendiente',
SUM(m_loan.interest_outstanding_derived) AS 'Interes Pendiente',   SUM(m_loan.total_outstanding_derived) AS 'Total Pendiente', 
NULL AS 'Fecha de Vencimiento' , NULL AS 'Fecha que cerro'
 FROM m_loan
INNER JOIN m_staff ON m_loan.loan_officer_id=m_staff.id
INNER JOIN m_office as o ON  m_staff.office_id=o.id
WHERE o.parent_id=8 AND  m_loan.disbursedon_date<=date('${endDate}') and m_loan.loan_status_id=300
UNION
SELECT "" as 'ID', NULL as 'External ID',  NULL AS Estado, "Miembros en grupos" as 'Mentor', NULL AS Area, " "  as Nombre, count(gc.group_id) as Integrantes, NULL AS 'Fecha de Desembolso', NULL AS 'Cuotas', null AS 'Monto Aprobado',  null AS 'Capital Pendiente', null AS 'Interes Pendiente',   null  AS 'Total Pendiente', 
NULL AS 'Fecha de Vencimiento' , NULL AS 'Fecha que cerro'
 FROM m_loan
INNER JOIN m_staff ON m_loan.loan_officer_id=m_staff.id
INNER JOIN m_office as o ON  m_staff.office_id=o.id
INNER JOIN m_group as g ON g.id=m_loan.group_id
INNER JOIN m_group_client as gc ON m_loan.group_id = gc.group_id
WHERE o.parent_id=8 AND  m_loan.disbursedon_date<=date('${endDate}') and m_loan.loan_status_id=300

UNION
SELECT "" as 'ID', NULL as 'External ID',  NULL AS Estado, "Clientes Individuales" as 'Mentor', NULL AS Area, ""  as Nombre, count(c.id) as Integrantes, NULL AS 'Fecha de Desembolso', NULL AS 'Cuotas', null  AS 'Monto Aprobado',  null  AS 'Capital Pendiente', null AS 'Interes Pendiente',  null AS 'Total Pendiente', 
NULL AS 'Fecha de Vencimiento' , NULL AS 'Fecha que cerro'
 FROM m_loan
INNER JOIN m_staff ON m_loan.loan_officer_id=m_staff.id
INNER JOIN m_office as o ON  m_staff.office_id=o.id
INNER JOIN m_client as c ON c.id=m_loan.client_id
WHERE o.parent_id=8 AND  m_loan.disbursedon_date<=date('${endDate}') and m_loan.loan_status_id=300

UNION

SELECT  m_loan.account_no as 'ID', m_loan.external_id as 'External ID',  m_loan.loan_status_id AS Estado, m_staff.display_name as 'Mentor',
o.name AS Area, c.display_name  as Nombre,  1 AS Integrantes, m_loan.disbursedon_date AS 'Fecha de Desembolso',  m_loan.number_of_repayments AS 'Cuotas',
m_loan.approved_principal AS 'Monto Aprobado', m_loan.principal_outstanding_derived AS 'Capital Pendiente', m_loan.interest_outstanding_derived AS 'Interes Pendiente',  m_loan.total_outstanding_derived AS 'Total Pendiente',  m_loan.maturedon_date AS 'Fecha de Vencimiento' , m_loan.closedon_date AS 'Fecha que cerro'
 FROM m_loan 
INNER JOIN m_staff ON m_loan.loan_officer_id=m_staff.id
INNER JOIN m_client as c ON c.id=m_loan.client_id
INNER JOIN m_office as o ON  m_staff.office_id=o.id
WHERE o.parent_id=8 AND  m_loan.disbursedon_date<=date('${endDate}') and m_loan.loan_status_id=300

UNION
SELECT  m_loan.account_no as 'ID', m_loan.external_id as 'External ID',  m_loan.loan_status_id AS Estado, m_staff.display_name as 'Mentor', o.name AS Area,
g.display_name  as Nombre,  count(*) AS Integrantes, m_loan.disbursedon_date AS 'Fecha de Desembolso',  m_loan.number_of_repayments AS 'Cuotas',
m_loan.approved_principal AS 'Monto Aprobado',  m_loan.principal_outstanding_derived AS 'Capital Pendiente', m_loan.interest_outstanding_derived AS 'Interes Pendiente',   m_loan.total_outstanding_derived AS 'Total Pendiente',  m_loan.maturedon_date AS 'Fecha de Vencimiento' , m_loan.closedon_date AS 'Fecha que cerro'
 FROM m_group_client as gc
INNER JOIN m_loan ON m_loan.group_id = gc.group_id
INNER JOIN m_staff ON m_loan.loan_officer_id=m_staff.id
INNER JOIN m_group as g ON g.id=m_loan.group_id
INNER JOIN m_office as o ON  m_staff.office_id=o.id
WHERE o.parent_id=8 AND  m_loan.disbursedon_date<=date('${endDate}') and m_loan.loan_status_id=300
group by gc.group_id
