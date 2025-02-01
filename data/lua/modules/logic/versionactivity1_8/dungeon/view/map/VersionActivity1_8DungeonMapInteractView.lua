module("modules.logic.versionactivity1_8.dungeon.view.map.VersionActivity1_8DungeonMapInteractView", package.seeall)

slot0 = class("VersionActivity1_8DungeonMapInteractView", BaseView)

function slot0.onInitView(slot0)
	slot0._gointeractiveroot = gohelper.findChild(slot0.viewGO, "#go_interactive_root")
	slot0.rootClick = gohelper.findChildClickWithDefaultAudio(slot0._gointeractiveroot, "close_block")
	slot0._gointeractitem = gohelper.findChild(slot0.viewGO, "#go_interactive_root/#go_interactitem")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_interactive_root/#go_interactitem/#btn_close")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/#go_title/#txt_title")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_scrollview/viewport/#txt_desc")
	slot0._godesc = slot0._txtdesc.gameObject
	slot0._gochat = gohelper.findChild(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat")
	slot0._gochatusericon = gohelper.findChild(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat/#go_scrollview/viewport/content/usericon")
	slot0._txtchatname = gohelper.findChildText(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat/#go_scrollview/viewport/content/name")
	slot0._txtchatdesc = gohelper.findChildText(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat/#go_scrollview/viewport/content/info")
	slot0._gorewardcontainer = gohelper.findChild(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/reward_container")
	slot0._gorewardContent = gohelper.findChild(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/reward_container/#go_rewardContent")
	slot0._goactivityrewarditem = gohelper.findChild(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/reward_container/#go_rewardContent/#go_activityrewarditem")
	slot0._gonone = gohelper.findChild(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_none")
	slot0._btnnone = gohelper.findButtonWithAudio(slot0._gonone)
	slot0._txtnone = gohelper.findChildText(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_none/#txt_none")
	slot0._gofight = gohelper.findChild(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_fight")
	slot0._btnfight = gohelper.findButtonWithAudio(slot0._gofight)
	slot0._txtfight = gohelper.findChildText(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_fight/#txt_fight")
	slot0._txtfighten = gohelper.findChildText(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_fight/en")
	slot0._godispatch = gohelper.findChild(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dispatch")
	slot0._btndispatch = gohelper.findButtonWithAudio(slot0._godispatch)
	slot0._txtdispatch = gohelper.findChildText(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dispatch/#txt_dispatch")
	slot0._txtdispatchen = gohelper.findChildText(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dispatch/en")
	slot0._godialogue = gohelper.findChild(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dialogue")
	slot0._gonext = gohelper.findChild(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dialogue/#go_next")
	slot0._btnnext = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dialogue/#go_next/#btn_next")
	slot0._gooptions = gohelper.findChild(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dialogue/#go_options")
	slot0._gotalkitem = gohelper.findChild(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dialogue/#go_options/#go_talkitem")

	gohelper.setActive(slot0._gotalkitem, false)

	slot0._gofinishtalk = gohelper.findChild(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dialogue/#go_finishtalk")
	slot0._btnfinishtalk = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dialogue/#go_finishtalk/#btn_finishtalk")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0.rootClick:AddClickListener(slot0.onClickRoot, slot0)
	slot0._btnclose:AddClickListener(slot0.onClickRoot, slot0)
	slot0._btnnone:AddClickListener(slot0._onClickNoneBtn, slot0)
	slot0._btnfight:AddClickListener(slot0._onClickFightBtn, slot0)
	slot0._btndispatch:AddClickListener(slot0._onClickDispatchBtn, slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
	slot0._btnfinishtalk:AddClickListener(slot0._btnfinishtalkOnClick, slot0)
	slot0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, slot0.onClickRoot, slot0)
	slot0:addEventCb(DialogueController.instance, DialogueEvent.OnDialogueInfoChange, slot0.onDialogueInfoChange, slot0)
	slot0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, slot0.showInteractUI, slot0)
	slot0:addEventCb(DispatchController.instance, DispatchEvent.AddDispatchInfo, slot0.onDispatchInfoChange, slot0)
	slot0:addEventCb(DispatchController.instance, DispatchEvent.RemoveDispatchInfo, slot0.onDispatchInfoChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0.rootClick:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._btnnone:RemoveClickListener()
	slot0._btnfight:RemoveClickListener()
	slot0._btndispatch:RemoveClickListener()
	slot0._btnnext:RemoveClickListener()
	slot0._btnfinishtalk:RemoveClickListener()

	for slot4, slot5 in pairs(slot0._optionBtnList) do
		slot5[2]:RemoveClickListener()
	end

	slot0:removeEventCb(JumpController.instance, JumpEvent.BeforeJump, slot0.onClickRoot, slot0)
	slot0:removeEventCb(DialogueController.instance, DialogueEvent.OnDialogueInfoChange, slot0.onDialogueInfoChange, slot0)
	slot0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, slot0.showInteractUI, slot0)
	slot0:removeEventCb(DispatchController.instance, DispatchEvent.AddDispatchInfo, slot0.onDispatchInfoChange, slot0)
	slot0:removeEventCb(DispatchController.instance, DispatchEvent.RemoveDispatchInfo, slot0.onDispatchInfoChange, slot0)
end

function slot0.onClickRoot(slot0)
	slot0:hide()
end

function slot0._onClickNoneBtn(slot0)
	slot0:hide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
	slot0:finishElement()
end

function slot0._onClickFightBtn(slot0)
	slot0:hide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)

	if slot0.isFinish then
		slot0:finishElement()

		return
	end

	slot1 = tonumber(slot0._config.param)
	DungeonModel.instance.curLookEpisodeId = slot1

	if not DungeonConfig.instance:getEpisodeCO(slot1) then
		logError("episode config not exist , episodeId : " .. tostring(slot1))

		return
	end

	VersionActivity1_8DungeonModel.instance:setLastEpisodeId(slot0.activityDungeonMo.episodeId)
	DungeonFightController.instance:enterFight(slot2.chapterId, slot1)
end

function slot0._onClickDispatchBtn(slot0)
	if slot0.isFinish then
		slot0:hide()
		slot0:finishElement()
	else
		DispatchController.instance:openDispatchView(VersionActivity1_8Enum.ActivityId.Dungeon, slot0._config.id, tonumber(slot0._config.param))
	end
end

function slot0.finishElement(slot0, slot1)
	if Activity157Config.instance:getMissionIdByElementId(Activity157Model.instance:getActId(), slot0._config.id) and Activity157Config.instance:getAct157MissionStoryId(slot3, slot4) and slot5 ~= 0 then
		StoryController.instance:playStory(slot5, nil, function ()
			VersionActivity1_8DungeonModel.instance:setIsNotShowNewElement(true)
			uv0:requestsFinishElement(uv1, uv2)
		end)
	else
		slot0:requestsFinishElement(slot2, slot1)
	end
end

function slot0.requestsFinishElement(slot0, slot1, slot2)
	DungeonRpc.instance:sendMapElementRequest(slot1, slot2, slot0.updateAct157Info, slot0)
end

function slot0.updateAct157Info(slot0)
	Activity157Controller.instance:getAct157ActInfo()
end

function slot0._btnnextOnClick(slot0)
	slot0:_playNextSectionOrDialog()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._playNextSectionOrDialog(slot0)
	if slot0._dialogIndex <= #slot0._sectionList then
		slot0:_playNextDialog()

		return
	end

	if not table.remove(slot0._sectionStack) then
		return
	end

	slot0:_playSection(slot1[1], slot1[2])
end

function slot0._btnfinishtalkOnClick(slot0)
	slot0:hide()
	slot0:finishElement(DungeonMapModel.instance:getDialogId())
	DungeonMapModel.instance:clearDialogId()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0.onDialogueInfoChange(slot0, slot1)
	if slot1 == slot0.dialogueId then
		slot0:refreshDialogueUI()
	end
end

function slot0.showInteractUI(slot0, slot1)
	if slot0._show then
		return
	end

	DungeonMapModel.instance:clearDialog()
	VersionActivity1_8DungeonModel.instance:setShowInteractView(true)

	slot0._mapElement = slot0.mapSceneElementsView:getElementComp(slot1)
	slot0._config = slot0._mapElement._config
	slot0._elementGo = slot0._mapElement._go
	slot0.isFinish = false

	slot0:show()
	slot0:refreshUI()
end

function slot0.onDispatchInfoChange(slot0, slot1)
	slot0:refreshDispatchUI()
end

function slot0._editableInitView(slot0)
	slot0.rewardItemList = {}
	slot0._optionBtnList = slot0:getUserDataTb_()
	slot0.mapSceneElementsView = slot0.viewContainer.mapSceneElements
	slot0.type2RefreshFunc = {
		[DungeonEnum.ElementType.None] = slot0.refreshNoneUI,
		[DungeonEnum.ElementType.Fight] = slot0.refreshFightUI,
		[DungeonEnum.ElementType.Story] = slot0.refreshDialogueUI,
		[DungeonEnum.ElementType.Dispatch] = slot0.refreshDispatchUI
	}
	slot0.type2GoDict = {
		[DungeonEnum.ElementType.None] = slot0._gonone,
		[DungeonEnum.ElementType.Fight] = slot0._gofight,
		[DungeonEnum.ElementType.Story] = slot0._godialogue,
		[DungeonEnum.ElementType.Dispatch] = slot0._godispatch
	}

	gohelper.setActive(slot0._gointeractitem, false)
	gohelper.setActive(slot0._gointeractiveroot, false)
	gohelper.setActive(slot0._goactivityrewarditem, false)
	TaskDispatcher.runRepeat(slot0.everySecondCall, slot0, 1)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.refreshUI(slot0)
	for slot4, slot5 in pairs(slot0.type2GoDict) do
		gohelper.setActive(slot5, slot4 == slot0._config.type)
	end

	slot0._txttitle.text = slot0._config.title

	if slot0.type2RefreshFunc[slot0._config.type] then
		slot1(slot0)
	else
		logError("element type undefined!")
	end

	slot0:refreshRewards()
end

function slot0.setIsChat(slot0, slot1)
	gohelper.setActive(slot0._godesc, not slot1)
	gohelper.setActive(slot0._gochat, slot1)
end

function slot0.refreshNoneUI(slot0)
	slot0._txtnone.text = slot0._config.acceptText
	slot0._txtdesc.text = slot0._config.desc

	slot0:setIsChat(false)
end

function slot0.refreshFightUI(slot0)
	slot0.isFinish = DungeonModel.instance:hasPassLevel(tonumber(slot0._config.param))

	if slot0.isFinish then
		slot0:setFinishText()

		slot0._txtfight.text = luaLang("p_dungeonmapinteractiveitem_win")
		slot0._txtfighten.text = luaLang("fixed_en_finish")
	else
		slot0._txtfight.text = slot0._config.acceptText
		slot0._txtdesc.text = slot0._config.desc
	end

	slot0:setIsChat(false)
end

function slot0.refreshDialogueUI(slot0)
	slot0._sectionStack = {}
	slot0._dialogId = tonumber(slot0._config.param)

	slot0:_playSection(0)
end

function slot0._playSection(slot0, slot1, slot2)
	slot0:_setSectionData(slot1, slot2)
	slot0:_playNextDialog()
end

function slot0._setSectionData(slot0, slot1, slot2)
	slot0._sectionList = DungeonConfig.instance:getDialog(slot0._dialogId, slot1)
	slot0._dialogIndex = slot2 or 1
	slot0._sectionId = slot1
end

function slot0._playNextDialog(slot0)
	slot0._dialogIndex = slot0._dialogIndex + 1

	if slot0._sectionList[slot0._dialogIndex].type == "dialog" then
		slot0:_showDialog("dialog", slot1.content, slot1.speaker, slot1.audio)
	end

	if #slot0._sectionStack > 0 and #slot0._sectionList < slot0._dialogIndex then
		slot2 = table.remove(slot0._sectionStack)

		slot0:_setSectionData(slot2[1], slot2[2])
	end

	slot2 = false

	if slot0._sectionList[slot0._dialogIndex] and slot3.type == "options" then
		slot0._dialogIndex = slot0._dialogIndex + 1

		for slot7, slot8 in pairs(slot0._optionBtnList) do
			gohelper.setActive(slot8[1], false)
		end

		for slot9, slot10 in ipairs(string.split(slot3.content, "#")) do
			slot0:_addDialogOption(slot9, string.split(slot3.param, "#")[slot9], slot10)
		end

		slot2 = true
	end

	slot0:_refreshDialogBtnState(slot2, not slot3 or slot3.type ~= "dialogend")
end

function slot0._showDialog(slot0, slot1, slot2, slot3, slot4)
	DungeonMapModel.instance:addDialog(slot1, slot2, slot3, slot4)
	gohelper.setActive(slot0._gochatusericon, not slot3)

	slot0._txtchatname.text = not string.nilorempty(slot3) and slot3 .. ":" or ""
	slot0._txtchatdesc.text = slot2

	slot0:setIsChat(true)
end

function slot0._addDialogOption(slot0, slot1, slot2, slot3)
	slot4 = slot0._optionBtnList[slot1] and slot0._optionBtnList[slot1][1] or gohelper.cloneInPlace(slot0._gotalkitem)

	gohelper.setActive(slot4, true)

	gohelper.findChildText(slot4, "txt_talkitem").text = slot3

	gohelper.findChildButtonWithAudio(slot4, "btn_talkitem"):AddClickListener(slot0._onOptionClick, slot0, {
		slot2,
		slot3
	})

	if not slot0._optionBtnList[slot1] then
		slot7 = slot0:getUserDataTb_()
		slot7[1] = slot4
		slot7[2] = slot6
		slot0._optionBtnList[slot1] = slot7
	end
end

function slot0._onOptionClick(slot0, slot1)
	slot2 = slot1[1]

	slot0:_showDialog("option", string.format("<color=#c95318>\"%s\"</color>", slot1[2]))

	if slot0._dialogIndex <= #slot0._sectionList then
		table.insert(slot0._sectionStack, {
			slot0._sectionId,
			slot0._dialogIndex
		})
	end

	DungeonMapModel.instance:addDialogId(slot2)
	slot0:_playSection(slot2)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._refreshDialogBtnState(slot0, slot1, slot2)
	gohelper.setActive(slot0._gooptions, slot1)

	if slot1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)
		gohelper.setActive(slot0._gonext, false)
		gohelper.setActive(slot0._gofinishtalk, false)

		slot0._curBtnGo = slot0._gooptions

		return
	end

	if slot2 and (#slot0._sectionStack > 0 or slot0._dialogIndex <= #slot0._sectionList) then
		slot0._curBtnGo = slot0._gonext

		gohelper.setActive(slot0._gonext, slot2)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continueappear)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)

		slot0._curBtnGo = slot0._gofinishtalk
	end

	gohelper.setActive(slot0._gonext, slot2)
	gohelper.setActive(slot0._gofinishtalk, not slot2)
end

function slot0.refreshDispatchUI(slot0)
	slot0.isFinish = DispatchModel.instance:getDispatchMo(slot0._config.id, tonumber(slot0._config.param)) and slot3:isFinish()

	if slot0.isFinish then
		slot0._txtdispatch.text = luaLang("p_dungeonmapinteractiveitem_finishtask")
		slot0._txtdispatchen.text = luaLang("fixed_en_finish")

		slot0:setFinishText()
	else
		slot0._txtdesc.text = slot0._config.desc

		if slot3 and slot3:isRunning() then
			slot0._txtdispatch.text = slot0._config.dispatchingText
		else
			slot0._txtdispatch.text = slot0._config.acceptText
		end
	end

	slot0:setIsChat(false)
end

function slot0.everySecondCall(slot0)
	if not slot0._show then
		return
	end

	if slot0._config and slot0._config.type == DungeonEnum.ElementType.Dispatch then
		slot0:refreshDispatchUI()
	end
end

function slot0.setFinishText(slot0)
	if string.nilorempty(slot0._config.finishText) then
		slot0._txtdesc.text = slot0._config.desc
	else
		slot0._txtdesc.text = slot1
	end
end

function slot0.refreshRewards(slot0)
	if string.nilorempty(DungeonModel.instance:getMapElementReward(slot0._config.id)) then
		gohelper.setActive(slot0._gorewardcontainer, false)

		return
	end

	gohelper.setActive(slot0._gorewardcontainer, true)

	for slot6, slot7 in ipairs(GameUtil.splitString2(slot1, true)) do
		if not slot0.rewardItemList[slot6] then
			table.insert(slot0.rewardItemList, slot0:createRewardItem())
		end

		gohelper.setActive(slot8.go, true)
		slot8.icon:isShowCount(false)
		slot8.icon:setMOValue(slot7[1], slot7[2], slot7[3])

		slot8.txtCount.text = slot7[3]
	end

	for slot6 = #slot2 + 1, #slot0.rewardItemList do
		gohelper.setActive(slot0.rewardItemList[slot6].go, false)
	end
end

function slot0.createRewardItem(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0._goactivityrewarditem)
	slot1.goIcon = gohelper.findChild(slot1.go, "itemicon")
	slot1.goCount = gohelper.findChild(slot1.go, "countbg")
	slot1.txtCount = gohelper.findChildText(slot1.go, "countbg/count")
	slot1.goRare = gohelper.findChild(slot1.go, "rare")
	slot1.icon = IconMgr.instance:getCommonPropItemIcon(slot1.goIcon)

	gohelper.setActive(slot1.goRare, false)

	return slot1
end

function slot0.show(slot0)
	if slot0._show then
		return
	end

	slot0._show = true

	gohelper.setActive(slot0._gointeractitem, true)
	gohelper.setActive(slot0._gointeractiveroot, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
end

function slot0.hide(slot0)
	if not slot0._show then
		return
	end

	VersionActivity1_8DungeonModel.instance:setShowInteractView(nil)

	slot0._show = false

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnclose)
	gohelper.setActive(slot0._gointeractitem, false)
	gohelper.setActive(slot0._gointeractiveroot, false)
	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.OnHideInteractUI)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._optionBtnList = nil
end

return slot0
