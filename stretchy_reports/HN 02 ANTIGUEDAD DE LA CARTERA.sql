select

o.name as "AREA"

,count(if(l.disbursedon_date<= date ('${endDate}'), l.id, NULL)) as "Prestamos Activos"
,sum(if(l.disbursedon_date<= date('${endDate}'),l.principal_disbursed_derived, 0)) as "Monto Total"
,sum(if(l.disbursedon_date<= date('${endDate}'), l.principal_outstanding_derived,0)) as "Balance"

,count(if(laa.overdue_since_date_derived <= date ('${endDate}') AND laa.principal_overdue_derived>0, laa.loan_id,NULL) ) as "No (Atrasos)"
,sum( if(laa.loan_id is not NULL AND laa.overdue_since_date_derived <= date ('${endDate}'), l.principal_outstanding_derived, 0) ) as "PAR Monto"
,sum(if(laa.overdue_since_date_derived <= date ('${endDate}'), laa.principal_overdue_derived, 0 )) as "Monto Atrasado"

,count(if(datediff(date('${endDate}'), laa.overdue_since_date_derived) between 1 and 30, l.id, NULL)) as "No (1-30)"
,sum( if(datediff(date('${endDate}'), laa.overdue_since_date_derived) between 1 and 30, laa.principal_overdue_derived, 0) ) as "Atrasado (1-30)"
,sum( if(datediff(date('${endDate}'), laa.overdue_since_date_derived) between 1 and 30, l.principal_outstanding_derived, 0) ) as "PAR Monto (1-30)"

,count( if(datediff(date('${endDate}'), laa.overdue_since_date_derived) between 31 and 120, l.id, NULL) ) as "No (31-120)"
,sum( if(datediff(date('${endDate}'), laa.overdue_since_date_derived) between 31 and 120, laa.principal_overdue_derived, 0) ) as "Atrasos (31-120)"
,sum( if(datediff(date('${endDate}'), laa.overdue_since_date_derived) between 31 and 120, l.principal_outstanding_derived, 0) ) as "PAR Monto (31-120)"

,count( if(datediff(date('${endDate}'), laa.overdue_since_date_derived) > 120, l.id, NULL) ) as "No (>120)"
,sum( if(datediff(date('${endDate}'), laa.overdue_since_date_derived) > 120, laa.principal_overdue_derived, 0) ) as "Atrasos (>120)"
,sum( if(datediff(date('${endDate}'), laa.overdue_since_date_derived) > 120, l.principal_outstanding_derived, 0) ) as "PAR Monto (>120)"

,count(IF(laa.overdue_since_date_derived <= date('${endDate}'), if(datediff(date('${endDate}'), laa.overdue_since_date_derived) > 30, l.id, NULL) ,NULL) )as "No (+30)Total"
,sum( if(datediff(date('${endDate}'), laa.overdue_since_date_derived) > 30, laa.principal_overdue_derived, 0) ) as "Atrasos (+30) total"
,sum( if(datediff(date('${endDate}'), laa.overdue_since_date_derived) > 30, l.principal_outstanding_derived, 0) ) as "PAR (+30)"
from m_loan as l

left join m_staff as s
	on s.id = l.loan_officer_id 

left join m_office as o 
	on o.id = s.office_id 
    
left join m_loan_arrears_aging as laa
	on l.id = laa.loan_id 


WHERE 

l.loan_status_id=300
AND
(o.parent_id=8)


group by o.name

union

(
	select

	'TOTAL' as "AREA"
	,count(IF(l.disbursedon_date<= ('${endDate}'),l.id,0)) as "Prestamos Activos"
	,sum(IF(l.disbursedon_date<= ('${endDate}'),l.principal_disbursed_derived,0)) as "MONTO"
	,sum(IF(l.disbursedon_date<= ('${endDate}'),l.principal_outstanding_derived,0)) as "Balance"

	,NULL as "No" 
	,NULL as "PAR Amt" 
	,NULL as "Arrears"
	,count(if(datediff(date('${endDate}'), laa.overdue_since_date_derived) between 1 and 30, l.id, NULL)) as "No (1-30)"
	,sum( if(datediff(date('${endDate}'), laa.overdue_since_date_derived) between 1 and 30, laa.principal_overdue_derived, 0) ) as "Arrears (1-30)"
	,sum( if(datediff(date('${endDate}'), laa.overdue_since_date_derived) between 1 and 30, l.principal_outstanding_derived, 0) ) as "PAR Amt (1-30)"


	,count( if(datediff(date('${endDate}'), laa.overdue_since_date_derived) between 31 and 120, l.id, NULL) ) as "No (8-30)"
	,sum( if(datediff(date('${endDate}'), laa.overdue_since_date_derived) between 31 and 120, laa.principal_overdue_derived, 0) ) as "Arrears (31-120)"
	,sum( if(datediff(date('${endDate}'), laa.overdue_since_date_derived) between 31 and 120, l.principal_outstanding_derived, 0) ) as "PAR Amt (31-120)"





	,count( if(datediff(date('${endDate}'), laa.overdue_since_date_derived) > 120, l.id, NULL) ) as "No (>120)"
	,sum( if(datediff(date('${endDate}'), laa.overdue_since_date_derived) > 120, laa.principal_overdue_derived, 0) ) as "Arrears (>120)"
	,sum( if(datediff(date('${endDate}'), laa.overdue_since_date_derived) > 120, l.principal_outstanding_derived, 0) ) as "PAR Amt (>120)"

	,count( if(datediff(date('${endDate}'), laa.overdue_since_date_derived) > 30, l.id, NULL) ) as "No total" 
	,sum( if(datediff(date('${endDate}'), laa.overdue_since_date_derived) > 30, laa.principal_overdue_derived, 0) ) as "ARREARS total"
	,sum( if(datediff(date('${endDate}'), laa.overdue_since_date_derived) > 30, l.principal_outstanding_derived, 0) ) as "PAR"

	from m_loan as l 
	left join m_staff as s
	on s.id = l.loan_officer_id 

left join m_office as o 
	on o.id = s.office_id 
		
	left join m_loan_arrears_aging as laa
		on l.id = laa.loan_id 

WHERE l.loan_status_id=300
AND
(o.parent_id=8)

)
