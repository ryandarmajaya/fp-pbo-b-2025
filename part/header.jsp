<%@ include file="/WEB-INF/includes/cek-session.jsp" %>
<%@ include file="/WEB-INF/modules/load.jsp" %>

<%
    String basePath = request.getContextPath();

    String username = (String) session.getAttribute("username");
    Db db = new Db();

    Connection con = db.createConnection();

    VarUtil varUtil = new VarUtil();
    JenisKelamin jenisKelamin = new JenisKelamin(con);
    Jenjang jenjang = new Jenjang(con);
    Role role = new Role(con);
    User user = new User(con);
    Prodi prodi = new Prodi(con);
    Mahasiswa mahasiswa = new Mahasiswa(con);

    UserObject userLogin = user.get(username);
    RoleObject roleLogin = role.get(userLogin.kode_role);
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Academic System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="<%=basePath%>/assets/css/bootstrap.css" rel="stylesheet">
        <link href="<%=basePath%>/assets/css/bootstrap-responsive.css" rel="stylesheet">
        
        <!-- FontAwesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <!-- Custom Styles -->
        <link href="<%=basePath%>/assets/css/main.css" rel="stylesheet">
    </head>

    <body>

        <div class="navbar navbar-inverse navbar-fixed-top">
          <div class="navbar-inner">
            <div class="container">

              <!-- Toggle for mobile -->
              <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>

              <!-- Brand -->
              <a class="brand" href="<%=basePath%>/home.jsp">Academic System</a>

              <!-- Navigation -->
              <div class="nav-collapse collapse">
                <ul class="nav pull-right">

                  <li><a href="<%=basePath%>/home.jsp">Home</a></li>
                  <li><a href="<%=basePath%>/role.jsp">Role</a></li>
                  <li><a href="<%=basePath%>/jenis-kelamin.jsp">Jenis Kelamin</a></li>
                  <li><a href="<%=basePath%>/jenjang.jsp">Jenjang</a></li>
                  <li><a href="<%=basePath%>/prodi.jsp">Prodi</a></li>
                  <li><a href="<%=basePath%>/user.jsp">User</a></li>
                  <li><a href="<%=basePath%>/mahasiswa.jsp">Mahasiswa</a></li>

                  <li><a class="text-danger" href="<%=basePath%>/logout.jsp">Logout</a></li>

                </ul>
              </div>

            </div>
          </div>
        </div>

        <div class="container content-wrapper">