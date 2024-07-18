<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Access Files - DocuLocker</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            max-width: 800px;
            width: 100%;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
        }
        .file-list {
            margin-top: 20px;
        }
        .file-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .file-item .file-name {
            flex: 1;
            color: #007bff;
            text-align: left;
        }
        .file-item .action-links {
            flex-shrink: 0;
            margin-left: 10px;
        }
        .file-item .action-links a {
            color: #007bff;
            text-decoration: none;
            transition: color 0.3s;
        }
        .file-item .action-links a:hover {
            color: #0056b3;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
            transition: text-decoration 0.3s;
        }
        .back-link:hover {
            text-decoration: underline;
        }
        .no-files {
            color: #888;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Access Files</h1>
        
        <div class="file-list">
            <%
                java.util.List<String> fileNames = (java.util.List<String>) request.getAttribute("fileNames");
                if (fileNames != null && !fileNames.isEmpty()) {
                    for (String fileName : fileNames) {
            %>
                        <div class="file-item">
                            <div class="file-name">
                                <%= fileName %>
                            </div>
                            <div class="action-links">
                                <a href="DownloadServlet?fileName=<%= fileName %>" target="_blank">View/Download</a>
                            </div>
                        </div>
            <%
                    }
                } else {
            %>
                    <p class="no-files">No files found.</p>
            <%
                }
            %>
        </div>
        
        <a class="back-link" href="userhome.jsp">Back to Home</a>
    </div>
</body>
</html>
