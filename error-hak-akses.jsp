<%@ include file="part/header.jsp" %>

<div class="hero-unit" style="background-color: #f2dede; border-color: #eed3d7; color: #b94a48;">
      <h1 style="color: #b94a48;">Akses Ditolak!</h1>
      <p style="margin-top: 20px;">
            Halo <strong><%=userLogin.username%></strong>,<br>
            Anda terdaftar dengan role: <strong><%=roleLogin.nama%></strong>.
      </p>
      <p>
            Maaf, Anda tidak memiliki izin untuk mengakses halaman ini.
      </p>
      <p style="margin-top: 30px;">
            <a href="home.jsp" class="btn btn-danger btn-large">Kembali ke Dashboard</a>
      </p>
</div>

<%@ include file="part/footer.jsp" %>