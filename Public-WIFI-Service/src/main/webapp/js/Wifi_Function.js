
/**
 * wifi 함수
 */


/*
	내 위치 찾기
*/
function bindLocation(LAT, LNT){
	document.getElementById("LAT").value = LAT;
	document.getElementById("LNT").value = LNT;
}


/*
	북마크 그룹 정보 저장
*/
function insertBookMark(){
	if(document.getElementById("bookMarkName").value == "" || document.getElementById("bookMarkSeq").value == ""){
		alert("북마크 그룹명과 순서를 입력하세요.");
		return false;
	} else {
		document.getElementById("btnBookMarkAdd").value = document.getElementById("bookMarkName").value
					+ "," + document.getElementById("bookMarkSeq").value;
		return true;
	}
}


/*
	북마크 그룹 정보 수정
*/
function updateBookMark(updateId){
	if(document.getElementById("bookMarkName").value == "" || document.getElementById("bookMarkSeq").value == ""){
		alert("북마크 그룹명과 순서를 입력하세요.");
		return false;
	} else {
		document.getElementById("bookMarkUpdate").value = updateId + "," + document.getElementById("bookMarkName").value
					+ "," + document.getElementById("bookMarkSeq").value;
		return true;
	}
}


/*
	북마크 추가 전 확인
*/
function chkSelector(){
	
	if(groupForm.groupList.value == ""){
		alert("북마크 그룹 이름을 선택하세요");
		groupForm.groupList.focus(); 
		return false;
	}
	
	return true;
}