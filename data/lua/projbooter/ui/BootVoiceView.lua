module("projbooter.ui.BootVoiceView", package.seeall)

local var_0_0 = class("BootVoiceView")
local var_0_1 = "BootVoiceViewState"
local var_0_2 = "BootVoiceDownloadChoice"
local var_0_3 = "BootVoiceDownloadLang"
local var_0_4 = "1"
local var_0_5 = "2"
local var_0_6 = typeof(UnityEngine.UI.Text)
local var_0_7 = typeof(UnityEngine.Animator)
local var_0_8 = SLFramework.GameObjectHelper.FindChildComponent
local var_0_9 = SLFramework.GameObjectHelper.SetActive

function var_0_0.getDownloadChoices(arg_1_0)
	if not arg_1_0._choiceStr then
		arg_1_0._choiceStr = UnityEngine.PlayerPrefs.GetString(var_0_2, "")
	end

	if not string.nilorempty(arg_1_0._choiceStr) then
		return string.split(arg_1_0._choiceStr, "#")
	end

	return {}
end

function var_0_0.setDownloadChoices(arg_2_0, arg_2_1)
	arg_2_0._choiceStr = table.concat(arg_2_1, "#")
end

function var_0_0.saveDownloadChoices(arg_3_0)
	UnityEngine.PlayerPrefs.SetString(var_0_2, arg_3_0._choiceStr)
	UnityEngine.PlayerPrefs.Save()
end

function var_0_0.isNeverOpen(arg_4_0)
	return UnityEngine.PlayerPrefs.GetString(var_0_1, "0") == "0"
end

function var_0_0.isDownloading(arg_5_0)
	return UnityEngine.PlayerPrefs.GetString(var_0_1, "0") == var_0_4
end

function var_0_0.isFirstDownloadDone(arg_6_0)
	return UnityEngine.PlayerPrefs.GetString(var_0_1, "0") == var_0_5
end

function var_0_0.setDownloading(arg_7_0)
	if not arg_7_0:isDownloading() then
		UnityEngine.PlayerPrefs.SetString(var_0_1, var_0_4)
		UnityEngine.PlayerPrefs.Save()
	end
end

function var_0_0.setFirstDownloadDone(arg_8_0)
	if not arg_8_0:isFirstDownloadDone() then
		UnityEngine.PlayerPrefs.SetString(var_0_1, var_0_5)
		UnityEngine.PlayerPrefs.Save()
	end
end

function var_0_0.showChoose(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._hasGetHotupdateInfo = false
	arg_9_0._chooseCallback = arg_9_1
	arg_9_0._chooseCallbackObj = arg_9_2
	arg_9_0._go = BootResMgr.instance:getVoiceViewGo()

	arg_9_0._go.transform:SetAsLastSibling()
	arg_9_0._go:SetActive(true)

	arg_9_0._rootTr = arg_9_0._go.transform

	arg_9_0:_initView()
	arg_9_0:_setState(true)
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.voice_pack_UI_manager)
end

function var_0_0.showDownloadSize(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0._hasGetHotupdateInfo = true
	arg_10_0._hotupdateSize = arg_10_1
	arg_10_0._downloadSizeCallback = arg_10_2
	arg_10_0._downloadSizeCallbackObj = arg_10_3
	arg_10_0._go = BootResMgr.instance:getVoiceViewGo()

	arg_10_0._go.transform:SetAsLastSibling()
	arg_10_0._go:SetActive(true)

	arg_10_0._rootTr = arg_10_0._go.transform

	arg_10_0:_initView()

	if arg_10_0._firstClickNextTime then
		UpdateBeat:Add(arg_10_0._onFrame, arg_10_0)
	else
		arg_10_0:_setState(false)
		arg_10_0:_initDownloadSize()
		arg_10_0:_playAnim("go_seconcheck")
	end
end

function var_0_0.isShow(arg_11_0)
	return arg_11_0._go and arg_11_0._go.activeInHierarchy
end

function var_0_0.hide(arg_12_0)
	if arg_12_0._go then
		arg_12_0._go:SetActive(false)
	end
end

function var_0_0._onFrame(arg_13_0)
	local var_13_0 = Time.time

	if var_13_0 - arg_13_0._firstClickNextTime < 0.5 then
		return
	end

	if not arg_13_0._playDownloadSizeTime then
		arg_13_0._playDownloadSizeTime = Time.time

		arg_13_0:_playAnim("go_getinformation")
	elseif var_13_0 - arg_13_0._playDownloadSizeTime > 0.1667 then
		arg_13_0:_setState(false)
		arg_13_0:_initDownloadSize()
		UpdateBeat:Remove(arg_13_0._onFrame, arg_13_0)
	end
end

function var_0_0._initView(arg_14_0)
	var_0_9(arg_14_0._go, true)

	local var_14_0 = arg_14_0._rootTr:Find("view/btn/#btn_back").gameObject
	local var_14_1 = arg_14_0._rootTr:Find("view/btn/#btn_next").gameObject
	local var_14_2 = arg_14_0._rootTr:Find("view/btn/#btn_downloadall").gameObject
	local var_14_3 = arg_14_0._rootTr:Find("view/btn/#btn_lock").gameObject

	arg_14_0._btnBack = SLFramework.UGUI.ButtonWrap.Get(var_14_0)
	arg_14_0._btnNext = SLFramework.UGUI.ButtonWrap.Get(var_14_1)
	arg_14_0._btnDownload = SLFramework.UGUI.ButtonWrap.Get(var_14_2)
	arg_14_0._btnLock = SLFramework.UGUI.ButtonWrap.Get(var_14_3)

	arg_14_0._btnBack:AddClickListener(arg_14_0._onClickBack, arg_14_0)
	arg_14_0._btnNext:AddClickListener(arg_14_0._onClickNext, arg_14_0)
	arg_14_0._btnDownload:AddClickListener(arg_14_0._onClickDownload, arg_14_0)

	arg_14_0._firstChooseGO = arg_14_0._rootTr:Find("view/#go_firstchoose").gameObject
	arg_14_0._secondCheckGO = arg_14_0._rootTr:Find("view/#go_secondcheck").gameObject
	arg_14_0._firstSelectGO = arg_14_0._rootTr:Find("view/bg/#go_Title/first/icon1").gameObject
	arg_14_0._firstUnselectGO = arg_14_0._rootTr:Find("view/bg/#go_Title/first/icon2").gameObject
	arg_14_0._secondSelectGO = arg_14_0._rootTr:Find("view/bg/#go_Title/second/light").gameObject
	arg_14_0._secondUnselectGO = arg_14_0._rootTr:Find("view/bg/#go_Title/second/dark").gameObject
	arg_14_0._lineDarkGO = arg_14_0._rootTr:Find("view/bg/#go_Title/line_dark").gameObject
	arg_14_0._lineLightGO = arg_14_0._rootTr:Find("view/bg/#go_Title/line_light").gameObject
	arg_14_0._animator = arg_14_0._go:GetComponent(var_0_7)

	local var_14_4 = var_0_8(arg_14_0._go, "view/bg/#go_Title/first", var_0_6)
	local var_14_5 = var_0_8(arg_14_0._go, "view/bg/#go_Title/second/light", var_0_6)
	local var_14_6 = var_0_8(arg_14_0._go, "view/bg/#go_Title/second/dark", var_0_6)
	local var_14_7 = var_0_8(arg_14_0._go, "view/#go_firstchoose/#txt_desc", var_0_6)

	var_14_4.text = booterLang("select_lang")
	var_14_5.text = booterLang("check_update")
	var_14_6.text = booterLang("check_update")

	local var_14_8 = GameConfig:GetDefaultLangShortcut()

	var_14_7.text = booterLang("default_download_lang_tips_" .. var_14_8)

	local var_14_9 = var_0_8(arg_14_0._go, "view/btn/#btn_next/Text", var_0_6)
	local var_14_10 = var_0_8(arg_14_0._go, "view/btn/#btn_back/Text", var_0_6)
	local var_14_11 = var_0_8(arg_14_0._go, "view/btn/#btn_downloadall/Text", var_0_6)
	local var_14_12 = var_0_8(arg_14_0._go, "view/btn/#btn_lock/Text", var_0_6)

	var_14_9.text = booterLang("next_step")
	var_14_10.text = booterLang("back_step")
	var_14_11.text = booterLang("download")
	var_14_12.text = booterLang("download")

	local var_14_13 = GameConfig:GetCurLangShortcut()
	local var_14_14 = true

	if var_14_13 ~= "zh" then
		var_14_14 = false
	end

	arg_14_0._rootTr:Find("view/btn/#btn_back/Text en").gameObject:SetActive(var_14_14)
	arg_14_0._rootTr:Find("view/btn/#btn_downloadall/Text en").gameObject:SetActive(var_14_14)
	arg_14_0._rootTr:Find("view/btn/#btn_next/Text en").gameObject:SetActive(var_14_14)
	arg_14_0._rootTr:Find("view/btn/#btn_lock/Text en").gameObject:SetActive(var_14_14)
	arg_14_0:_initChoose()
end

function var_0_0._initChoose(arg_15_0)
	arg_15_0._selectGOList = {}
	arg_15_0._selectClickList = {}

	local var_15_0 = arg_15_0._rootTr:Find("view/#go_firstchoose/#scroll_content/viewport/content")
	local var_15_1 = var_15_0:Find("item")

	arg_15_0._supportLangList = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()

	table.insert(arg_15_0._supportLangList, "res-HD")

	local var_15_2 = GameConfig:GetDefaultVoiceShortcut()

	for iter_15_0 = 1, #arg_15_0._supportLangList do
		local var_15_3 = arg_15_0._supportLangList[iter_15_0]
		local var_15_4 = iter_15_0 == 1 and var_15_1 or SLFramework.GameObjectHelper.FindChild(var_15_0.gameObject, "item" .. iter_15_0)

		var_15_4 = var_15_4 or SLFramework.GameObjectHelper.CloneInPlace(var_15_1.gameObject, "item" .. iter_15_0)

		local var_15_5 = var_15_4.gameObject
		local var_15_6 = SLFramework.GameObjectHelper.FindChild(var_15_5, "#go_select")
		local var_15_7 = SLFramework.GameObjectHelper.FindChild(var_15_6, "icon")

		table.insert(arg_15_0._selectGOList, var_15_6)

		local var_15_8 = SLFramework.GameObjectHelper.FindChild(var_15_5, "#go_tips")

		if HotUpdateVoiceMgr.ForceSelect[var_15_3] or var_15_3 == var_15_2 then
			var_0_9(var_15_6, true)
			var_0_9(var_15_8, true)
			var_0_9(var_15_7, false)

			var_0_8(var_15_8, "dec", var_0_6).text = booterLang("default_download")
		else
			local var_15_9 = arg_15_0:getDownloadChoices()
			local var_15_10 = tabletool.indexOf(var_15_9, var_15_3) ~= nil

			var_0_9(var_15_6, var_15_10)
			var_0_9(var_15_8, false)
			var_0_9(var_15_7, true)

			local var_15_11 = SLFramework.UGUI.UIClickListener.Get(var_15_5)

			var_15_11:AddClickListener(arg_15_0._onClickItem, arg_15_0, iter_15_0)
			table.insert(arg_15_0._selectClickList, var_15_11)
		end

		local var_15_12 = var_0_8(var_15_5, "#txt_title", var_0_6)
		local var_15_13 = var_0_8(var_15_5, "#txt_dec", var_0_6)
		local var_15_14 = HotUpdateVoiceMgr.instance:getLangSize(var_15_3)

		if HotUpdateVoiceMgr.IsGuoFu and var_15_14 == 0 and var_15_3 == HotUpdateVoiceMgr.LangEn then
			var_15_14 = HotUpdateVoiceMgr.instance:getLangSize(HotUpdateVoiceMgr.LangZh)
		end

		if var_15_14 > 0 then
			var_15_12.text = booterLang(var_15_3 .. "_voice") .. string.format(" (%s)", arg_15_0:_fixSizeStr(var_15_14))
		else
			var_15_12.text = booterLang(var_15_3 .. "_voice")
		end

		var_15_13.text = booterLang(var_15_3 .. "_voice_desc")
	end
end

function var_0_0._initDownloadSize(arg_16_0)
	local var_16_0 = HotUpdateVoiceMgr.instance:getNeedDownloadSize() + (arg_16_0._hotupdateSize or 0)
	local var_16_1 = var_0_8(arg_16_0._go, "view/#go_secondcheck/#txt_tips", var_0_6)
	local var_16_2 = var_0_8(arg_16_0._go, "view/#go_secondcheck/#txt_desc", var_0_6)
	local var_16_3 = var_0_8(arg_16_0._go, "view/btn/#btn_downloadall/Text", var_0_6)

	if var_16_0 > 0 then
		local var_16_4 = string.format("<color=#bb541d>%s</color>", arg_16_0:_fixSizeStr(var_16_0))

		var_16_1.text = string.format(booterLang("hotupdate_info"), var_16_4)
		var_16_2.text = booterLang("recommend_wifi")
		var_16_3.text = booterLang("download")

		var_0_9(var_16_2.gameObject, true)
	else
		var_16_1.text = booterLang("zero_hotupdate_size")
		var_16_3.text = booterLang("sure")

		var_0_9(var_16_2.gameObject, false)
	end
end

function var_0_0._initGetInfoTips(arg_17_0)
	arg_17_0:updateTips()

	local var_17_0 = var_0_8(arg_17_0._go, "view/#go_secondcheck/#txt_desc", var_0_6)

	var_0_9(var_17_0.gameObject, false)
end

function var_0_0.updateTips(arg_18_0)
	if arg_18_0._go then
		local var_18_0 = var_0_8(arg_18_0._go, "view/#go_secondcheck/#txt_tips", var_0_6)

		if HotUpdateMgr.instance:getFailAlertCount() > 0 then
			local var_18_1 = string.format("(%d)", HotUpdateMgr.instance:getFailAlertCount())

			var_18_0.text = booterLang("hotupdate_getinfo") .. var_18_1
		else
			var_18_0.text = booterLang("hotupdate_getinfo")
		end
	end
end

function var_0_0._setState(arg_19_0, arg_19_1)
	var_0_9(arg_19_0._firstChooseGO, arg_19_1)
	var_0_9(arg_19_0._secondCheckGO, not arg_19_1)
	var_0_9(arg_19_0._firstSelectGO, arg_19_1)
	var_0_9(arg_19_0._firstUnselectGO, not arg_19_1)
	var_0_9(arg_19_0._secondSelectGO, not arg_19_1)
	var_0_9(arg_19_0._secondUnselectGO, arg_19_1)
	var_0_9(arg_19_0._lineDarkGO, arg_19_1)
	var_0_9(arg_19_0._lineLightGO, not arg_19_1)

	local var_19_0 = arg_19_0:isDownloading()

	var_0_9(arg_19_0._btnBack.gameObject, not arg_19_1 and not var_19_0 and arg_19_0._hasGetHotupdateInfo)
	var_0_9(arg_19_0._btnNext.gameObject, arg_19_1)
	var_0_9(arg_19_0._btnDownload.gameObject, not arg_19_1 and arg_19_0._hasGetHotupdateInfo)
	var_0_9(arg_19_0._btnLock.gameObject, not arg_19_1 and not arg_19_0._hasGetHotupdateInfo)
end

function var_0_0._playAnim(arg_20_0, arg_20_1)
	if arg_20_0._animator then
		arg_20_0._animator:Play(arg_20_1, 0, 0)
	end
end

function var_0_0._onClickItem(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._selectGOList[arg_21_1]

	if var_21_0 then
		var_0_9(var_21_0, not var_21_0.activeSelf)
	end
end

function var_0_0._onClickBack(arg_22_0)
	UpdateBeat:Remove(arg_22_0._onFrame, arg_22_0)
	arg_22_0:_initChoose()
	arg_22_0:_setState(true)
	arg_22_0:_playAnim("go_firstchoose")
end

function var_0_0._onClickNext(arg_23_0)
	local var_23_0 = {}

	for iter_23_0 = 1, #arg_23_0._supportLangList do
		local var_23_1 = arg_23_0._selectGOList[iter_23_0]

		if var_23_1 and var_23_1.activeSelf then
			table.insert(var_23_0, arg_23_0._supportLangList[iter_23_0])
		end
	end

	arg_23_0:setDownloadChoices(var_23_0)
	arg_23_0:_playAnim("go_seconcheck")

	if not arg_23_0._firstClickNextTime then
		arg_23_0._firstClickNextTime = Time.time
	end

	if arg_23_0._chooseCallback then
		arg_23_0:_setState(false)
		arg_23_0:_initGetInfoTips()

		local var_23_2 = arg_23_0._chooseCallback
		local var_23_3 = arg_23_0._chooseCallbackObj

		arg_23_0._chooseCallback = nil
		arg_23_0._chooseCallbackObj = nil

		var_23_2(var_23_3)
	else
		arg_23_0:_initDownloadSize()
		arg_23_0:_setState(false)
	end
end

function var_0_0._onClickDownload(arg_24_0)
	local var_24_0 = {}

	var_24_0.entrance = "first_open"
	var_24_0.update_amount = arg_24_0:_fixSizeMB(HotUpdateVoiceMgr.instance:getNeedDownloadSize())
	var_24_0.download_voice_pack_list = arg_24_0:getDownloadChoices()
	var_24_0.current_voice_pack_list = {
		GameConfig:GetCurVoiceShortcut()
	}

	SDKDataTrackMgr.instance:trackVoicePackDownloadConfirm(var_24_0)
	UpdateBeat:Remove(arg_24_0._onFrame, arg_24_0)
	arg_24_0:setDownloading()
	arg_24_0:saveDownloadChoices()
	arg_24_0._go:SetActive(false)

	local var_24_1 = arg_24_0._downloadSizeCallback
	local var_24_2 = arg_24_0._downloadSizeCallbackObj

	arg_24_0._downloadSizeCallback = nil
	arg_24_0._downloadSizeCallbackObj = nil

	var_24_1(var_24_2)
end

function var_0_0.dispose(arg_25_0)
	UpdateBeat:Remove(arg_25_0._onFrame, arg_25_0)

	if arg_25_0._go then
		arg_25_0._btnBack:RemoveClickListener()
		arg_25_0._btnNext:RemoveClickListener()
		arg_25_0._btnDownload:RemoveClickListener()
		UnityEngine.GameObject.Destroy(arg_25_0._go)

		arg_25_0._go = nil
	end

	if arg_25_0._selectClickList then
		for iter_25_0 = #arg_25_0._selectClickList, 1, -1 do
			arg_25_0._selectClickList[iter_25_0]:RemoveClickListener()

			arg_25_0._selectClickList[iter_25_0] = nil
		end

		arg_25_0._selectClickList = nil
	end

	for iter_25_1, iter_25_2 in pairs(arg_25_0) do
		if type(iter_25_2) == "userdata" then
			rawset(arg_25_0, iter_25_1, nil)
		end
	end
end

function var_0_0._fixSizeStr(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1 / HotUpdateMgr.MB_SIZE
	local var_26_1 = "MB"

	if var_26_0 < 1 then
		var_26_0 = arg_26_1 / HotUpdateMgr.KB_SIZE
		var_26_1 = "KB"

		if var_26_0 < 0.01 then
			var_26_0 = 0.01
		end
	end

	local var_26_2 = var_26_0 - var_26_0 % 0.01

	return string.format("%.2f %s", var_26_2, var_26_1)
end

function var_0_0._fixSizeMB(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1 / HotUpdateMgr.MB_SIZE

	return var_27_0 - var_27_0 % 0.01
end

var_0_0.instance = var_0_0.New()

return var_0_0
