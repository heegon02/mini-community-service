//id 유효성검사
function checkId() {

    var userId = document.getElementById("userId").value.trim();
    const idRegex = /^[a-zA-Z0-9]{4,12}$/;

    if(!idRegex.test(userId)) {
        alert("아이디 입력 형식 오류");
        return false;
    }
    return true;
}    
    
//password 유효성검사
function checkPassword() {
    var password = document.getElementById("password").value.trim();
    var userId = document.getElementById("userId").value.trim();
    const pwRegex = /^[a-zA-Z0-9]{4,12}$/;

    if (!pwRegex.test(password)) {
        alert("비밀번호는 4~12자의 영문 대소문자와 숫자로만 입력해야 합니다.");
        return false;
    }

    if (password === userId) {
        alert("아이디와 비밀번호는 같을 수 없습니다.");
        return false;
    }
    return true;
}


//password확인 유효성검사
function checkPassword2() {

    var password = document.getElementById("password").value.trim();
    var password2 = document.getElementById("passwordCheck").value.trim();

    if (password2 !== password) {
        alert("비밀번호와 비밀번호확인이 서로 다릅니다.");
        return false;
    }
    return true;
}

//메일주소 유효성검사
function checkEmail() {

    var email = document.getElementById("email").value.trim();
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if(!emailRegex.test(email)) {
        alert("메일 주소 형식이 정해져 있습니다. ");
        return false;
    }
    return true;
}

//주민등록번호 유효성 검사 및 생일 자동 입력
function checkResidentNum() {

    var residentNumber = document.getElementById("residentNumber").value.trim();
    const pwRegex = /^[0-9]{13}$/;

    if(!pwRegex.test(residentNumber)) {
        alert("주민등록번호는 13자리를 입력해야 합니다.");
        return false;
    }

    let sum = 0;
    const multipliers = [2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5];

    for (let i = 0; i<12; i++) {
        sum += parseInt(residentNumber.charAt(i)) * multipliers[i];
    }

    const calculatedVerifyNum = (11 - (sum % 11)) % 10;

    if(calculatedVerifyNum !== parseInt(residentNumber.charAt(12))) {
        alert("유효하지 않은 주민등록번호입니다.");
        return false;
    }

    //주민등록번호에서 생년월일 추출
    var yearPrefix = (residentNumber.charAt(7) === "1" || residentNumber.charAt(7) === "2") ? "19" : "20";
    var year = yearPrefix + residentNumber.substring(0, 2);
    var month = residentNumber.substring(2, 4);
    var day = residentNumber.substring(4, 6);

    //생년월일 자동으로 채우기
	document.getElementById("year").value = year;
	document.getElementById("month").value = parseInt(month, 10);
	document.getElementById("day").value = parseInt(day, 10);

    return true;
}

//주소 입력
function findAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = ''; 
            var extraAddr = ''; 
                
            if (data.userSelectedType === 'R') {
                addr = data.roadAddress;
            } else { 
                addr = data.jibunAddress;
            }

            document.getElementById('address').value = addr;
            document.getElementById('detailAddress').value = extraAddr;

        }
    }).open();
}

//주소랑 상세주소 입력 유효성검사
function checkAddress() {
    var address = document.getElementById("address").value.trim();
    var address2 = document.getElementById("detailAddress").value.trim();

    const addRegex = /^.{1,}$/;

    if(!addRegex.test(address) || !addRegex.test(address2)) {
        alert("주소와 상세주소를 입력하세요.");
        return false;
    }
    return true;
}

//관심분야 유효성검사
function checkInterest() {
    var interests = document.querySelectorAll("#interest input[type='checkbox']");
    let checked = false;
    interests.forEach(cb => {
        if (cb.checked) checked = true;
    });

    if (!checked) {
        alert("관심분야를 한 가지 이상 선택해야 합니다.");
        return false;
    }
    return true;
}

//자기소개 유효성검사
function checkIntroduce() {
    var introduce = document.getElementById("introduce").value.trim();
    var introRegex = /^.{20,}$/;

    if(!introRegex.test(introduce)) {
        alert("자기소개는 20글자 이상은 입력해주세요.");
        return false;
    }
    return true;
}

//회원가입 버튼 이벤트 (유효성 검사)
document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("joinForm");

    form.addEventListener("submit", (e) => {
        if (!checkId() || !checkPassword() || !checkPassword2() || !checkEmail()
         || !checkResidentNum() || !checkAddress() ||!checkInterest() ||!checkIntroduce() ) {
            e.preventDefault(); 
        }
    });
});