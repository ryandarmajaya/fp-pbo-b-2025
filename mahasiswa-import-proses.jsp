<%@ include file="part/header.jsp" %>
<%
if ( userLogin.kode_role > 3 ) {
    response.sendRedirect(request.getContextPath() + "/error-hak-akses.jsp");
    return;
}

if ( request.getParameter("file") == null ) {
    response.sendRedirect(request.getContextPath() + "/error-hak-akses.jsp");
    return;
}
%>

<div class="page-header">
    <h1>Hasil Import Mahasiswa</h1>
</div>

<div class="btn-toolbar">
    <a href="mahasiswa.jsp" class="btn btn-primary"><i class="icon-ok icon-white"></i> Selesai / Kembali</a>
    <a href="mahasiswa-import-dialog.jsp" class="btn">Import Lagi</a>
</div>

<table class="table table-striped table-bordered table-condensed">
    <caption>Rekapitulasi Proses Import</caption>
    <thead>
        <tr>
            <th style="width: 50px;">Baris</th>
            <th style="width: 100px;">Status</th>
            <th>Detail / Pesan Error</th>
        </tr>
    </thead>
    <tbody>
    <%
    String[] header = new MahasiswaObject().header();
    String fileName = request.getParameter("file");
    String filePath = Config.getTempDir() + File.separator + fileName;
    
    File f = new File(filePath);
    
    if(f.exists()){
        BufferedReader reader = new BufferedReader(new FileReader(f));
        String line;
        int baris = 0;
        boolean ready = true;
        
        while ( (line = reader.readLine()) != null ){
            baris++;
            if(line.trim().isEmpty()) continue;

            CSVParser parser = CSVParser.parse(line, CSVFormat.DEFAULT);
            List<CSVRecord> daftarRecord = parser.getRecords();
            
            if(daftarRecord.isEmpty()) continue;

            CSVRecord record = daftarRecord.get(0);
            
            if ( baris == 1 ) {
                for ( int i=0; i<header.length; i++ ) {
                    if ( record.size() <= i || !header[i].equalsIgnoreCase(record.get(i)) ) {
                        ready = false;
                        break;
                    }
                }
                if(!ready){
    %>
                <tr class="error">
                    <td>1</td>
                    <td><span class="label label-important">FATAL</span></td>
                    <td>Format Header CSV Salah. Harap gunakan template yang benar.</td>
                </tr>
    <%
                    break;
                }
                continue;
            }
            
            String status = "OK";
            String pesanError = "-";
            String rowClass = "success";
            
            try{
                MahasiswaObject mo = new MahasiswaObject();
                mo.nim = varUtil.parseString(record.get(0));
                mo.nama = varUtil.parseString(record.get(1));
                mo.kode_jenis_kelamin = varUtil.parseInt(record.get(2));
                mo.kode_prodi = varUtil.parseInt(record.get(3));
                mo.username = varUtil.parseString(record.get(4));
                
                mahasiswa.upsert(mo);
                
            }catch(Exception e){
                status = "ERROR";
                pesanError = e.getMessage();
                rowClass = "error";
            }
    %>
            <tr class="<%=rowClass%>">
                <td><%=varUtil.show(baris)%></td>
                <td>
                    <% if("OK".equals(status)) { %>
                        <span class="label label-success">OK</span>
                    <% } else { %>
                        <span class="label label-important">ERROR</span>
                    <% } %>
                </td>
                <td><%=varUtil.show(pesanError)%></td>
            </tr>
    <%
        }
        
        reader.close();
        
        try { f.delete(); } catch(Exception e){}
    } else {
    %>
        <tr class="error"><td colspan="3">File tidak ditemukan.</td></tr>
    <% } %>
    </tbody>
</table>

<%@ include file="part/footer.jsp" %>