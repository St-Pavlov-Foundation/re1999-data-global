module("modules.logic.settings.view.SettingsRoleVoiceView", package.seeall)

slot0 = class("SettingsRoleVoiceView", BaseView)

function slot0._refreshVoiceItemList(slot0)
	slot1 = GameConfig:GetDefaultVoiceShortcut()

	for slot6, slot7 in ipairs(slot0:_getVoiceItemList()) do
		slot8 = nil

		if slot6 > #slot0._voiceItemObjList then
			table.insert(slot0._voiceItemObjList, slot0:_create_SettingsRoleVoiceViewLangBtn(slot6))
		else
			slot8 = slot0._voiceItemObjList[slot6]
		end

		slot8:onUpdateMO(slot7)
		slot8:setActive(true)
		slot8:setSelected(slot1 == slot7.lang)
	end

	for slot6 = #slot2 + 1, #slot0._voiceItemObjList do
		slot0._voiceItemObjList[slot6]:setActive(false)
	end
end

function slot0._getVoiceItemList(slot0)
	if not slot0._tmpVoiceItemList then
		slot0._tmpVoiceItemList = slot0:_voiceItemList()
	end

	return slot0._tmpVoiceItemList
end

function slot0._voiceItemList(slot0)
	if not slot0.viewParam then
		return slot0:_getVoiceItemDataList()
	end

	return slot0.viewParam.voiceItemList or slot0:_getVoiceItemDataList()
end

function slot0._getVoiceItemDataList(slot0)
	slot1 = {}

	for slot6 = 1, #HotUpdateVoiceMgr.instance:getSupportVoiceLangs() do
		table.insert(slot1, {
			lang = slot7,
			langId = LangSettings.shortCut2LangIdxTab[slot7],
			available = SettingsVoicePackageModel.instance:getPackInfo(slot2[slot6]) and not slot8:needDownload() or false
		})
	end

	return slot1
end

function slot0._create_SettingsRoleVoiceViewLangBtn(slot0)
	slot1 = SettingsRoleVoiceViewLangBtn

	return MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._golangoverseas, slot1.__cname), slot1, {
		parent = slot0,
		baseViewContainer = slot0.viewContainer
	})
end

function slot0.setcurSelectLang(slot0, slot1)
	slot0._curSelectLang = slot1 or 0

	for slot5, slot6 in ipairs(slot0._voiceItemObjList or {}) do
		slot6:refreshSelected(slot1)
	end
end

function slot0._refreshLangOptionSelectState_overseas(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0._voiceItemObjList or {}) do
		slot7:refreshLangOptionSelectState(slot1, slot2)
	end
end

function slot0._refreshLangMode_overseas(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._voiceItemObjList or {}) do
		slot6:refreshLangMode(slot1)
	end
end

function slot0.afterSelectedNewLang(slot0)
	if not slot0._batchEditMode then
		slot0:_refreshLangOptionSelectState(slot0._curSelectLang, SettingsModel.instance:getVoiceValue() == 0)
		slot0:_playGreetingVoice()
	else
		slot0:_refreshLangOptionSelectState(slot0._curSelectLang, true)
	end
end

function slot0.onInitView(slot0)
	slot0._golangoverseas = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang_overseas")
	slot0._voiceItemObjList = {}

	slot0:_refreshVoiceItemList()

	slot0._gocharacterinfo = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo")
	slot0._goops = gohelper.findChild(slot0.viewGO, "characterinfo/#go_ops")
	slot0._gononecharacter = gohelper.findChild(slot0.viewGO, "characterinfo/#go_nonecharacter")
	slot0._langInfoAnimator = gohelper.onceAddComponent(slot0._gocharacterinfo, gohelper.Type_Animator)
	slot0._selectCharInfoAnimator = gohelper.onceAddComponent(slot0._gononecharacter, gohelper.Type_Animator)
	slot0._btnbatchedit = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_batchedit")
	slot0._btnselectall = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_selectall")
	slot0._gobatcheditUnSelected = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_batchedit/btn1")
	slot0._gobatcheditSelected = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_batchedit/btn2")
	slot0._goselectAllBtn = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_selectall")
	slot0._goselectAllUnSelected = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_selectall/btn1")
	slot0._goselectAllSelected = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_selectall/btn2")
	slot0._btnCN = gohelper.findChildButtonWithAudio(slot0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang2/click")
	slot0._btnEN = gohelper.findChildButtonWithAudio(slot0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang1/click")
	slot0._goCNUnSelected = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang2/unselected")
	slot0._goCNSelected = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang2/selected")
	slot0._goCNSelectPoint = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang2/selected/point")
	slot0._goENUnSelected = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang1/unselected")
	slot0._goENSelected = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang1/selected")
	slot0._goENSelectPoint = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/LangContainer/#go_lang1/selected/point")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "characterinfo/#go_ops/#btn_confirm")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "characterinfo/#go_ops/#btn_cancel")
	slot0._txtchoose = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/#txt_choose")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbatchedit:AddClickListener(slot0._btnbatcheditOnClick, slot0)
	slot0._btnselectall:AddClickListener(slot0._btnselectallOnClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
	slot0._btnCN:AddClickListener(slot0._btnCNOnClick, slot0)
	slot0._btnEN:AddClickListener(slot0._btnENOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbatchedit:RemoveClickListener()
	slot0._btnselectall:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
	slot0._btnCN:RemoveClickListener()
	slot0._btnEN:RemoveClickListener()
end

function slot0._btnbatcheditOnClick(slot0)
	slot0._batchEditMode = not slot0._batchEditMode

	gohelper.setActive(slot0._gobatcheditUnSelected, not slot0._batchEditMode)
	gohelper.setActive(slot0._gobatcheditSelected, slot0._batchEditMode)
	gohelper.setActive(slot0._goselectAllBtn, slot0._batchEditMode)

	if not slot0._batchEditMode then
		slot0._selectAll = false

		slot0:_refreshAllBtnState()
	end

	slot0.viewContainer:clearSelectedItems()

	if not slot0._voiceEnd then
		slot0:_stopVoice()
	end

	slot0:_onSelectedChar(false, false)
	slot0.viewContainer:setBatchEditMode(slot0._batchEditMode)
end

function slot0._btnselectallOnClick(slot0)
	slot0._selectAll = not slot0._selectAll

	if slot0._selectAll then
		slot0.viewContainer:selectedAllItems()

		for slot5, slot6 in ipairs(CharacterBackpackCardListModel.instance:getCharacterCardList()) do
			slot0._selectedCharMos[#slot0._selectedCharMos + 1] = slot6
		end

		slot0:_refreshOptionView(#slot0._selectedCharMos > 0)
	else
		slot0.viewContainer:clearSelectedItems()
		slot0:_onSelectedChar(false, false)
	end

	slot0:_refreshAllBtnState()
end

function slot0._btnCNOnClick(slot0)
	if slot0._curSelectLang == LangSettings.zh then
		return
	end

	if SettingsVoicePackageModel.instance:getPackInfo(LangSettings.shortcutTab[LangSettings.zh]) and slot2:needDownload() then
		GameFacade.showToast(ToastEnum.CharVoiceLangLost)

		return
	end

	slot0._curSelectLang = LangSettings.zh

	slot0:_refreshLangMode(slot0._curSelectLang)

	if not slot0._batchEditMode then
		slot0:_refreshLangOptionSelectState(slot0._curSelectLang, SettingsModel.instance:getVoiceValue() == 0)
		slot0:_playGreetingVoice()
	else
		slot0:_refreshLangOptionSelectState(slot0._curSelectLang, true)
	end
end

function slot0._btnENOnClick(slot0)
	if slot0._curSelectLang == LangSettings.en then
		return
	end

	if SettingsVoicePackageModel.instance:getPackInfo(LangSettings.shortcutTab[LangSettings.en]) and slot2:needDownload() then
		GameFacade.showToast(ToastEnum.CharVoiceLangLost)

		return
	end

	slot0._curSelectLang = LangSettings.en

	slot0:_refreshLangMode(slot0._curSelectLang)

	if not slot0._batchEditMode then
		slot0:_refreshLangOptionSelectState(slot0._curSelectLang, SettingsModel.instance:getVoiceValue() == 0)
		slot0:_playGreetingVoice()
	else
		slot0:_refreshLangOptionSelectState(slot0._curSelectLang, true)
	end
end

function slot0._btnconfirmOnClick(slot0)
	slot1 = false

	if slot0._curSelectLang == 0 then
		slot1 = false
	else
		for slot5, slot6 in ipairs(slot0._selectedCharMos) do
			slot8, slot9 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(slot6.heroId)

			if slot0._curSelectLang ~= slot8 then
				slot1 = true

				break
			end
		end
	end

	if slot1 then
		SettingsRoleVoiceController.instance:setCharVoiceLangPrefValue(slot0._selectedCharMos, slot0._curSelectLang)
	end

	slot0.viewContainer:clearSelectedItems()
	slot0:_onSelectedChar(false, false)
end

function slot0._btncancelOnClick(slot0)
	slot0.viewContainer:clearSelectedItems()
	slot0:_onSelectedChar(false, false)
end

function slot0._editableInitView(slot0)
	slot0._voiceEnd = true
	slot0._imgBg = gohelper.findChildSingleImage(slot0.viewGO, "bg/bgimg")
	slot0._simageredlight = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_redlight")

	slot0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))
	slot0._simageredlight:LoadImage(ResUrl.getHeroGroupBg("guang_027"))
	gohelper.setActive(slot0._gocharacterinfo, false)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(SettingsRoleVoiceController.instance, SettingsEvent.OnSetVoiceRoleSelected, slot0._onSelectedChar, slot0)
	slot0:addEventCb(SettingsRoleVoiceController.instance, SettingsEvent.OnSetVoiceRoleFiltered, slot0._onCharFiltered, slot0)
	slot0:_refreshOptionView(false)
	slot0:_refreshBtnStateView(false, false)
	slot0:_refreshLangOptionDownloadState(LangSettings.zh, slot0._goCNUnSelected)
	slot0:_refreshLangOptionDownloadState(LangSettings.en, slot0._goENUnSelected)
end

function slot0.onClose(slot0)
	GameUtil.onDestroyViewMemberList(slot0, "_voiceItemObjList")

	if not slot0._voiceEnd then
		slot0:_stopVoice()
	end

	TaskDispatcher.cancelTask(slot0._playVoice, slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0._onSelectedChar(slot0, slot1, slot2)
	if slot0._selectAll and not slot2 then
		slot0._selectAll = false

		slot0:_refreshAllBtnState()
	end

	if slot0._batchEditMode then
		if not slot1 then
			slot0._selectedCharMos = {}

			slot0:setcurSelectLang(0)
		elseif slot2 then
			slot0._selectedCharMos = slot0._selectedCharMos or {}

			if #slot0._selectedCharMos == 0 then
				slot0:setcurSelectLang(0)
			end

			slot0._selectedCharMos[#slot0._selectedCharMos + 1] = slot1
		else
			tabletool.removeValue(slot0._selectedCharMos, slot1)
		end
	else
		slot0._selectedCharMos = slot2 and {
			slot1
		} or {}

		if not slot2 and not slot0._voiceEnd then
			slot0:_stopVoice()
		end
	end

	slot0:_refreshOptionView(#slot0._selectedCharMos > 0)
end

function slot0._onCharFiltered(slot0)
	if not slot0._voiceEnd then
		slot0:_stopVoice()
	end

	slot0.viewContainer:clearSelectedItems()
	slot0:_onSelectedChar(false, false)
end

function slot0._refreshOptionView(slot0, slot1)
	if slot1 then
		gohelper.setActive(slot0._gocharacterinfo, true)
	end

	slot0._langInfoAnimator:Play(slot1 and UIAnimationName.Open or UIAnimationName.Close)
	slot0._selectCharInfoAnimator:Play(slot1 and UIAnimationName.Close or UIAnimationName.Open)
	gohelper.setActive(slot0._goops, slot1)
	gohelper.setActive(slot0._gononecharacter, not slot1)

	if slot0._batchEditMode then
		slot0._txtchoose.text = luaLang("p_herovoiceedityiew_selectcharlistlang")

		slot0:_refreshLangMode(slot0._curSelectLang)
	elseif slot1 then
		slot0._curSelectLang = 0

		for slot5, slot6 in ipairs(slot0._selectedCharMos) do
			if #slot0._selectedCharMos == 1 then
				slot0._curSelectLang, slot9 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(slot6.heroId)
			end
		end

		slot0:setcurSelectLang(slot0._curSelectLang)

		slot0._txtchoose.text = GameUtil.getSubPlaceholderLuaLang(luaLang("p_herovoiceeditview_selectcharlang"), {
			slot0._selectedCharMos[1].config.name
		})

		slot0:_refreshLangOptionSelectState(slot0._curSelectLang, SettingsModel.instance:getVoiceValue() == 0)
		slot0:_playGreetingVoice()
		slot0:_refreshLangMode(slot0._curSelectLang)
	end
end

function slot0._refreshBtnStateView(slot0, slot1, slot2)
	gohelper.setActive(slot0._gobatcheditUnSelected, not slot1)
	gohelper.setActive(slot0._gobatcheditSelected, slot1)
	gohelper.setActive(slot0._goselectAllBtn, slot1)
	gohelper.setActive(slot0._goselectAllSelected, slot2)
	gohelper.setActive(slot0._goselectAllUnSelected, not slot2)
end

function slot0._refreshLangMode(slot0, slot1)
	return slot0:_refreshLangMode_overseas(slot1)

	gohelper.setActive(slot0._goCNUnSelected, slot1 ~= LangSettings.zh)
	gohelper.setActive(slot0._goCNSelected, slot1 == LangSettings.zh)
	gohelper.setActive(slot0._goENUnSelected, slot1 ~= LangSettings.en)
	gohelper.setActive(slot0._goENSelected, slot1 == LangSettings.en)
end

function slot0._refreshAllBtnState(slot0)
	gohelper.setActive(slot0._goselectAllSelected, slot0._selectAll)
	gohelper.setActive(slot0._goselectAllUnSelected, not slot0._selectAll)
end

function slot0._refreshLangOptionSelectState(slot0, slot1, slot2)
	return slot0:_refreshLangOptionSelectState_overseas(slot1, slot2)

	if slot1 == LangSettings.en then
		gohelper.setActive(slot0._goENSelectPoint, slot2)
	elseif slot1 == LangSettings.zh then
		gohelper.setActive(slot0._goCNSelectPoint, slot2)
	end
end

function slot0._refreshLangOptionDownloadState(slot0, slot1, slot2)
	if SettingsVoicePackageModel.instance:getPackInfo(LangSettings.shortcutTab[slot1]) and slot4:needDownload() then
		slot6 = gohelper.findChildImage(slot2, "point")
		gohelper.findChildText(slot2, "info1").alpha = 0.4
		slot7 = slot6.color
		slot7.a = 0.4
		slot6.color = slot7
	end
end

function slot0.isBatchEditMode(slot0)
	return slot0._batchEditMode
end

function slot0._playVoice(slot0)
	slot1 = LangSettings.shortcutTab[slot0._curSelectLang]
	slot2 = slot0:_getVoiceEmitter()

	if not slot0._voiceEnd then
		slot0:_stopVoice()

		slot0._voiceEarlyStop = true

		TaskDispatcher.runDelay(slot0._playVoice, slot0, 0.33)
	else
		slot0._voiceBnkName = AudioConfig.instance:getAudioCOById(slot0._curVoiceCfg.audio).bankName
		slot0._voiceEnd = false

		if GameConfig:GetCurVoiceShortcut() == LangSettings.shortcutTab[LangSettings.zh] then
			ZProj.AudioManager.Instance:LoadBank(slot0._voiceBnkName, slot1)
			slot2:Emitter(slot0._curVoiceCfg.audio, slot1, slot0._onEmitterCallback, slot0)
			ZProj.AudioManager.Instance:UnloadBank(slot0._voiceBnkName)
		else
			slot2:Emitter(slot0._curVoiceCfg.audio, slot1, slot0._onEmitterCallback, slot0)
		end
	end
end

function slot0._playGreetingVoice(slot0)
	if slot0._selectedCharMos and #slot0._selectedCharMos == 1 then
		slot2 = nil

		for slot6, slot7 in pairs(CharacterDataConfig.instance:getCharacterVoicesCo(slot0._selectedCharMos[1].heroId)) do
			if slot7.type == CharacterEnum.VoiceType.Greeting then
				slot2 = slot7

				break
			end
		end

		slot0._curVoiceCfg = slot2

		slot0:_playVoice()
	end
end

function slot0._stopVoice(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_Hero_Voc_Bus)

	slot0._voiceEnd = true

	slot0:_unloadBnk()
end

function slot0._getVoiceEmitter(slot0)
	if not slot0._emitter then
		slot0._emitter = ZProj.AudioEmitter.Get(slot0.viewGO)
	end

	return slot0._emitter
end

function slot0._onEmitterCallback(slot0, slot1, slot2)
	if slot1 == AudioEnum.AkCallbackType.AK_Duration then
		-- Nothing
	elseif slot1 == AudioEnum.AkCallbackType.AK_EndOfEvent then
		slot0:_emitterVoiceEnd()
	end
end

function slot0._emitterVoiceEnd(slot0)
	if slot0._voiceEarlyStop then
		slot0._voiceEarlyStop = false
	else
		slot0._voiceEnd = true

		slot0:_unloadBnk()
		slot0:_refreshLangOptionSelectState(slot0._curSelectLang, true)
	end
end

function slot0._unloadBnk(slot0)
	if slot0._voiceBnkName then
		ZProj.AudioManager.Instance:UnloadBank(slot0._voiceBnkName)
		AudioMgr.instance:clearUnusedBanks()
	end
end

return slot0
