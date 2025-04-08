<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - BlogSphere</title>

    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

    <style>
        .center-card {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .custom-width {
            width: 100%;
            max-width: 500px;
        }
    </style>
</head>
<body class="bg-dark">
    <div class="container center-card">
        <div class="card custom-width">
            <div class="card-body">
                <h5 class="card-title"><i class="fas fa-blog"></i> BlogSphere</h5>
                <p>Create your account to get started:</p>

                <!-- Display messages (optional) -->
                <%
                    String error = request.getParameter("error");
                    String success = request.getParameter("success");
                %>

                <% if (error != null && !error.isEmpty()) { %>
                    <div class="alert alert-danger" role="alert">
                        <%= error %>
                    </div>
                <% } %>

                <% if (success != null && !success.isEmpty()) { %>
                    <div class="alert alert-success" role="alert">
                        <%= success %>
                    </div>
                <% } %>

                <!-- Registration Form -->
                <form id="frmRegister" name="frmRegister" method="POST" action="registerServlet">
                    <div class="mb-3">
                        <label for="username" class="form-label">Username:</label>
                        <input type="text" id="username" class="form-control form-control-sm bg-white" name="username" autocomplete="off" required />
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Email:</label>
                        <input type="email" id="email" class="form-control form-control-sm bg-white" name="email" autocomplete="off" required />
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Password:</label>
                        <input type="password" id="password" class="form-control form-control-sm bg-white" name="password" autocomplete="off" required />
                    </div>

                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">Confirm Password:</label>
                        <input type="password" id="confirmPassword" class="form-control form-control-sm bg-white" name="confirmPassword" autocomplete="off" required />
                    </div>

                    <button type="submit" id="btnRegister" class="btn btn-success" name="btnRegister">Register</button>
                </form>

                <div class="mt-3">
                    <small>Already have an account? <a href="login">Login Here</a></small>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
