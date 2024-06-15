<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/cssorder.css" rel="stylesheet" type="text/css"/>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" rel="stylesheet"/>
    </head>
    <body>
        <div class="wrapper">
            <div class="d-flex align-items-center justify-content-between">
                <div class="d-flex flex-column">
                    <div class="h3">Your Orders</div>
                    <div class="text-uppercase">6 sublists</div>
                </div>
                <div class="ml-auto btn"><span class="fas fa-cog"></span></div>
                <div class="btn" id="sub">
                    + Add sublist
                </div>
            </div>
            <div class="notification alert alert-dismissible fade show text-white d-flex align-items-center my-3 text-justify"
                 role="alert">
                <span class="far fa-bell pr-2"></span>
                You've got 3 new items on your list and 7 new comments check it out!
                <button type="button" class="close text-white ml-auto" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">
                        Ok, Thanks
                    </span>
                </button>
            </div>
            <div id="table" class="bg-white rounded">
                <div class="d-md-flex align-items-md-center px-3 pt-3">
                    <div class="d-flex flex-column">
                        <div class="h4 font-weight-bold">Wedding lists</div>
                        <div class="text-muted">400 items</div>
                    </div>
                    <div class="ml-auto d-flex align-items-center">
                        <div class="editors">
                            <img src="https://images.unsplash.com/photo-1509967419530-da38b4704bc6?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NXx8ZmFjZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
                                 id="img1" alt="">
                            <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZmFjZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
                                 id="img2" alt="">
                            <img src="https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80"
                                 id="img3" alt="">
                        </div>
                        <div class="text-muted pl-md-0 pl-5">
                            + 7 editors
                        </div>
                    </div>
                </div>
                <hr>
                <div class="table-responsive">
                    <table class="table activitites">
                        <thead>
                            <tr>
                                <th scope="col" class="text-uppercase header">item</th>
                                <th scope="col" class="text-uppercase">Quantity</th>
                                <th scope="col" class="text-uppercase">price each</th>
                                <th scope="col" class="text-uppercase">total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="item">
                                    <div class="d-flex">
                                        <img src="https://images.unsplash.com/photo-1601479604588-68d9e6d386b5?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8Y2FuZGxlc3xlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
                                             alt="">
                                        <div class="pl-2">
                                            <span style="font-family: 'Times New Roman', Times, serif;">Suspended Heart Candles</span>
                                            <div class="text-uppercase new"><span class="fas fa-star"></span>new</div>
                                            <div class="d-flex flex-column justify-content-center">
                                                <div class="text-muted">Blue</div>
                                                <div><a href="#"><span class="red text-uppercase"><span
                                                                class="fas fa-comment pr-1"></span>add a comment</span></a>
                                                </div>
                                            </div>
                                        </div>
                                </td>
                                <td>120</td>
                                <td class="d-flex flex-column"><span class="red">$21.40</span>
                                    <del class="cross">$30.00</del>
                                </td>
                                <td class="font-weight-bold">
                                    $249
                                    <div class="close">&times;</div>
                                    <button class="d-flex justify-content-end btn border">+ Add to cart</button>
                                </td>
                            </tr>
                            <tr>
                                <td class="item">
                                    <div class="d-flex align-items-start">
                                        <img src="https://www.freepnglogos.com/uploads/corona-png-logo/corona-bottle-transparent-png-logo-27.png"
                                             alt="">
                                        <div>
                                            Wine Bottle Shaped in Gift Base
                                            <div class="text-uppercase new"><span class="fas fa-star"></span>new</div>
                                            <div>
                                                <a href="#">
                                                    <span class="red text-uppercase">
                                                        <span class="fas fa-comment pr-1"></span>
                                                        add a comment
                                                    </span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>120</td>
                                <td class="d-flex flex-column">$21.40
                                </td>
                                <td class="font-weight-bold">
                                    $249
                                    <div class="close">&times;</div>
                                    <button class="d-flex justify-content-end align-items-end btn border">+ Add to
                                        cart</button>
                                </td>
                            </tr>
                            <tr>
                                <td class="item">
                                    <div class="d-flex align-items-start">
                                        <img src="https://www.freepnglogos.com/uploads/corona-png-logo/corona-bottle-transparent-png-logo-27.png"
                                             alt="">
                                        <div>
                                            Copper Moscow Mug
                                            <div class="text-uppercase new"><span class="fas fa-star"></span>new</div>
                                            <div class="d-flex flex-column justify-content-center">
                                                <div class="text-muted">Blue/Mute</div>
                                                <div><a href="#"><span class="red text-uppercase"><span
                                                                class="fas fa-comment pr-1"></span>add a comment</span></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>120</td>
                                <td class="d-flex flex-column">$21.40
                                </td>
                                <td class="font-weight-bold">
                                    $249
                                    <div class="close">&times;</div>
                                    <button class="d-flex justify-content-end btn border">+ Add to cart</button>
                                </td>
                            </tr>
                            <tr>
                                <td class="item">
                                    <div class="d-flex align-items-start">
                                        <img src="https://www.freepnglogos.com/uploads/corona-png-logo/corona-bottle-transparent-png-logo-27.png"
                                             alt="">
                                        <div>
                                            Wine Bottle Shaped in Gift Base
                                            <div class="d-md-flex align-items-md-center">
                                                <div class="editors">
                                                    <img src="https://images.unsplash.com/photo-1509967419530-da38b4704bc6?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NXx8ZmFjZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
                                                         id="commentor1" alt="">
                                                    <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZmFjZXxl
