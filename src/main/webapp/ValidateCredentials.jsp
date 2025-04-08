<%@page import="java.sql.*" %>
<%@page import="com.DBConnection" %> <%-- adjust package as per your class --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%!
    public String isBlankNull(String str) {
        return (str == null || str.trim().isEmpty()) ? "" : str;
    }
%>

<%
    String strUserName = isBlankNull(request.getParameter("txtUserNm"));
    String strPassword = isBlankNull(request.getParameter("txtPassword"));

    try {
        DBConnection dbc = new DBConnection();
        Connection con = dbc.getConnection();
        PreparedStatement pstmt = con.prepareStatement("SELECT UserId, Username FROM users WHERE BINARY Username = ? AND BINARY PasswordHash = ?");
        pstmt.setString(1, strUserName);
        pstmt.setString(2, strPassword);

        ResultSet rst = pstmt.executeQuery();

        if (rst.next()) {
            %>
            <%=rst.getString("UserId")%>
            <%=rst.getString("Username")%>
            <%
        } else {
            response.sendRedirect("Login.jsp?error=1");
        }

        // Close resources
        rst.close();
        pstmt.close();
        con.close();

    } catch (Exception ex) {
        out.println("<p style='color:red;'>Error in ValidateCredentials.jsp: " + ex.getMessage() + "</p>");
    }
%>
