module("modules.logic.settings.view.SettingsLanguageView", package.seeall)

local var_0_0 = class("SettingsLanguageView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btndownload = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "download/#btn_download")
	arg_1_0._godownload = gohelper.findChild(arg_1_0.viewGO, "download/#btn_download/#go_download")
	arg_1_0._godownloading = gohelper.findChild(arg_1_0.viewGO, "download/#btn_download/#go_downloading")
	arg_1_0._txtdownloadingprogress = gohelper.findChildText(arg_1_0.viewGO, "download/#btn_download/#go_downloading/#txt_downloadingprogress")
	arg_1_0._gotxtlang = gohelper.findChild(arg_1_0.viewGO, "#go_lang/#go_txtlang")
	arg_1_0._govoicelang = gohelper.findChild(arg_1_0.viewGO, "#go_lang/#go_voicelang")
	arg_1_0._godropnode = gohelper.findChild(arg_1_0.viewGO, "dropnode")
	arg_1_0._gostoryvoicelang = gohelper.findChild(arg_1_0.viewGO, "#go_lang/#go_storyvoicelang")
	arg_1_0._godesc = gohelper.findChild(arg_1_0.viewGO, "#go_lang/#go_voicelang/#go_desc")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_lang/#go_voicelang/#go_desc/#txt_desc")
	arg_1_0._btncustomvoice = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_lang/#go_voicelang/#btn_go")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndownload:AddClickListener(arg_2_0._btndownloadOnClick, arg_2_0)
	arg_2_0._btncustomvoice:AddClickListener(arg_2_0._btnCustomRoleVoiceOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndownload:RemoveClickListener()
	arg_3_0._btncustomvoice:RemoveClickListener()
end

function var_0_0._btndownloadOnClick(arg_4_0)
	SettingsVoicePackageController.instance:openVoicePackageView()
end

function var_0_0._btnCustomRoleVoiceOnClick(arg_5_0)
	SettingsRoleVoiceController.instance:openSettingRoleVoiceView()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._voiceDropDownGo = gohelper.findChild(arg_6_0._godropnode, "dropvoicelang")
	arg_6_0._txtvoiceDrop = gohelper.findChildText(arg_6_0._voiceDropDownGo, "Label")
	arg_6_0._voiceClick = gohelper.getClickWithAudio(arg_6_0._voiceDropDownGo, AudioEnum.UI.play_ui_set_click)

	arg_6_0._voiceClick:AddClickListener(arg_6_0._onvoiceClick, arg_6_0)

	arg_6_0._voiceDropDownItemListGo = gohelper.findChild(arg_6_0._voiceDropDownGo, "Template")
	arg_6_0._voiceDropDownItemContainer = gohelper.findChild(arg_6_0._voiceDropDownItemListGo, "Viewport/Content")
	arg_6_0._voiceItemGo = gohelper.findChild(arg_6_0._voiceDropDownItemContainer, "Item")

	gohelper.setActive(arg_6_0._voiceItemGo, false)

	arg_6_0._voiceDropDownTouchEventMgr = TouchEventMgrHepler.getTouchEventMgr(arg_6_0._voiceDropDownItemListGo)

	arg_6_0._voiceDropDownTouchEventMgr:SetIgnoreUI(true)
	arg_6_0._voiceDropDownTouchEventMgr:SetOnlyTouch(true)
	arg_6_0._voiceDropDownTouchEventMgr:SetOnClickCb(arg_6_0._hideVoice, arg_6_0)

	arg_6_0._voiceItemList = {}
	arg_6_0._langItemList = {}

	arg_6_0:_refreshVoiceDropDown()

	arg_6_0._langDropDownGo = gohelper.findChild(arg_6_0._godropnode, "droplang")
	arg_6_0._txtLangDrop = gohelper.findChildText(arg_6_0._langDropDownGo, "Label")
	arg_6_0._langClick = gohelper.getClickWithAudio(arg_6_0._langDropDownGo, AudioEnum.UI.play_ui_set_click)

	arg_6_0._langClick:AddClickListener(arg_6_0._onlangDropClick, arg_6_0)

	arg_6_0._langDropDownItemListGo = gohelper.findChild(arg_6_0._langDropDownGo, "Template")
	arg_6_0._langDropDownItemContainer = gohelper.findChild(arg_6_0._langDropDownItemListGo, "Viewport/Content")
	arg_6_0._langItemGo = gohelper.findChild(arg_6_0._langDropDownItemContainer, "Item")

	gohelper.setActive(arg_6_0._langItemGo, false)

	arg_6_0._langDropDownTouchEventMgr = TouchEventMgrHepler.getTouchEventMgr(arg_6_0._langDropDownItemListGo)

	arg_6_0._langDropDownTouchEventMgr:SetIgnoreUI(true)
	arg_6_0._langDropDownTouchEventMgr:SetOnlyTouch(true)
	arg_6_0._langDropDownTouchEventMgr:SetOnClickCb(arg_6_0._hideLang, arg_6_0)
	arg_6_0:_refreshLangDropDown()

	arg_6_0.trVoiceDropArrow = gohelper.findChildComponent(arg_6_0._voiceDropDownGo, "arrow", typeof(UnityEngine.Transform))
	arg_6_0.trLangDropArrow = gohelper.findChildComponent(arg_6_0._langDropDownGo, "arrow", typeof(UnityEngine.Transform))

	local var_6_0 = arg_6_0._allLangTypes[arg_6_0._curLangTxtIndex + 1]
	local var_6_1 = GameLanguageMgr.instance:getStoryIndexByShortCut(var_6_0)

	GameLanguageMgr.instance:setLanguageTypeByStoryIndex(var_6_1)
	PlayerPrefsHelper.setNumber("StoryTxtLanType", var_6_1 - 1)
end

function var_0_0._onChangeLangTxt(arg_7_0)
	arg_7_0:_refreshVoiceDropDownStr()
end

function var_0_0._refreshVoiceDropDown(arg_8_0)
	arg_8_0._allVoiceTypes = {}
	arg_8_0._allStoryVoiceTypes = {}
	arg_8_0._allStoryVoiceTypesStr = {}

	local var_8_0 = GameConfig:GetCurVoiceShortcut()
	local var_8_1 = SettingsController.instance:getStoryVoiceType()

	arg_8_0._curVoiceIndex = 0
	arg_8_0._curStoryVoiceIndex = 0

	local var_8_2 = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()
	local var_8_3 = GameConfig:GetDefaultVoiceShortcut()

	for iter_8_0 = 1, #var_8_2 do
		local var_8_4 = var_8_2[iter_8_0]

		if var_8_4 == var_8_3 then
			table.insert(arg_8_0._allVoiceTypes, 1, var_8_4)
		elseif OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.AudioDownload) then
			table.insert(arg_8_0._allVoiceTypes, var_8_4)
		end
	end

	arg_8_0._curVoiceIndex = (tabletool.indexOf(arg_8_0._allVoiceTypes, var_8_0) or 1) - 1

	arg_8_0:_refreshVoiceDropDownStr()
end

function var_0_0._refreshLangDropDown(arg_9_0)
	local var_9_0 = GameConfig:GetSupportedLangShortcuts()

	arg_9_0._allLangTypes = {}
	arg_9_0._allLangTypesStr = {}

	local var_9_1 = GameConfig:GetCurLangShortcut()

	arg_9_0._curLangTxtIndex = 0

	for iter_9_0 = 0, var_9_0.Length - 1 do
		local var_9_2 = var_9_0[iter_9_0]

		if OpenConfig.instance:isOpenLangTxt(var_9_2) then
			table.insert(arg_9_0._allLangTypes, var_9_2)
			table.insert(arg_9_0._allLangTypesStr, SettingsConfig.instance:getSettingLang(var_9_2))

			if var_9_2 == var_9_1 then
				logNormal("cur lang index = " .. #arg_9_0._allLangTypes)

				arg_9_0._curLangTxtIndex = #arg_9_0._allLangTypes - 1
			end
		end
	end

	arg_9_0:_refreshLangDropDownStr()
end

local var_0_1 = 84
local var_0_2 = var_0_1 * 5

function var_0_0._refreshLangDropDownStr(arg_10_0)
	local var_10_0 = GameConfig:GetCurLangShortcut()

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._allLangTypes) do
		local var_10_1 = arg_10_0._allLangTypesStr[iter_10_0]

		if iter_10_1 == var_10_0 then
			arg_10_0._txtLangDrop.text = string.format("<color=#c3beb6ff>%s</color>", var_10_1)
			var_10_1 = string.format("<color=#efb785ff>%s</color>", var_10_1)
		else
			var_10_1 = string.format("<color=#c3beb6ff>%s</color>", var_10_1)
		end

		local var_10_2 = arg_10_0._langItemList[iter_10_0]

		if var_10_2 == nil then
			var_10_2 = arg_10_0:getUserDataTb_()
			var_10_2.go = gohelper.cloneInPlace(arg_10_0._langItemGo, "Item" .. iter_10_0)
			var_10_2.goselected = gohelper.findChild(var_10_2.go, "BG")
			var_10_2.goxian = gohelper.findChild(var_10_2.go, "xian")
			var_10_2.txt = gohelper.findChildText(var_10_2.go, "Text")
			var_10_2.btn = gohelper.getClickWithAudio(var_10_2.go, AudioEnum.UI.play_ui_plot_common)

			var_10_2.btn:AddClickListener(function(arg_11_0)
				transformhelper.setLocalScale(arg_10_0.trLangDropArrow, 1, 1, 1)
				arg_10_0:_onChangeLangTxtType(iter_10_0 - 1)
			end, var_10_2)

			arg_10_0._langItemList[iter_10_0] = var_10_2
		end

		var_10_2.txt.text = var_10_1

		gohelper.setActive(var_10_2.goselected, iter_10_1 == var_10_0)
		gohelper.setActive(var_10_2.go, true)
		gohelper.setActive(var_10_2.goxian, iter_10_0 ~= #arg_10_0._allLangTypes)
	end

	for iter_10_2 = #arg_10_0._allLangTypes + 1, #arg_10_0._allLangTypes do
		gohelper.setActive(arg_10_0._allLangTypes[iter_10_2].go, false)
	end

	local var_10_3 = #arg_10_0._allLangTypes * var_0_1

	recthelper.setHeight(arg_10_0._langDropDownItemContainer.transform, var_10_3)
	recthelper.setHeight(arg_10_0._langDropDownItemListGo.transform, math.min(var_10_3, var_0_2))
end

function var_0_0._refreshVoiceDropDownStr(arg_12_0)
	local var_12_0 = GameConfig:GetCurVoiceShortcut()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._allVoiceTypes) do
		local var_12_1 = luaLang(iter_12_1)
		local var_12_2 = SettingsVoicePackageModel.instance:getPackInfo(iter_12_1)

		if iter_12_1 == var_12_0 then
			arg_12_0._curVoiceIndex = iter_12_0 - 1
			arg_12_0._txtvoiceDrop.text = string.format("<color=#c3beb6ff>%s</color>", var_12_1)
			var_12_1 = string.format("<color=#efb785ff>%s</color>", var_12_1)
		elseif var_12_2 and var_12_2:needDownload() then
			local var_12_3, var_12_4, var_12_5 = var_12_2:getLeftSizeMBorGB()

			var_12_1 = string.format("<color=#c3beb666>%s%s</color>", var_12_1, string.format("(%.2f%s)", var_12_3, var_12_5))
		else
			var_12_1 = string.format("<color=#c3beb6ff>%s</color>", var_12_1)
		end

		local var_12_6 = arg_12_0._voiceItemList[iter_12_0]

		if var_12_6 == nil then
			var_12_6 = arg_12_0:getUserDataTb_()
			var_12_6.go = gohelper.cloneInPlace(arg_12_0._voiceItemGo, "Item" .. iter_12_0)
			var_12_6.goselected = gohelper.findChild(var_12_6.go, "BG")
			var_12_6.goxian = gohelper.findChild(var_12_6.go, "xian")
			var_12_6.txt = gohelper.findChildText(var_12_6.go, "Text")
			var_12_6.btn = gohelper.getClickWithAudio(var_12_6.go, AudioEnum.UI.play_ui_plot_common)

			var_12_6.btn:AddClickListener(function(arg_13_0)
				transformhelper.setLocalScale(arg_12_0.trVoiceDropArrow, 1, 1, 1)
				arg_12_0:_onChangeVoiceType(iter_12_0 - 1)
			end, var_12_6)

			arg_12_0._voiceItemList[iter_12_0] = var_12_6
		end

		var_12_6.txt.text = var_12_1

		gohelper.setActive(var_12_6.goselected, iter_12_1 == var_12_0)
		gohelper.setActive(var_12_6.go, true)
		gohelper.setActive(var_12_6.goxian, iter_12_0 ~= #arg_12_0._allVoiceTypes)
	end

	for iter_12_2 = #arg_12_0._allVoiceTypes + 1, #arg_12_0._voiceItemList do
		gohelper.setActive(arg_12_0._voiceItemList[iter_12_2].go, false)
	end

	local var_12_7 = #arg_12_0._allVoiceTypes * var_0_1

	recthelper.setHeight(arg_12_0._voiceDropDownItemContainer.transform, var_12_7)
	recthelper.setHeight(arg_12_0._voiceDropDownItemListGo.transform, math.min(var_12_7, var_0_2))
	arg_12_0:_updateVoiceTips()
end

function var_0_0._onChangeVoiceType(arg_14_0, arg_14_1)
	logNormal("_onChangeVoiceType index = " .. arg_14_1)

	if arg_14_0._curVoiceIndex == arg_14_1 then
		return
	end

	arg_14_0._toChangeVoiceTypeIdx = arg_14_1

	local var_14_0 = arg_14_0._allVoiceTypes[arg_14_1 + 1]
	local var_14_1 = luaLang(var_14_0)

	GameFacade.showMessageBox(MessageBoxIdDefine.SettingAllRoleVoice, MsgBoxEnum.BoxType.Yes_No, arg_14_0._doChangeVoiceTypeAction, nil, nil, arg_14_0, nil, nil, var_14_1)
end

function var_0_0._doChangeVoiceTypeAction(arg_15_0)
	local var_15_0 = arg_15_0._toChangeVoiceTypeIdx
	local var_15_1 = arg_15_0._allVoiceTypes[var_15_0 + 1]
	local var_15_2 = SettingsVoicePackageModel.instance:getPackInfo(var_15_1)

	if var_15_2 and var_15_2:needDownload() then
		SettingsVoicePackageController.instance:tryDownload(var_15_2, true)
	else
		arg_15_0:addEventCb(AudioMgr.instance, AudioMgr.Evt_ChangeFinish, arg_15_0._onChangeFinish, arg_15_0)

		arg_15_0._curVoiceIndex = var_15_0

		if var_15_1 then
			SettingsVoicePackageController.instance:switchVoiceType(var_15_1, "in_settings")
			arg_15_0:_refreshVoiceDropDownStr()

			local var_15_3 = HeroModel.instance:getAllHero()

			for iter_15_0, iter_15_1 in pairs(var_15_3) do
				local var_15_4 = iter_15_1.heroId
				local var_15_5, var_15_6, var_15_7 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(var_15_4)

				if not var_15_7 then
					SettingsRoleVoiceModel.instance:setCharVoiceLangPrefValue(var_15_1, iter_15_1.heroId)
				end
			end
		else
			logError("_onChangeVoiceType error  index =" .. arg_15_0._curVoiceIndex)
		end
	end

	gohelper.setActive(arg_15_0._voiceDropDownItemListGo, false)
end

function var_0_0._updateVoiceTips(arg_16_0)
	local var_16_0 = GameConfig:GetCurVoiceShortcut()
	local var_16_1 = SettingsConfig.instance:getVoiceTips(var_16_0)

	arg_16_0._txtdesc.text = var_16_1

	gohelper.setActive(arg_16_0._godesc, string.nilorempty(var_16_1) == false)
end

function var_0_0._onChangeFinish(arg_17_0)
	arg_17_0:removeEventCb(AudioMgr.instance, AudioMgr.Evt_ChangeFinish, arg_17_0._onChangeFinish, arg_17_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)
	GameFacade.showToast(ToastEnum.SettingCharVoiceLang)
end

function var_0_0._onChangeStoryVoiceType(arg_18_0, arg_18_1)
	logNormal("_onChangeStoryVoiceType index = " .. arg_18_1)

	if arg_18_0._curStoryVoiceIndex == arg_18_1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)

	arg_18_0._curStoryVoiceIndex = arg_18_1

	local var_18_0 = arg_18_0._allStoryVoiceTypes[arg_18_0._curStoryVoiceIndex + 1]

	if var_18_0 then
		PlayerPrefsHelper.setString(PlayerPrefsKey.VoiceTypeKey_Story, var_18_0)

		local var_18_1 = GameLanguageMgr.instance:getStoryIndexByShortCut(var_18_0)

		PlayerPrefsHelper.setNumber("StoryAudioLanType", var_18_1 - 1)
		PlayerPrefsHelper.save()
		arg_18_0:_refreshLangDropDownStr()
	else
		logError("_onChangeVoiceType error  index =" .. arg_18_0._curStoryVoiceIndex)
	end
end

function var_0_0._onChangeLangTxtType(arg_19_0, arg_19_1)
	logNormal("_onChangeLangTxtType index = " .. arg_19_1)

	if arg_19_0._curLangTxtIndex == arg_19_1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)

	arg_19_0._curLangTxtIndex = arg_19_1

	local var_19_0 = arg_19_0._allLangTypes[arg_19_0._curLangTxtIndex + 1]

	LangSettings.instance:SetCurLangType(var_19_0, arg_19_0._onChangeLangTxtType2, arg_19_0)
end

function var_0_0._onChangeLangTxtType2(arg_20_0)
	local var_20_0 = GameConfig:GetCurLangShortcut()
	local var_20_1 = GameLanguageMgr.instance:getStoryIndexByShortCut(var_20_0)

	GameLanguageMgr.instance:setLanguageTypeByStoryIndex(var_20_1)
	PlayerPrefsHelper.setNumber("StoryTxtLanType", var_20_1 - 1)
	arg_20_0:_refreshLangDropDownStr()
	SettingsController.instance:changeLangTxt()
end

function var_0_0.onUpdateParam(arg_21_0)
	return
end

function var_0_0.onOpen(arg_22_0)
	arg_22_0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnPackItemStateChange, arg_22_0._refreshVoiceDropDown, arg_22_0)
	arg_22_0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnDownloadPackSuccess, arg_22_0._refreshVoiceDropDown, arg_22_0)
	arg_22_0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnDownloadPackFail, arg_22_0._onPackItemStateChange, arg_22_0)
	arg_22_0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnChangeVoiceType, arg_22_0._refreshVoiceDropDownStr, arg_22_0)
	arg_22_0:addEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, arg_22_0._onChangeLangTxt, arg_22_0)
	gohelper.setActive(arg_22_0._btndownload.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.AudioDownload))
	gohelper.setActive(arg_22_0._govoicelang, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SettingsVoiceLang))
	gohelper.setActive(arg_22_0._gotxtlang, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SettingsTxtLang))
	gohelper.setActive(arg_22_0._gostoryvoicelang, false)
	gohelper.setActive(arg_22_0._godownload, true)
	gohelper.setActive(arg_22_0._godownloading, false)
end

function var_0_0._onPackItemStateChange(arg_23_0)
	arg_23_0:_refreshVoiceDropDownStr()
end

function var_0_0._onlangDropClick(arg_24_0)
	transformhelper.setLocalScale(arg_24_0.trLangDropArrow, 1, -1, 1)
	gohelper.setActive(arg_24_0._langDropDownItemListGo, true)
end

function var_0_0._onvoiceClick(arg_25_0)
	SettingsVoicePackageController.instance:onSettingVoiceDropDown()
	transformhelper.setLocalScale(arg_25_0.trVoiceDropArrow, 1, -1, 1)
	gohelper.setActive(arg_25_0._voiceDropDownItemListGo, true)
end

function var_0_0._hideVoice(arg_26_0)
	transformhelper.setLocalScale(arg_26_0.trVoiceDropArrow, 1, 1, 1)
	gohelper.setActive(arg_26_0._voiceDropDownItemListGo, false)
end

function var_0_0._hideLang(arg_27_0)
	transformhelper.setLocalScale(arg_27_0.trLangDropArrow, 1, 1, 1)
	gohelper.setActive(arg_27_0._langDropDownItemListGo, false)
end

function var_0_0._onstoryVoiceClick(arg_28_0)
	arg_28_0:_cleanXian(arg_28_0._storyVoiceDropDown)
end

function var_0_0._cleanXian(arg_29_0, arg_29_1)
	local var_29_0 = gohelper.findChild(arg_29_1.gameObject, "Dropdown List").transform
	local var_29_1 = gohelper.findChild(arg_29_1.gameObject, "Dropdown List/Viewport/Content").transform
	local var_29_2 = recthelper.getHeight(var_29_1)

	recthelper.setHeight(var_29_0, var_29_2)

	local var_29_3 = gohelper.findChild(arg_29_1.gameObject, "Dropdown List/Viewport/Content").transform

	if var_29_3 then
		local var_29_4 = var_29_3.childCount - 1
		local var_29_5 = var_29_3:GetChild(var_29_4).gameObject
		local var_29_6 = gohelper.findChild(var_29_5, "xian")

		gohelper.setActive(var_29_6, false)
	end
end

function var_0_0.onClose(arg_30_0)
	arg_30_0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnPackItemStateChange, arg_30_0._refreshVoiceDropDown, arg_30_0)
	arg_30_0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnDownloadPackSuccess, arg_30_0._refreshVoiceDropDown, arg_30_0)
	arg_30_0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnDownloadPackFail, arg_30_0._refreshVoiceDropDownStr, arg_30_0)
	arg_30_0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnChangeVoiceType, arg_30_0._refreshVoiceDropDownStr, arg_30_0)
	arg_30_0:removeEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, arg_30_0._onChangeLangTxt, arg_30_0)
end

function var_0_0.onDestroyView(arg_31_0)
	arg_31_0._voiceClick:RemoveClickListener()
	arg_31_0._langClick:RemoveClickListener()

	if not gohelper.isNil(arg_31_0._voiceDropDownTouchEventMgr) then
		TouchEventMgrHepler.remove(arg_31_0._voiceDropDownTouchEventMgr)
	end

	if not gohelper.isNil(arg_31_0._langDropDownTouchEventMgr) then
		TouchEventMgrHepler.remove(arg_31_0._langDropDownTouchEventMgr)
	end

	if arg_31_0._voiceItemList and #arg_31_0._voiceItemList > 0 then
		for iter_31_0 = 1, #arg_31_0._voiceItemList do
			arg_31_0._voiceItemList[iter_31_0].btn:RemoveClickListener()
		end
	end

	if arg_31_0._langItemList and #arg_31_0._langItemList > 0 then
		for iter_31_1 = 1, #arg_31_0._langItemList do
			arg_31_0._langItemList[iter_31_1].btn:RemoveClickListener()
		end
	end
end

return var_0_0
