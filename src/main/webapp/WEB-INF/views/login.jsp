<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Heegon's Board</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    :root {
        --main-green: #27a932;
        --soft-green: #d2f8d7;
        --soft-bg: #f7faf8;
    }

    body {
        background: radial-gradient(circle at top left, #ecfff3, #f7faf8 50%, #ffffff 100%);
        font-family: 'Noto Sans KR', sans-serif;
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .login-card {
        width: 100%;
        max-width: 420px;
        background: rgba(255, 255, 255, 0.95);
        border-radius: 22px;
        padding: 32px;
        box-shadow: 0 20px 40px rgba(0,0,0,0.08);
        border: 1px solid rgba(152, 231, 170, 0.4);
        animation: fadeUp 0.5s ease-out;
    }

    @keyframes fadeUp {
        from { opacity: 0; transform: translateY(15px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .btn-main {
        width: 100%;
        background: linear-gradient(135deg, #27a932, #59d957);
        color: white;
        border-radius: 50px;
        padding: 10px 0;
        font-weight: 600;
        box-shadow: 0 10px 20px rgba(39,169,50,0.25);
        border: none;
        transition: 0.2s;
    }

    .btn-main:hover {
        box-shadow: 0 14px 26px rgba(39,169,50,0.35);
        transform: translateY(-2px);
        color: #fff;
    }

    .btn-sub {
        width: 100%;
        background: #ffffff;
        border-radius: 50px;
        padding: 10px 0;
        font-weight: 500;
        border: 1px solid #bceec7;
        transition: 0.2s;
    }

    .btn-sub:hover {
        background: #f3fff6;
        transform: translateY(-2px);
    }

    .title {
        color: var(--main-green);
        font-weight: 700;
        margin-bottom: 25px;
        text-align: center;
    }

</style>
</head>

<body>

<div class="login-card">
    <h2 class="title">로그인</h2>

    <form method="post" action="loginAction" name="Loginform">

        <!-- 아이디 -->
        <div class="mb-3 text-start">
            <label class="form-label fw-bold">ID</label>
            <input type="text" name="userId" class="form-control form-control-sm" placeholder="아이디를 입력하세요">
        </div>

        <!-- 비밀번호 -->
        <div class="mb-4 text-start">
            <label class="form-label fw-bold">Password</label>
            <input type="password" name="password" class="form-control form-control-sm" placeholder="비밀번호를 입력하세요">
        </div>

        <!-- 로그인 버튼 -->
        <button type="submit" class="btn-main mb-3">로그인</button>

        <!-- 회원가입 버튼 -->
        <button type="button" class="btn-sub" onclick="location.href='join'">회원가입</button>

    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
