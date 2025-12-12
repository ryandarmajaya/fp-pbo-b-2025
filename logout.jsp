<%
    session.setAttribute("username", null);
    session.invalidate();
    response.sendRedirect(request.getContextPath() + "/index.jsp");
    return;
%>