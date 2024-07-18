import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

@WebServlet("/UploadServlet")
public class UploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "E:/Upload_Files";

    private static final String DB_URL = "jdbc:mysql://localhost:3306/doculocker";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Somya@0407";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (ServletFileUpload.isMultipartContent(request)) {
            try {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List<FileItem> items = upload.parseRequest(request);

                String fileName = null;
                String userProvidedFileName = null;

                for (FileItem item : items) {
                    if (item.isFormField()) {
                        if (item.getFieldName().equals("fileName")) {
                            userProvidedFileName = item.getString();
                        }
                    } else {
                        fileName = FilenameUtils.getName(item.getName());
                        File uploadFolder = new File(UPLOAD_DIR);
                        if (!uploadFolder.exists()) {
                            uploadFolder.mkdirs();
                        }
                        File uploadedFile = new File(uploadFolder + File.separator + fileName);
                        item.write(uploadedFile);

                        String userEmail = (String) request.getSession().getAttribute("email");
                        saveFileMetadata(userProvidedFileName, userEmail, fileName);
                    }
                }

                if (fileName != null && userProvidedFileName != null) {
                    request.setAttribute("message", "File uploaded successfully: " + userProvidedFileName);
                } else {
                    request.setAttribute("message", "No file uploaded");
                }

                request.getRequestDispatcher("userhome.jsp").forward(request, response);
            } catch (Exception e) {
                throw new ServletException("File upload failed", e);
            }
        } else {
            response.getWriter().println("The request doesn't contain a multipart/form-data or multipart/mixed stream");
        }
    }

    private void saveFileMetadata(String userProvidedFileName, String userEmail, String fileName) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String sql = "INSERT INTO uploads (file_name, user_email, upload_time, file_path) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userProvidedFileName);
            pstmt.setString(2, userEmail);
            pstmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            pstmt.setString(4, UPLOAD_DIR + File.separator + fileName);
            pstmt.executeUpdate();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
}
