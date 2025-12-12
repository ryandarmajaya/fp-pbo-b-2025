<%@ page contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/includes/cek-session.jsp" %>
<%@ include file="/WEB-INF/modules/load.jsp" %>
<%
    String roleStr = (String) session.getAttribute("username"); 

    String fileName = "data_mahasiswa.csv";
    String delimiter = ",";

    Db db = new Db();
    Connection con = db.createConnection();

    response.setContentType("application/force-download");
    response.setContentLength(-1);
    response.setHeader("Content-Transfer-Encoding", "binary");
    response.setHeader("Content-Disposition","attachment; filename=\""+fileName+"\"");

    try {
        MahasiswaObject mo = new MahasiswaObject();
        String[] header = mo.header();

        for(int i=0; i<header.length; i++){
            out.print(header[i]);
            if ( i != header.length -1 ) out.print(delimiter);
        }
        out.println();

        Mahasiswa m = new Mahasiswa(con);
        List<MahasiswaObject> daftar = m.list();

        for(MahasiswaObject mObj : daftar){
            out.print(mObj.nim + delimiter);
            out.print("\"" + mObj.nama + "\"" + delimiter);
            out.print(mObj.kode_jenis_kelamin + delimiter);
            out.print(mObj.kode_prodi + delimiter);
            out.print(mObj.username);
            out.println();
        }
    } catch(Exception e) {
        out.println("ERROR: " + e.getMessage());
    } finally {
        if(con != null) con.close();
    }
%>