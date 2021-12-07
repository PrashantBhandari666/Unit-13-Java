# Database Programming with JDBC
JDBC stands for ``Java Database Connectivity`` , which is a standard Java API for database-independent connectivity between the Java programming language and a wide range of databases.

The JDBC library includes APIs for each of the tasks mentioned below that are commonly associated with database usage.

* Making a connection to a database.
* Creating SQL or MySQL statements.
* Executing SQL or MySQL queries in the database.
* Viewing & Modifying the resulting records.

Fundamentally, JDBC is a specification that provides a complete set of interfaces that allows for portable access to an underlying database. Java can be used to write different types of executables, such as −

* Java Applications
* Java Applets
* Java Servlets
* Java ServerPages (JSPs)
* Enterprise JavaBeans (EJBs).

All of these different executables are able to use a JDBC driver to access a database, and take advantage of the stored data.

JDBC provides the same capabilities as ODBC, allowing Java programs to contain database-independent code.

## Using Connection:
------------------------
You can establish a connection using the ``DriverManager.getConnection()`` method. For easy reference, let me list the three overloaded ``DriverManager.getConnection()`` methods −

* ``getConnection(String url)``

* ``getConnection(String url, Properties prop)``

* ``getConnection(String url, String user, String password)``

Here each form requires a database URL. A database URL is an address that points to your database.

Formulating a database URL is where most of the problems associated with establishing a connection occurs.

Following table lists down the popular JDBC driver names and database URL.

| RDBMS |         JDBC driver name           |                      URL format                        |
|-------|------------------------------------|--------------------------------------------------------|
|MySQL  |``com.mysql.jdbc.Driver``           |``jdbc:mysql://hostname/ databaseName``                 |
|ORACLE |``oracle.jdbc.driver.OracleDriver`` |``jdbc:oracle:thin:@hostname:port Number:databaseName`` |
|DB2    |``com.ibm.db2.jdbc.net.DB2Driver``  |``jdbc:db2:hostname:port Number/databaseName``          |
|Sybase |``com.sybase.jdbc.SybDriver``       |``jdbc:sybase:Tds:hostname: port Number/databaseName``  |

**Create Connection Object**

We have listed down three forms of ``DriverManager.getConnection()`` method to create a connection object.
The most commonly used form of ``getConnection()`` requires you to pass a database URL, a username, and a password. 

```Java
String url ="jdbc:mysql://localhost/school";
String user="root";
String password="";
Connection con = DriverManager.getConnection(url, user, password);
```

**Closing JDBC Connections**

At the end of your JDBC program, it is required explicitly to close all the connections to the database to end each database session. However, if you forget, Java's garbage collector will close the connection when it cleans up stale objects.

Relying on the garbage collection, especially in database programming, is a very poor programming practice. You should make a habit of always closing the connection with the ``close()`` method associated with connection object.

To ensure that a connection is closed, you could provide a 'finally' block in your code. A finally block always executes, regardless of an exception occurs or not.

To close the above opened connection, you should call ``close()`` method as follows −

```Java
con.close();
```
Example Program:
```Java
import java.sql.*;
import java.sql.SQLException;

class Main {
    public static void main(String [] args) {
        String url ="jdbc:mysql://localhost/school";
        String user="root";
        String password="";
        try {
            Connection con = DriverManager.getConnection(url, user, password);
            System.out.println("Connection Sucessful");
            con.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
```

## Using Statement:
-------------------

The ``Statement interface`` provides methods to execute queries with the database. The statement interface is a factory of ResultSet i.e. it provides factory method to get the object of ResultSet.

Before you can use a Statement object to execute a SQL statement, you need to create one using the Connection object's ``createStatement()`` method, as in the following example 

### Create Statemet:

From the connection interface, you can create the object for this interface. It is generally used for general–purpose access to databases and is useful while using static SQL statements at runtime.

Syntax:

```
Statement statement = connection.createStatement();
```

Example:

```Java
Statement s = con.createStatement();
```

**Commonly used methods of Statement interface:**

* ``public ResultSet executeQuery(String sql)``: is used to execute SELECT query. It returns the object of ResultSet.
* ``public int executeUpdate(String sql)``: is used to execute specified query, it may be create, drop, insert, update, delete etc.
* ``public boolean execute(String sql)``: is used to execute queries that may return multiple results.
* ``public int[] executeBatch()``: is used to execute batch of commands.

### Prepared Statement:

Prepared Statement represents a recompiled SQL statement, that can be executed many times. This accepts parameterized SQL queries. In this, ``?`` is used instead of the parameter, one can pass the parameter dynamically by using the methods of PREPARED STATEMENT at run time.

**Illustration:** 

Considering in the people database if there is a need to INSERT some values, SQL statements such as these are used: 

```Java
INSERT INTO people VALUES ("Ayan",25);
```
To do the same in Java, one may use Prepared Statements and set the values in the ``?`` holders, setXXX() of a prepared statement is used as shown: 

```Java
String query = "INSERT INTO people(name, age)VALUES(?, ?)";
Statement s = con.prepareStatement(query);
s.setString(1,"Ayan");
s.setInt(2,25);
s.executeUpdate();
```
**Implementation:** Once the PreparedStatement object is created, there are three ways to execute it: 

* ``execute()``: This returns a boolean value and executes a static SQL statement that is present in the prepared statement object.

* ``executeQuery()``: Returns a ResultSet from the current prepared statement.

* ``executeUpdate()``: Returns the number of rows affected by the DML statements such as ``INSERT``, ``DELETE``, and more that is present in the current Prepared Statement.

### Callable Statement:

Callable Statement are stored procedures which are a group of statements that we compile in the database for some task, they are beneficial when we are dealing with multiple tables with complex scenario & rather than sending multiple queries to the database, we can send the required data to the stored procedure & lower the logic executed in the database server itself. The Callable Statement interface provided by JDBC API helps in executing stored procedures.

Syntax: To prepare a CallableStatement

```Java
CallableStatement cstmt = con.prepareCall("{call Procedure_name(?, ?}");
```
**Implementation:** Once the callable statement object is created

* ``execute()`` is used to perform the execution of the statement.

Example Programs:

```Java
import java.sql.*;
import java.sql.SQLException;

public class CreateTable {
    public static void main(String[] args) {
        String url ="jdbc:mysql://localhost/school";
        String user="root";
        String password="";
        String query= "CREATE TABLE student (StudentID int,FirstName varchar(255),LastName varchar(255),RollNo int,City varchar(255));";
        try {
            Connection con = DriverManager.getConnection(url, user, password);
            Statement s = con.createStatement();
            s.executeUpdate(query);
            System.out.println("Table Created");
            con.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
```

```Java
import java.sql.*;
import java.sql.SQLException;

public class Insert {
    public static void main(String[] args) {
        String url ="jdbc:mysql://localhost/school";
        String user="root";
        String password="";
        try {
            Connection con = DriverManager.getConnection(url, user, password);
            Statement s = con.createStatement();
            String query= "INSERT INTO student VALUES (1, 'Prashant', 'Bhandari', 39, 'Birtamode');";
            s.executeUpdate(query);
            System.out.println("Data Inserted");
            con.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}

```

## Result Set Interface:
------------------------

The SQL statements that read data from a database query, return the data in a result set. The ``SELECT`` statement is the standard way to select rows from a database and view them in a result set. The java.sql.ResultSet interface represents the result set of a database query.

A ResultSet object maintains a cursor that points to the current row in the result set. The term "result set" refers to the row and column data contained in a ResultSet object.

**Commonly used methods of ResultSet interfaces:**

* ``public boolean next()``:is used to move the cursor to the one row next from the current position.
* ``public boolean previous()``:is used to move the cursor to the one row previous from the current position.
* ``public boolean first()``:is used to move the cursor to the first row in result set object.
* ``public boolean last()``:is used to move the cursor to the last row in result set object.
* ``public boolean absolute(int row)``: is used to move the cursor to the specified row number in the ResultSet object.
* ``public boolean relative(int row)``: is used to move the cursor to the relative row number in the ResultSet object, it may be positive or negative.
* ``public int getInt(int columnIndex)``: is used to return the data of specified column index of the current row as int.
* ``public int getInt(String columnName)``:is used to return the data of specified column name of the current row as int.
* ``public String getString(int columnIndex)``:is used to return the data of specified column index of the current row as String.
* ``public String getString(String columnName)``:is used to return the data of specified column name of the current row as String.

**Creating a ResultSet**

You create a ResultSet by executing a Statement or PreparedStatement, like this:

```Java
Statement statement = connection.createStatement();
ResultSet result = statement.executeQuery("select * from people");
```

Or like this:

```Java
String sql = "select * from people";
PreparedStatement statement = connection.prepareStatement(sql);
ResultSet result = statement.executeQuery();
```

Example Program:

```Java
import java.sql.*;
import java.sql.SQLException;

public class Select {
    public static void main(String[] args) {
        String url ="jdbc:mysql://localhost/school";
        String user="root";
        String password="";
        try
        {
            Connection conn = DriverManager.getConnection(url,user,password);
            Statement s = conn.createStatement();
            String query="SELECT * FROM student";
            ResultSet r = s.executeQuery(query);
            while(r.next()){
                //Display values
                System.out.print(" ID : " + r.getInt("StudentID"));
                System.out.print(" First Name: " + r.getString("FirstName"));
                System.out.print(" Last Name: " + r.getString("LastName"));
                System.out.print(" Roll Number: " + r.getInt("RollNo"));
                System.out.println(" City : " + r.getString("City"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
```
Output:
```
ID : 1 First Name: Prashant Last Name: Bhandari Roll Number: 39 City : Birtamode
```
