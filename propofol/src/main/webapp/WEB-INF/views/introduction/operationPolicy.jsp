<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.agreement_lst_tit ol{
	list-style: none;
	padding-left: 1px;
}
.agreement_lst_tit dt,dd{
display: inline-block;
font: caption;
}

.agreement_lst_detail ol{
	list-style: none;
	padding-left: 1px;
}

#floatMenu {
	position: absolute;
	width: 80px;
	height: 70px;
	left: 95%;
	top: 40%;
}
.imgBtn{
	border: none;
    width: 90px;
    height: 95px;
    cursor: pointer;
}
</style>
<div class="content">
        
        <h2 class="blind">이용약관</h2>
        <div class="content_section ad_agreement_top fst">
            <div class="con">
                <div class="w_ad_agreement">
                    <div class="h_ad_agreement">
                        <p>홈페이지 서비스 이용 약관</p>
                        <span class="allview_h_bar"></span>
                    </div>
                </div>
                <div class="agreement_lst_tit">
                    <ol style="display: inline-block;">
                        <li>
                            <dl>
                                <dt>제 1 조</dt>
                                <dd>
                                <a href="javascript:fnMove('1');">목적</a>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt>제 2 조</dt>
                                <dd>
                                    <a href="javascript:fnMove('2');">정의</a>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt>제 3 조</dt>
                                <dd>
                                    <a href="javascript:fnMove('3');">약관의 게시와 개정</a>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt>제 4 조</dt>
                                <dd>
                                    <a href="javascript:fnMove('4');">API 서비스 사용 신청</a>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt>제 5 조</dt>
                                <dd>
                                    <a href="javascript:fnMove('5');">사용자 액세스 라이선스 및 비밀키 관리 의무</a>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt>제 6 조</dt>
                                <dd>
                                    <a href="javascript:fnMove('6');">개인정보의 보호</a>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt>제 7 조</dt>
                                <dd>
                                    <a href="javascript:fnMove('7');">API 서비스를 통한 회사의 데이터 제공</a>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt>제 8 조</dt>
                                <dd>
                                    <a href="javascript:fnMove('8');">API 서비스의 사용 범위</a>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt>제 9 조</dt>
                                <dd>
                                    <a href="javascript:fnMove('9');">사용자의 의무</a>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt>제 10 조</dt>
                                <dd>
                                    <a href="javascript:fnMove('10');">API 서비스의 변경</a>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt>제 11 조</dt>
                                <dd>
                                    <a href="javascript:fnMove('11');">서비스의 중단</a>
                                </dd>
                            </dl>
                        </li>
                    </ol>
                    <ol start="12" style="display: inline-block; margin-left: 10%;">
                        <li>
                            <dl>
                                <dt>제 12 조</dt>
                                <dd>
                                    <a href="javascript:fnMove('12');">클라이언트의 검사</a>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt>제 13 조</dt>
                                <dd>
                                    <a href="javascript:fnMove('13');">사용자에 대한 통지</a>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt>제 14 조</dt>
                                <dd>
                                    <a href="javascript:fnMove('14');">서비스 이용료</a>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt>제 15 조</dt>
                                <dd>
                                    <a href="javascript:fnMove('15');">회사의 의무</a>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt>제 16 조</dt>
                                <dd>
                                    <a href="javascript:fnMove('16');">사용자 탈퇴</a>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt>제 17 조</dt>
                                <dd>
                                    <a href="javascript:fnMove('17');">지적 재산권</a>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt>제 18 조</dt>
                                <dd>
                                    <a href="javascript:fnMove('18');">모니터링</a>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt>제 19 조</dt>
                                <dd>
                                    <a href="javascript:fnMove('19');">회사의 보증 및 책임의 제한</a>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt>제 20 조</dt>
                                <dd>
                                    <a href="javascript:fnMove('20');">약관의 해석</a>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt>제 21 조</dt>
                                <dd>
                                    <a href="javascript:fnMove('21');">준거법 및 재판관할</a>
                                </dd>
                            </dl>
                        </li>
                        <li><a href="javascript:fnMove('22');">부칙</a></li>
                    </ol>
                </div>
               

            </div>
        </div>

<hr>
        <div class="content_section agreement_lst_info">
            <div class="con">
                <div class="agreement_lst_detail">
                    <ol>
                        <li id="step1">
                            <dl>
                                <dt>제 1 조 (목적)</dt>
                                <dd>이 약관(이하 "약관"이라고 합니다)은 Propofol주식회사(이하 "회사"라고 합니다)가 제공하는 새로운 검색광고 (‘Propofol새로운광고시스템’) API 서비스의 이용과 관련하여 "사용자"와 "회사" 간에 필요한 사항을 규정함을 목적으로 합니다.</dd>
                            </dl>
                        </li>
                        <li id="step2">
                            <dl>
                                <dt>제 2 조 (정의)</dt>
                                <dd>
                                    "약관"에서 사용하는 용어의 정의는 아래와 같습니다.
                                    <ol>
                                        <li>① "검색광고"라 함은 키워드와 연계하여 "회사"가 정한 방식에 따라 사용자가 신청한 광고를 광고매체 이용자에게 보여주는 방식의 인터넷 광고를 의미합니다.</li>
                                        <li>② "검색광고 서비스"(이하 "검색광고 서비스"라고 합니다)라 함은 "회사"가 제공하는 "검색광고" 및 "검색광고"에 부수되는 제반 서비스를 의미합니다.</li>
                                        <li>③ "광고매체"라 함은 "회사"에 의해 "검색광고"가 게재되는 매체를 의미합니다.</li>
                                        <li>④ " 회원"아라 함은 "서비스"를 이용하기 위해 "검색광고 서비스 이용 약관"에 따라 "회사"와 이용계약을 체결하고 "회사"가 제공하는 "검색광고 서비스"를 이용하는 이용고객을 의미합니다.</li>
                                        <li>⑤ "회원 계정"이라 함은 함은 " 회원"이 검색광고"의 신청, 게재, 관리, 취소 등을 하기 위해 "검색광고센터"를 이용할 수 있도록, " 회원"이 등록을 신청하면 "회사"가 "회원" 에게 부여하는 식별정보를 의미합니다.
                                        </li>
                                        <li>⑥ "검색광고센터"라 함은 "회원"이 "검색광고"의 신청, 게재, 관리, 취소 등을 위해 "회사"가 제공하는 "검색광고 서비스" 중 검색광고 관리 서비스를 제공하는 웹사이트를 의미합니다.</li>
                                        <li>⑦ "검색광고 API(Application Programing Interface) 서비스(이하 "API 서비스"라고 합니다.)"라 함은 "검색광고"에 부수되는 제반 서비스 중 회원 또는 회원이 "API 서비스" 사용 권한을 위임한 광고 대행사가 직접 구축한 웹 페이지 및 어플리케이션에서 검색광고 광고 등록 신청 및 광고 관련 정보를 이용 할 수 있도록 회사가 제공하는 서비스를 의미합니다.</li>
                                        <li>⑧ "사용자"라 함은 "API 서비스"를 이용하기 위해 "약관"에 따라 "회사"와 이용계약을 체결하고 "회사"가 제공하는 "API 서비스"를 이용하는 "회원"을 의미합니다.</li>
                                        <li>⑨ "액세스 라이선스"라 함은 함은 "사용자"가 "API 서비스 "를 이용할 수 있도록, "사용자"가 등록 신청하면 "회사" 가 "사용자"에게 부여하는 고유 식별 정보를 의미합니다.</li>
                                        <li>⑩ "비밀키" 라 함은 "사용자"가 "API 서비스"를 이용할 수 있도록 "사용자"가 등록 신청하면 "회사"가 "사용자"에게 부여하는 고유 식별 정보를 의미합니다.</li>
                                        <li>⑪ "클라이언트"란 "API 서비스"를 사용하기 위하여 API 사양(仕樣)에 따라 개발된 "사용자"의 어플리케이션을 의미합니다.</li>
                                        <li>⑫ "테스트 환경"이라 함은 "사용자"가 "액세스 라이선스"를 부여 받고 실제 "검색광고 서비스"와 연동되는 환경에 접근하기 앞서 "사용자"의 "클라이언트"와 "회사"의 서비스 환경이 적합한지 테스트 하기 위한 환경을 의미합니다.</li>
                                        <li>⑬ "프로덕션 환경"이라 함은 "테스트 환경" 에서 적합성 테스트를 거친 "사용자"에게 제공되는 "API 서비스"의 실제 "검색광고 서비스"와 연동되는 서비스 환경을 의미합니다. "테스트 환경"과 "프로덕션 환경"은 서로 연동되지 않으며, 각각 별도로 구동 됩니다.</li>
                                        <li>⑭ "API 데이터"라 함은 "API 서비스"를 통해 "회사"의 광고 서버에 요청하여 "사용자"가 받는 모든 데이터를 의미하며 "회원"의 광고를 관리하는 용도 이외의 어떠한 용도로도 사용할 수 없습니다.</li>
                                        <li>⑮ "매뉴얼 사이트"라 함은 "회사"가 "API서비스" 개발 및 사용을 지원하기를 위하여 운영하는 웹 사이트를 의미합니다.</li>
                                    </ol>
                                </dd>
                            </dl>
                        </li>
                        <li id="step3">
                            <dl>
                                <dt>제 3 조 (약관의 게시와 개정)</dt>
                                <dd>
                                    <ol>
                                        <li>① "회사"는 "약관"의 내용을 "사용자"가 쉽게 알 수 있도록 "검색광고센터"내 "API 사용" 관리 페이지 또는 "메뉴얼 페이지"를 통하여 게시합니다.</li>
                                        <li>② "회사"는 필요한 경우 관련 법령을 위배하지 않는 범위 내에서 "약관"을 개정할 수 있습니다.</li>
                                        <li>③ "회사"는 "약관"을 개정할 경우 개정내용과 적용일자를 명시하여 "검색광고센터"에서 적용일자 7일 전부터 적용일자 전일까지 공지합니다. 다만, "사용자"에게 불리하게 개정되는 경우 적용일자 30일 전부터 공지합니다.</li>
                                        <li>④ "회사"가 전항에 따라 공지하면서 "사용자"에게 적용일자 전일까지 의사표시를 하지 않으면 의사표시가 표명된 것으로 본다는 뜻을 명확하게 공지하거나 제13조에 따른 방법으로 통지하였음에도 "사용자"가 명시적으로 거부의 의사표시를 하지 않은 경우 "사용자"가 개정 약관에 동의한 것으로 봅니다.</li>
                                        <li>⑤ "사용자"는 개정 약관에 동의하지 않는 경우 적용일자 전일까지 "회사"에 거부의사를 표시하고 "API 서비스 " 사용 중지를 할 수 있습니다.</li>
                                    </ol>
                                </dd>
                            </dl>
                        </li>
                        <li id="step4">
                            <dl>
                                <dt>제 4 조 (API 서비스 사용 신청)</dt>
                                <dd>
                                    <ol>
                                        <li>① "API 서비스" 사용 신청은 "API 서비스"를 이용하고자 하는 자(이하 "사용신청자"라고 합니다)가 "약관"의 내용에 동의를 한 다음 "회사"가 정한 절차에 따라 API 서비스 사용 신청을 하면, "회사"가 이러한 신청에 대하여 승낙함으로써 체결됩니다.</li>
                                        <li>② "회사"는 "사용신청자"의 신청에 대하여 아래 각 호의 사유가 있는 경우에는 승낙을 하지 않을 수 있으며, 가입 이후에도 아래 각 호의 사유가 확인될 경우에는 "API 서비스" 사용 중지 조치를 할 수 있습니다.
                                            <ol>
                                                <li>1. "API 서비스 신청자 "가 "회원"이 아닌 경우</li>
                                                <li>2. "API 서비스 신청자 "가 "검색광고 서비스" 이용 제한 중인 경우</li>
                                                <li>3. "API 서비스 신청자 "가 약관"에 의하여 이전에 "사용자" 자격을 상실한 적이 있는 경우</li>
                                                <li>4. "API 서비스 신청자 "가 "약관" 위반 등의 사유로 "서비스" 이용 제한 중에 "사용자" 탈퇴 후 재가입신청을 하는 경우</li>
                                                <li>5. 허위 또는 잘못된 정보를 기재 또는 제공하거나 "회사"가 제시하는 사항을 기재하지 않은 경우</li>
                                                <li>6. "가입신청자"의 귀책사유로 인하여 승낙이 불가능하거나 기타 "약관"에서 규정한 제반 사항을 위반하여 신청하는 경우</li>
                                            </ol>
                                        </li>
                                        <li>③ "사용자" 가입의 성립 시기는 "회사"가 가입 완료를 신청절차상에서 표시한 시점으로 합니다.</li>
                                    </ol>
                                </dd>
                            </dl>
                        </li>
                        <li id="step5">
                            <dl>
                                <dt>제 5 조 (사용자 액세스 라이선스 및 비밀키 관리 의무)</dt>
                                <dd>
                                    <ol>
                                        <li>① "액세스 라이선스"와 "비밀키"에 대한 관리책임은 "사용자"에게 있습니다.</li>
                                        <li>② "액세스 라이선스"와 "비밀키"는 제 3자에게 전달 하여서는 안 되며 제 3자의 이용에 따른 모든 불이익과 분쟁에 대하여 "회사"는 책임을 지지 않습니다.</li>
                                        <li>③ "사용자"는 "액세스 라이선스" 와 "비밀키"가 도용되고 있음을 안 경우, 이를 즉시 "회사"에 통지하고 "회사"의 안내에 따라야 합니다.</li>
                                        <li>④ "사용자"는 가입 신청 시 기재한 사항이 변경되었을 경우 "검색광고센터"에 접속하여 직접 수정하거나 고객센터를 통하여 "회사"에 변경 사항을 통지하여야 합니다.</li>
                                        <li>⑤ "사용자"가 제3항, 제4항을 준수하지 않아 발생한 불이익에 대하여 "회사"는 책임을 지지 않습니다.</li>
                                    </ol>
                                </dd>
                            </dl>
                        </li>
                        <li id="step6">
                            <dl>
                                <dt>제 6 조 (개인정보의 보호)</dt>
                                <dd>
                                    "회사"는 "정보통신망 이용촉진 및 정보보호 등에 관한 법률", "개인정보보호법" 등 관련 법령이 정하는 바에 따라 "사용자"의 개인정보를 보호하기 위해 노력합니다. 개인정보의 보호 및 사용에 대해서는 관련 법령 및 "회사"의 개인정보 처리방침이 적용됩니다. 다만, "회사"의 공식 사이트 이외의 링크된 사이트에서는 "회사"의 개인정보 처리방침이 적용되지 않습니다.<br>(개인정보보호정책: <a href="http://mktg.naver.com/privacy/privacy.html" target="_blank">http://mktg.naver.com/privacy/privacy.html</a>)
                                </dd>
                            </dl>
                        </li>
                        <li id="step7">
                            <dl>
                                <dt>제 7 조 (API 서비스를 통한 회사의 데이터 제공)</dt>
                                <dd>
                                    <ol>
                                        <li>① "회사"가 "API서비스"를 통하여 클라이언트"에 제공하는 "API데이터"는 실제 데이터와 시간 차이가 존재할 수 있습니다.</li>
                                        <li>② "회사" 가 "API 서비스"를 통하여 "클라이언트"에 제공되는 "API 데이터"의 무결 성 및 정합성을 보장하지 않습니다.</li>
                                        <li>③ "사용자"는 "클라이언트" 내에서 "API 데이터"를 "사용자"가 스스로 제공하는 데이터와 시각적으로 구분되도록 표시하여야 합니다.</li>
                                        <li>④ "광고 API"를 통해 제공되는 데이터는 "사용자" 본인 및 권한 기능을 통해 권한을 가진 다른 회원의 광고 관리 목적 범위 내에서만 사용하여야 합니다. 또한 "사용자가 " 다른 "회원 계정"에 대한 권한을 상실하는 즉시 다른 회원의 광고 정보 등 "회사"가 제공한 다른 회원의 광고 관련 모든 정보를 삭제하여야 합니다. 본항 위반시 "회사"는 "사용자"에 대하여 즉시 접근제한 등의 조치를 취할 수 있습니다.</li>
                                        <li>⑤ "액세스 라이선스" 및 "비밀키"를 제3자에게 전달하여서는 안되며 제 3자가 "API 서비스"를 통해 수집한 "사용자"의 데이터로 인해 발생하는 모든 불이익, 분쟁에 대하여 "회사"는 책임지지 않습니다. 이로 인해 발생하는 분쟁 등에 대하여는 "API 사용자"가 책임을 부담하여야 하며 "사용자" 자신의 비용과 책임으로 "회사"를 면책 시키고 "회사"에 발생한 모든 손해를 배상하여야 합니다.</li>
                                        <li>⑥ "사용자"는 "회사"가 "API서비스"를 통하여 제공하는 데이터 이외에 다른 방법(모든 형태의 자동화된 방법 포함)으로 광고주센터 등에 게재된 "사용자"본인의 "회원" 데이터 및 다른 "회원" 데이터 등을 임의로 수집하거나 제 3자에게 제공할 수 없습니다.</li>
                                    </ol>
                                </dd>
                            </dl>
                        </li>
                        <li id="step8">
                            <dl>
                                <dt>제 8 조 (API 서비스의 사용 범위)</dt>
                                <dd>
                                    <ol>
                                        <li>① "사용자"는 "API 서비스"를 사용하여 다음 각호의 행위를 할 수 있습니다.
                                            <ol>
                                                <li>1. "회사"로 부터 발급 받은 "액세스 라이선스"로 "회사"의 "광고 서비스"에 접속하는 행위</li>
                                                <li>2. "사용자"의 "클라이언트"에서 "API 서비스"를 통하여 "회사"의 "광고 서비스"에 광고 관련 정보를 조회, 수정, 입력하고 광고를 게재 및 수정, 삭제하는 행위</li>
                                                <li>3. "사용자"가 "클라이언트"를 통하여 입력한 광고 관련 정보에 대한 "API 서비스"의 처리 결과를 "API 서비스"와 연동된 "클라이언트"에서 확인하는 행위</li>
                                            </ol>
                                        </li>
                                        <li>② "사용자"는 "API 사양" 및 "액세스라이선스", "비밀키"를 "클라이언트" 개발 및 "API 서비스" 연동을 위한 목적에 한하여 사용할 수 있습니다.</li>
                                    </ol>
                                </dd>
                            </dl>
                        </li>
                        <li id="step9">
                            <dl>
                                <dt>제 9 조 (사용자의 의무)</dt>
                                <dd>
                                    <ol>
                                        <li>① "사용자"는 관련 법령, "약관", 광고운영정책, 이용안내 및 "회사"가 공지하거나 통지한 사항 등을 준수하여야 하며, 기타 "회사"의 업무에 방해되는 행위를 하여서는 안 됩니다.</li>
                                        <li>② "사용자"는 "클라이언트"를 통해 이루어지는 "사용자"의 활동이 적법한 것임을 보증합니다.</li>
                                        <li>③ "사용자"는 "클라이언트"가 "회사"의 "API 서비스" 및 "회사"의 광고 업무를 방해하지 않는 방식을 운영 됨을 보증합니다.</li>
                                        <li>④ "사용자"의 "API 서비스" 사용은 사용자 자신의 및 권한 기능을 통해 권한을 가진 다른 회원 계정의 "광고 계정"에 대한 광고 관리 목적 범위 내로 한정 되어야 합니다.</li>
                                        <li>⑤ "사용자"는 "API데이터", "액세스 라이선스","비밀키", "API 사양"에 대한 보안에 대하여 "회사"의 검색광고API서버에서 허용하는 프로토콜 수준의 보안수준을 만족하여야 합니다.</li>
                                        <li>⑥ "사용자"는 "클라이언트" 내의 모든 데이터의 저장 및 소통 시 최소한 128Bit SSL로 보호하여야 하며, "회사"의 광고서버가 받아들일 수 있는 수준의 "Client" Protocol로 데이터를 "회사"의 광고서버에 전송하여야 합니다.</li>
                                        <li>⑦ "회사"는 필요할 경우 "사용자"의 보안수준을 점검할 수 있으며, "사용자"는 "회사"의 보안점검에 적극 협력하여야 합니다. "사용자"의 보안수준이 "회사"가 정하는 보안수준에 미흡할 경우 "회사"는 본 계약을 해지할 수 있습니다.</li>
                                        <li>⑧ 사용자"가 "회사"의 귀책 없이 "약관" 또는 관련 법령을 위반하여 제3자가 "회사"를 상대로 민·형사상 등의 문제를 제기하는 경우 "사용자"는 해당 문제해결을 위해 적극 협조하여야 하며, 이와 관련하여 "회사"에 손해가 발생한 경우 손해를 배상합니다.</li>
                                        <li>⑨ "사용자"는 "API 서비스"에 관한 자료와 입찰 등 "API 서비스" 이용과정에서 취득한 일체의 정보를 제3자에게 제공, 공개 또는 누설하여서는 안 됩니다.</li>
                                        <li>⑩ "사용자"는 "API 서비스" 제공 또는 본 조 위반여부를 확인하기 위해 "회사"가 자료 또는 접근권한의 제공 및 관련사실에 대한 소명을 요청하는 경우에는 이에 성실히 임하여야 합니다.</li>
                                        <li>⑪ “사용자”는 “API 서비스”의 “사양” 및 사용 방식이 변경 될 경우 계속 사용하고자 한다면 “회사”의 변경된 “API 서비스”에 맞게 “클라이언트”를 30일 이내 수정 하여야 합니다. 만약, 사용자가 변경된 “API 서비스”에 맞게 “클라이언트”를 수정할 수 없을 경우 “사용자”는 사용을 중단하거나 “사용자”탈퇴를 할 수 있습니다.</li>
                                    </ol>
                                </dd>
                            </dl>
                        </li>
                        <li id="step10">
                            <dl>
                                <dt>제 10 조 (API 서비스의 변경)</dt>
                                <dd>
                                    <ol>
                                        <li>① "회사"는 안정적인 "서비스" 제공을 위하여 "서비스"의 내용, 운영상 또는 기술상 사항 등을 변경할 수 있습니다.</li>
                                        <li>② "회사"는 "서비스"를 변경할 경우 변경내용과 적용일자를 명시하여 "매뉴얼 사이트"에서 사전에 공지합니다. 단, "사용자"의 권리나 의무 및 "서비스" 이용과 관련되는 실질적인 사항을 변경할 경우 적용일자 7일 전부터 공지하며, "사용자"에게 불리한 변경의 경우 적용일자 30일 전부터 공지합니다.</li>
                                        <li>③ "회사"의 합리적인 판단에 따라 운영상 필요한 경우 혹은 긴급하거나 급박한 경우 "API 서비스"에 대한 "사용자"의 접근 권한 등 사용 권한을 공지 이전에 제한할 수 있으며, "API 서비스"방식 및 "사양"에 등에 대한 수정을 할 수 있으며 사후 공지하여야 합니다.</li>
                                        <li>④ "사용자"는 "서비스" 변경에 동의하지 않을 경우 "회사"에 거부의사를 표시하고 "사용자" 탈퇴를 할 수 있습니다.</li>
                                        <li>⑤ "회사"는 "API 서비스"에 "사용자"의 권리나 의무 및 "API 서비스"이용과 관련된 실질적인 사항이 변경되지 않는 신규 기능을 제공할 경우 이를 "사용자"에게 미리 통지 하지 않을 수 있습니다. 이 경우 "사용자"는 "사양"을 최신 버전으로 업데이트 함으로써 해당 신규 기능들을 사용할 수 있습니다.</li>
                                        <li>⑥ "회사"는 "사용자"에게 "API 서비스" 사용 속도의 제한을 둡니다. 합리적인 사용 속도의 제한을 위해 "회사"는 "사용자"의 사용 실적, 광고 집행 규모 및 광고비 지출액 등을 고려하여 사용 속도를 재 조정할 수 있으며 사용 속도의 재 조정 사항 내역은 "사용자"에게 별도 통보하지 않습니다.</li>
                                    </ol>
                                </dd>
                            </dl>
                        </li>
                        <li id="step11">
                            <dl>
                                <dt>제 11 조 (서비스의 중단)</dt>
                                <dd>
                                    <ol>
                                        <li>① "회사"는 컴퓨터 등 정보통신설비의 보수점검, 교체, 고장, 장애, 통신두절 또는 운영상 합리적인 사유가 있는 경우 "API 서비스" 제공을 일시적으로 중단할 수 있습니다. "사용자"는 이에 대비하여 계속 적인 데이터 BACK-UP을 실시하여야 합니다. "회사"는 운영상 합리적인 사유가 종결 혹은 해결 되는 즉시 "API 서비스"를 재개 하여야 합니다.</li>
                                        <li>② "회사"는 "API 서비스"의 중단 시 "매뉴얼 사이트"를 통해 "사용자"에게 통지합니다. 다만, "회사"가 사전에 통지할 수 없는 부득이한 사유가 있는 경우 사후에 통지할 수 있습니다.</li>
                                        <li>③ "회사"는 제1항에 따른 "서비스" 제공 중단으로 발생한 "사용자"의 손해에 대하여 고의 또는 과실이 없는 한 책임을 지지 않습니다.</li>
                                        <li>④ "회사"는 다음 각호의 경우 "API서비스"를 중단할 수 있습니다.
                                            <ol>
                                                <li>1. "사용자"가 생성하는 report의 내용에서 "API데이터"와 "사용자"가 직접 작성한 정보를 구분하여 표기하지 않는 등 제7조의 의무사항 위반한 경우</li>
                                                <li>2.	"API서비스"를 사용하는 "클라이언트"가 "회사"의 이용정책과 부합하지 않는 동작을 하는 경우(단, 계약 당시 설명되고, "회사"가 확인한 기능은 예외로 한다)</li>
                                                <li>3. "사용자"의 클라이언트"가 의도적 혹은 우연적으로 "회사"가 운영하는 시스템 혹은 서비스의 작동을 해하거나 비정상적 접근을 하는 경우</li>
                                                <li>4. "사용자"의 "Client"가 의도적 혹은 우연적으로 "회사"가 운영하는 시스템 혹은 서비스의 작동을 해하거나 비정상적 접근을 하는 경우</li>
                                                <li>5. "사용자"가 제 10조 제6항에 따라 제한 되는 속도 보다 빠른 속도로 "API 서비스"를 사용한 경우</li>
                                                <li>6. 기타 "사용자"가 본 약관 에서 정한 사항을 위반한 경우</li>
                                            </ol>
                                        </li>
                                    </ol>
                                </dd>
                            </dl>
                        </li>
                        <li id="step12">
                            <dl>
                                <dt>제 12 조 (클라이언트의 검사)</dt>
                                <dd>
                                    <ol>
                                        <li>① "회사"는 "사용자"가 개발, 구매, 임대 하고 있는 "클라이언트"의 기능 안정성 및 호환성에 대한 검사를 시행할 수 있습니다. "회사"는 "클라이언트"검사 후 "클라이언트"가 "API 서비스"에 적합 하지 아니하거나 "회사"가 정한 정책에 부합되지 않을 경우 그 사유를 설명하고 정책에 부합하도록 혹은 "API 서비스"에 적합하도록 수정할 것을 통지하고, "사용자"에게 30일간의 "클라이언트" 수정 기간을 부여하여야 합니다. "사용자"가 위 기간 내에 "회사"의 요청에 부합하는 내용의 수정을 아니하는 경우 "회사"는 "API 서비스" 제공을 거부할 수 있습니다.</li>
                                        <li>② "회사"는 "사용자"에 대하여 합리적인 범위 내에서 "클라이언트" 수정을 요구하여야 합니다.</li>
                                        <li>③ "회사"는 필요에 따라 "클라이언트" 테스트용 자료(소스코드 및 UI등)을 요구할 수 있으며 이 경우 "사용자는" 해당 자료를 "회사"에 제공하여야 합니다. 단, "사용자"가 저작하지 않는 "클라이언트" 등 "사용자"가 해당 자료를 "회사"에 제공할 수 없는 합리적인 이유가 있을 경우 이를 거부할 수 있습니다.</li>
                                        <li>④ "회사"는 사용자가 비밀정보임을 사전에 서면으로 통지하고 제공한 "클라이언트" 테스트 용 자료(소스 코드 및 UI등)에 대해서는 이를 본 약관 제 12조 1항에 기술한 검사 목적을 위해서만 사용하며, 제3자에게 유출되거나 비밀이 침해되지 않도록 노력합니다.</li>
                                    </ol>
                                </dd>
                            </dl>
                        </li>
                        <li id="step13">
                            <dl>
                                <dt>제 13 조 (사용자에 대한 통지)</dt>
                                <dd>
                                    <ol>
                                        <li>① "회사"가 "사용자"에 대하여 통지를 하는 경우 "약관"에 별도의 규정이 없는 한 "사용자"가 제공한 전자우편주소, (휴대)전화번호, 주소, "검색광고센터" 로그인시 동의 창 등의 수단으로 할 수 있습니다.</li>
                                        <li>② "회사"는 "사용자" 전체에 대하여 통지를 하는 경우 7일 이상 "매뉴얼 사이트" 내 게시판에 국문 또는 영문으로 게시함으로써 전항의 통지에 갈음할 수 있으며</li>
                                        <li>③ "사용자"는 "매뉴얼 사이트" 내에 게시되는 공지를 성실히 열람하여야 하며 "사용자"의 공지 미숙지로 인한 모든 불이익에 대해서는 "회사"는 책임지지 않습니다.</li>
                                    </ol>
                                </dd>
                            </dl>
                        </li>
                        <li id="step14">
                            <dl>
                                <dt>제 14 조 (서비스 이용료)</dt>
                                <dd>
                                    <ol>
                                        <li>① "API서비스"의 이용대가는 무상으로 합니다.</li>
                                        <li>② "API 서비스"의 이용대가를 유상으로 변경할 경우 "회사"는 이를 "사용자"에게 시행 30일 전에 제 13조 제 1항에서 정한 방식으로 통보하여야 하며 "사용자"는 "API 서비스"의 사용을 중지하거나 탈퇴할 수 있습니다.</li>
                                    </ol>
                                </dd>
                            </dl>
                        </li>
                        <li id="step15">
                            <dl>
                                <dt>제 15 조 (회사의 의무)</dt>
                                <dd>
                                    <ol>
                                        <li>① "회사"는 관련 법령과 "약관"을 준수하며, 계속적이고 안정적으로 "API 서비스"를 제공하기 위하여 최선을 다하여 노력합니다.</li>
                                        <li>② "회사"는 "사용자"가 안전하게 "API 서비스"를 이용할 수 있도록 개인정보(신용정보 포함) 보호를 위하여 보안시스템을 갖추어야 하며 개인정보 처리방침을 공시하고 준수합니다.</li>
                                        <li>③ "회사"는 "API 서비스" 이용과 관련하여 "사용자"로부터 제기된 의견이나 불만이 정당하다고 인정될 경우 이를 처리하여야 하며, "매뉴얼 사이트 " 내 게시판, 전자우편 등을 통하여 "사용자"에게 처리과정 및 결과를 전달할 수 있습니다.</li>
                                        <li>④ "회사"는 "사용자"의 이용에 따른 "클라이언트"의 사용 정보를 "사용자"의 동의 없이 제3자에게 제공할 수 없습니다.</li>
                                    </ol>
                                </dd>
                            </dl>
                        </li>
                        <li id="step16">
                            <dl>
                                <dt>제 16 조 (사용자 탈퇴)</dt>
                                <dd>
                                    <ol>
                                        <li>① "사용자"는 언제든지 고객센터로 요청하거나 직접 "검색광고센터"에 접속하여 "약관" 제4조에 따라 가입한 "사용자" 탈퇴를 신청할 수 있으며, "회사"는 관련 법령이 정하는 바에 따라 이를 즉시 처리하여야 합니다.</li>
                                        <li>② "사용자" 탈퇴가 완료되는 경우, "회사"는 관련 법령 및 개인정보 처리방침에 따라 보유하는 "사용자"의 정보를 제외한 "사용자"의 모든 정보 및 "API 서비스" 사용을 위해 제공된 "액세스 라이선스","비밀키" 정보를 즉시 삭제합니다.</li>
                                        <li>③ "사용자" 탈퇴가 완료되는 경우 광고운영정책에서 정하는 바에 따라 탈퇴한 "액세스 라이선스"의 정보로 다시 가입하는 것이 제한될 수 있습니다.</li>
                                    </ol>
                                </dd>
                            </dl>
                        </li>
                        <li id="step17">
                            <dl>
                                <dt>제 17 조 (지적 재산권)</dt>
                                <dd>
                                    <ol>
                                        <li>① "회사" 가 "사용자" 에게 제공하는 "API 데이터" 등 일체의 자료 및 정보에 대한 권리는 "회사"가 보유합니다.</li>
                                        <li>② "사용자"가 "클라이언트"를 통해 제공하는 "API 데이터"등의 정보에 대한 소유권 및 일체의 지적 재산권은 "회사"에 속하며 사용자는 이를 "클라이언트"에 표시하여야 합니다.</li>
                                    </ol>
                                </dd>
                            </dl>
                        </li>
                        <li id="step18">
                            <dl>
                                <dt>제 18 조 (모니터링)</dt>
                                <dd>
                                    <ol>
                                        <li>① "회사"는 "API서비스"의 원활한 운영을 위하여 상시 모니터링을 수행합니다. "회사"는 모니터링을 위하여 필요한 경우 "사용자"의 영업에 지장을 초래하지 아니하는 범위 내에서 "사용자"의 협조를 구할 수 있으며, 이 경우 "사용자"는 "회사"의 요청에 적극 협력하여야 합니다.</li>
                                        <li>② "사용자"는 "회사"의 모니터링에 협력하여야 합니다. "사용자"가 "회사"의 모니터링을 방해하거나 방해하고자 하는 어떠한 시도를 하였음이 확인될 경우 "회사"는 "사용자"에 대한 "API서비스" 사용허가를 즉시 취소 할 수 있습니다.</li>
                                    </ol>
                                </dd>
                            </dl>
                        </li>
                        <li id="step19">
                            <dl>
                                <dt>제 19 조 (회사의 보증 및 책임의 제한)</dt>
                                <dd>
                                    <ol>
                                        <li>① "회사"는 "API 서비스" 및 "API 서비스"와 연동한 "클라이언트"의 운영과 관련하여 "사용자"가 주장하는 "API 서비스" 및 "API 데이터" 등에 대한 "사용자"의 어떠한 권리도 보증 하지 않습니다.</li>
                                        <li>② "회사"는 "PI서비스"에 오류가 없거나, "API서비스"가 장애를 일으키지 않음을 보증하지 않습니다. 또한 "API데이터" 및 "API 사양" 내용의 정확성 및 진실성을 보증하지 아니 하며, "회사" "API 서비스"와 "클라이언트"간의 연동에 의하여 자동으로 "API데이터"가 생성되는 것만을 보증합니다.</li>
                                        <li>③ "회사"는 "API서비스"를 이용하여 게재된 광고의 운영 결과에 대해 책임을 지지 않습니다.</li>
                                        <li>④ "회사"는 "API서비서"의 장애 또는 "API데이터"와 "API 사양" 내용의 부 정확성 등으로 인하여 "사용자"에게 발생한 손해에 대하여 책임을 부담하지 않습니다.</li>
                                        <li>⑤ "회사"는 "사용자"와 제 3자간에 광고 API서비스를 매개로 발생한 분쟁에 대해 개입할 의무가 없으며, 이로 인한 손해를 배상할 책임을 부담하지 않습니다. 만일 "사용자"의 "광고API서비스" 이용과 관련하여 제 3자가 "회사"를 상대로 이의를 제기할 경우 "사용자"는 "회사"를 자신의 비용과 책임으로 면책시켜야 합니다.</li>
                                        <li>⑥ "회사"는 "API서비스"에 대한 비독점적이고 "회사"가 승인한 일부 권한만을 "사용자"에게 부여하며, "사용자"는 "광고API서비스"와 관련하여 "회사"가 정한 사용허가 조건 하에서 사용할 수 있습니다.</li>
                                        <li>⑦ "사용자"가 "약관" 또는 관련 법령을 위반하여 "회사"에 손해가 발생한 경우 관련 법령이 규정하는 범위 내에서 "회사"에 그 손해를 배상합니다.</li>
                                    </ol>
                                </dd>
                            </dl>
                        </li>
                        <li id="step20">
                            <dl>
                                <dt>제 20 조 (약관의 해석)</dt>
                                <dd>
                                    <ol>
                                        <li>① "회사"는 "약관" 외에 별도의 "API서비스" 운영 정책을 둘 수 있습니다.</li>
                                        <li>② "약관"에서 정하지 않은 사항이나 해석에 대하여는 검색 광고 서비스 이용 약관 광고운영정책, 이용안내, 관련 법령에 따릅니다.</li>
                                    </ol>
                                </dd>
                            </dl>
                        </li>
                        <li id="step21">
                            <dl>
                                <dt>제 21 조 (준거법 및 재판관할)</dt>
                                <dd>
                                    <ol>
                                        <li>① "회사"와 "사용자" 간에 발생한 분쟁에 대하여는 대한민국법을 준거법으로 합니다.</li>
                                        <li>② "회사"와 "사용자" 간 발생한 분쟁에 관한 소송은 민사소송법 상의 관할법원에 제소합니다.</li>
                                    </ol>
                                </dd>
                            </dl>
                        </li>
                        <li id="step22">
                            <dl>
                                <dt>부칙</dt>
                                <dd>
                                    <ol>
                                        <li>1. 본 약관은 2016년 3월 21일부터 시행됩니다.</li>
                                    </ol>
                                </dd>
                            </dl>
                        </li>
                    </ol>
                </div>
            </div>
        </div>
        <div id="floatMenu" style="top: 747px;">
		<input class="imgBtn" type="button" onClick="location.href='#'" style="background: url('${cPath}/img/introduction/top.jpg')" />
		</div>
            </div>
<script>
	//클릭시 찾는 거 가운대로
    function fnMove(seq){
        var offset = $("#step" + seq).offset();
        var winH = $(window).height();
        $('html, body').animate({scrollTop : (offset.top - winH/2)}, 400);
    }
 // 기존 css에서 플로팅 배너 위치(top)값을 가져와 저장한다.
	var floatPosition = parseInt($("#floatMenu").css('top'));
	// 250px 이런식으로 가져오므로 여기서 숫자만 가져온다. parseInt( 값 );

	$(window).scroll(function() {
		// 현재 스크롤 위치를 가져온다.
		var scrollTop = $(window).scrollTop();
		var newPosition = scrollTop + floatPosition + "px";

		/* 애니메이션 없이 바로 따라감
		 $("#floatMenu").css('top', newPosition);
		 */

		$("#floatMenu").stop().animate({
			"top" : newPosition
		}, 500);

	}).scroll();
</script>
