module("modules.versionactivitybase.fixed.dungeon.view.map.VersionActivityFixedDungeonMapInteractView", package.seeall)

local var_0_0 = class("VersionActivityFixedDungeonMapInteractView", BaseView)

function var_0_0.onInitView(arg_1_0, arg_1_1)
	arg_1_0._gointeractroot = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root")
	arg_1_0._gointeractitem = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0._gointeractitem, "#btn_close")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0._gointeractitem, "rotate/#go_title/#txt_title")
	arg_1_0._simagedescbg = gohelper.findChildSingleImage(arg_1_0._gointeractitem, "rotate/desc_container/#simage_descbg")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0._gointeractitem, "rotate/desc_container/#txt_desc")
	arg_1_0._godesc = arg_1_0._txtdesc.gameObject
	arg_1_0._gochat = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat")
	arg_1_0._gochatusericon = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat/usericon")
	arg_1_0._txtchatname = gohelper.findChildText(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat/name")
	arg_1_0._txtchatdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat/info")
	arg_1_0.goRewardContainer = gohelper.findChild(arg_1_0._gointeractitem, "rotate/reward_container")
	arg_1_0.goRewardContent = gohelper.findChild(arg_1_0._gointeractitem, "rotate/reward_container/#go_rewardContent")
	arg_1_0.goRewardItem = gohelper.findChild(arg_1_0._gointeractitem, "rotate/reward_container/#go_rewardContent/#go_activityrewarditem")

	arg_1_0:initNoneContainer()
	arg_1_0:initFightContainer()
	arg_1_0:initDialogueContainer()
	arg_1_0:initTalkContainer()

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

function var_0_0.initDialogueContainer(arg_4_0)
	arg_4_0.goDialogue = gohelper.findChild(arg_4_0._gointeractitem, "rotate/option_container/#go_dialogue")
	arg_4_0.txtDialogue = gohelper.findChildText(arg_4_0._gointeractitem, "rotate/option_container/#go_dialogue/#txt_dialogue")
	arg_4_0.enterDialogueBtn = gohelper.findButtonWithAudio(arg_4_0.goDialogue)
end

function var_0_0.initTalkContainer(arg_5_0)
	arg_5_0.goTalk = gohelper.findChild(arg_5_0._gointeractitem, "rotate/option_container/#go_talk")
	arg_5_0._gonext = gohelper.findChild(arg_5_0._gointeractitem, "rotate/option_container/#go_talk/#go_next")
	arg_5_0._btnnext = gohelper.findChildButtonWithAudio(arg_5_0._gointeractitem, "rotate/option_container/#go_talk/#go_next/#btn_next")
	arg_5_0._gooptions = gohelper.findChild(arg_5_0._gointeractitem, "rotate/option_container/#go_talk/#go_options")
	arg_5_0._gotalkitem = gohelper.findChild(arg_5_0._gointeractitem, "rotate/option_container/#go_talk/#go_options/#go_talkitem")

	gohelper.setActive(arg_5_0._gotalkitem, false)

	arg_5_0._gofinishtalk = gohelper.findChild(arg_5_0._gointeractitem, "rotate/option_container/#go_talk/#go_finishtalk")
	arg_5_0._btnfinishtalk = gohelper.findChildButtonWithAudio(arg_5_0._gointeractitem, "rotate/option_container/#go_talk/#go_finishtalk/#btn_finishtalk")
end

function var_0_0.addEvents(arg_6_0)
	arg_6_0._btnclose:AddClickListener(arg_6_0._btncloseOnClick, arg_6_0)
	arg_6_0.noneBtn:AddClickListener(arg_6_0._onClickNoneBtn, arg_6_0)
	arg_6_0.fightBtn:AddClickListener(arg_6_0._onClickFightBtn, arg_6_0)
	arg_6_0.enterDialogueBtn:AddClickListener(arg_6_0._onClickEnterDialogueBtn, arg_6_0)
	arg_6_0._btnnext:AddClickListener(arg_6_0._btnnextOnClick, arg_6_0)
	arg_6_0._btnfinishtalk:AddClickListener(arg_6_0._btnfinishtalkOnClick, arg_6_0)
	arg_6_0:addEventCb(VersionActivityFixedHelper.getVersionActivityDungeonController().instance, VersionActivityFixedDungeonEvent.OnClickElement, arg_6_0.showInteractUI, arg_6_0)
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_6_0.onCloseViewFinishCall, arg_6_0)
	arg_6_0:addEventCb(DialogueController.instance, DialogueEvent.OnDialogueInfoChange, arg_6_0.onDialogueInfoChange, arg_6_0)
	arg_6_0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, arg_6_0.beforeJump, arg_6_0)
end

function var_0_0.removeEvents(arg_7_0)
	arg_7_0._btnclose:RemoveClickListener()
	arg_7_0.noneBtn:RemoveClickListener()
	arg_7_0.fightBtn:RemoveClickListener()
	arg_7_0.enterDialogueBtn:RemoveClickListener()
	arg_7_0._btnnext:RemoveClickListener()
	arg_7_0._btnfinishtalk:RemoveClickListener()
	arg_7_0:removeEventCb(VersionActivityFixedHelper.getVersionActivityDungeonController().instance, VersionActivityFixedDungeonEvent.OnClickElement, arg_7_0.showInteractUI, arg_7_0)
	arg_7_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_7_0.onCloseViewFinishCall, arg_7_0)
	arg_7_0:removeEventCb(DialogueController.instance, DialogueEvent.OnDialogueInfoChange, arg_7_0.onDialogueInfoChange, arg_7_0)
	arg_7_0:removeEventCb(JumpController.instance, JumpEvent.BeforeJump, arg_7_0.beforeJump, arg_7_0)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._handleTypeMap = {
		[DungeonEnum.ElementType.None] = arg_8_0.refreshNoneUI,
		[DungeonEnum.ElementType.Fight] = arg_8_0.refreshFightUI,
		[DungeonEnum.ElementType.EnterDialogue] = arg_8_0.refreshDialogueUI,
		[DungeonEnum.ElementType.Story] = arg_8_0.refreshTalkUI
	}
	arg_8_0.type2goDict = {
		[DungeonEnum.ElementType.None] = arg_8_0.goNone,
		[DungeonEnum.ElementType.Fight] = arg_8_0.goFight,
		[DungeonEnum.ElementType.EnterDialogue] = arg_8_0.goDialogue,
		[DungeonEnum.ElementType.Story] = arg_8_0.goTalk
	}
	arg_8_0.rewardItemList = {}
	arg_8_0._optionBtnList = arg_8_0:getUserDataTb_()
	arg_8_0.mapSceneElementsView = arg_8_0.viewContainer.mapSceneElements
	arg_8_0.rootClick = gohelper.findChildClickWithDefaultAudio(arg_8_0._gointeractroot, "close_block")

	arg_8_0.rootClick:AddClickListener(arg_8_0.onClickRoot, arg_8_0)
	gohelper.setActive(arg_8_0._gointeractitem, false)
	gohelper.setActive(arg_8_0._gointeractroot, false)
	gohelper.setActive(arg_8_0.goRewardItem, false)
end

function var_0_0.showInteractUI(arg_9_0, arg_9_1)
	if arg_9_0._show then
		return
	end

	VersionActivityFixedDungeonModel.instance:setShowInteractView(true)

	arg_9_0._mapElement = arg_9_1
	arg_9_0._config = arg_9_0._mapElement._config
	arg_9_0._elementGo = arg_9_0._mapElement._go
	arg_9_0.isFinish = false

	arg_9_0:show()
	arg_9_0:refreshUI()
end

function var_0_0.show(arg_10_0)
	if arg_10_0._show then
		return
	end

	arg_10_0._show = true

	gohelper.setActive(arg_10_0._gointeractitem, true)
	gohelper.setActive(arg_10_0._gointeractroot, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
end

function var_0_0.hide(arg_11_0)
	if not arg_11_0._show then
		return
	end

	VersionActivityFixedDungeonModel.instance:setShowInteractView(nil)

	arg_11_0._show = false
	arg_11_0.dispatchMo = nil

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnclose)
	gohelper.setActive(arg_11_0._gointeractitem, false)
	gohelper.setActive(arg_11_0._gointeractroot, false)
	TaskDispatcher.cancelTask(arg_11_0.everySecondCall, arg_11_0)
	VersionActivityFixedHelper.getVersionActivityDungeonController().instance:dispatchEvent(VersionActivityFixedDungeonEvent.OnHideInteractUI)
end

function var_0_0.refreshUI(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.type2goDict) do
		gohelper.setActive(iter_12_1, iter_12_0 == arg_12_0._config.type)
	end

	arg_12_0._txttitle.text = arg_12_0._config.title

	local var_12_0 = arg_12_0._handleTypeMap[arg_12_0._config.type]

	if var_12_0 then
		var_12_0(arg_12_0)
	else
		logError("element type undefined!")
	end

	arg_12_0:refreshRewards()
end

function var_0_0.refreshRewards(arg_13_0)
	local var_13_0 = arg_13_0._config.reward

	if string.nilorempty(var_13_0) then
		gohelper.setActive(arg_13_0.goRewardContainer, false)

		return
	end

	gohelper.setActive(arg_13_0.goRewardContainer, true)

	local var_13_1 = GameUtil.splitString2(var_13_0, true)

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		local var_13_2 = arg_13_0.rewardItemList[iter_13_0]

		if not var_13_2 then
			var_13_2 = arg_13_0:createRewardItem()

			table.insert(arg_13_0.rewardItemList, var_13_2)
		end

		gohelper.setActive(var_13_2.go, true)
		var_13_2.icon:isShowCount(false)
		var_13_2.icon:setMOValue(iter_13_1[1], iter_13_1[2], iter_13_1[3])

		var_13_2.txtCount.text = iter_13_1[3]
	end

	for iter_13_2 = #var_13_1 + 1, #arg_13_0.rewardItemList do
		gohelper.setActive(arg_13_0.rewardItemList[iter_13_2].go, false)
	end
end

function var_0_0.createRewardItem(arg_14_0)
	local var_14_0 = arg_14_0:getUserDataTb_()

	var_14_0.go = gohelper.cloneInPlace(arg_14_0.goRewardItem)
	var_14_0.goIcon = gohelper.findChild(var_14_0.go, "itemicon")
	var_14_0.goCount = gohelper.findChild(var_14_0.go, "countbg")
	var_14_0.txtCount = gohelper.findChildText(var_14_0.go, "countbg/count")
	var_14_0.goRare = gohelper.findChild(var_14_0.go, "rare")
	var_14_0.icon = IconMgr.instance:getCommonPropItemIcon(var_14_0.goIcon)

	gohelper.setActive(var_14_0.goRare, false)

	return var_14_0
end

function var_0_0.refreshNoneUI(arg_15_0)
	arg_15_0.txtNone.text = arg_15_0._config.acceptText
	arg_15_0._txtdesc.text = arg_15_0._config.desc

	arg_15_0:setIsChat(false)
end

function var_0_0.setFinishText(arg_16_0)
	local var_16_0 = arg_16_0._config.finishText

	if string.nilorempty(var_16_0) then
		arg_16_0._txtdesc.text = arg_16_0._config.desc
	else
		arg_16_0._txtdesc.text = var_16_0
	end
end

function var_0_0.refreshFightUI(arg_17_0)
	local var_17_0 = tonumber(arg_17_0._config.param)

	arg_17_0.isFinish = DungeonModel.instance:hasPassLevel(var_17_0)

	if arg_17_0.isFinish then
		arg_17_0.txtFight.text = luaLang("p_v1a5_news_order_finish")

		arg_17_0:setFinishText()
	else
		arg_17_0.txtFight.text = arg_17_0._config.acceptText
		arg_17_0._txtdesc.text = arg_17_0._config.desc
	end

	arg_17_0:setIsChat(false)
end

function var_0_0.refreshDialogueUI(arg_18_0)
	arg_18_0.dialogueId = tonumber(arg_18_0._config.param)
	arg_18_0.isFinish = DialogueModel.instance:isFinishDialogue(arg_18_0.dialogueId)

	if arg_18_0.isFinish then
		arg_18_0.txtDialogue.text = luaLang("p_v1a5_news_order_finish")

		arg_18_0:setFinishText()
	else
		arg_18_0.txtDialogue.text = arg_18_0._config.acceptText
		arg_18_0._txtdesc.text = arg_18_0._config.desc
	end

	arg_18_0:setIsChat(false)
end

function var_0_0.refreshTalkUI(arg_19_0)
	arg_19_0._sectionStack = {}
	arg_19_0._dialogId = tonumber(arg_19_0._config.param)

	arg_19_0:_playSection(0)
end

function var_0_0._playSection(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0:_setSectionData(arg_20_1, arg_20_2)
	arg_20_0:_playNextDialog()
end

function var_0_0._setSectionData(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0._sectionList = DungeonConfig.instance:getDialog(arg_21_0._dialogId, arg_21_1)
	arg_21_0._dialogIndex = arg_21_2 or 1
	arg_21_0._sectionId = arg_21_1
end

function var_0_0._playNextDialog(arg_22_0)
	local var_22_0 = arg_22_0._sectionList[arg_22_0._dialogIndex]

	arg_22_0._dialogIndex = arg_22_0._dialogIndex + 1

	if var_22_0.type == "dialog" then
		arg_22_0:_showDialog("dialog", var_22_0.content, var_22_0.speaker, var_22_0.audio)
	end

	if #arg_22_0._sectionStack > 0 and #arg_22_0._sectionList < arg_22_0._dialogIndex then
		local var_22_1 = table.remove(arg_22_0._sectionStack)

		arg_22_0:_setSectionData(var_22_1[1], var_22_1[2])
	end

	local var_22_2 = false
	local var_22_3 = arg_22_0._sectionList[arg_22_0._dialogIndex]

	if var_22_3 and var_22_3.type == "options" then
		arg_22_0._dialogIndex = arg_22_0._dialogIndex + 1

		for iter_22_0, iter_22_1 in pairs(arg_22_0._optionBtnList) do
			gohelper.setActive(iter_22_1[1], false)
		end

		local var_22_4 = string.split(var_22_3.content, "#")
		local var_22_5 = string.split(var_22_3.param, "#")

		for iter_22_2, iter_22_3 in ipairs(var_22_4) do
			arg_22_0:_addDialogOption(iter_22_2, var_22_5[iter_22_2], iter_22_3)
		end

		var_22_2 = true
	end

	local var_22_6 = not var_22_3 or var_22_3.type ~= "dialogend"

	arg_22_0:_refreshDialogBtnState(var_22_2, var_22_6)
end

function var_0_0._showDialog(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	DungeonMapModel.instance:addDialog(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	gohelper.setActive(arg_23_0._gochatusericon, not arg_23_3)

	local var_23_0 = not string.nilorempty(arg_23_3)

	arg_23_0._txtchatname.text = var_23_0 and arg_23_3 .. ":" or ""
	arg_23_0._txtchatdesc.text = arg_23_2

	arg_23_0:setIsChat(true)
end

function var_0_0.setIsChat(arg_24_0, arg_24_1)
	gohelper.setActive(arg_24_0._godesc, not arg_24_1)
	gohelper.setActive(arg_24_0._gochat, arg_24_1)
end

function var_0_0._addDialogOption(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_0._optionBtnList[arg_25_1] and arg_25_0._optionBtnList[arg_25_1][1] or gohelper.cloneInPlace(arg_25_0._gotalkitem)

	gohelper.setActive(var_25_0, true)

	gohelper.findChildText(var_25_0, "txt_talkitem").text = arg_25_3

	local var_25_1 = gohelper.findChildButtonWithAudio(var_25_0, "btn_talkitem")

	var_25_1:AddClickListener(arg_25_0._onOptionClick, arg_25_0, {
		arg_25_2,
		arg_25_3
	})

	if not arg_25_0._optionBtnList[arg_25_1] then
		local var_25_2 = arg_25_0:getUserDataTb_()

		var_25_2[1] = var_25_0
		var_25_2[2] = var_25_1
		arg_25_0._optionBtnList[arg_25_1] = var_25_2
	end
end

function var_0_0._onOptionClick(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1[1]
	local var_26_1 = string.format("<color=#c95318>\"%s\"</color>", arg_26_1[2])

	arg_26_0:_showDialog("option", var_26_1)

	if #arg_26_0._sectionList >= arg_26_0._dialogIndex then
		table.insert(arg_26_0._sectionStack, {
			arg_26_0._sectionId,
			arg_26_0._dialogIndex
		})
	end

	DungeonMapModel.instance:addDialogId(var_26_0)
	arg_26_0:_playSection(var_26_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._refreshDialogBtnState(arg_27_0, arg_27_1, arg_27_2)
	gohelper.setActive(arg_27_0._gooptions, arg_27_1)

	if arg_27_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)
		gohelper.setActive(arg_27_0._gonext, false)
		gohelper.setActive(arg_27_0._gofinishtalk, false)

		arg_27_0._curBtnGo = arg_27_0._gooptions

		return
	end

	arg_27_2 = arg_27_2 and (#arg_27_0._sectionStack > 0 or #arg_27_0._sectionList >= arg_27_0._dialogIndex)

	if arg_27_2 then
		arg_27_0._curBtnGo = arg_27_0._gonext

		gohelper.setActive(arg_27_0._gonext, arg_27_2)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continueappear)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)

		arg_27_0._curBtnGo = arg_27_0._gofinishtalk
	end

	gohelper.setActive(arg_27_0._gonext, arg_27_2)
	gohelper.setActive(arg_27_0._gofinishtalk, not arg_27_2)
end

function var_0_0.onClickRoot(arg_28_0)
	arg_28_0:hide()
end

function var_0_0._btncloseOnClick(arg_29_0)
	arg_29_0:hide()
end

function var_0_0._onClickNoneBtn(arg_30_0)
	arg_30_0:hide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
	arg_30_0:finishElement()
end

function var_0_0._onClickFightBtn(arg_31_0)
	arg_31_0:hide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)

	if arg_31_0.isFinish then
		arg_31_0:finishElement()

		return
	end

	local var_31_0 = tonumber(arg_31_0._config.param)

	DungeonModel.instance.curLookEpisodeId = var_31_0

	local var_31_1 = DungeonConfig.instance:getEpisodeCO(var_31_0)

	if not var_31_1 then
		logError("episode config not exist , episodeId : " .. tostring(var_31_0))

		return
	end

	VersionActivityFixedDungeonModel.instance:setLastEpisodeId(arg_31_0.activityDungeonMo.episodeId)
	DungeonFightController.instance:enterFight(var_31_1.chapterId, var_31_0)
end

function var_0_0._onClickEnterDialogueBtn(arg_32_0)
	if arg_32_0.isFinish then
		arg_32_0:hide()
		arg_32_0:finishElement()

		return
	end

	DialogueController.instance:enterDialogue(arg_32_0.dialogueId)
end

function var_0_0.finishElement(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0._config.id

	DungeonMapModel.instance:addFinishedElement(var_33_0)
	DungeonMapModel.instance:removeElement(var_33_0)
	DungeonRpc.instance:sendMapElementRequest(var_33_0, arg_33_1, arg_33_0.refreshElement, arg_33_0)
end

function var_0_0.refreshElement(arg_34_0)
	return
end

function var_0_0._btnnextOnClick(arg_35_0)
	arg_35_0:_playNextSectionOrDialog()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._playNextSectionOrDialog(arg_36_0)
	if #arg_36_0._sectionList >= arg_36_0._dialogIndex then
		arg_36_0:_playNextDialog()

		return
	end

	local var_36_0 = table.remove(arg_36_0._sectionStack)

	if not var_36_0 then
		return
	end

	arg_36_0:_playSection(var_36_0[1], var_36_0[2])
end

function var_0_0._btnfinishtalkOnClick(arg_37_0)
	arg_37_0:hide()

	local var_37_0 = DungeonMapModel.instance:getDialogId()

	arg_37_0:finishElement(var_37_0)
	DungeonMapModel.instance:clearDialogId()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0.onDialogueInfoChange(arg_38_0, arg_38_1)
	if arg_38_1 == arg_38_0.dialogueId then
		arg_38_0:refreshDialogueUI()
	end
end

function var_0_0.onCloseViewFinishCall(arg_39_0, arg_39_1)
	if arg_39_1 == ViewName.DialogueView and arg_39_0.isFinish then
		arg_39_0:refreshUI()
	end
end

function var_0_0.beforeJump(arg_40_0)
	arg_40_0:hide()
end

function var_0_0.onClose(arg_41_0)
	return
end

function var_0_0.onDestroyView(arg_42_0)
	arg_42_0.rootClick:RemoveClickListener()
end

return var_0_0
