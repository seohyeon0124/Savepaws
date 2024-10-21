# 🐱 세이브포스 Savepaws

<br>

## 프로젝트 소개

- 세이브포스는 유기동물의 입양을 촉진하고, 입양 후기를 공유하며, 지역사회의 중고 물건을 나눔할 수 있는 플랫폼입니다.
- 이 웹사이트는 Java, JSP, HTML, CSS, Oracle, jQuery 등의 기술 스택을 활용하여 개발되었습니다.
- 관리자는 유기동물을 등록할 수 있고, 사용자는 입양 신청을 하며, 다양한 커뮤니티 활동에 참여할 수 있습니다.

<br>

## 기대 효과

- 세이브포스는 유기동물 입양을 장려하고, 지역 사회의 나눔 문화를 촉진하는 것을 목표로 합니다.
- 사용자들은 서로의 경험을 공유하며, 유기동물에게 따뜻한 가정을 제공할 수 있는 기회를 가집니다.
- 또한, 중고 물건 나눔을 통해 자원의 효율적인 사용과 환경 보호에도 기여할 수 있습니다.

<br>

## 1. 개발 환경

- 개발 인원 : 1명
- 개발 기간 : 2024-04-23 ~ 2024-05-08
- 프론트엔드 : HTML, CSS, jQuery, Bootstrap 
- 백엔드 : Java, JSP
- 데이터베이스 : Oracle
- 기타 : AJAX를 활용한 비동기 통신 구현으로 사용자 경험 향상

<br>

## 2. 프로젝트 구조

```
├─README.md
└─ Project_jsh
   ├─ .classpath
   ├─ .project
   ├─ .settings
   ├─ build
   └─ src
      └─ main
         ├─ java
         │  └─ my
         │     ├─ animal
         │     │  ├─ AnicateBean.java
         │     │  ├─ AnicateDao.java
         │     │  ├─ AnimalBean.java
         │     │  ├─ AnimalDao.java
         │     │  ├─ RequestBean.java
         │     │  └─ RequestDao.java
         │     ├─ free
         │     │  ├─ FreeBean.java
         │     │  └─ FreeDao.java
         │     ├─ member
         │     │  ├─ MemberBean.java
         │     │  └─ MemberDao.java
         │     ├─ review
         │     │  ├─ ReviewBean.java
         │     │  └─ ReviewDao.java
         │     └─ store
         │        ├─ StoreBean.java
         │        ├─ StoreDao.java
         │        ├─ StorecateBean.java
         │        └─ StorecateDao.java
         └─ webapp
            ├─ META-INF
            ├─ WEB-INF
            │  └─ lib
            │     ├─ commons-collections-3.1.jar
            │     ├─ commons-dbcp-1.2.1.jar
            │     ├─ commons-pool-1.2.jar
            │     ├─ cos.jar
            │     ├─ gson-2.8.5.jar
            │     ├─ json-simple-1.1.1.jar
            │     ├─ ojdbc8.jar
            │     └─ servlet-api.jar
            ├─ admin
            │  ├─ admin.jsp
            │  ├─ admin_bottom.jsp
            │  ├─ admin_top.jsp
            │  ├─ aniCate.jsp
            │  ├─ animalList.jsp
            │  ├─ animalProc.jsp
            │  ├─ animalUser.jsp
            │  ├─ animalView.jsp
            │  ├─ blog.css
            │  ├─ cateProc.jsp
            │  ├─ deleteAnimal.jsp
            │  ├─ deleteCate.jsp
            │  ├─ deleteStore.jsp
            │  ├─ inputAnimal.jsp
            │  ├─ inputCate.jsp
            │  ├─ inputStore.jsp
            │  ├─ requestProc.jsp
            │  ├─ storeCate.jsp
            │  ├─ storeList.jsp
            │  ├─ storeProc.jsp
            │  ├─ storeView.jsp
            │  ├─ updateAnimal.jsp
            │  ├─ updateAnimalProc.jsp
            │  ├─ updateStore.jsp
            │  ├─ updateStoreProc.jsp
            │  └─ userList.jsp
            ├─ animal
            │  ├─ aniRequest.jsp
            │  ├─ aniRequestAll.jsp
            │  ├─ anilike.jsp
            │  ├─ anilikeBtn.jsp
            │  ├─ animal.jsp
            │  ├─ animalView.jsp
            │  ├─ animal_top.jsp
            │  ├─ blog.css
            │  ├─ delAnilike.jsp
            │  └─ delRequest.jsp
            ├─ free
            │  ├─ blog.css
            │  ├─ delFree.jsp
            │  ├─ free.jsp
            │  ├─ freeView.jsp
            │  ├─ free_around.jsp
            │  ├─ free_input.jsp
            │  ├─ free_inputProc.jsp
            │  ├─ free_my.jsp
            │  ├─ free_place.jsp
            │  ├─ free_thing.jsp
            │  ├─ free_top.jsp
            │  ├─ free_want.jsp
            │  └─ map.js
            ├─ introduce
            │  ├─ carousel.css
            │  └─ introduce.jsp
            ├─ member
            │  ├─ checkEmailProc.jsp
            │  ├─ findid.jsp
            │  ├─ findidProc.jsp
            │  ├─ findpw.jsp
            │  ├─ findpwProc.jsp
            │  ├─ login.jsp
            │  ├─ loginProc.jsp
            │  ├─ logout.jsp
            │  ├─ naverLogin.jsp
            │  ├─ register.jsp
            │  ├─ registerProc.jsp
            │  └─ signin.css
            ├─ review
            │  ├─ review.jsp
            │  ├─ reviewProc.jsp
            │  ├─ review_delete.jsp
            │  ├─ review_form.jsp
            │  ├─ review_top.jsp
            │  ├─ review_update.jsp
            │  ├─ review_updateProc.jsp
            │  └─ review_view.jsp
            ├─ store
            │  ├─ blog.css
            │  ├─ store.jsp
            │  └─ store_top.jsp
            ├─ js
            ├─ img
            ├─ main.css
            ├─ main.jsp
            ├─ top.jsp
            ├─ bottom.jsp
            ├─ carousel.css
            ├─ memo.txt
            └─ 이미지
```

<br>

## 3. 기능

### 🌱 1. 메인 Main

- 세이브 포스에서 이용 가능한 메뉴바와 로그인 버튼이 상단에 위치해있습니다.
- 관리자 로그인시 메뉴바에 Admin 메뉴가 추가됩니다. 해당 메뉴에서 사이트를 관리할 수 있습니다.

<img width="500" alt="main" src="https://github.com/user-attachments/assets/adc65057-ccb7-47bf-b8fa-a08a610a1a83">
<br><br>

### 🌱 2. 로그인 Login

#### [로그인]
- 사용자는 아이디와 비밀번호를 입력하여 로그인을 진행할 수 있습니다.
- 아이디와 비밀번호를 입력하지 않았을 경우 또는 아이디가 이메일 형식이 아닐경우 유효성 검사를 진행합니다.
- 네이버 및 카카오 로그인 API를 사용하여 해당 방법으로 로그인이 가능합니다.

#### [아이디 찾기]
- 회원 가입시 입력한 이름, 주민등록번호, 전화번호 정보를 사용하여 아이디를 찾을 수 있습니다.
- 누락 또는 올바르지 않은 값 입력시 유효성 검사를 진행합니다.
- 가입된 정보와 입력값이 일치하는 경우에만 등록된 아이디를 안내합니다.
- 네이버 및 카카오 로그인은 해당되지 않습니다.

#### [비밀번호 찾기]
- 회원 가입시 입력한 아이디, 이름, 주민등록번호, 전화번호 정보를 사용하여 비밀번호를 변경할 수 있습니다.
- 누락 또는 올바르지 않은 값 입력시 유효성 검사를 진행합니다.
- 가입된 정보와 입력값이 일치하는 경우에만 비밀번호 변경이 가능합니다.
- 네이버 및 카카오 로그인은 해당되지 않습니다.

#### [회원가입]
- 사용자는 이름, 아이디, 비밀번호, 주민등록번호, 전화번호, 연령대, 성별 정보를 입력하여 회원가입이 가능합니다.
- 누락 또는 올바르지 않은 값 입력시 유효성 검사를 진행합니다.

<img width="300" alt="image" src="https://github.com/user-attachments/assets/4180520b-5396-45af-97db-bc71b7e87479">
<br><br>

### 🌱 3. 소개 Introduce

- 모든 사람은 세이브 포스의 이념과 활동, 위치 장소 등에 대한 정보를 확인할 수 있습니다.
- 카카오 지도 API를 사용하여 위치를 표시하였습니다.

<br>

### 🌱 4. 입양 Animal

- 강아지, 고양이, 토끼, 도마뱀 등 등록되어있는 카테고리 별로 등록된 유기 동물의 정보를 확인할 수 있습니다.
- 로그인을 진행한 뒤, 원하는 유기 동물 정보에 관심 표시를 하거나 입양 신청을 진행할 수 있습니다.
- 원하는 유기 동물 정보를 클릭하면 컬러, 구조일, 종 등의 상세 정보를 확인할 수 있습니다.
- 검색 기능을 통해 원하는 품종의 유기 동물이 있는지 확인할 수 있습니다.

<br>

### 🌱 5. 입양후기 Review

- 세이브 포스에서 입양된 동물이라면, 로그인을 진행한 뒤 현재 상황을 업로드할 수 있습니다.
- 다른 사용자들은 해당 게시물에 좋아요 표시를 할 수 있으며, 한번 더 누르면 취소됩니다.
- 해당 게시물에 접속하는 수만큼 조회수가 증가하며, 게시일이 지난 날짜만큼 'OO일 전'으로 표시됩니다.

<br>

### 🌱 6. 중고물품나눔 Free

- 세이브 포스의 회원이라면 로그인을 진행한 뒤, 안쓰는 물건을 등록/신청하여 나눔을 진행할 수 있습니다.
- 물품 등록시 교환 장소의 주소를 설정할 수 있고, 해당 장소가 지도에 표시됩니다.
- 사용자는 지역으로 분류된 카테고리 확인 또는 지도 확인을 통해 원하는 지역에서 나눔되는 물품을 확인할 수 있습니다.

<br>

### 🌱 7. 관리자 Admin

#### [동물관련작업]
- 관리자는 Animal 메뉴 화면에 나타나는 동물 카테고리를 추가/삭제할 수 있습니다.
- 관리자는 구조된 유기동물의 정보를 등록할 수 있습니다. 이때, 카테고리를 올바르게 선택해야하며 누락된 정보가 있을 경우 유효성 검사가 진행됩니다.
- 관리자는 등록된 모든 유기동물의 정보를 조회할 수 있습니다. 이때, 원하는 카테고리와 검색어에 따른 조회가 가능합니다.

#### [입양관련작업]
- 관리자는 입양 신청이 들어온 유기동물과 회원정보를 조회할 수 있으며, 초기 상태는 '신청'입니다.
- 상담을 통해 입양 신청의 상태를 '승인' 또는 '반려'로 설정할 수 있습니다. 해당 상태는 회원의 신청 목록에서 확인 가능합니다.

#### [회원관련작업]
- 관리자는 세이브 포스에 가입한 모든 회원의 정보를 조회할 수 있습니다. 이때, 주민등록번호는 조회 불가능합니다.

<br>

## 4. 개선할 부분

- 사용자들이 질문이나 건의사항을 남길 수 있는 문의 게시판 기능을 추가하여, 커뮤니티의 소통을 강화하고 사용자 지원을 개선해야 합니다.
- 로그인 없이 접근이 필요한 기능에 대해 자동으로 로그인 화면으로 이동하도록 설정하여, 사용자들이 필요한 서비스를 원활하게 이용할 수 있도록 해야 합니다. 이를 통해 사용자 경험을 향상시키고 보안성을 높입니다.

<br>

## 5. 프로젝트 후기

세이브포스 프로젝트는 기술적 도전과 사회적 가치를 동시에 추구할 수 있는 기회였습니다. 유기동물과 지역 사회에 긍정적인 영향을 미칠 수 있는 프로젝트라는 점이 매우 뿌듯했습니다. 
Java, JSP, Oracle 등 다양한 기술을 활용하면서 실무 경험을 쌓을 수 있었고, 특히 데이터베이스와의 연동 및 비동기 통신을 구현하는 과정에서 많은 것을 배웠습니다.
앞으로는 사용자 피드백을 반영하여 웹사이트를 발전시켜 나갈 수 있도록 노력할 것입니다.
