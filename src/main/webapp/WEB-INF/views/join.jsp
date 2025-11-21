<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Heegon's Board</title>

<!-- Daum 주소 API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- Bootstrap (디자인용) -->
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
        align-items: flex-start;
        padding: 40px 16px;
    }

    .join-card {
        width: 100%;
        max-width: 900px;
        background: rgba(255, 255, 255, 0.98);
        border-radius: 24px;
        box-shadow: 0 20px 45px rgba(0, 0, 0, 0.08);
        border: 1px solid rgba(152, 231, 170, 0.5);
        padding: 28px 28px 24px 28px;
    }

    .join-title-wrap {
        text-align: center;
        margin-bottom: 20px;
    }

    .join-title-wrap h1 {
        font-size: 1.6rem;
        font-weight: 700;
        color: var(--main-green);
        margin-bottom: 4px;
    }

    .join-title-wrap p {
        margin: 0;
        font-size: 0.9rem;
        color: #7b8a8f;
    }

    /* 기존 table에만 스타일 입히기 */
    table.join-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
        border: none;
        margin: 0 auto;
        font-size: 0.95rem;
    }

    table.join-table tr + tr td {
        border-top: 1px solid var(--border-light);
    }

    table.join-table td {
        padding: 10px 12px;
        border: none;
    }

    table.join-table tr:first-child td {
        border-top: none;
    }

    /* 섹션 헤더 줄 (회원 기본 정보 / 개인 신상 정보) */
    .section-header {
        background: #f0f5f2 !important;
        font-weight: 700;
        color: #34495e;
        padding: 10px 0 !important;
        border-radius: 12px;
    }

    /* 왼쪽 라벨 컬럼 */
    .cell-label {
        width: 22%;
        background: #f7f9f8 !important;
        font-weight: 600;
        color: #4b5964;
        text-align: center;
        white-space: nowrap;
        border-right: 1px solid var(--border-light);
    }

    /* 오른쪽 입력 컬럼 */
    .cell-input {
        text-align: left;
        background: transparent;
    }

    /* input / select / textarea 공통 스타일 (Bootstrap 안 쓰고 순수 CSS) */
    .cell-input input[type="text"],
    .cell-input input[type="password"],
    .cell-input select,
    .cell-input textarea {
        border: 1px solid #d1e2d8;
        border-radius: 8px;
        padding: 6px 10px;
        font-size: 0.95rem;
        outline: none;
        box-sizing: border-box;
    }

    .cell-input input[type="text"]:focus,
    .cell-input input[type="password"]:focus,
    .cell-input select:focus,
    .cell-input textarea:focus {
        border-color: var(--main-green);
        box-shadow: 0 0 0 2px rgba(39, 169, 50, 0.17);
    }

    .cell-input input[readonly] {
        background: #f5f7f6;
        cursor: pointer;
    }

    .inline-hint {
        font-size: 0.8rem;
        color: #7f8c8d;
        margin-left: 8px;
    }

    .birth-select {
        margin-left: 4px;
        margin-right: 4px;
    }

    /* 버튼 영역 */
    .btn-row {
        margin-top: 18px;
        display: flex;
        gap: 10px;
        justify-content: center;
    }

    .btn-join-main,
    .btn-join-reset {
        min-width: 150px;
        padding: 9px 18px;
        border-radius: 999px;
        font-weight: 600;
        font-size: 0.95rem;
        border: none;
        cursor: pointer;
        transition: all 0.18s ease-in-out;
    }

    .btn-join-main {
        background: linear-gradient(135deg, #27a932, #6ddc5f);
        color: #fff;
        box-shadow: 0 10px 20px rgba(39, 169, 50, 0.28);
    }

    .btn-join-main:hover {
        transform: translateY(-1px);
        box-shadow: 0 14px 28px rgba(39, 169, 50, 0.38);
    }

    .btn-join-reset {
        background: #ffffff;
        color: #4b5b60;
        border: 1px solid #cfe9d7;
    }

    .btn-join-reset:hover {
        background: #f4fff7;
        transform: translateY(-1px);
    }

    /* 관심분야 체크박스 영역 정리 */
    #interest input[type="checkbox"] {
        margin-right: 4px;
        margin-left: 0;
    }
    #interest {
        line-height: 2;
    }

    textarea#introduce {
        width: 100%;
        min-height: 100px;
    }

    @media (max-width: 768px) {
        .join-card {
            padding: 20px 16px 18px 16px;
            border-radius: 18px;
        }

        table.join-table td {
            padding: 8px 8px;
            font-size: 0.9rem;
        }

        .cell-label {
            width: 28%;
        }
    }
</style>
</head>

<body>

<div class="page-wrapper">
    <div class="join-card">

        <div class="join-title-wrap">
            <h1>회원 가입</h1>
            <p>Heegon's Board에 오신 걸 환영합니다 🌱</p>
        </div>

        <!-- ★ form / name / id / action / 구조 전부 그대로 유지 ★ -->
        <form method="post" action="joinAction" id="joinForm">
            <table align="center" border="1" cellspacing="0" width="650" class="join-table">

                <tr align="center">
                    <td colspan="2" bgcolor="lightgray" class="section-header">
                        회원 기본 정보
                    </td>
                </tr>

                <tr>
                    <td align="center" bgcolor="#f0f0ef" class="cell-label">아이디:</td>
                    <td align="left" class="cell-input">
                        <input type="text" name="userId" id="userId">
                        <span class="inline-hint">4~12자의 영문 대소문자와 숫자로만 입력</span>
                    </td>
                </tr>
                <tr>
                    <td align="center" bgcolor="#f0f0ef" class="cell-label">비밀번호:</td>
                    <td align="left" class="cell-input">
                        <input type="password" name="password" id="password">
                        <span class="inline-hint">4~12자의 영문 대소문자와 숫자로만 입력</span>
                    </td>
                </tr>
                <tr>
                    <td align="center" bgcolor="#f0f0ef" class="cell-label">비밀번호확인:</td>
                    <td align="left" class="cell-input">
                        <input type="password" name="passwordCheck" id="passwordCheck">
                        <span class="inline-hint">4~12자의 영문 대소문자와 숫자로만 입력</span>
                    </td>
                </tr>
                <tr>
                    <td align="center" bgcolor="#f0f0ef" class="cell-label">메일주소:</td>
                    <td align="left" class="cell-input">
                        <input type="text" name="email" id="email">
                        <span class="inline-hint">예) id@domain.com</span>
                    </td>
                </tr>
                <tr>
                    <td align="center" bgcolor="#f0f0ef" class="cell-label">이름:</td>
                    <td align="left" class="cell-input">
                        <input type="text" name="name" id="name">
                    </td>
                </tr>

                <tr align="center">
                    <td colspan="2" bgcolor="lightgray" class="section-header">
                        개인 신상 정보
                    </td>
                </tr>

                <tr>
                    <td bgcolor="#f0f0ef" class="cell-label">주민등록번호:</td>
                    <td align="left" class="cell-input">
                        <input type="password" name="residentNumber" id="residentNumber">
                        <span class="inline-hint">예) 1234561234567</span>
                    </td>
                </tr>

                <tr>
                    <td bgcolor="#f0f0ef" class="cell-label">생일:</td>
                    <td align="left" class="cell-input">
                        <input type="text" size="5" name="year" id="year" style="max-width:90px;">
                        년
                        <select id="month" name="month" class="birth-select">
                            <option>1</option><option>2</option><option>3</option><option>4</option>
                            <option>5</option><option>6</option><option>7</option><option>8</option>
                            <option>9</option><option>10</option><option>11</option><option>12</option>
                        </select>
                        월
                        <select id="day" name="day" class="birth-select">
                            <option>1</option><option>2</option><option>3</option><option>4</option>
                            <option>5</option><option>6</option><option>7</option><option>8</option>
                            <option>9</option><option>10</option><option>11</option><option>12</option>
                            <option>13</option><option>14</option><option>15</option><option>16</option>
                            <option>17</option><option>18</option><option>19</option><option>20</option>
                            <option>21</option><option>22</option><option>23</option><option>24</option>
                            <option>25</option><option>26</option><option>27</option><option>28</option>
                            <option>29</option><option>30</option><option>31</option>
                        </select>
                        일
                        <a style="font-size:small;">: 주민등록번호를 입력하면 자동입력됩니다.</a>
                    </td>
                </tr>

                <tr>
                    <td align="center" bgcolor="#f0f0ef" class="cell-label">주소:</td>
                    <td align="left" class="cell-input">
                        <input type="text" name="address" id="address" size="30" placeholder="주소 검색 버튼 클릭" readonly>
                        <input type="button" onclick="findAddress()" value="주소 검색">
                        <br>
                        <input type="text" name="detailAddress" id="detailAddress" placeholder="상세 주소 입력" style="margin-top:6px; width:100%;">
                    </td>
                </tr>

                <tr>
                    <td align="center" bgcolor="#f0f0ef" class="cell-label">관심분야:</td>
                    <td align="left" id="interest" name="interest" class="cell-input">
                        <input type="checkbox" name="interest" value="컴퓨터">컴퓨터
                        <input type="checkbox" name="interest" value="인터넷">인터넷
                        <input type="checkbox" name="interest" value="여행">여행
                        <input type="checkbox" name="interest" value="영화감상">영화감상
                        <input type="checkbox" name="interest" value="음악감상">음악감상
                    </td>
                </tr>

                <tr>
                    <td align="center" bgcolor="#f0f0ef" class="cell-label">자기소개:</td>
                    <td align="left" class="cell-input">
                        <textarea cols="50" rows="5" name="introduce" id="introduce"></textarea>
                    </td>
                </tr>

            </table>

            <div class="btn-row">
                <button type="submit" class="btn-join-main">회원 가입</button>
                <button type="reset" class="btn-join-reset">다시 입력</button>
            </div>
        </form>

        <!-- 기존 유효성 검사 / JS 그대로 유지 -->
        <script src="${pageContext.request.contextPath}/resources/join.js"></script>

    </div>
</div>

</body>
</html>
