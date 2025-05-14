module("modules.logic.rouge.map.view.choice.RougeMapChoiceView", package.seeall)

local var_0_0 = class("RougeMapChoiceView", RougeMapChoiceBaseView)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "all_bg/#simage_FullBG")
	arg_1_0._simageEpisodeBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "all_bg/#simage_EpisodeBG")
	arg_1_0._simageFrameBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "all_bg/#simage_FrameBG")

	arg_1_0._simageFullBG:LoadImage("singlebg/rouge/episode/rouge_episode_fullbg.png")
	arg_1_0._simageFrameBG:LoadImage("singlebg/rouge/rouge_illustration_framebg.png")
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onChoiceEventChange, arg_1_0.onChoiceEventChange, arg_1_0)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onClearInteract, arg_1_0.onClearInteract, arg_1_0)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onPopViewDone, arg_1_0.onPopViewDone, arg_1_0)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onReceiveChoiceEvent, arg_1_0.onReceiveChoiceEvent, arg_1_0)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onBeforeActorMoveToEnd, arg_1_0.onBeforeActorMoveToEnd, arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.onBeforeActorMoveToEnd(arg_2_0)
	arg_2_0.beforeChangeMap = true
end

function var_0_0.onReceiveChoiceEvent(arg_3_0)
	if RougeMapModel.instance:isInteractiving() then
		logNormal("wait interact")

		arg_3_0.waitInteract = true

		return
	end

	if RougePopController.instance:hadPopView() then
		logNormal("wait pop view")

		arg_3_0.waitInteract = true
	end

	arg_3_0.waitInteract = nil

	arg_3_0:playSelectedDialogue()
end

function var_0_0.onClearInteract(arg_4_0)
	if not arg_4_0.waitInteract then
		return
	end

	arg_4_0:playSelectedDialogue()
end

function var_0_0.onPopViewDone(arg_5_0)
	if not arg_5_0.waitInteract then
		return
	end

	arg_5_0:playSelectedDialogue()
end

function var_0_0.playSelectedDialogue(arg_6_0)
	arg_6_0:playChoiceHideAnim()

	local var_6_0 = RougeMapModel.instance:getCurChoiceId()
	local var_6_1 = var_6_0 and lua_rouge_choice.configDict[var_6_0]
	local var_6_2 = var_6_1 and var_6_1.selectedDesc

	if string.nilorempty(var_6_2) then
		arg_6_0:triggerEventHandle()
	else
		arg_6_0:startPlayDialogue(var_6_2, arg_6_0.onSelectedDescPlayDone, arg_6_0)
	end
end

function var_0_0.onSelectedDescPlayDone(arg_7_0)
	arg_7_0:changeState(RougeMapEnum.ChoiceViewState.Finish)
end

function var_0_0.triggerEventHandle(arg_8_0)
	local var_8_0 = RougeMapModel.instance:getCurNode()

	RougeMapChoiceEventHelper.triggerEventHandleOnChoiceView(var_8_0)
end

function var_0_0.onClickBlockOnFinishState(arg_9_0)
	arg_9_0:triggerEventHandle()
end

function var_0_0.onChoiceEventChange(arg_10_0, arg_10_1)
	if arg_10_0.beforeChangeMap then
		arg_10_0:closeThis()

		return
	end

	if arg_10_1.nodeId ~= arg_10_0.nodeMo.nodeId then
		return
	end

	local var_10_0 = arg_10_1.eventId

	if var_10_0 == arg_10_0.curEventId then
		return
	end

	arg_10_0.curEventId = var_10_0
	arg_10_0.eventCo = RougeMapConfig.instance:getRougeEvent(arg_10_0.curEventId)
	arg_10_0.choiceEventCo = lua_rouge_choice_event.configDict[arg_10_0.curEventId]

	arg_10_0:refreshUI()

	local var_10_1 = arg_10_0.choiceEventCo.desc

	arg_10_0:startPlayDialogue(var_10_1, arg_10_0.onChangeDialogueDone, arg_10_0)
end

function var_0_0.onChangeDialogueDone(arg_11_0)
	arg_11_0:changeState(RougeMapEnum.ChoiceViewState.WaitSelect)
	arg_11_0:refreshChoice()
	arg_11_0:playChoiceShowAnim()
end

function var_0_0.initViewData(arg_12_0)
	arg_12_0.nodeMo = arg_12_0.viewParam
	arg_12_0.curEventId = arg_12_0.nodeMo.eventId
	arg_12_0.eventCo = RougeMapConfig.instance:getRougeEvent(arg_12_0.curEventId)
	arg_12_0.choiceEventCo = lua_rouge_choice_event.configDict[arg_12_0.curEventId]
end

function var_0_0.onOpen(arg_13_0)
	var_0_0.super.onOpen(arg_13_0)
	arg_13_0:initViewData()
	arg_13_0:refreshUI()

	local var_13_0 = arg_13_0.choiceEventCo.desc

	arg_13_0:startPlayDialogue(var_13_0, arg_13_0.onEnterDialogueDone, arg_13_0)
end

function var_0_0.refreshUI(arg_14_0)
	arg_14_0._simageEpisodeBG:LoadImage(string.format("singlebg/rouge/episode/%s.png", arg_14_0.choiceEventCo.image))

	arg_14_0._txtName.text = arg_14_0.choiceEventCo.title
	arg_14_0._txtNameEn.text = ""
end

function var_0_0.onEnterDialogueDone(arg_15_0)
	arg_15_0:changeState(RougeMapEnum.ChoiceViewState.WaitSelect)
	arg_15_0:refreshChoice()
	arg_15_0:playChoiceShowAnim()
end

function var_0_0.refreshChoice(arg_16_0)
	AudioMgr.instance:trigger(AudioEnum.UI.ChoiceViewChoiceOpen)
	gohelper.setActive(arg_16_0.goRight, true)
	gohelper.setActive(arg_16_0.goLeft, true)

	local var_16_0 = arg_16_0.nodeMo.eventMo:getChoiceIdList()

	if not var_16_0 then
		logError("choiceIdList is nil, curNode : " .. tostring(arg_16_0.nodeMo))

		return
	end

	local var_16_1 = #var_16_0

	arg_16_0.posList = RougeMapEnum.ChoiceItemPos[var_16_1]

	RougeMapHelper.loadItemWithCustomUpdateFunc(arg_16_0.goChoiceItem, RougeMapNodeChoiceItem, var_16_0, arg_16_0.choiceItemList, arg_16_0.updateItem, arg_16_0)
end

function var_0_0.updateItem(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_1:update(arg_17_3, arg_17_0.posList[arg_17_2], arg_17_0.nodeMo)
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0._simageFullBG:UnLoadImage()
	arg_18_0._simageEpisodeBG:UnLoadImage()
	arg_18_0._simageFrameBG:UnLoadImage()
	var_0_0.super.onDestroyView(arg_18_0)
end

return var_0_0
