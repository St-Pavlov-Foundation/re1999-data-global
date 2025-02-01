module("projbooter.ui.BootVoiceView", package.seeall)

slot0 = class("BootVoiceView")
slot1 = "BootVoiceViewState"
slot2 = "BootVoiceDownloadChoice"
slot3 = "BootVoiceDownloadLang"
slot4 = "1"
slot5 = "2"
slot6 = typeof(UnityEngine.UI.Text)
slot7 = typeof(UnityEngine.Animator)
slot8 = SLFramework.GameObjectHelper.FindChildComponent
slot9 = SLFramework.GameObjectHelper.SetActive

function slot0.getDownloadChoices(slot0)
	if not slot0._choiceStr then
		slot0._choiceStr = UnityEngine.PlayerPrefs.GetString(uv0, "")
	end

	if not string.nilorempty(slot0._choiceStr) then
		return string.split(slot0._choiceStr, "#")
	end

	return {}
end

function slot0.setDownloadChoices(slot0, slot1)
	slot0._choiceStr = table.concat(slot1, "#")
end

function slot0.saveDownloadChoices(slot0)
	UnityEngine.PlayerPrefs.SetString(uv0, slot0._choiceStr)
	UnityEngine.PlayerPrefs.Save()
end

function slot0.isNeverOpen(slot0)
	return UnityEngine.PlayerPrefs.GetString(uv0, "0") == "0"
end

function slot0.isDownloading(slot0)
	return UnityEngine.PlayerPrefs.GetString(uv0, "0") == uv1
end

function slot0.isFirstDownloadDone(slot0)
	return UnityEngine.PlayerPrefs.GetString(uv0, "0") == uv1
end

function slot0.setDownloading(slot0)
	if not slot0:isDownloading() then
		UnityEngine.PlayerPrefs.SetString(uv0, uv1)
		UnityEngine.PlayerPrefs.Save()
	end
end

function slot0.setFirstDownloadDone(slot0)
	if not slot0:isFirstDownloadDone() then
		UnityEngine.PlayerPrefs.SetString(uv0, uv1)
		UnityEngine.PlayerPrefs.Save()
	end
end

function slot0.showChoose(slot0, slot1, slot2)
	slot0._hasGetHotupdateInfo = false
	slot0._chooseCallback = slot1
	slot0._chooseCallbackObj = slot2
	slot0._go = BootResMgr.instance:getVoiceViewGo()

	slot0._go.transform:SetAsLastSibling()
	slot0._go:SetActive(true)

	slot0._rootTr = slot0._go.transform

	slot0:_initView()
	slot0:_setState(true)
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.voice_pack_UI_manager)
end

function slot0.showDownloadSize(slot0, slot1, slot2, slot3)
	slot0._hasGetHotupdateInfo = true
	slot0._hotupdateSize = slot1
	slot0._downloadSizeCallback = slot2
	slot0._downloadSizeCallbackObj = slot3
	slot0._go = BootResMgr.instance:getVoiceViewGo()

	slot0._go.transform:SetAsLastSibling()
	slot0._go:SetActive(true)

	slot0._rootTr = slot0._go.transform

	slot0:_initView()

	if slot0._firstClickNextTime then
		UpdateBeat:Add(slot0._onFrame, slot0)
	else
		slot0:_setState(false)
		slot0:_initDownloadSize()
		slot0:_playAnim("go_seconcheck")
	end
end

function slot0.isShow(slot0)
	return slot0._go and slot0._go.activeInHierarchy
end

function slot0.hide(slot0)
	if slot0._go then
		slot0._go:SetActive(false)
	end
end

function slot0._onFrame(slot0)
	if Time.time - slot0._firstClickNextTime < 0.5 then
		return
	end

	if not slot0._playDownloadSizeTime then
		slot0._playDownloadSizeTime = Time.time

		slot0:_playAnim("go_getinformation")
	elseif slot1 - slot0._playDownloadSizeTime > 0.1667 then
		slot0:_setState(false)
		slot0:_initDownloadSize()
		UpdateBeat:Remove(slot0._onFrame, slot0)
	end
end

function slot0._initView(slot0)
	uv0(slot0._go, true)

	slot0._btnBack = SLFramework.UGUI.ButtonWrap.Get(slot0._rootTr:Find("view/btn/#btn_back").gameObject)
	slot0._btnNext = SLFramework.UGUI.ButtonWrap.Get(slot0._rootTr:Find("view/btn/#btn_next").gameObject)
	slot0._btnDownload = SLFramework.UGUI.ButtonWrap.Get(slot0._rootTr:Find("view/btn/#btn_downloadall").gameObject)
	slot0._btnLock = SLFramework.UGUI.ButtonWrap.Get(slot0._rootTr:Find("view/btn/#btn_lock").gameObject)

	slot0._btnBack:AddClickListener(slot0._onClickBack, slot0)
	slot0._btnNext:AddClickListener(slot0._onClickNext, slot0)
	slot0._btnDownload:AddClickListener(slot0._onClickDownload, slot0)

	slot0._firstChooseGO = slot0._rootTr:Find("view/#go_firstchoose").gameObject
	slot0._secondCheckGO = slot0._rootTr:Find("view/#go_secondcheck").gameObject
	slot0._firstSelectGO = slot0._rootTr:Find("view/bg/#go_Title/first/icon1").gameObject
	slot0._firstUnselectGO = slot0._rootTr:Find("view/bg/#go_Title/first/icon2").gameObject
	slot0._secondSelectGO = slot0._rootTr:Find("view/bg/#go_Title/second/light").gameObject
	slot0._secondUnselectGO = slot0._rootTr:Find("view/bg/#go_Title/second/dark").gameObject
	slot0._lineDarkGO = slot0._rootTr:Find("view/bg/#go_Title/line_dark").gameObject
	slot0._lineLightGO = slot0._rootTr:Find("view/bg/#go_Title/line_light").gameObject
	slot0._animator = slot0._go:GetComponent(uv1)
	uv2(slot0._go, "view/bg/#go_Title/first", uv3).text = booterLang("select_lang")
	uv2(slot0._go, "view/bg/#go_Title/second/light", uv3).text = booterLang("check_update")
	uv2(slot0._go, "view/bg/#go_Title/second/dark", uv3).text = booterLang("check_update")
	uv2(slot0._go, "view/#go_firstchoose/#txt_desc", uv3).text = booterLang("default_download_lang_tips_" .. GameConfig:GetDefaultLangShortcut())
	uv2(slot0._go, "view/btn/#btn_next/Text", uv3).text = booterLang("next_step")
	uv2(slot0._go, "view/btn/#btn_back/Text", uv3).text = booterLang("back_step")
	uv2(slot0._go, "view/btn/#btn_downloadall/Text", uv3).text = booterLang("download")
	uv2(slot0._go, "view/btn/#btn_lock/Text", uv3).text = booterLang("download")
	slot15 = true

	if GameConfig:GetCurLangShortcut() ~= "zh" then
		slot15 = false
	end

	slot0._rootTr:Find("view/btn/#btn_back/Text en").gameObject:SetActive(slot15)
	slot0._rootTr:Find("view/btn/#btn_downloadall/Text en").gameObject:SetActive(slot15)
	slot0._rootTr:Find("view/btn/#btn_next/Text en").gameObject:SetActive(slot15)
	slot0._rootTr:Find("view/btn/#btn_lock/Text en").gameObject:SetActive(slot15)
	slot0:_initChoose()
end

function slot0._initChoose(slot0)
	slot0._selectGOList = {}
	slot0._selectClickList = {}
	slot2 = slot0._rootTr:Find("view/#go_firstchoose/#scroll_content/viewport/content"):Find("item")
	slot0._supportLangList = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()

	for slot7 = 1, #slot0._supportLangList do
		slot10 = (slot7 == 1 and slot2 or SLFramework.GameObjectHelper.FindChild(slot1.gameObject, "item" .. slot7) or SLFramework.GameObjectHelper.CloneInPlace(slot2.gameObject, "item" .. slot7)).gameObject
		slot11 = SLFramework.GameObjectHelper.FindChild(slot10, "#go_select")

		table.insert(slot0._selectGOList, slot11)

		slot13 = SLFramework.GameObjectHelper.FindChild(slot10, "#go_tips")

		if HotUpdateVoiceMgr.ForceSelect[slot0._supportLangList[slot7]] or slot8 == GameConfig:GetDefaultVoiceShortcut() then
			uv0(slot11, true)
			uv0(slot13, true)
			uv0(SLFramework.GameObjectHelper.FindChild(slot11, "icon"), false)

			uv1(slot13, "dec", uv2).text = booterLang("default_download")
		else
			uv0(slot11, tabletool.indexOf(slot0:getDownloadChoices(), slot8) ~= nil)
			uv0(slot13, false)
			uv0(slot12, true)

			slot16 = SLFramework.UGUI.UIClickListener.Get(slot10)

			slot16:AddClickListener(slot0._onClickItem, slot0, slot7)
			table.insert(slot0._selectClickList, slot16)
		end

		slot14 = uv1(slot10, "#txt_title", uv2)
		slot15 = uv1(slot10, "#txt_dec", uv2)

		if HotUpdateVoiceMgr.IsGuoFu and HotUpdateVoiceMgr.instance:getLangSize(slot8) == 0 and slot8 == HotUpdateVoiceMgr.LangEn then
			slot16 = HotUpdateVoiceMgr.instance:getLangSize(HotUpdateVoiceMgr.LangZh)
		end

		if slot16 > 0 then
			slot14.text = booterLang(slot8 .. "_voice") .. string.format(" (%s)", slot0:_fixSizeStr(slot16))
		else
			slot14.text = booterLang(slot8 .. "_voice")
		end

		slot15.text = booterLang(slot8 .. "_voice_desc")
	end
end

function slot0._initDownloadSize(slot0)
	slot4 = uv0(slot0._go, "view/#go_secondcheck/#txt_desc", uv1)

	if HotUpdateVoiceMgr.instance:getNeedDownloadSize() + (slot0._hotupdateSize or 0) > 0 then
		uv0(slot0._go, "view/#go_secondcheck/#txt_tips", uv1).text = string.format(booterLang("hotupdate_info"), string.format("<color=#bb541d>%s</color>", slot0:_fixSizeStr(slot2)))
		slot4.text = booterLang("recommend_wifi")
		uv0(slot0._go, "view/btn/#btn_downloadall/Text", uv1).text = booterLang("download")

		uv2(slot4.gameObject, true)
	else
		slot3.text = booterLang("zero_hotupdate_size")
		slot5.text = booterLang("sure")

		uv2(slot4.gameObject, false)
	end
end

function slot0._initGetInfoTips(slot0)
	slot0:updateTips()
	uv2(uv0(slot0._go, "view/#go_secondcheck/#txt_desc", uv1).gameObject, false)
end

function slot0.updateTips(slot0)
	if slot0._go then
		if HotUpdateMgr.instance:getFailAlertCount() > 0 then
			uv0(slot0._go, "view/#go_secondcheck/#txt_tips", uv1).text = booterLang("hotupdate_getinfo") .. string.format("(%d)", HotUpdateMgr.instance:getFailAlertCount())
		else
			slot1.text = booterLang("hotupdate_getinfo")
		end
	end
end

function slot0._setState(slot0, slot1)
	uv0(slot0._firstChooseGO, slot1)
	uv0(slot0._secondCheckGO, not slot1)
	uv0(slot0._firstSelectGO, slot1)
	uv0(slot0._firstUnselectGO, not slot1)
	uv0(slot0._secondSelectGO, not slot1)
	uv0(slot0._secondUnselectGO, slot1)
	uv0(slot0._lineDarkGO, slot1)
	uv0(slot0._lineLightGO, not slot1)
	uv0(slot0._btnBack.gameObject, not slot1 and not slot0:isDownloading() and slot0._hasGetHotupdateInfo)
	uv0(slot0._btnNext.gameObject, slot1)
	uv0(slot0._btnDownload.gameObject, not slot1 and slot0._hasGetHotupdateInfo)
	uv0(slot0._btnLock.gameObject, not slot1 and not slot0._hasGetHotupdateInfo)
end

function slot0._playAnim(slot0, slot1)
	if slot0._animator then
		slot0._animator:Play(slot1, 0, 0)
	end
end

function slot0._onClickItem(slot0, slot1)
	if slot0._selectGOList[slot1] then
		uv0(slot2, not slot2.activeSelf)
	end
end

function slot0._onClickBack(slot0)
	UpdateBeat:Remove(slot0._onFrame, slot0)
	slot0:_initChoose()
	slot0:_setState(true)
	slot0:_playAnim("go_firstchoose")
end

function slot0._onClickNext(slot0)
	slot1 = {}

	for slot5 = 1, #slot0._supportLangList do
		if slot0._selectGOList[slot5] and slot6.activeSelf then
			table.insert(slot1, slot0._supportLangList[slot5])
		end
	end

	slot0:setDownloadChoices(slot1)
	slot0:_playAnim("go_seconcheck")

	if not slot0._firstClickNextTime then
		slot0._firstClickNextTime = Time.time
	end

	if slot0._chooseCallback then
		slot0:_setState(false)
		slot0:_initGetInfoTips()

		slot0._chooseCallback = nil
		slot0._chooseCallbackObj = nil

		slot0._chooseCallback(slot0._chooseCallbackObj)
	else
		slot0:_initDownloadSize()
		slot0:_setState(false)
	end
end

function slot0._onClickDownload(slot0)
	SDKDataTrackMgr.instance:trackVoicePackDownloadConfirm({
		entrance = "first_open",
		update_amount = slot0:_fixSizeMB(HotUpdateVoiceMgr.instance:getNeedDownloadSize()),
		download_voice_pack_list = slot0:getDownloadChoices(),
		current_voice_pack_list = {
			GameConfig:GetCurVoiceShortcut()
		}
	})
	UpdateBeat:Remove(slot0._onFrame, slot0)
	slot0:setDownloading()
	slot0:saveDownloadChoices()
	slot0._go:SetActive(false)

	slot0._downloadSizeCallback = nil
	slot0._downloadSizeCallbackObj = nil

	slot0._downloadSizeCallback(slot0._downloadSizeCallbackObj)
end

function slot0.dispose(slot0)
	UpdateBeat:Remove(slot0._onFrame, slot0)

	if slot0._go then
		slot0._btnBack:RemoveClickListener()
		slot0._btnNext:RemoveClickListener()
		slot0._btnDownload:RemoveClickListener()
		UnityEngine.GameObject.Destroy(slot0._go)

		slot0._go = nil
	end

	if slot0._selectClickList then
		for slot4 = #slot0._selectClickList, 1, -1 do
			slot0._selectClickList[slot4]:RemoveClickListener()

			slot0._selectClickList[slot4] = nil
		end

		slot0._selectClickList = nil
	end

	for slot4, slot5 in pairs(slot0) do
		if type(slot5) == "userdata" then
			rawset(slot0, slot4, nil)
		end
	end
end

function slot0._fixSizeStr(slot0, slot1)
	slot3 = "MB"

	if slot1 / HotUpdateMgr.MB_SIZE < 1 then
		slot3 = "KB"

		if slot1 / HotUpdateMgr.KB_SIZE < 0.01 then
			slot2 = 0.01
		end
	end

	return string.format("%.2f %s", slot2 - slot2 % 0.01, slot3)
end

function slot0._fixSizeMB(slot0, slot1)
	slot2 = slot1 / HotUpdateMgr.MB_SIZE

	return slot2 - slot2 % 0.01
end

slot0.instance = slot0.New()

return slot0
