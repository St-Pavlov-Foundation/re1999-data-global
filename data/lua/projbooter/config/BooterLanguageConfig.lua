-- chunkname: @projbooter/config/BooterLanguageConfig.lua

module("projbooter.config.BooterLanguageConfig", package.seeall)

local BooterLanguageConfig = {
	hotupdate = {
		jp = "更新チェック中",
		de = "",
		zh = "检查更新中",
		tw = "檢查更新中",
		kr = "업데이트 중",
		fr = "",
		thai = "",
		en = "Checking for updates"
	},
	error_request_version = {
		jp = "更新に失敗しました。バージョン情報が取得できません",
		de = "",
		zh = "更新失败，无法获取版本信息",
		tw = "更新失敗，無法獲取版本資訊",
		kr = "업데이트 실패, 버전 정보 확인 불가",
		fr = "",
		thai = "",
		en = "Update failed.\nCannot obtain version information."
	},
	error_request_update = {
		jp = "更新に失敗しました",
		de = "",
		zh = "更新失败",
		tw = "更新失敗",
		kr = "업데이트 실패",
		fr = "",
		thai = "",
		en = "Update failed."
	},
	need_update_package = {
		jp = "アップデートが必要です。クライアントまたはアプリを更新してください",
		de = "",
		zh = "本次更新为强更新，请各位玩家下载并安装新客户端",
		tw = "本次更新為強更新，請各位玩家下載並安裝新用戶端",
		kr = "클라이언트 업데이트가 필요합니다, 스토어에서 업데이트를 진행해 주세요.",
		fr = "",
		thai = "",
		en = "This is a compulsory update, please download and install the latest game client."
	},
	exit = {
		jp = "ログアウト",
		de = "",
		zh = "退出",
		tw = "退出",
		kr = "로그아웃",
		fr = "",
		thai = "",
		en = "Exit"
	},
	retry = {
		jp = "リトライ",
		de = "",
		zh = "重试",
		tw = "重試",
		kr = "다시하기",
		fr = "",
		thai = "",
		en = "Retry"
	},
	download = {
		jp = "ダウンロード",
		de = "",
		zh = "下载",
		tw = "下載",
		kr = "다운로드",
		fr = "",
		thai = "",
		en = "Download"
	},
	continue_download = {
		jp = "再開",
		de = "",
		zh = "继续下载",
		tw = "繼續下載",
		kr = "계속 다운로드",
		fr = "",
		thai = "",
		en = "Continue"
	},
	hotupdate_info = {
		jp = "ゲームの更新に必要なデータのダウンロードを開始します。\nサイズ：%s。ダウンロードしますか？",
		de = "",
		zh = "本次更新需下载资源包：%s，是否同意下载？",
		tw = "本次更新需下載資源包：%s，是否同意下載？",
		kr = "이번 업데이트 다운로드 용량: %s, 진행하시겠습니까?",
		fr = "",
		thai = "",
		en = "The update weighs in at %s, do you wish to download?"
	},
	hotupdate_continue_info = {
		jp = "データのダウンロードが完了していません。残りのサイズ：%s。ダウンロードしますか？",
		de = "",
		zh = "本次更新资源包还需要下载%s，是否继续下载？",
		tw = "本次更新資源包還需要下載%s，是否繼續下載？",
		kr = "이번 업데이트 추가 다운로드 용량: %s, 진행하시겠습니까?",
		fr = "",
		thai = "",
		en = "Another %s needed to be download to complete the update, do you wish to continue?"
	},
	download_info = {
		jp = "更新中 %s/%s\n更新内容やご利用の通信環境によって時間がかかる場合がございます。\nWi-Fi環境など、通信環境の良い場所でのダウンロードをおすすめします。",
		de = "",
		zh = "正在更新中 %s/%s\n建议在wifi环境下进行下载，资源文件较多，请耐心等待！",
		tw = "正在更新中 %s/%s\n建議在wifi環境下進行下載，資源檔較多，請耐心等待！",
		kr = "업데이트 중 %s/%s\n와이파이 환경에서 다운로드를 권장 드립니다. 잠시만 기다려 주세요!",
		fr = "",
		thai = "",
		en = "Updating %s/%s\nMultiple files will be downloaded for the update, we suggest downloading on WIFI. "
	},
	download_fail_download_error = {
		jp = "ダウンロードに失敗しました。電波状況の良いところで再度お試しください。",
		de = "",
		zh = "下载发生错误，请检查网络连接",
		tw = "下載發生錯誤，請檢查網路連線",
		kr = "다운로드 오류, 네트워크 연결을 확인해 주세요.",
		fr = "",
		thai = "",
		en = " An error occurred during download. Please check your internet connection."
	},
	download_fail_not_found = {
		jp = "ダウンロードに失敗しました。（エラーコード：404）",
		de = "",
		zh = "下载错误。（错误代码 404）",
		tw = "下載錯誤。（錯誤代碼 404）",
		kr = "다운로드 실패(에러 코드 404)",
		fr = "",
		thai = "",
		en = " An error occurred during download. (Code: 404)"
	},
	download_fail_server_pause = {
		jp = "サーバーのメンテナンス中です。メンテナンス終了までしばらくお待ちください。（エラーコード：403）",
		de = "",
		zh = "服务器维护中，请稍后再试。（错误代码 403）",
		tw = "伺服器維護中，請稍後再試。（錯誤代碼 403）",
		kr = "서버 업데이트 중, 잠시 후 다시 시도해 주세요. 에러 코드 403",
		fr = "",
		thai = "",
		en = "Server under maintenance. Please try again later. (Code: 403)"
	},
	download_fail_time_out = {
		jp = "ダウンロードエラー。要求がタイムアウトしました。",
		de = "",
		zh = "下载错误，请求已超时",
		tw = "下載錯誤，請求已超時",
		kr = "다운로드 실패, 요청 시간 초과.",
		fr = "",
		thai = "",
		en = " An error occurred during download. Request timed out."
	},
	download_fail_no_enough_disk = {
		jp = "ダウンロードエラー。デバイスの空き容量を増やしてから、もう一度お試しください。",
		de = "",
		zh = "下载错误，请清理储存空间后重试",
		tw = "下載錯誤，請清理儲存空間後重試",
		kr = "다운로드 실패, 저장 공간을 확보하고 다시 시도해 주세요.",
		fr = "",
		thai = "",
		en = " An error occurred during download. Please retry after freed up some space in your disk."
	},
	download_fail_md5_check_error = {
		jp = "ダウンロードエラー。リソース検証に失敗しました。",
		de = "",
		zh = "下载错误，资源包校验失败",
		tw = "下載錯誤，資源包驗證失敗",
		kr = "다운로드 실패, 리소스 검증 실패.",
		fr = "",
		thai = "",
		en = " An error occurred during download. Resource validation failed."
	},
	download_fail_other = {
		jp = "ダウンロードエラー",
		de = "",
		zh = "下载错误",
		tw = "下載錯誤",
		kr = "다운로드 실패",
		fr = "",
		thai = "",
		en = "An error occurred during download."
	},
	unpack_error = {
		jp = "展開に失敗しました。デバイスの空き容量が不足しています。",
		de = "",
		zh = "资源解压失败，本地储存空间不足。",
		tw = "資源解壓失敗，本地儲存空間不足。",
		kr = "리소스 압축 풀기 실패, 디바이스 용량 부족.",
		fr = "",
		thai = "",
		en = "Failed to decompress. Please free up more space in your disk."
	},
	unpack_error_running = {
		jp = "展開に失敗しました。もう一度お試しください。",
		de = "",
		zh = "资源解压失败，请重新尝试。",
		tw = "資源解壓失敗，請重新嘗試。",
		kr = "리소스 압축 풀기 실패, 다시 시도해 주세요.",
		fr = "",
		thai = "",
		en = "Failed to decompress. Please try again."
	},
	unpack_error_done = {
		jp = "展開はすでに完了しました。",
		de = "",
		zh = "资源解压已完成，请勿重复操作。",
		tw = "資源解壓已完成，請勿重複操作。",
		kr = "리소스 압축 풀기 성공.",
		fr = "",
		thai = "",
		en = "The file has been decompressed to your disk. "
	},
	unpack_error_file_not_found = {
		jp = "展開に失敗しました。ファイルが破損しているため、修復を行ってからもう一度お試しください。",
		de = "",
		zh = "无法完成资源解压，部分资源文件缺失，请尝试修复后重试。",
		tw = "無法完成資源解壓，部分資源檔缺失，請嘗試修復後重試。",
		kr = "리소스 압축 풀기 불가, 일부 파일이 누락되었습니다, 복구 후 다시 시도해 주세요.",
		fr = "",
		thai = "",
		en = "Some files are missing. Please repair it and try again."
	},
	unpack_error_not_enough_space = {
		jp = "展開に失敗しました。デバイスの空き容量が不足しています。",
		de = "",
		zh = "资源解压失败，本地储存空间不足。",
		tw = "資源解壓失敗，本地儲存空間不足。",
		kr = "리소스 압축 풀기 실패, 디바이스 용량 부족.",
		fr = "",
		thai = "",
		en = "Failed to decompress. Please free up more space in your disk."
	},
	unpack_error_thread_abort = {
		jp = "展開に失敗しました。もう一度お試しください。",
		de = "",
		zh = "资源解压失败，请重新尝试。",
		tw = "資源解壓失敗，請重新嘗試。",
		kr = "리소스 압축 풀기 실패, 다시 시도해 주세요.",
		fr = "",
		thai = "",
		en = "Failed to decompress. Please try again."
	},
	unpack_error_exception = {
		jp = "ファイル展開異常エラー。もう一度お試しください。",
		de = "",
		zh = "资源解压存在异常错误，请重新尝试。",
		tw = "資源解壓存在異常錯誤，請重新嘗試。",
		kr = "리소스 압축 풀기 비정상 오류 발생, 다시 시도해 주세요.",
		fr = "",
		thai = "",
		en = "An unusual error has occurred during decompression, please try again."
	},
	unpack_error_unknown = {
		jp = "ファイル展開未知エラー。もう一度お試しください。",
		de = "",
		zh = "资源解压存在未知错误，请重新尝试。",
		tw = "資源解壓存在未知錯誤，請重新嘗試。",
		kr = "알 수 없는 오류 발생, 다시 시도해 주세요.",
		fr = "",
		thai = "",
		en = "An unknown error has occurred during decompression, please try again."
	},
	unpack_done = {
		jp = "展開が完了しました。",
		de = "",
		zh = "资源解压完成！",
		tw = "資源解壓完成！",
		kr = "압축 풀기 완료!",
		fr = "",
		thai = "",
		en = "Decompression complete."
	},
	hotupdate_done = {
		jp = "更新が完了しました。ロード中です。しばらくお待ちください…",
		de = "",
		zh = "更新完毕，正在加载资源（此过程不消耗流量），请稍候…",
		tw = "更新完畢，正在載入資源（此過程不消耗流量），請稍候…",
		kr = "업데이트 완료, 리소스 팩 로딩 중(데이터를 소모하지 않음), 잠시 기다려 주세요...",
		fr = "",
		thai = "",
		en = "The update is complete. Loading (no data will be used during loading) ..."
	},
	unpacking = {
		jp = "データ展開中です。しばらくお待ちください…",
		de = "",
		zh = "正在解压资源包，请稍候...",
		tw = "正在解壓資源包，請稍候...",
		kr = "리소스 압축 풀기 중, 잠시만 기다려 주세요...",
		fr = "",
		thai = "",
		en = "Decompressing the files, please wait ..."
	},
	version_validate = {
		jp = "バージョンチェック",
		de = "",
		zh = "版本检查",
		tw = "版本檢查",
		kr = "버전 검사",
		fr = "",
		thai = "",
		en = "Checking the current version"
	},
	version_validate_fail = {
		jp = "バージョンチェックに失敗しました。\nエラー:",
		de = "",
		zh = "检查版本状态失败!\n错误:",
		tw = "檢查版本狀態失敗!\n錯誤:",
		kr = "버전 검사 실패!\n에러:",
		fr = "",
		thai = "",
		en = "Failed to obtain version information!\nError:"
	},
	loading_res = {
		jp = "ロード中です。しばらくお待ちください…",
		de = "",
		zh = "正在加载资源（此过程不消耗流量），请稍候...",
		tw = "正在載入資源（此過程不消耗流量），請稍候...",
		kr = "리소스 로딩 중(데이터를 소모하지 않습니다), 잠시 기다려 주세요...",
		fr = "",
		thai = "",
		en = "Loading (no data will be used during loading), please wait ..."
	},
	loading_res_complete = {
		jp = "ロードが完了しました。",
		de = "",
		zh = "资源加载完毕！",
		tw = "資源載入完畢！",
		kr = "리소스 로딩 완료!",
		fr = "",
		thai = "",
		en = "Loading complete."
	},
	fixed = {
		jp = "修復",
		de = "",
		zh = "修复",
		tw = "修復",
		kr = "복구",
		fr = "",
		thai = "",
		en = "Repair"
	},
	fixed_res_finish = {
		jp = "修復が完了しました。ゲームを再起動してください。",
		de = "",
		zh = "修复已完成，请重新启动游戏",
		tw = "修復已完成，請重新啟動遊戲",
		kr = "복구 완료, 게임을 다시 시작해 주세요.",
		fr = "",
		thai = "",
		en = "Repair complete, please start the game again."
	},
	fixed_content = {
		jp = "修復を行いますか？",
		de = "",
		zh = "是否修复游戏？",
		tw = "是否修復遊戲？",
		kr = "복구를 진행하시겠습니까?",
		fr = "",
		thai = "",
		en = "Proceed to repair the game?"
	},
	sure = {
		jp = "決定",
		de = "",
		zh = "确定",
		tw = "確定",
		kr = "확인",
		fr = "",
		thai = "",
		en = "Confirm"
	},
	cancel = {
		jp = "キャンセル",
		de = "",
		zh = "取消",
		tw = "取消",
		kr = "취소",
		fr = "",
		thai = "",
		en = "Cancel"
	},
	notice = {
		jp = "確 認",
		de = "",
		zh = "提 示",
		tw = "提 示",
		kr = "알 림",
		fr = "",
		thai = "",
		en = "Notice"
	},
	zh = {
		jp = "中国語",
		de = "",
		zh = "中文",
		tw = "中文",
		kr = "중국어",
		fr = "",
		thai = "",
		en = "Chinese"
	},
	en = {
		jp = "英語",
		de = "",
		zh = "英文",
		tw = "英文",
		kr = "영어",
		fr = "",
		thai = "",
		en = "English"
	},
	jp = {
		jp = "日本語",
		de = "",
		zh = "日文",
		tw = "日文",
		kr = "일본어",
		fr = "",
		thai = "",
		en = "Japanese"
	},
	kr = {
		jp = "韓国語",
		de = "",
		zh = "韩文",
		tw = "韓文",
		kr = "한국어",
		fr = "",
		thai = "",
		en = "Korean"
	},
	de = {
		jp = "ドイツ語",
		de = "",
		zh = "德文",
		tw = "德文",
		kr = "독일어",
		fr = "",
		thai = "",
		en = "German"
	},
	fr = {
		jp = "フランス語",
		de = "",
		zh = "法文",
		tw = "法文",
		kr = "프랑스어",
		fr = "",
		thai = "",
		en = "French"
	},
	thai = {
		jp = "タイ語",
		de = "",
		zh = "泰文",
		tw = "泰文",
		kr = "태국어",
		fr = "",
		thai = "",
		en = "Thai"
	},
	zh_voice = {
		jp = "中国語ボイスパック",
		de = "",
		zh = "中文语音包",
		tw = "中文語音包",
		kr = "중국어 보이스",
		fr = "",
		thai = "",
		en = "Chinese Voice Pack"
	},
	en_voice = {
		jp = "英語ボイスパック",
		de = "",
		zh = "英文语音包",
		tw = "英文語音包",
		kr = "영어 보이스",
		fr = "",
		thai = "",
		en = "English Voice Pack"
	},
	jp_voice = {
		jp = "日本語ボイスパック",
		de = "",
		zh = "日文语音包",
		tw = "日文語音包",
		kr = "일본어 보이스",
		fr = "",
		thai = "",
		en = "Japanese Voice Pack"
	},
	kr_voice = {
		jp = "韓国語ボイスパック",
		de = "",
		zh = "韩文语音包",
		tw = "韓文語音包",
		kr = "한국어 보이스",
		fr = "",
		thai = "",
		en = "Korean Voice Pack"
	},
	de_voice = {
		jp = "ドイツ語ボイスパック",
		de = "",
		zh = "德文语音包",
		tw = "德文語音包",
		kr = "독일어 보이스",
		fr = "",
		thai = "",
		en = "German Voice Pack"
	},
	fr_voice = {
		jp = "フランス語ボイスパック",
		de = "",
		zh = "法文语音包",
		tw = "法文語音包",
		kr = "프랑스어 보이스",
		fr = "",
		thai = "",
		en = "French Voice Pack"
	},
	thai_voice = {
		jp = "タイ語ボイスパック",
		de = "",
		zh = "泰文语音包",
		tw = "泰文語音包",
		kr = "태국어 보이스",
		fr = "",
		thai = "",
		en = "Thai Voice Pack"
	},
	zh_voice_desc = {
		jp = "中国語を標準言語に、いくつかの方言、その他の言語及び未知の言葉がセットになった豊富なボイス体験。",
		de = "",
		zh = "以汉语普通话为通用语种，附赠少量方言口音、其他语种及不可知语种的丰富配音体验。",
		tw = "以國語為通用語種，附贈少量方言口音、其他語種及不可知語種的豐富配音體驗。",
		kr = "중국어 표준어를 기본 언어로 설정하며 일부 방언 억양 및 다른 언어 추가를 통해 풍성한 더빙 퀄리티를 제공합니다.",
		fr = "",
		thai = "",
		en = "A rich user experience based on Chinese with a modicum of lines in dialects and other languages (including unknown ones)."
	},
	en_voice_desc = {
		jp = "英語を標準言語に、いくつかの方言、その他の言語及び未知の言葉がセットになった豊富なボイス体験。",
		de = "",
		zh = "以英语为通用语种，附赠少量方言口音、其他语种及不可知语种的丰富配音体验。",
		tw = "以英語為通用語種，附贈少量方言口音、其他語種及不可知語種的豐富配音體驗。",
		kr = "영어를 기본 언어로 설정하며 일부 방언 억양 및 다른 언어 추가를 통해 풍성한 더빙 퀄리티를 제공합니다.",
		fr = "",
		thai = "",
		en = "A rich user experience based on English with a modicum of lines in dialects and other languages (including unknown ones)."
	},
	jp_voice_desc = {
		jp = "日本語を標準言語に、いくつかの方言、その他の言語及び未知の言葉がセットになった豊富なボイス体験。",
		de = "",
		zh = "以日语为通用语种，附赠少量方言口音、其他语种及不可知语种的丰富配音体验。",
		tw = "以日語為通用語種，附贈少量方言口音、其他語種及不可知語種的豐富配音體驗。",
		kr = "일본어를 기본 언어로 설정하며 일부 방언 억양 및 다른 언어 추가를 통해 풍성한 더빙 퀄리티를 제공합니다.",
		fr = "",
		thai = "",
		en = "A rich user experience based on Japanese with a modicum of lines in dialects and other languages (including unknown ones)."
	},
	kr_voice_desc = {
		jp = "韓国語を標準言語に、いくつかの方言、その他の言語及び未知の言葉がセットになった豊富なボイス体験。",
		de = "",
		zh = "以韩语为通用语种，附赠少量方言口音、其他语种及不可知语种的丰富配音体验。",
		tw = "以韓語為通用語種，附贈少量方言口音、其他語種及不可知語種的豐富配音體驗。",
		kr = "한국어를 기본 언어로 설정하며 일부 방언 억양 및 다른 언어 추가를 통해 풍성한 더빙 퀄리티를 제공합니다.",
		fr = "",
		thai = "",
		en = "A rich user experience based on Korean with a modicum of lines in dialects and other languages (including unknown ones)."
	},
	de_voice_desc = {
		jp = "ドイツ語ボイスパックについての説明",
		de = "",
		zh = "德文语音包描述",
		tw = "德文語音包描述",
		kr = "독일어 보이스 설명",
		fr = "",
		thai = "",
		en = "German Voice Pack Description"
	},
	fr_voice_desc = {
		jp = "フランス語ボイスパックについての説明",
		de = "",
		zh = "法文语音包描述",
		tw = "法文語音包描述",
		kr = "프랑스어 보이스 설명",
		fr = "",
		thai = "",
		en = "French Voice Pack Description"
	},
	thai_voice_desc = {
		jp = "タイ語ボイスパックについての説明",
		de = "",
		zh = "泰文语音包描述",
		tw = "泰文語音包描述",
		kr = "태국어 보이스 설명",
		fr = "",
		thai = "",
		en = "Thai Voice Pack Description"
	},
	version_validate_voice_fail = {
		jp = "ボイスパックのバージョン情報のチェックに失敗しました。\nエラー：",
		de = "",
		zh = "检查语音包版本状态失败!\n错误:",
		tw = "檢查語音包版本狀態失敗!\n錯誤:",
		kr = "보이스 팩 버전 상태 검사 실패!\n오류:",
		fr = "",
		thai = "",
		en = "Failed to check the voice pack version status!\nError:"
	},
	default_download = {
		jp = "デフォルト",
		de = "",
		zh = "默认下载",
		tw = "默認下載",
		kr = "기본 다운로드",
		fr = "",
		thai = "",
		en = "Download by Default"
	},
	recommend_wifi = {
		jp = "Wi-Fi環境でのダウンロードを推奨します",
		de = "",
		zh = "推荐使用WIFI进行下载",
		tw = "推薦使用WIFI進行下載",
		kr = "와이파이 환경에서 다운로드 권장",
		fr = "",
		thai = "",
		en = "Downloading through Wi-Fi Recommended"
	},
	select_lang = {
		jp = "言語リソースを選択",
		de = "",
		zh = "选择语音资源",
		tw = "選擇語言資源",
		kr = "언어 선택",
		fr = "",
		thai = "",
		en = "Select Language Resource"
	},
	check_update = {
		jp = "更新プログラムのチェック",
		de = "",
		zh = "检查更新",
		tw = "檢查更新",
		kr = "업데이트 검사",
		fr = "",
		thai = "",
		en = "Checking for updates..."
	},
	hotupdate_getinfo = {
		jp = "ホットフィックス情報を取得しています……",
		de = "",
		zh = "正在获取热更信息....",
		tw = "正在獲取熱更資訊....",
		kr = "업데이트 정보 수집 중...",
		fr = "",
		thai = "",
		en = "Acquiring hotfix data..."
	},
	default_download_lang_tips_zh = {
		jp = "中国語・英語ボイスパックをデフォルトでダウンロードします",
		de = "",
		zh = "默认下载中、英文语音包",
		tw = "預設下載中、英文語音包",
		kr = "중국어, 영어 언어팩 디폴드 다운로드 중",
		fr = "",
		thai = "",
		en = "Download Chinese and English Voice Pack by Default"
	},
	default_download_lang_tips_tw = {
		jp = "英語ボイスパックをデフォルトでダウンロードします",
		de = "",
		zh = "默认下载英文语音包",
		tw = "默認下載英文語音包",
		kr = "영어 언어팩 디폴트 다운로드",
		fr = "",
		thai = "",
		en = "Download English voice pack by default"
	},
	default_download_lang_tips_en = {
		jp = "英語ボイスパックをデフォルトでダウンロードします",
		de = "",
		zh = "默认下载英文语音包",
		tw = "默認下載英文語音包",
		kr = "영어 언어팩 디폴트 다운로드",
		fr = "",
		thai = "",
		en = "Download English voice pack by default"
	},
	default_download_lang_tips_kr = {
		jp = "韓国語ボイスパックをデフォルトでダウンロードします",
		de = "",
		zh = "默认下载韩文语音包",
		tw = "默認下載韓文語音包",
		kr = "한국어 언어팩 디폴트 다운로드",
		fr = "",
		thai = "",
		en = "Download Korean voice pack by default"
	},
	default_download_lang_tips_jp = {
		jp = "日本語ボイスパックをデフォルトでダウンロードします",
		de = "",
		zh = "默认下载日文语音包",
		tw = "默認下載日文語音包",
		kr = "일본어 언어팩 디폴트 다운로드",
		fr = "",
		thai = "",
		en = "Download Japanese voice pack by default"
	},
	default_download_lang_tips_de = {
		jp = "ドイツ語ボイスパックをデフォルトでダウンロードします",
		de = "",
		zh = "默认下载德文语音包",
		tw = "默認下載德文語音包",
		kr = "독일어 언어팩 디폴트 다운로드",
		fr = "",
		thai = "",
		en = "Download German voice pack by default"
	},
	default_download_lang_tips_fr = {
		jp = "フランス語ボイスパックをデフォルトでダウンロードします",
		de = "",
		zh = "默认下载法文语音包",
		tw = "默認下載法文語音包",
		kr = "프랑스어 언어팩 디폴트 다운로드",
		fr = "",
		thai = "",
		en = "Download French voice pack by default"
	},
	default_download_lang_tips_thai = {
		jp = "タイ語ボイスパックをデフォルトでダウンロードします",
		de = "",
		zh = "默认下载泰文语音包",
		tw = "默認下載泰文語音包",
		kr = "태국어 언어팩 디폴트 다운로드",
		fr = "",
		thai = "",
		en = "Download Thai voice pack by default"
	},
	unziping_progress = {
		jp = "展開中 %d%% %s/%s\nWi-Fi環境でのダウンロードを推奨します。リソースファイルが大きいので、しばらくお待ちください。",
		de = "",
		zh = "正在解压%d%% %s/%s\n建议在wifi环境下进行下载，资源文件较多，请耐心等待！",
		tw = "正在解壓%d%% %s/%s\n建議在wifi環境下進行下載，資源檔較多，請耐心等待！",
		kr = "압축 풀기 %d%% %s/%s\n와이파이 환경에서 다운로드를 권장합니다, 리소스 파일이 많아 시간이 걸릴 수 있습니다!",
		fr = "",
		thai = "",
		en = "Unpacking %d%% %s/%s\nPlease be patient. There are many files to download. It is recommended to use Wi-Fi for downloading."
	},
	zero_hotupdate_size = {
		jp = "ゲームリソースは最新バージョンにアップデートされました",
		de = "",
		zh = "当前游戏资源已更新至最新",
		tw = "當前遊戲資源已更新至最新",
		kr = "현재 최신 버전의 리소스가 업데이트 되었습니다",
		fr = "",
		thai = "",
		en = "Current game resources have been updated to the latest version."
	},
	next_step = {
		jp = "次へ",
		de = "",
		zh = "下一步",
		tw = "下一步",
		kr = "다음",
		fr = "",
		thai = "",
		en = "Next"
	},
	back_step = {
		jp = "前へ",
		de = "",
		zh = "上一步",
		tw = "上一步",
		kr = "이전",
		fr = "",
		thai = "",
		en = "Previous"
	},
	fixed_content_tips = {
		jp = "修復には時間がかかる場合があります。このまましばらくお待ちください。",
		de = "",
		zh = "修复时间较长，请耐心等待",
		tw = "修復時間較長，請耐心等待",
		kr = "시간이 조금 걸릴 수 있습니다, 잠시만 기다려 주세요",
		fr = "",
		thai = "",
		en = "It takes a while to repair the client. Please wait."
	},
	copy_ab = {
		jp = "パッケージリソースの展開",
		de = "",
		zh = "解压包体资源",
		tw = "解壓包體資源",
		kr = "패키지 리소스 압축 풀기",
		fr = "",
		thai = "",
		en = "Extract resources"
	},
	copy_ab_error = {
		jp = "パッケージリソースの展開に失敗しました。メモリ容量を確保してもう一度お試しください。",
		de = "",
		zh = "解压包体资源失败，请检查存储空间后重试。",
		tw = "解壓包體資源失敗，請檢查儲存空間後重試。",
		kr = "패키지 리소스의 압축을 풀지 못했습니다. 저장 공간을 확인한 후 다시 시도하세요.",
		fr = "",
		thai = "",
		en = "Failed to extract resources. Check your storage space and retry."
	},
	mass_download_fail_other = {
		jp = "%s\nリソースダウンロード失敗。再度ダウンロードしてください。",
		de = "",
		zh = "%s\n下载资源失败，请重新下载",
		tw = "%s\n下載資源失敗，請重新下載",
		kr = "%s\n 리소스 다운로드 실패, 다시 다운로드 받으세요.",
		fr = "",
		thai = "",
		en = "%s\n Download failed. Please try again."
	},
	mass_download = {
		jp = "リソースダウンロード中",
		de = "",
		zh = "正在下载资源",
		tw = "正在下載資源",
		kr = "리소스 다운로드 중",
		fr = "",
		thai = "",
		en = "Downloading files"
	},
	mass_download_Progress = {
		jp = "リソースダウンロード中：%s/%s",
		de = "",
		zh = "正在下载资源：%s/%s",
		tw = "正在下載資源：%s/%s",
		kr = "리소스 다운로드 중: %s/%s",
		fr = "",
		thai = "",
		en = "Downloading files: %s/%s"
	},
	skip = {
		jp = "SKIP",
		de = "",
		zh = "跳过",
		tw = "跳過",
		kr = "Skip",
		fr = "",
		thai = "",
		en = "Skip"
	},
	rescheker = {
		jp = "リソースチェック中：%d/%d",
		de = "",
		zh = "正在检查资源：%d/%d",
		tw = "正在檢查資源：%d/%d",
		kr = "리소스 확인 중: %d/%d",
		fr = "",
		thai = "",
		en = "Checking files: %d/%d"
	},
	download_info_wifi = {
		jp = "更新中 %s/%s\nリソースをダウンロードしています。お待ちください。",
		de = "",
		zh = "正在更新中 %s/%s\n正在下载，资源文件较多，请耐心等待！",
		tw = "正在更新中 %s/%s\n正在下載，資源檔案較多，請耐心等待！",
		kr = "업데이트 중 %s/%s\n리소스 파일을 다운로드 중이니 잠시만 기다려주세요.",
		fr = "",
		thai = "",
		en = "Updating %s/%s\nDownloading a large amount of resource files, please wait ..."
	},
	unziping_progress_wifi = {
		jp = "展開中 %d%% %s/%s\nリソースを展開しています。お待ちください。",
		de = "",
		zh = "正在解压%d%% %s/%s\n正在解压，资源文件较多，请耐心等待！",
		tw = "正在解壓%d%% %s/%s\n正在解壓，資源檔案較多，請耐心等待！",
		kr = "압축을 푸는 중 %d%% %s/%s\n리소스 파일의 압축을 푸는 중이니 잠시만 기다려주세요.",
		fr = "",
		thai = "",
		en = "Unpacking %s/%s\nUnpacking a large amount of resource files, please wait ..."
	},
	network_reconnect = {
		jp = "接続に失敗しました。再接続しています（%s）",
		de = "",
		zh = "网络连接失败....正在重试（%s）",
		tw = "網路連接失敗....正在重試（%s）",
		kr = "네트워크 연결에 실패했습니다.... 재시도 중 (%s)",
		fr = "",
		thai = "",
		en = "Network connection failure. Retrying (%s)"
	},
	network_connecting = {
		jp = "接続しています…",
		de = "",
		zh = "正在连接网络...",
		tw = "正在連接網路...",
		kr = "네트워크에 연결하는 중...",
		fr = "",
		thai = "",
		en = "Connecting to network ..."
	},
	["res-HD_voice"] = {
		jp = "高解像度動画リソース",
		de = "",
		zh = "高清视频资源",
		tw = "高清影片資源",
		kr = "고화질 비디오 리소스",
		fr = "",
		thai = "",
		en = "HD Video Resources"
	},
	["res-HD_voice_desc"] = {
		jp = "り高い解像度の動画がダウンロード可能になります。",
		de = "",
		zh = "为游戏内视频提供更高清晰度的可选下载项。",
		tw = "為遊戲內影片提供更高清晰度的可選下載項。",
		kr = "인게임 동영상을 고화질로 다운로드할 수 있는 옵션",
		fr = "",
		thai = "",
		en = "Download in-game videos in higher quality."
	},
	downloading_and_unzip = {
		jp = "更新中…更新内容やご利用の通信環境によって時間がかかる場合がございます。\nWi-Fi環境など、通信環境の良い場所でのダウンロードをおすすめします。",
		de = "",
		zh = "正在下载、解压中，建议在wifi环境下进行下载，资源文件较多，请耐心等待！",
		tw = "正在下載、解壓中，建議在wifi環境下進行下載，資源文件較多，請耐心等待！",
		kr = "리소스 다운로드 및 압축 해제 중입니다. 용량이 커 시간이 다소 소요될 수 있습니다. 안정적인 진행을 위해 Wi-Fi 환경에서 다운로드해 주십시오. 잠시만 기다려 주세요.",
		fr = "",
		thai = "",
		en = "Downloading and unpacking a large amount of resources ... Using a Wi-Fi connection is recommended."
	},
	downloading_and_unzip_wifi = {
		jp = "更新中…リソースをダウンロードしています。お待ちください。",
		de = "",
		zh = "正在下载、解压中，资源文件较多，请耐心等待！",
		tw = "正在下載、解壓中，資源文件較多，請耐心等待！",
		kr = "리소스 다운로드 및 압축 해제 중입니다. 용량이 커 시간이 다소 소요될 수 있습니다. 잠시만 기다려 주세요.",
		fr = "",
		thai = "",
		en = "Downloading and unpacking a large amount of resources ..."
	},
	unziping_progress_new = {
		jp = "ファイル展開中…%d%% %s/%s",
		de = "",
		zh = "正在解压%d%% %s/%s",
		tw = "正在解壓%d%% %s/%s",
		kr = "리소스 압축 해제 중 %d%% %s/%s",
		fr = "",
		thai = "",
		en = "Unpacking %d%%: %s/%s"
	},
	downloading_progress_new = {
		jp = "更新中… %s/%s",
		de = "",
		zh = "正在更新中 %s/%s",
		tw = "正在更新中 %s/%s",
		kr = "업데이트 중 %s/%s",
		fr = "",
		thai = "",
		en = "Updating: %s/%s"
	},
	res_fixing = {
		jp = "修復中…",
		de = "",
		zh = "资源修复中",
		tw = "資源修復中",
		kr = "리소스 복구 중",
		fr = "",
		thai = "",
		en = "Repairing ..."
	},
	res_checking = {
		jp = "リソースチェック中…",
		de = "",
		zh = "正在检查资源",
		tw = "正在檢查資源",
		kr = "리소스 확인 중",
		fr = "",
		thai = "",
		en = "Verifying resources ..."
	},
	switch_zip = {
		jp = "DLモード切替",
		de = "",
		zh = "切换下载模式",
		tw = "切換下載模式",
		kr = "다운로드 모드 전환",
		fr = "",
		thai = "",
		en = "Switch Download Mode"
	},
	switch_zip_tips = {
		jp = "ダウンロードモードを切り替えると、ゲームが再起動し、すべてのリソースを再ダウンロードすることになります。切り替えますか？",
		de = "",
		zh = "切换下载模式将重启游戏并重新下载所有游戏资源，是否继续？",
		tw = "切換下載模式將重啟遊戲並重新下載所有遊戲資源，是否繼續？",
		kr = "다운로드 모드를 변경하면 게임이 재시작되며, 모든 리소스를 다시 다운로드합니다. 계속하시겠습니까?",
		fr = "",
		thai = "",
		en = "Switching the download mode will restart the game and re-download all resources. Continue?"
	},
	mass_download_fail_other_switch = {
		jp = "%s\nリソースのダウンロードに失敗しました。再試行するか、ダウンロードモードを切り替えてからもう一度お試しください。",
		de = "",
		zh = "%s\n下载资源失败，请尝试重新下载或切换下载模式",
		tw = "%s\n下載資源失敗，請嘗試重新下載或切換下載模式",
		kr = "%s\n리소스 다운로드 실패. 다시 시도하시거나 다운로드 모드를 변경해 주세요.",
		fr = "",
		thai = "",
		en = "%s\nDownload failed. Please redownload or try a different download mode."
	}
}

function booterLang(key)
	local shortcut = GameConfig:GetCurLangShortcut()

	return BooterLanguageConfig[key][shortcut]
end

setGlobal("booterLang", booterLang)

return BooterLanguageConfig
