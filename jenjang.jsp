<%@ include file="part/header.jsp" %>
<%
if ( userLogin.kode_role != 1 ) {
    response.sendRedirect(request.getContextPath() + "/error-hak-akses.jsp");
    return;
}

String message = null;
JenjangObject obj = new JenjangObject();
String actForm = "insert";
String act = request.getParameter("act");

if ( "edit".equals(act) ) {
    actForm = "update";
    int kode = varUtil.parseInt(request.getParameter("kode"));
    obj = jenjang.get(kode);
}
else if("del".equals(act)){
    actForm = "delete";
    int kode = varUtil.parseInt(request.getParameter("kode"));
    obj = jenjang.get(kode);
}
else if ( "update".equals(act) ) {
    try{
        JenjangObject ro = new JenjangObject();
        ro.kode = varUtil.parseInt(request.getParameter("kode"));
        ro.nama = varUtil.parseString(request.getParameter("nama"));
        
        jenjang.update(ro);
        response.sendRedirect(request.getContextPath() + "/jenjang.jsp");
        return;
    }catch(Exception e){ message = e.toString(); }
}
else if( "insert".equals(act) ){
    try{
        JenjangObject ro = new JenjangObject();
        ro.kode = varUtil.parseInt(request.getParameter("kode"));
        ro.nama = varUtil.parseString(request.getParameter("nama"));
        
        jenjang.insert(ro);
        response.sendRedirect(request.getContextPath() + "/jenjang.jsp");
        return;
    }catch(Exception e){ message = e.toString(); }
}
else if("delete".equals(act)){
    try{
        int kode = varUtil.parseInt(request.getParameter("kode"));
        jenjang.delete(kode);
        response.sendRedirect(request.getContextPath() + "/jenjang.jsp");
        return;
    }catch(Exception e){ message = e.toString(); }
}
%>

<div class="page-header">
    <h1>Manajemen Jenjang Pendidikan</h1>
</div>

<% if(message != null){ %>
    <div class="alert alert-error">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <strong>Error!</strong> <%=message%>
    </div>
<% } %>

<div class="row">

    <!-- FORM CARD -->
    <div class="span4">
        <div class="role-card">

            <form method="post" action="jenjang.jsp">
                <input type="hidden" name="act" value="<%=actForm%>" />

                <fieldset>
                    <legend><%=actForm.toUpperCase()%> JENJANG</legend>

                    <!-- KODE JENJANG -->
                    <label>Kode</label>
                    <% if ( "update".equals(actForm) || "delete".equals(actForm) ) { %>
                        <input type="hidden" name="kode" value="<%=varUtil.show(obj.kode)%>" />
                        <span class="input-block-level uneditable-input"><%=varUtil.show(obj.kode)%></span>
                    <% } else { %>
                        <input type="text" name="kode" value="<%=varUtil.show(obj.kode)%>"
                               class="input-block-level" required />
                    <% } %>

                    <!-- NAMA JENJANG -->
                    <label>Nama Jenjang</label>
                    <% if("delete".equals(actForm)){ %>
                        <span class="input-block-level uneditable-input"><%=varUtil.show(obj.nama)%></span>
                    <% } else { %>
                        <input type="text" name="nama" value="<%=varUtil.show(obj.nama)%>"
                               class="input-block-level" required />
                    <% } %>

                    <!-- BUTTONS -->
                    <div style="margin-top: 20px;">
                        <button type="submit" class="btn btn-primary">
                            <%=actForm.toUpperCase()%>
                        </button>
                        <a href="jenjang.jsp" class="btn btn-default">Reset</a>
                    </div>

                </fieldset>
            </form>

        </div>
    </div>

    <!-- TABLE CARD -->
    <div class="span8">
        <div class="role-table-wrapper">
            <table class="table table-striped table-modern table-bordered table-hover">
                <thead>
                    <tr>
                        <th>Kode</th>
                        <th>Nama Jenjang</th>
                        <th style="width: 140px;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                List<JenjangObject> daftar = jenjang.list();
                for(JenjangObject ro : daftar){
                %>
                    <tr>
                        <td><%=varUtil.show(ro.kode)%></td>
                        <td><%=varUtil.show(ro.nama)%></td>
                        <td>
                            <div class="btn-group">
                                <a class="btn btn-mini btn-info action-btn"
                                href="?act=edit&kode=<%=ro.kode%>">
                                    <i class="fa fa-pencil"></i> Update
                                </a>
                                <a class="btn btn-mini btn-danger"
                                href="?act=del&kode=<%=ro.kode%>">
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