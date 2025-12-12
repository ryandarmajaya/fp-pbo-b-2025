        </div>
        
        <footer class="footer-modern">
            <div class="container text-center">
                <p class="footer-copy">&copy; Object Oriented Programming B 2025 - All rights reserved.</p>
            </div>
        </footer>

        <!-- JS -->
        <script src="<%= request.getContextPath() %>/assets/js/jquery.js"></script>
        <script src="<%= request.getContextPath() %>/assets/js/bootstrap.js"></script>

    </body>
</html>


<%
    if (con != null) {
        try {
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>