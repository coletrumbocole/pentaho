select
tot.branch as "Branch"
#	as "Last Month (prev.)"
#	as "This Month (prev.)"
#	as "Difference (prev.)"
#	, as "Last Month (current)" # How can get whatever "This Month (current)" would have returned last month? I can't.
	,(tot.weighted_a8 + tot.weighted_a31 + tot.weighted_a61 + tot.weighted_a91 + tot.weighted_a120) as "This Month (current)" # this is the total (by branch) of arrears8-30 * .1, arrears31-60 * .25, etc. It's like the AgingOfAccts.sql. 
#	,(this month) - (last month) as "Difference (current)"

	from 
    (
		select 
        o.`name` as branch
		,(sum(if(datediff(curdate(), laa.overdue_since_date_derived) between 8 and 30, laa.principal_overdue_derived, 0)) * .1) as weighted_a8
		,(sum(if(datediff(curdate(), laa.overdue_since_date_derived) between 31 and 60, laa.principal_overdue_derived, 0)) * .25) as weighted_a31
		,(sum(if(datediff(curdate(), laa.overdue_since_date_derived) between 61 and 90, laa.principal_overdue_derived, 0)) * .5) as weighted_a61
		,(sum( if(datediff(curdate(), laa.overdue_since_date_derived) between 91 and 120, laa.principal_overdue_derived, 0) ) * .75) as weighted_a91
		,sum( if(datediff(curdate(), laa.overdue_since_date_derived) > 120, laa.principal_overdue_derived, 0) ) as weighted_a120

		from m_loan as l
		left join m_client as c
			on c.id = l.client_id # so that I have no duplication of loans. *All loans have a client, some have same client.

		left join m_office as o 
			on o.id = c.office_id # All clients have office_id. So now each loan has an office_id.
			
		left join m_loan_arrears_aging as laa
			on l.id = laa.loan_id # not all loans have match an laa.
		
        group by o.`name`
	) as tot  # totals

;