<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css" type="text/css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/css/bootstrap.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="<%=request.getContextPath()%>/css/datepicker-ko.js"></script>

<style>
	.container{width:518px; padding:0;
	}
	
	#headerDiv{width:100%; height:auto; text-align:center; margin-top:50px; border-bottom:1px solid #EFEFEF;}
	input[type=radio], input[type=checkbox]{display:none;}
	/* ==================== 시작 날짜 =================== */
	#startDateDiv{text-align:center; padding:10px 0; }
	#startDateDiv>input{width:30%; height:100%; margin:0 5%;}
	#startDateDiv>input[name=start_date]{height:38px;vertical-align:bottom;text-align:center;}
	#endDateDiv{text-align:center; padding:10px 0; }
	#endDateDiv>input{width:30%; height:100%; margin:0 5%;}
	#endDateDiv>input[name=end_date]{height:38px;vertical-align:bottom;text-align:center;}
	/* ===================== =====================*/
	#selectDayDiv{width:100%; overflow:hidden; height:auto; border-bottom:1px solid gray; padding-bottom:20px; margin-bottom:30px;}
	#selectDayDiv ul{
		display:table;
		width:100%;
		margin:0;
		padding:0;
	}
	#selectDayDiv li>label{
		display:block; 
		width:100%; height:100%; 
		border-radius:50%; 
		background-color:#EFEFEF; 
		margin:0;
	}
	#selectDayDiv li{
		width:12.28%; 
		height:60px; 
		line-height:60px; 
		border-radius:50%; 
		text-align:center; 
		float:left; margin:1%; 
		list-style:none;
	}	
	/* ===================== =====================*/
	
	/* ==================== 활동 요일 설정  ======================== */
	#timeDiv{width:100%; overflow:hidden; height:auto;}
	#timeDiv div{width:50%; height:100px; float:left;}
	#startDiv{padding:20px; border-right:1px solid gray;}
	#startDiv *{float:right;}
	#endDiv{padding:20px;}
	#startDiv>select{text-align-last:center}
	#endDiv>select{text-align-last:center;}
	select{width:50%; height:40px; font-size:17px; -webkit-appearance: none; moz-appearance: none;}
	#timeDiv span{}
	
	/* ==================== 활동 기간 설정 ==========================*/
	#periodDiv{width:100%; overflow:hidden; height:auto; text-align:center; margin-top:30px; border-top:1px solid gray;}
	
	#periodDiv h6{color:gray; margin-top:20px;}
	label{display:inline-block; width:100%; height:100%; margin:0;}
	#periodDiv ul{width:100%; overflow:hidden; height:auto; margin:0;}
	#periodList li{width:33%; text-align:center; float:left; border:1px solid #EFEFEF; }
	/* input[type=radio]{display:none;} */
	
	input[type=submit]{width:100%; height:40px; margin-top:30px; background-color:orange; color:white; border:1px solid #EFEFEF;}
	label{-webkit-transition:background-color 1s;
		transition:background-color 1s;}
	li{-webkit-transition:background-color 1s;
		transition:background-color 1s;}
</style>
<script>
	
	$(function(){
			
		startTime();
		
		$("input[name=period]").each(function(){
			$(this).prop("checked", false);
		});
		
		var getDay = "${rdVO.yoil}";
		var getYoil = getDay.split(",");
		$("input[name=yoil]").each(function(){
			for(var i=0;i<7;i++){
				if($(this).val()==getYoil[i]){
					$(this).prop("checked", true);
				}
			}
		});
		
		var getStart_time = "${rdVO.start_time}";
		$(document).ready(function(){
			$("#start_time").val(getStart_time);
			var test = $("#start_time").val();
			for(var i=1;i<=48;i++){
				if($("#start_time option[id=rt"+i+"]").val()==test){
					endTime(i); 	
					var getEnd_time = "${rdVO.end_time}";
					$("#end_time").val(getEnd_time);
				}
			}
		});
		
		var minDate;
		$("#startDateBtn").datepicker({
			showAnim : "show",
			minDate : '0',
			maxDate : '1m',
			dateFormat : "yy-mm-dd",
			onSelect:function(dateText){
				minDate = dateText;
				$("#start_date").val(dateText);
				$("#startDateBtn").val("활동 시작일 선택");
				$("#endDateBtn").val("활동 종료일 선택");
				$("#endDateBtn").datepicker("option", "minDate", dateText);
			},
			altFormat:"yyyy-mm-dd"
		});
		
		var start_date2 = $("#start_date");
		var todayday = new Date(start_date2);
		$("#endDateBtn").datepicker({
			showAnim : "show",
			changeMonth : true,
			minDate : todayday,
			changeYear : true,
			dateFormat : "yy-mm-dd",
			onSelect:function(dateText){
				$("#end_date").val(dateText);
				
				$("#endDateBtn").val("돌봄 종료일 선택");
			},
			altFormat:"yyyy-mm-dd"
		});
		
		// 요일 선택 시 색상변경
		$("input[name=yoil]").change(function(){
			var selectedData = $(this).attr("id");
			
			if($("input[id="+selectedData+"]").is(":checked")){
				$("label[for="+selectedData+"]").css("background-color", "orange").css("color", "white");//노랑
			}else{
				$("label[for="+selectedData+"]").css("background-color", "#EFEFEF").css("color", "black");//회색
			}
		});
		
		$("input[name=yoil]").each(function(){
			if($(this).is(':checked') == true){
				$(this).parent("label").css("background-color", "orange").css("color", "white");
			}else{
				$(this).parent("label").css("background-color", "#EFEFEF");
			}
		});
	});
	
	function startTime(){ // 시작 시간
		var time = new Date(2020, 0, 1);
		var tag="";
		for(var i=1;i<=48;i++){
			if(time.getHours()<10 && time.getMinutes()==0) {
				tag += "<option id='rt"+i+"'>0"+time.getHours()+":0"+time.getMinutes()+"</option>";
			}else if(time.getHours()<10 && time.getMinutes()!=0){
				tag += "<option id='rt"+i+"'>0"+time.getHours()+":"+time.getMinutes()+"</option>";
			}else if(time.getHours()>=10 && time.getMinutes()==0){
				tag += "<option id='rt"+i+"'>"+time.getHours()+":0"+time.getMinutes()+"</option>";
			}else if(time.getHours()>=10 && time.getMinutes()!=0){
				tag += "<option id='rt"+i+"'>"+time.getHours()+":"+time.getMinutes()+"</option>";
			}
			time.setMinutes(time.getMinutes()+30);
		}
		document.getElementById("start_time").innerHTML = tag;
	}
	
	$(function(){
		$("#start_time").on('change' ,function(){
			var test = $("#start_time").val();
			var i=1;
			for(i;i<=48;i++){
				if($("#start_time option[id="+i+"]").val()==test){
					endTime(i);
				}
			}
			
		});
	});
	
	function endTime(i){
		var time = new Date(2020, 0, 1);
		var tag="";
		time.setMinutes(time.getMinutes()+30*i);
		for(i;i<48;i++){
			if(time.getHours()<10 && time.getMinutes()==0) {
				tag += "<option>0"+time.getHours()+":0"+time.getMinutes()+"</option>";
			}else if(time.getHours()<10 && time.getMinutes()!=0){
				tag += "<option>0"+time.getHours()+":"+time.getMinutes()+"</option>";
			}else if(time.getHours()>10 && time.getMinutes()==0){
				tag += "<option>"+time.getHours()+":0"+time.getMinutes()+"</option>";
			}else if(time.getHours()>10 && time.getMinutes()!=0){
				tag += "<option>"+time.getHours()+":"+time.getMinutes()+"</option>";
			}else if(time.getHours()>=24){
				break;
			}
			time.setMinutes(time.getMinutes()+30);
		}
		document.getElementById("end_time").innerHTML = tag;
	}
	
	function setEndDate(i){
		var date = new Date();
		var startDate = document.getElementById("start_date").value;
		var data = startDate.split("-");
		var endDate;
		var setEndDate;
		var month = Number(data[1]);
		if(i==1){
			endDate = new Date(data[0], data[1], Number(data[2])+7);
			setEndDate = endDate.getFullYear()+"-"+endDate.getMonth()+"-"+endDate.getDate();
		}else if(i==2){
			if(month+1==12){
				endDate = new Date(data[0], month+1, data[2]);
				setEndDate = endDate.getFullYear()+"-12-"+endDate.getDate();
			}else{
				endDate = new Date(data[0], month+1, data[2]);
				setEndDate = endDate.getFullYear()+"-"+endDate.getMonth()+"-"+endDate.getDate();
			}
		}else if(i==3){
			if(month+3==12){
				endDate = new Date(data[0], month+3, data[2]);
				setEndDate = endDate.getFullYear()+"-12-"+endDate.getDate();
			}else{
				endDate = new Date(data[0], month+3, data[2]);
				setEndDate = endDate.getFullYear()+"-"+endDate.getMonth()+"-"+endDate.getDate();
			}
		}else if(i==4){
			if(month+6==12){
				endDate = new Date(data[0], month+6, data[2]);
				setEndDate = endDate.getFullYear()+"-12-"+endDate.getDate();
			}else{
				endDate = new Date(data[0], month+6, data[2]);
				setEndDate = endDate.getFullYear()+"-"+endDate.getMonth()+"-"+endDate.getDate();
			}
		}
		document.getElementById("end_date").value = setEndDate;
		
	}
	
	
	$(function(){
		$("#dateFrm").submit(function(){
			
			var start_date = $("#start_date").val();
			var end_date = $("#end_date").val();
			if(start_date==null || start_date==""){
				swal({
					title : "돌봄 날짜 선택",
					text : "돌봄 시작날짜를 선택해주세요",
					icon : "info"
				});
				return false;
			}else if(end_date==null || end_date==""){
				swal({
					title : "돌봄 날짜 선택",
					text : "돌봄 종료날짜를 선택해주세요",
					icon : "info"
				});
				return false;
			}
			
			var yoil = $("input[name=yoil]:checked").length;
			if(yoil < 1) {
				swal({
					title : "돌봄 날짜 선택",
					text : "선생님을 만나고 싶은 요일을 선택해주세요",
					icon : "info"
				});
				return false;
			}
			
			var start_time = $("#start_time").val();
			var end_time = $("#end_time").val();
			console.log("stime => " + start_time);
			console.log("etime => " + end_time);
			
			if(end_time==null || end_time=="종료시간") {
				swal({
					title : "돌봄 시간 선택",
					text : "돌봄 종료시간을 선택해주세요",
					icon : "info"
				});
				return false;
			}
		});
	});
</script>
</head>
<body>
	<div class="container">
		<form id="dateFrm" method="post" action="<%=request.getContextPath()%>/teacherScheduleEdit">
		<div id="headerDiv"><h2>돌봄 기간 / 시간 변경</h2></div>
		<div id="startDateDiv">
			<input class="btn" style="background-color:orange;color:white;"type="button" id="startDateBtn" value="활동 시작일 선택" />
			<input type="text" id="start_date" name="start_date" readonly="readonly" value="${rdVO.start_date }"/>
		</div>
		<div id="selectDayDiv">
			<ul>
				<li><label for="1"><input type="checkbox" id="1" name="yoil" value="월" />월</label></li>
				<li><label for="2"><input type="checkbox" id="2" name="yoil" value="화" />화</label></li>
				<li><label for="3"><input type="checkbox" id="3" name="yoil" value="수" />수</label></li>
				<li><label for="4"><input type="checkbox" id="4" name="yoil" value="목" />목</label></li>
				<li><label for="5"><input type="checkbox" id="5" name="yoil" value="금" />금</label></li>
				<li><label for="6"><input type="checkbox" id="6" name="yoil" value="토" />토</label></li>
				<li><label for="7"><input type="checkbox" id="7" name="yoil" value="일" />일</label></li>
			</ul>
		</div>
		<div id="timeDiv">
			<div id="startDiv">
				<span>시작 시간</span><br/>		
				<select id="start_time" name="start_time" onselect="endTime();">
				
				</select>
			</div>
			<div id="endDiv">
				<span>종료 시간</span><br/>
				<select id="end_time" name="end_time">
					<option>종료시간</option>
				</select>
			</div>
		</div>
		<div id="endDateDiv">
			<input class="btn" style="background-color:orange;color:white;"type="button" id="endDateBtn" value="활동 종료일 선택" />
			<input type="text" id="end_date" name="end_date" readonly="readonly" value="${rdVO.end_date }"/>
		</div>
		<div id="periodDiv">
			<input class="btn" type="submit" value="저장하기" />
		</div>
		</form>
	</div>
	
</body>
</html>