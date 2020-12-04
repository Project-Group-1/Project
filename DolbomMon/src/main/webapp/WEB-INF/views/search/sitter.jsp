<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device, initial-scale=1" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.css" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="<%=request.getContextPath() %>/css/bootstrap.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&family=Noto+Sans+KR:wght@300;400&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<style>

	.container{width:1100px;}


	img{ height:110px; width:110px;}

	
	<!-- 액션 캡슐 버튼 -->

	.btn1{
	    color: #434343;
	    padding: 10px 14px;
	    border-radius: 16px;
	    border: 1px solid #ddd;
	    margin: 5px 6px 10px 0;
	    display: inline-block;
	    cursor: pointer;
	    font-size: 13px;
	    font-weight: 400;
	    line-height: 12px;
	    text-align: center;
	    width:90px;
	    background-color:white;
	    border-color:orange;
	}
	
	#actBox{
	width: 100%; 
	white-space: nowrap; 
  	display: inline-block; 
  	vertical-align: top;
  	}
  	

	 .list-group-item {
	 	width:1000px;
	 	margin:10px auto;
	 }
	   


	 input[type=text]{
	  width:100%;
	 }
	 /*#mapBox{
	 width:100%;
	 height: 610px;
	   display:none;
	 }*/
	#map{
	width:100%;
	height:500px;
	border-bottom-left-radius:20px;
	border-bottom-right-radius:20px;
	
	}
	
	.card>.profilepic {
	width:100%; 
	height:300px;
	border-top-left-radius:20px; 
	border-top-right-radius:20px;
	}
	
	.card{
	margin: 20px 17px; 
	width:30%; 
	height: 500px;
	border:1px orange solid; 
	border-radius:20px; 
	float:left; 
	display:block;
	}
	i{
	color:orange;
	}


</style>

<script>
	$(function(){
		
	
	    //  $(document).on("click",".wrapper2>ul", function(){
	     //     location.href="teacherView?userid="+$(this).attr('id');   
	    //   });

	    /* 
	    function filterLoc(){
	    	  var value = document.getElementById("locFilter").value.toLowerCase();
	    	  var item = document.getElementbyClassName("wrapper2");
		for(i=0;item)
	      }*/
	      $(document).on("click", "#mapBtn", function(){
				$("#map").toggle();
			});
			
	    $(document).on("keyup", "#locFilter", function(){
	    	var value = $(this).val().toLowerCase();
	    	$(".loc").filter(function(){
	    		$(this).parent().parent().toggle($(this).text().toLowerCase().indexOf(value)>-1);
				    		
	    	});
	    });
	    
	
		
		//========================ajax=========
	    $(document).on("click", "#actBox>button", (function(){
	    	var activity_type = $(this).text();
	    	console.log(activity_type);
	    	var url = "/dbmon/searchAct1";
			var params = "activity_type="+activity_type;

			$.ajax({
				url:url,
				data:params,
				type:'GET',
				success:function(result){
					
					var $result = $(result);
					var tag = "";
					
					$result.each(function(idx, vo){
					
						tag += '<div class="card" onclick="location.href="teacherView?userid='+vo.userid+'"" >';
						tag += '<img class="profilepic" src=';
						if(vo.pic==null){
							tag +='"img/profilepic.png"';
						} else {
							tag +='"upload/' +vo.pic+ '"';
						}
						tag += '/><br/>';
						tag += '<div class="card-body">';
							tag += '<h5 class="card-title"><b>' + vo.username.substring(0,1)+'O'+vo.username.substring(2)+'</b>';
							
							tag += '<span class="ml-2" style="font-size:0.7em">';
							if(vo.last_edit>525600){
								tag += Math.round(vo.last_edit/525600)+'년';
							} else if(vo.last_edit>43200){
								tag += Math.round(vo.last_edit/43200) +'달';
							} else if(vo.last_edit>1440){
								tag += Math.round(vo.last_edit/1440) +'일';
							} else if(vo.last_edit>60){
								tag += Math.round(vo.last_edit/60) +'시간';
							} else {
								tag += Math.round(vo.last_edit) +'분';
							}
							tag += '</span>';
							tag += '<img src="https://s3.ap-northeast-2.amazonaws.com/momsitter-service/momsitter-app/static/public/favorites/s-list-like-off.png" alt="favorite" style="height:30px; width:30px; float:right;">';
							tag += '</h5>';
										
							tag += '<h6 class="loc"><i class="fas fa-map-marker-alt"></i>'+ vo.area1 +'</h6>';
							tag += '<h6><i class="fas fa-coins mr-1"></i>희망시급 : '+ vo.desired_wage +'원 | <i class="fas fa-hands-helping"></i>협의유무: '+ vo.discussion +'</h6>';
							tag += '<h6><i class="fas fa-child"></i>'+ vo.birth +'세 | <i class="fas fa-baby-carriage"></i>돌봄가능아이 : '+ vo.headcount +'명</h6>';
							
							if(vo.identi_status =="Y" || vo.license_status =="Y" || vo.school_status== "Y" || vo.crime_status=="Y"){
								tag += '<hr/>';
							}
							if(vo.identi_status == "Y"){
								tag += '<div class="badge badge-pill badge-warning align-top mr-1">등초본</div>';
							} else if(vo.license_status == "Y"){
								tag += '<div class="badge badge-pill badge-warning align-top mr-1">선생님</div>';
							} else if(vo.school_status == "Y"){
								tag += '<div class="badge badge-pill badge-warning align-top mr-1">학교</div>';
							} else if(vo.crime_status == "Y"){
								tag += '<div class="badge badge-pill badge-warning align-top mr-1">성범죄안심</div>';
							}
							
							tag += '</div>';
							tag += '</div>';
						
					});
					tag += "";
						$("#cardBox").html(tag); 
						}, error: function(){
					console.log("리스트 받기 에러");
					}

				})
				
	    }));
			
			
			
	});//제이쿼리
</script>
</head>
<body>
<!-- -------------------상단메뉴------------- -->
<div id="top">
<%@include file="/WEB-INF/views/top.jsp"%>
<hr/><br/>
</div>
<div class="container">

<!-- ---------------------필터들------ -->

<button type="button" class="btn btn-warning btn-lg btn-block mb-2">어떤 돌봄몬을 찾으세요?</button>
<div>
	<button id="mapBtn" class="btn btn-warning btn-lg btn-block">가까운 돌봄몬 찾기
	
	
	</button>
	<div id="map">
	</div>
</div>
<input type="text" class="form-control border-warning mt-2" id="locFilter" placeholder="#돌봄 지역을 입력해주세요">


<form class="form-inline">
  
  <select class="custom-select border-warning mt-2 mb-2" style="width:100%;">
    <option selected>돌봄 유형을 선택하시면, 맞춤시터를 보여드려요</option>
    <option value="1">2~10세 정기 돌봄</option>
    <option value="2">신생아/영아 정기 돌봄</option>
    <option value="3">긴급 돌봄</option>
    <option value="4">모든 돌봄 유형 보기</option>
  </select>
 </form>
 
<!-- ------------------------------- -->
  


   <div id="actBox">
	  <button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act1" >실내놀이</button>
	  <button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act2">등하원 돕기</button>
	  <button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act3">책 읽기</button>
	  <button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act4">야외활동</button>
	  <button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act5">한글놀이</button>
	  <button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act6">영어놀이</button>
	  <button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act7">학습지도</button>
	  <button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act8">체육놀이</button>
	  <button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act9">간단 청소</button>
	  <button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act10">밥 챙겨주기</button>
	  <button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act11">간단 설거지</button>
	  <button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act12">장기입주</button>
	  <button class="btn btn-outline-warning btn-sm rounded-pill pt-1 pb-1 px-2" id="act13">단기입주</button>

  </div>
 
<!-- ------------------------------- -->
 
   <div class="d-inline-block m-2" style="width:100%;">
	<div class="float-left" > 총 돌봄몬 수 : ${totalRecord} </div>
	<div class="float-right" style="cursor:pointer">후기순
		<i class="fas fa-arrow-circle-down"></i>
	</div>
	</div>

<!-- ------------------------------- -->
	<div id="cardBox" class="d-inline-block" style="width:100%;">
	<c:forEach var="vo" items="${list}">
		<div class="card" onclick="location.href='teacherView?userid=${vo.userid}'" >
			<img class="profilepic" src=<c:if test="${vo.pic==null}">"img/profilepic.png"</c:if><c:if test="${vo.pic!=null}">"upload/${vo.pic}"</c:if> alt="${vo.userid}"/><br/>
			<div class="card-body">
				<h5 class="card-title"><b>${vo.username.substring(0,1)}O${vo.username.substring(2)} </b>
				<!-- 마지막 업데이트일 -->
				<span class="ml-2" style="font-size:0.7em">
						<fmt:parseNumber integerOnly="true" var="edit_year" value="${vo.last_edit/525600}"/>
						<fmt:parseNumber integerOnly="true" var="edit_month" value="${vo.last_edit/43200}"/>
						<fmt:parseNumber integerOnly="true" var="edit_day" value="${vo.last_edit/1440}"/>
						<fmt:parseNumber integerOnly="true" var="edit_hour" value="${vo.last_edit/60}"/>					
					<c:choose>
						<c:when test="${vo.last_edit>525600}">${vo.last_edit/525600}년</c:when>
						<c:when test="${vo.last_edit>43200}">${edit_month}달</c:when>
						<c:when test="${vo.last_edit>1440}">${edit_day}일</c:when>
						<c:when test="${vo.last_edit>60}">${edit_hour}시간</c:when>
						<c:otherwise>${vo.last_edit}분</c:otherwise>
					</c:choose>
				</span>
				<img src="https://s3.ap-northeast-2.amazonaws.com/momsitter-service/momsitter-app/static/public/favorites/s-list-like-off.png" alt="favorite" style="height:30px; width:30px; float:right;">
				</h5>
							
				<h6 class="loc"><i class="fas fa-map-marker-alt"></i>${vo.area1}</h6>
				<h6><i class="fas fa-coins mr-1"></i>희망시급 : ${vo.desired_wage}원 | <i class="fas fa-hands-helping"></i>협의유무: ${vo.discussion}</h6>
				<h6><i class="fas fa-child"></i>${vo.birth}세 | <i class="fas fa-baby-carriage"></i>돌봄가능아이 : ${vo.headcount}명</h6>
		
				<c:if test="${vo.identi_status =='Y' || vo.license_status == 'Y' || vo.school_status == 'Y' || vo.crime_status == 'Y'}">
				<hr/>
				</c:if>
				<c:if test="${vo.identi_status == 'Y' }"><div class="badge badge-pill badge-warning align-top mr-1">등초본</div></c:if>
				<c:if test="${vo.license_status == 'Y'}"><div class="badge badge-pill badge-warning align-top mr-1">선생님</div></c:if>
				<c:if test="${vo.school_status == 'Y'}"><div class="badge badge-pill badge-warning align-top mr-1">학교</div></c:if>
				<c:if test="${vo.crime_status == 'Y'}"><div class="badge badge-pill badge-warning align-top mr-1">성범죄클린</div></c:if>
			</div>	
		</div>
	</c:forEach>
	

	</div>


<!-- =================지도======================================== -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d236a21d1724aae6ae65ed16423e6d4f"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new kakao.maps.LatLng("${mvo.lat}", "${mvo.lng}"), // 지도의 중심좌표
        level: 8 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
 
// 마커를 표시할 위치와 title 객체 배열입니다 
var positions = [
	<c:forEach var="vo" items="${hash}">
    {
        content: '<div style="padding:5px;">${vo.username}<br/><a href="teacherView">프로필보기</a></div>', 
        latlng: new kakao.maps.LatLng("${vo.lat}", "${vo.lng}")
    },
    </c:forEach>
];

// 마커 이미지의 이미지 주소입니다
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
    
for (var i = 0; i < positions.length; i ++) {
    
    // 마커 이미지의 이미지 크기 입니다
    var imageSize = new kakao.maps.Size(24, 35); 
    
    // 마커 이미지를 생성합니다    
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
    
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: positions[i].latlng, // 마커를 표시할 위치
        //title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
        image : markerImage // 마커 이미지 
    });

  //  var iwContent = '<div style="padding:5px;">Hello World! <br><a href="https://map.kakao.com/link/map/Hello World!,33.450701,126.570667" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/Hello World!,33.450701,126.570667" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

	// 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({
	    content : positions[i].content 
	});
  
// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
//infowindow.open(map, marker); 



// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
// 이벤트 리스너로는 클로저를 만들어 등록합니다 
// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
kakao.maps.event.addListener(marker, 'click', makeOverListener(map, marker, infowindow));
kakao.maps.event.addListener(map, 'click', makeOutListener(infowindow));
}//for문

//인포윈도우를 표시하는 클로저를 만드는 함수입니다 
function makeOverListener(map, marker, infowindow) {
return function() {
    infowindow.open(map, marker);
};
}

//인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
return function() {
    infowindow.close();
};
}

</script>




</div><!-- container -->
<jsp:include page="../footer.jsp"/>
</body>
</html>