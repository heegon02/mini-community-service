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
        --border-light: #e3eee6;
    }

    body {
        background: radial-gradient(circle at top left, #ecfff3, #f7faf8 50%, #ffffff 100%);
        font-family: 'Noto Sans KR', sans-serif;
        margin: 0;
        padding: 0;
    }

    .modify-wrapper {
        min-height: 100vh;
        display: flex;
        justify-content: center;
        padding: 40px 16px;
    }

    .modify-card {
        width: 100%;
        max-width: 750px;
        background: rgba(255, 255, 255, 0.98);
        border-radius: 24px;
        padding: 32px;
        box-shadow: 0 20px 45px rgba(0,0,0,0.08);
        border: 1px solid rgba(152, 231, 170, 0.4);
    }

    .modify-title {
        text-align: center;
        margin-bottom: 20px;
        font-size: 1.6rem;
        font-weight: 700;
        color: var(--main-green);
    }

    .modify-sub {
        text-align: center;
        font-size: 0.9rem;
        color: #7b8a8f;
        margin-bottom: 10px;
    }

    table.modify-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
        font-size: 0.95rem;
    }

    table.modify-table td {
        padding: 10px 10px;
        vertical-align: middle;
    }

    .label-cell {
        width: 20%;
        background: #f7f9f8;
        font-weight: 600;
        color: #4b5964;
        text-align: center;
        border-right: 1px solid var(--border-light);
        white-space: nowrap;
    }

    .value-cell {
        text-align: left;
    }

    .value-cell input[type="text"],
    .value-cell textarea {
        width: 100%;
        border: 1px solid #d1e2d8;
        border-radius: 8px;
        padding: 6px 10px;
        font-size: 0.95rem;
        box-sizing: border-box;
        outline: none;
        resize: vertical;
    }

    .value-cell input[type="text"]:focus,
    .value-cell textarea:focus {
        border-color: var(--main-green);
        box-shadow: 0 0 0 2px rgba(39,169,50,0.17);
    }

    .value-cell input[readonly] {
        background: #f5f7f6;
    }

    .readonly-text {
        padding: 6px 0;
        color: #374151;
    }

    .btn-row {
        margin-top: 24px;
        text-align: center;
    }

    .btn-main {
        background: linear-gradient(135deg, #27a932, #6ddc5f);
        color: #fff;
        font-weight: 600;
        padding: 9px 20px;
        border-radius: 999px;
        border: none;
        box-shadow: 0 10px 22px rgba(39,169,50,0.28);
        transition: 0.2s;
        margin-right: 10px;
        min-width: 100px;
    }

    .btn-main:hover {
        color: #fff;
        transform: translateY(-1px);
        box-shadow: 0 14px 28px rgba(39,169,50,0.38);
    }

    .btn-sub {
        display: inline-block;
        padding: 9px 16px;
        border-radius: 999px;
        border: 1px solid #cfe9d7;
        background: #ffffff;
        font-weight: 500;
        font-size: 0.9rem;
        color: #4b5b60;
        text-decoration: none;
        margin-right: 8px;
        min-width: 90px;
        transition: 0.2s;
    }

    .btn-sub:hover {
        background: #f4fff7;
        transform: translateY(-1px);
        text-decoration: none;
        color: #2f3b42;
    }

    .btn-danger-sub {
        border-color: #f5c2c7;
        color: #b02a37;
    }

    .btn-danger-sub:hover {
        background: #fff5f5;
        color: #842029;
    }

</style>
</head>
<body>

<div class="modify-wrapper">
    <div class="modify-card">

        <div class="modify-title">게시글 수정</div>
        <div class="modify-sub">내용을 수정한 후 저장하거나, 삭제/답변 기능을 사용할 수 있습니다.</div>

        <!-- 기존 form / action / name / value 전부 유지 -->
        <table width="500" cellpadding="0" cellspacing="0" border="1" class="modify-table">
            <form action="modify" method="post">
                <input type="hidden" name="bId" value="${content_view.bId}">

                <tr>
                    <td class="label-cell">번호</td>
                    <td class="value-cell">
                        <span class="readonly-text">${content_view.bId}</span>
                    </td>
                </tr>
                <tr>
                    <td class="label-cell">히트</td>
                    <td class="value-cell">
                        <span class="readonly-text">${content_view.bHit}</span>
                    </td>
                </tr>
                <tr>
                    <td class="label-cell">이름</td>
                    <td class="value-cell">
                        <input type="text" name="bName" value="<%=name %>" readonly>
                    </td>
                </tr>
                <tr>
                    <td class="label-cell">제목</td>
                    <td class="value-cell">
                        <input type="text" name="bTitle" value="${content_view.bTitle}">
                    </td>
                </tr>
                <tr>
                    <td class="label-cell">내용</td>
                    <td class="value-cell">
                        <textarea rows="10" name="bContent">${content_view.bContent}</textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="value-cell">
                        <div class="btn-row">
                            <input type="submit" value="수정" class="btn-main">

                            <a href="main" class="btn-sub">목록보기</a>
                            <a href="delete?bId=${content_view.bId}" class="btn-sub btn-danger-sub">삭제</a>
                            <a href="reply_view?bId=${content_view.bId}" class="btn-sub">답변</a>
                        </div>
                    </td>
                </tr>
            </form>
        </table>

    </div>
</div>

<!-- Bootstrap JS (선택사항, 있어도 되고 없어도 됨) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
