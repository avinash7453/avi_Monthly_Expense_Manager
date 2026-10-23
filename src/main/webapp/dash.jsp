<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>     
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Expense Dashboard</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<%
    int id = Integer.parseInt(request.getParameter("id"));
    String nm = request.getParameter("name");
    int bal = 0;
    Statement stmt; 
    ResultSet rs;
    Connection con;
    String url="";
    String username="";
    String pass="";
    try {
    	Class.forName("com.mysql.cj.jdbc.Driver");
		 url="jdbc:mysql://localhost:3306/expense_manager";
	     username="root";
	     pass="Avi@7453";
	    con=DriverManager.getConnection(url,username,pass);
		//out.print("Connection Successfull...");
        stmt = con.createStatement();
        rs = stmt.executeQuery("select opbal from uopbal where uid=" + id);
      
        while(rs.next()){
            bal = rs.getInt(1);
        }
    } catch(Exception e) {
        out.print(e);
    }
%>

    <!-- Navbar -->
    <nav class="navbar navbar-dark bg-dark shadow-sm">
        <div class="container-fluid px-4">
            <span class="navbar-brand fw-bold"><i class="bi bi-wallet2 me-2"></i>Expense Manager</span>
            <span class="text-white"><i class="bi bi-person-circle me-1"></i> <%= nm %></span>
        </div>
    </nav>

    <!-- Main Container -->
    <div class="container my-5">

        <!-- Welcome Banner & Opening Balance Card -->
        <div class="row g-4 mb-4">
            <div class="col-md-8">
                <div class="card border-0 shadow-sm rounded-4 p-4 bg-white h-100 d-flex flex-column justify-content-center">
                    <h2 class="fw-bold text-dark mb-1">Welcome to Dashboard, <%= nm %>!</h2>
                    <p class="text-muted mb-0">Manage your credits and debits efficiently.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm rounded-4 p-4 bg-primary text-white h-100">
                    <h6 class="text-uppercase fw-semibold opacity-75 small">Opening Balance</h6>
                    <h2 class="fw-bold mb-0">₹ <%= bal %></h2>
                    <div class="mt-2 text-white-50 small">User ID: <%= id %></div>
                </div>
            </div>
        </div>

        <!-- Action Buttons Bar -->
        <div class="card border-0 shadow-sm rounded-4 p-3 mb-4 bg-white">
            <div class="d-flex justify-content-end gap-3">
                <button type="button" class="btn btn-success px-4 py-2 rounded-pill fw-semibold shadow-sm" data-bs-toggle="modal" data-bs-target="#exampleModal">
                    <i class="bi bi-plus-circle me-2"></i> Add Credit
                </button>
                <button type="button" class="btn btn-danger px-4 py-2 rounded-pill fw-semibold shadow-sm" data-bs-toggle="modal" data-bs-target="#dexampleModal">
                    <i class="bi bi-dash-circle me-2"></i> Add Debit
                </button>
            </div>
        </div>

        <!-- Transactions Table Section -->
        <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
            <div class="card-header bg-white py-3 px-4 border-0">
                <h5 class="fw-bold mb-0 text-dark"><i class="bi bi-table me-2"></i>Transaction Details</h5>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light text-uppercase fs-7">
                        <tr>
                            <th class="py-3 px-4">TID</th>
                            <th class="py-3">Date</th>
                            <th class="py-3">Note</th>
                            <th class="py-3 text-success">Credit</th>
                            <th class="py-3 text-danger">Debit</th>
                            <th class="py-3">Closing Bal</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        con = DriverManager.getConnection(url, username, pass);
                       stmt=con.createStatement();
                     rs=  stmt.executeQuery("select * from transaction where uid="+id) ;
                       
                     while(rs.next()){
                 		
                 		%>
                         <tr>
                             <td><%=rs.getString(1) %></td>
                             <td><%=rs.getString(2) %></td>
                            <td><%=rs.getString(3) %></td>
                            <td class="text-danger"><%=rs.getInt(4) %></td>
                            <td class="text-success fw-semibold">+<%=rs.getInt(5) %></td>
                            <td class="px-4 fw-semibold"><%=rs.getInt(6) %></td>
                        </tr>
                        <%
    	}
		 %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Credit Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 rounded-4 shadow">
          <div class="modal-header border-0 pb-0">
            <h5 class="modal-title fw-bold text-success" id="exampleModalLabel"><i class="bi bi-plus-circle-fill me-2"></i>Credit Amount</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form action="credit.jsp" method="get">
              <div class="modal-body py-4">
                 <input class="form-control"  readonly="readonly" type="hidden" value= <%= nm %> name="nm" required>
                     <input class="form-control"  readonly="readonly" type="hidden" value= <%= id %> name="id" required>
                     <input class="form-control"  readonly="readonly" type="hidden" value= <%= bal %> name="opbal" required>
                 <div class="mb-3">
                     <label class="form-label text-muted small fw-semibold">Date</label>
                     <input class="form-control rounded-3" type="date" name="dt" required>
                 </div>
                 <div class="mb-3">
                     <label class="form-label text-muted small fw-semibold">Note</label>
                     <input class="form-control rounded-3" type="text" name="note" placeholder="Enter Note" required>
                 </div>
                 <div class="mb-3">
                     <label class="form-label text-muted small fw-semibold">Credit Amount</label>
                     <input class="form-control rounded-3" type="number" name="crdt" placeholder="Enter Credit Amount" required>
                 </div>
              </div>
              <div class="modal-footer border-0 pt-0">
                <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-success rounded-pill px-4">Credit</button>
              </div>
          </form>
        </div>
      </div>
    </div>

    <!-- Debit Modal -->
    <div class="modal fade" id="dexampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 rounded-4 shadow">
          <div class="modal-header border-0 pb-0">
            <h5 class="modal-title fw-bold text-danger" id="exampleModalLabel"><i class="bi bi-dash-circle-fill me-2"></i>Debit Amount</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form action="debit.jsp" method="get">
              <div class="modal-body py-4">
                 <input class="form-control"  readonly="readonly" type="hidden" value= <%= nm %> name="nm" required>
                     <input class="form-control"  readonly="readonly" type="hidden" value= <%= id %> name="id" required>
                     <input class="form-control"  readonly="readonly" type="hidden" value= <%= bal %> name="opbal" required>
                 <div class="mb-3">
                     <label class="form-label text-muted small fw-semibold">Date</label>
                     <input class="form-control rounded-3" type="date" name="dt" required>
                 </div>
                 <div class="mb-3">
                     <label class="form-label text-muted small fw-semibold">Note</label>
                     <input class="form-control rounded-3" type="text" name="note" placeholder="Enter Note" required>
                 </div>
                 <div class="mb-3">
                     <label class="form-label text-muted small fw-semibold">Debit Amount</label>
                     <input class="form-control rounded-3" type="number" name="dbt" placeholder="Enter Debit Amount" required>
                 </div>
              </div>
              <div class="modal-footer border-0 pt-0">
                <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-danger rounded-pill px-4">Debit</button>
              </div>
          </form>
        </div>
      </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>