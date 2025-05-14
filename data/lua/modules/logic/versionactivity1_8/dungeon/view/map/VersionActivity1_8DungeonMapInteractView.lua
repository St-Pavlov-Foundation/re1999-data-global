module("modules.logic.versionactivity1_8.dungeon.view.map.VersionActivity1_8DungeonMapInteractView", package.seeall)

local var_0_0 = class("VersionActivity1_8DungeonMapInteractView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gointeractiveroot = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root")
	arg_1_0.rootClick = gohelper.findChildClickWithDefaultAudio(arg_1_0._gointeractiveroot, "close_block")
	arg_1_0._gointeractitem = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/#btn_close")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/#go_title/#txt_title")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_scrollview/viewport/#txt_desc")
	arg_1_0._godesc = arg_1_0._txtdesc.gameObject
	arg_1_0._gochat = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat")
	arg_1_0._gochatusericon = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat/#go_scrollview/viewport/content/usericon")
	arg_1_0._txtchatname = gohelper.findChildText(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat/#go_scrollview/viewport/content/name")
	arg_1_0._txtchatdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/desc_container/#go_chat/#go_scrollview/viewport/content/info")
	arg_1_0._gorewardcontainer = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/reward_container")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/reward_container/#go_rewardContent")
	arg_1_0._goactivityrewarditem = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/reward_container/#go_rewardContent/#go_activityrewarditem")
	arg_1_0._gonone = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_none")
	arg_1_0._btnnone = gohelper.findButtonWithAudio(arg_1_0._gonone)
	arg_1_0._txtnone = gohelper.findChildText(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_none/#txt_none")
	arg_1_0._gofight = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_fight")
	arg_1_0._btnfight = gohelper.findButtonWithAudio(arg_1_0._gofight)
	arg_1_0._txtfight = gohelper.findChildText(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_fight/#txt_fight")
	arg_1_0._txtfighten = gohelper.findChildText(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_fight/en")
	arg_1_0._godispatch = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dispatch")
	arg_1_0._btndispatch = gohelper.findButtonWithAudio(arg_1_0._godispatch)
	arg_1_0._txtdispatch = gohelper.findChildText(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dispatch/#txt_dispatch")
	arg_1_0._txtdispatchen = gohelper.findChildText(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dispatch/en")
	arg_1_0._godialogue = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dialogue")
	arg_1_0._gonext = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dialogue/#go_next")
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dialogue/#go_next/#btn_next")
	arg_1_0._gooptions = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dialogue/#go_options")
	arg_1_0._gotalkitem = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dialogue/#go_options/#go_talkitem")

	gohelper.setActive(arg_1_0._gotalkitem, false)

	arg_1_0._gofinishtalk = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dialogue/#go_finishtalk")
	arg_1_0._btnfinishtalk = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_interactive_root/#go_interactitem/rotate/option_container/#go_dialogue/#go_finishtalk/#btn_finishtalk")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.rootClick:AddClickListener(arg_2_0.onClickRoot, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.onClickRoot, arg_2_0)
	arg_2_0._btnnone:AddClickListener(arg_2_0._onClickNoneBtn, arg_2_0)
	arg_2_0._btnfight:AddClickListener(arg_2_0._onClickFightBtn, arg_2_0)
	arg_2_0._btndispatch:AddClickListener(arg_2_0._onClickDispatchBtn, arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
	arg_2_0._btnfinishtalk:AddClickListener(arg_2_0._btnfinishtalkOnClick, arg_2_0)
	arg_2_0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, arg_2_0.onClickRoot, arg_2_0)
	arg_2_0:addEventCb(DialogueController.instance, DialogueEvent.OnDialogueInfoChange, arg_2_0.onDialogueInfoChange, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, arg_2_0.showInteractUI, arg_2_0)
	arg_2_0:addEventCb(DispatchController.instance, DispatchEvent.AddDispatchInfo, arg_2_0.onDispatchInfoChange, arg_2_0)
	arg_2_0:addEventCb(DispatchController.instance, DispatchEvent.RemoveDispatchInfo, arg_2_0.onDispatchInfoChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.rootClick:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnnone:RemoveClickListener()
	arg_3_0._btnfight:RemoveClickListener()
	arg_3_0._btndispatch:RemoveClickListener()
	arg_3_0._btnnext:RemoveClickListener()
	arg_3_0._btnfinishtalk:RemoveClickListener()

	for iter_3_0, iter_3_1 in pairs(arg_3_0._optionBtnList) do
		iter_3_1[2]:RemoveClickListener()
	end

	arg_3_0:removeEventCb(JumpController.instance, JumpEvent.BeforeJump, arg_3_0.onClickRoot, arg_3_0)
	arg_3_0:removeEventCb(DialogueController.instance, DialogueEvent.OnDialogueInfoChange, arg_3_0.onDialogueInfoChange, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, arg_3_0.showInteractUI, arg_3_0)
	arg_3_0:removeEventCb(DispatchController.instance, DispatchEvent.AddDispatchInfo, arg_3_0.onDispatchInfoChange, arg_3_0)
	arg_3_0:removeEventCb(DispatchController.instance, DispatchEvent.RemoveDispatchInfo, arg_3_0.onDispatchInfoChange, arg_3_0)
end

function var_0_0.onClickRoot(arg_4_0)
	arg_4_0:hide()
end

function var_0_0._onClickNoneBtn(arg_5_0)
	arg_5_0:hide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
	arg_5_0:finishElement()
end

function var_0_0._onClickFightBtn(arg_6_0)
	arg_6_0:hide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)

	if arg_6_0.isFinish then
		arg_6_0:finishElement()

		return
	end

	local var_6_0 = tonumber(arg_6_0._config.param)

	DungeonModel.instance.curLookEpisodeId = var_6_0

	local var_6_1 = DungeonConfig.instance:getEpisodeCO(var_6_0)

	if not var_6_1 then
		logError("episode config not exist , episodeId : " .. tostring(var_6_0))

		return
	end

	VersionActivity1_8DungeonModel.instance:setLastEpisodeId(arg_6_0.activityDungeonMo.episodeId)
	DungeonFightController.instance:enterFight(var_6_1.chapterId, var_6_0)
end

function var_0_0._onClickDispatchBtn(arg_7_0)
	if arg_7_0.isFinish then
		arg_7_0:hide()
		arg_7_0:finishElement()
	else
		local var_7_0 = VersionActivity1_8Enum.ActivityId.Dungeon
		local var_7_1 = arg_7_0._config.id
		local var_7_2 = tonumber(arg_7_0._config.param)

		DispatchController.instance:openDispatchView(var_7_0, var_7_1, var_7_2)
	end
end

function var_0_0.finishElement(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._config.id
	local var_8_1 = Activity157Model.instance:getActId()
	local var_8_2 = Activity157Config.instance:getMissionIdByElementId(var_8_1, var_8_0)
	local var_8_3 = var_8_2 and Activity157Config.instance:getAct157MissionStoryId(var_8_1, var_8_2)

	if var_8_3 and var_8_3 ~= 0 then
		StoryController.instance:playStory(var_8_3, nil, function()
			VersionActivity1_8DungeonModel.instance:setIsNotShowNewElement(true)
			arg_8_0:requestsFinishElement(var_8_0, arg_8_1)
		end)
	else
		arg_8_0:requestsFinishElement(var_8_0, arg_8_1)
	end
end

function var_0_0.requestsFinishElement(arg_10_0, arg_10_1, arg_10_2)
	DungeonRpc.instance:sendMapElementRequest(arg_10_1, arg_10_2, arg_10_0.updateAct157Info, arg_10_0)
end

function var_0_0.updateAct157Info(arg_11_0)
	Activity157Controller.instance:getAct157ActInfo()
end

function var_0_0._btnnextOnClick(arg_12_0)
	arg_12_0:_playNextSectionOrDialog()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._playNextSectionOrDialog(arg_13_0)
	if #arg_13_0._sectionList >= arg_13_0._dialogIndex then
		arg_13_0:_playNextDialog()

		return
	end

	local var_13_0 = table.remove(arg_13_0._sectionStack)

	if not var_13_0 then
		return
	end

	arg_13_0:_playSection(var_13_0[1], var_13_0[2])
end

function var_0_0._btnfinishtalkOnClick(arg_14_0)
	arg_14_0:hide()

	local var_14_0 = DungeonMapModel.instance:getDialogId()

	arg_14_0:finishElement(var_14_0)
	DungeonMapModel.instance:clearDialogId()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0.onDialogueInfoChange(arg_15_0, arg_15_1)
	if arg_15_1 == arg_15_0.dialogueId then
		arg_15_0:refreshDialogueUI()
	end
end

function var_0_0.showInteractUI(arg_16_0, arg_16_1)
	if arg_16_0._show then
		return
	end

	DungeonMapModel.instance:clearDialog()

	arg_16_0._mapElement = arg_16_0.mapSceneElementsView:getElementComp(arg_16_1), VersionActivity1_8DungeonModel.instance:setShowInteractView(true)
	arg_16_0._config = arg_16_0._mapElement._config
	arg_16_0._elementGo = arg_16_0._mapElement._go
	arg_16_0.isFinish = false

	arg_16_0:show()
	arg_16_0:refreshUI()
end

function var_0_0.onDispatchInfoChange(arg_17_0, arg_17_1)
	arg_17_0:refreshDispatchUI()
end

function var_0_0._editableInitView(arg_18_0)
	arg_18_0.rewardItemList = {}
	arg_18_0._optionBtnList = arg_18_0:getUserDataTb_()
	arg_18_0.mapSceneElementsView = arg_18_0.viewContainer.mapSceneElements
	arg_18_0.type2RefreshFunc = {
		[DungeonEnum.ElementType.None] = arg_18_0.refreshNoneUI,
		[DungeonEnum.ElementType.Fight] = arg_18_0.refreshFightUI,
		[DungeonEnum.ElementType.Story] = arg_18_0.refreshDialogueUI,
		[DungeonEnum.ElementType.Dispatch] = arg_18_0.refreshDispatchUI
	}
	arg_18_0.type2GoDict = {
		[DungeonEnum.ElementType.None] = arg_18_0._gonone,
		[DungeonEnum.ElementType.Fight] = arg_18_0._gofight,
		[DungeonEnum.ElementType.Story] = arg_18_0._godialogue,
		[DungeonEnum.ElementType.Dispatch] = arg_18_0._godispatch
	}

	gohelper.setActive(arg_18_0._gointeractitem, false)
	gohelper.setActive(arg_18_0._gointeractiveroot, false)
	gohelper.setActive(arg_18_0._goactivityrewarditem, false)
	TaskDispatcher.runRepeat(arg_18_0.everySecondCall, arg_18_0, 1)
end

function var_0_0.onUpdateParam(arg_19_0)
	return
end

function var_0_0.onOpen(arg_20_0)
	return
end

function var_0_0.refreshUI(arg_21_0)
	for iter_21_0, iter_21_1 in pairs(arg_21_0.type2GoDict) do
		gohelper.setActive(iter_21_1, iter_21_0 == arg_21_0._config.type)
	end

	arg_21_0._txttitle.text = arg_21_0._config.title

	local var_21_0 = arg_21_0.type2RefreshFunc[arg_21_0._config.type]

	if var_21_0 then
		var_21_0(arg_21_0)
	else
		logError("element type undefined!")
	end

	arg_21_0:refreshRewards()
end

function var_0_0.setIsChat(arg_22_0, arg_22_1)
	gohelper.setActive(arg_22_0._godesc, not arg_22_1)
	gohelper.setActive(arg_22_0._gochat, arg_22_1)
end

function var_0_0.refreshNoneUI(arg_23_0)
	arg_23_0._txtnone.text = arg_23_0._config.acceptText
	arg_23_0._txtdesc.text = arg_23_0._config.desc

	arg_23_0:setIsChat(false)
end

function var_0_0.refreshFightUI(arg_24_0)
	local var_24_0 = tonumber(arg_24_0._config.param)

	arg_24_0.isFinish = DungeonModel.instance:hasPassLevel(var_24_0)

	if arg_24_0.isFinish then
		arg_24_0:setFinishText()

		arg_24_0._txtfight.text = luaLang("p_dungeonmapinteractiveitem_win")
		arg_24_0._txtfighten.text = luaLang("fixed_en_finish")
	else
		arg_24_0._txtfight.text = arg_24_0._config.acceptText
		arg_24_0._txtdesc.text = arg_24_0._config.desc
	end

	arg_24_0:setIsChat(false)
end

function var_0_0.refreshDialogueUI(arg_25_0)
	arg_25_0._sectionStack = {}
	arg_25_0._dialogId = tonumber(arg_25_0._config.param)

	arg_25_0:_playSection(0)
end

function var_0_0._playSection(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0:_setSectionData(arg_26_1, arg_26_2)
	arg_26_0:_playNextDialog()
end

function var_0_0._setSectionData(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0._sectionList = DungeonConfig.instance:getDialog(arg_27_0._dialogId, arg_27_1)
	arg_27_0._dialogIndex = arg_27_2 or 1
	arg_27_0._sectionId = arg_27_1
end

function var_0_0._playNextDialog(arg_28_0)
	local var_28_0 = arg_28_0._sectionList[arg_28_0._dialogIndex]

	arg_28_0._dialogIndex = arg_28_0._dialogIndex + 1

	if var_28_0.type == "dialog" then
		arg_28_0:_showDialog("dialog", var_28_0.content, var_28_0.speaker, var_28_0.audio)
	end

	if #arg_28_0._sectionStack > 0 and #arg_28_0._sectionList < arg_28_0._dialogIndex then
		local var_28_1 = table.remove(arg_28_0._sectionStack)

		arg_28_0:_setSectionData(var_28_1[1], var_28_1[2])
	end

	local var_28_2 = false
	local var_28_3 = arg_28_0._sectionList[arg_28_0._dialogIndex]

	if var_28_3 and var_28_3.type == "options" then
		arg_28_0._dialogIndex = arg_28_0._dialogIndex + 1

		for iter_28_0, iter_28_1 in pairs(arg_28_0._optionBtnList) do
			gohelper.setActive(iter_28_1[1], false)
		end

		local var_28_4 = string.split(var_28_3.content, "#")
		local var_28_5 = string.split(var_28_3.param, "#")

		for iter_28_2, iter_28_3 in ipairs(var_28_4) do
			arg_28_0:_addDialogOption(iter_28_2, var_28_5[iter_28_2], iter_28_3)
		end

		var_28_2 = true
	end

	local var_28_6 = not var_28_3 or var_28_3.type ~= "dialogend"

	arg_28_0:_refreshDialogBtnState(var_28_2, var_28_6)
end

function var_0_0._showDialog(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	DungeonMapModel.instance:addDialog(arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	gohelper.setActive(arg_29_0._gochatusericon, not arg_29_3)

	local var_29_0 = not string.nilorempty(arg_29_3)

	arg_29_0._txtchatname.text = var_29_0 and arg_29_3 .. ":" or ""
	arg_29_0._txtchatdesc.text = arg_29_2

	arg_29_0:setIsChat(true)
end

function var_0_0._addDialogOption(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = arg_30_0._optionBtnList[arg_30_1] and arg_30_0._optionBtnList[arg_30_1][1] or gohelper.cloneInPlace(arg_30_0._gotalkitem)

	gohelper.setActive(var_30_0, true)

	gohelper.findChildText(var_30_0, "txt_talkitem").text = arg_30_3

	local var_30_1 = gohelper.findChildButtonWithAudio(var_30_0, "btn_talkitem")

	var_30_1:AddClickListener(arg_30_0._onOptionClick, arg_30_0, {
		arg_30_2,
		arg_30_3
	})

	if not arg_30_0._optionBtnList[arg_30_1] then
		local var_30_2 = arg_30_0:getUserDataTb_()

		var_30_2[1] = var_30_0
		var_30_2[2] = var_30_1
		arg_30_0._optionBtnList[arg_30_1] = var_30_2
	end
end

function var_0_0._onOptionClick(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_1[1]
	local var_31_1 = string.format("<color=#c95318>\"%s\"</color>", arg_31_1[2])

	arg_31_0:_showDialog("option", var_31_1)

	if #arg_31_0._sectionList >= arg_31_0._dialogIndex then
		table.insert(arg_31_0._sectionStack, {
			arg_31_0._sectionId,
			arg_31_0._dialogIndex
		})
	end

	DungeonMapModel.instance:addDialogId(var_31_0)
	arg_31_0:_playSection(var_31_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function var_0_0._refreshDialogBtnState(arg_32_0, arg_32_1, arg_32_2)
	gohelper.setActive(arg_32_0._gooptions, arg_32_1)

	if arg_32_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)
		gohelper.setActive(arg_32_0._gonext, false)
		gohelper.setActive(arg_32_0._gofinishtalk, false)

		arg_32_0._curBtnGo = arg_32_0._gooptions

		return
	end

	arg_32_2 = arg_32_2 and (#arg_32_0._sectionStack > 0 or #arg_32_0._sectionList >= arg_32_0._dialogIndex)

	if arg_32_2 then
		arg_32_0._curBtnGo = arg_32_0._gonext

		gohelper.setActive(arg_32_0._gonext, arg_32_2)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continueappear)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)

		arg_32_0._curBtnGo = arg_32_0._gofinishtalk
	end

	gohelper.setActive(arg_32_0._gonext, arg_32_2)
	gohelper.setActive(arg_32_0._gofinishtalk, not arg_32_2)
end

function var_0_0.refreshDispatchUI(arg_33_0)
	local var_33_0 = arg_33_0._config.id
	local var_33_1 = tonumber(arg_33_0._config.param)
	local var_33_2 = DispatchModel.instance:getDispatchMo(var_33_0, var_33_1)

	arg_33_0.isFinish = var_33_2 and var_33_2:isFinish()

	if arg_33_0.isFinish then
		arg_33_0._txtdispatch.text = luaLang("p_dungeonmapinteractiveitem_finishtask")
		arg_33_0._txtdispatchen.text = luaLang("fixed_en_finish")

		arg_33_0:setFinishText()
	else
		arg_33_0._txtdesc.text = arg_33_0._config.desc

		if var_33_2 and var_33_2:isRunning() then
			arg_33_0._txtdispatch.text = arg_33_0._config.dispatchingText
		else
			arg_33_0._txtdispatch.text = arg_33_0._config.acceptText
		end
	end

	arg_33_0:setIsChat(false)
end

function var_0_0.everySecondCall(arg_34_0)
	if not arg_34_0._show then
		return
	end

	if arg_34_0._config and arg_34_0._config.type == DungeonEnum.ElementType.Dispatch then
		arg_34_0:refreshDispatchUI()
	end
end

function var_0_0.setFinishText(arg_35_0)
	local var_35_0 = arg_35_0._config.finishText

	if string.nilorempty(var_35_0) then
		arg_35_0._txtdesc.text = arg_35_0._config.desc
	else
		arg_35_0._txtdesc.text = var_35_0
	end
end

function var_0_0.refreshRewards(arg_36_0)
	local var_36_0 = DungeonModel.instance:getMapElementReward(arg_36_0._config.id)

	if string.nilorempty(var_36_0) then
		gohelper.setActive(arg_36_0._gorewardcontainer, false)

		return
	end

	gohelper.setActive(arg_36_0._gorewardcontainer, true)

	local var_36_1 = GameUtil.splitString2(var_36_0, true)

	for iter_36_0, iter_36_1 in ipairs(var_36_1) do
		local var_36_2 = arg_36_0.rewardItemList[iter_36_0]

		if not var_36_2 then
			var_36_2 = arg_36_0:createRewardItem()

			table.insert(arg_36_0.rewardItemList, var_36_2)
		end

		gohelper.setActive(var_36_2.go, true)
		var_36_2.icon:isShowCount(false)
		var_36_2.icon:setMOValue(iter_36_1[1], iter_36_1[2], iter_36_1[3])

		var_36_2.txtCount.text = iter_36_1[3]
	end

	for iter_36_2 = #var_36_1 + 1, #arg_36_0.rewardItemList do
		gohelper.setActive(arg_36_0.rewardItemList[iter_36_2].go, false)
	end
end

function var_0_0.createRewardItem(arg_37_0)
	local var_37_0 = arg_37_0:getUserDataTb_()

	var_37_0.go = gohelper.cloneInPlace(arg_37_0._goactivityrewarditem)
	var_37_0.goIcon = gohelper.findChild(var_37_0.go, "itemicon")
	var_37_0.goCount = gohelper.findChild(var_37_0.go, "countbg")
	var_37_0.txtCount = gohelper.findChildText(var_37_0.go, "countbg/count")
	var_37_0.goRare = gohelper.findChild(var_37_0.go, "rare")
	var_37_0.icon = IconMgr.instance:getCommonPropItemIcon(var_37_0.goIcon)

	gohelper.setActive(var_37_0.goRare, false)

	return var_37_0
end

function var_0_0.show(arg_38_0)
	if arg_38_0._show then
		return
	end

	arg_38_0._show = true

	gohelper.setActive(arg_38_0._gointeractitem, true)
	gohelper.setActive(arg_38_0._gointeractiveroot, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
end

function var_0_0.hide(arg_39_0)
	if not arg_39_0._show then
		return
	end

	VersionActivity1_8DungeonModel.instance:setShowInteractView(nil)

	arg_39_0._show = false

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnclose)
	gohelper.setActive(arg_39_0._gointeractitem, false)
	gohelper.setActive(arg_39_0._gointeractiveroot, false)
	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.OnHideInteractUI)
end

function var_0_0.onClose(arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0.everySecondCall, arg_40_0)
end

function var_0_0.onDestroyView(arg_41_0)
	arg_41_0._optionBtnList = nil
end

return var_0_0
