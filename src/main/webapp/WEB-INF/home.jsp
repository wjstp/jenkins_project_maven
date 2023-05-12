<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Jua&family=Lobster&family=Nanum+Pen+Script&family=Single+Day&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <style>
body, body * {
    font-family:'Jua';
}

    </style>
</head>
<body>
jenkins에 maven project 배포 연습
<h5>젠킨스에 배포 성공했습니다!</h5>
깃허브 자동화 테스트,,
멍청 민서기
<div>
    <textarea style="width: 100%; height: 120px; " class="form-control"
    id="msg">프로젝트 진행잘되어가고 있나요?</textarea>
</div>
<div class="input-group" style="width: 250px; margin-left: 50px;">
    <select id="seltrans" class="form-select">
        <option value="ko">한국어</option>
        <option value="en">영어</option>
        <option value="ja">일어</option>
        <option value="zh-CN">중국어</option>
        <option value="es">스페인어</option>
        <option value="de">독일어</option>
    </select>
    <button type="button" id="btntrans" class="btn btn-outline-danger">번역하기</button>
    <i class="bi bi-megaphone speak voicespeak" style="font-size: 30px; margin-left: 10px; cursor: pointer"></i>
    <br>
    <div id="trans"style="postion:absolute; top: 200px; padding-left: 20px;"></div>


</div>
<script type="text/javascript">
    $("#btntrans").click(function(){
        //입력한 메세지
        let msg=$("#msg").val();
        //선택한 나라 기호
        let lang=$("#seltrans").val();
        $.ajax({
            type:"post",
            url:"./trans",
            data:{"msg":msg, "lang":lang},//보내는 정보
            dataType:"text",//return 타입,, String 반환되므로
            success: function(res){
               // alert(res);
                //Stringd을 json 데이터로 받는다
                let j=JSON.parse(res);
                //번역한 문자열을 얻는다
                let s=j.message.result.translatedText;
                //div 에 출력
                $("#trans").html(s);
            }
        })
    })
    //스피커 클릭시
    $(".voicespeak").click(function(){
        //입력한 메세지
        let msg=$("#trans").text();
        //선택한 나라 기호
        let lang=$("#seltrans").val();
        if(lang=='en'||lang=='ja'||lang=='zh-CN'||lang=='ko'||lang=='es'){
        $.ajax({
            type:"get",
            url:"./voice",
            data:{"msg":msg, "lang":lang},//보내는 정보
            dataType:"text",//return 타입,, String 반환되므로 mp3파일명이 반환됨
            success: function(res){//res에는 오디오 파일이 들어감
                // alert(res);
                let audio=new Audio(res);
                audio.play();
            }
        })}else{
            alert("독일어는 지원안합니다.");
        }
    })
</script>
</body>
</html>
