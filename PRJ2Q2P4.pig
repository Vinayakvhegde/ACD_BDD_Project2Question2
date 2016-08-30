REGISTER /home/acadgild/Downloads/piggybank-0.11.0.jar ;
DEFINE CSVExcelStorage org.apache.pig.piggybank.storage.CSVExcelStorage ;

Cust_data = LOAD '/flume_sink/FlumeData.1469777750126' USING  CSVExcelStorage AS (Date_Recieved : chararray , Product : chararray, SubProduct :chararray, Issue :chararray , SubIssue : chararray, Narrative : chararray , Public_Response : chararray,  Company : chararray , State_Cust :Chararray, ZIPcode : chararray ,Submitted_Via : chararray, Date_Sent : chararray, Company_Response :chararray , Timely_Response : chararray , Consumer_Disputed:Chararray , Complaint_Id :chararray ) ;

Filtered_Data = FILTER Cust_data BY ((Date_Recieved IS NOT null) AND (Product IS NOT null) AND ((int)SUBSTRING(Date_Recieved, 6, 10) == 2015) AND (Product == 'Debt collection')) ;
Selected_Data = FOREACH Filtered_Data GENERATE (int)SUBSTRING(Date_Recieved, 6, 10) as Year,  Product ;
Grouped_Data = GROUP Selected_Data BY Year ;
Num_Of_Complaints = FOREACH Grouped_Data GENERATE group,COUNT(Selected_Data.Product) AS TotalCount;

STORE Num_Of_Complaints INTO 'prj2/AnswerQ2P4' ;

