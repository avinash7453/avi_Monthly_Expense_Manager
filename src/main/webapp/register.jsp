<%@page import="org.apache.catalina.connector.Response"%>

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
String name=request.getParameter("name");
String mob=request.getParameter("mobile");
int bal=Integer.parseInt(request.getParameter("bal"));

out.print(name+mob+bal);

Connection con;
Statement stmt;
ResultSet rs;
PreparedStatement pstmt;

	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		String url="jdbc:mysql://localhost:3306/expense_manager";
	    String username="root";
	    String pass="Avi@7453";
	    con=DriverManager.getConnection(url,username,pass);
		out.print("Connection Successfull...");
		pstmt=con.prepareStatement("insert into users (uname,mobile) values(?,?)");
		pstmt.setString(1, name);
		pstmt.setString(2, mob);
		int r=pstmt.executeUpdate();
		if(r>0){
			out.print("success");
			stmt=con.createStatement();
			rs=stmt.executeQuery("select max(uid) as uid from users");
			while(rs.next()){
				int id=rs.getInt(1);
				pstmt=con.prepareStatement("insert into uopbal(uid,opbal) values(?,?)");
				pstmt.setInt(1, id);
				pstmt.setInt(2, bal);
				pstmt.executeUpdate();
			}
			response.sendRedirect("login.html");
		}
		else{
			out.print("failed");
			response.sendRedirect("login.html");
		}
		
	}catch(Exception e){
		out.print(e);
	}
		
%>
</body>
</html>