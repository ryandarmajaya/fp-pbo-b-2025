<%@ include file="part/header.jsp" %>
<%
if ( userLogin.kode_role > 3 ) {
    response.sendRedirect(request.getContextPath() + "/error-hak-akses.jsp");
    return;
}

String message = null;
String actForm = "import";
String act = request.getParameter("act");

if ( "import".equals(act) ) {
    String newRandomName = null; 
    FileItem uploadedFileItem = null; 
    
    boolean isMultipart = JakartaServletFileUpload.isMultipartContent(request);

    if (isMultipart) {
        try {
            DiskFileItemFactory factory = DiskFileItemFactory.builder().get();
            JakartaServletFileUpload upload = new JakartaServletFileUpload(factory);
            List<FileItem> items = upload.parseRequest(new JakartaServletRequestContext(request));

            for (FileItem item : items) {
                if (!item.isFormField() && "file".equals(item.getFieldName())) {
                    uploadedFileItem = item;
                    break; 
                }
            }
            
            if (uploadedFileItem != null && uploadedFileItem.getName() != null && !uploadedFileItem.getName().isEmpty()) {
                
                String uploadPath = Config.getTempDir();
                String originalFileName = new File(uploadedFileItem.getName()).getName();
                
                String extension = "";
                int i = originalFileName.lastIndexOf('.');
                if (i > 0) {
                    extension = originalFileName.substring(i);
                }
                newRandomName = UUID.randomUUID().toString() + extension;

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();
                Path finalFilePath = new File(uploadPath, newRandomName).toPath();

                uploadedFileItem.write(finalFilePath);

                response.sendRedirect(request.getContextPath() + "/mahasiswa-import-waiting.jsp?file=" + newRandomName);
                return; 

            } else {
                message = "Anda tidak memilih file untuk di-upload.";
            }

        } catch (Exception e) {
            message = "Upload Gagal: " + e.getMessage();
            e.printStackTrace(); 
        }
    } else {
        message = "Form tidak valid (bukan multipart/form-data).";
    }
}
%>

<div class="page-header">
    <h1>Import Data Mahasiswa</h1>
</div>

<!-- INFO BOX -->
<div class="row">
    <div class="span12">
        <div class="role-card" style="border-left:5px solid #4cc9f0;">
            <strong>Petunjuk:</strong><br/>
            Silakan download template CSV terlebih dahulu, isi data, lalu upload kembali.
        </div>
    </div>
</div>

<div class="row" style="margin-top:20px;">

    <!-- FORM UPLOAD -->
    <div class="span6">
        <div class="role-card">

            <% if(message != null){ %>
                <div class="alert alert-error" style="margin-bottom: 15px;">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <strong>Error!</strong> <%=message%>
                </div>
            <% } %>

            <form method="post"
                  action="mahasiswa-import-dialog.jsp?act=<%=actForm%>"
                  enctype="multipart/form-data">

                <fieldset>
                    <legend>UPLOAD CSV</legend>

                    <label>Pilih File CSV</label>
                    <input type="file" name="file"
                           class="select-block-level"
                           style="padding:10px; border-radius:10px;"
                           required />

                    <div style="margin-top: 20px;">
                        <button type="submit" class="btn btn-primary">
                            Upload & Proses
                        </button>
                        <a href="mahasiswa.jsp" class="btn btn-default">Batal</a>
                    </div>
                </fieldset>

            </form>
        </div>
    </div>

    <!-- TEMPLATE CSV DOWNLOAD -->
    <div class="span6">
        <div class="role-card" style="text-align:center;">

            <h3 style="font-weight:600; margin-bottom:10px;">Template CSV</h3>
            <p style="color:#666;">Gunakan file ini sebagai acuan format data.</p>

            <a href="mahasiswa-template.csv"
               target="_blank"
               class="btn btn-success btn-large"
               style="margin-top:10px; border-radius:12px;">
               Download Template CSV
            </a>

        </div>
    </div>

</div>

<%@ include file="part/footer.jsp" %>