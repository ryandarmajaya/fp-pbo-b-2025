<%@ include file="part/header.jsp" %>
<%
    if ( userLogin.kode_role > 3 ) {
        response.sendRedirect(request.getContextPath() + "/error-hak-akses.jsp");
        return;
    }

    String message = null;
    MahasiswaObject obj = new MahasiswaObject();
    UserObject uObj = new UserObject();
    JenisKelaminObject jkObj = new JenisKelaminObject();
    ProdiObject pObj = new ProdiObject();

    List<JenisKelaminObject> daftarJenisKelamin = jenisKelamin.list();
    List<UserObject> daftarUser = user.listByKodeRole(4);
    List<ProdiObject> daftarProdi = prodi.list(); 

    String actForm = "insert";
    String act = request.getParameter("act");

    if ( "edit".equals(act) ) {
        actForm = "update";
        String nim = varUtil.parseString(request.getParameter("nim"));
        obj = mahasiswa.get(nim);
        if(obj != null) {
            uObj = user.get(obj.username);
            jkObj = jenisKelamin.get(obj.kode_jenis_kelamin);
            pObj = prodi.get(obj.kode_prodi);
        }
    }
    else if("del".equals(act)){
        actForm = "delete";
        String nim = varUtil.parseString(request.getParameter("nim"));
        obj = mahasiswa.get(nim);
        if(obj != null) {
            uObj = user.get(obj.username);
            jkObj = jenisKelamin.get(obj.kode_jenis_kelamin);
            pObj = prodi.get(obj.kode_prodi);
        }
    }
    else if ( "update".equals(act) ) {
        try{
            MahasiswaObject ro = new MahasiswaObject();
            ro.nim = varUtil.parseString(request.getParameter("nim"));
            ro.nama = varUtil.parseString(request.getParameter("nama"));
            ro.kode_jenis_kelamin = varUtil.parseInt(request.getParameter("kode_jenis_kelamin"));
            ro.kode_prodi = varUtil.parseInt(request.getParameter("kode_prodi"));
            ro.username = varUtil.parseString(request.getParameter("username"));
            
            mahasiswa.update(ro);
            response.sendRedirect(request.getContextPath() + "/mahasiswa.jsp");
            return;
        }catch(Exception e){ message = e.toString(); }
    }
    else if( "insert".equals(act) ){
        try{
            MahasiswaObject ro = new MahasiswaObject();
            ro.nim = varUtil.parseString(request.getParameter("nim"));
            ro.nama = varUtil.parseString(request.getParameter("nama"));
            ro.kode_jenis_kelamin = varUtil.parseInt(request.getParameter("kode_jenis_kelamin"));
            ro.kode_prodi = varUtil.parseInt(request.getParameter("kode_prodi"));
            ro.username = varUtil.parseString(request.getParameter("username"));
            
            mahasiswa.insert(ro);
            response.sendRedirect(request.getContextPath() + "/mahasiswa.jsp");
            return;
        }catch(Exception e){ message = e.toString(); }
    }
    else if("delete".equals(act)){
        try{
            String nim = varUtil.parseString(request.getParameter("nim"));
            mahasiswa.delete(nim);
            response.sendRedirect(request.getContextPath() + "/mahasiswa.jsp");
            return;
        }catch(Exception e){ message = e.toString(); }
    }
%>

<div class="page-header">
    <h1>Manajemen Mahasiswa</h1>
</div>

<!-- TOOLBAR -->
<div class="btn-toolbar" style="margin-bottom:20px;">
    <div class="btn-group">
        <a href="mahasiswa.jsp" class="btn btn-success">Tambah Mahasiswa</a>
        <a href="mahasiswa-export.jsp" target="_blank" class="btn">Export Data</a>
        <a href="mahasiswa-import-dialog.jsp" class="btn">Import Data</a>
    </div>
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

            <form method="post" action="mahasiswa.jsp">
                <input type="hidden" name="act" value="<%=actForm%>" />

                <fieldset>
                    <legend><%=actForm.toUpperCase()%> DATA</legend>

                    <!-- NIM -->
                    <label>NIM</label>
                    <% if("update".equals(actForm) || "delete".equals(actForm)) { %>
                        <input type="hidden" name="nim" value="<%=obj.nim%>" />
                        <span class="input-block-level uneditable-input"><%=obj.nim%></span>
                    <% } else { %>
                        <input type="text" name="nim" value="<%= ("insert".equals(actForm) ? "" : obj.nim) %>" class="input-block-level" required />
                    <% } %>

                    <!-- NAMA -->
                    <label>Nama Lengkap</label>
                    <% if("delete".equals(actForm)) { %>
                        <input type="hidden" name="nama" value="<%=obj.nama%>" />
                        <span class="input-block-level uneditable-input"><%=obj.nama%></span>
                    <% } else { %>
                        <input type="text" name="nama" value="<%= ("insert".equals(actForm) ? "" : obj.nama) %>" class="input-block-level" required />
                    <% } %>

                    <!-- JK -->
                    <label>Jenis Kelamin</label>
                    <% if("delete".equals(actForm)) { %>
                        <input type="hidden" name="kode_jenis_kelamin" value="<%=obj.kode_jenis_kelamin%>" />
                        <span class="input-block-level uneditable-input"><%=jkObj.nama%></span>
                    <% } else { %>
                        <select name="kode_jenis_kelamin" class="select-block-level">
                            <% for(JenisKelaminObject jO : daftarJenisKelamin){
                                String selected = (jO.kode == obj.kode_jenis_kelamin) ? "selected='selected'" : "";
                            %>
                            <option value="<%=jO.kode%>" <%=selected%>><%=jO.nama%></option>
                            <% } %>
                        </select>
                    <% } %>

                    <!-- PRODI -->
                    <label>Program Studi</label>
                    <% if("delete".equals(actForm)) { %>
                        <input type="hidden" name="kode_prodi" value="<%=obj.kode_prodi%>" />
                        <span class="input-block-level uneditable-input"><%=pObj.nama%></span>
                    <% } else { %>
                        <select name="kode_prodi" class="select-block-level">
                            <% for(ProdiObject pO : daftarProdi){
                               String selected = (pO.kode == obj.kode_prodi) ? "selected='selected'" : "";
                            %>
                            <option value="<%=pO.kode%>" <%=selected%>><%=pO.nama%></option>
                            <% } %>
                        </select>
                    <% } %>

                    <!-- USERNAME -->
                    <label>Username Login</label>
                    <% if("delete".equals(actForm)) { %>
                        <input type="hidden" name="username" value="<%=obj.username%>" />
                        <span class="input-block-level uneditable-input"><%=uObj.username%></span>
                    <% } else { %>
                        <select name="username" class="select-block-level">
                            <% for(UserObject uO : daftarUser){
                                String selected = (uO.username.equals(obj.username)) ? "selected='selected'" : "";
                            %>
                            <option value="<%=uO.username%>" <%=selected%>><%=uO.username%></option>
                            <% } %>
                        </select>
                    <% } %>

                    <div style="margin-top: 20px;">
                        <button type="submit" class="btn btn-primary"><%=actForm.toUpperCase()%></button>
                        <a href="mahasiswa.jsp" class="btn btn-default">Cancel</a>
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
                        <th>NIM</th>
                        <th>Nama</th>
                        <th>L/P</th>
                        <th>Prodi</th>
                        <th>Username</th>
                        <th style="width:140px;">Actions</th>
                    </tr>
                </thead>

                <tbody>
                <%
                List<MahasiswaObject> daftar = mahasiswa.list();
                for(MahasiswaObject d : daftar){
                    UserObject uO = user.get(d.username);
                    JenisKelaminObject jkO = jenisKelamin.get(d.kode_jenis_kelamin);
                    ProdiObject pO = prodi.get(d.kode_prodi);
                %>
                <tr>
                    <td><%=d.nim%></td>
                    <td><%=d.nama%></td>
                    <td><%=jkO.nama%></td>
                    <td><%=pO.nama%></td>
                    <td><%=uO.username%></td>

                    <td>
                        <div class="btn-group">
                            <a class="btn btn-mini btn-info action-btn" href="?act=edit&nim=<%=d.nim%>">
                                <i class="fa fa-pencil"></i> Update
                            </a>
                            <a class="btn btn-mini btn-danger" href="?act=del&nim=<%=d.nim%>">
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