<%@ include file="/WEB-INF/modules/load.jsp" %>
<%
    String act = request.getParameter("act");
    boolean isLogin = false;
    String message = null;

    if ("login".equals(act)) {

        Db db = new Db();
        Connection con = db.createConnection();
        User user = new User(con);
        UserLogin ul = new UserLogin();

        ul.username = request.getParameter("username");
        ul.password = request.getParameter("password");

        message = "Login Failed. Please check Username and Password.";

        try {
            isLogin = user.login(ul);
        } catch (Exception e) {
            message = "System Error: " + e.getMessage();
        } finally {
            if (con != null) con.close();
        }

        if (isLogin) {
            session.setAttribute("username", ul.username);
            response.sendRedirect(request.getContextPath() + "/home.jsp");
            return;
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Sign in - Academic System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

        <!-- Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom Styles -->
        <link href="assets/css/login.css" rel="stylesheet">
    </head>

    <body>

        <div class="login-card">

            <h2 class="login-title">Sign In</h2>

            <% if (message != null) { %>
                <div class="alert alert-danger text-start">
                    <strong>Failed!</strong> <%= message %>
                </div>
            <% } %>

            <form method="POST" action="login.jsp">
                <input type="hidden" name="act" value="login" />

                <div class="mb-3 text-start">
                    <label class="form-label fw-semibold">Username</label>
                    <input type="text" name="username" class="form-control" placeholder="Enter username" required>
                </div>

                <div class="mb-3 text-start">
                    <label class="form-label fw-semibold">Password</label>
                    <input type="password" name="password" class="form-control" placeholder="Enter password" required>
                </div>

                <button class="btn btn-primary mt-2" type="submit">Sign In</button>

                <div class="mt-3 small-links">
                    Don't have an account? <a href="register.jsp">Register</a><br>
                    <a href="index.jsp">Back to Home</a>
                </div>
            </form>

        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
