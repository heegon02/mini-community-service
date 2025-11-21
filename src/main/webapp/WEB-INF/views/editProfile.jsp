<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Heegon's Board</title>

<!-- 주소 검색 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- Bootstrap (디자인 보조용) -->
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

    .page-wrapper {
        min-height: 100vh;
        display: flex;
        justify-content: center;
        padding: 40px 16px;
    }

    .edit-card {
        width: 100%;
        max-width: 900px;
        background: rgba(255, 255, 255, 0.98);
        border-radius: 24px;
        box-shadow: 0 20px 45px rgba(0,0,0,0.08);
        border: 1px solid rgba(152, 231, 170, 0.5);
        padding: 28px;
    }

    .edit-title {
        text-align: center;
        margin-bottom: 20px;
    }

    .edit-title h1 {
        font-size: 1.6rem;
        font-weight: 700;
        color: var(--main-green);
        margin-bottom: 4px;
    }

    table.edit-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
        border: none;
        font-size: 0.95rem;
    }

    table.edit-table tr + tr td {
        border-top: 1px solid var(--border-light);
    }

    table.edit-table td {
        padding: 10px 12px;
        border: none;
    }

    .section-header {
        background: #f0f5f2 !important;
        font-weight: 700;
        color: #34495e;
        padding: 10px 0 !important;
        border-radius: 12px;
    }

    .cell-label {
        width: 22%;
        background: #f7f9f8 !important;
        font-weight: 600;
        color: #4b5964;
        text-align: center;
        white-space: nowrap;
        border-right: 1px solid var(--border-light);
    }

    .cell-input input[type="text"],
    .cell-input input[type="password"],
    .cell-input textarea {
        border: 1px solid #d1e2d8;
        border-radius: 8px;
        padding: 6px 10px;
        font-size: 0.95rem;
        width: 90%;
    }

    .cell-input input:focus,
    .cell-input textarea:focus {
        border-color: var(--main-green);
        box-shadow: 0 0 0 2px rgba(39, 169, 50, 0.17);
    }

    .cell-input input[readonly] {
        background: #f5f7f6;
        cursor: pointer;
    }

    #interest input[type="checkbox"] {
        margin-right: 4px;
    }

    textarea {
        resize: vertical;
        width: 95%;
        min-height: 100px;
    }

    .btn-wrap {
        margin-top: 20px;
        display: flex;
        justify-content: center;
    }

    .btn-save {
        min-width: 180px;
        padding: 10px 18px;
        border-radius: 999px;
        border: none;
        font-weight: 600;
        background: linear-gradient(135deg, #27a932, #6ddc5f);
        color: white;
        box-shadow: 0 10px 22px rgba(39,169,50,0.28);
        transition: 0.2s;
    }

    .btn-save:hover {
        transform: translateY(-1px);
        box-shadow: 0 14px 28px rgba(39,169,50,0.38);
    }
</style>
</head>

<body>

<div class="page-wrapper">
    <div class="edit-card">

        <div class="edit-title">
            <h1>회원 정보 수정</h1>
            <p class="text-muted small">내 정보를 최신 상태로 유지하세요 🌱</p>
        </div>

        <!-- ★ 기존 form 그대로 유지 ★ -->
        <form method="post" action="editProfileAction" id="editForm">
            <table align="center" border="1" cellspacing="0" width="650" class="edit-table">

                <tr align="center">
                    <td colspan="2" bgcolor="lightgray" class="section-header">회원 정보 수정</td>
                </tr>

                <tr>
                    <td class="cell-label">아이디</td>
                    <td class="cell-input">
                        <input type="text" name="userId" value="${editProfile.userId}" readonly>
                    </td>
                </tr>

                <tr>
                    <td class="cell-label">비밀번호</td>
                    <td class="cell-input">
                        <input type="password" name="password" value="${editProfile.password}">
                    </td>
                </tr>

                <tr>
                    <td class="cell-label">이메일</td>
                    <td class="cell-input">
                        <input type="text" name="email" value="${editProfile.email}">
                    </td>
                </tr>

                <tr>
                    <td class="cell-label">이름</td>
                    <td class="cell-input">
                        <input type="text" name="name" value="${editProfile.name}">
                    </td>
                </tr>

                <tr>
                    <td class="cell-label">주소</td>
                    <td class="cell-input">
                        <input type="text" name="address" id="address" value="${editProfile.address}" readonly>
                        <input type="button" onclick="findAddress()" value="주소 검색" style="margin-left:6px;">
                        <br>
                        <input type="text" name="detailAddress" id="detailAddress" value="${editProfile.detailAddress}" style="margin-top:6px;">
                    </td>
                </tr>

                <tr>
                    <td class="cell-label">관심분야</td>
                    <td align="left" id="interest" class="cell-input">

                        <input type="checkbox" name="interest" value="컴퓨터" class="interest">컴퓨터
                        <input type="checkbox" name="interest" value="인터넷" class="interest">인터넷
                        <input type="checkbox" name="interest" value="여행" class="interest">여행
                        <input type="checkbox" name="interest" value="영화감상" class="interest">영화감상
                        <input type="checkbox" name="interest" value="음악감상" class="interest">음악감상

                    </td>
                </tr>

                <tr>
                    <td class="cell-label">자기소개</td>
                    <td class="cell-input">
                        <textarea name="introduce" cols="50" rows="5">${editProfile.introduce}</textarea>
                    </td>
                </tr>

            </table>

            <div class="btn-wrap">
                <button type="submit" class="btn-save">회원 정보 수정</button>
            </div>
        </form>
    </div>
</div>

<script>
    window.onload = function () {
        const interestData = "${editProfile.interest}";
        const checkboxes = document.querySelectorAll(".interest");

        checkboxes.forEach(cb => {
            if (interestData.includes(cb.value)) {
                cb.checked = true;
            }
        });
    }
</script>

<!-- Bootstrap Script -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
