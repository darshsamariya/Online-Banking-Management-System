<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
         <%@page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>TVS Credit</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"/></head>
<body>

<style><%@include file="/WEB-INF/css/style.css"%></style>

     <%@include file="h_header.jsp" %>
     <%!
     String m="";
     %>
      <%
       m=(String)session.getAttribute("message");
      if(m==null)
      {
    	  m="";
      }
      else
      {
   	   session.removeAttribute("message");
      }
        %>
      
        <section class="home" id="home">
                     
            <div class="content">
       <p>    <%=m %>
       </p>
                           
                <span>India's Largest </span>
                <h3>Bank</h3>
                <p>We are your partner on the road to success.</p>
     <div id="myGroup">
    <button class="btn dropdown" data-toggle="collapse" data-target="#login,#message" data-parent="#myGroup"><i class="icon-chevron-right"></i> Login  </button>
    <button class="btn dropdown" data-toggle="collapse" data-target="#cus" data-parent="#myGroup"><i class="icon-chevron-right"></i> Customer</button>
    <button class="btn dropdown" data-toggle="collapse" data-target="#emp" data-parent="#myGroup"><i class="icon-chevron-right"></i> Employee</button>

    <div class="accordion-group">
        <div class="collapse indent" id="login">
           <div class="container pt-5" style="position: absolute; margin-top: -290px; margin-left: 700px; width: 1000px;">
    <div class="row justify-content-sm-center pt-5">
        <div class="col-sm-6 shadow round pb-3">
  
            <h1 class="text-center pt-3 text-secondary">Login</h1>

            <form  method="post" action="check" >
                <div class="form-group">
                    <label class="col-form-label" >Email:</label>
                    <input name="email" type="email" required style="text-transform: lowercase;"	 class="form-control">
                </div>
                <div class="form-group">
                    <label class="col-form-label">Password</label>
                    <input name="password"  type="password" class="form-control">
                </div>
                <br>
                <button  type="submit"  class="btn btn-primary text-center">Login</button>
            </form>
        </div>
    </div>
</div>
        </div>

        <div class="collapse indent" id="cus">
           <div class="container pt-5" style="position: absolute; margin-top: -550px; margin-left: 700px; width: 1000px;">
    <div class="row justify-content-sm-center pt-5">
        <div class="col-sm-6 shadow round pb-3">
            <h1 class="text-center pt-3 text-secondary">Register AS Customer</h1>
              <div id="error_message"></div>
            <form  method="post" action="insertcus">
                <div class="form-group">
                    <label class="col-form-label">Name:</label>
                    <input type="text" required id="name" name="firstname" class="form-control">
                </div>
                <div class="form-group">
                    <label class="col-form-label">Email:</label>
                    <input  name="email" required type="email" id="email" style="text-transform: lowercase;" class="form-control">
                </div>
                <div class="form-group">
                    <label name="gender" class="col-form-label">Gender</label>
                    <input  type="radio" name="gender" value="Male" checked>Male
                    <input  type="radio" name="gender" value="Female">Female

                </div>
                <div class="form-group">
                    <label class="col-form-label">Date of Birth</label>
                    <input name="dob" id="date" required type="date" class="form-control" max='2002-01-01'>
                </div>

                <div class="form-group">
                    <label class="col-form-label">Phone:</label>
                    <input type="number" required name="phone" id="phone" class="form-control">
        
                </div>
                <div class="form-group">
                    <label class="col-form-label">Address:</label>
                    <textarea  name="address" id="address" required class="form-control"></textarea>
                </div>
                <div class="form-group">
                    <label class="col-form-label">Pincode</label>
                    <input name="pin" type="number" id="pin" required class="form-control">
                </div>
                <input type="hidden" value="customer" name="type"/>
                 <input type="hidden" value="90100" name="account"/>
                  <input type="hidden" value="cus" name="c_id"/>
                <div class="form-group">
                    <label class="col-form-label">password:</label>
                    <input name="password" id="password" type="password" required class="form-control">
                </div>
                <br>
               
        <input class="btn-primary" onclick="return validate()" type="submit">
            </form>
        </div>
    </div>
</div>
        </div>

        <div class="collapse" id="emp">
            <div class="container pt-1" style="position: absolute; margin-top: -550px; margin-left: 700px; width: 1000px;">
    <div class="row justify-content-sm-center pt-5">
        <div class="col-sm-6 shadow round pb-3">
            <h1 class="text-center pt-3 text-secondary">Register as Employee</h1>
                          <div id="error_message1"></div>
            <form  method="post" action="insertemp">
                <div class="form-group">
                    <label class="col-form-label">Name:</label>
                    <input name="firstname" id="name1" type="text" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="col-form-label">Email:</label>
                    <input name="email" type="text" id="email1" style="text-transform: lowercase;" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="col-form-label">Gender</label>
                    <input name="gender" type="radio" value="Male" checked>Male
                    <input name="gender" type="radio" value="Female">Female
                </div>
                <div class="form-group">
                    <label class="col-form-label">Date of Joining</label>
                    <input name="doj" type="date" id="date1" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="col-form-label">Position</label>
                    <input name="position" id="position" type="text" class="form-control" required>
                </div>
<input type="hidden" value="employee" name="type"/> 
                <div class="form-group">
                    <label class="col-form-label">Experience in years</label>
                    <input name="exp" type="number" id="exp" class="form-control" required>
                </div>

                <div class="form-group">
                    <label class="col-form-label">Phone:</label>
                    <input name="phone" type="number" id="phone1" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="col-form-label">Areas of Interest</label>
                    <textarea name="interest" id="interest" required class="form-control"></textarea>
                </div>
                <div class="form-group">
                    <label class="col-form-label">password:</label>
                    <input name="password" type="password" id="password1" class="form-control" required>
                </div>
                  <input type="hidden" value="emp" name="e_id"/>
                <br>
                        <input class="btn-primary" onclick="return validate2()" type="submit">
            </form>
        </div>
    </div>
</div>
        </div>
    </div>
</div>

            </div>
        </section>

        <%@include file="h_footer.jsp" %>
        <div>

    </div>

</body>
<script>
jQuery('button').click( function(e) {
    jQuery('.collapse').collapse('hide');
});
</script>
<script>
function validate2(){

	  var name1 = document.getElementById("name1").value;
	  var email1 = document.getElementById("email1").value;
	  var date1= document.getElementById("date1").value;
	  var position = document.getElementById("position").value;
	  var exp = document.getElementById("exp").value;
	  var phone1 = document.getElementById("phone1").value;
	  var interest = document.getElementById("interest").value;

	  var password1= document.getElementById("password1").value;

	  var error_message1 = document.getElementById("error_message1");
	//  console.log(name);
	  error_message.style.padding = "10px";
	 // console.log("ok");
	  var text;
	  if(name1.length < 5){
	    text = "Please Enter valid Name";
	    error_message1.innerHTML = text;
	    return false;
	  }
	  if(email1.indexOf("@") == -1 || email1.length < 6){
		    text = "Please Enter valid Email";
		    error_message1.innerHTML = text;
		    return false;
		  }
	  if(email1.endsWith("@tvscredit.com")==false)
		  {
		  text = "Email must End with @tvscredit.com";
		    error_message1.innerHTML = text;
		    return false;
		  }
	  if(date1.length<=1){
		    text = "Please Enter Date";
		    error_message1.innerHTML = text;
		    return false;
		  }
	  if(position.length < 1){
		    text = "Please Enter Position";
		    error_message1.innerHTML = text;
		    return false;
		  }
	  if(isNaN(exp) || exp.length<=0){
		    text = "Please Enter Experience in years";
		    error_message1.innerHTML = text;
		    return false;
		  }
	  if(isNaN(phone1) || phone1.length != 10){
		    text = "Please Enter valid Phone Number";
		    error_message1.innerHTML = text;
		    return false;
		  }
	  if(interest.length < 10){
	    text = "Think More and add more than 10 charcater";
	    error_message1.innerHTML = text;
	    return false;
	  }
	  if(password1.length <= 7){
	    text = "Please Enter More Than 7 Characters password";
	    error_message1.innerHTML = text;
	    return false;
	  }
	  alert("Form Submitted Successfully!");
	  return true;
	}
</script>
<script>
function validate(){
	  console.log("inside");
	  var name = document.getElementById("name").value;
	  var address = document.getElementById("address").value;
	  var phone = document.getElementById("phone").value;
	  var email = document.getElementById("email").value;
	  var pin = document.getElementById("pin").value;
	  var password= document.getElementById("password").value;
	  var date= document.getElementById("date").value;
	  var error_message = document.getElementById("error_message");
	  console.log(name);
	  error_message.style.padding = "10px";
	  console.log("ok");
	  var text;
	  if(name.length < 5){
	    text = "Please Enter valid Name";
	    error_message.innerHTML = text;
	    return false;
	  }
	  if(email.indexOf("@") == -1 || email.length < 6){
		    text = "Please Enter valid Email";
		    error_message.innerHTML = text;
		    return false;
		  }
	  if(email.endsWith("@tvscredit.com"))
	  {
	  text = "Email cannot end with @tvscredit.com";
	    error_message.innerHTML = text;
	    return false;
	  }
	  if(date.length<=1){
		    text = "Please Enter date";
		    error_message.innerHTML = text;
		    return false;
		  }
	  if(isNaN(phone) || phone.length != 10){
		    text = "Please Enter valid Phone Number";
		    error_message.innerHTML = text;
		    return false;
		  }
	  if(address.length < 10){
	    text = "Address must be more than 10 charcater";
	    error_message.innerHTML = text;
	    return false;
	  }

	
	  if(isNaN(pin) || pin.length != 6){
		    text = "Please Enter valid Pincode Number";
		    error_message.innerHTML = text;
		    return false;
		  }
	
	  if(password.length <= 7){
	    text = "Please Enter More Than 7 Characters password";
	    error_message.innerHTML = text;
	    return false;
	  }
	  alert("Form Submitted Successfully!");
	  return true;
	}
</script>
</html>