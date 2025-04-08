<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.bson.Document" %>
<%@ page import="com.mongodb.client.MongoDatabase" %>
<%@ page import="com.mongodb.client.MongoCollection" %>
<%@ page import="com.mongodb.client.MongoCursor" %>
<%@ page import="org.bson.types.ObjectId" %>
<%@ page import="com.mongodb.client.model.Filters" %>
<%@ page import="com.DBConnection" %>
<%@ page import="org.bson.conversions.Bson" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home - Blog</title>
    <link href="style/css/bootstrap.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
          crossorigin="anonymous">
    <style>
        .card {
            margin-bottom: 20px;
        }

        .carousel-inner img {
            max-height: 300px;
            object-fit: cover;
        }
    </style>
    <jsp:include page="include/menu.jsp" />
</head>
<body class="bg-light">
<div class="container">
    <h1 class="my-4 text-center"><i class="fas fa-blog"></i> Blog Home</h1>

    <!-- Search Box -->
    <div class="mb-4">
        <input type="text" id="searchInput" class="form-control" placeholder="Search posts...">
    </div>

    <div class="row" id="postContainer">
        <%
            String strUserId = (session.getAttribute("UserId") != null) ? session.getAttribute("UserId").toString() : "";
            String strUsername = (session.getAttribute("Username") != null) ? session.getAttribute("Username").toString() : "Guest";

            MongoDatabase db = new DBConnection().getConnection();

            try {
                MongoCollection<Document> postsCol = db.getCollection("Posts");
                MongoCollection<Document> usersCol = db.getCollection("Users");
                MongoCollection<Document> imgCol = db.getCollection("PostImages");

                Bson filter = Filters.eq("IsPublished", true);
                MongoCursor<Document> cursor = postsCol.find(filter).sort(new Document("PublishedAt", -1)).iterator();

                while (cursor.hasNext()) {
                    Document post = cursor.next();
                    ObjectId postID = post.getObjectId("_id");
                    String title = post.getString("Title");
                    String content = post.getString("Content");
                    String publishedAt = post.getString("PublishedAt");
                    String postUserId = post.getString("UserID");

                    Document userDoc = usersCol.find(Filters.eq("_id", new ObjectId(postUserId))).first();
                    String userName = (userDoc != null) ? userDoc.getString("UserName") : "Unknown";

                    List<Document> images = imgCol.find(Filters.eq("PostID", postID.toHexString())).into(new java.util.ArrayList<>());
        %>
        <div class="col-md-6 post-card" data-title="<%= title.toLowerCase() %>" data-content="<%= content.toLowerCase() %>">
            <div class="card">
                <div id="carousel<%= postID %>" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <%
                            boolean isFirst = true;
                            for (Document imgDoc : images) {
                                String imagePath = imgDoc.getString("ImagePath");
                        %>
                        <div class="carousel-item <%= isFirst ? "active" : "" %>">
                            <img src="<%= imagePath %>" class="d-block w-100" alt="Post Image">
                        </div>
                        <%
                                isFirst = false;
                            }
                        %>
                    </div>
                    <a class="carousel-control-prev" href="#carousel<%= postID %>" role="button" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#carousel<%= postID %>" role="button" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </a>
                </div>
                <div class="card-body">
                    <h5 class="card-title"><%= title %></h5>
                    <h6 class="card-subtitle mb-2 text-muted">By <%= userName %> on <%= publishedAt %></h6>
                    <p class="card-text"><%= content.length() > 150 ? content.substring(0, 150) + "..." : content %></p>
                    <a href="viewPost?postID=<%= postID.toHexString() %>" class="card-link">Read More</a>
                    <% if (strUserId.equals(postUserId)) { %>
                        <a href="DeleteBlog?postID=<%= postID.toHexString() %>" class="card-link text-danger">
                            <i class="fas fa-trash-alt"></i> Delete</a>
                    <% } %>
                    <button class="btn btn-light like-btn" data-postid="<%= postID.toHexString() %>">
                        <i class="far fa-heart"></i>
                    </button>
                </div>
            </div>
        </div>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    $(document).ready(function () {
        $('#searchInput').on('input', function () {
            const query = $(this).val().toLowerCase();
            $('.post-card').each(function () {
                const title = $(this).data('title');
                const content = $(this).data('content');
                if (title.includes(query) || content.includes(query)) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        });

        $('.like-btn').on('click', function () {
            const heartIcon = $(this).find('i');
            heartIcon.toggleClass('far fa-heart fas fa-heart');
            $(this).toggleClass('text-danger', heartIcon.hasClass('fas'));
        });
    });
</script>
</body>
</html>
