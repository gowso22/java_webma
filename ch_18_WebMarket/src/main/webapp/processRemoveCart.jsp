<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");

	String productId = request.getParameter("id");
	
	PreparedStatement pstmt = null;	
	
	String sql = "delete from cart where p_id = ?";
	pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, productId);
	
	pstmt.executeUpdate();
	
	if (pstmt != null)
		pstmt.close();
	if (conn != null)
		conn.close();
	
	response.sendRedirect("cart.jsp");
	
%>
	
