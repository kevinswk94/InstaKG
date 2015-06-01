using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Collections;
using System.Data;
using System.Configuration;
/// <summary>
/// Summary description for DataBaseHelper
/// </summary>
public class DataBaseHelper
{
	SqlConnection _SqlConnection;
	SqlCommand _SqlCommand;
	SqlDataAdapter _sqlDataAdapter;
	public DataBaseHelper()
	{
	}
	public int ExecuteNonQuery(string procedureName, Hashtable cmdParms)
	{
		int result = -1;
		_SqlConnection = GetSQLConnection();
		try
		{
			//Open SQL Connection
			_SqlConnection.Open();
			//creating instance of SqlCommand
			_SqlCommand = new SqlCommand(procedureName, _SqlConnection);
			//setting sql commandType
			_SqlCommand.CommandType = CommandType.StoredProcedure;
			//null or empty checking procdure name and hashtable
			if (cmdParms.Count > 0 && !string.IsNullOrWhiteSpace(procedureName))
			{
				foreach (DictionaryEntry de in cmdParms)
				{
					//adding sql parameter
					_SqlCommand.Parameters.Add(new SqlParameter(de.Key.ToString(), de.Value));
				}
				//Executing SQl Command
			   result= _SqlCommand.ExecuteNonQuery();
			}
		}

		finally
		{
			//closing sql connection
			_SqlConnection.Close();
		}
		return result;
	}
	public DataTable GetTable(string sqlQuery)
	{
		//creating new instance of Datatable
		DataTable dataTable = new DataTable();
		_SqlConnection = GetSQLConnection();
		_SqlCommand = new SqlCommand(sqlQuery, _SqlConnection);
		//Open SQL Connection
		_SqlConnection.Open();
			try
			{
				_sqlDataAdapter = new SqlDataAdapter(_SqlCommand);
				_sqlDataAdapter.Fill(dataTable);
			}
			catch
			{ }
			finally
			{
				//Closing Sql Connection 
				_SqlConnection.Close();
			}
		return dataTable;
	}
	public object SQLExecuteNonQuery(string procedureName, Hashtable cmdParms)
	{
		try
		{
			_SqlConnection = GetSQLConnection();
			//Open SQL Connection
			_SqlConnection.Open();
			_SqlCommand = new SqlCommand(procedureName, _SqlConnection);

			_SqlCommand.CommandType = CommandType.StoredProcedure;
			//null or empty checking procdure name and hashtable
			if (cmdParms.Count > 0 && !string.IsNullOrWhiteSpace(procedureName))
			{
				foreach (DictionaryEntry de in cmdParms)
				{
					//adding sql parameter
					_SqlCommand.Parameters.Add(new SqlParameter(de.Key.ToString(), de.Value));
				}
			   
			}
			//Executing SQl Command
			return _SqlCommand.ExecuteScalar();
		}
		finally
		{
			_SqlConnection.Close();
		}
	}
	public static SqlConnection GetSQLConnection()
	{
		return new SqlConnection(ConfigurationManager.AppSettings["sqlConn"]);
	}
}