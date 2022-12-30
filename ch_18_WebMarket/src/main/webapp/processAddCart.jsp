<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String sessionId = (String) session.getAttribute("sessionId");
	String productId = request.getParameter("p_id");

	
	PreparedStatement pstmt = null;	
	
	String sql = "insert into cart(id, p_id) values(?,?)";
	pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, sessionId);
	pstmt.setString(2, productId);
	
	pstmt.executeUpdate();
	
	if (pstmt != null)
		pstmt.close();
	if (conn != null)
		conn.close();
	
	response.sendRedirect("cart.jsp");
	
%>
	
