<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <title>Admin</title>
    </head>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
        }

        .modal-content {
            background-color: #fff;
            border-radius: 10px;
        }

        .modal-header {
            background-color: #f1b0b7;
            color: #fff;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            padding: 15px;
        }

        .modal-header .modal-title {
            margin: 0;
            font-weight: bold;
        }

        .modal-body {
            padding: 15px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            font-weight: bold;
            color: #333;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .modal-footer {
            padding: 15px;
            background-color: #f8f9fa;
            border-bottom-left-radius: 10px;
            border-bottom-right-radius: 10px;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn-default {
            background-color: #f1b0b7;
            color: #fff;
            border: none;
        }

        .btn-info {
            background-color: #f1b0b7;
            color: #fff;
            border: none;
        }
    </style>
    <body>
        <div class="modal-content" >
            <form action="edit" method="post">
                <div class="modal-header" ">						
                    <h4 class="modal-title">Edit Product</h4>
                </div>
                <div class="modal-body">					
                    <div class="form-group">
                        <label>Name</label>
                        <input type="text" value="${o.name}" name="name" class="form-control" placeholder="Name" required>
                        <input type="text" hidden value="${o.id}" name="id" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Image</label>
                        <input type="text" value="${o.image}" name="image" class="form-control" placeholder="Image" required>
                    </div>
                    <div class="form-group">
                        <label for="brand">Brand</label>
                        <select name="brand" id="brand" class="form-control">
                            <c:forEach var="o" items="${brand}">
                                <option ${o.id==o.id?'selected':''} value="${o.id}">${o.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="category">Category</label>
                        <select name="category" id="category" class="form-control">
                            <c:forEach var="o" items="${category}">
                                <option ${o.id==o.id?'selected':''}  value="${o.id}">${o.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Price</label>
                        <input type="text" value="${o.price}" name="price" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Stock</label>
                        <input type="text" value="${o.stock}" name="stock" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Description</label>
                        <input name="description" value="${o.description}" class="form-control" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="submit" class="btn btn-default" data-dismiss="modal" value="Cancel">
                    <input type="submit" class="btn btn-info" value="Save">
                </div>
            </form>
        </div>
    </body>
</html>
