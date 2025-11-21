<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String userId = (String) session.getAttribute("userId");
    String name = (String) session.getAttribute("name");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Heegon's Board</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        :root {
            --main-green: #27a932;
            --soft-bg: #f7faf8;
        }

        body {
            background: radial-gradient(circle at top left, #ecfff3, #f7faf8 50%, #ffffff 100%);
            font-family: 'Noto Sans KR', sans-serif;
        }

        .app-navbar {
            background: linear-gradient(120deg, #c4f5d0, #e6fff0);
            box-shadow: 0 15px 35px rgba(0,0,0,0.08);
        }

        .btn-soft {
            border-radius: 999px;
            border: 1px solid rgba(39,169,50,0.28);
            background: rgba(255,255,255,0.85);
            padding: 6px 14px;
            text-decoration: none;
            display: inline-flex;
            gap: 6px;
            align-items: center;
        }

        .btn-main {
            background: linear-gradient(135deg, #27a932, #6ddc5f);
            border-radius: 999px;
            padding: 6px 16px;
            color: #fff;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            box-shadow: 0 8px 18px rgba(39,169,50,0.35);
        }

        .board-header-card {
            background: rgba(255,255,255,0.9);
            border-radius: 24px;
            box-shadow: 0 16px 40px rgba(0,0,0,0.06);
        }

        .table-board {
            border-collapse: separate;
            border-spacing: 0 12px;
        }

        .table-board tbody tr {
            background: rgba(255,255,255,0.96);
            border-radius: 14px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.06);
        }

        .badge-reply {
            background: rgba(214,244,221,0.7);
            padding: 3px 7px;
            border-radius: 999px;
            font-size: 0.75rem;
            color: var(--main-green);
        }
    </style>
</head>

<body>

<!-- 상단 헤더 -->
<nav class="app-navbar py-3 mb-4">
    <div class="container d-flex justify-content-between align-items-center">
        <div>
            <div class="fw-bold text-success fs-5"><%= name %> 님, 환영합니다 🌱</div>
            <div class="small text-muted">편하게 글을 남기세요.</div>
        </div>

        <div class="d-flex gap-2">
            <a href="logout" class="btn-soft text-success">
                <img src="resources/logout.png" height="18"> 로그아웃
            </a>

            <a href="editProfile" class="btn-soft text-success">
                <img src="resources/edit.png" height="18"> 정보 수정
            </a>
        </div>
    </div>
</nav>

<main class="d-flex justify-content-center">
    <div class="board-wrapper w-100 px-3" style="max-width:1050px;">

        <!-- 상단 카드 -->
        <div class="board-header-card p-4 mb-4">
            <div class="d-flex justify-content-between">
                <div>
                    <h3 class="text-success fw-bold mb-1">게시판</h3>
                    <div class="text-muted small">최근 글을 확인하세요.</div>
                </div>

                <a href="write_view" class="btn-main">
                    <img src="resources/writeBoard.png" height="20"> 새 글 작성
                </a>
            </div>
        </div>

        <!-- 현재 시간 (NEW 계산용) -->
        <jsp:useBean id="now" class="java.util.Date" />

        <!-- 게시글 목록 -->
        <div class="table-responsive">
            <table class="table table-board align-middle">
                <thead>
                <tr class="text-center small">
                    <th class="text-start ps-3">Num.</th>
                    <th>작성자</th>
                    <th></th>
                    <th class="text-start">제목</th>
                    <th>작성 날짜</th>
                    <th class="text-end pe-3">조회수</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach items="${list}" var="dto">
                    <tr>

                        <!-- 글번호 -->
                        <td class="text-start ps-3 fw-semibold">${dto.bId}</td>

                        <!-- 작성자 -->
                        <td class="text-center">
                            <span class="badge rounded-pill text-bg-light px-3 py-2">
                                ${dto.bName}
                            </span>
                        </td>

                        <td></td>

                        <!-- 제목 -->
                        <td class="text-start">

                            <c:forEach begin="1" end="${dto.bIndent}">&nbsp;</c:forEach>

                            <span style="margin-left:${dto.bIndent * 14}px;">

                                <c:if test="${dto.bIndent > 0}">
                                    <span class="badge-reply">ㄴ</span>
                                </c:if>

                                <a href="content_view?bId=${dto.bId}">
                                    ${dto.bTitle}
                                </a>

                                <!-- NEW 표시 -->
                                <c:set var="writeDate" value="${dto.bDate}" />
                                <c:set var="diffMs" value="${now.time - writeDate.time}" />
                                <c:set var="diffHours" value="${diffMs / 3600000}" />

                                <c:if test="${diffHours < 3}">
                                    <span class="badge ms-2"
                                          style="background:#27a932; color:white; border-radius:999px; font-size:0.7rem;">
                                        NEW
                                    </span>
                                </c:if>

                            </span>
                        </td>

                        <!-- 작성 날짜 -->
                        <td class="text-center small">
                            <fmt:formatDate value="${dto.bDate}" pattern="yyyy-MM-dd HH:mm:ss" timeZone="Asia/Seoul" />
                        </td>

                        <!-- 조회수 -->
                        <td class="text-end pe-3 fw-semibold">${dto.bHit}</td>

                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</main>

<!-- 하단 이미지 -->
<footer class="mt-5">
    <img src="resources/bottomImage.jpg" class="w-100">
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
