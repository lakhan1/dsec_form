<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="connection.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>verification</title>
</head>
<body>
<%
String q=request.getParameter("token");
try{
Class.forName(driver);
Connection conn=DriverManager.getConnection(url,user,password);
Statement stmt=conn.createStatement();
String sql="select * from registeration where hash_value='"+q+"' && active='0'";
ResultSet rs=stmt.executeQuery(sql);
while(rs.next()){
	String email=rs.getString("Email");
	session.setAttribute("email", email);
}
String sqlupdate="update registeration set active='1' where hash_value='"+q+"'";
	int rsupdate=stmt.executeUpdate(sqlupdate);
	if(rsupdate>0){
		out.println(rsupdate);
		response.sendRedirect("sendpassword.jsp");
	}
	else{%>
	<script>
	alert("unauthorised access");
	</script>
	<%
	response.sendRedirect("index1.jsp");
		
	}

}catch(Exception e){
	out.println(e);
}


%>

</body>
</html>