<%@ include file="part/header.jsp" %>
<%
if ( userLogin.kode_role > 3 ) {
    response.sendRedirect(request.getContextPath() + "/error-hak-akses.jsp");
    return;
}

String file = request.getParameter("file");

if ( file == null ) {
    response.sendRedirect(request.getContextPath() + "/error-hak-akses.jsp");
    return;
}
%>

<meta http-equiv="refresh" content="3; url=<%=request.getContextPath()%>/mahasiswa-import-proses.jsp?file=<%=file%>" />

<div class="row" style="margin-top: 50px; text-align: center;">
    <div class="span12">
        <h1>Sedang Memproses Data...</h1>
        <p class="lead">Mohon tunggu sebentar, jangan tutup halaman ini.</p>
        <br/>
        <img src="<%=request.getContextPath()%>/assets/img/loading.gif" alt="Loading..." />
        <br/><br/>
        <p>Sistem sedang membaca file CSV dan memasukkan data ke database.</p>
    </div>
</div>

<%@ include file="part/footer.jsp" %>