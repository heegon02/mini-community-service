<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String name = (String) session.getAttribute("name");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Heegon's Board</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom Theme -->
<style>
    :root {
        --main-green: #27a932;
        --soft-green: #d2f8d7;
        --soft-bg: #f7faf8;
    }

    body {
        background: radial-gradient(circle at top left, #ecfff3, #f7faf8 50%, #ffffff 100%);
        font-family: 'Noto Sans KR', sans-serif;
        margin: 0;
        padding: 0;
    }

    .write-wrapper {
        display: flex;
        justify-content: center;
        padding: 40px 16px;
    }

    .write-card {
        width: 100%;
        max-width: 750px;
        background: rgba(255, 255, 255, 0.98);
        border-radius: 24px;
        padding: 32px;
        box-shadow: 0 20px 45px rgba(0,0,0,0.08);
        border: 1px solid rgba(152,231,170,0.4);
    }

    .write-title {
        text-align: center;
        margin-bottom: 25px;
        color: var(--main-green);
        font-weight: 700;
    }

    .write-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
    }

    .write-table td {
        padding: 12px 10px;
        vertical-align: middle;
        font-size: 0.95rem;
    }

    .label-cell {
        width: 20%;
        background: #f7f9f8;
        font-weight: 600;
        color: #4b5964;
        text-align: center;
        border-right: 1px solid #e3eee6;
        border-radius: 10px 0 0 10px;
    }

    .input-cell input[type="text"],
    .input-cell textarea {
        width: 100%;
        border: 1px solid #d1e2d8;
        border-radius: 8px;
        padding: 8px 10px;
        font-size: 1rem;
        outline: none;
        resize: vertical;
        box-sizing: border-box;
    }

    .input-cell input:focus,
    .input-cell textarea:focus {
        border-color: var(--main-green);
        box-shadow: 0 0 0 2px rgba(39, 169, 50, 0.17);
    }

    .btn-area {
        margin-top: 25px;
        text-align: center;
    }

    .btn-main {
        background: linear-gradient(135deg, #27a932, #6ddc5f);
        color: white;
        font-weight: 600;
        padding: 9px 20px;
        border-radius: 999px;
        border: none;
        box-shadow: 0 10px 22px rgba(39,169,50,0.28);
        transition: 0.2s;
        margin-right: 10px;
        min-width: 120px;
    }

    .btn-main:hover {
        transform: translateY(-1px);
        box-shadow: 0 14px 28px rgba(39,169,50,0.38);
    }

    .btn-sub {
        background: #ffffff;
        color: #4b5b60;
        border: 1px solid #cfe9d7;
        font-weight: 600;
        padding: 9px 20px;
        border-radius: 999px;
        transition: 0.2s;
        min-width: 120px;
    }

    .btn-sub:hover {
        background: #f4fff7;
        transform: translateY(-1px);
    }

</style>
</head>

<body>

<div class="write-wrapper">
    <div class="write-card">

        <h2 class="write-title">새 글 작성</h2>

        <!-- ★ 기존 기능/이름/구조 그대로! -->
        <form action="write" method="post">
            <table class="write-table">

                <tr>
                    <td class="label-cell">이름</td>
                    <td class="input-cell">
                        <input type="text" name="bName" size="50" value="<%=name %>" readonly>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">제목</td>
                    <td class="input-cell">
                        <input type="text" name="bTitle" size="50">
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">내용</td>
                    <td class="input-cell">
                        <textarea name="bContent" rows="10"></textarea>
                    </td>
                </tr>

            </table>

            <div class="btn-area">
                <input type="submit" class="btn-main" value="입력">
                <a href="main" class="btn-sub">목록 보기</a>
            </div>
        </form>

    </div>
</div>

<!-- Bootstrap Script -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
