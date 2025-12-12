<%
    if ( session.getAttribute("username") == null ) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>