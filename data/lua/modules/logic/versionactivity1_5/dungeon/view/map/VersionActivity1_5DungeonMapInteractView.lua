module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapInteractView", package.seeall)

local var_0_0 = class("VersionActivity1_5DungeonMapInteractView", BaseView)

function var_0_0.onInitView(arg_1_0, arg_1_1)
	arg_1_0._gointeractroot = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root")
	arg_1_0._gointeractitem = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0._gointeractitem, "#btn_close")
	arg_1_0._txtsubherotasktitle = gohelper.findChildText(arg_1_0._gointeractitem, "rotate/#go_subherotasktitle/#txt_subherotasktitle")
	arg_1_0._gosubherotasktitle = gohelper.findChild(arg_1_0._gointeractitem, "rotate/#go_subherotasktitle")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0._gointeractitem, "rotate/#go_title/#txt_title")
	arg_1_0._simagedescbg = gohelper.findChildSingleImage(arg_1_0._gointeractitem, "rotate/desc_container/#simage_descbg")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0._gointeractitem, "rotate/desc_container/#txt_desc")
	arg_1_0.goRewardContainer = gohelper.findChild(arg_1_0._gointeractitem, "rotate/reward_container")
	arg_1_0.goRewardContent = gohelper.findChild(arg_1_0._gointeractitem, "rotate/reward_container/#go_rewardContent")
	arg_1_0.goRewardItem = gohelper.findChild(arg_1_0._gointeractitem, "rotate/reward_container/#go_rewardContent/#go_activityrewarditem")

	arg_1_0:initNoneContainer()
	arg_1_0:initFightContainer()
	arg_1_0:initDispatchContainer()
	arg_1_0:initDialogueContainer()

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.initNoneContainer(arg_2_0)
	arg_2_0.goNone = gohelper.findChild(arg_2_0._gointeractitem, "rotate/option_container/#go_none")
	arg_2_0.txtNone = gohelper.findChildText(arg_2_0._gointeractitem, "rotate/option_container/#go_none/#txt_none")
	arg_2_0.noneBtn = gohelper.findButtonWithAudio(arg_2_0.goNone)
end

function var_0_0.initFightContainer(arg_3_0)
	arg_3_0.goFight = gohelper.findChild(arg_3_0._gointeractitem, "rotate/option_container/#go_fight")
	arg_3_0.goFightTip = gohelper.findChild(arg_3_0._gointeractitem, "rotate/option_container/#go_fight/#go_fighttip")
	arg_3_0.txtRemainFightNumber = gohelper.findChildText(arg_3_0._gointeractitem, "rotate/option_container/#go_fight/#go_fighttip/#txt_remainfightnumber")
	arg_3_0.fightTipClickArea = gohelper.findChild(arg_3_0._gointeractitem, "rotate/option_container/#go_fight/#go_fighttip/clickarea")
	arg_3_0.txtFight = gohelper.findChildText(arg_3_0._gointeractitem, "rotate/option_container/#go_fight/#txt_fight")
	arg_3_0.goFightCost = gohelper.findChild(arg_3_0._gointeractitem, "rotate/option_container/#go_fight/#go_cost")
	arg_3_0.txtFightCost = gohelper.findChildText(arg_3_0._gointeractitem, "rotate/option_container/#go_fight/#go_cost/#txt_cost")
	arg_3_0.simageCostIcon = gohelper.findChildSingleImage(arg_3_0._gointeractitem, "rotate/option_container/#go_fight/#go_cost/#simage_costicon")
	arg_3_0.fightBtn = gohelper.findButtonWithAudio(arg_3_0.goFight)
end

function var_0_0.initDispatchContainer(arg_4_0)
	arg_4_0.goDispatch = gohelper.findChild(arg_4_0._gointeractitem, "rotate/option_container/#go_dispatch")
	arg_4_0.txtDispatch = gohelper.findChildText(arg_4_0._gointeractitem, "rotate/option_container/#go_dispatch/#txt_dispatch")
	arg_4_0.enterDispatchBtn = gohelper.findButtonWithAudio(arg_4_0.goDispatch)
end

function var_0_0.initDialogueContainer(arg_5_0)
	arg_5_0.goDialogue = gohelper.findChild(arg_5_0._gointeractitem, "rotate/option_container/#go_dialogue")
	arg_5_0.txtDialogue = gohelper.findChildText(arg_5_0._gointeractitem, "rotate/option_container/#go_dialogue/#txt_dialogue")
	arg_5_0.enterDialogueBtn = gohelper.findButtonWithAudio(arg_5_0.goDialogue)
end

function var_0_0.addEvents(arg_6_0)
	arg_6_0._btnclose:AddClickListener(arg_6_0._btncloseOnClick, arg_6_0)
	arg_6_0.noneBtn:AddClickListener(arg_6_0._onClickNoneBtn, arg_6_0)
	arg_6_0.fightBtn:AddClickListener(arg_6_0._onClickFightBtn, arg_6_0)
	arg_6_0.enterDialogueBtn:AddClickListener(arg_6_0._onClickEnterDialogueBtn, arg_6_0)
	arg_6_0.enterDispatchBtn:AddClickListener(arg_6_0._onClickEnterDispatchBtn, arg_6_0)
end

function var_0_0.removeEvents(arg_7_0)
	arg_7_0._btnclose:RemoveClickListener()
	arg_7_0.noneBtn:RemoveClickListener()
	arg_7_0.fightBtn:RemoveClickListener()
	arg_7_0.enterDialogueBtn:RemoveClickListener()
	arg_7_0.enterDispatchBtn:RemoveClickListener()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._handleTypeMap = {
		[DungeonEnum.ElementType.None] = arg_8_0.refreshNoneUI,
		[DungeonEnum.ElementType.Fight] = arg_8_0.refreshFightUI,
		[DungeonEnum.ElementType.EnterDialogue] = arg_8_0.refreshDialogueUI,
		[DungeonEnum.ElementType.EnterDispatch] = arg_8_0.refreshEnterDispatchUI
	}
	arg_8_0.type2goDict = {
		[DungeonEnum.ElementType.None] = arg_8_0.goNone,
		[DungeonEnum.ElementType.Fight] = arg_8_0.goFight,
		[DungeonEnum.ElementType.EnterDialogue] = arg_8_0.goDialogue,
		[DungeonEnum.ElementType.EnterDispatch] = arg_8_0.goDispatch
	}
	arg_8_0.rewardItemList = {}
	arg_8_0.rootClick = gohelper.findChildClickWithDefaultAudio(arg_8_0._gointeractroot, "close_block")

	arg_8_0.rootClick:AddClickListener(arg_8_0.onClickRoot, arg_8_0)
	gohelper.setActive(arg_8_0._gointeractitem, false)
	gohelper.setActive(arg_8_0._gointeractroot, false)
	gohelper.setActive(arg_8_0.goRewardItem, false)
	arg_8_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnClickElement, arg_8_0.showInteractUI, arg_8_0)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_8_0.onCloseViewFinishCall, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.AddDispatchInfo, arg_8_0.onAddDispatchInfo, arg_8_0)
	arg_8_0:addEventCb(DialogueController.instance, DialogueEvent.OnDialogueInfoChange, arg_8_0.onDialogueInfoChange, arg_8_0)
	arg_8_0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, arg_8_0.beforeJump, arg_8_0)
end

function var_0_0.onClickRoot(arg_9_0)
	arg_9_0:hide()
end

function var_0_0.showInteractUI(arg_10_0, arg_10_1)
	if arg_10_0._show then
		return
	end

	VersionActivity1_5DungeonModel.instance:setShowInteractView(true)

	arg_10_0._mapElement = arg_10_1
	arg_10_0._config = arg_10_0._mapElement._config
	arg_10_0._elementGo = arg_10_0._mapElement._go
	arg_10_0.isFinish = false

	arg_10_0:show()
	arg_10_0:refreshUI()
end

function var_0_0.show(arg_11_0)
	if arg_11_0._show then
		return
	end

	arg_11_0._show = true

	gohelper.setActive(arg_11_0._gointeractitem, true)
	gohelper.setActive(arg_11_0._gointeractroot, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
end

function var_0_0.hide(arg_12_0)
	if not arg_12_0._show then
		return
	end

	VersionActivity1_5DungeonModel.instance:setShowInteractView(nil)

	arg_12_0._show = false
	arg_12_0.dispatchMo = nil

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnclose)
	gohelper.setActive(arg_12_0._gointeractitem, false)
	gohelper.setActive(arg_12_0._gointeractroot, false)
	TaskDispatcher.cancelTask(arg_12_0.everySecondCall, arg_12_0)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnHideInteractUI)
end

function var_0_0.refreshUI(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.type2goDict) do
		gohelper.setActive(iter_13_1, iter_13_0 == arg_13_0._config.type)
	end

	arg_13_0._txttitle.text = arg_13_0._config.title

	local var_13_0 = arg_13_0._handleTypeMap[arg_13_0._config.type]

	if var_13_0 then
		var_13_0(arg_13_0)
	else
		logError("element type undefined!")
	end

	arg_13_0:refreshSubHeroTaskTitle()
	arg_13_0:refreshRewards()
end

function var_0_0.refreshSubHeroTaskTitle(arg_14_0)
	local var_14_0 = VersionActivity1_5DungeonConfig.instance:getSubHeroTaskCoByElementId(arg_14_0._config.id)
	local var_14_1 = var_14_0 ~= nil

	gohelper.setActive(arg_14_0._gosubherotasktitle, var_14_1)

	if var_14_1 then
		arg_14_0._txtsubherotasktitle.text = var_14_0.title
	end
end

function var_0_0.refreshRewards(arg_15_0)
	local var_15_0 = DungeonModel.instance:getMapElementReward(arg_15_0._config.id)

	if string.nilorempty(var_15_0) then
		gohelper.setActive(arg_15_0.goRewardContainer, false)

		return
	end

	gohelper.setActive(arg_15_0.goRewardContainer, true)

	local var_15_1 = GameUtil.splitString2(var_15_0, true)

	for iter_15_0, iter_15_1 in ipairs(var_15_1) do
		local var_15_2 = arg_15_0.rewardItemList[iter_15_0]

		if not var_15_2 then
			var_15_2 = arg_15_0:createRewardItem()

			table.insert(arg_15_0.rewardItemList, var_15_2)
		end

		gohelper.setActive(var_15_2.go, true)
		var_15_2.icon:isShowCount(false)
		var_15_2.icon:setMOValue(iter_15_1[1], iter_15_1[2], iter_15_1[3])

		var_15_2.txtCount.text = iter_15_1[3]
	end

	for iter_15_2 = #var_15_1 + 1, #arg_15_0.rewardItemList do
		gohelper.setActive(arg_15_0.rewardItemList[iter_15_2].go, false)
	end
end

function var_0_0.createRewardItem(arg_16_0)
	local var_16_0 = arg_16_0:getUserDataTb_()

	var_16_0.go = gohelper.cloneInPlace(arg_16_0.goRewardItem)
	var_16_0.goIcon = gohelper.findChild(var_16_0.go, "itemicon")
	var_16_0.goCount = gohelper.findChild(var_16_0.go, "countbg")
	var_16_0.txtCount = gohelper.findChildText(var_16_0.go, "countbg/count")
	var_16_0.goRare = gohelper.findChild(var_16_0.go, "rare")
	var_16_0.icon = IconMgr.instance:getCommonPropItemIcon(var_16_0.goIcon)

	gohelper.setActive(var_16_0.goRare, false)

	return var_16_0
end

function var_0_0.refreshNoneUI(arg_17_0)
	arg_17_0.txtNone.text = arg_17_0._config.acceptText
	arg_17_0._txtdesc.text = arg_17_0._config.desc
end

function var_0_0.setFinishText(arg_18_0)
	local var_18_0 = arg_18_0._config.finishText

	if string.nilorempty(var_18_0) then
		arg_18_0._txtdesc.text = arg_18_0._config.desc
	else
		arg_18_0._txtdesc.text = var_18_0
	end
end

function var_0_0.refreshFightUI(arg_19_0)
	local var_19_0 = tonumber(arg_19_0._config.param)

	arg_19_0.isFinish = DungeonModel.instance:hasPassLevel(var_19_0)

	if arg_19_0.isFinish then
		arg_19_0.txtFight.text = luaLang("p_v1a5_news_order_finish")

		arg_19_0:setFinishText()
	else
		arg_19_0.txtFight.text = arg_19_0._config.acceptText
		arg_19_0._txtdesc.text = arg_19_0._config.desc
	end
end

function var_0_0.refreshDialogueUI(arg_20_0)
	arg_20_0.dialogueId = tonumber(arg_20_0._config.param)
	arg_20_0.isFinish = DialogueModel.instance:isFinishDialogue(arg_20_0.dialogueId)

	if arg_20_0.isFinish then
		arg_20_0.txtDialogue.text = luaLang("p_v1a5_news_order_finish")

		arg_20_0:setFinishText()
	else
		arg_20_0.txtDialogue.text = arg_20_0._config.acceptText
		arg_20_0._txtdesc.text = arg_20_0._config.desc
	end
end

function var_0_0.refreshEnterDispatchUI(arg_21_0)
	local var_21_0 = tonumber(arg_21_0._config.param)

	arg_21_0.dispatchMo = VersionActivity1_5DungeonModel.instance:getDispatchMo(var_21_0)
	arg_21_0.isFinish = arg_21_0.dispatchMo and arg_21_0.dispatchMo:isFinish()

	if arg_21_0.isFinish then
		arg_21_0.txtDispatch.text = luaLang("p_v1a5_news_order_finish")

		arg_21_0:setFinishText()
		TaskDispatcher.cancelTask(arg_21_0.everySecondCall, arg_21_0)
	else
		arg_21_0.txtDispatch.text = arg_21_0._config.acceptText
		arg_21_0._txtdesc.text = arg_21_0._config.desc

		if arg_21_0.dispatchMo and arg_21_0.dispatchMo:isRunning() then
			TaskDispatcher.runRepeat(arg_21_0.everySecondCall, arg_21_0, 1)
		end
	end
end

function var_0_0._btncloseOnClick(arg_22_0)
	arg_22_0:hide()
end

function var_0_0._onClickNoneBtn(arg_23_0)
	arg_23_0:hide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
	arg_23_0:finishElement()
end

function var_0_0._onClickFightBtn(arg_24_0)
	arg_24_0:hide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)

	if arg_24_0.isFinish then
		arg_24_0:finishElement()

		return
	end

	local var_24_0 = tonumber(arg_24_0._config.param)

	DungeonModel.instance.curLookEpisodeId = var_24_0

	local var_24_1 = DungeonConfig.instance:getEpisodeCO(var_24_0)

	if not var_24_1 then
		logError("episode config not exist , episodeId : " .. tostring(var_24_0))

		return
	end

	VersionActivity1_5DungeonController.instance:setLastEpisodeId(arg_24_0.activityDungeonMo.episodeId)
	DungeonFightController.instance:enterFight(var_24_1.chapterId, var_24_0)
end

function var_0_0._onClickEnterDialogueBtn(arg_25_0)
	if arg_25_0.isFinish then
		arg_25_0:hide()
		arg_25_0:finishElement()

		return
	end

	DialogueController.instance:enterDialogue(arg_25_0.dialogueId)
end

function var_0_0._onClickEnterDispatchBtn(arg_26_0)
	if arg_26_0.isFinish then
		arg_26_0:hide()
		arg_26_0:finishElement()

		return
	end

	VersionActivity1_5DungeonController.instance:openDispatchView(tonumber(arg_26_0._config.param))
end

function var_0_0.finishElement(arg_27_0)
	local var_27_0 = arg_27_0._config.id

	DungeonMapModel.instance:addFinishedElement(var_27_0)
	DungeonMapModel.instance:removeElement(var_27_0)
	DungeonRpc.instance:sendMapElementRequest(var_27_0)
end

function var_0_0.onDialogueInfoChange(arg_28_0, arg_28_1)
	if arg_28_1 == arg_28_0.dialogueId then
		arg_28_0:refreshDialogueUI()
	end
end

function var_0_0.everySecondCall(arg_29_0)
	if arg_29_0.dispatchMo and arg_29_0.dispatchMo:isFinish() then
		arg_29_0:refreshEnterDispatchUI()
	end
end

function var_0_0.onCloseViewFinishCall(arg_30_0, arg_30_1)
	if arg_30_1 == ViewName.DialogueView and arg_30_0.isFinish then
		arg_30_0:refreshUI()
	end
end

function var_0_0.onAddDispatchInfo(arg_31_0, arg_31_1)
	arg_31_0:refreshEnterDispatchUI()
end

function var_0_0.beforeJump(arg_32_0)
	arg_32_0:hide()
end

function var_0_0.onClose(arg_33_0)
	return
end

function var_0_0.onDestroyView(arg_34_0)
	arg_34_0._simagedescbg:UnLoadImage()
	arg_34_0.rootClick:RemoveClickListener()
end

return var_0_0
