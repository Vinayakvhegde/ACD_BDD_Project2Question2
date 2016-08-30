REGISTER /home/acadgild/Downloads/piggybank-0.11.0.jar ;
DEFINE CSVExcelStorage org.apache.pig.piggybank.storage.CSVExcelStorage ;

Cust_data = LOAD '/flume_sink/FlumeData.1469777750126' USING  CSVExcelStorage AS (Date_Recieved : chararray , Product : chararray, SubProduct :chararray, Issue :chararray , SubIssue : chararray, Narrative : chararray , Public_Response : chararray,  Company : chararray , State_Cust :Chararray, ZIPcode : chararray ,Submitted_Via : chararray, Date_Sent : chararray, Company_Response :chararray , Timely_Response : chararray , Consumer_Disputed:Chararray , Complaint_Id :chararray ) ;

Filtered_Data = FILTER Cust_data BY ((Date_Recieved IS NOT null) AND (Product IS NOT null) AND (SubProduct IS NOT null) AND (Issue IS NOT null) AND (SubIssue IS NOT null) AND (Narrative IS NOT null) AND (Company IS NOT null) AND (Public_Response IS NOT null))  ;
Selected_Data = FOREACH Filtered_Data GENERATE Company, Complaint_Id ;
Grouped_Data = GROUP Selected_Data BY Company ;
Complaint_Chart = FOREACH Grouped_Data GENERATE group,COUNT(Selected_Data.Complaint_Id) AS TotalCount;
Complaint_Chart_Ordered = ORDER Complaint_Chart BY TotalCount DESC ;

STORE Complaint_Chart_Ordered INTO 'prj2/AnswerQ2P3' ;
