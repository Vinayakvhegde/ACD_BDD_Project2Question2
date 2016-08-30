REGISTER /home/acadgild/Downloads/piggybank-0.11.0.jar ;
DEFINE CSVLoader org.apache.pig.piggybank.storage.CSVLoader();

Cust_data = LOAD '/flume_sink/FlumeData.1469777750126' USING  CSVLoader AS (Date_Recieved : chararray , Product : chararray, SubProduct :chararray, Issue :chararray , SubIssue : chararray, Narrative : chararray , Public_Response : chararray,  Company : chararray , State_Cust :Chararray, ZIPcode : chararray ,Submitted_Via : chararray, Date_Sent : chararray, Company_Response :chararray , Timely_Response : chararray , Consumer_Disputed:Chararray , Complaint_Id :chararray ) ;

Selected_Data = FOREACH Cust_data GENERATE Complaint_Id, Timely_Response  ;
Filtered_Data = FILTER Selected_Data BY (Timely_Response =='Yes')  ;
Grouped_Data  = GROUP Filtered_Data BY Timely_Response ;
Num_Of_TimelyResponses = FOREACH Grouped_Data GENERATE COUNT(Filtered_Data.Complaint_Id) ;

STORE Num_Of_TimelyResponses INTO 'prj2/AnswerQ2P1' ;
