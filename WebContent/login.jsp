<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Connexion</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f8f4e9;
            color: #333;
            line-height: 1.6;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            width: 100%;
            max-width: 450px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 8px 24px rgba(126, 78, 35, 0.15);
            overflow: hidden;
            padding-bottom: 30px;
        }

        .header {
            text-align: center;
            padding: 30px 0;
            background-color: #7e4e23;
            margin-bottom: 30px;
            position: relative;
        }

        .header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 25%;
            width: 50%;
            height: 4px;
            background-color: #d4b68c;
            border-radius: 20px;
        }

        .header h1 {
            color: #fff;
            font-size: 2.2em;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .form-container {
            padding: 0 40px;
        }

        .error {
            color: #e74c3c;
            background-color: rgba(231, 76, 60, 0.1);
            padding: 10px 15px;
            border-radius: 5px;
            font-size: 0.9em;
            margin-bottom: 20px;
            border-left: 4px solid #e74c3c;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            color: #7e4e23;
            margin-bottom: 8px;
            font-weight: 600;
            font-size: 0.95em;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #d4b68c;
            border-radius: 6px;
            font-size: 1em;
            transition: all 0.3s ease;
            background-color: #fdfbf7;
        }

        .form-group input:focus {
            outline: none;
            border-color: #7e4e23;
            box-shadow: 0 0 0 3px rgba(126, 78, 35, 0.2);
        }

        button {
            width: 100%;
            background-color: #7e4e23;
            color: white;
            border: none;
            padding: 14px;
            font-size: 1.1em;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            margin-top: 10px;
            box-shadow: 0 4px 10px rgba(126, 78, 35, 0.2);
        }

        button:hover {
            background-color: #6a4220;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(126, 78, 35, 0.3);
        }

        button:active {
            transform: translateY(0);
        }

        .register-link {
            text-align: center;
            margin-top: 25px;
            font-size: 0.95em;
        }

        .register-link a {
            color: #7e4e23;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .register-link a:hover {
            color: #d4b68c;
            text-decoration: underline;
        }

        @media (max-width: 500px) {
            .form-container {
                padding: 0 20px;
            }
            
            .header {
                padding: 20px 0;
            }
            
            .header h1 {
                font-size: 1.8em;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Connexion</h1>
        </div>
        
        <div class="form-container">
            <c:if test="${not empty error}">
                <p class="error">${error}</p>
            </c:if>

            <form action="login" method="post">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required>
                </div>
                
                <div class="form-group">
                    <label for="password">Mot de passe</label>
                    <input type="password" id="password" name="password" required>
                </div>
                
                <button type="submit">Se connecter</button>
            </form>
            
            <p class="register-link">Pas de compte? <a href="register.jsp">S'inscrire</a></p>
        </div>
    </div>
</body>
</html>