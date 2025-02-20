module("modules.logic.weekwalk.view.WeekWalkDialogView", package.seeall)

slot0 = class("WeekWalkDialogView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnnext = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_next")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_content/#simage_bg")
	slot0._txtinfo = gohelper.findChildText(slot0.viewGO, "#go_content/#txt_info")
	slot0._gooptions = gohelper.findChild(slot0.viewGO, "#go_content/#go_options")
	slot0._gotalkitem = gohelper.findChild(slot0.viewGO, "#go_content/#go_options/#go_talkitem")
	slot0._gopcbtn = gohelper.findChild(slot0._gotalkitem, "#go_pcbtn")
	slot0._btnskip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_skip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
	slot0._btnskip:AddClickListener(slot0._btnskipOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogNext, slot0._btnnextOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSkip, slot0._btnskipOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, slot0.OnStoryDialogSelect, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnext:RemoveClickListener()
	slot0._btnskip:RemoveClickListener()
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogNext, slot0._btnnextOnClick, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSkip, slot0._btnskipOnClick, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, slot0.OnStoryDialogSelect, slot0)
end

function slot0._btnskipOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.StorySkipConfirm, MsgBoxEnum.BoxType.Yes_No, function ()
		uv0:_skipStory()
	end)
end

function slot0.OnStoryDialogSelect(slot0, slot1)
	if slot0._optionBtnList[slot1] and slot2[1].gameObject.activeInHierarchy then
		slot2[2]:Trigger()
	end
end

function slot0._skipStory(slot0)
	slot0._isSkip = true

	if slot0._skipOptionParams then
		slot0:_skipOption(slot0._skipOptionParams[1], slot0._skipOptionParams[2])
	end

	for slot4 = 1, 100 do
		slot0:_playNextSectionOrDialog()

		if slot0._finishClose then
			break
		end
	end
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

	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
	slot0._nexticon = gohelper.findChild(slot0.viewGO, "#go_content/nexticon")
	slot0._txtmarktop = IconMgr.instance:getCommonTextMarkTop(slot0._txtinfo.gameObject):GetComponent(gohelper.Type_TextMesh)
	slot0._conMark = gohelper.onceAddComponent(slot0._txtinfo.gameObject, typeof(ZProj.TMPMark))

	slot0._conMark:SetMarkTopGo(slot0._txtmarktop.gameObject)
	slot0._conMark:SetTopOffset(0, -2)
end

function slot0.onOpen(slot0)
	slot0._mapElement = slot0.viewParam

	slot0._mapElement:setWenHaoVisible(false)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnSetEpisodeListVisible, false)

	slot0._config = slot0._mapElement._config
	slot0._elementGo = slot0._mapElement._go
	slot0._elementInfo = slot0._mapElement._info

	slot0:_playStory()
	slot0._simagebg:LoadImage(ResUrl.getWeekWalkBg("bg_wz.png"))
	gohelper.setActive(slot0._btnskip.gameObject, WeekWalkModel.instance:getCurMapInfo():storyIsFinished(slot0._dialogId))
	NavigateMgr.instance:addSpace(ViewName.WeekWalkDialogView, slot0._onSpace, slot0)
end

function slot0._onSpace(slot0)
	if not slot0._btnnext.gameObject.activeInHierarchy then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_commonchoose)
	slot0:_btnnextOnClick()
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

function slot0._playStory(slot0, slot1)
	slot0._sectionStack = {}
	slot0._optionId = 0
	slot0._mainSectionId = "0"
	slot0._sectionId = slot0._mainSectionId
	slot0._dialogIndex = nil
	slot0._historyList = {}
	slot0._dialogId = slot1 or tonumber(slot0._elementInfo:getParam())

	slot0:_initHistoryItem()

	slot0._historyList.id = slot0._dialogId

	slot0:_playSection(slot0._sectionId, slot0._dialogIndex)
end

function slot0._initHistoryItem(slot0)
	if #slot0._elementInfo.historylist == 0 then
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
	slot3 = WeekWalkConfig.instance:getDialog(slot0._dialogId, slot1)
	slot4 = nil
	slot4 = slot1 == slot0._mainSectionId and slot2 > #slot3 or slot2 >= #slot3

	for slot8, slot9 in ipairs(slot3) do
		if slot8 < slot2 or slot4 then
			if slot9.type == "dialog" then
				-- Nothing
			end

			if slot9.type == "options" then
				slot10 = string.split(slot9.content, "#")
				slot12 = {}
				slot13 = {}

				for slot17, slot18 in ipairs(string.split(slot9.param, "#")) do
					if WeekWalkConfig.instance:getDialog(slot0._dialogId, slot18) and slot19.type == "random" then
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
	slot0._sectionList = WeekWalkConfig.instance:getDialog(slot0._dialogId, slot1)

	if slot0._sectionList and not string.nilorempty(slot0._sectionList.option_param) then
		slot0._option_param = slot0._sectionList.option_param
	end

	if not string.nilorempty(slot0._option_param) then
		slot0._historyList.option = slot0._option_param
	end

	slot0._dialogIndex = slot2 or 1
	slot0._sectionId = slot1
end

function slot0._playNextDialog(slot0)
	if slot0._sectionList[slot0._dialogIndex] and slot1.type == "dialog" then
		slot0:_showDialog("dialog", slot1.content, slot1.speaker)

		slot0._dialogIndex = slot0._dialogIndex + 1

		if #slot0._sectionStack > 0 and #slot0._sectionList < slot0._dialogIndex then
			slot2 = table.remove(slot0._sectionStack)

			slot0:_setSectionData(slot2[1], slot2[2])
		end

		slot0:_refreshDialogBtnState()
	elseif slot1 and slot1.type == "options" then
		slot0:_showOptionByConfig(slot1)
	end
end

function slot0._showOptionByConfig(slot0, slot1)
	slot2 = false

	if slot1 and slot1.type == "options" then
		slot0:_updateHistory()

		slot0._dialogIndex = slot0._dialogIndex + 1
		slot0._isSingle = slot1.single == 1

		if slot0._isSkip then
			slot0:_refreshDialogBtnState(true)
			slot0:_skipOption(string.split(slot1.content, "#"), string.split(slot1.param, "#"))

			return
		else
			slot0._skipOptionParams = {
				slot3,
				slot4
			}

			for slot8, slot9 in pairs(slot0._optionBtnList) do
				gohelper.setActive(slot9[1], false)
			end

			for slot8, slot9 in ipairs(slot3) do
				slot0:_addDialogOption(slot8, slot4[slot8], slot3[slot8], #slot3)
			end

			gohelper.setActive(slot0._nexticon, false)
		end

		for slot8, slot9 in ipairs(slot0._optionBtnList) do
			PCInputController.instance:showkeyTips(gohelper.findChild(slot9[1], "#go_pcbtn"), nil, , "Alpha" .. slot8)
		end

		slot2 = true
	end

	slot0:_refreshDialogBtnState(slot2)
end

function slot0._skipOption(slot0, slot1, slot2)
	slot3 = 1

	if WeekWalkModel.instance:getCurMapId() >= 201 and slot4 <= 205 then
		slot3 = #slot1
	end

	slot0:_onOptionClick({
		slot2[slot3],
		slot1[slot3],
		slot3
	})
end

function slot0._refreshDialogBtnState(slot0, slot1)
	if slot1 then
		gohelper.setActive(slot0._gooptions, true)
	else
		slot0:_playCloseTalkItemEffect()
	end

	gohelper.setActive(slot0._txtinfo, not slot1)
	gohelper.setActive(slot0._btnnext, not slot1)

	if slot1 then
		return
	end

	slot3 = not (#slot0._sectionStack > 0 or slot0._dialogIndex <= #slot0._sectionList)

	if slot0._isFinish then
		SLFramework.AnimatorPlayer.Get(slot0.viewGO):Play(UIAnimationName.Close, slot0._fadeOutDone, slot0)

		slot0._finishClose = true
	end

	slot0._isFinish = slot3
end

function slot0._fadeOutDone(slot0)
	if slot0._config.skipFinish ~= 1 then
		slot0:_sendFinishDialog()
	end

	if slot0._elementInfo:getNextType() == WeekWalkEnum.ElementType.Battle then
		uv0.startBattle(slot0._elementInfo.elementId)
	end

	slot0:closeThis()
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
	WeekWalkModel.instance:setBattleElementId(slot0)

	if WeekWalkModel.instance:infoNeedUpdate() then
		return
	end

	WeekwalkRpc.instance:sendBeforeStartWeekwalkBattleRequest(slot0)
end

function slot0._sendFinishDialog(slot0)
	if WeekWalkModel.instance:infoNeedUpdate() then
		return
	end

	slot1 = tonumber(slot0._option_param) or 0

	if WeekWalkConfig.instance:getOptionParamList(slot0._dialogId) and #slot2 > 0 then
		slot3 = 1

		if WeekWalkModel.instance:getCurMapId() >= 201 and slot4 <= 205 then
			slot3 = 2
		end

		if slot1 ~= slot3 then
			slot1 = slot3
		end
	end

	WeekwalkRpc.instance:sendWeekwalkDialogRequest(slot0._config.id, slot1)
end

function slot0._addDialogOption(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot0._optionBtnList[slot1] and slot0._optionBtnList[slot1][1] or gohelper.cloneInPlace(slot0._gotalkitem)

	slot5.gameObject.transform:SetSiblingIndex(slot4 - slot1)
	gohelper.setActive(slot5, true)

	gohelper.findChildText(slot5, "txt_talkitem").text = slot3

	gohelper.findChildButtonWithAudio(slot5, "btn_talkitem", AudioEnum.WeekWalk.play_artificial_ui_talkchoose):AddClickListener(slot0._onOptionClick, slot0, {
		slot2,
		slot3,
		slot1
	})

	if not slot0._optionBtnList[slot1] then
		slot0._optionBtnList[slot1] = {
			slot5,
			slot7
		}
	end

	if not slot0._isSingle then
		return
	end

	if slot1 == 1 then
		slot10 = WeekWalkModel.instance:getCurMapConfig().type ~= 1

		gohelper.setActive(gohelper.findChild(slot5, "mask"), slot10)
		gohelper.setActive(gohelper.findChild(slot5, "chaticon"), not slot10)
		gohelper.setActive(slot7.gameObject, not slot10)
	end

	if slot1 == 2 then
		gohelper.setActive(slot5, slot8.type ~= 1)
	end
end

function slot0._onOptionClick(slot0, slot1)
	slot0._skipOptionParams = nil

	if not slot0:_checkClickCd() then
		return
	end

	slot0:_showDialog("option", string.format("<indent=4.7em><color=#C66030>\"%s\"</color>", slot1[2]))

	slot0._showOption = true
	slot0._optionId = slot1[3]

	slot0:_checkOption(slot1[1])
end

function slot0._checkOption(slot0, slot1)
	if not WeekWalkConfig.instance:getDialog(slot0._dialogId, slot1) then
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
	slot0:_updateHistory()

	if slot0._isSkip then
		return
	end

	slot4 = slot0:_addDialogItem(slot1, slot2, slot3)
end

function slot0._updateHistory(slot0)
	if slot0._isSkip then
		return
	end

	if slot0._config.skipFinish == 1 then
		return
	end

	slot0._historyList[slot0._sectionId] = slot0._dialogIndex
	slot1 = {}

	for slot5, slot6 in pairs(slot0._historyList) do
		table.insert(slot1, string.format("%s#%s", slot5, slot6))
	end

	slot0._elementInfo:updateHistoryList(slot1)

	if WeekWalkModel.instance:infoNeedUpdate() then
		return
	end

	WeekwalkRpc.instance:sendWeekwalkDialogHistoryRequest(slot0._config.id, slot1)
end

function slot0._addDialogItem(slot0, slot1, slot2, slot3)
	slot5 = (not string.nilorempty(slot3) and "<#FAFAFA>" .. slot3 .. ":  " or "") .. slot2
	slot6 = StoryTool.getMarkTopTextList(slot5)
	slot0._txtinfo.text = StoryTool.filterMarkTop(slot5)

	TaskDispatcher.runDelay(function ()
		uv0._conMark:SetMarksTop(uv1)
	end, nil, 0.01)
	slot0._animatorPlayer:Play(UIAnimationName.Click, slot0._animDone, slot0)
	gohelper.setActive(slot0._nexticon, true)
end

function slot0._animDone(slot0)
end

function slot0.onClose(slot0)
	for slot4, slot5 in pairs(slot0._optionBtnList) do
		slot5[2]:RemoveClickListener()
	end

	slot0._mapElement:setWenHaoVisible(true)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnSetEpisodeListVisible, true)
	TaskDispatcher.cancelTask(slot0._hideOption, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
