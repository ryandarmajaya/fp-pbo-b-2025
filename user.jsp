<%@ include file="part/header.jsp" %>
<%
if ( userLogin.kode_role != 1 ) {
    response.sendRedirect(request.getContextPath() + "/error-hak-akses.jsp");
    return;
}

String message = null;
UserObject obj = new UserObject();
RoleObject rObj = new RoleObject();
List<RoleObject> daftarRole = role.list();

String actForm = "insert";
String act = request.getParameter("act");

if ( "editPass".equals(act) ) {
    actForm = "updatePass";
    String usernameInput = varUtil.parseString(request.getParameter("username"));
    obj = user.get(usernameInput);
    if(obj != null) rObj = role.get(obj.kode_role);
}
else if("editRole".equals(act) ) {
    actForm = "updateKodeRole";
    String usernameInput = varUtil.parseString(request.getParameter("username"));
    obj = user.get(usernameInput);
    if(obj != null) rObj = role.get(obj.kode_role);
}
else if("del".equals(act)){
    actForm = "delete";
    String usernameInput = varUtil.parseString(request.getParameter("username"));
    obj = user.get(usernameInput);
    if(obj != null) rObj = role.get(obj.kode_role);
}
else if ( "updatePass".equals(act) ) {
    try{
        UserObject ro = new UserObject();
        ro.username = varUtil.parseString(request.getParameter("username"));
        ro.password = varUtil.parseString(request.getParameter("password"));
        
        user.updatePassword(ro.username, ro.password);
        response.sendRedirect(request.getContextPath() + "/user.jsp");
        return;
    }catch(Exception e){ message = e.toString(); }
}
else if ( "updateKodeRole".equals(act) ) {
    try{
        UserObject ro = new UserObject();
        ro.username = varUtil.parseString(request.getParameter("username"));
        ro.kode_role = varUtil.parseInt(request.getParameter("kode_role"));
        
        user.updateKodeRole(ro.username, ro.kode_role);
        response.sendRedirect(request.getContextPath() + "/user.jsp");
        return;
    }catch(Exception e){ message = e.toString(); }
}
else if( "insert".equals(act) ){
    try{
        UserObject ro = new UserObject();
        ro.username = varUtil.parseString(request.getParameter("username"));
        ro.password = varUtil.parseString(request.getParameter("password"));
        ro.kode_role = varUtil.parseInt(request.getParameter("kode_role"));
        
        user.insert(ro);
        response.sendRedirect(request.getContextPath() + "/user.jsp");
        return;
    }catch(Exception e){ message = e.toString(); }
}
else if("delete".equals(act)){
    try{
        String usernameInput = varUtil.parseString(request.getParameter("username"));
        user.delete(usernameInput);
        response.sendRedirect(request.getContextPath() + "/user.jsp");
        return;
    }catch(Exception e){ message = e.toString(); }
}
%>

<div class="page-header">
    <h1>Manajemen User</h1>
</div>

<% if(message != null){ %>
    <div class="alert alert-error">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <strong>Error!</strong> <%=message%>
    </div>
<% } %>

<div class="row">

    <!-- FORM -->
    <div class="span4">
        <div class="role-card">

            <form method="post" action="user.jsp">
                <input type="hidden" name="act" value="<%=actForm%>" />

                <fieldset>
                    <legend><%=actForm.toUpperCase()%> USER</legend>

                    <label>Username</label>
                    <% if ("updatePass".equals(actForm) || "updateKodeRole".equals(actForm) || "delete".equals(actForm)) { %>
                        <input type="hidden" name="username" value="<%=obj.username%>" />
                        <span class="input-block-level uneditable-input"><%=obj.username%></span>
                    <% } else { %>
                        <input type="text" name="username" value="<%= ("insert".equals(actForm) ? "" : obj.username) %>" class="input-block-level" required />
                    <% } %>

                    <% if("updatePass".equals(actForm) || "insert".equals(actForm)) { %>
                        <label>Password</label>
                        <input type="password" name="password" class="input-block-level" required />
                    <% } %>

                    <% if("updateKodeRole".equals(actForm) || "insert".equals(actForm)) { %>
                        <label>Role</label>
                        <select name="kode_role" class="select-block-level">
                            <% for(RoleObject r : daftarRole){
                               String selected = (r.kode == obj.kode_role) ? "selected='selected'" : "";
                            %>
                            <option value="<%=r.kode%>" <%=selected%>><%=r.nama%></option>
                            <% } %>
                        </select>
                    <% } %>

                    <div style="margin-top: 20px;">
                        <button type="submit" class="btn btn-primary"><%=actForm.toUpperCase()%></button>
                        <a href="user.jsp" class="btn btn-default">Reset</a>
                    </div>
                </fieldset>

            </form>

        </div>
    </div>

    <!-- TABLE -->
    <div class="span8">
        <div class="role-table-wrapper">
            <table class="table table-striped table-modern table-bordered table-hover">

                <thead>
                    <tr>
                        <th>Username</th>
                        <th>Role</th>
                        <th style="width:180px;">Actions</th>
                    </tr>
                </thead>

                <tbody>
                <%
                List<UserObject> daftar = user.list();
                for(UserObject ro : daftar){
                    RoleObject roo = role.get(ro.kode_role);
                %>
                <tr>
                    <td><%=ro.username%></td>
                    <td><%=roo.nama%></td>
                    
                    <td>
                        <div class="btn-group">
                            <a class="btn btn-mini btn-info action-btn" href="?act=editPass&username=<%=ro.username%>">
                                <i class="fa fa-pencil"></i> Password
                            </a>
                            <a class="btn btn-mini action-btn" href="?act=editRole&username=<%=ro.username%>">
                                <i class="fa fa-pencil"></i> Role
                            </a>
                            <a class="btn btn-mini btn-danger" href="?act=del&username=<%=ro.username%>">
                                <i class="fa fa-trash"></i> Delete
                            </a>
                        </div>
                    </td>

                </tr>
                <% } %>
                </tbody>

            </table>
        </div>
    </div>

</div>

<%@ include file="part/footer.jsp" %>