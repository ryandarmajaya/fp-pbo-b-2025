<%@ include file="/WEB-INF/modules/load.jsp" %>
<%
    if ( session.getAttribute("username") != null ) {
        response.sendRedirect(request.getContextPath() + "/home.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Welcome - Academic System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

        <!-- Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom Styles -->
        <link href="assets/css/welcome.css" rel="stylesheet">
    </head>

    <body>

        <!-- NAVBAR -->
        <nav class="navbar navbar-expand-lg navbar-custom shadow-sm">
            <div class="container">
                <a class="navbar-brand" href="#">Academic System</a>
            </div>
        </nav>

        <!-- HERO SECTION -->
        <div class="hero-section mt-5">
            <div class="hero-box">
                <h1>Welcome to AIS</h1>
                <p class="lead mt-3">
                    Manage Students, Academic Data, and Study Programs efficiently.<br>
                    Please sign in to continue or create a new account.
                </p>

                <div class="mt-4">
                    <a href="login.jsp" class="btn btn-primary btn-lg px-4 me-2">
                        Sign In
                    </a>

                    <a href="register.jsp" class="btn btn-success btn-lg px-4">
                        Register Now
                    </a>
                </div>
            </div>
        </div>

        <!-- FEATURES -->
        <div class="container mb-5">
            <div class="row g-4">

                <div class="col-md-4">
                    <div class="feature-box text-center">
                        <h4 class="fw-semibold">Data Management</h4>
                        <p class="mt-2">Manage student data, import/export CSV, and maintain academic information easily.</p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="feature-box text-center">
                        <h4 class="fw-semibold">Secure Access</h4>
                        <p class="mt-2">Role-based access control ensures data security for all users.</p>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="feature-box text-center">
                        <h4 class="fw-semibold">Easy to Use</h4>
                        <p class="mt-2">Responsive layout designed for both desktop and mobile devices.</p>
                    </div>
                </div>

            </div>
        </div>

        <!-- FOOTER -->
        <footer>
            &copy; Object Oriented Programming B 2025 - Academic Information System
        </footer>

        <!-- BOOTSTRAP SCRIPT -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
