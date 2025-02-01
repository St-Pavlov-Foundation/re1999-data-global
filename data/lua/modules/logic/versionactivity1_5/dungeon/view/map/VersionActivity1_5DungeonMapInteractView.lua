module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapInteractView", package.seeall)

slot0 = class("VersionActivity1_5DungeonMapInteractView", BaseView)

function slot0.onInitView(slot0, slot1)
	slot0._gointeractroot = gohelper.findChild(slot0.viewGO, "#go_interactive_root")
	slot0._gointeractitem = gohelper.findChild(slot0.viewGO, "#go_interactive_root/#go_interactitem")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0._gointeractitem, "#btn_close")
	slot0._txtsubherotasktitle = gohelper.findChildText(slot0._gointeractitem, "rotate/#go_subherotasktitle/#txt_subherotasktitle")
	slot0._gosubherotasktitle = gohelper.findChild(slot0._gointeractitem, "rotate/#go_subherotasktitle")
	slot0._txttitle = gohelper.findChildText(slot0._gointeractitem, "rotate/#go_title/#txt_title")
	slot0._simagedescbg = gohelper.findChildSingleImage(slot0._gointeractitem, "rotate/desc_container/#simage_descbg")
	slot0._txtdesc = gohelper.findChildText(slot0._gointeractitem, "rotate/desc_container/#txt_desc")
	slot0.goRewardContainer = gohelper.findChild(slot0._gointeractitem, "rotate/reward_container")
	slot0.goRewardContent = gohelper.findChild(slot0._gointeractitem, "rotate/reward_container/#go_rewardContent")
	slot0.goRewardItem = gohelper.findChild(slot0._gointeractitem, "rotate/reward_container/#go_rewardContent/#go_activityrewarditem")

	slot0:initNoneContainer()
	slot0:initFightContainer()
	slot0:initDispatchContainer()
	slot0:initDialogueContainer()

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.initNoneContainer(slot0)
	slot0.goNone = gohelper.findChild(slot0._gointeractitem, "rotate/option_container/#go_none")
	slot0.txtNone = gohelper.findChildText(slot0._gointeractitem, "rotate/option_container/#go_none/#txt_none")
	slot0.noneBtn = gohelper.findButtonWithAudio(slot0.goNone)
end

function slot0.initFightContainer(slot0)
	slot0.goFight = gohelper.findChild(slot0._gointeractitem, "rotate/option_container/#go_fight")
	slot0.goFightTip = gohelper.findChild(slot0._gointeractitem, "rotate/option_container/#go_fight/#go_fighttip")
	slot0.txtRemainFightNumber = gohelper.findChildText(slot0._gointeractitem, "rotate/option_container/#go_fight/#go_fighttip/#txt_remainfightnumber")
	slot0.fightTipClickArea = gohelper.findChild(slot0._gointeractitem, "rotate/option_container/#go_fight/#go_fighttip/clickarea")
	slot0.txtFight = gohelper.findChildText(slot0._gointeractitem, "rotate/option_container/#go_fight/#txt_fight")
	slot0.goFightCost = gohelper.findChild(slot0._gointeractitem, "rotate/option_container/#go_fight/#go_cost")
	slot0.txtFightCost = gohelper.findChildText(slot0._gointeractitem, "rotate/option_container/#go_fight/#go_cost/#txt_cost")
	slot0.simageCostIcon = gohelper.findChildSingleImage(slot0._gointeractitem, "rotate/option_container/#go_fight/#go_cost/#simage_costicon")
	slot0.fightBtn = gohelper.findButtonWithAudio(slot0.goFight)
end

function slot0.initDispatchContainer(slot0)
	slot0.goDispatch = gohelper.findChild(slot0._gointeractitem, "rotate/option_container/#go_dispatch")
	slot0.txtDispatch = gohelper.findChildText(slot0._gointeractitem, "rotate/option_container/#go_dispatch/#txt_dispatch")
	slot0.enterDispatchBtn = gohelper.findButtonWithAudio(slot0.goDispatch)
end

function slot0.initDialogueContainer(slot0)
	slot0.goDialogue = gohelper.findChild(slot0._gointeractitem, "rotate/option_container/#go_dialogue")
	slot0.txtDialogue = gohelper.findChildText(slot0._gointeractitem, "rotate/option_container/#go_dialogue/#txt_dialogue")
	slot0.enterDialogueBtn = gohelper.findButtonWithAudio(slot0.goDialogue)
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0.noneBtn:AddClickListener(slot0._onClickNoneBtn, slot0)
	slot0.fightBtn:AddClickListener(slot0._onClickFightBtn, slot0)
	slot0.enterDialogueBtn:AddClickListener(slot0._onClickEnterDialogueBtn, slot0)
	slot0.enterDispatchBtn:AddClickListener(slot0._onClickEnterDispatchBtn, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0.noneBtn:RemoveClickListener()
	slot0.fightBtn:RemoveClickListener()
	slot0.enterDialogueBtn:RemoveClickListener()
	slot0.enterDispatchBtn:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._handleTypeMap = {
		[DungeonEnum.ElementType.None] = slot0.refreshNoneUI,
		[DungeonEnum.ElementType.Fight] = slot0.refreshFightUI,
		[DungeonEnum.ElementType.EnterDialogue] = slot0.refreshDialogueUI,
		[DungeonEnum.ElementType.EnterDispatch] = slot0.refreshEnterDispatchUI
	}
	slot0.type2goDict = {
		[DungeonEnum.ElementType.None] = slot0.goNone,
		[DungeonEnum.ElementType.Fight] = slot0.goFight,
		[DungeonEnum.ElementType.EnterDialogue] = slot0.goDialogue,
		[DungeonEnum.ElementType.EnterDispatch] = slot0.goDispatch
	}
	slot0.rewardItemList = {}
	slot0.rootClick = gohelper.findChildClickWithDefaultAudio(slot0._gointeractroot, "close_block")

	slot0.rootClick:AddClickListener(slot0.onClickRoot, slot0)
	gohelper.setActive(slot0._gointeractitem, false)
	gohelper.setActive(slot0._gointeractroot, false)
	gohelper.setActive(slot0.goRewardItem, false)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnClickElement, slot0.showInteractUI, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinishCall, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.AddDispatchInfo, slot0.onAddDispatchInfo, slot0)
	slot0:addEventCb(DialogueController.instance, DialogueEvent.OnDialogueInfoChange, slot0.onDialogueInfoChange, slot0)
	slot0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, slot0.beforeJump, slot0)
end

function slot0.onClickRoot(slot0)
	slot0:hide()
end

function slot0.showInteractUI(slot0, slot1)
	if slot0._show then
		return
	end

	VersionActivity1_5DungeonModel.instance:setShowInteractView(true)

	slot0._mapElement = slot1
	slot0._config = slot0._mapElement._config
	slot0._elementGo = slot0._mapElement._go
	slot0.isFinish = false

	slot0:show()
	slot0:refreshUI()
end

function slot0.show(slot0)
	if slot0._show then
		return
	end

	slot0._show = true

	gohelper.setActive(slot0._gointeractitem, true)
	gohelper.setActive(slot0._gointeractroot, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
end

function slot0.hide(slot0)
	if not slot0._show then
		return
	end

	VersionActivity1_5DungeonModel.instance:setShowInteractView(nil)

	slot0._show = false
	slot0.dispatchMo = nil

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnclose)
	gohelper.setActive(slot0._gointeractitem, false)
	gohelper.setActive(slot0._gointeractroot, false)
	TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnHideInteractUI)
end

function slot0.refreshUI(slot0)
	for slot4, slot5 in pairs(slot0.type2goDict) do
		gohelper.setActive(slot5, slot4 == slot0._config.type)
	end

	slot0._txttitle.text = slot0._config.title

	if slot0._handleTypeMap[slot0._config.type] then
		slot1(slot0)
	else
		logError("element type undefined!")
	end

	slot0:refreshSubHeroTaskTitle()
	slot0:refreshRewards()
end

function slot0.refreshSubHeroTaskTitle(slot0)
	slot2 = VersionActivity1_5DungeonConfig.instance:getSubHeroTaskCoByElementId(slot0._config.id) ~= nil

	gohelper.setActive(slot0._gosubherotasktitle, slot2)

	if slot2 then
		slot0._txtsubherotasktitle.text = slot1.title
	end
end

function slot0.refreshRewards(slot0)
	if string.nilorempty(DungeonModel.instance:getMapElementReward(slot0._config.id)) then
		gohelper.setActive(slot0.goRewardContainer, false)

		return
	end

	gohelper.setActive(slot0.goRewardContainer, true)

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
	slot1.go = gohelper.cloneInPlace(slot0.goRewardItem)
	slot1.goIcon = gohelper.findChild(slot1.go, "itemicon")
	slot1.goCount = gohelper.findChild(slot1.go, "countbg")
	slot1.txtCount = gohelper.findChildText(slot1.go, "countbg/count")
	slot1.goRare = gohelper.findChild(slot1.go, "rare")
	slot1.icon = IconMgr.instance:getCommonPropItemIcon(slot1.goIcon)

	gohelper.setActive(slot1.goRare, false)

	return slot1
end

function slot0.refreshNoneUI(slot0)
	slot0.txtNone.text = slot0._config.acceptText
	slot0._txtdesc.text = slot0._config.desc
end

function slot0.setFinishText(slot0)
	if string.nilorempty(slot0._config.finishText) then
		slot0._txtdesc.text = slot0._config.desc
	else
		slot0._txtdesc.text = slot1
	end
end

function slot0.refreshFightUI(slot0)
	slot0.isFinish = DungeonModel.instance:hasPassLevel(tonumber(slot0._config.param))

	if slot0.isFinish then
		slot0.txtFight.text = luaLang("p_v1a5_news_order_finish")

		slot0:setFinishText()
	else
		slot0.txtFight.text = slot0._config.acceptText
		slot0._txtdesc.text = slot0._config.desc
	end
end

function slot0.refreshDialogueUI(slot0)
	slot0.dialogueId = tonumber(slot0._config.param)
	slot0.isFinish = DialogueModel.instance:isFinishDialogue(slot0.dialogueId)

	if slot0.isFinish then
		slot0.txtDialogue.text = luaLang("p_v1a5_news_order_finish")

		slot0:setFinishText()
	else
		slot0.txtDialogue.text = slot0._config.acceptText
		slot0._txtdesc.text = slot0._config.desc
	end
end

function slot0.refreshEnterDispatchUI(slot0)
	slot0.dispatchMo = VersionActivity1_5DungeonModel.instance:getDispatchMo(tonumber(slot0._config.param))
	slot0.isFinish = slot0.dispatchMo and slot0.dispatchMo:isFinish()

	if slot0.isFinish then
		slot0.txtDispatch.text = luaLang("p_v1a5_news_order_finish")

		slot0:setFinishText()
		TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)
	else
		slot0.txtDispatch.text = slot0._config.acceptText
		slot0._txtdesc.text = slot0._config.desc

		if slot0.dispatchMo and slot0.dispatchMo:isRunning() then
			TaskDispatcher.runRepeat(slot0.everySecondCall, slot0, 1)
		end
	end
end

function slot0._btncloseOnClick(slot0)
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

	VersionActivity1_5DungeonController.instance:setLastEpisodeId(slot0.activityDungeonMo.episodeId)
	DungeonFightController.instance:enterFight(slot2.chapterId, slot1)
end

function slot0._onClickEnterDialogueBtn(slot0)
	if slot0.isFinish then
		slot0:hide()
		slot0:finishElement()

		return
	end

	DialogueController.instance:enterDialogue(slot0.dialogueId)
end

function slot0._onClickEnterDispatchBtn(slot0)
	if slot0.isFinish then
		slot0:hide()
		slot0:finishElement()

		return
	end

	VersionActivity1_5DungeonController.instance:openDispatchView(tonumber(slot0._config.param))
end

function slot0.finishElement(slot0)
	slot1 = slot0._config.id

	DungeonMapModel.instance:addFinishedElement(slot1)
	DungeonMapModel.instance:removeElement(slot1)
	DungeonRpc.instance:sendMapElementRequest(slot1)
end

function slot0.onDialogueInfoChange(slot0, slot1)
	if slot1 == slot0.dialogueId then
		slot0:refreshDialogueUI()
	end
end

function slot0.everySecondCall(slot0)
	if slot0.dispatchMo and slot0.dispatchMo:isFinish() then
		slot0:refreshEnterDispatchUI()
	end
end

function slot0.onCloseViewFinishCall(slot0, slot1)
	if slot1 == ViewName.DialogueView and slot0.isFinish then
		slot0:refreshUI()
	end
end

function slot0.onAddDispatchInfo(slot0, slot1)
	slot0:refreshEnterDispatchUI()
end

function slot0.beforeJump(slot0)
	slot0:hide()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagedescbg:UnLoadImage()
	slot0.rootClick:RemoveClickListener()
end

return slot0
