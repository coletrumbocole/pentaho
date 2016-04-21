select 
'LOAN' as "LOAN"
,'EVALUATION' as "EVALUATION"
,'SHEET' as "SHEET"
,'' as col4
,'' as col5
,'' as col6
,'' as col7

UNION ALL
(
select
'Loan' as "LOAN"
,'Applicaiton' as "EVALUATION"
,'' as "SHEET"
,'' as col4
,'' as col5
,'' as col6
,'' as col7
)

UNION ALL
(
select
'Existing' as "LOAN"
,'Loan' as "EVALUATION"
,'' as "SHEET"
,'' as col4
,'' as col5
,'' as col6
,'' as col7
)

UNION ALL
(
select
'Client Name:' as "LOAN"
,'' as "EVALUATION"
,'' as "SHEET"
,'' as col4
,'' as col5
,'PS Balance:' as col6
,'' as col7
)

UNION ALL
(
select
'Branch:' as "LOAN"
,'' as "EVALUATION"
,'' as "SHEET"
,'' as col4
,'' as col5
,'GL Cycle:' as col6
,'' as col7
)

UNION ALL
(
select
'Mentor:' as "LOAN"
,'' as "EVALUATION"
,'' as "SHEET"
,'' as col4
,'' as col5
,'GF Wkly State:' as col6
,'' as col7
)

UNION ALL
(
select
'Center:' as "LOAN"
,'' as "EVALUATION"
,'' as "SHEET"
,'' as col4
,'' as col5
,'GF Dep 25wks:' as col6
,'' as col7
)

UNION ALL
(
select
'Client ID:' as "LOAN"
,'' as "EVALUATION"
,'' as "SHEET"
,'' as col4
,'' as col5
,'Client Class:' as col6
,'' as col7
)

UNION ALL
(
select
'Renter?:' as "LOAN"
,'' as "EVALUATION"
,'' as "SHEET"
,'' as col4
,'' as col5
,'Business. Class:' as col6
,'' as col7
)

UNION ALL
(
select
'Credit Limit:' as "LOAN"
,'' as "EVALUATION"
,'' as "SHEET"
,'' as col4
,'' as col5
,'Client Arrears:' as col6
,'' as col7
)

UNION ALL
(
select
'CI Date:' as "LOAN"
,'' as "EVALUATION"
,'' as "SHEET"
,'' as col4
,'' as col5
,'Group Arrears:' as col6
,'' as col7
)

UNION ALL
(
select
'CI Conduct by:' as "LOAN"
,'' as "EVALUATION"
,'' as "SHEET"
,'' as col4
,'' as col5
,'Center Arrears:' as col6
,'' as col7
)

UNION ALL
(
select
'' as "LOAN"
,'' as "EVALUATION"
,'' as "SHEET"
,'' as col4
,'' as col5
,'' as col6
,'' as col7
)

UNION ALL
(
select
'PERSONAL' as "LOAN"
,' SAVINGS' as "EVALUATION"
,' HISTORY' as "SHEET"
,' (4 Months)' as col4
,'' as col5
,'' as col6
,'' as col7
)

UNION ALL
(
select
'User' as "LOAN"
,'Date' as "EVALUATION"
,'Type' as "SHEET"
,'Amount' as col4
,'Balance' as col5
,'Reverse' as col6
,'' as col7
)

;