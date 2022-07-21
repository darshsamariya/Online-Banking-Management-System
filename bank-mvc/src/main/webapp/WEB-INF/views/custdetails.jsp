<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
            <%@page import="com.bankmvc.entities.customer" %>
                 <%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer details</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<style>
button .unblock {
  display: none;
}

button:hover .block {
  display: none;
}

button:hover .unblock {
  display: inline;
}
</style>

</head>
<body>
 <%
  customer c=(customer)session.getAttribute("custid");
    	
  if(c!=null){
 %>
	  <div class="row my-5 div-four content">
                  
                    <section class="vh-180" style="background-color: #f4f5f7;">

                        <div class="container py-5 h-100">
                            <div class="row d-flex justify-content-center align-items-center h-190">
                                <div class="col col-lg-6 mb-4 mb-lg-0">
                                    <div class="card mb-3" style="border-radius: .5rem;">
                                        <div class="row g-0">
                                            <div class="col-md-4 gradient-custom text-center text-white" style="border-top-left-radius: .5rem; border-bottom-left-radius: .5rem;">
                                                <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava3.webp" alt="Avatar" class="img-fluid my-5" style="width: 80px;" />
                                                <h5 style="color:black"><%=c.getFirstname() %>	</h5>
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
                                                            <p class="text-muted"><%=c.getAccount() %></p>
                                                        </div>
                                                        <div class="col-6 mb-3">
                                                            <h6>Account ID</h6>
                                                            <p class="text-muted"><%=c.getC_id() %></p>
                                                        </div>
                                                        <div class="col-6 mb-3">
                                                            <h6>Email</h6>
                                                            <p class="text-muted"><%=c.getEmail() %></p>
                                                        </div>
                                                        <div class="col-6 mb-3">
                                                            <h6>Phone</h6>
                                                            <p class="text-muted"><%=c.getPhone() %></p>
                                                        </div>
                                                        <div class="col-6 mb-3">
                                                            <h6>Address</h6>
                                                            <p class="text-muted"><%=c.getAddress() %></p>
                                                        </div>
                                                         <div class="col-6 mb-3">
                                                            <h6>Balance</h6>
                                                            <p class="text-muted"><%=c.getBalance()%></p>
                                                        </div>
                                                         <div class="col-6 mb-3">
                                                            <h6>Limit</h6>
                                                            <p class="text-muted"><%=c.getT_limit()%></p>
                                                        </div>
                                                         
                                                          <div class="col-6 mb-3">
                                                            <h6>Account status</h6>
                                                             <%if(c.getT_lock()==1)
                                                             {
                                                            	 %>
                                                            	  <p class="text-muted">Active</p>
                                                            	  <% 
                                                             }
                                                             else
                                                             {
                                                            	 %>
                                                            	 <form action="unblock" method="post">
                                                            	  <input type="hidden" name="cid" value="<%=c.getC_id() %>"/>
                                                            	 <button class="btn btn-primary" type="submit"  >
                                                            	  <span class="block">Locked</span>
                                                                  <span class="unblock">UnLock</span>
                                                            	 </button>
                                                            	 </form>
                                                             <%}%>
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
                    <%} %>
                    
                    <%
                    String d1=(String)session.getAttribute("date1");
                    String d2=(String)session.getAttribute("date2");
                    %>
                    <%
                    if(c!=null || d1!=null)
                    {
                    %>
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
                  if(c!=null)
                  {
                  q="select * from account where cus_id='"+c.getC_id()+"' union select * from mvcbank.deposit where ben_id='"+c.getC_id()+"'	 order by date desc";
                  }
                  else
                  {
                	  q="select * from account where date between '"+d1+"' and '"+d2+"' union select * from mvcbank.deposit where date between '"+d1+"' and '"+d2+"' order by date desc";
                  }
                rs=st.executeQuery(q);
System.out.println(q);	
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
                <%} %>
                <%
                if(c!=null)
                {
                	session.removeAttribute("custid");
                }
                else if(d1!=null)
                {
                	session.removeAttribute("d1");
                	session.removeAttribute("d2");

                }
                %>

  <a href="dash-emp">Go back</a>
 </body>
</html>