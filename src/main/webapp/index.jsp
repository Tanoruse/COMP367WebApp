<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalTime" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome Page</title>
</head>
<body>
    <h2>
        <% 
            LocalTime now = LocalTime.now();
            String greeting;

            if (now.getHour() < 12) {
                greeting = "Good morning, Samuel, Welcome to COMP367";
            } else {
                greeting = "Good afternoon, Samuel, Welcome to COMP367";
            }
        %>
        <%= greeting %>
    </h2>
</body>
</html>
