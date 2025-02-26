module("modules.logic.meilanni.view.MeilanniDialogItem", package.seeall)

slot0 = class("MeilanniDialogItem", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._btnnext = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_next")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "#go_content/#go_head/#txt_remaintime")
	slot0._imageweather = gohelper.findChildImage(slot0.viewGO, "#go_content/#go_head/#txt_remaintime/#image_weather")
	slot0._txtinfo = gohelper.findChildText(slot0.viewGO, "#go_content/#go_desc/#txt_info")
	slot0._txttemplate = gohelper.findChildText(slot0.viewGO, "#go_content/#txt_template")
	slot0._txtnormalevent = gohelper.findChildText(slot0.viewGO, "#go_content/#go_normal/#txt_normalevent")
	slot0._txtspecialevent = gohelper.findChildText(slot0.viewGO, "#go_content/#go_special/#txt_specialevent")
	slot0._txtoverdueevent = gohelper.findChildText(slot0.viewGO, "#go_content/#go_overdue/#txt_overdueevent")
	slot0._gooptions = gohelper.findChild(slot0.viewGO, "#go_content/#go_options")
	slot0._gotalkitem = gohelper.findChild(slot0.viewGO, "#go_content/#go_options/#go_talkitem")
	slot0._gohead = gohelper.findChild(slot0.viewGO, "#go_content/#go_head")
	slot0._godesc = gohelper.findChild(slot0.viewGO, "#go_content/#go_desc")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_content/#go_normal")
	slot0._gospecial = gohelper.findChild(slot0.viewGO, "#go_content/#go_special")
	slot0._gooverdue = gohelper.findChild(slot0.viewGO, "#go_content/#go_overdue")
	slot0._goenddaytip = gohelper.findChild(slot0.viewGO, "#go_content/#go_enddaytip")
	slot0._txtenddaytip = gohelper.findChildText(slot0.viewGO, "#go_content/#go_enddaytip/#txt_enddaytip")
	slot0._goend = gohelper.findChild(slot0.viewGO, "#go_content/#go_end")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnext:RemoveClickListener()
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()
	slot0:addEvents()
	slot0:onOpen()
end

function slot0.onDestroy(slot0)
	slot0:onClose()
	slot0:removeEvents()
	slot0:onDestroyView()
end

function slot0._btnnextOnClick(slot0)
	if not slot0._btnnext.gameObject.activeInHierarchy or slot0._finishClose then
		return
	end

	if not slot0:_checkClickCd() then
		return
	end

	slot0:_playNextSectionOrDialog()
end

function slot0._checkClickCd(slot0)
	if Time.time - slot0._time < 0.5 then
		return
	end

	slot0._time = Time.time

	return true
end

function slot0._editableInitView(slot0)
	slot0._time = Time.time
	slot0._optionBtnList = slot0:getUserDataTb_()
	slot0._dialogItemList = slot0:getUserDataTb_()
	slot0._dialogItemCacheList = slot0:getUserDataTb_()

	gohelper.addUIClickAudio(slot0._btnnext.gameObject, AudioEnum.WeekWalk.play_artificial_ui_commonchoose)

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._canvasGroup = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_CanvasGroup)
	slot0._txtList = slot0:getUserDataTb_()
end

function slot0.onOpen(slot0)
end

function slot0._playNextSectionOrDialog(slot0)
	if slot0._dialogIndex <= #slot0._sectionList then
		slot0:_playNextDialog()

		return
	end

	if table.remove(slot0._sectionStack) then
		slot0:_playSection(slot1[1], slot1[2])
	else
		slot0:_refreshDialogBtnState()
	end
end

function slot0.setEpisodeInfo(slot0, slot1)
	if not slot1 then
		logError("MeilanniDialogItem setEpisodeInfo info is nil")

		return
	end

	slot0._episodeInfo = slot1
end

function slot0.getEpisodeInfo(slot0)
	return slot0._episodeInfo
end

function slot0._startFadeIn(slot0)
	slot0._delayFadeTime = nil

	if not MeilanniModel.instance:getDialogItemFadeIndex() then
		return
	end

	slot0._openFadeIn = true

	if slot1 <= 0 then
		return
	end

	slot0._animator.enabled = false
	slot0._canvasGroup.alpha = 0

	TaskDispatcher.cancelTask(slot0._delayFadeIn, slot0)

	slot0._delayFadeTime = slot1 * 0.4

	TaskDispatcher.runDelay(slot0._delayFadeIn, slot0, slot0._delayFadeTime)
end

function slot0._delayFadeIn(slot0)
	slot0._animator.enabled = true

	slot0._animator:Play("open", 0, 0)

	slot0._canvasGroup.alpha = 1
end

function slot0.playDesc(slot0, slot1)
	slot0:_startFadeIn()
	gohelper.setActive(slot0._godesc.gameObject, true)

	slot0._txtinfo.text = slot1

	MeilanniController.instance:dispatchEvent(MeilanniEvent.dialogChange, slot0)
end

function slot0.showEpilogue(slot0, slot1)
	slot0:_startFadeIn()
	gohelper.setActive(slot0._goenddaytip, true)

	slot0._txtenddaytip.text = slot1

	MeilanniController.instance:dispatchEvent(MeilanniEvent.dialogChange, slot0)
end

function slot0.showEndDialog(slot0, slot1, slot2, slot3)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.dialogChange, slot0)
	slot0:_startFadeIn()
	gohelper.setActive(slot0._goend, true)

	slot0._endBtn = gohelper.findChildButtonWithAudio(slot0._goend, "#btn_end", AudioEnum.WeekWalk.play_artificial_ui_talkchoose)

	slot0._endBtn:AddClickListener(slot0._clickEndHandler, slot0)
	gohelper.setActive(slot0._endBtn, false)

	slot5 = gohelper.findChildText(slot0._goend, "#btn_end/#txt_endbtndesc")
	slot0._mapId = MeilanniModel.instance:getCurMapId()
	slot0._mapInfo = MeilanniModel.instance:getMapInfo(slot0._mapId)

	if slot0._mapInfo.score <= 0 then
		gohelper.findChildText(slot0._goend, "#txt_enddesc").text = luaLang("p_meilannidialogitem_enddesc4")
		slot5.text = luaLang("p_meilannidialogitem_endbtn4")
		gohelper.findChildText(slot0._goend, "tag/#txt_endtitle").text = luaLang("p_meilannidialogitem_endtitle4")

		SLFramework.UGUI.GuiHelper.SetColor(slot5, "#EB9A58")
		UISpriteSetMgr.instance:setMeilanniSprite(gohelper.findChildImage(slot0._goend, "#btn_end/icon"), "bg_xuanzhe1")

		slot0._isFail = true

		MeilanniController.instance:dispatchEvent(MeilanniEvent.showDialogEndBtn, {
			slot5.text,
			slot0,
			slot0._clickEndHandler,
			slot0._delayFadeTime
		})

		return
	end

	if slot0._episodeInfo.episodeConfig.day == MeilanniConfig.instance:getLastEpisode(slot0._mapId).day then
		slot4.text = slot0._mapInfo.mapConfig.endContent
		slot5.text = luaLang("p_meilannidialogitem_endbtn3")
		slot6.text = luaLang("p_meilannidialogitem_endtitle3")

		SLFramework.UGUI.GuiHelper.SetColor(slot5, "#EB9A58")
		UISpriteSetMgr.instance:setMeilanniSprite(slot7, "bg_xuanzhe1")

		slot0._isSuccess = true

		MeilanniController.instance:dispatchEvent(MeilanniEvent.showDialogEndBtn, {
			slot5.text,
			slot0,
			slot0._clickEndHandler,
			slot0._delayFadeTime
		})

		return
	end

	if slot0._mapId < MeilanniEnum.unlockMapId then
		slot4.text = luaLang("p_meilannidialogitem_enddesc1")
		slot5.text = luaLang("p_meilannidialogitem_endbtn1")
		slot6.text = luaLang("p_meilannidialogitem_endtitle1")

		SLFramework.UGUI.GuiHelper.SetColor(slot5, "#D9CEBD")
		UISpriteSetMgr.instance:setMeilanniSprite(slot7, "bg_xuanzhe")
	else
		slot4.text = luaLang("p_meilannidialogitem_enddesc2")
		slot5.text = luaLang("p_meilannidialogitem_endbtn2")
		slot6.text = luaLang("p_meilannidialogitem_endtitle2")

		SLFramework.UGUI.GuiHelper.SetColor(slot5, "#D9CEBD")
		UISpriteSetMgr.instance:setMeilanniSprite(slot7, "bg_xuanzhe")
	end

	MeilanniController.instance:dispatchEvent(MeilanniEvent.showDialogEndBtn, {
		slot5.text,
		slot0,
		slot0._clickEndHandler,
		slot0._delayFadeTime
	})
end

function slot0._clickEndHandler(slot0)
	MeilanniAnimationController.instance:startAnimation()
	Activity108Rpc.instance:sendEpisodeConfirmRequest(MeilanniEnum.activityId, slot0._episodeInfo.episodeId, slot0._endCallback, slot0)
end

function slot0._endCallback(slot0)
	gohelper.destroy(slot0.viewGO)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.dialogClose, slot0)

	if slot0._isFail then
		MeilanniController.instance:dispatchEvent(MeilanniEvent.mapFail)
	elseif slot0._isSuccess then
		MeilanniController.instance:dispatchEvent(MeilanniEvent.mapSuccess)
	end
end

function slot0.showSkipDialog(slot0, slot1, slot2, slot3)
	slot0:_startFadeIn()

	if MeilanniAnimationController.instance:isPlaying() then
		slot0:_setDelayShowDialog()

		slot0._topDialog = true
	end

	slot0._config = slot1.config
	slot0._curText = slot0._txtoverdueevent
	slot0._curText.text = ""

	gohelper.setActive(slot0._gooverdue, true)

	slot0._maskline = gohelper.findChild(slot0._gooverdue, "maskline")

	gohelper.setActive(slot0._maskline, false)

	slot4 = slot1:getSkipDialog()

	slot0:_showDialog(MeilanniEnum.ResultString.dialog, slot4.content, slot4.speaker)

	slot5, slot0._scoreResult, slot7 = uv0.getResult(nil, slot4, "")

	if not string.nilorempty(slot5) then
		slot0._customDialogTime = MeilanniEnum.selectedTime

		slot0:_showDialog(MeilanniEnum.ResultString.result, slot5)
	end
end

function slot0.clearConfig(slot0)
	slot0._config = nil
	slot0._content = nil
end

function slot0.showHistory(slot0, slot1, slot2, slot3)
	slot0:_startFadeIn()

	if MeilanniAnimationController.instance:isPlaying() then
		slot0:_setDelayShowDialog()
	end

	if not slot0._config then
		slot0._config = slot1.config

		slot0:_setText(slot0._config)
	end

	slot6 = slot1.interactParam[slot2 + 1][2]

	if not slot1.historylist[slot2] then
		logError(string.format("MeilanniDialogItem no eventHistory id:%s,index:%s", slot0._config.id, slot2))

		return
	end

	slot9 = slot1._historyResult or ""
	slot10, slot11 = nil

	for slot15, slot16 in ipairs(slot7.history) do
		slot17 = string.splitToNumber(slot16, "#")
		slot19 = slot17[2]

		if not lua_activity108_dialog.configDict[slot6][slot17[1]] then
			logError(string.format("MeilanniDialogItem showHistory no stepConfig dialogId:%s,stepId:%s", slot6, slot18))
		end

		if slot20 and slot20.type == MeilanniEnum.ResultString.dialog then
			slot0:_showDialog(MeilanniEnum.ResultString.dialog, slot20.content, slot20.speaker)
		elseif slot20 and slot20.type == MeilanniEnum.ResultString.options then
			if string.split(slot20.content, "#")[slot19] then
				slot0:_showDialog(MeilanniEnum.ResultString.options, string.format("<color=#B95F0F>\"%s\"</color>", slot23))

				if string.len(slot9) <= 0 then
					slot9, slot0._scoreResult, slot0._featureResult = uv0.getResult(slot1, MeilanniConfig.instance:getDialog(slot6, string.split(slot20.param, "#")[slot19]), slot9, true)
				end
			end
		end
	end

	if string.len(slot9) > 0 then
		slot1._historyResult = slot9

		if slot4 == #slot1.interactParam then
			slot0:_showDialog(MeilanniEnum.ResultString.result, slot9)
		end
	end
end

function slot0.isTopDialog(slot0)
	return slot0._topDialog
end

function slot0.playDialog(slot0, slot1)
	slot0._topDialog = true
	slot0._mapElement = slot1
	slot0._elementInfo = slot0._mapElement._info
	slot0._mapId = MeilanniModel.instance:getCurMapId()
	slot0._mapInfo = MeilanniModel.instance:getMapInfo(slot0._mapId)
	slot2 = slot0._mapInfo:getCurEpisodeInfo()

	if not slot0._config then
		slot0._config = slot0._mapElement._config

		slot0:_setText(slot0._config)
	end

	slot0:_playStory()
end

function slot0._setText(slot0, slot1)
	if slot1.type == 0 then
		slot0._curText = slot0._txtnormalevent
	else
		slot0._curText = slot0._txtspecialevent
	end

	slot0._curText.text = ""
	slot2 = slot1.type == 0

	gohelper.setActive(slot0._gonormal, slot2)
	gohelper.setActive(slot0._gospecial, not slot2)
	slot0:_hideMaskline(slot1)
end

function slot0._hideMaskline(slot0, slot1)
	slot0._maskline = gohelper.findChild(slot1.type == 0 and slot0._gonormal or slot0._gospecial, "maskline")

	gohelper.setActive(slot0._maskline, false)
end

function slot0._playStory(slot0)
	slot0._sectionStack = {}
	slot0._optionId = 0
	slot0._mainSectionId = "0"
	slot0._sectionId = slot0._mainSectionId
	slot0._dialogIndex = nil
	slot0._historyList = {}
	slot0._dialogId = tonumber(slot0._elementInfo:getParam())
	slot0._historyList.id = slot0._dialogId
	slot0._dialogHistoryList = {}

	slot0:_playSection(slot0._sectionId, slot0._dialogIndex)
end

function slot0._initHistoryItem(slot0)
	if not slot0._elementInfo or not slot0._elementInfo.historylist or #slot1 == 0 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		slot7 = string.split(slot6, "#")
		slot0._historyList[slot7[1]] = tonumber(slot7[2])
	end

	if not slot0._historyList.id or slot2 ~= slot0._dialogId then
		slot0._historyList = {}

		return
	end

	slot0._option_param = slot0._historyList.option
	slot3 = slot0._mainSectionId

	slot0:_addSectionHistory(slot3, slot0._historyList[slot3])

	if not slot0._dialogIndex then
		slot0._dialogIndex = slot4
		slot0._sectionId = slot3
	end
end

function slot0._addSectionHistory(slot0, slot1, slot2)
	slot3 = MeilanniConfig.instance:getDialog(slot0._dialogId, slot1)
	slot4 = nil
	slot4 = slot1 == slot0._mainSectionId and slot2 > #slot3 or slot2 >= #slot3

	for slot8, slot9 in ipairs(slot3) do
		if slot8 < slot2 or slot4 then
			if slot9.type == MeilanniEnum.ResultString.dialog then
				-- Nothing
			end

			if slot9.type == MeilanniEnum.ResultString.options then
				slot10 = string.split(slot9.content, "#")
				slot12 = {}
				slot13 = {}

				for slot17, slot18 in ipairs(string.split(slot9.param, "#")) do
					if MeilanniConfig.instance:getDialog(slot0._dialogId, slot18) and slot19.type == "random" then
						for slot23, slot24 in ipairs(slot19) do
							slot25 = string.split(slot24.option_param, "#")

							table.insert(slot12, slot10[slot17])
							table.insert(slot13, slot25[2])
							table.insert(slot12, slot10[slot17])
							table.insert(slot13, slot25[3])
						end
					elseif slot19 then
						table.insert(slot12, slot10[slot17])
						table.insert(slot13, slot18)
					end
				end

				for slot17, slot18 in ipairs(slot13) do
					if slot0._historyList[slot18] then
						slot0:_addSectionHistory(slot18, slot19)
					end
				end
			end
		else
			break
		end
	end

	if not slot4 then
		if not slot0._dialogIndex then
			slot0._dialogIndex = slot2
			slot0._sectionId = slot1

			return
		end

		table.insert(slot0._sectionStack, 1, {
			slot1,
			slot2
		})
	end
end

function slot0._playSection(slot0, slot1, slot2)
	slot0:_setSectionData(slot1, slot2)
	slot0:_playNextDialog()
end

function slot0._setSectionData(slot0, slot1, slot2)
	slot0._sectionList = MeilanniConfig.instance:getDialog(slot0._dialogId, slot1)

	if slot0._sectionList and not string.nilorempty(slot0._sectionList.option_param) then
		slot0._option_param = slot0._sectionList.option_param
	end

	if not string.nilorempty(slot0._option_param) then
		slot0._historyList.option = slot0._option_param
	end

	slot0._dialogIndex = slot2 or 1
	slot0._sectionId = slot1
end

function slot0._autoPlay(slot0)
	slot0:_playNextSectionOrDialog()
end

function slot0._playNextDialog(slot0)
	if slot0._sectionList[slot0._dialogIndex] and slot1.type == MeilanniEnum.ResultString.dialog then
		slot0:_addDialogHistory(slot1.stepId)
		slot0:_showDialog(MeilanniEnum.ResultString.dialog, slot1.content, slot1.speaker)

		slot0._dialogIndex = slot0._dialogIndex + 1

		if #slot0._sectionStack > 0 and #slot0._sectionList < slot0._dialogIndex then
			slot2 = table.remove(slot0._sectionStack)

			slot0:_setSectionData(slot2[1], slot2[2])
		end

		slot0:_refreshDialogBtnState()
		slot0:_autoPlay()
	elseif slot1 and slot1.type == MeilanniEnum.ResultString.options then
		slot0:_showOptionByConfig(slot1)
	end
end

function slot0._showOptionByConfig(slot0, slot1)
	slot2 = false

	if slot1 and slot1.type == MeilanniEnum.ResultString.options then
		slot0._dialogIndex = slot0._dialogIndex + 1
		slot0._isSingle = slot1.single == 1

		if slot0._isSkip then
			slot0:_refreshDialogBtnState(true)
			slot0:_onOptionClick({
				string.split(slot1.param, "#")[1],
				string.split(slot1.content, "#")[1],
				1
			})

			return
		else
			MeilanniController.instance:dispatchEvent(MeilanniEvent.startShowDialogOptionBtn)

			for slot8, slot9 in pairs(slot0._optionBtnList) do
				gohelper.setActive(slot9[1], false)
			end

			slot5 = #slot3 + 1

			for slot9 = 1, #slot3 do
				slot0:_addDialogOption(slot5, slot9, slot4[slot9], slot3[slot9], slot1.stepId)
			end

			slot0:_addDialogOption(slot5, slot5, -1, luaLang("p_meilannidialogitem_shelve"), slot1.stepId, "bg_xuanzhe")
			TaskDispatcher.runDelay(slot0._setOptionBtnEnabled, slot0, slot5 * MeilanniEnum.optionTime + 1.2)
			MeilanniController.instance:dispatchEvent(MeilanniEvent.dialogChange, slot0)
		end

		slot2 = true
	end

	slot0:_refreshDialogBtnState(slot2)
end

function slot0._setOptionBtnEnabled(slot0)
	for slot4, slot5 in pairs(slot0._optionBtnList) do
		slot5[2].button.enabled = true
	end
end

function slot0._refreshDialogBtnState(slot0, slot1)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.refreshDialogBtnState, slot1)
	gohelper.setActive(slot0._gooptions, slot1)

	if slot1 then
		return
	end

	slot3 = not (#slot0._sectionStack > 0 or slot0._dialogIndex <= #slot0._sectionList)

	if slot0._isFinish then
		slot0:_fadeOutDone()

		slot0._finishClose = true
	end

	slot0._isFinish = slot3
end

function slot0._fadeOutDone(slot0)
	if slot0._config.skipFinish ~= 1 then
		slot0:_sendFinishDialog()
	end

	TaskDispatcher.runDelay(slot0._startBattle, slot0, 1.5)
end

function slot0._startBattle(slot0)
	if slot0._elementInfo:getNextType() == MeilanniEnum.ElementType.Battle then
		MeilanniController.instance:startBattle(slot0._config.id)
	end
end

function slot0._playCloseTalkItemEffect(slot0)
	for slot4, slot5 in pairs(slot0._optionBtnList) do
		slot5[1]:GetComponent(typeof(UnityEngine.Animator)):Play("weekwalk_options_out")
	end

	TaskDispatcher.runDelay(slot0._hideOption, slot0, 0.133)
end

function slot0._hideOption(slot0)
	gohelper.setActive(slot0._gooptions, false)
end

function slot0.startBattle(slot0)
end

function slot0._sendFinishDialog(slot0)
	MeilanniAnimationController.instance:startAnimation()
	slot0:_setDelayShowDialog()
	MeilanniController.instance:dispatchEvent(MeilanniEvent.setElementsVisible, true)
	Activity108Rpc.instance:sendDialogEventSelectRequest(MeilanniEnum.activityId, slot0._config.id, slot0._dialogHistoryList, tonumber(slot0._option_param) or 0)
end

slot1 = "#225D23"

function slot0.getResult(slot0, slot1, slot2, slot3, slot4)
	slot6, slot7 = nil

	if string.splitToNumber(slot1.result, "#")[1] == MeilanniEnum.ResultType.score then
		slot2 = (slot5[2] ~= 0 or formatLuaLang("meilannidialogitem_noscore", slot2)) and string.format("%s  %s", formatLuaLang("meilannidialogitem_noscore", slot2), MeilanniController.getScoreDesc(slot8))
		slot6 = slot8
	elseif slot5[1] == MeilanniEnum.ResultType.feature then
		slot2 = GameUtil.getSubPlaceholderLuaLang(luaLang("meilannidialogitem_eliminat"), {
			slot2,
			slot4 and slot4.featureTxtColor or uv0,
			lua_rule.configDict[tonumber(lua_activity108_rule.configDict[slot5[2]].rules)].name
		})
		slot7 = true
	elseif slot0 and slot0:getConfigBattleId() then
		slot2 = (not slot3 or formatLuaLang("meilannidialogitem_fightsuccess", slot2)) and formatLuaLang("meilannidialogitem_fight", formatLuaLang("meilannidialogitem_fightsuccess", slot2))
	end

	return slot2, slot6, slot7
end

function slot0._setAnimatorEnabled(slot0)
	slot0.enabled = true
end

function slot0._addDialogOption(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.showDialogOptionBtn, {
		{
			slot3,
			slot4,
			slot2,
			slot5,
			slot1,
			slot6
		},
		slot0,
		slot0._onOptionClick
	})
end

function slot0._setDelayShowDialog(slot0)
	slot0._delayStartTime = slot0._delayStartTime or Time.realtimeSinceStartup
	slot0._delayShowDialogList = slot0._delayShowDialogList or {}
end

function slot0._getDelayShowDialogList(slot0)
	return slot0._delayShowDialogList
end

function slot0._onOptionClick(slot0, slot1)
	if not slot0:_checkClickCd() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_fight_choosecard)

	if slot1[1] == -1 then
		gohelper.destroy(slot0.viewGO)
		MeilanniController.instance:dispatchEvent(MeilanniEvent.setElementsVisible, true)
		MeilanniController.instance:dispatchEvent(MeilanniEvent.dialogClose, slot0)

		return
	end

	MeilanniAnimationController.instance:startAnimation()
	slot0:_setDelayShowDialog()
	slot0:_addDialogHistory(slot1[4], slot1[3])
	slot0:_showDialog(MeilanniEnum.ResultString.options, string.format("<color=#B95F0F>\"%s\"</color>", slot1[2]))

	slot0._showOption = true
	slot0._optionId = slot1[3]

	slot0:_checkOption(slot2)
end

function slot0._addDialogHistory(slot0, slot1, slot2)
	if slot2 then
		table.insert(slot0._dialogHistoryList, string.format("%s#%s", slot1, slot2))
	else
		table.insert(slot0._dialogHistoryList, tostring(slot1))
	end
end

function slot0._checkOption(slot0, slot1)
	if not MeilanniConfig.instance:getDialog(slot0._dialogId, slot1) then
		slot0:_playNextSectionOrDialog()

		return
	end

	if slot0._dialogIndex <= #slot0._sectionList then
		table.insert(slot0._sectionStack, {
			slot0._sectionId,
			slot0._dialogIndex
		})
	end

	if slot2.type == "random" then
		for slot6, slot7 in ipairs(slot2) do
			slot8 = string.split(slot7.option_param, "#")
			slot13 = nil

			slot0:_playSection(math.random(100) <= tonumber(slot8[1]) and slot8[2] or slot8[3])

			break
		end
	else
		slot0:_playSection(slot1)
	end
end

function slot0._showDialog(slot0, slot1, slot2, slot3)
	if slot0._isSkip then
		return
	end

	if string.nilorempty(slot2) or slot0._txtList[slot2] then
		return
	end

	if not slot0:_getDelayShowDialogList() then
		slot0:_addDialogItem(slot1, slot2, slot3)

		return
	end

	MeilanniAnimationController.instance:startDialogListAnim()
	table.insert(slot4, {
		slot1,
		slot2,
		slot3,
		slot1 == MeilanniEnum.ResultString.result
	})
	TaskDispatcher.runRepeat(slot0._showDelayDialog, slot0, 0)
end

function slot0._showDelayDialog(slot0)
	if slot0:_getDelayShowDialogList() and #slot1 ~= 0 and slot1[1][4] then
		slot2 = (slot0._customDialogTime or MeilanniEnum.dialogTime) + MeilanniEnum.resultTime
	end

	if slot1 and slot2 <= Time.realtimeSinceStartup - slot0._delayStartTime then
		slot0._delayStartTime = Time.realtimeSinceStartup

		if #slot1 <= 0 then
			TaskDispatcher.cancelTask(slot0._showDelayDialog, slot0)
			MeilanniAnimationController.instance:endDialogListAnim()

			return
		end

		if table.remove(slot1, 1) then
			slot0:_addDialogItem(slot3[1], slot3[2], slot3[3])
		end
	end
end

function slot0._updateHistory(slot0)
	if slot0._isSkip then
		return
	end

	if slot0._config.skipFinish == 1 then
		return
	end

	slot0._historyList[slot0._sectionId] = slot0._dialogIndex

	for slot5, slot6 in pairs(slot0._historyList) do
		table.insert({}, string.format("%s#%s", slot5, slot6))
	end
end

function slot0._addDialogItem(slot0, slot1, slot2, slot3)
	if string.nilorempty(slot2) then
		return
	end

	if string.nilorempty(slot0._content) then
		slot0._content = slot2
		slot0._eventIndexDesc = nil
	else
		slot0._content = string.format("%s\n%s", slot0._content, slot2)
	end

	if not slot0._txtList[slot2] then
		slot4 = gohelper.clone(slot0._txttemplate.gameObject, slot0._curText.transform.parent.gameObject)

		gohelper.setActive(slot4, true)

		slot4:GetComponent(gohelper.Type_TextMesh).text = slot2
		slot6 = slot4:GetComponent(typeof(UnityEngine.Animator))
		slot7 = "fade"

		if slot1 == MeilanniEnum.ResultString.dialog then
			slot9 = slot4:GetComponent(typeof(ZProj.MaterialPropsTMPCtrl)).TMPList

			slot9:Clear()
			slot9:Add(slot5)

			slot7 = "open"
		elseif slot1 == MeilanniEnum.ResultString.result then
			if MeilanniAnimationController.instance:isPlayingDialogListAnim() then
				if slot0._scoreResult and slot0._scoreResult > 0 then
					gohelper.setActive(gohelper.findChild(slot4, "vx/1"), true)
					AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_decrypt_correct)
				elseif slot0._scoreResult and slot0._scoreResult < 0 then
					gohelper.setActive(gohelper.findChild(slot4, "vx/2"), true)
					AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_decrypt_incorrect)
				elseif slot0._scoreResult and slot0._scoreResult == 0 then
					gohelper.setActive(gohelper.findChild(slot4, "vx/4"), true)
					AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_no_effect)
				elseif slot0._featureResult then
					gohelper.setActive(gohelper.findChild(slot4, "vx/3"), true)
					AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_remove_effect)
				end

				slot0._scoreResult = nil
				slot0._featureResult = nil
				slot0._topDialog = false
			end

			if slot0._maskline then
				gohelper.setActive(slot0._maskline, true)
			end
		end

		if slot0._openFadeIn then
			slot7 = "idle"
		end

		slot6:Play(slot7)

		slot0._txtList[slot2] = true
	end

	MeilanniController.instance:dispatchEvent(MeilanniEvent.dialogChange, slot0)
end

function slot0.onClose(slot0)
	for slot4, slot5 in pairs(slot0._optionBtnList) do
		slot5[2]:RemoveClickListener()
		TaskDispatcher.cancelTask(uv0._setAnimatorEnabled, slot5[3])
	end

	if slot0._endBtn then
		slot0._endBtn:RemoveClickListener()

		slot0._endBtn = nil
	end

	TaskDispatcher.cancelTask(slot0._hideOption, slot0)
	TaskDispatcher.cancelTask(slot0._delayFadeIn, slot0)
	TaskDispatcher.cancelTask(slot0._showDelayDialog, slot0)
	TaskDispatcher.cancelTask(slot0._startBattle, slot0)
	TaskDispatcher.cancelTask(slot0._setOptionBtnEnable, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
