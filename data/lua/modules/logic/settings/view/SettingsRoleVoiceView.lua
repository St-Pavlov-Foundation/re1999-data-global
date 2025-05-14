module("modules.logic.settings.view.SettingsRoleVoiceView", package.seeall)

local var_0_0 = class("SettingsRoleVoiceView", BaseView)

function var_0_0._refreshVoiceItemList(arg_1_0)
	local var_1_0 = GameConfig:GetDefaultVoiceShortcut()
	local var_1_1 = arg_1_0:_getVoiceItemList()

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		local var_1_2

		if iter_1_0 > #arg_1_0._voiceItemObjList then
			var_1_2 = arg_1_0:_create_SettingsRoleVoiceViewLangBtn(iter_1_0)

			table.insert(arg_1_0._voiceItemObjList, var_1_2)
		else
			var_1_2 = arg_1_0._voiceItemObjList[iter_1_0]
		end

		var_1_2:onUpdateMO(iter_1_1)
		var_1_2:setActive(true)
		var_1_2:setSelected(var_1_0 == iter_1_1.lang)
	end

	for iter_1_2 = #var_1_1 + 1, #arg_1_0._voiceItemObjList do
		arg_1_0._voiceItemObjList[iter_1_2]:setActive(false)
	end
end

function var_0_0._getVoiceItemList(arg_2_0)
	if not arg_2_0._tmpVoiceItemList then
		arg_2_0._tmpVoiceItemList = arg_2_0:_voiceItemList()
	end

	return arg_2_0._tmpVoiceItemList
end

function var_0_0._voiceItemList(arg_3_0)
	if not arg_3_0.viewParam then
		return arg_3_0:_getVoiceItemDataList()
	end

	return arg_3_0.viewParam.voiceItemList or arg_3_0:_getVoiceItemDataList()
end

function var_0_0._getVoiceItemDataList(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()

	for iter_4_0 = 1, #var_4_1 do
		local var_4_2 = var_4_1[iter_4_0]
		local var_4_3 = SettingsVoicePackageModel.instance:getPackInfo(var_4_2)
		local var_4_4 = var_4_3 and not var_4_3:needDownload() or false

		table.insert(var_4_0, {
			lang = var_4_2,
			langId = LangSettings.shortCut2LangIdxTab[var_4_2],
			available = var_4_4
		})
	end

	return var_4_0
end

function var_0_0._create_SettingsRoleVoiceViewLangBtn(arg_5_0)
	local var_5_0 = SettingsRoleVoiceViewLangBtn
	local var_5_1 = gohelper.cloneInPlace(arg_5_0._golangoverseas, var_5_0.__cname)

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_5_1, var_5_0, {
		parent = arg_5_0,
		baseViewContainer = arg_5_0.viewContainer
	})
end

function var_0_0.setcurSelectLang(arg_6_0, arg_6_1)
	arg_6_0._curSelectLang = arg_6_1 or 0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._voiceItemObjList or {}) do
		iter_6_1:refreshSelected(arg_6_1)
	end
end

function var_0_0._refreshLangOptionSelectState_overseas(arg_7_0, arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._voiceItemObjList or {}) do
		iter_7_1:refreshLangOptionSelectState(arg_7_1, arg_7_2)
	end
end

function var_0_0._refreshLangMode_overseas(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0._voiceItemObjList or {}) do
		iter_8_1:refreshLangMode(arg_8_1)
	end
end

function var_0_0.afterSelectedNewLang(arg_9_0)
	if not arg_9_0._batchEditMode then
		local var_9_0 = SettingsModel.instance:getVoiceValue()

		arg_9_0:_refreshLangOptionSelectState(arg_9_0._curSelectLang, var_9_0 == 0)
		arg_9_0:_playGreetingVoice()
	else
		arg_9_0:_refreshLangOptionSelectState(arg_9_0._curSelectLang, true)
	end
end

function var_0_0.onInitView(arg_10_0)
	arg_10_0._golangoverseas = gohelper.findChild(arg_10_0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang_overseas")
	arg_10_0._voiceItemObjList = {}

	arg_10_0:_refreshVoiceItemList()

	arg_10_0._gocharacterinfo = gohelper.findChild(arg_10_0.viewGO, "characterinfo/#go_characterinfo")
	arg_10_0._goops = gohelper.findChild(arg_10_0.viewGO, "characterinfo/#go_ops")
	arg_10_0._gononecharacter = gohelper.findChild(arg_10_0.viewGO, "characterinfo/#go_nonecharacter")
	arg_10_0._langInfoAnimator = gohelper.onceAddComponent(arg_10_0._gocharacterinfo, gohelper.Type_Animator)
	arg_10_0._selectCharInfoAnimator = gohelper.onceAddComponent(arg_10_0._gononecharacter, gohelper.Type_Animator)
	arg_10_0._btnbatchedit = gohelper.findChildButtonWithAudio(arg_10_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_batchedit")
	arg_10_0._btnselectall = gohelper.findChildButtonWithAudio(arg_10_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_selectall")
	arg_10_0._gobatcheditUnSelected = gohelper.findChild(arg_10_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_batchedit/btn1")
	arg_10_0._gobatcheditSelected = gohelper.findChild(arg_10_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_batchedit/btn2")
	arg_10_0._goselectAllBtn = gohelper.findChild(arg_10_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_selectall")
	arg_10_0._goselectAllUnSelected = gohelper.findChild(arg_10_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_selectall/btn1")
	arg_10_0._goselectAllSelected = gohelper.findChild(arg_10_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_selectall/btn2")
	arg_10_0._btnCN = gohelper.findChildButtonWithAudio(arg_10_0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang2/click")
	arg_10_0._btnEN = gohelper.findChildButtonWithAudio(arg_10_0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang1/click")
	arg_10_0._goCNUnSelected = gohelper.findChild(arg_10_0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang2/unselected")
	arg_10_0._goCNSelected = gohelper.findChild(arg_10_0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang2/selected")
	arg_10_0._goCNSelectPoint = gohelper.findChild(arg_10_0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang2/selected/point")
	arg_10_0._goENUnSelected = gohelper.findChild(arg_10_0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang1/unselected")
	arg_10_0._goENSelected = gohelper.findChild(arg_10_0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang1/selected")
	arg_10_0._goENSelectPoint = gohelper.findChild(arg_10_0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang1/selected/point")
	arg_10_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_10_0.viewGO, "characterinfo/#go_ops/#btn_confirm")
	arg_10_0._btncancel = gohelper.findChildButtonWithAudio(arg_10_0.viewGO, "characterinfo/#go_ops/#btn_cancel")
	arg_10_0._txtchoose = gohelper.findChildText(arg_10_0.viewGO, "characterinfo/#go_characterinfo/#txt_choose")

	if arg_10_0._editableInitView then
		arg_10_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_11_0)
	arg_11_0._btnbatchedit:AddClickListener(arg_11_0._btnbatcheditOnClick, arg_11_0)
	arg_11_0._btnselectall:AddClickListener(arg_11_0._btnselectallOnClick, arg_11_0)
	arg_11_0._btnconfirm:AddClickListener(arg_11_0._btnconfirmOnClick, arg_11_0)
	arg_11_0._btncancel:AddClickListener(arg_11_0._btncancelOnClick, arg_11_0)
	arg_11_0._btnCN:AddClickListener(arg_11_0._btnCNOnClick, arg_11_0)
	arg_11_0._btnEN:AddClickListener(arg_11_0._btnENOnClick, arg_11_0)
end

function var_0_0.removeEvents(arg_12_0)
	arg_12_0._btnbatchedit:RemoveClickListener()
	arg_12_0._btnselectall:RemoveClickListener()
	arg_12_0._btnconfirm:RemoveClickListener()
	arg_12_0._btncancel:RemoveClickListener()
	arg_12_0._btnCN:RemoveClickListener()
	arg_12_0._btnEN:RemoveClickListener()
end

function var_0_0._btnbatcheditOnClick(arg_13_0)
	arg_13_0._batchEditMode = not arg_13_0._batchEditMode

	gohelper.setActive(arg_13_0._gobatcheditUnSelected, not arg_13_0._batchEditMode)
	gohelper.setActive(arg_13_0._gobatcheditSelected, arg_13_0._batchEditMode)
	gohelper.setActive(arg_13_0._goselectAllBtn, arg_13_0._batchEditMode)

	if not arg_13_0._batchEditMode then
		arg_13_0._selectAll = false

		arg_13_0:_refreshAllBtnState()
	end

	arg_13_0.viewContainer:clearSelectedItems()

	if not arg_13_0._voiceEnd then
		arg_13_0:_stopVoice()
	end

	arg_13_0:_onSelectedChar(false, false)
	arg_13_0.viewContainer:setBatchEditMode(arg_13_0._batchEditMode)
end

function var_0_0._btnselectallOnClick(arg_14_0)
	arg_14_0._selectAll = not arg_14_0._selectAll

	if arg_14_0._selectAll then
		arg_14_0.viewContainer:selectedAllItems()

		local var_14_0 = CharacterBackpackCardListModel.instance:getCharacterCardList()

		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			arg_14_0._selectedCharMos[#arg_14_0._selectedCharMos + 1] = iter_14_1
		end

		arg_14_0:_refreshOptionView(#arg_14_0._selectedCharMos > 0)
	else
		arg_14_0.viewContainer:clearSelectedItems()
		arg_14_0:_onSelectedChar(false, false)
	end

	arg_14_0:_refreshAllBtnState()
end

function var_0_0._btnCNOnClick(arg_15_0)
	if arg_15_0._curSelectLang == LangSettings.zh then
		return
	end

	local var_15_0 = LangSettings.shortcutTab[LangSettings.zh]
	local var_15_1 = SettingsVoicePackageModel.instance:getPackInfo(var_15_0)

	if var_15_1 and var_15_1:needDownload() then
		GameFacade.showToast(ToastEnum.CharVoiceLangLost)

		return
	end

	arg_15_0._curSelectLang = LangSettings.zh

	arg_15_0:_refreshLangMode(arg_15_0._curSelectLang)

	if not arg_15_0._batchEditMode then
		local var_15_2 = SettingsModel.instance:getVoiceValue()

		arg_15_0:_refreshLangOptionSelectState(arg_15_0._curSelectLang, var_15_2 == 0)
		arg_15_0:_playGreetingVoice()
	else
		arg_15_0:_refreshLangOptionSelectState(arg_15_0._curSelectLang, true)
	end
end

function var_0_0._btnENOnClick(arg_16_0)
	if arg_16_0._curSelectLang == LangSettings.en then
		return
	end

	local var_16_0 = LangSettings.shortcutTab[LangSettings.en]
	local var_16_1 = SettingsVoicePackageModel.instance:getPackInfo(var_16_0)

	if var_16_1 and var_16_1:needDownload() then
		GameFacade.showToast(ToastEnum.CharVoiceLangLost)

		return
	end

	arg_16_0._curSelectLang = LangSettings.en

	arg_16_0:_refreshLangMode(arg_16_0._curSelectLang)

	if not arg_16_0._batchEditMode then
		local var_16_2 = SettingsModel.instance:getVoiceValue()

		arg_16_0:_refreshLangOptionSelectState(arg_16_0._curSelectLang, var_16_2 == 0)
		arg_16_0:_playGreetingVoice()
	else
		arg_16_0:_refreshLangOptionSelectState(arg_16_0._curSelectLang, true)
	end
end

function var_0_0._btnconfirmOnClick(arg_17_0)
	local var_17_0 = false

	if arg_17_0._curSelectLang == 0 then
		var_17_0 = false
	else
		for iter_17_0, iter_17_1 in ipairs(arg_17_0._selectedCharMos) do
			local var_17_1 = iter_17_1.heroId
			local var_17_2, var_17_3 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(var_17_1)

			if arg_17_0._curSelectLang ~= var_17_2 then
				var_17_0 = true

				break
			end
		end
	end

	if var_17_0 then
		SettingsRoleVoiceController.instance:setCharVoiceLangPrefValue(arg_17_0._selectedCharMos, arg_17_0._curSelectLang)
	end

	arg_17_0.viewContainer:clearSelectedItems()
	arg_17_0:_onSelectedChar(false, false)
end

function var_0_0._btncancelOnClick(arg_18_0)
	arg_18_0.viewContainer:clearSelectedItems()
	arg_18_0:_onSelectedChar(false, false)
end

function var_0_0._editableInitView(arg_19_0)
	arg_19_0._voiceEnd = true
	arg_19_0._imgBg = gohelper.findChildSingleImage(arg_19_0.viewGO, "bg/bgimg")
	arg_19_0._simageredlight = gohelper.findChildSingleImage(arg_19_0.viewGO, "bg/#simage_redlight")

	arg_19_0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))
	arg_19_0._simageredlight:LoadImage(ResUrl.getHeroGroupBg("guang_027"))
	gohelper.setActive(arg_19_0._gocharacterinfo, false)
end

function var_0_0.onOpen(arg_20_0)
	arg_20_0:addEventCb(SettingsRoleVoiceController.instance, SettingsEvent.OnSetVoiceRoleSelected, arg_20_0._onSelectedChar, arg_20_0)
	arg_20_0:addEventCb(SettingsRoleVoiceController.instance, SettingsEvent.OnSetVoiceRoleFiltered, arg_20_0._onCharFiltered, arg_20_0)
	arg_20_0:_refreshOptionView(false)
	arg_20_0:_refreshBtnStateView(false, false)
	arg_20_0:_refreshLangOptionDownloadState(LangSettings.zh, arg_20_0._goCNUnSelected)
	arg_20_0:_refreshLangOptionDownloadState(LangSettings.en, arg_20_0._goENUnSelected)
end

function var_0_0.onClose(arg_21_0)
	GameUtil.onDestroyViewMemberList(arg_21_0, "_voiceItemObjList")

	if not arg_21_0._voiceEnd then
		arg_21_0:_stopVoice()
	end

	TaskDispatcher.cancelTask(arg_21_0._playVoice, arg_21_0)
end

function var_0_0.onDestroyView(arg_22_0)
	return
end

function var_0_0._onSelectedChar(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0._selectAll and not arg_23_2 then
		arg_23_0._selectAll = false

		arg_23_0:_refreshAllBtnState()
	end

	if arg_23_0._batchEditMode then
		if not arg_23_1 then
			arg_23_0._selectedCharMos = {}

			arg_23_0:setcurSelectLang(0)
		elseif arg_23_2 then
			arg_23_0._selectedCharMos = arg_23_0._selectedCharMos or {}

			if #arg_23_0._selectedCharMos == 0 then
				arg_23_0:setcurSelectLang(0)
			end

			arg_23_0._selectedCharMos[#arg_23_0._selectedCharMos + 1] = arg_23_1
		else
			tabletool.removeValue(arg_23_0._selectedCharMos, arg_23_1)
		end
	else
		arg_23_0._selectedCharMos = arg_23_2 and {
			arg_23_1
		} or {}

		if not arg_23_2 and not arg_23_0._voiceEnd then
			arg_23_0:_stopVoice()
		end
	end

	arg_23_0:_refreshOptionView(#arg_23_0._selectedCharMos > 0)
end

function var_0_0._onCharFiltered(arg_24_0)
	if not arg_24_0._voiceEnd then
		arg_24_0:_stopVoice()
	end

	arg_24_0.viewContainer:clearSelectedItems()
	arg_24_0:_onSelectedChar(false, false)
end

function var_0_0._refreshOptionView(arg_25_0, arg_25_1)
	if arg_25_1 then
		gohelper.setActive(arg_25_0._gocharacterinfo, true)
	end

	arg_25_0._langInfoAnimator:Play(arg_25_1 and UIAnimationName.Open or UIAnimationName.Close)
	arg_25_0._selectCharInfoAnimator:Play(arg_25_1 and UIAnimationName.Close or UIAnimationName.Open)
	gohelper.setActive(arg_25_0._goops, arg_25_1)
	gohelper.setActive(arg_25_0._gononecharacter, not arg_25_1)

	if arg_25_0._batchEditMode then
		arg_25_0._txtchoose.text = luaLang("p_herovoiceedityiew_selectcharlistlang")

		arg_25_0:_refreshLangMode(arg_25_0._curSelectLang)
	elseif arg_25_1 then
		arg_25_0._curSelectLang = 0

		for iter_25_0, iter_25_1 in ipairs(arg_25_0._selectedCharMos) do
			if #arg_25_0._selectedCharMos == 1 then
				local var_25_0 = iter_25_1.heroId
				local var_25_1, var_25_2 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(var_25_0)

				arg_25_0._curSelectLang = var_25_1
			end
		end

		arg_25_0:setcurSelectLang(arg_25_0._curSelectLang)

		local var_25_3 = arg_25_0._selectedCharMos[1]

		arg_25_0._txtchoose.text = GameUtil.getSubPlaceholderLuaLang(luaLang("p_herovoiceeditview_selectcharlang"), {
			var_25_3.config.name
		})

		local var_25_4 = SettingsModel.instance:getVoiceValue()

		arg_25_0:_refreshLangOptionSelectState(arg_25_0._curSelectLang, var_25_4 == 0)
		arg_25_0:_playGreetingVoice()
		arg_25_0:_refreshLangMode(arg_25_0._curSelectLang)
	end
end

function var_0_0._refreshBtnStateView(arg_26_0, arg_26_1, arg_26_2)
	gohelper.setActive(arg_26_0._gobatcheditUnSelected, not arg_26_1)
	gohelper.setActive(arg_26_0._gobatcheditSelected, arg_26_1)
	gohelper.setActive(arg_26_0._goselectAllBtn, arg_26_1)
	gohelper.setActive(arg_26_0._goselectAllSelected, arg_26_2)
	gohelper.setActive(arg_26_0._goselectAllUnSelected, not arg_26_2)
end

function var_0_0._refreshLangMode(arg_27_0, arg_27_1)
	do return arg_27_0:_refreshLangMode_overseas(arg_27_1) end

	gohelper.setActive(arg_27_0._goCNUnSelected, arg_27_1 ~= LangSettings.zh)
	gohelper.setActive(arg_27_0._goCNSelected, arg_27_1 == LangSettings.zh)
	gohelper.setActive(arg_27_0._goENUnSelected, arg_27_1 ~= LangSettings.en)
	gohelper.setActive(arg_27_0._goENSelected, arg_27_1 == LangSettings.en)
end

function var_0_0._refreshAllBtnState(arg_28_0)
	gohelper.setActive(arg_28_0._goselectAllSelected, arg_28_0._selectAll)
	gohelper.setActive(arg_28_0._goselectAllUnSelected, not arg_28_0._selectAll)
end

function var_0_0._refreshLangOptionSelectState(arg_29_0, arg_29_1, arg_29_2)
	do return arg_29_0:_refreshLangOptionSelectState_overseas(arg_29_1, arg_29_2) end

	if arg_29_1 == LangSettings.en then
		gohelper.setActive(arg_29_0._goENSelectPoint, arg_29_2)
	elseif arg_29_1 == LangSettings.zh then
		gohelper.setActive(arg_29_0._goCNSelectPoint, arg_29_2)
	end
end

function var_0_0._refreshLangOptionDownloadState(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = LangSettings.shortcutTab[arg_30_1]
	local var_30_1 = SettingsVoicePackageModel.instance:getPackInfo(var_30_0)

	if var_30_1 and var_30_1:needDownload() then
		local var_30_2 = gohelper.findChildText(arg_30_2, "info1")
		local var_30_3 = gohelper.findChildImage(arg_30_2, "point")

		var_30_2.alpha = 0.4

		local var_30_4 = var_30_3.color

		var_30_4.a = 0.4
		var_30_3.color = var_30_4
	end
end

function var_0_0.isBatchEditMode(arg_31_0)
	return arg_31_0._batchEditMode
end

function var_0_0._playVoice(arg_32_0)
	local var_32_0 = LangSettings.shortcutTab[arg_32_0._curSelectLang]
	local var_32_1 = arg_32_0:_getVoiceEmitter()

	if not arg_32_0._voiceEnd then
		arg_32_0:_stopVoice()

		arg_32_0._voiceEarlyStop = true

		TaskDispatcher.runDelay(arg_32_0._playVoice, arg_32_0, 0.33)
	else
		arg_32_0._voiceBnkName = AudioConfig.instance:getAudioCOById(arg_32_0._curVoiceCfg.audio).bankName
		arg_32_0._voiceEnd = false

		if GameConfig:GetCurVoiceShortcut() == LangSettings.shortcutTab[LangSettings.zh] then
			ZProj.AudioManager.Instance:LoadBank(arg_32_0._voiceBnkName, var_32_0)
			var_32_1:Emitter(arg_32_0._curVoiceCfg.audio, var_32_0, arg_32_0._onEmitterCallback, arg_32_0)
			ZProj.AudioManager.Instance:UnloadBank(arg_32_0._voiceBnkName)
		else
			var_32_1:Emitter(arg_32_0._curVoiceCfg.audio, var_32_0, arg_32_0._onEmitterCallback, arg_32_0)
		end
	end
end

function var_0_0._playGreetingVoice(arg_33_0)
	if arg_33_0._selectedCharMos and #arg_33_0._selectedCharMos == 1 then
		local var_33_0 = CharacterDataConfig.instance:getCharacterVoicesCo(arg_33_0._selectedCharMos[1].heroId)
		local var_33_1

		for iter_33_0, iter_33_1 in pairs(var_33_0) do
			if iter_33_1.type == CharacterEnum.VoiceType.Greeting then
				var_33_1 = iter_33_1

				break
			end
		end

		arg_33_0._curVoiceCfg = var_33_1

		arg_33_0:_playVoice()
	end
end

function var_0_0._stopVoice(arg_34_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_Hero_Voc_Bus)

	arg_34_0._voiceEnd = true

	arg_34_0:_unloadBnk()
end

function var_0_0._getVoiceEmitter(arg_35_0)
	if not arg_35_0._emitter then
		arg_35_0._emitter = ZProj.AudioEmitter.Get(arg_35_0.viewGO)
	end

	return arg_35_0._emitter
end

function var_0_0._onEmitterCallback(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_1 == AudioEnum.AkCallbackType.AK_Duration then
		-- block empty
	elseif arg_36_1 == AudioEnum.AkCallbackType.AK_EndOfEvent then
		arg_36_0:_emitterVoiceEnd()
	end
end

function var_0_0._emitterVoiceEnd(arg_37_0)
	if arg_37_0._voiceEarlyStop then
		arg_37_0._voiceEarlyStop = false
	else
		arg_37_0._voiceEnd = true

		arg_37_0:_unloadBnk()
		arg_37_0:_refreshLangOptionSelectState(arg_37_0._curSelectLang, true)
	end
end

function var_0_0._unloadBnk(arg_38_0)
	if arg_38_0._voiceBnkName then
		ZProj.AudioManager.Instance:UnloadBank(arg_38_0._voiceBnkName)
		AudioMgr.instance:clearUnusedBanks()
	end
end

return var_0_0
