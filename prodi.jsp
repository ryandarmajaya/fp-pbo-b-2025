<%@ include file="part/header.jsp" %>
<%
if ( userLogin.kode_role != 1 ) {
    response.sendRedirect(request.getContextPath() + "/error-hak-akses.jsp");
    return;
}

String message = null;
ProdiObject obj = new ProdiObject();
JenjangObject jObj = new JenjangObject();
List<JenjangObject> daftarJenjang = jenjang.list();

String actForm = "insert";
String act = request.getParameter("act");

if ( "edit".equals(act) ) {
    actForm = "update";
    int kode = varUtil.parseInt(request.getParameter("kode"));
    obj = prodi.get(kode);
    if(obj != null) jObj = jenjang.get(obj.kode_jenjang);
}
else if("del".equals(act)){
    actForm = "delete";
    int kode = varUtil.parseInt(request.getParameter("kode"));
    obj = prodi.get(kode);
    if(obj != null) jObj = jenjang.get(obj.kode_jenjang);
}
else if ( "update".equals(act) ) {
    try{
        ProdiObject ro = new ProdiObject();
        ro.kode = varUtil.parseInt(request.getParameter("kode"));
        ro.nama = varUtil.parseString(request.getParameter("nama"));
        ro.kode_jenjang = varUtil.parseInt(request.getParameter("kode_jenjang"));
        
        prodi.update(ro);
        response.sendRedirect(request.getContextPath() + "/prodi.jsp");
        return;
    }catch(Exception e){ message = e.toString(); }
}
else if( "insert".equals(act) ){
    try{
        ProdiObject ro = new ProdiObject();
        ro.kode = varUtil.parseInt(request.getParameter("kode"));
        ro.nama = varUtil.parseString(request.getParameter("nama"));
        ro.kode_jenjang = varUtil.parseInt(request.getParameter("kode_jenjang"));
        
        prodi.insert(ro);
        response.sendRedirect(request.getContextPath() + "/prodi.jsp");
        return;
    }catch(Exception e){ message = e.toString(); }
}
else if("delete".equals(act)){
    try{
        int kode = varUtil.parseInt(request.getParameter("kode"));
        prodi.delete(kode);
        response.sendRedirect(request.getContextPath() + "/prodi.jsp");
        return;
    }catch(Exception e){ message = e.toString(); }
}
%>

<div class="page-header">
    <h1>Manajemen Prodi</h1>
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

            <form method="post" action="prodi.jsp">
                <input type="hidden" name="act" value="<%=actForm%>" />

                <fieldset>
                    <legend><%=actForm.toUpperCase()%> PRODI</legend>

                    <label>Kode Prodi</label>
                    <% if ("update".equals(actForm) || "delete".equals(actForm)) { %>
                        <input type="hidden" name="kode" value="<%=obj.kode%>"/>
                        <span class="input-block-level uneditable-input"><%=obj.kode%></span>
                    <% } else { %>
                        <input type="text" name="kode" value="<%= ("insert".equals(actForm) ? "" : obj.kode) %>" class="input-block-level" required />
                    <% } %>

                    <label>Nama Prodi</label>
                    <% if("delete".equals(actForm)) { %>
                        <span class="input-block-level uneditable-input"><%=obj.nama%></span>
                    <% } else { %>
                        <input type="text" name="nama" value="<%= ("insert".equals(actForm) ? "" : obj.nama) %>" class="input-block-level" required />
                    <% } %>

                    <label>Jenjang</label>
                    <% if("delete".equals(actForm)) { %>
                        <input type="hidden" name="kode_jenjang" value="<%=obj.kode_jenjang%>"/>
                        <span class="input-block-level uneditable-input"><%=jObj.nama%></span>
                    <% } else { %>
                        <select name="kode_jenjang" class="select-block-level">
                            <% for(JenjangObject jo : daftarJenjang){
                                String selected = (jo.kode == obj.kode_jenjang) ? "selected='selected'" : "";
                            %>
                            <option value="<%=jo.kode%>" <%=selected%>><%=jo.nama%></option>
                            <% } %>
                        </select>
                    <% } %>

                    <div style="margin-top: 20px;">
                        <button type="submit" class="btn btn-primary"><%=actForm.toUpperCase()%></button>
                        <a href="prodi.jsp" class="btn btn-default">Reset</a>
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
                    <th>Kode</th>
                    <th>Nama Prodi</th>
                    <th>Jenjang</th>
                    <th style="width:140px;">Actions</th>
                </tr>
                </thead>

                <tbody>
                <%
                List<ProdiObject> daftar = prodi.list();
                for(ProdiObject ro : daftar){
                    JenjangObject ojo = jenjang.get(ro.kode_jenjang);
                %>
                <tr>
                    <td><%=ro.kode%></td>
                    <td><%=ro.nama%></td>
                    <td><%=ojo.nama%></td>
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