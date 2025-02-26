module("modules.logic.settings.view.SettingsLanguageView", package.seeall)

slot0 = class("SettingsLanguageView", BaseView)

function slot0.onInitView(slot0)
	slot0._btndownload = gohelper.findChildButtonWithAudio(slot0.viewGO, "download/#btn_download")
	slot0._godownload = gohelper.findChild(slot0.viewGO, "download/#btn_download/#go_download")
	slot0._godownloading = gohelper.findChild(slot0.viewGO, "download/#btn_download/#go_downloading")
	slot0._txtdownloadingprogress = gohelper.findChildText(slot0.viewGO, "download/#btn_download/#go_downloading/#txt_downloadingprogress")
	slot0._gotxtlang = gohelper.findChild(slot0.viewGO, "#go_lang/#go_txtlang")
	slot0._govoicelang = gohelper.findChild(slot0.viewGO, "#go_lang/#go_voicelang")
	slot0._godropnode = gohelper.findChild(slot0.viewGO, "dropnode")
	slot0._gostoryvoicelang = gohelper.findChild(slot0.viewGO, "#go_lang/#go_storyvoicelang")
	slot0._godesc = gohelper.findChild(slot0.viewGO, "#go_lang/#go_voicelang/#go_desc")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#go_lang/#go_voicelang/#go_desc/#txt_desc")
	slot0._btncustomvoice = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_lang/#go_voicelang/#btn_go")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btndownload:AddClickListener(slot0._btndownloadOnClick, slot0)
	slot0._btncustomvoice:AddClickListener(slot0._btnCustomRoleVoiceOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btndownload:RemoveClickListener()
	slot0._btncustomvoice:RemoveClickListener()
end

function slot0._btndownloadOnClick(slot0)
	SettingsVoicePackageController.instance:openVoicePackageView()
end

function slot0._btnCustomRoleVoiceOnClick(slot0)
	SettingsRoleVoiceController.instance:openSettingRoleVoiceView()
end

function slot0._editableInitView(slot0)
	slot0._voiceDropDownGo = gohelper.findChild(slot0._godropnode, "dropvoicelang")
	slot0._txtvoiceDrop = gohelper.findChildText(slot0._voiceDropDownGo, "Label")
	slot0._voiceClick = gohelper.getClickWithAudio(slot0._voiceDropDownGo, AudioEnum.UI.play_ui_set_click)

	slot0._voiceClick:AddClickListener(slot0._onvoiceClick, slot0)

	slot0._voiceDropDownItemListGo = gohelper.findChild(slot0._voiceDropDownGo, "Template")
	slot0._voiceDropDownItemContainer = gohelper.findChild(slot0._voiceDropDownItemListGo, "Viewport/Content")
	slot0._voiceItemGo = gohelper.findChild(slot0._voiceDropDownItemContainer, "Item")

	gohelper.setActive(slot0._voiceItemGo, false)

	slot0._voiceDropDownTouchEventMgr = TouchEventMgrHepler.getTouchEventMgr(slot0._voiceDropDownItemListGo)

	slot0._voiceDropDownTouchEventMgr:SetIgnoreUI(true)
	slot0._voiceDropDownTouchEventMgr:SetOnlyTouch(true)
	slot0._voiceDropDownTouchEventMgr:SetOnClickCb(slot0._hideVoice, slot0)

	slot0._voiceItemList = {}
	slot0._langItemList = {}

	slot0:_refreshVoiceDropDown()

	slot0._langDropDownGo = gohelper.findChild(slot0._godropnode, "droplang")
	slot0._txtLangDrop = gohelper.findChildText(slot0._langDropDownGo, "Label")
	slot0._langClick = gohelper.getClickWithAudio(slot0._langDropDownGo, AudioEnum.UI.play_ui_set_click)

	slot0._langClick:AddClickListener(slot0._onlangDropClick, slot0)

	slot0._langDropDownItemListGo = gohelper.findChild(slot0._langDropDownGo, "Template")
	slot0._langDropDownItemContainer = gohelper.findChild(slot0._langDropDownItemListGo, "Viewport/Content")
	slot0._langItemGo = gohelper.findChild(slot0._langDropDownItemContainer, "Item")

	gohelper.setActive(slot0._langItemGo, false)

	slot0._langDropDownTouchEventMgr = TouchEventMgrHepler.getTouchEventMgr(slot0._langDropDownItemListGo)

	slot0._langDropDownTouchEventMgr:SetIgnoreUI(true)
	slot0._langDropDownTouchEventMgr:SetOnlyTouch(true)
	slot0._langDropDownTouchEventMgr:SetOnClickCb(slot0._hideLang, slot0)
	slot0:_refreshLangDropDown()

	slot0.trVoiceDropArrow = gohelper.findChildComponent(slot0._voiceDropDownGo, "arrow", typeof(UnityEngine.Transform))
	slot0.trLangDropArrow = gohelper.findChildComponent(slot0._langDropDownGo, "arrow", typeof(UnityEngine.Transform))
	slot2 = GameLanguageMgr.instance:getStoryIndexByShortCut(slot0._allLangTypes[slot0._curLangTxtIndex + 1])

	GameLanguageMgr.instance:setLanguageTypeByStoryIndex(slot2)
	PlayerPrefsHelper.setNumber("StoryTxtLanType", slot2 - 1)
end

function slot0._onChangeLangTxt(slot0)
	slot0:_refreshVoiceDropDownStr()
end

function slot0._refreshVoiceDropDown(slot0)
	slot0._allVoiceTypes = {}
	slot0._allStoryVoiceTypes = {}
	slot0._allStoryVoiceTypesStr = {}
	slot1 = GameConfig:GetCurVoiceShortcut()
	slot2 = SettingsController.instance:getStoryVoiceType()
	slot0._curVoiceIndex = 0
	slot0._curStoryVoiceIndex = 0

	for slot8 = 1, #HotUpdateVoiceMgr.instance:getSupportVoiceLangs() do
		if slot3[slot8] == GameConfig:GetDefaultVoiceShortcut() then
			table.insert(slot0._allVoiceTypes, 1, slot9)
		elseif OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.AudioDownload) then
			table.insert(slot0._allVoiceTypes, slot9)
		end
	end

	slot0._curVoiceIndex = (tabletool.indexOf(slot0._allVoiceTypes, slot1) or 1) - 1

	slot0:_refreshVoiceDropDownStr()
end

function slot0._refreshLangDropDown(slot0)
	slot0._allLangTypes = {}
	slot0._allLangTypesStr = {}
	slot0._curLangTxtIndex = 0

	for slot6 = 0, GameConfig:GetSupportedLangShortcuts().Length - 1 do
		if OpenConfig.instance:isOpenLangTxt(slot1[slot6]) then
			table.insert(slot0._allLangTypes, slot7)
			table.insert(slot0._allLangTypesStr, SettingsConfig.instance:getSettingLang(slot7))

			if slot7 == GameConfig:GetCurLangShortcut() then
				logNormal("cur lang index = " .. #slot0._allLangTypes)

				slot0._curLangTxtIndex = #slot0._allLangTypes - 1
			end
		end
	end

	slot0:_refreshLangDropDownStr()
end

slot2 = 84 * 5

function slot0._refreshLangDropDownStr(slot0)
	slot1 = GameConfig:GetCurLangShortcut()

	for slot5, slot6 in ipairs(slot0._allLangTypes) do
		slot7 = slot0._allLangTypesStr[slot5]

		if slot6 == slot1 then
			slot0._txtLangDrop.text = string.format("<color=#c3beb6ff>%s</color>", slot7)
			slot7 = string.format("<color=#efb785ff>%s</color>", slot7)
		else
			slot7 = string.format("<color=#c3beb6ff>%s</color>", slot7)
		end

		if slot0._langItemList[slot5] == nil then
			slot8 = slot0:getUserDataTb_()
			slot8.go = gohelper.cloneInPlace(slot0._langItemGo, "Item" .. slot5)
			slot8.goselected = gohelper.findChild(slot8.go, "BG")
			slot8.goxian = gohelper.findChild(slot8.go, "xian")
			slot8.txt = gohelper.findChildText(slot8.go, "Text")
			slot8.btn = gohelper.getClickWithAudio(slot8.go, AudioEnum.UI.play_ui_plot_common)

			slot8.btn:AddClickListener(function (slot0)
				transformhelper.setLocalScale(uv0.trLangDropArrow, 1, 1, 1)
				uv0:_onChangeLangTxtType(uv1 - 1)
			end, slot8)

			slot0._langItemList[slot5] = slot8
		end

		slot8.txt.text = slot7

		gohelper.setActive(slot8.goselected, slot6 == slot1)
		gohelper.setActive(slot8.go, true)
		gohelper.setActive(slot8.goxian, slot5 ~= #slot0._allLangTypes)
	end

	for slot5 = #slot0._allLangTypes + 1, #slot0._allLangTypes do
		gohelper.setActive(slot0._allLangTypes[slot5].go, false)
	end

	slot2 = #slot0._allLangTypes * uv0

	recthelper.setHeight(slot0._langDropDownItemContainer.transform, slot2)
	recthelper.setHeight(slot0._langDropDownItemListGo.transform, math.min(slot2, uv1))
end

function slot0._refreshVoiceDropDownStr(slot0)
	slot1 = GameConfig:GetCurVoiceShortcut()

	for slot5, slot6 in ipairs(slot0._allVoiceTypes) do
		slot7 = luaLang(slot6)
		slot8 = SettingsVoicePackageModel.instance:getPackInfo(slot6)

		if slot6 == slot1 then
			slot0._curVoiceIndex = slot5 - 1
			slot0._txtvoiceDrop.text = string.format("<color=#c3beb6ff>%s</color>", slot7)
			slot7 = string.format("<color=#efb785ff>%s</color>", slot7)
		elseif slot8 and slot8:needDownload() then
			slot9, slot10, slot11 = slot8:getLeftSizeMBorGB()
			slot7 = string.format("<color=#c3beb666>%s%s</color>", slot7, string.format("(%.2f%s)", slot9, slot11))
		else
			slot7 = string.format("<color=#c3beb6ff>%s</color>", slot7)
		end

		if slot0._voiceItemList[slot5] == nil then
			slot9 = slot0:getUserDataTb_()
			slot9.go = gohelper.cloneInPlace(slot0._voiceItemGo, "Item" .. slot5)
			slot9.goselected = gohelper.findChild(slot9.go, "BG")
			slot9.goxian = gohelper.findChild(slot9.go, "xian")
			slot9.txt = gohelper.findChildText(slot9.go, "Text")
			slot9.btn = gohelper.getClickWithAudio(slot9.go, AudioEnum.UI.play_ui_plot_common)

			slot9.btn:AddClickListener(function (slot0)
				transformhelper.setLocalScale(uv0.trVoiceDropArrow, 1, 1, 1)
				uv0:_onChangeVoiceType(uv1 - 1)
			end, slot9)

			slot0._voiceItemList[slot5] = slot9
		end

		slot9.txt.text = slot7

		gohelper.setActive(slot9.goselected, slot6 == slot1)
		gohelper.setActive(slot9.go, true)
		gohelper.setActive(slot9.goxian, slot5 ~= #slot0._allVoiceTypes)
	end

	for slot5 = #slot0._allVoiceTypes + 1, #slot0._voiceItemList do
		gohelper.setActive(slot0._voiceItemList[slot5].go, false)
	end

	slot2 = #slot0._allVoiceTypes * uv0

	recthelper.setHeight(slot0._voiceDropDownItemContainer.transform, slot2)
	recthelper.setHeight(slot0._voiceDropDownItemListGo.transform, math.min(slot2, uv1))
	slot0:_updateVoiceTips()
end

function slot0._onChangeVoiceType(slot0, slot1)
	logNormal("_onChangeVoiceType index = " .. slot1)

	if slot0._curVoiceIndex == slot1 then
		return
	end

	slot0._toChangeVoiceTypeIdx = slot1

	GameFacade.showMessageBox(MessageBoxIdDefine.SettingAllRoleVoice, MsgBoxEnum.BoxType.Yes_No, slot0._doChangeVoiceTypeAction, nil, , slot0, nil, , luaLang(slot0._allVoiceTypes[slot1 + 1]))
end

function slot0._doChangeVoiceTypeAction(slot0)
	if SettingsVoicePackageModel.instance:getPackInfo(slot0._allVoiceTypes[slot0._toChangeVoiceTypeIdx + 1]) and slot3:needDownload() then
		SettingsVoicePackageController.instance:tryDownload(slot3, true)
	else
		slot0:addEventCb(AudioMgr.instance, AudioMgr.Evt_ChangeFinish, slot0._onChangeFinish, slot0)

		slot0._curVoiceIndex = slot1

		if slot2 then
			SettingsVoicePackageController.instance:switchVoiceType(slot2, "in_settings")
			slot0:_refreshVoiceDropDownStr()

			for slot8, slot9 in pairs(HeroModel.instance:getAllHero()) do
				slot11, slot12, slot13 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(slot9.heroId)

				if not slot13 then
					SettingsRoleVoiceModel.instance:setCharVoiceLangPrefValue(slot2, slot9.heroId)
				end
			end
		else
			logError("_onChangeVoiceType error  index =" .. slot0._curVoiceIndex)
		end
	end

	gohelper.setActive(slot0._voiceDropDownItemListGo, false)
end

function slot0._updateVoiceTips(slot0)
	slot2 = SettingsConfig.instance:getVoiceTips(GameConfig:GetCurVoiceShortcut())
	slot0._txtdesc.text = slot2

	gohelper.setActive(slot0._godesc, string.nilorempty(slot2) == false)
end

function slot0._onChangeFinish(slot0)
	slot0:removeEventCb(AudioMgr.instance, AudioMgr.Evt_ChangeFinish, slot0._onChangeFinish, slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)
	GameFacade.showToast(ToastEnum.SettingCharVoiceLang)
end

function slot0._onChangeStoryVoiceType(slot0, slot1)
	logNormal("_onChangeStoryVoiceType index = " .. slot1)

	if slot0._curStoryVoiceIndex == slot1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)

	slot0._curStoryVoiceIndex = slot1

	if slot0._allStoryVoiceTypes[slot0._curStoryVoiceIndex + 1] then
		PlayerPrefsHelper.setString(PlayerPrefsKey.VoiceTypeKey_Story, slot2)
		PlayerPrefsHelper.setNumber("StoryAudioLanType", GameLanguageMgr.instance:getStoryIndexByShortCut(slot2) - 1)
		PlayerPrefsHelper.save()
		slot0:_refreshLangDropDownStr()
	else
		logError("_onChangeVoiceType error  index =" .. slot0._curStoryVoiceIndex)
	end
end

function slot0._onChangeLangTxtType(slot0, slot1)
	logNormal("_onChangeLangTxtType index = " .. slot1)

	if slot0._curLangTxtIndex == slot1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)

	slot0._curLangTxtIndex = slot1

	LangSettings.instance:SetCurLangType(slot0._allLangTypes[slot0._curLangTxtIndex + 1], slot0._onChangeLangTxtType2, slot0)
end

function slot0._onChangeLangTxtType2(slot0)
	slot2 = GameLanguageMgr.instance:getStoryIndexByShortCut(GameConfig:GetCurLangShortcut())

	GameLanguageMgr.instance:setLanguageTypeByStoryIndex(slot2)
	PlayerPrefsHelper.setNumber("StoryTxtLanType", slot2 - 1)
	slot0:_refreshLangDropDownStr()
	SettingsController.instance:changeLangTxt()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnPackItemStateChange, slot0._refreshVoiceDropDown, slot0)
	slot0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnDownloadPackSuccess, slot0._refreshVoiceDropDown, slot0)
	slot0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnDownloadPackFail, slot0._onPackItemStateChange, slot0)
	slot0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnChangeVoiceType, slot0._refreshVoiceDropDownStr, slot0)
	slot0:addEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, slot0._onChangeLangTxt, slot0)
	gohelper.setActive(slot0._btndownload.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.AudioDownload))
	gohelper.setActive(slot0._govoicelang, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SettingsVoiceLang))
	gohelper.setActive(slot0._gotxtlang, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SettingsTxtLang))
	gohelper.setActive(slot0._gostoryvoicelang, false)
	gohelper.setActive(slot0._godownload, true)
	gohelper.setActive(slot0._godownloading, false)
end

function slot0._onPackItemStateChange(slot0)
	slot0:_refreshVoiceDropDownStr()
end

function slot0._onlangDropClick(slot0)
	transformhelper.setLocalScale(slot0.trLangDropArrow, 1, -1, 1)
	gohelper.setActive(slot0._langDropDownItemListGo, true)
end

function slot0._onvoiceClick(slot0)
	SettingsVoicePackageController.instance:onSettingVoiceDropDown()
	transformhelper.setLocalScale(slot0.trVoiceDropArrow, 1, -1, 1)
	gohelper.setActive(slot0._voiceDropDownItemListGo, true)
end

function slot0._hideVoice(slot0)
	transformhelper.setLocalScale(slot0.trVoiceDropArrow, 1, 1, 1)
	gohelper.setActive(slot0._voiceDropDownItemListGo, false)
end

function slot0._hideLang(slot0)
	transformhelper.setLocalScale(slot0.trLangDropArrow, 1, 1, 1)
	gohelper.setActive(slot0._langDropDownItemListGo, false)
end

function slot0._onstoryVoiceClick(slot0)
	slot0:_cleanXian(slot0._storyVoiceDropDown)
end

function slot0._cleanXian(slot0, slot1)
	recthelper.setHeight(gohelper.findChild(slot1.gameObject, "Dropdown List").transform, recthelper.getHeight(gohelper.findChild(slot1.gameObject, "Dropdown List/Viewport/Content").transform))

	if gohelper.findChild(slot1.gameObject, "Dropdown List/Viewport/Content").transform then
		gohelper.setActive(gohelper.findChild(slot5:GetChild(slot5.childCount - 1).gameObject, "xian"), false)
	end
end

function slot0.onClose(slot0)
	slot0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnPackItemStateChange, slot0._refreshVoiceDropDown, slot0)
	slot0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnDownloadPackSuccess, slot0._refreshVoiceDropDown, slot0)
	slot0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnDownloadPackFail, slot0._refreshVoiceDropDownStr, slot0)
	slot0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnChangeVoiceType, slot0._refreshVoiceDropDownStr, slot0)
	slot0:removeEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, slot0._onChangeLangTxt, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._voiceClick:RemoveClickListener()
	slot0._langClick:RemoveClickListener()

	if not gohelper.isNil(slot0._voiceDropDownTouchEventMgr) then
		TouchEventMgrHepler.remove(slot0._voiceDropDownTouchEventMgr)
	end

	if not gohelper.isNil(slot0._langDropDownTouchEventMgr) then
		TouchEventMgrHepler.remove(slot0._langDropDownTouchEventMgr)
	end

	if slot0._voiceItemList and #slot0._voiceItemList > 0 then
		for slot4 = 1, #slot0._voiceItemList do
			slot0._voiceItemList[slot4].btn:RemoveClickListener()
		end
	end

	if slot0._langItemList and #slot0._langItemList > 0 then
		for slot4 = 1, #slot0._langItemList do
			slot0._langItemList[slot4].btn:RemoveClickListener()
		end
	end
end

return slot0
