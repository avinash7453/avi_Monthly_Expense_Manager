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
 String nm=request.getParameter("nm");
   String dt=request.getParameter("dt");
  String note=request.getParameter("note");
  int crdt=Integer.parseInt(request.getParameter("crdt"));
  int opbal=Integer.parseInt(request.getParameter("opbal"));
  int id=Integer.parseInt(request.getParameter("id"));
  int clbl=opbal+crdt;
  out.print(id+" "+dt+" "+note+" "+crdt+" "+clbl+"<br>");
  
  Statement stmt;
  PreparedStatement pstmt;
  ResultSet rs;
  Connection con; 
  try {
  	Class.forName("com.mysql.cj.jdbc.Driver");
		String url="jdbc:mysql://localhost:3306/expense_manager";
	    String username="root";
	    String pass="Avi@7453";
	    con=DriverManager.getConnection(url,username,pass);
		out.print("Connection Successfull...");
		
		pstmt=con.prepareStatement("insert into transaction(date, note, debit, credit, clbal, uid)values(?,?,?,?,?,?)");
		   //psmt.setString(1, dt);
		   java.sql.Date sqlDate = java.sql.Date.valueOf(dt);

		   pstmt.setDate(1, sqlDate);
		   pstmt.setString(2, note);
		   pstmt.setInt(3,0);
		   pstmt.setInt(4,crdt);
		   pstmt.setInt(5,clbl);
		   pstmt.setInt(6,id);
		 int r=  pstmt.executeUpdate();
		 if(r>0){
			 pstmt=con.prepareStatement("update uopbal set opbal= opbal+"+crdt+" where uid="+id);
			 pstmt.executeUpdate();
			 response.sendRedirect("dash.jsp?id=" + id + "&name=" + nm);
		 }
		 else{
			 response.sendRedirect("dash.jsp?id=" + id + "&name=" + nm);
		 }

  }catch(Exception e){
	  
  }
  %>
</body>
</html>