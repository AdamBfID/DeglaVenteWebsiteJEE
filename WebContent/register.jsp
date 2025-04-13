<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Palmora-Inscription</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
        }

        body {
            background-image: url("images/LoginBg.jpg");
            background-size: cover;
            color: #111;
            line-height: 1.5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 14px;
        }

        .container {
            width: 100%;
            max-width: 350px;
            background-color: #fff;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px 26px;
        }

        .header {
            margin-bottom: 28px;
        }

        .header h1 {
            color: #6b4423;
            font-size: 28px;
            font-weight: 400;
            margin-bottom: 10px;
        }

        .error {
            color: #c40000;
            background-color: #fff;
            padding: 8px 12px;
            border-radius: 4px;
            font-size: 13px;
            margin-bottom: 14px;
            border: 1px solid #c40000;
            border-radius: 4px;
        }

        .error-icon {
            color: #c40000;
            margin-right: 5px;
        }

        .success {
            color: #007600;
            background-color: #fff;
            padding: 8px 12px;
            border-radius: 4px;
            font-size: 13px;
            margin-bottom: 14px;
            border: 1px solid #007600;
            border-radius: 4px;
        }

        .success-icon {
            color: #007600;
            margin-right: 5px;
        }

        .form-group {
            margin-bottom: 14px;
        }

        .form-group label {
            display: block;
            color: #111;
            margin-bottom: 5px;
            font-weight: 700;
            font-size: 13px;
        }

        .form-group input {
            width: 100%;
            padding: 7px 10px;
            height: 31px;
            border: 1px solid #a6a6a6;
            border-top-color: #949494;
            border-radius: 3px;
            box-shadow: 0 1px 0 rgba(255,255,255,.5), 0 1px 0 rgba(0,0,0,.07) inset;
            font-size: 14px;
            background-color: #fff;
        }

        .form-group input:focus {
            outline: none;
            border-color: #724e1b;
            box-shadow: 0 0 0 2px rgba(114, 78, 27, 0.5);
        }

        button {
            width: 100%;
            background: linear-gradient(to bottom, #8c6239 0%, #7c5531 100%);
            border: 1px solid;
            border-color: #6c4c2b #5a3e24 #4e351e;
            color: white;
            padding: 7px 0;
            height: 31px;
            font-size: 13px;
            border-radius: 3px;
            cursor: pointer;
            font-weight: 400;
            margin-top: 18px;
            box-shadow: 0 1px 0 rgba(255,255,255,.4) inset;
        }

        button:hover {
            background: linear-gradient(to bottom, #7c5531 0%, #6c4c2b 100%);
        }

        button:active {
            background: #6c4c2b;
            box-shadow: 0 1px 3px rgba(0,0,0,.2) inset;
        }

        .divider {
            position: relative;
            text-align: center;
            margin: 24px 0;
            height: 1px;
            background-color: #e7e7e7;
        }

        .divider span {
            position: relative;
            top: -7px;
            background-color: #fff;
            padding: 0 8px;
            color: #767676;
            font-size: 12px;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
            font-size: 13px;
        }

        .login-link-button {
            display: block;
            width: 100%;
            padding: 7px 0;
            text-align: center;
            background: linear-gradient(to bottom, #f7f8fa, #e7e9ec);
            border-radius: 3px;
            border: 1px solid;
            border-color: #adb1b8 #a2a6ac #8d9096;
            color: #111;
            box-shadow: 0 1px 0 rgba(255,255,255,.6) inset;
            margin-top: 10px;
            cursor: pointer;
            font-size: 13px;
            text-decoration: none;
        }

        .login-link-button:hover {
            background: linear-gradient(to bottom, #e7e9ec, #dfe1e5);
        }

        .security-notice {
            margin-top: 18px;
            font-size: 12px;
            color: #555;
            line-height: 1.5;
        }

        .security-notice a {
            color: #0066c0;
            text-decoration: none;
        }

        .security-notice a:hover {
            color: #c45500;
            text-decoration: underline;
        }

        .logo {
            text-align: center;
            margin-bottom: 18px;
        }

        .logo-text {
            font-size: 24px;
            font-weight: bold;
            color: #6b4423;
        }

        @media (max-width: 500px) {
            .container {
                max-width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">
            <span class="logo-text">Bienvenue à Palmora</span>
        </div>
        
        <div class="header">
            <h1>Créer un compte</h1>
        </div>
        
        <c:if test="${not empty success}">
            <div class="success">
                <span class="success-icon">✓</span> ${success}
            </div>
        </c:if>
        
        <c:if test="${not empty errors}">
            <div class="error">
                <span class="error-icon">⚠</span> Veuillez corriger les erreurs ci-dessous.
            </div>
        </c:if>

        <form action="register" method="post">
            <!-- Name Field -->
            <div class="form-group">
                <label for="nom">Nom complet</label>
                <input type="text" id="nom" name="nom" value="${param.nom}" required>
                <c:if test="${not empty errors.nomError}">
                    <span class="error">${errors.nomError}</span>
                </c:if>
            </div>

            <!-- Email Field -->
            <div class="form-group">
                <label for="email">Adresse e-mail</label>
                <input type="email" id="email" name="email" value="${param.email}" required>
                <c:if test="${not empty errors.emailError}">
                    <span class="error">${errors.emailError}</span>
                </c:if>
            </div>

            <!-- Password Field -->
            <div class="form-group">
                <label for="password">Mot de passe (8 caractères minimum)</label>
                <input type="password" id="password" name="password" required>
                <c:if test="${not empty errors.passwordError}">
                    <span class="error">${errors.passwordError}</span>
                </c:if>
            </div>

            <!-- Confirm Password Field -->
            <div class="form-group">
                <label for="confirmPassword">Confirmer le mot de passe</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
                <c:if test="${not empty errors.confirmError}">
                    <span class="error">${errors.confirmError}</span>
                </c:if>
            </div>
            
            <button type="submit">Créer votre compte</button>
        </form>
        
        <div class="security-notice">
            En créant un compte, vous acceptez les <a href="#">Conditions d'utilisation</a> et la <a href="#">Notice Protection de vos informations personnelles</a>.
        </div>
        
        <div class="divider">
            <span>Déjà client ?</span>
        </div>
        
        <a href="login.jsp" class="login-link-button">Se connecter</a>
    </div>
</body>
</html>