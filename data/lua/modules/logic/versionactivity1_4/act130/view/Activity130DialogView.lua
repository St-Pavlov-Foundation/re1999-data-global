module("modules.logic.versionactivity1_4.act130.view.Activity130DialogView", package.seeall)

slot0 = class("Activity130DialogView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnnext = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_next")
	slot0._gotopcontent = gohelper.findChild(slot0.viewGO, "#go_topcontent")
	slot0._godialoghead = gohelper.findChild(slot0.viewGO, "#go_topcontent/#go_dialoghead")
	slot0._simagehead = gohelper.findChildSingleImage(slot0.viewGO, "#go_topcontent/#go_dialoghead/#image_headicon")
	slot0._txtdialogdesc = gohelper.findChildText(slot0.viewGO, "#go_topcontent/#txt_dialogdesc")
	slot0._gobottomcontent = gohelper.findChild(slot0.viewGO, "#go_bottomcontent")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_bottomcontent/#go_content")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_bottomcontent/#go_content/#simage_bg")
	slot0._txtinfo = gohelper.findChildText(slot0.viewGO, "#go_bottomcontent/#go_content/#txt_info")
	slot0._gooptions = gohelper.findChild(slot0.viewGO, "#go_bottomcontent/#go_content/#go_options")
	slot0._gotalkitem = gohelper.findChild(slot0.viewGO, "#go_bottomcontent/#go_content/#go_options/#go_talkitem")
	slot0._btnskip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_bottomcontent/#btn_skip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
	slot0._btnskip:AddClickListener(slot0._btnskipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnext:RemoveClickListener()
	slot0._btnskip:RemoveClickListener()
end

function slot0._btnskipOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.StorySkipConfirm, MsgBoxEnum.BoxType.Yes_No, function ()
		uv0:_skipStory()
	end)
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

	if slot0.viewParam.isClient then
		if #string.split(slot0.viewParam.dialogParam, "#") < slot0._clientDialogIndex then
			slot0:closeThis()
		end

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
	slot0._txtmarktop = IconMgr.instance:getCommonTextMarkTop(slot0._txtdialogdesc.gameObject):GetComponent(gohelper.Type_TextMesh)
	slot0._conMark = gohelper.onceAddComponent(slot0._txtdialogdesc.gameObject, typeof(ZProj.TMPMark))

	slot0._conMark:SetMarkTopGo(slot0._txtmarktop.gameObject)
	slot0._conMark:SetTopOffset(0, -7.3257)
end

function slot0.onOpen(slot0)
	slot0._simagebg:LoadImage(ResUrl.getWeekWalkBg("bg_wz.png"))
	NavigateMgr.instance:addSpace(ViewName.Activity130DialogView, slot0._onSpace, slot0)

	if slot0.viewParam.isClient then
		slot0._clientDialogIndex = 1
		slot0.viewContainer:getSetting().viewType = ViewType.Normal

		slot0:_showClientTalk()
	else
		slot0._elementInfo = slot0.viewParam.elementInfo
		slot0.viewContainer:getSetting().viewType = ViewType.Full

		slot0:_playStory()
	end
end

function slot0._showClientTalk(slot0)
	gohelper.setActive(slot0._gobottomcontent, false)
	gohelper.setActive(slot0._gotopcontent, true)

	slot1 = VersionActivity1_4Enum.ActivityId.Role37
	slot3 = string.splitToNumber(string.split(slot0.viewParam.dialogParam, "#")[slot0._clientDialogIndex], "_")
	slot4 = Activity130Config.instance:getActivity130DialogCo(slot3[1], slot3[2])
	slot0._clientDialogIndex = slot0._clientDialogIndex + 1
	slot0._txtdialogdesc.text = slot4.content

	slot0._simagehead:LoadImage(string.format("singlebg/headicon_small/%s.png", string.splitToNumber(slot4.param, "#")[1]))

	if slot0._audioId and slot0._audioId > 0 then
		AudioEffectMgr.instance:stopAudio(slot0._audioId, 0)
	end

	slot0._audioId = slot5[2]

	AudioEffectMgr.instance:playAudio(slot0._audioId)
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
	slot3 = Activity130Config.instance:getDialog(slot0._dialogId, slot1)
	slot4 = nil
	slot4 = slot1 == slot0._mainSectionId and slot2 > #slot3 or slot2 >= #slot3

	for slot8, slot9 in ipairs(slot3) do
		if slot8 < slot2 or slot4 then
			if slot9.type == Activity130Enum.dialogType.options then
				slot10 = string.split(slot9.content, "#")
				slot12 = {}
				slot13 = {}

				for slot17, slot18 in ipairs(string.split(slot9.param, "#")) do
					if Activity130Config.instance:getDialog(slot0._dialogId, slot18) and slot19.type == "random" then
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
	slot0._sectionList = Activity130Config.instance:getDialog(slot0._dialogId, slot1)

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
	if not slot0._sectionList[slot0._dialogIndex] then
		return
	end

	if slot1.type == Activity130Enum.dialogType.dialog then
		slot0:_showDialog(Activity130Enum.dialogType.dialog, slot1.content, slot1.speaker)

		slot0._dialogIndex = slot0._dialogIndex + 1

		if #slot0._sectionStack > 0 and #slot0._sectionList < slot0._dialogIndex then
			slot2 = table.remove(slot0._sectionStack)

			slot0:_setSectionData(slot2[1], slot2[2])
		end

		slot0:_refreshDialogBtnState()
	elseif slot1.type == Activity130Enum.dialogType.option then
		slot0:_showOptionByConfig(slot1)
	elseif slot1.type == Activity130Enum.dialogType.talk then
		slot0:_showTalk(Activity130Enum.dialogType.talk, slot1)

		slot0._dialogIndex = slot0._dialogIndex + 1

		if #slot0._sectionStack > 0 and #slot0._sectionList < slot0._dialogIndex then
			slot2 = table.remove(slot0._sectionStack)

			slot0:_setSectionData(slot2[1], slot2[2])
		end

		slot0:_refreshDialogBtnState()
	end
end

function slot0._showDialog(slot0, slot1, slot2, slot3)
	if slot0._audioId and slot0._audioId > 0 then
		AudioEffectMgr.instance:stopAudio(slot0._audioId, 0)
	end

	gohelper.setActive(slot0._gobottomcontent, true)
	gohelper.setActive(slot0._gotopcontent, false)
	slot0:_updateHistory()

	if slot0._isSkip then
		return
	end

	slot4 = slot0:_addDialogItem(slot1, slot2, slot3)
end

function slot0._showTalk(slot0, slot1, slot2)
	gohelper.setActive(slot0._gobottomcontent, false)
	gohelper.setActive(slot0._gotopcontent, true)
	slot0:_updateHistory()

	slot0._isSkip = false
	slot0._txtdialogdesc.text = slot0:_getDialogDesc(slot2.content)

	slot0._simagehead:LoadImage(string.format("singlebg/headicon_small/%s.png", string.splitToNumber(slot2.param, "#")[1]))

	if slot0._audioId and slot0._audioId > 0 then
		AudioEffectMgr.instance:stopAudio(slot0._audioId, 0)
	end

	slot0._audioId = slot3[2]

	if slot0._audioId > 0 then
		AudioEffectMgr.instance:playAudio(slot0._audioId)
	end
end

function slot0._showOptionByConfig(slot0, slot1)
	slot2 = false

	if slot1 and slot1.type == Activity130Enum.dialogType.option then
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

			for slot8 = #slot3, 1, -1 do
				slot0:_addDialogOption(slot8, slot4[slot8], slot3[slot8])
			end

			gohelper.setActive(slot0._nexticon, false)
		end

		slot2 = true
	end

	slot0:_refreshDialogBtnState(slot2)
end

function slot0._skipOption(slot0, slot1, slot2)
	slot3 = 1

	if Activity130Model.instance:getCurMapId() >= 201 and slot4 <= 205 then
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
	if slot0._elementInfo.config.skipFinish ~= 1 then
		slot0:_sendFinishDialog()
	end

	if slot0._elementInfo:getNextType() == Activity130Enum.ElementType.Battle then
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
end

function slot0._sendFinishDialog(slot0)
	slot1 = tonumber(slot0._option_param) or 0

	if Activity130Config.instance:getOptionParamList(slot0._dialogId) and #slot2 > 0 then
		slot3 = 1

		if Activity130Model.instance:getCurMapId() >= 201 and slot4 <= 205 then
			slot3 = 2
		end

		if slot1 ~= slot3 then
			slot1 = slot3
		end
	end

	Activity130Rpc.instance:sendAct130DialogRequest(VersionActivity1_4Enum.ActivityId.Role37, Activity130Model.instance:getCurEpisodeId(), slot0._elementInfo.elementId, slot1)
end

function slot0._addDialogOption(slot0, slot1, slot2, slot3)
	slot4 = slot0._optionBtnList[slot1] and slot0._optionBtnList[slot1][1] or gohelper.cloneInPlace(slot0._gotalkitem)

	gohelper.setActive(slot4, true)

	gohelper.findChildText(slot4, "txt_talkitem").text = slot3

	gohelper.findChildButtonWithAudio(slot4, "btn_talkitem", AudioEnum.WeekWalk.play_artificial_ui_talkchoose):AddClickListener(slot0._onOptionClick, slot0, {
		slot2,
		slot3,
		slot1
	})

	if not slot0._optionBtnList[slot1] then
		slot0._optionBtnList[slot1] = {
			slot4,
			slot6
		}
	end

	if not slot0._isSingle then
		return
	end

	if slot1 == 1 then
		slot9 = Activity130Model.instance:getCurMapConfig().type ~= 1

		gohelper.setActive(gohelper.findChild(slot4, "mask"), slot9)
		gohelper.setActive(gohelper.findChild(slot4, "chaticon"), not slot9)
		gohelper.setActive(slot6.gameObject, not slot9)
	end

	if slot1 == 2 then
		gohelper.setActive(slot4, slot7.type ~= 1)
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
	if not Activity130Config.instance:getDialog(slot0._dialogId, slot1) then
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

function slot0._updateHistory(slot0)
	if slot0._isSkip then
		return
	end

	if slot0._elementInfo.config.skipFinish == 1 then
		return
	end

	slot0._historyList[slot0._sectionId] = slot0._dialogIndex
	slot1 = {}

	for slot5, slot6 in pairs(slot0._historyList) do
		table.insert(slot1, string.format("%s#%s", slot5, slot6))
	end

	slot0._elementInfo:updateHistoryList(slot1)
	Activity130Rpc.instance:sendAct130DialogHistoryRequest(VersionActivity1_4Enum.ActivityId.Role37, Activity130Model.instance:getCurEpisodeId(), slot0._elementInfo.elementId, slot1)
end

function slot0._addDialogItem(slot0, slot1, slot2, slot3)
	slot0._txtinfo.text = (not string.nilorempty(slot3) and "<#FAFAFA>" .. slot3 .. ":  " or "") .. slot2

	slot0._animatorPlayer:Play(UIAnimationName.Click, slot0._animDone, slot0)
	gohelper.setActive(slot0._nexticon, true)
end

function slot0._animDone(slot0)
end

function slot0.onClose(slot0)
	for slot4, slot5 in pairs(slot0._optionBtnList) do
		slot5[2]:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(slot0._hideOption, slot0)
	FrameTimerController.instance:unregister(slot0._fTimer)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

function slot0._getDialogDesc(slot0, slot1)
	slot2 = StoryTool.getMarkTopTextList(slot1)
	slot0._fTimer = FrameTimerController.instance:register(function ()
		if uv0._txtmarktop and not gohelper.isNil(uv0._txtmarktop.gameObject) then
			uv0._conMark:SetMarksTop(uv1)
		end
	end, nil, 1)

	slot0._fTimer:Start()

	return StoryTool.filterMarkTop(slot1)
end

return slot0
