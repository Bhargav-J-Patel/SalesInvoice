////--------------------------------------------------------------------------------------------------------
//// Declare all the NameSpaces to be referenced
////--------------------------------------------------------------------------------------------------------
using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Collections;
using System.Data.Sql ;
using System.Configuration;


////------------------------------------------------------------------------------------------------------------
//// Last Change : Overloade function RunSql oCn.open added.
////                 Confiuration class added to read the connection string from app.config
//// Page Description :	The DataLayer component is an interface between the business services tier and 
//// 			a data source. It can execute stored procedures or Sql statements and it can 
////			    return rowsets, if requested.
////------------------------------------------------------------------------------------------------------------
namespace App_Code{

    public enum ssenumSqlDataTypesRE{ssSDT_Bit,ssSDT_DateTime,ssSDT_Decimal,ssSDT_Integer,ssSDT_Money,ssSDT_String}
    
    //--------------------------------------------------------------------------------------------------------------
    // public Class
    // Purpose:	The SqlService class interacts with a datasource using ADO.Net's 
    //				SqlClient interface.
    //--------------------------------------------------------------------------------------------------------------
    public class SqlInvoice
    {


        //----------------------------------------------------------------------------------------------------
        // Declare Class level variables
        //----------------------------------------------------------------------------------------------------
        
        private String   m_sUsername  = "" ;         //--- The Database login User ID
        private String   m_sPassword = ""  ;        //--- The Database login Password
        private String   m_sServer = ""     ;       //--- The SQL Server instance
        private String   m_sDatabase = ""    ;      //--- The Database name
        private String   m_sConnectionString= "";  //--- The Database connection string
        //--- The array used to store the parameters to a stored procedure
        private ArrayList   m_oParmList= new  ArrayList();

        //----------------------------------------------------------------------------------------------------
        // Class Constructor (zero arguments)
        // Overloaded:	Yes
        //----------------------------------------------------------------------------------------------------

        //public  SqlTransportService()
        //{
        //    string connectionInfo = System.Configuration.ConfigurationManager.AppSettings["SS_TreeLogy"];
        //     m_sConnectionString = connectionInfo;
           
        //}

        //----------------------------------------------------------------------------------------------------
        // Class Constructor (with the entire connection string as the argument)
        // Overloaded:	Yes
        //----------------------------------------------------------------------------------------------------
        //public  SqlTransportService(String sConnectionString)
        //{
        //    m_sConnectionString = sConnectionString;
        //}
            
        //----------------------------------------------------------------------------------------------------
        // Class Constructor (with connection string arguments)
        // Overloaded:	Yes
        //----------------------------------------------------------------------------------------------------
        public void  main(String sServer,String sDatabase,String sUsername,String sPassword){
            Server = sServer;
            Database = sDatabase;
            Username = sUsername;
            Password = sPassword;
        }
            
        

        //----------------------------------------------------------------------------------------------------
        // public R/W Property 
        // Purpose:		Exposes the connection string
        //----------------------------------------------------------------------------------------------------
        
        public string ConnectionString{
            get{ return m_sConnectionString;}
            set{ m_sConnectionString = value;}
        }
        
        //----------------------------------------------------------------------------------------------------
        // public R/W Property 
        // Purpose:		Exposes the User ID 
        //----------------------------------------------------------------------------------------------------
        
        public string Username{
            get{ return m_sUsername;}
            set{ m_sUsername = value;}
        }
        

        //------------------------------------------------------------------------------------------------------------
        // public R/W Property 
        // Purpose:    Exposes the Password
        //------------------------------------------------------------------------------------------------------------
        public string Password{
            get{ return m_sPassword;}
            set{ m_sPassword = value;}
        }
        
        //------------------------------------------------------------------------------------------------------------
        // public R/W Property 
        // Purpose:		Exposes the SQL Server
        //------------------------------------------------------------------------------------------------------------
        public string Server{
            get{ return m_sServer;}
            set{ m_sServer = value;}
        }
        
        //------------------------------------------------------------------------------------------------------------
        // public R/W Property
        // Purpose:		Exposes the Database name
        //------------------------------------------------------------------------------------------------------------
        public string Database{
            get{ return m_sDatabase;}
            set{ m_sDatabase = value;}
        }
        
        //------------------------------------------------------------------------------------------------------------
        // public Method
        // Overloaded:		Yes
        // Return Value:	DataSet
        // Purpose:		Executes a SQL statement.
        //------------------------------------------------------------------------------------------------------------
        public DataSet RunSql(String sSql,String sTableName){

            SqlCommand oCmd = new SqlCommand();              //--- Create a new SqlCommand
            SqlConnection oCn   = null ;                 //--- Declare the SqlConnection
            SqlDataAdapter oDa  = new SqlDataAdapter();      //--- Create a new SqlDataAdapter
            DataSet oDs = new DataSet();                    //--- Create a new DataSet

        //--- Prepare connection to the database
            oCn =  Connect();

            //using oCmd
                //--- Set the CommandText, ActiveConnection and the Command Type 
                //--- for the SqlCommand Object
                oCmd.Connection = oCn;
                oCmd.CommandText = sSql;
                oCmd.CommandTimeout = 0;
                oCmd.CommandType = CommandType.Text;
            //End With

            //With oDa
                //--- Assign the SqlCommand Object to the
                //--- Select command of the SqlDataAdapter and

                oDa.SelectCommand = oCmd;

                //--- Execute the Sql Statement and fill the dataset
               oDa .Fill(oDs, sTableName);
            //End With

            //--- Disconnect from the database
            Disconnect(oCn);

            //--- Return the DataSet
            return oDs;

        }
        
        
        ////------------------------------------------------------------------------------------------------------------
        //// public Method
        //// Overloaded:		Yes
        //// Return Value:	None
        //// Purpose:		Executes a SQL statement and returns nothing.
        ////------------------------------------------------------------------------------------------------------------
        public Int32 RunSql(String sSql){
            
            
            SqlCommand oCmd = new SqlCommand();              //--- Create a new SqlCommand
            SqlConnection oCn   = null ;                 //--- Declare the SqlConnection
            Int32 oRowAffected= 0;                       //---no of row affected by query execution;

            //--- Prepare connection to the database
            oCn = Connect();
            oCn.Open();
            
                //--- Execute the Sql Satement
                oCmd.CommandText = sSql;
                oCmd.Connection = oCn;
                oCmd.CommandType = CommandType.Text;
                oRowAffected = oCmd.ExecuteNonQuery();
            

            //--- Disconnect from the database
            Disconnect(oCn);
            return oRowAffected;
        }

            
        

        ////------------------------------------------------------------------------------------------------------------
        //// public Method
        //// Overloaded:		Yes
        //// Return Value:	DataSet
        //// Purpose:		Executes a stored procedure.
        ////------------------------------------------------------------------------------------------------------------
        //public Overloads Function RunProc(ByVal sProcName As String, ByVal sTableName As String) As DataSet

        //    Dim oCmd As SqlCommand = New SqlCommand             //--- Create a new SqlCommand
        //    Dim oCn As SqlConnection = Nothing                  //--- Declare the SqlConnection
        //    Dim oDA As SqlDataAdapter = New SqlDataAdapter      //--- Create a new SqlDataAdapter
        //    Dim oDs As DataSet = New DataSet                    //--- Create a new DataSet
        //    Dim oSqlParameter As SqlParameter = Nothing         //--- Declare a SqlParameter
        //    Dim oPMLM As ParameterRE = Nothing                       //--- Declare a Parameter
        //    //--- Get an enumerator for the parameter array list
        //    Dim oEnumerator As IEnumerator = m_oParmList.GetEnumerator()

        //    //--- Prepare connection to the database
        //    oCn = Connect()
        //    oCn.Open()
        //    With oCmd
        //        //--- Set the CommandText, ActiveConnection and the Command Type for the 
        //        //--- SqlCommand Object
        //        .Connection = oCn
        //        .CommandText = sProcName
        //        .CommandType = CommandType.StoredProcedure
        //    End With

        //    //--- Loop through the Parameters in the ArrayList
        //    Do While (oEnumerator.MoveNext())
        //        oPMLM = Nothing
        //        //--- Get the current Parameter object
        //        oPMLM = oEnumerator.Current
        //        //--- Instantiate a SqlParameter object
        //        oSqlParameter = ConvertParameterToSqlParameter(oPMLM)
        //        //--- Add the SqlParameter object to the SqlCommand object
        //        oCmd.Parameters.Add(oSqlParameter)
        //    Loop

        //    With oDA
        //        //--- Assign the SqlCommand Object to the
        //        //--- Select command of the SqlDataAdapter and
        //        .SelectCommand = oCmd

        //        //--- Execute the Stored Procedure and fill the dataset
        //        .Fill(oDs, sTableName)
        //    End With

        //    //--- Disconnect from the database
        //    Disconnect(oCn)

        //    //--- Return the DataSet
        //    Return oDs

        //End Function


        ////------------------------------------------------------------------------------------------------------------
        //// public Method
        //// Overloaded:		Yes
        //// Return Value:	None
        //// Purpose:		Executes a stored procedure.
        ////------------------------------------------------------------------------------------------------------------
        //public Overloads Sub RunProc(ByVal sProcName As String)

        //    Dim oCmd As SqlCommand = New SqlCommand             //--- Create a new SqlCommand
        //    Dim oCn As SqlConnection = Nothing                  //--- Declare the SqlConnection
        //    Dim oSqlParameter As SqlParameter = Nothing         //--- Declare a SqlParameter
        //    Dim oP As ParameterRE = Nothing                       //--- Declare a Parameter
        //    //--- Get an enumerator for the parameter array list
        //    Dim oEnumerator As IEnumerator = m_oParmList.GetEnumerator()

        //    //--- Prepare connection to the database
        //    oCn = Connect()
        //    oCn.Open()
        //    With oCmd
        //        //--- Set the CommandText, ActiveConnection and the Command Type for the 
        //        //--- SqlCommand Object
        //        .Connection = oCn
        //        .CommandText = sProcName
        //        .CommandType = CommandType.StoredProcedure
        //    End With

        //    //--- Loop through the Parameters in the ArrayList
        //    Do While (oEnumerator.MoveNext())
        //        oP = Nothing
        //        //--- Get the current Parameter object
        //        oP = oEnumerator.Current
        //        //--- Instantiate a SqlParameter object
        //        oSqlParameter = ConvertParameterToSqlParameter(oP)
        //        //--- Add the SqlParameter object to the SqlCommand object
        //        oCmd.Parameters.Add(oSqlParameter)
        //    Loop

        //    //--- Execute the Stored Procedure
        //    oCmd.ExecuteNonQuery()

        //    //--- Disconnect from the database
        //    Disconnect(oCn)
        //End Sub

        ////---------------------------------------------------------------------------------------
        //// public Method
        //// Overloaded:		Yes
        //// Return Value:	None
        //// Purpose:		Adds a parameter for a stored procedure.
        ////---------------------------------------------------------------------------------------
        //public Sub AddParameter(ByVal sParameterName As String, ByVal lSqlType As ssenumSqlDataTypesRE, ByVal iSize As Integer, ByVal sValue As String)

        //    Dim eDataType As SqlDbType
        //    Dim oParam As ParameterRE = Nothing

        //    Select Case lSqlType
        //        Case ssenumSqlDataTypesRE.ssSDT_String
        //            eDataType = SqlDbType.VarChar
        //        Case ssenumSqlDataTypesRE.ssSDT_Integer
        //            eDataType = SqlDbType.Int
        //        Case ssenumSqlDataTypesRE.ssSDT_DateTime
        //            eDataType = SqlDbType.DateTime
        //        Case ssenumSqlDataTypesRE.ssSDT_Bit
        //            eDataType = SqlDbType.Bit
        //        Case ssenumSqlDataTypesRE.ssSDT_Decimal
        //            eDataType = SqlDbType.Decimal
        //        Case ssenumSqlDataTypesRE.ssSDT_Money
        //            eDataType = SqlDbType.Money
        //    End Select

        //    oParam = New ParameterRE(sParameterName, eDataType, iSize, sValue)

        //    m_oParmList.Add(oParam)

        //End Sub

        ////---------------------------------------------------------------------------------------
        //// Private Method
        //// Return Value:	None
        //// Purpose:		public Method that converts a Parameter to a SqlParameter
        ////---------------------------------------------------------------------------------------
        //Private Function ConvertParameterToSqlParameter(ByVal oP As ParameterRE) As SqlParameter
        //    //--- Instantiate a SqlParameter object
        //    Dim oSqlParameter As SqlParameter = New SqlParameter(oP.ParameterName, oP.DataType, oP.Size)

        //    With oSqlParameter
        //        .Value = oP.Value
        //        .Direction = oP.Direction
        //    End With

        //    Return oSqlParameter

        //End Function

        //---------------------------------------------------------------------------------------
        // Private Method
        // Return Value:	None
        // Purpose:		public Method that adds a parameter for a stored procedure.
        //---------------------------------------------------------------------------------------
        
        private  SqlConnection  Connect()
        {
            SqlConnection oCn = null ;
            string connectionInfo = System.Configuration.ConfigurationManager.AppSettings["Invoice"];
            m_sConnectionString = connectionInfo;

            if (m_sConnectionString.Length > 0) {
                oCn = new SqlConnection(m_sConnectionString);
            }
            else {
                oCn = new SqlConnection("Server=" + m_sServer + ";User ID=" + m_sUsername + ";Password=" + m_sPassword + ";Database=" + m_sDatabase + ";");
            }
            
            return oCn;
        }

        //---------------------------------------------------------------------------------------
        // Private Method
        // Return Value:	None
        // Purpose:		Close and destroy the Connection
        //---------------------------------------------------------------------------------------
        
        private void  Disconnect (SqlConnection oCn){
            
            oCn.Close();
            //--- Destroy the objects and release the memory
            oCn = null;
        }
            //--- Close the Connection if the Connection exists
            
        

    

    //---------------------------------------------------------------------------------------
    // public Class
    // Purpose:		The parameter class defines a parameter that will be passed 
    //				    to a stored procedure
    //---------------------------------------------------------------------------------------
    //public Class ParameterRE

    //    public DataType As SqlDbType            //--- The datatype of the parameter
    //    public Direction As ParameterDirection  //--- The direction of the parameter
    //    public ParameterName As String          //--- The Name of the parameter
    //    public Size As Integer                  //--- The size of the parameter
    //    public Value As String                  //--- The value of the parameter

    //    //----------------------------------------------------------------------------------------------------
    //    // Class Constructor (zero arguments)
    //    // Overloaded:	No
    //    //----------------------------------------------------------------------------------------------------
    //    Sub New(ByVal sParameterName As String, ByVal lDataType As SqlDbType, ByVal iSize As Integer, ByVal sValue As String)
    //        ParameterName = sParameterName
    //        DataType = lDataType
    //        Size = iSize
    //        Value = sValue 
    //        Direction = ParameterDirection.Input
    //    End Sub

       

        }
}


  //  //--------------------------------------------------------------------------------------------------------------
   // // public Enumerator
    /// Purpose:	This defines all of the data types that can be used by the SqlService
   //--------------------------------------------------------------------------------------------------------------
    


