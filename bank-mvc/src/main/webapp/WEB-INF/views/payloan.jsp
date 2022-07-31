<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
            <%@page import="com.bankmvc.entities.customer" %>
            <%@page import="com.bankmvc.entities.loan" %>
                 <%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer details</title>
<style><%@include file="/WEB-INF/css/styledash.css"%></style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">



</head>
<body>
 <%
  customer c=(customer)session.getAttribute("customer");
    	loan l=(loan)session.getAttribute("loan_id");
  if(c!=null && l!=null){%>
       <div id="page-content-wrapper">
	  <div class="row my-5 content ">
      <div class="container p-0">
<div class="card px-4">
<p class="h8 py-3">Pay loan </p>

  <div id="error_message"></div>
<form action="transfer" method="post">
<div class="row gx-3">
   <div class="col-6">
       <div class="d-flex flex-column">
           <p class="text mb-1">Bank ID</p>
           <input class="form-control mb-3" type="text" id="c_id" name="c_id" value="tvscredit" readonly >
       </div>
   </div>
    <div class="col-6">
       <div class="d-flex flex-column">
           <p class="text mb-1">Loan ID</p>
           <input class="form-control mb-3" type="text"  name="loan_id" value="<%=l.getLoan_id() %>" readonly >
       </div>
   </div>
   <div class="col-6">
       <div class="d-flex flex-column">
           <p class="text mb-1">Account Number</p>
           <input class="form-control mb-3" type="text"  id="account" name="account" value="LOAN DEPOSIT" readonly >
       </div>
   </div>
     <div class="col-6">
       <div class="d-flex flex-column">
           <p class="text mb-1">Amount left</p>
           <input class="form-control mb-3" type="text"  id="amt_left" name="amt_left" value="<%=l.getAmt_left() %>" readonly >
       </div>
   </div>
   
   <div class="col-6">
       <div class="d-flex flex-column">
           <p class="text mb-1">Amount</p>
           <input class="form-control mb-3" type="text" onkeypress='onlynumber(event)' id="amount" name="amount" placeholder="Transfer Amount" onchange="uncheck()">
       </div>
   </div>
     <div class="col-6">
       <div class="d-flex flex-column">
           <p class="text mb-1">Applicable Interest</p>
           <input class="form-control mb-3" type="text" onkeypress='onlynumber(event)' id="net_amount" name="net_amount"  value="<%=l.getInt_val() %>" readonly>
       </div>
   </div>
   <div class="form-check">
  <label><input type="checkbox" name="check" id="check-2" >Clear all dues</label>
</div>
   <input type="hidden" name="roi" id="roi" value="<%=l.getRoi() %>"/>
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
   
	  
 <%  }

 %>
  <a href="dash-cus">Go back</a>
 </body>
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
function validate(){
	  var password= document.getElementById("password").value;
	  var amount= document.getElementById("amount").value;
	  var amt_left= document.getElementById("amt_left").value;
	  var error_message = document.getElementById("error_message");
	  error_message.style.padding = "10px";
	  var text;
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
       document.querySelector('input[type="checkbox"]').addEventListener('change', function () {
    	   console.log(this.checked);
    		if (this.checked) {
    			 var amt_left= document.getElementById("amt_left").value;
    			 var net_amt=document.getElementById("net_amount").value;
    			document.getElementById("amount").value =parseFloat(amt_left)+parseFloat(net_amt);
    			
    		}
    		else {
    			document.getElementById("amount").value = '';
    		}
       }, false);
       </script>
       <script>
       function uncheck()
       {
    	   document.getElementById("check-2").checked=false;
       }
       </script>
</html>