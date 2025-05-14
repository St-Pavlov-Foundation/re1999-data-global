module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogView", package.seeall)

local var_0_0 = class("AergusiDialogView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._simagechatbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_chatbg")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_righttop")
	arg_1_0._btnskip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_righttop/#btn_skip")
	arg_1_0._imageskip = gohelper.findChildImage(arg_1_0.viewGO, "#go_righttop/#btn_skip/#image_skip")
	arg_1_0._btntimes = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_righttop/#btn_times")
	arg_1_0._txttimes = gohelper.findChildText(arg_1_0.viewGO, "#go_righttop/#btn_times/#txt_times")
	arg_1_0._gotimelight = gohelper.findChild(arg_1_0.viewGO, "#go_righttop/#btn_times/light")
	arg_1_0._gotimegrey = gohelper.findChild(arg_1_0.viewGO, "#go_righttop/#btn_times/grey")
	arg_1_0._btnclue = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_clue")
	arg_1_0._goeyegray = gohelper.findChild(arg_1_0.viewGO, "#btn_clue/eye_grey")
	arg_1_0._goeyelight = gohelper.findChild(arg_1_0.viewGO, "#btn_clue/eye_light")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnskip:AddClickListener(arg_2_0._btnskipOnClick, arg_2_0)
	arg_2_0._btntimes:AddClickListener(arg_2_0._btntimesOnClick, arg_2_0)
	arg_2_0._btnclue:AddClickListener(arg_2_0._btnclueOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnskip:RemoveClickListener()
	arg_3_0._btntimes:RemoveClickListener()
	arg_3_0._btnclue:RemoveClickListener()
end

function var_0_0._btnskipOnClick(arg_4_0)
	AergusiController.instance:dispatchEvent(AergusiEvent.EvidenceFinished)
	TaskDispatcher.runDelay(arg_4_0.closeThis, arg_4_0, 1)
end

function var_0_0._btntimesOnClick(arg_5_0)
	if AergusiDialogModel.instance:getShowingGroupState() then
		return
	end

	local var_5_0 = AergusiDialogModel.instance:getCurDialogGroup()

	if not (AergusiConfig.instance:getEvidenceConfig(var_5_0).dialogGroupType == AergusiEnum.DialogGroupType.Interact) then
		return
	end

	if not AergusiDialogModel.instance:getNextPromptOperate(false) then
		local var_5_1 = AergusiDialogModel.instance:getLastPromptOperate(false)

		AergusiController.instance:dispatchEvent(AergusiEvent.OnClickShowResultTip, var_5_1)

		return
	end

	local var_5_2 = VersionActivity2_1Enum.ActivityId.Aergusi
	local var_5_3 = arg_5_0.viewParam.episodeId
	local var_5_4 = AergusiEnum.OperationType.Tip
	local var_5_5 = ""

	Activity163Rpc.instance:sendAct163EvidenceOperationRequest(var_5_2, var_5_3, var_5_4, var_5_5, arg_5_0._onShowTipFinished, arg_5_0)
end

function var_0_0._onShowTipFinished(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_2 ~= 0 then
		return
	end

	local var_6_0 = AergusiDialogModel.instance:getNextPromptOperate(false)

	AergusiController.instance:dispatchEvent(AergusiEvent.OnClickShowResultTip, var_6_0)
	AergusiDialogModel.instance:addPromptOperate(var_6_0, false)
end

function var_0_0._btnclueOnClick(arg_7_0)
	local var_7_0, var_7_1 = AergusiDialogModel.instance:getCurDialogProcess()
	local var_7_2 = AergusiConfig.instance:getDialogConfig(var_7_0, var_7_1)

	if var_7_2.nextStep == 0 and var_7_2.conditions ~= "" and string.splitToNumber(var_7_2.condition, "#")[1] == AergusiEnum.OperationType.Submit then
		AergusiController.instance:dispatchEvent(AergusiEvent.OnClickEpisodeClueBtn)

		return
	end

	local var_7_3 = AergusiDialogModel.instance:getShowingGroupState()
	local var_7_4 = AergusiConfig.instance:getEvidenceConfig(var_7_0).dialogGroupType == AergusiEnum.DialogGroupType.Interact
	local var_7_5 = {
		episodeId = arg_7_0.viewParam.episodeId,
		groupId = var_7_0,
		stepId = var_7_1,
		couldPrompt = not var_7_3 and var_7_4
	}

	AergusiController.instance:openAergusiClueView(var_7_5)
end

function var_0_0._editableInitView(arg_8_0)
	AergusiDialogModel.instance:setUnlockAutoShow(false)
	AergusiDialogModel.instance:clearDialogProcess()
	arg_8_0:_addEvents()

	arg_8_0._startServerTime = ServerTime.now()
end

function var_0_0._refreshView(arg_9_0)
	local var_9_0 = AergusiModel.instance:getEpisodeInfo(arg_9_0.viewParam.episodeId)

	gohelper.setActive(arg_9_0._btnskip.gameObject, var_9_0.passEvidence)

	local var_9_1 = AergusiDialogModel.instance:getLeftPromptTimes()

	arg_9_0._txttimes.text = var_9_1

	local var_9_2 = AergusiModel.instance:getEpisodeClueConfigs(arg_9_0.viewParam.episodeId, true)
	local var_9_3 = AergusiModel.instance:hasClueNotRead(var_9_2)

	gohelper.setActive(arg_9_0._goeyelight, var_9_3)
	gohelper.setActive(arg_9_0._goeyegray, not var_9_3)

	local var_9_4 = AergusiDialogModel.instance:getShowingGroupState()
	local var_9_5 = AergusiDialogModel.instance:getCurDialogGroup()
	local var_9_6 = AergusiConfig.instance:getEvidenceConfig(var_9_5).dialogGroupType == AergusiEnum.DialogGroupType.Interact

	gohelper.setActive(arg_9_0._gotimegrey, var_9_4 or not var_9_6)
	gohelper.setActive(arg_9_0._gotimelight, not var_9_4 and var_9_6)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:_refreshView()

	local var_10_0 = AergusiModel.instance:isEpisodePassed(arg_10_0.viewParam.episodeId)
	local var_10_1 = AergusiModel.instance:getUnlockAutoTipProcess()

	if not var_10_0 and var_10_1[1] ~= 0 then
		AergusiDialogModel.instance:setUnlockAutoShow(true)
	end
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0._addEvents(arg_12_0)
	arg_12_0:addEventCb(AergusiController.instance, AergusiEvent.EvidenceError, arg_12_0._onEvidenceError, arg_12_0)
	arg_12_0:addEventCb(AergusiController.instance, AergusiEvent.StartOperation, arg_12_0._refreshView, arg_12_0)
	arg_12_0:addEventCb(AergusiController.instance, AergusiEvent.OnStartDialogNextStep, arg_12_0._refreshView, arg_12_0)
	arg_12_0:addEventCb(AergusiController.instance, AergusiEvent.OnShowDialogGroupFinished, arg_12_0._refreshView, arg_12_0)
end

function var_0_0._removeEvents(arg_13_0)
	arg_13_0:removeEventCb(AergusiController.instance, AergusiEvent.EvidenceError, arg_13_0._onEvidenceError, arg_13_0)
	arg_13_0:removeEventCb(AergusiController.instance, AergusiEvent.StartOperation, arg_13_0._refreshView, arg_13_0)
	arg_13_0:removeEventCb(AergusiController.instance, AergusiEvent.OnStartDialogNextStep, arg_13_0._refreshView, arg_13_0)
	arg_13_0:removeEventCb(AergusiController.instance, AergusiEvent.OnShowDialogGroupFinished, arg_13_0._refreshView, arg_13_0)
end

function var_0_0._onEvidenceError(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = 0

	if AergusiDialogModel.instance:getLeftErrorTimes() > 0 then
		var_14_0 = AergusiConfig.instance:getEvidenceConfig(arg_14_1.id).errorTip
	else
		var_14_0 = AergusiConfig.instance:getEpisodeConfig(nil, arg_14_0.viewParam.episodeId).failedId
	end

	local var_14_1 = {
		bubbleId = var_14_0,
		callback = arg_14_0._onShowBubbleFinished,
		callbackObj = arg_14_0
	}

	AergusiController.instance:dispatchEvent(AergusiEvent.OnStartErrorBubbleDialog, var_14_1)
	arg_14_0:_refreshView()
end

function var_0_0._onShowBubbleFinished(arg_15_0)
	if AergusiDialogModel.instance:getLeftErrorTimes() <= 0 then
		local var_15_0 = {
			episodeId = arg_15_0.viewParam.episodeId
		}

		AergusiController.instance:openAergusiFailView(var_15_0)

		local var_15_1 = {}
		local var_15_2 = AergusiModel.instance.instance:getEpisodeClueConfigs(arg_15_0.viewParam.episodeId, true)

		for iter_15_0, iter_15_1 in pairs(var_15_2) do
			table.insert(var_15_1, iter_15_1.clueName)
		end

		StatController.instance:track(StatEnum.EventName.ExitArgusActivity, {
			[StatEnum.EventProperties.EpisodeId] = tostring(arg_15_0.viewParam.episodeId),
			[StatEnum.EventProperties.Result] = "Fail",
			[StatEnum.EventProperties.UseTime] = ServerTime.now() - arg_15_0._startServerTime,
			[StatEnum.EventProperties.GoalNum] = AergusiDialogModel.instance:getFinishedTargetGroupCount(),
			[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
			[StatEnum.EventProperties.HoldClueName] = var_15_1
		})
	end
end

function var_0_0.onDestroyView(arg_16_0)
	AergusiDialogModel.instance:setUnlockAutoShow(false)
	TaskDispatcher.cancelTask(arg_16_0.closeThis, arg_16_0)
	arg_16_0:_removeEvents()
end

return var_0_0
