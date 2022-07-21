<%@page import="org.springframework.web.servlet.ModelAndView"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@page isELIgnored="false" %>
        <%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Dashboard</title>
<style><%@include file="/WEB-INF/css/styledash.css"%></style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
</head>
<body onload="load()">
<div>
    <div class="d-flex" id="wrapper">
        <!-- Sidebar -->
        <div class="bg-white" id="sidebar-wrapper">
            <img src="https://zeevector.com/wp-content/uploads/TVS-Credit-Logo-PNG.png" style="margin-left: 40px; margin-top: 10px;" height="40px" width="150px">
        
            <div class="list-group list-group-flush my-3">
          <a href="#" class="tab-link" data-div="div-one">     <button class="btn dropdown  list-group-item list-group-item-action bg-transparent second-text fw-bold" ><i
                        class="fas fa-tachometer-alt me-2"></i><i class="bi-house-door-fill"></i>Dashboard</button></a>
           <a href="#" class="tab-link" data-div="div-two">     <button class="btn dropdown  list-group-item list-group-item-action bg-transparent second-text fw-bold" data-toggle="collapse" data-target="#fundtransfer" data-parent="#myGroup"><i
                        class="fas fa-project-diagram me-2"></i><i class="bi-cash-coin"></i>Fund Transfer</button></a>
          <a href="#" class="tab-link" data-div="div-three">      <button class="btn dropdown list-group-item list-group-item-action bg-transparent second-text fw-bold" data-toggle="collapse" data-target="#attrs" data-parent="#myGroup"><i
                        class="fas fa-chart-line me-2"></i><i class="bi-table"></i>View Statement</button></a>
             <a  href="#" class="tab-link" data-div="div-four">   <button class="btn dropdown list-group-item list-group-item-action bg-transparent second-text fw-bold" data-toggle="collapse" data-target="#attrs" data-parent="#myGroup"><i
                        class="fas fa-paperclip me-2"></i><i class="bi-person-circle"></i>My Details</button></a>
               <a> <button class="btn dropdown list-group-item list-group-item-action bg-transparent second-text fw-bold" data-toggle="collapse" data-target="#attrs" data-parent="#myGroup"><i
                        class="fas fa-shopping-cart me-2"></i><i class="bi-chat-dots-fill"></i>Support</button></a>
                <a> <button class="btn dropdown  list-group-item list-group-item-action bg-transparent second-text fw-bold" data-toggle="collapse" data-target="#attrs" data-parent="#myGroup"><i
                        class="fas fa-gift me-2"></i><i class="bi-gear-fill"></i>Settings</button></a>
               <a href="logout"> <button class="btn dropdown list-group-item list-group-item-action bg-transparent text-primary fw-bold" data-toggle="collapse" data-target="#attrs" data-parent="#myGroup"><i
                        class="fas fa-power-off me-2"></i><i class="bi-box-arrow-right"></i>Logout</button></a>

            </div>
        </div>
        <!-- /#sidebar-wrapper -->

        <!-- Page Content -->
        <div id="page-content-wrapper">
            <nav class="navbar navbar-expand-lg navbar-light bg-transparent py-4 px-4">
                <div class="d-flex align-items-center">
                    <i class="fas fa-align-left primary-text fs-4 me-3" id="menu-toggle"></i>
                    <h2 class="fs-2 m-0">Welcome ${u.firstname}</h2>
                </div>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle second-text fw-bold" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-user me-2"></i>${u.firstname}
                            </a>

                        </li>
                    </ul>
                </div>
            </nav>

            <div class="container-fluid px-4" id="java">
                <div class="row g-3 my-2">
                    <div class="col-md-3">
                        <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                            <div>
                                <h3 class="fs-2">${u.balance}</h3>
                                <p class="fs-5">Account balance</p>
                            </div>
                       <i style="transform:scale(1.8)" class="bi-cash-coin"></i>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                            <div style="cursor: pointer;" class="tab-link" data-div="div-five">
                                <h3 class="fs-2">Apply</h3>
                                <p class="fs-5">For Loans</p>
                            </div>
                       <i style="transform:scale(1.8)" class="bi-box-arrow-in-down-right"> </i>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                            <div>
                                <h3 class="fs-2">7%</h3>
                                <p class="fs-5">Interest</p>
                            </div>
                            <i style="transform:scale(1.8)" class="bi-arrow-up-right-square"></i>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                            <div>
                                <h3 class="fs-2">New</h3>
                                <p class="fs-5">Offers</p>
                            </div>
                         <i style="transform:scale(1.8)" class="bi-bookmark-heart-fill"></i>
                        </div>
                    </div>
                </div>
                 <div class="row my-5 div-one content ">
                           <%
           String m=(String)session.getAttribute("fund");
           if(m==null)
           {
        	   m="";
           }
           else
           {
        	   session.removeAttribute("fund");
           }
           %>
           <h3> <%=m %></h3>

            </div>
                
                <!-- --------------------------------------------------Two -->
                 <div class="row my-5 div-two content ">
                   <div class="container p-0">
        <div class="card px-4">
            <p class="h8 py-3">Fund Transfer </p>
 
               <div id="error_message"></div>
            <form action="transfer" method="post">
            <div class="row gx-3">
                <div class="col-12">
                    <div class="d-flex flex-column">
                        <p class="text mb-1">Person ID</p>
                        <input class="form-control mb-3" type="text" id="c_id" name="c_id" placeholder="Enter Benificiery ID">
                    </div>
                </div>
                
                <div class="col-12">
                    <div class="d-flex flex-column">
                        <p class="text mb-1">Account Number</p>
                        <input class="form-control mb-3" type="text" onkeypress='onlynumber(event)' id="account" name="account" placeholder="9010 0XXX XXX">
                    </div>
                </div>
                <div class="col-6">
                    <div class="d-flex flex-column">
                        <p class="text mb-1">Amount</p>
                        <input class="form-control mb-3" type="text" onkeypress='onlynumber(event)' id="amount" name="amount" placeholder="Transfer Amount">
                    </div>
                </div>
                <div class="col-6">
                    <div class="d-flex flex-column">
                        <p class="text mb-1">Password</p>
                        <input class="form-control mb-3 pt-2 " id="password" name="password" type="password" placeholder="***">
                    </div>
                </div>
               
            
                                    
                    <input type="submit"  onclick="return validate()" class="btn btn-primary mb-3">

                
            </div>
            </form>
        </div>
    </div>
                </div>
                
                
                   <!-- ------------three ----------- -->
                        <div class="row my-5 div-three content">
                    <h3 class="fs-4 mb-3">Recent Transactions</h3>
                    <div class="col">
                        <table class="table bg-white rounded shadow-sm  table-hover">
                            <thead>
                                <tr>
                                    <th scope="col" width="50">#</th>
                                    <th scope="col">ID</th>
                                    <th scope="col">Benificiery ID</th>
                                    <th scope="col">Benificiery account no</th>
                                    <th scope="col">Name</th>
                                     <th scope="col">Credit</th>
                                      <th scope="col">Debit</th>
                                       <th scope="col">Opening Balance</th>
                                         <th scope="col">Closing Balance</th>
                                            <th scope="col">Date</th>
                                </tr>
                            </thead>
          <%
          ResultSet rs=null;
          String q="";
          int i=0;
          try
          {
        	  String connectionURL = "jdbc:mysql://localhost:3306/mvcbank";
               Class.forName("com.mysql.jdbc.Driver");
                  // Get a Connection to the database
                Connection co=DriverManager.getConnection(connectionURL, "root", "5900"); 
                  Statement st=co.createStatement();
                  q="select * from account where cus_id='"+session.getAttribute("c_id")+"' union select * from mvcbank.deposit where ben_id='"+session.getAttribute("c_id")+"'	 order by date desc";
                rs=st.executeQuery(q);

          }
          catch(Exception e)
          {
              System.out.println("error is "+e);
          }
          %>
      
                            <tbody>
                                <% while(rs.next()){
            i++;
        %>
                
                                <tr>
                                    <th scope="row"><%=i %></th>
                                    <td><%=rs.getString("cus_id") %></td>
                                       <td><%=rs.getString("ben_id") %></td>
                                         
                                            <td><%=rs.getString("account") %></td>
                                             <td><%=rs.getString("name") %></td>
                                                 <td class="text-success">+<%=rs.getDouble("credit") %></td>
                                                      <td class="text-danger">-<%=rs.getDouble("debit") %></td>
                                                           <td><%=rs.getDouble("o_balance") %></td>
                                                                <td><%=rs.getDouble("c_balance") %></td>
                                                                <td><%=rs.getDate("date") %></td>
                                </tr>
                                  <%
            }
%>
                             
                            </tbody>
                        </table>
                    </div>
                </div>
                
              <!-- --------------------four------------------- -->

                 <div class="row my-5 div-four content">
                    <h3 class="fs-4 mb-3">My details</h3>
                    <section class="vh-180" style="background-color: #f4f5f7;">
                        <div class="container py-5 h-100">
                            <div class="row d-flex justify-content-center align-items-center h-190">
                                <div class="col col-lg-6 mb-4 mb-lg-0">
                                    <div class="card mb-3" style="border-radius: .5rem;">
                                        <div class="row g-0">
                                            <div class="col-md-4 gradient-custom text-center text-white" style="border-top-left-radius: .5rem; border-bottom-left-radius: .5rem;">
                                                <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava3.webp" alt="Avatar" class="img-fluid my-5" style="width: 80px;" />
                                                <h5 style="color:black">${u.firstname} 	</h5>
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
                                                            <p class="text-muted">${u.account}</p>
                                                        </div>
                                                        <div class="col-6 mb-3">
                                                            <h6>Account ID</h6>
                                                            <p class="text-muted">${u.c_id}</p>
                                                        </div>
                                                        <div class="col-6 mb-3">
                                                            <h6>Email</h6>
                                                            <p class="text-muted">${u.email }</p>
                                                        </div>
                                                        <div class="col-6 mb-3">
                                                            <h6>Phone</h6>
                                                            <p class="text-muted">${u.phone }</p>
                                                        </div>
                                                        <div class="col-6 mb-3">
                                                            <h6>Address</h6>
                                                            <p class="text-muted">${u.address}</p>
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

               <!-- ----------------------------------------FIVE-------- -->
                           <div class="row my-5 div-five content ">
                   <div class="container p-0">
        <div class="card px-4">
 
            <p class="h8 py-3">Apply For Loan </p>
                    <div id="error_message2"></div>
            <form action="applyloan" method="post">
            <div class="row gx-3">
                <div class="col-12">
                    <div class="d-flex flex-column">
                        <p class="text mb-1">Required Loan for</p>
                        <input class="form-control mb-3" type="text" name="req" id="req">
                    </div>
                </div>
                <div class="col-6">
                    <div class="d-flex flex-column">
                        <p class="text mb-1">Enter Loan Amount</p>
                        <input class="form-control mb-3" type="text" onchange="calculateAmount()" value="" onkeypress='onlynumber(event)' id="amt" name="amt" placeholder="Loan Amount">
                    </div>
                </div>
                <div class="col-12">
                    <div class="d-flex flex-column">
                        <p class="text mb-1">Load Period</p>
                        <select class="form-select"  onchange="calculateAmount()" name="data" id="data" aria-label="Default select example">
  <option value="" disabled selected>Open this select menu</option>
  <option value="3 12">3 Months 12% Interest</option>
  <option value="6 9">6 Months 9% Interest</option>
  <option value="12 7">12 Months 7% Interest</option>
</select>
                    </div>
                </div>
                <div class="col-6">
                    <div class="d-flex flex-column">
                        <p class="text mb-1">Effective Amount</p>
                        <input class="form-control mb-3" type="text" id="tot-amount" name="tot-amount" readonly>
                    </div>
                </div>
                <div class="col-6">
                    <div class="d-flex flex-column">
                        <p class="text mb-1">Password</p>
                        <input class="form-control mb-3 pt-2 " id="pass" name="pass" type="password" placeholder="***">
                    </div>
                </div>
               
            
                                    
                    <input type="submit" onclick="return valid()" class="btn btn-primary mb-3">
                    <script>
                    function calculateAmount() {
                    	var val=document.getElementById("data").value;
                    	const arr=val.split(" ");
                  	 var amount= document.getElementById("amt").value;
                    	console.log(amount);
                    	console.log(arr);
						var tot_price=(amount*arr[0]*arr[1]);
						tot_price=parseInt(amount)+(tot_price/(100*12));
						 tot_price=parseFloat(tot_price).toFixed(2);
						//display
						var divobj=document.getElementById('tot-amount');
						divobj.value=tot_price;
					}
                    </script>
                
            </div>
            </form>
        </div>
    </div>
                </div>
                
                
                
                
                <!-- ------------------------------------------------ -->

            </div>
        </div>
    </div>

</div>


</body>
<script>
$('.tab-link').click(function(){
	   var contClass = $(this).data('div');
	   $('.content').hide().filter('.' + contClass).show()
	})
</script>
<script>
function validate(){
	  console.log("inside");

	  var account = document.getElementById("account").value;
	  var c_id = document.getElementById("c_id").value;
	  var password= document.getElementById("password").value;
	  var amount= document.getElementById("amount").value;
	  var error_message = document.getElementById("error_message");
	  error_message.style.padding = "10px";
	  var text;



	  if(c_id.length!=9){
		    text = "Please Enter 9 digit Customer id";
		    error_message.innerHTML = text;
		    return false;
		  }
	  if(account.length!=11){
		    text = "Please Enter 11 Digit account number";
		    error_message.innerHTML = text;
		    return false;
		  }
	  if(amount<=0){
		    text = "Amount must be greater than 0";
		    error_message.innerHTML = text;
		    return false;
		  }
	  if(password.length <= 7){
	    text = "Please Enter More Than 7 Characters password";
	    error_message.innerHTML = text;
	    return false;
	  }
	  alert("Request Submitted Successfully!");
	  return true;
	}
</script>
<script>
function valid() {
	console.log("insidvalide");
	  var req = document.getElementById("req").value;
	  var amount = document.getElementById("amt").value;
	  var password= document.getElementById("pass").value;
	  var data= document.getElementById("data").value;
	  var error_message = document.getElementById("error_message2");
	  error_message.style.padding = "10px";
	  var text;
	  if(req.length<=9){
		    text = "Please Enter at least 9 charcters";
		    error_message.innerHTML = text;
		    return false;
		  }
	  if(amount<=0){
		    text = "Amount must be greater than 0";
		    error_message.innerHTML = text;
		    return false;
		  }
	  if(data.length<=1){
		    text = "Please select Atleast 1 option";
		    error_message.innerHTML = text;
		    return false;
		  }
	  if(password.length <= 7){
		    text = "Please Enter More Than 7 Characters password";
		    error_message.innerHTML = text;
		    return false;
		  }
	  alert("Request Submitted Successfully!");
	  return true;
}
</script>
<script>
function onlynumber(evt) {
	  var theEvent = evt || window.event;

	  // Handle paste
	  if (theEvent.type === 'paste') {
	      key = event.clipboardData.getData('text/plain');
	  } else {
	  // Handle key press
	      var key = theEvent.keyCode || theEvent.which;
	      key = String.fromCharCode(key);
	  }
	  var regex = /[0-9]|\./;
	  if( !regex.test(key) ) {
	    theEvent.returnValue = false;
	    if(theEvent.preventDefault) theEvent.preventDefault();
	  }
	}
</script>
<script>
function load() {
	  var contClass ='div-one';
	   $('.content').hide().filter('.' + contClass).show()
}
</script>
</html>