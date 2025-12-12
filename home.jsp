<%@ include file="part/header.jsp" %>

<div class="container content-wrapper">

    <!-- HERO -->
    <div class="home-hero">
        <h1>Welcome, <%= userLogin.username %></h1>
        <p class="subtext">
            This is your Academic Information System Dashboard.<br>
            Manage academic data quickly and efficiently.
        </p>

        <div class="hero-buttons">
            <a href="mahasiswa.jsp" class="btn btn-primary btn-large">Manage Mahasiswa</a>
            <a href="prodi.jsp" class="btn btn-info btn-large">View Prodi</a>
        </div>
    </div>

    <!-- 3 Feature Boxes -->
    <div class="row">

        <div class="span4">
            <div class="home-box">
                <h4>User Profile</h4>

                <p class="title">Logged in as:</p>
                <p class="value"><%= username %></p>

                <p class="title">Role:</p>
                <span class="badge badge-success"><%= roleLogin.nama %></span>
            </div>
        </div>

        <div class="span4">
            <div class="home-box">
                <h4>System Status</h4>
                <p class="text-muted">
                    System is running normally.<br>
                    All modules operational.
                </p>
            </div>
        </div>

        <div class="span4">
            <div class="home-box">
                <h4>Help & Support</h4>
                <p class="text-muted">
                    Contact the administrator if you encounter difficulties.
                </p>
                <a href="#" class="btn btn-support">Contact Support</a>
            </div>
        </div>

    </div>

</div>

<%@ include file="part/footer.jsp" %>
