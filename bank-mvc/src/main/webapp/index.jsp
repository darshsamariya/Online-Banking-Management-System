<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<script type="text/javascript">
$(".link").click(function(e) {
    e.preventDefault();
    $('.content-container div').fadeOut('slow');
    $('#' + $(this).data('rel')).fadeIn('slow');
});
</script>
<body>
<h2>Hello World!</h2>
<a class="link" href="#" data-rel="content1">Link 3</a>
<a class="link" href="#" data-rel="content2">Link 4</a>
<a class="link" href="#" data-rel="content3">Link 5</a>
<a class="link" href="#" data-rel="content4">Link 6</a>
<a class="link" href="#" data-rel="content5">Link 7</a>

<div class="content-container">
    <div id="content3">This is the test content for part 3</div>
    <div id="content4">This is the test content for part 4</div>
    <div id="content5">This is the test content for part 5</div>
    <div id="content6">This is the test content for part 6</div>
    <div id="content7">This is the test content for part 7</div>
</div>
<div id="myGroup">
    <button class="btn dropdown" data-toggle="collapse" data-target="#keys" data-parent="#myGroup"><i class="icon-chevron-right"></i> Keys  <span class="badge badge-info pull-right">X</span></button>
    <button class="btn dropdown" data-toggle="collapse" data-target="#attrs" data-parent="#myGroup"><i class="icon-chevron-right"></i> Attributes</button>
    <button class="btn dropdown" data-toggle="collapse" data-target="#edit" data-parent="#myGroup"><i class="icon-chevron-right"></i> Edit Details</button>

 
</div>
   <div class="accordion-group">
        <div class="collapse indent" id="keys">
            keys
        </div>

        <div class="collapse indent" id="attrs">
            attrs
        </div>

        <div class="collapse" id="edit">
            edit
        </div>
    </div>
</body>

<script>
jQuery('button').click( function(e) {
    jQuery('.collapse').collapse('hide');
});
</script>
</html>
  <div class="row my-5" *ngIf="temp=='dashboard'">
                    <h3 class="fs-4 mb-3">Recent Transaction</h3>


                    <div class="col">

                        <table mat-table [dataSource]="dataSource" class="mat-elevation-z8" class="table bg-white rounded shadow-sm  table-hover">
                            <ng-container matColumnDef="name">
                                <th mat-header-cell *matHeaderCellDef> Name. </th>
                                <td mat-cell *matCellDef="let element"> {{element.name}} </td>
                            </ng-container>

                            <!-- Name Column -->
                            <ng-container matColumnDef="age">
                                <th mat-header-cell *matHeaderCellDef> Age. </th>
                                <td mat-cell *matCellDef="let element"> {{element.age}} </td>
                            </ng-container>

                            <!-- Weight Column -->
                            <ng-container matColumnDef="subject">
                                <th mat-header-cell *matHeaderCellDef>Subject. </th>
                                <td mat-cell *matCellDef="let element"> {{element.subject}} </td>
                            </ng-container>

                            <!-- Symbol Column -->
                            <ng-container matColumnDef="country">
                                <th mat-header-cell *matHeaderCellDef> Country. </th>
                                <td mat-cell *matCellDef="let element"> {{element.country}} </td>
                            </ng-container>

                            <tr mat-header-row *matHeaderRowDef="displayedColumns"></tr>
                            <tr mat-row *matRowDef="let row; columns: displayedColumns;"></tr>



                        </table>
                    </div>
                </div>
                
                
                
                
                
                
                
                
                 <div class="row my-5" *ngIf="temp=='fundtransfer'">
                    <h3 class="fs-4 mb-3">Recent Orders</h3>
                    <div class="col">
                        <table class="table bg-white rounded shadow-sm  table-hover">
                            <thead>
                                <tr>
                                    <th scope="col" width="50">#</th>
                                    <th scope="col">Product</th>
                                    <th scope="col">Customer</th>
                                    <th scope="col">Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th scope="row">1</th>
                                    <td>Television</td>
                                    <td>Jonny</td>
                                    <td>$1200</td>
                                </tr>
                                <tr>
                                    <th scope="row">2</th>
                                    <td>Laptop</td>
                                    <td>Kenny</td>
                                    <td>$750</td>
                                </tr>
                                <tr>
                                    <th scope="row">3</th>
                                    <td>Cell Phone</td>
                                    <td>Jenny</td>
                                    <td>$600</td>
                                </tr>
                                <tr>
                                    <th scope="row">4</th>
                                    <td>Fridge</td>
                                    <td>Killy</td>
                                    <td>$300</td>
                                </tr>
                                <tr>
                                    <th scope="row">5</th>
                                    <td>Books</td>
                                    <td>Filly</td>
                                    <td>$120</td>
                                </tr>
                                <tr>
                                    <th scope="row">6</th>
                                    <td>Gold</td>
                                    <td>Bumbo</td>
                                    <td>$1800</td>
                                </tr>
                                <tr>
                                    <th scope="row">7</th>
                                    <td>Pen</td>
                                    <td>Bilbo</td>
                                    <td>$75</td>
                                </tr>
                                <tr>
                                    <th scope="row">8</th>
                                    <td>Notebook</td>
                                    <td>Frodo</td>
                                    <td>$36</td>
                                </tr>
                                <tr>
                                    <th scope="row">9</th>
                                    <td>Dress</td>
                                    <td>Kimo</td>
                                    <td>$255</td>
                                </tr>
                                <tr>
                                    <th scope="row">10</th>
                                    <td>Paint</td>
                                    <td>Zico</td>
                                    <td>$434</td>
                                </tr>
                                <tr>
                                    <th scope="row">11</th>
                                    <td>Carpet</td>
                                    <td>Jeco</td>
                                    <td>$1236</td>
                                </tr>
                                <tr>
                                    <th scope="row">12</th>
                                    <td>Food</td>
                                    <td>Haso</td>
                                    <td>$422</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                
                
                
                
                
                
                
                
                
                
                
                 <div class="row my-5" *ngIf="temp=='mydetails'">
                    <h3 class="fs-4 mb-3">My details</h3>
                    <section class="vh-180" style="background-color: #f4f5f7;">
                        <div class="container py-5 h-100">
                            <div class="row d-flex justify-content-center align-items-center h-190">
                                <div class="col col-lg-6 mb-4 mb-lg-0">
                                    <div class="card mb-3" style="border-radius: .5rem;">
                                        <div class="row g-0">
                                            <div class="col-md-4 gradient-custom text-center text-white" style="border-top-left-radius: .5rem; border-bottom-left-radius: .5rem;">
                                                <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava3.webp" alt="Avatar" class="img-fluid my-5" style="width: 80px;" />
                                                <h5 style="color:black">Darsh Samariya</h5>
                                                <p style="color:black">Savings Account</p>
                                                <i class="far fa-edit mb-5"></i>
                                            </div>
                                            <div class="col-md-8">
                                                <div class="card-body p-4">
                                                    <h6>Information</h6>
                                                    <hr class="mt-0 mb-4">
                                                    <div class="row pt-1">
                                                        <div class="col-6 mb-3">
                                                            <h6>Account No</h6>
                                                            <p class="text-muted">9010052</p>
                                                        </div>
                                                        <div class="col-6 mb-3">
                                                            <h6>Email</h6>
                                                            <p class="text-muted">info@example.com</p>
                                                        </div>
                                                        <div class="col-6 mb-3">
                                                            <h6>Phone</h6>
                                                            <p class="text-muted">123 456 789</p>
                                                        </div>
                                                        <div class="col-6 mb-3">
                                                            <h6>Address</h6>
                                                            <p class="text-muted">mall road</p>
                                                        </div>


                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>

