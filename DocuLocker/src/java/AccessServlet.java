import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AccessServlet")
public class AccessServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database credentials
    private static final String DB_URL = "jdbc:mysql://localhost:3306/doculocker";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Somya@0407"; // replace with your actual password

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userEmail = (String) request.getSession().getAttribute("email");
        if (userEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<String> fileNames = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Get a connection to the database
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Prepare SQL query
            String sql = "SELECT file_name FROM uploads WHERE user_email = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userEmail);

            // Execute SQL query
            rs = pstmt.executeQuery();

            // Process result set
            while (rs.next()) {
                fileNames.add(rs.getString("file_name"));
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Handle exceptions appropriately
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Set attributes in request for accessFiles.jsp
        request.setAttribute("fileNames", fileNames);
        request.getRequestDispatcher("accessFiles.jsp").forward(request, response);
    }
}
