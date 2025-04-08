<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    public String isBlankNull(String str) {
        return (str == null || str.trim().isEmpty()) ? "" : str;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - BlogSphere</title>

    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

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
                <p>Welcome to BlogSphere! Enter your credentials:</p>

                <form id="frmLoginCrdt" name="frmLoginCrdt" method="POST" action="/login">
                    <div class="mb-3">
                        <label for="txtUserNm" class="form-label">User Name:</label>
                        <input type="text" id="txtUserNm" class="form-control form-control-sm bg-white" name="txtUserNm" autocomplete="off" required />
                    </div>

                    <div class="mb-3">
                        <label for="txtPassword" class="form-label">Password:</label>
                        <input type="password" id="txtPassword" class="form-control form-control-sm bg-white" name="txtPassword" autocomplete="off" required />
                    </div>

                    <button type="submit" id="btnLogin" class="btn btn-success" name="btnLogin">Proceed</button>
                </form>

                <div class="mt-3">
                    <small>Don't have an account? <a href="Register.jsp">Register Here</a></small>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
