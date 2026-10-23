<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String mob=request.getParameter("mobile");
out.print(mob);

Connection con;
Statement stmt;
ResultSet rs;
try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	String url="jdbc:mysql://localhost:3306/expense_manager";
    String username="root";
    String pass="Avi@7453";
    con=DriverManager.getConnection(url,username,pass);
	out.print("Connection Successfull...");
	stmt=con.createStatement();
    rs=stmt.executeQuery("select uid,uname from users where mobile='"+mob+"'");
    int flg=0;
    while(rs.next()){
    	flg++;
    	int id=rs.getInt(1);
    	String name=rs.getString(2);
    	
    	response.sendRedirect("dash.jsp?id=" + id + "&name=" + name);
    }
    if(flg>0){
    	response.sendRedirect("dash.jsp");
    }else{
    	response.sendRedirect("login.html");
    }
}catch(Exception e){
	out.print(e);
}
%>
</body>
</html>