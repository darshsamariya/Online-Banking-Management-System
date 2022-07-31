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
                        class="fas fa-project-diagram me-2"></i><i class="bi-cash-coin"></i>Deposit Money</button></a>
          <a href="#" class="tab-link" data-div="div-three">      <button class="btn dropdown list-group-item list-group-item-action bg-transparent second-text fw-bold" data-toggle="collapse" data-target="#attrs" data-parent="#myGroup"><i
                        class="fas fa-chart-line me-2"></i><i class="bi-table"></i>My transaction</button></a>
             <a  href="#" class="tab-link" data-div="div-four">   <button class="btn dropdown list-group-item list-group-item-action bg-transparent second-text fw-bold" data-toggle="collapse" data-target="#attrs" data-parent="#myGroup"><i
                        class="fas fa-paperclip me-2"></i><i class="bi-person-circle"></i>My Details</button></a>
               <a  href="#search" class="tab-link" data-div="div-five"> <button class="btn dropdown list-group-item list-group-item-action bg-transparent second-text fw-bold" data-toggle="collapse" data-target="#attrs" data-parent="#myGroup"><i
                        class="fas fa-shopping-cart me-2"></i><i class="bi-chat-dots-fill"></i>Search customer</button></a>
                          <a  href="#search" class="tab-link" data-div="div-nine"> <button class="btn dropdown list-group-item list-group-item-action bg-transparent second-text fw-bold" data-toggle="collapse" data-target="#attrs" data-parent="#myGroup"><i
                        class="fas fa-shopping-cart me-2"></i><i class="bi-chat-dots-fill"></i>View All loans</button></a>
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
                    <h2 class="fs-2 m-0" style="text-transform: capitalize;">Welcome ${u.firstname}</h2>
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
                                <h3 class="fs-2">Employee</h3>
                                <p class="fs-5">Account </p>
                            </div>
                       <i style="transform:scale(1.8)" class="bi-cash-coin"></i>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                   
                            <div style="cursor: pointer;" class="tab-link" data-div="div-six">
                                <h3 class="fs-2">View</h3>
                                <p class="fs-5">Bank Transaction</p>
                            </div>
                          
                       <i style="transform:scale(1.8)" 	 class="bi-box-arrow-in-down-right"></i>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                            <div  style="cursor: pointer;"   class="tab-link" data-div="div-seven">
                                <h3 class="fs-2">View</h3>
                                <p class="fs-5">Custom Bank statement</p>
                            </div>
                            <i style="transform:scale(1.8)" class="bi-arrow-up-right-square"></i>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                            <div  style="cursor: pointer;"   class="tab-link" data-div="div-eight">
                                <h3 class="fs-2">View</h3>
                                <p class="fs-5">Loan Application</p>
                            </div>
                         <i style="transform:scale(1.8)" class="bi-bookmark-heart-fill"></i>
                        </div>
                    </div>
                      <div class="row my-5 div-one content">
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
                </div>
           <% 
                   	  String connectionURL = "jdbc:mysql://localhost:3306/mvcbank";
               Class.forName("com.mysql.jdbc.Driver");
                  // Get a Connection to the database
                Connection co=DriverManager.getConnection(connectionURL, "root", "5900"); 
                  Statement st=co.createStatement();%>
                       
                <!-- ------------ONE ----------- -->
                        <div class="row my-5 div-three content">
                    <h3 class="fs-4 mb-3">Recent Transactions</h3>
                    <div class="col">
                        <table class="table bg-white rounded shadow-sm  table-hover">
                            <thead>
                                <tr>
                                    <th scope="col" width="50">#</th>
                                    <th scope="col">Employee ID</th>
                                    <th scope="col">Benificiery ID</th>
                                    <th scope="col">Benificiery Name</th>
                                    <th scope="col">Benificiery account no</th>
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

                  q="select * from deposit where cus_id='"+session.getAttribute("e_id")+"' order by date desc";
               
                     // q="select * from account union select * from deposit order by date desc";
      
                ///  System.out.println(q);
                  rs=st.executeQuery(q);

          }
          catch(Exception e)
          {
              System.out.println("error is "+e);
          }
          %>
                            <tbody>
                                <% if(rs!=null){
                                	while(rs.next()){
            i++;
        %>

                                <tr>
                                    <th scope="row"><%=i %></th>
                                   
                                    <td><%=rs.getString("cus_id") %></td>
                                       <td><%=rs.getString("ben_id") %></td>
                                           <td><%=rs.getString("name") %></td>
                                            <td><%=rs.getString("account") %></td>
                                                 <td class="text-success">+<%=rs.getDouble("credit") %></td>
                                                      <td class="text-danger">-<%=rs.getDouble("debit") %></td>
                                                           <td><%=rs.getDouble("o_balance") %></td>
                                                                <td><%=rs.getDouble("c_balance") %></td>
                                                                 <td><%=rs.getDate("date") %></td>
                                </tr>
                                  <%
            }}
%>
                             
                            </tbody>
                        </table>
                    </div>
                </div>
           
                <!-- --------------------------------------------------Two -->
                 <div class="row my-5 div-two content ">
                   <div class="container p-0">
        <div class="card px-4">
            <p class="h8 py-3">Deposit Money </p>
       
               <div id="error_message"></div>
            <form action="deposit" method="post">
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
                        <input class="form-control mb-3" type="text" id="amount" name="amount" placeholder="Transfer Amount" onkeypress='onlynumber(event)'>
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
                                                <p style="color:black">Employee Account</p>
                                                <i class="far fa-edit mb-5"></i>
                                            </div>
                                            <div class="col-md-8">
                                                <div class="card-body p-4">
                                                    <h6>Information</h6>
                                                    <hr class="mt-0 mb-4">
                                                    <div class="row pt-1">
                                                     <div class="col-6 mb-3">
                                                            <h6>Id</h6>
                                                            <p class="text-muted">${u.e_id }</p>
                                                        </div>
                                                        <div class="col-6 mb-3">
                                                            <h6>Position</h6>
                                                            <p class="text-muted">${u.position}</p>
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
                                                            <h6>Skills</h6>
                                                            <p class="text-muted">${u.interest}</p>
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

               <!-- ------------------------------------------------ -->
               <div class="row my-5 div-five content">
              <form action="getcustomer" method="post"> 
  <div class="form-group">
    <label for="exampleInputEmail1">Enter customer ID</label>
  <input type="text" class="form-control" name="cid" placeholder="cusXXXXXX">
  </div>
  <button type="submit" class="btn btn-primary">Submit</button>
  </form>
  </div>
  <!-- ------------------------------------------------SIC -->
                       <div class="row my-5 div-six content">
                    <h3 class="fs-4 mb-3">Full Bank transaction</h3>
                 
                    <div class="col">
                        <table class="table bg-white rounded shadow-sm  table-hover">
                            <thead>
                                <tr>
                                    <th scope="col" width="50">#</th>
                                    <th scope="col">Employee ID</th>
                                    <th scope="col">Benificiery ID</th>
                                    <th scope="col">Benificiery Name</th>
                                    <th scope="col">Benificiery account no</th>
                                     <th scope="col">Credit</th>
                                      <th scope="col">Debit</th>
                                       <th scope="col">Opening Balance</th>
                                         <th scope="col">Closing Balance</th>
                                          <th scope="col">Date</th>
                                </tr>
                            </thead>
          <%
          ResultSet rs2=null;
          String q2="";
           i=0;
          try
          {
                 q2="select * from transfer union select * from deposit order by date desc";;
                  rs2=st.executeQuery(q2);

          }
          catch(Exception e)
          {
              System.out.println("error is "+e);
          }
          %>
                            <tbody>
                                <% if(rs2!=null)
                                	{while(rs2.next()){
            i++;
        %>
    
                
                                <tr>
                                    <th scope="row"><%=i %></th>
                                   
                                    <td><%=rs2.getString("cus_id") %></td>
                                       <td><%=rs2.getString("ben_id") %></td>
                                           <td><%=rs2.getString("name") %></td>
                                            <td><%=rs2.getString("account") %></td>
                                                 <td class="text-success">+<%=rs2.getDouble("credit") %></td>
                                                      <td class="text-danger">-<%=rs2.getDouble("debit") %></td>
                                                           <td><%=rs2.getDouble("o_balance") %></td>
                                                                <td><%=rs2.getDouble("c_balance") %></td>
                                                                 <td><%=rs2.getDate("date") %></td>
                                </tr>
                                  <%
            }}
%>
                             
                            </tbody>
                        </table>
                    </div>
                </div>
<!-- ----------------------------------Seven -->
  <div class="row my-5 div-seven content">
        <div id="error_message2"></div>
     <form method="post" action="customdate">
                        <div class="form-group">
                    <label class="col-form-label">Start Date</label>
                    <input name="d1" id="d1"  type="date" class="form-control" >
                </div>
                    <div class="form-group">
                    <label class="col-form-label">End date</label>
                    <input name="d2"  id="d2" type="date" class="form-control">
                </div>
                   <input type="submit" onclick="return validate2()" class="btn btn-primary mb-3">
                    </form>
  </div>
 <!-- ---------------------------------Eight -->
                  <div class="row my-5 div-eight content">
                    <h3 class="fs-4 mb-3">Loans Requested</h3>
                 
                    <div class="col">
                        <table class="table bg-white rounded shadow-sm  table-hover">
                            <thead>
                                <tr>
                                    <th scope="col" width="50">#</th>
                                     <th scope="col">Loan ID</th>
                                    <th scope="col">CustomerID</th>
                                    <th scope="col">Name</th>
                                    <th scope="col">Requirement</th>
                                    <th scope="col">Loan Amount</th>
                                     <th scope="col">Period</th>
                                      <th scope="col">ROI</th>
                                          <th scope="col">Date Applied</th>
                                          <th scope="col">Pay per month</th>
                                      <th scope="col" class="text-justify">Status</th>
                                </tr>
                            </thead>
          <%
          ResultSet rs3=null;
          String q3="";
           i=0;
          try
          {
                 q3="select * from loanapplication where status='applied'";
                  rs3=st.executeQuery(q3);

          }
          catch(Exception e)
          {
              System.out.println("error is "+e);
          }
          %>
                            <tbody>
                                <% if(rs3!=null)
                                	{while(rs3.next()){
            i++;
        %>
    
                
                                <tr>
                                    <th scope="row"><%=i %></th>
                                   <td><%=rs3.getString("loan_id") %></td>
                                    <td><%=rs3.getString("cus_id") %></td>
                                           <td><%=rs3.getString("name") %></td>
                                              <td><%=rs3.getString("req") %></td>
                                                      <td><%=rs3.getDouble("amount_applied") %></td>
                                                           <td><%=rs3.getInt("period") %> Months</td>
                                                                <td><%=rs3.getDouble("roi") %> %</td>
                                                                  <td><%=rs3.getDate("date_app") %></td>
                                                                     <td><%=rs3.getDouble("pay_per_month") %></td>                                  
                                                                        <td>
                                                                    
                                                                          <form action="loanstatus" method="post">
                                                            	 <button style="background-color:green; color: white;" name="status" value="accept" type="submit"  >
                                                            	  <span class="block">Accept</span>
                                                            	  </button>
                                                            	   <input type="hidden" value="<%=rs3.getDouble("amount_applied") %>" name="amt"/>
                                                            	  <input type="hidden" value="<%=rs3.getString("cus_id") %>" name="cus_id"/>
                                                            	  <input type="hidden" value="<%=rs3.getString("loan_id") %>" name="loan_id"/>
                                                            	  <button style="background-color: red; color: white"  name="status" value="reject" type="submit">
                                                                  <span class="unblock">Reject</span>	
                                                            	 </button>
                                                            	 </form>
                                                            	 </td>
                                </tr>
                                                            
                                  <%
            }}
%>
                             
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <!-- ----------NINE------ -->
           <div class="row my-5 div-nine content">
                    <h3 class="fs-4 mb-3">All loans status</h3>
                 
                    <div class="col">
                        <table class="table bg-white rounded shadow-sm  table-hover">
                            <thead>
                                <tr>
                                    <th scope="col" width="50">#</th>
                                     <th scope="col">Loan ID</th>
                                    <th scope="col">CustomerID</th>
                                    <th scope="col">Name</th>
                                    <th scope="col">Requirement</th>
                                    <th scope="col">Loan Amount</th>
                                     <th scope="col">Period</th>
                                      <th scope="col">ROI</th>
                                          <th scope="col">Date Applied</th>
                                      <th scope="col" class="text-justify">Status</th>
                                          <th scope="col">Net Amount Paid</th>
                                </tr>
                            </thead>
          <%
          ResultSet rs4=null;
          String q4="";
           i=0;
          try
          {
                 q4="select * from loanapplication order by date_app desc ";
                  rs4=st.executeQuery(q4);

          }
          catch(Exception e)
          {
              System.out.println("error is "+e);
          }
          %>
                            <tbody>
                                <% if(rs4!=null)
                                	{while(rs4.next()){
            i++;
        %>
    
                
                                <tr>
                                    <th scope="row"><%=i %></th>
                                   <td><%=rs4.getString("loan_id") %></td>
                                    <td><%=rs4.getString("cus_id") %></td>
                                           <td><%=rs4.getString("name") %></td>
                                              <td><%=rs4.getString("req") %></td>
                                                      <td><%=rs4.getDouble("amount_applied") %></td>
                                                           <td><%=rs4.getInt("period") %> Months</td>
                                                                <td><%=rs4.getDouble("roi") %> %</td>
                                                                  <td><%=rs4.getDate("date_app") %></td>
                                                                   <td>  <b> <%=rs4.getString("status") %> </b></td>
                                                                      <td><%=rs4.getDouble("net_val") %></td>
                                                            	 </form>
                                                            	 </td>
                                </tr>
                                                            
                                  <%
            }}
%>
                             
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </div>




</body>
<script>
function load() {
	  var contClass ='div-one';
	   $('.content').hide().filter('.' + contClass).show()
}
</script>
<script>
$('.tab-link').click(function(){
	   var contClass = $(this).data('div');
	   console.log(contClass);  
	   $('.content').hide().filter('.' + contClass).show()
	})
</script>
<script>
function validate2()
{
	  var d1 = document.getElementById("d1").value;
	  var d2 = document.getElementById("d2").value;
	  var error_message2 = document.getElementById("error_message2");
	  error_message2.style.padding = "10px";
	  var text;
	  if(d1.localcompare(d2)>0)
		  {
		  text = "Please Enter valid custom date";
		    error_message2.innerHTML = text;
		    return false;
		  }

alert("Fetching data!");
return true;
	}
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
</html>