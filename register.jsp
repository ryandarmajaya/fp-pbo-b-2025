<%@ include file="/WEB-INF/modules/load.jsp" %>
<%
    if (session.getAttribute("username") != null) {
        response.sendRedirect(request.getContextPath() + "/home.jsp");
        return;
    }

    VarUtil varUtil = new VarUtil();
    String message = null;
    String messageType = "danger";

    Db db = new Db();
    Connection con = null;
    List<RoleObject> roleList = new ArrayList<>();

    try {
        con = db.createConnection();
        Role roleModule = new Role(con);
        roleList = roleModule.list();

        if ("register".equals(request.getParameter("act"))) {
            String userParams = request.getParameter("username");
            String passParams = request.getParameter("password");
            String passConfirm = request.getParameter("confirm_password");
            int roleParam = varUtil.parseInt(request.getParameter("kode_role"));

            if (userParams == null || userParams.trim().isEmpty() ||
                passParams == null || passParams.trim().isEmpty()) {

                message = "Username and Password cannot be empty.";
            }
            else if (!passParams.equals(passConfirm)) {
                message = "Password confirmation does not match.";
            }
            else if (roleParam == 1) {
                message = "Registration as <strong>Administrator</strong> is not allowed.";
            }
            else if (roleParam == 0) {
                message = "Please select a valid role.";
            }
            else {
                User user = new User(con);

                if (user.get(userParams) != null) {
                    message = "Username <strong>" + userParams + "</strong> is already taken.";
                } else {
                    UserObject newUser = new UserObject();
                    newUser.username = userParams;
                    newUser.password = passParams;
                    newUser.kode_role = roleParam;

                    user.insert(newUser);

                    message = "Registration successful! You can now <a href='login.jsp'>Login</a>.";
                    messageType = "success";
                }
            }
        }
    } catch (Exception e) {
        message = "System Error: " + e.getMessage();
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Create Account - Academic System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

        <!-- Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom Styles -->
        <link href="assets/css/register.css" rel="stylesheet">
    </head>

    <body>

        <div class="register-card">

            <h2 class="register-title">Create Account</h2>

            <% if (message != null) { %>
                <div class="alert alert-<%=messageType%>">
                    <%=message%>
                </div>
            <% } %>

            <form method="POST" action="register.jsp">
                <input type="hidden" name="act" value="register" />

                <div class="mb-3">
                    <label class="fw-semibold">Username</label>
                    <input type="text" name="username" class="form-control" placeholder="Choose a username" required>
                </div>

                <div class="mb-3">
                    <label class="fw-semibold">Password</label>
                    <input type="password" name="password" class="form-control" placeholder="Create a password" required>
                </div>

                <div class="mb-3">
                    <label class="fw-semibold">Confirm Password</label>
                    <input type="password" name="confirm_password" class="form-control" placeholder="Repeat password" required>
                </div>

                <div class="mb-3">
                    <label class="fw-semibold">Register As</label>
                    <select name="kode_role" class="form-select">
                        <% for (RoleObject role : roleList) {
                            if (role.kode == 1) continue; %>
                            <option value="<%=role.kode%>"><%=role.nama%></option>
                        <% } %>
                    </select>
                </div>

                <button class="btn btn-success btn-custom" type="submit">Register</button>

                <div class="small-links">
                    Already have an account? <a href="login.jsp">Sign In</a> <br>
                    <a href="index.jsp">Back to Home</a>
                </div>
            </form>

        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>

<%
    if (con != null) try { con.close(); } catch(Exception e){}
%>
