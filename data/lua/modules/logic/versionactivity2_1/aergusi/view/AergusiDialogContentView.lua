module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogContentView", package.seeall)

slot0 = class("AergusiDialogContentView", BaseView)

function slot0.onInitView(slot0)
	slot0._gonextstep = gohelper.findChild(slot0.viewGO, "#go_nextstep")
	slot0._godialoguecontainer = gohelper.findChild(slot0.viewGO, "#go_dialoguecontainer")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content")
	slot0._goleftdialogueitem = gohelper.findChild(slot0.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_leftdialogueitem")
	slot0._gorightdialogueitem = gohelper.findChild(slot0.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_rightdialogueitem")
	slot0._gosystemmessageitem = gohelper.findChild(slot0.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_systemmessageitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._scrollcontent:AddOnValueChanged(slot0._onScrollValueChanged, slot0)
	slot0._nextStepClick:AddClickListener(slot0._onClickNextStep, slot0)
	slot0._drag:AddDragBeginListener(slot0._onBeginDrag, slot0)
	slot0._drag:AddDragEndListener(slot0._onEndDrag, slot0)
	slot0._nextStepClick2:AddClickListener(slot0._onClickNextStep, slot0)
end

function slot0.removeEvents(slot0)
	slot0._scrollcontent:RemoveOnValueChanged()
	slot0._nextStepClick:RemoveClickListener()
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
	slot0._nextStepClick2:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._itemRootGos = {
		[AergusiEnum.DialogType.NormalLeft] = slot0._goleftdialogueitem,
		[AergusiEnum.DialogType.NormalRight] = slot0._gorightdialogueitem,
		[AergusiEnum.DialogType.SystemMsg] = slot0._gosystemmessageitem
	}
	slot4 = "#go_dialoguecontainer/Scroll View"
	slot0._scrollcontent = gohelper.findChildScrollRect(slot0.viewGO, slot4)
	slot0._contentMinHeight = recthelper.getHeight(slot0._scrollcontent.transform)
	slot0._nextStepClick = gohelper.getClickWithDefaultAudio(slot0._gonextstep)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._scrollcontent.gameObject)
	slot0._nextStepClick2 = gohelper.getClickWithDefaultAudio(slot0._scrollcontent.gameObject)
	slot0._rectTrContent = slot0._gocontent.transform

	for slot4, slot5 in pairs(slot0._itemRootGos) do
		gohelper.setActive(slot5, false)
	end

	slot0._dialogueItemList = {}
	slot0._contentHeight = 0
	slot0._startServerTime = ServerTime.now()

	slot0:_addEvents()
end

function slot0._onScrollValueChanged(slot0)
	gohelper.setActive(slot0._goArrow, slot0._scrollcontent.verticalNormalizedPosition >= 0.01)
end

function slot0._onClickNextStep(slot0)
	if slot0._dragging then
		return
	end

	slot0:_playNext()
end

function slot0._onBeginDrag(slot0)
	slot0._dragging = true
end

function slot0._onEndDrag(slot0)
	slot0._dragging = false
end

function slot0.onOpen(slot0)
	slot0._config = AergusiConfig.instance:getEpisodeConfig(nil, slot0.viewParam.episodeId)
	slot0.stepCoList = {}

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("waitOpen")
	TaskDispatcher.runDelay(slot0._startInitGroup, slot0, 0.83)
end

function slot0._startInitGroup(slot0)
	UIBlockMgr.instance:endBlock("waitOpen")
	slot0:_playGroup(AergusiDialogModel.instance:getCurDialogGroup())
end

function slot0._playGroup(slot0, slot1, slot2)
	AergusiDialogModel.instance:addTargetGroup(slot1)
	AergusiDialogModel.instance:setDialogGroup(slot1)
	AergusiDialogModel.instance:setShowingGroup(true)
	AergusiController.instance:dispatchEvent(AergusiEvent.OnStartDialogGroup)
	slot0:_addStepList(slot1)
	slot0:_playNext(slot2)
end

function slot0._addStepList(slot0, slot1)
	for slot6 = #AergusiDialogModel.instance:getDialogStepList(slot1), 1, -1 do
		table.insert(slot0.stepCoList, slot2[slot6])
	end
end

function slot0._playNext(slot0, slot1)
	if AergusiDialogModel.instance:getLeftErrorTimes() <= 0 then
		return
	end

	if not slot0:_popNextStep() then
		slot0:_setDialogGroupDone()

		return
	end

	slot0._stepCo = slot3

	if slot0._stepCo.id == AergusiModel.instance:getUnlockAutoTipProcess()[1] and slot0._stepCo.stepId == slot4[2] then
		AergusiDialogModel.instance:setUnlockAutoShow(false)
	end

	slot5 = slot0._stepCo.pos

	if slot5 == AergusiEnum.DialogPos.Right then
		AergusiDialogItem.CreateItem(slot0._stepCo, gohelper.cloneInPlace(slot0._itemRootGos[slot5]), slot0._contentHeight, slot5):setQutation(slot1)
	end

	for slot11, slot12 in pairs(slot0._dialogueItemList) do
		slot12:refresh()
	end

	table.insert(slot0._dialogueItemList, slot7)
	UIBlockMgr.instance:startBlock("waitOpen")
	AergusiDialogModel.instance:setCurDialogProcess(slot3.id, slot3.stepId)
	TaskDispatcher.runDelay(slot0._startDialogNextStep, slot0, 0.1)
end

function slot0._startDialogNextStep(slot0)
	UIBlockMgr.instance:endBlock("waitOpen")
	slot0:_setDialogRt()
	AergusiController.instance:dispatchEvent(AergusiEvent.OnStartDialogNextStep, slot0._stepCo)
	slot0:_checkAutoOperate()
end

function slot0._setDialogRt(slot0)
	slot0._contentHeight = slot0._contentHeight + slot0._dialogueItemList[#slot0._dialogueItemList]:getHeight() + AergusiEnum.IntervalY

	recthelper.setHeight(slot0._rectTrContent, Mathf.Max(slot0._contentHeight, slot0._contentMinHeight))
	slot0:playUpAnimation()
end

function slot0._checkAutoOperate(slot0)
	if slot0._stepCo.condition ~= "" then
		if string.splitToNumber(slot0._stepCo.condition, "#")[1] == AergusiEnum.OperationType.AutoBubble then
			AergusiController.instance:dispatchEvent(AergusiEvent.OnStartAutoBubbleDialog, {
				stepCo = slot0._stepCo
			})
		elseif slot1[1] == AergusiEnum.OperationType.GetClue then
			Activity163Rpc.instance:sendAct163EvidenceOperationRequest(VersionActivity2_1Enum.ActivityId.Aergusi, slot0.viewParam.episodeId, AergusiEnum.OperationType.GetClue, string.format("%s", slot0._stepCo.stepId), slot0._onGetClueFinished, slot0)
		end
	end
end

function slot0._onGetClueFinished(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	GameFacade.showToast(ToastEnum.Act163GetClueTip)
end

function slot0._setDialogGroupDone(slot0)
	if not AergusiDialogModel.instance:getShowingGroupState() then
		return
	end

	if AergusiConfig.instance:getEvidenceConfig(AergusiDialogModel.instance:getCurDialogGroup()).dialogGroupType == AergusiEnum.DialogGroupType.Normal then
		slot0:_onShowingGroupFinished()
	else
		AergusiController.instance:openAergusiDialogStartView(slot2, slot0._onShowingGroupFinished, slot0)
	end
end

function slot0._onShowingGroupFinished(slot0)
	AergusiDialogModel.instance:setShowingGroup(AergusiConfig.instance:getEvidenceConfig(AergusiDialogModel.instance:getCurDialogGroup()).dialogGroupType == AergusiEnum.DialogGroupType.Normal)
	AergusiController.instance:dispatchEvent(AergusiEvent.OnShowDialogGroupFinished, slot1)

	if AergusiConfig.instance:getEvidenceConfig(slot1).dialogGroupType == AergusiEnum.DialogGroupType.Interact then
		slot4 = AergusiDialogModel.instance:getNextPromptOperate(false)

		if string.splitToNumber(AergusiConfig.instance:getDialogConfig(slot4.groupId, slot4.stepId).condition, "#")[1] == AergusiEnum.OperationType.Refutation then
			AergusiController.instance:dispatchEvent(AergusiEvent.OnGuideEnterInteractRefutation)
		elseif slot6[1] == AergusiEnum.OperationType.Probe then
			AergusiController.instance:dispatchEvent(AergusiEvent.OnGuideEnterInteractProbe)
		end
	end

	if slot0._stepCo.condition ~= "" then
		if string.splitToNumber(slot0._stepCo.condition, "#")[1] == AergusiEnum.OperationType.NextDialogs then
			Activity163Rpc.instance:sendAct163EvidenceOperationRequest(VersionActivity2_1Enum.ActivityId.Aergusi, slot0.viewParam.episodeId, AergusiEnum.OperationType.NextDialogs, "", slot0._onNextDialogFinished, slot0)
		elseif slot4[1] == AergusiEnum.OperationType.Submit then
			slot0:_checkWaitGuide(slot4[3])
		elseif slot4[1] == AergusiEnum.OperationType.EndEpisode then
			UIBlockMgr.instance:startBlock("waitEndEpisode")
			Activity163Rpc.instance:sendAct163EvidenceOperationRequest(VersionActivity2_1Enum.ActivityId.Aergusi, slot0.viewParam.episodeId, AergusiEnum.OperationType.EndEpisode, "", slot0._onEndEpisode, slot0)
		end
	end

	if slot0._stepCo.id == AergusiModel.instance:getUnlockAutoTipProcess()[1] and slot0._stepCo.stepId == slot4[2] then
		AergusiDialogModel.instance:setUnlockAutoShow(false)
	end
end

function slot0._checkWaitGuide(slot0, slot1)
	slot0._groupId = slot1

	if slot0._stepCo.id == AergusiEnum.FirstGroupId and slot0._stepCo.stepId == AergusiEnum.FirstGroupLastStepId and not GuideModel.instance:isGuideFinish(AergusiEnum.FirstDialogGuideId) and not GuideController.instance:isForbidGuides() then
		GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, slot0._onGuideFinish, slot0)

		return
	end

	slot0:_openClue()
end

function slot0._onGuideFinish(slot0, slot1)
	if slot1 ~= AergusiEnum.FirstDialogGuideId then
		return
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, slot0._onGuideFinish, slot0)
	slot0:_openClue()
end

function slot0._openClue(slot0)
	AergusiController.instance:openAergusiClueView({
		episodeId = slot0.viewParam.episodeId,
		type = AergusiEnum.OperationType.Submit,
		groupId = slot0._groupId,
		stepId = slot0._stepCo.stepId,
		couldPrompt = true,
		callback = slot0._onSubmitEvidenceFinished,
		callbackObj = slot0
	})
end

function slot0._onEndEpisode(slot0, slot1, slot2)
	UIBlockMgr.instance:endBlock("waitEndEpisode")

	slot8 = true

	for slot8, slot9 in pairs(AergusiModel.instance.instance:getEpisodeClueConfigs(slot0.viewParam.episodeId, slot8)) do
		table.insert({}, slot9.clueName)
	end

	if slot2 ~= 0 then
		StatController.instance:track(StatEnum.EventName.ExitArgusActivity, {
			[StatEnum.EventProperties.EpisodeId] = tostring(slot0.viewParam.episodeId),
			[StatEnum.EventProperties.Result] = "Abort",
			[StatEnum.EventProperties.UseTime] = ServerTime.now() - slot0._startServerTime,
			[StatEnum.EventProperties.GoalNum] = AergusiDialogModel.instance:getFinishedTargetGroupCount(),
			[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
			[StatEnum.EventProperties.HoldClueName] = slot3
		})
		slot0:closeThis()

		return
	end

	StatController.instance:track(StatEnum.EventName.ExitArgusActivity, {
		[StatEnum.EventProperties.EpisodeId] = tostring(slot0.viewParam.episodeId),
		[StatEnum.EventProperties.Result] = "Success",
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - slot0._startServerTime,
		[StatEnum.EventProperties.GoalNum] = AergusiDialogModel.instance:getFinishedTargetGroupCount() + 1,
		[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
		[StatEnum.EventProperties.HoldClueName] = slot3
	})
	AergusiController.instance:openAergusiDialogEndView(slot0.viewParam.episodeId, slot0._realClose, slot0)
end

function slot0._realClose(slot0)
	if slot0.viewParam and slot0.viewParam.callback then
		slot0.viewParam.callback(slot0.viewParam.callbackObj)
	end

	TaskDispatcher.runDelay(slot0._waitStoryPlay, slot0, 1)
end

function slot0._waitStoryPlay(slot0)
	slot0:closeThis()
end

function slot0._onNextDialogFinished(slot0, slot1, slot2)
	if slot2 ~= 0 then
		slot0:closeThis()

		return
	end

	slot0:_playGroup(string.splitToNumber(slot0._stepCo.condition, "#")[2])
end

function slot0._onSubmitEvidenceFinished(slot0, slot1)
	if slot1 == -1 then
		AergusiDialogModel.instance:setShowingGroup(true)

		return
	end

	if not slot1 or slot1 == 0 then
		AergusiDialogModel.instance:setShowingGroup(true)

		slot2, slot3 = AergusiDialogModel.instance:getCurDialogProcess()

		AergusiController.instance:dispatchEvent(AergusiEvent.EvidenceError, AergusiConfig.instance:getDialogConfig(slot2, slot3), AergusiEnum.OperationType.Submit)

		return
	end

	slot0:_playGroup(slot1)
end

function slot0._popNextStep(slot0)
	if #slot0.stepCoList <= 0 then
		return
	end

	slot0.stepCoList[slot1] = nil

	return slot0.stepCoList[slot1]
end

function slot0.playUpAnimation(slot0)
	if slot0._contentHeight <= slot0._contentMinHeight then
		return
	end

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot0._scrollcontent.verticalNormalizedPosition, 0, 0.5, slot0._frameUpdate, slot0._frameFinished, slot0)
end

function slot0._frameUpdate(slot0, slot1)
	slot0._scrollcontent.verticalNormalizedPosition = slot1
end

function slot0._frameFinished(slot0)
	gohelper.setActive(slot0._goArrow, false)
end

function slot0.onClose(slot0)
end

function slot0._addEvents(slot0)
	slot0:addEventCb(AergusiController.instance, AergusiEvent.OnRefuteStartGroup, slot0._OnRefuteStartGroup, slot0)
	slot0:addEventCb(AergusiController.instance, AergusiEvent.OnDialogAskSuccess, slot0._onDialogAskSuccess, slot0)
	slot0:addEventCb(AergusiController.instance, AergusiEvent.OnClickEpisodeClueBtn, slot0._onEpisodeClueBtnClick, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(AergusiController.instance, AergusiEvent.OnRefuteStartGroup, slot0._OnRefuteStartGroup, slot0)
	slot0:removeEventCb(AergusiController.instance, AergusiEvent.OnDialogAskSuccess, slot0._onDialogAskSuccess, slot0)
	slot0:removeEventCb(AergusiController.instance, AergusiEvent.OnClickEpisodeClueBtn, slot0._onEpisodeClueBtnClick, slot0)
end

function slot0._OnRefuteStartGroup(slot0, slot1)
	slot0:_playGroup(slot1)
end

function slot0._onDialogAskSuccess(slot0, slot1)
	slot0:_playGroup(string.splitToNumber(slot1.condition, "#")[2], slot1)
end

function slot0._onEpisodeClueBtnClick(slot0)
	slot0:_setDialogGroupDone()
end

function slot0.onDestroyView(slot0)
	UIBlockMgr.instance:endBlock("waitOpen")
	TaskDispatcher.cancelTask(slot0._startInitGroup, slot0)
	TaskDispatcher.cancelTask(slot0._waitStoryPlay, slot0)
	slot0:_removeEvents()

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	for slot4, slot5 in ipairs(slot0._dialogueItemList) do
		slot5:destroy()
	end
end

return slot0
