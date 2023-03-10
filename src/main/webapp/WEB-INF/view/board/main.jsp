<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../common/heading.jsp"%>
<script src="https://unpkg.com/@yaireo/tagify"></script>
<script
	src="https://unpkg.com/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
<link href="https://unpkg.com/@yaireo/tagify/dist/tagify.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.min.css" />
<link rel="stylesheet" href="/review.css" />
</head>

<body>
	<%@ include file="../common/top.jsp"%>
	<!-- =========================== Main Start =========================== -->
	<div class="container">
		<div class="row" style="justify-content: space-evenly">
			<%@ include file="../common/aside.jsp"%>


			<!-- // content - 리스트  -->
			<div class="content col-lg-8">
				<!-- ★ 검색 -->
				<div class="main-search">
					<h3>딱 맞는 유치원 찾기</h3>
					<form action="/board/main" method="post">
						<table class="main-search-tb">
							<tr>
								<th class="txtmain">Tag 검색</th>
								<td><input name="findtag" class="some_class_name"
									value="${findtag}" /></td>
							</tr>
							<tr>
								<td><p>지역</p></td>
								<td><input name="findarea" class="some_class_name"
									value="${findarea }" /></td>
							</tr> 
<%-- 							<tr>
								<th class="txtmain">지역 검색</th>
						<td><select name="area" class="form-select board-input" style="color:#333">
									<option value="전체">전체</option>
									<option value="서울">서울</option>
									<option value="부산">부산</option>
									<option value="대구">대구</option>
									<option value="인천">인천</option>
									<option value="광주">광주</option>
									<option value="대전">대전</option>
									<option value="울산">울산</option>
									<option value="세종">세종</option>
									<option value="경기">경기</option>
									<option value="강원">강원</option>
									<option value="충청">충청</option>
									<option value="경상">경상</option>
									<option value="전라">전라</option>
									<option value="제주">제주</option>
						</select></td>
							</tr>--%>
							
							
							
							<tr>
								<td colspan="2"><input class="btn full maincolor"
									type="submit" value="검색" /></td>
							</tr>
						</table>
					</form>
				</div>
				<div class="content-list">
					<c:forEach var="b" items="${blist }">
						<div class="content-list-col">
							<div class="descbox">
								<c:choose>
									<c:when test="${b.reCnt eq 0 }">
										<div class="re-star descbox-star">
											<span class="" style="color: #444;">평점 미등록</span>
										</div>
									</c:when>
									<c:otherwise>
										<div class="re-star descbox-star">
											<span class="" style="color: #666;">평점</span>
											<c:forEach begin="1" end="${b.grade_ }">
												<span class="fa-star fa on"></span>
											</c:forEach>
											<c:forEach begin="1" end="${5 - b.grade_ }">
												<span class="fa-star fa"></span>
											</c:forEach>
										</div>
									</c:otherwise>
								</c:choose>

								<img src="/thum/${b.thum }" id="descimg"
									onclick="location.href='/board/detail/${b.bid}'" />
							</div>
							<div class="content-list-bookmark mb-2">
								<!-- 태그 -->
								<p class="board-view-tag">
									<c:set var="t" value="${fn:split(b.tag,'/')}"></c:set>
									<c:forEach var="w" items="${t}">
										<span class="subcolor">${w}</span>
									</c:forEach>
								</p>

								<!-- 북마크 -->
								<c:set var="fill" value="" />
								<c:set var="url" value="bookmark/${b.bid }" />
								<c:forEach var="m" items="${mlist }">
									<c:if test="${m eq b.bid }">
										<c:set var="fill" value="fill" />
										<c:set var="url" value="bookmark/del/${b.bid }" />
									</c:if>
								</c:forEach>

								<span class="bookmark material-symbols-outlined ${fill }"
									onclick="location.href='/board/${url}'"> bookmark </span>
								<!-- 북마크 -->
							</div>
							<div class="main-list-title mb-3"
								onclick="location.href='/board/detail/${b.bid}'">
								<h5 class="mb-1">${b.title }</h5>
								<p>${b.addr }</p>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<!-- content - 리스트 // -->
		</div>
	</div>
	<!-- =========================== Main End =========================== -->
	<%@ include file="../common/bottom.jsp"%>
	<script>
		var input = document.querySelector('input[name="findtag"]'),
		// init Tagify script on the above inputs
		tagify = new Tagify(input, {
			whitelist : [ '#호텔', '#유치원', '#실내', '#야외', '#미용' ], // 화이트리스트 배열
			userInput : false,
			maxTags : 10, // 최대 허용 태그 갯수

			dropdown : {
				maxItems : 20, // 드롭다운 메뉴에서 몇개 정도 항목을 보여줄지
				classname : 'tags-look', // 드롭다운 메뉴 엘리먼트 클래스 이름. 이걸로 css 선택자로 쓰면 된다.
				enabled : 0, // 단어 몇글자 입력했을떄 추천 드롭다운 메뉴가 나타날지
				closeOnSelect : false, // 드롭다운 메뉴에서 태그 선택하면 자동으로 꺼지는지 안꺼지는지
			},
		});
	</script>
	<script>
		var input = document.querySelector('input[name="findarea"]'),
		// init Tagify script on the above inputs
		tagify = new Tagify(input, {
			whitelist : [ '전체', '서울', '부산', '대구', '인천', '광주', '대전', '울산', '세종',
					'경기', '강원', '충청', '경상', '전라', '제주', ], // 화이트리스트 배열
			userInput : false,
			maxTags : 1, // 최대 허용 태그 갯수

			dropdown : {
				maxItems : 20, // 드롭다운 메뉴에서 몇개 정도 항목을 보여줄지
				classname : 'tags-look', // 드롭다운 메뉴 엘리먼트 클래스 이름. 이걸로 css 선택자로 쓰면 된다.
				enabled : 0, // 단어 몇글자 입력했을떄 추천 드롭다운 메뉴가 나타날지
				closeOnSelect : false, // 드롭다운 메뉴에서 태그 선택하면 자동으로 꺼지는지 안꺼지는지
			},
		});
	</script>
</body>
</html>