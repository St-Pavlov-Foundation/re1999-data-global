module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogView", package.seeall)

slot0 = class("AergusiDialogView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._simagechatbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_chatbg")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "#go_righttop")
	slot0._btnskip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_righttop/#btn_skip")
	slot0._imageskip = gohelper.findChildImage(slot0.viewGO, "#go_righttop/#btn_skip/#image_skip")
	slot0._btntimes = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_righttop/#btn_times")
	slot0._txttimes = gohelper.findChildText(slot0.viewGO, "#go_righttop/#btn_times/#txt_times")
	slot0._gotimelight = gohelper.findChild(slot0.viewGO, "#go_righttop/#btn_times/light")
	slot0._gotimegrey = gohelper.findChild(slot0.viewGO, "#go_righttop/#btn_times/grey")
	slot0._btnclue = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_clue")
	slot0._goeyegray = gohelper.findChild(slot0.viewGO, "#btn_clue/eye_grey")
	slot0._goeyelight = gohelper.findChild(slot0.viewGO, "#btn_clue/eye_light")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnskip:AddClickListener(slot0._btnskipOnClick, slot0)
	slot0._btntimes:AddClickListener(slot0._btntimesOnClick, slot0)
	slot0._btnclue:AddClickListener(slot0._btnclueOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnskip:RemoveClickListener()
	slot0._btntimes:RemoveClickListener()
	slot0._btnclue:RemoveClickListener()
end

function slot0._btnskipOnClick(slot0)
	AergusiController.instance:dispatchEvent(AergusiEvent.EvidenceFinished)
	TaskDispatcher.runDelay(slot0.closeThis, slot0, 1)
end

function slot0._btntimesOnClick(slot0)
	if AergusiDialogModel.instance:getShowingGroupState() then
		return
	end

	if not (AergusiConfig.instance:getEvidenceConfig(AergusiDialogModel.instance:getCurDialogGroup()).dialogGroupType == AergusiEnum.DialogGroupType.Interact) then
		return
	end

	if not AergusiDialogModel.instance:getNextPromptOperate(false) then
		AergusiController.instance:dispatchEvent(AergusiEvent.OnClickShowResultTip, AergusiDialogModel.instance:getLastPromptOperate(false))

		return
	end

	Activity163Rpc.instance:sendAct163EvidenceOperationRequest(VersionActivity2_1Enum.ActivityId.Aergusi, slot0.viewParam.episodeId, AergusiEnum.OperationType.Tip, "", slot0._onShowTipFinished, slot0)
end

function slot0._onShowTipFinished(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	slot4 = AergusiDialogModel.instance:getNextPromptOperate(false)

	AergusiController.instance:dispatchEvent(AergusiEvent.OnClickShowResultTip, slot4)
	AergusiDialogModel.instance:addPromptOperate(slot4, false)
end

function slot0._btnclueOnClick(slot0)
	slot1, slot2 = AergusiDialogModel.instance:getCurDialogProcess()

	if AergusiConfig.instance:getDialogConfig(slot1, slot2).nextStep == 0 and slot3.conditions ~= "" and string.splitToNumber(slot3.condition, "#")[1] == AergusiEnum.OperationType.Submit then
		AergusiController.instance:dispatchEvent(AergusiEvent.OnClickEpisodeClueBtn)

		return
	end

	AergusiController.instance:openAergusiClueView({
		episodeId = slot0.viewParam.episodeId,
		groupId = slot1,
		stepId = slot2,
		couldPrompt = not AergusiDialogModel.instance:getShowingGroupState() and AergusiConfig.instance:getEvidenceConfig(slot1).dialogGroupType == AergusiEnum.DialogGroupType.Interact
	})
end

function slot0._editableInitView(slot0)
	AergusiDialogModel.instance:setUnlockAutoShow(false)
	AergusiDialogModel.instance:clearDialogProcess()
	slot0:_addEvents()

	slot0._startServerTime = ServerTime.now()
end

function slot0._refreshView(slot0)
	gohelper.setActive(slot0._btnskip.gameObject, AergusiModel.instance:getEpisodeInfo(slot0.viewParam.episodeId).passEvidence)

	slot0._txttimes.text = AergusiDialogModel.instance:getLeftPromptTimes()
	slot4 = AergusiModel.instance:hasClueNotRead(AergusiModel.instance:getEpisodeClueConfigs(slot0.viewParam.episodeId, true))

	gohelper.setActive(slot0._goeyelight, slot4)
	gohelper.setActive(slot0._goeyegray, not slot4)

	slot5 = AergusiDialogModel.instance:getShowingGroupState()
	slot7 = AergusiConfig.instance:getEvidenceConfig(AergusiDialogModel.instance:getCurDialogGroup()).dialogGroupType == AergusiEnum.DialogGroupType.Interact

	gohelper.setActive(slot0._gotimegrey, slot5 or not slot7)
	gohelper.setActive(slot0._gotimelight, not slot5 and slot7)
end

function slot0.onOpen(slot0)
	slot0:_refreshView()

	if not AergusiModel.instance:isEpisodePassed(slot0.viewParam.episodeId) and AergusiModel.instance:getUnlockAutoTipProcess()[1] ~= 0 then
		AergusiDialogModel.instance:setUnlockAutoShow(true)
	end
end

function slot0.onClose(slot0)
end

function slot0._addEvents(slot0)
	slot0:addEventCb(AergusiController.instance, AergusiEvent.EvidenceError, slot0._onEvidenceError, slot0)
	slot0:addEventCb(AergusiController.instance, AergusiEvent.StartOperation, slot0._refreshView, slot0)
	slot0:addEventCb(AergusiController.instance, AergusiEvent.OnStartDialogNextStep, slot0._refreshView, slot0)
	slot0:addEventCb(AergusiController.instance, AergusiEvent.OnShowDialogGroupFinished, slot0._refreshView, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(AergusiController.instance, AergusiEvent.EvidenceError, slot0._onEvidenceError, slot0)
	slot0:removeEventCb(AergusiController.instance, AergusiEvent.StartOperation, slot0._refreshView, slot0)
	slot0:removeEventCb(AergusiController.instance, AergusiEvent.OnStartDialogNextStep, slot0._refreshView, slot0)
	slot0:removeEventCb(AergusiController.instance, AergusiEvent.OnShowDialogGroupFinished, slot0._refreshView, slot0)
end

function slot0._onEvidenceError(slot0, slot1, slot2)
	slot3 = 0

	AergusiController.instance:dispatchEvent(AergusiEvent.OnStartErrorBubbleDialog, {
		bubbleId = (AergusiDialogModel.instance:getLeftErrorTimes() <= 0 or AergusiConfig.instance:getEvidenceConfig(slot1.id).errorTip) and AergusiConfig.instance:getEpisodeConfig(nil, slot0.viewParam.episodeId).failedId,
		callback = slot0._onShowBubbleFinished,
		callbackObj = slot0
	})
	slot0:_refreshView()
end

function slot0._onShowBubbleFinished(slot0)
	if AergusiDialogModel.instance:getLeftErrorTimes() <= 0 then
		AergusiController.instance:openAergusiFailView({
			episodeId = slot0.viewParam.episodeId
		})

		slot3 = {}
		slot8 = true

		for slot8, slot9 in pairs(AergusiModel.instance.instance:getEpisodeClueConfigs(slot0.viewParam.episodeId, slot8)) do
			table.insert(slot3, slot9.clueName)
		end

		StatController.instance:track(StatEnum.EventName.ExitArgusActivity, {
			[StatEnum.EventProperties.EpisodeId] = tostring(slot0.viewParam.episodeId),
			[StatEnum.EventProperties.Result] = "Fail",
			[StatEnum.EventProperties.UseTime] = ServerTime.now() - slot0._startServerTime,
			[StatEnum.EventProperties.GoalNum] = AergusiDialogModel.instance:getFinishedTargetGroupCount(),
			[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
			[StatEnum.EventProperties.HoldClueName] = slot3
		})
	end
end

function slot0.onDestroyView(slot0)
	AergusiDialogModel.instance:setUnlockAutoShow(false)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
	slot0:_removeEvents()
end

return slot0
