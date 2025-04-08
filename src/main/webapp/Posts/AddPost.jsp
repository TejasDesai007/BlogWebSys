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
    <title>Add Post - BlogSphere</title>

    <!-- Bootstrap 5.3.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet"
          integrity="sha384-jLKHWM+4+lU0LM0Wm5IcOjf5MjG3PB3rzBQyk7r3DjfYel2XmKZ5FEmfAxOWiG6U" crossorigin="anonymous">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"
            integrity="sha384-UG8ao2jwOWB7/oDdObZc6ItJmwUkR/PfMyt9Qs5AwX7PsnYn1CRKCTWyncPTWvaS" crossorigin="anonymous"></script>

    <style>
        .center-card {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .custom-width {
            width: 100%;
            max-width: 600px;
        }
    </style>
</head>
<body class="bg-dark">

    <div class="container center-card">
        <div class="card custom-width">
            <div class="card-body">
                <h5 class="card-title"><i class="fas fa-pen"></i> Add New Post</h5>
                <p>Create your blog post below:</p>

                <form method="POST" action="/addPost">
                    <div class="mb-3">
                        <label for="postTitle" class="form-label">Post Title:</label>
                        <input type="text" id="postTitle" name="postTitle" class="form-control bg-white" required />
                    </div>

                    <div class="mb-3">
                        <label for="postContent" class="form-label">Post Content:</label>
                        <textarea id="postContent" name="postContent" class="form-control bg-white" rows="6" required></textarea>
                    </div>

                    <button type="submit" class="btn btn-success"><i class="fas fa-upload"></i> Submit Post</button>
                    <a href="../index.jsp" class="btn btn-secondary ms-2"><i class="fas fa-arrow-left"></i> Back</a>
                </form>
            </div>
        </div>
    </div>

</body>
</html>
