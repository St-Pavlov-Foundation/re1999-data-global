module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogContentView", package.seeall)

local var_0_0 = class("AergusiDialogContentView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonextstep = gohelper.findChild(arg_1_0.viewGO, "#go_nextstep")
	arg_1_0._godialoguecontainer = gohelper.findChild(arg_1_0.viewGO, "#go_dialoguecontainer")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content")
	arg_1_0._goleftdialogueitem = gohelper.findChild(arg_1_0.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_leftdialogueitem")
	arg_1_0._gorightdialogueitem = gohelper.findChild(arg_1_0.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_rightdialogueitem")
	arg_1_0._gosystemmessageitem = gohelper.findChild(arg_1_0.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_systemmessageitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._scrollcontent:AddOnValueChanged(arg_2_0._onScrollValueChanged, arg_2_0)
	arg_2_0._nextStepClick:AddClickListener(arg_2_0._onClickNextStep, arg_2_0)
	arg_2_0._drag:AddDragBeginListener(arg_2_0._onBeginDrag, arg_2_0)
	arg_2_0._drag:AddDragEndListener(arg_2_0._onEndDrag, arg_2_0)
	arg_2_0._nextStepClick2:AddClickListener(arg_2_0._onClickNextStep, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._scrollcontent:RemoveOnValueChanged()
	arg_3_0._nextStepClick:RemoveClickListener()
	arg_3_0._drag:RemoveDragBeginListener()
	arg_3_0._drag:RemoveDragEndListener()
	arg_3_0._nextStepClick2:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._itemRootGos = {
		[AergusiEnum.DialogType.NormalLeft] = arg_4_0._goleftdialogueitem,
		[AergusiEnum.DialogType.NormalRight] = arg_4_0._gorightdialogueitem,
		[AergusiEnum.DialogType.SystemMsg] = arg_4_0._gosystemmessageitem
	}
	arg_4_0._scrollcontent = gohelper.findChildScrollRect(arg_4_0.viewGO, "#go_dialoguecontainer/Scroll View")
	arg_4_0._contentMinHeight = recthelper.getHeight(arg_4_0._scrollcontent.transform)
	arg_4_0._nextStepClick = gohelper.getClickWithDefaultAudio(arg_4_0._gonextstep)
	arg_4_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_4_0._scrollcontent.gameObject)
	arg_4_0._nextStepClick2 = gohelper.getClickWithDefaultAudio(arg_4_0._scrollcontent.gameObject)
	arg_4_0._rectTrContent = arg_4_0._gocontent.transform

	for iter_4_0, iter_4_1 in pairs(arg_4_0._itemRootGos) do
		gohelper.setActive(iter_4_1, false)
	end

	arg_4_0._dialogueItemList = {}
	arg_4_0._contentHeight = 0
	arg_4_0._startServerTime = ServerTime.now()

	arg_4_0:_addEvents()
end

function var_0_0._onScrollValueChanged(arg_5_0)
	gohelper.setActive(arg_5_0._goArrow, arg_5_0._scrollcontent.verticalNormalizedPosition >= 0.01)
end

function var_0_0._onClickNextStep(arg_6_0)
	if arg_6_0._dragging then
		return
	end

	arg_6_0:_playNext()
end

function var_0_0._onBeginDrag(arg_7_0)
	arg_7_0._dragging = true
end

function var_0_0._onEndDrag(arg_8_0)
	arg_8_0._dragging = false
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._config = AergusiConfig.instance:getEpisodeConfig(nil, arg_9_0.viewParam.episodeId)
	arg_9_0.stepCoList = {}

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("waitOpen")
	TaskDispatcher.runDelay(arg_9_0._startInitGroup, arg_9_0, 0.83)
end

function var_0_0._startInitGroup(arg_10_0)
	UIBlockMgr.instance:endBlock("waitOpen")

	local var_10_0 = AergusiDialogModel.instance:getCurDialogGroup()

	arg_10_0:_playGroup(var_10_0)
end

function var_0_0._playGroup(arg_11_0, arg_11_1, arg_11_2)
	AergusiDialogModel.instance:addTargetGroup(arg_11_1)
	AergusiDialogModel.instance:setDialogGroup(arg_11_1)
	AergusiDialogModel.instance:setShowingGroup(true)
	AergusiController.instance:dispatchEvent(AergusiEvent.OnStartDialogGroup)
	arg_11_0:_addStepList(arg_11_1)
	arg_11_0:_playNext(arg_11_2)
end

function var_0_0._addStepList(arg_12_0, arg_12_1)
	local var_12_0 = AergusiDialogModel.instance:getDialogStepList(arg_12_1)

	for iter_12_0 = #var_12_0, 1, -1 do
		table.insert(arg_12_0.stepCoList, var_12_0[iter_12_0])
	end
end

function var_0_0._playNext(arg_13_0, arg_13_1)
	if AergusiDialogModel.instance:getLeftErrorTimes() <= 0 then
		return
	end

	local var_13_0 = arg_13_0:_popNextStep()

	if not var_13_0 then
		arg_13_0:_setDialogGroupDone()

		return
	end

	arg_13_0._stepCo = var_13_0

	local var_13_1 = AergusiModel.instance:getUnlockAutoTipProcess()

	if arg_13_0._stepCo.id == var_13_1[1] and arg_13_0._stepCo.stepId == var_13_1[2] then
		AergusiDialogModel.instance:setUnlockAutoShow(false)
	end

	local var_13_2 = arg_13_0._stepCo.pos
	local var_13_3 = gohelper.cloneInPlace(arg_13_0._itemRootGos[var_13_2])
	local var_13_4 = AergusiDialogItem.CreateItem(arg_13_0._stepCo, var_13_3, arg_13_0._contentHeight, var_13_2)

	if var_13_2 == AergusiEnum.DialogPos.Right then
		var_13_4:setQutation(arg_13_1)
	end

	for iter_13_0, iter_13_1 in pairs(arg_13_0._dialogueItemList) do
		iter_13_1:refresh()
	end

	table.insert(arg_13_0._dialogueItemList, var_13_4)
	UIBlockMgr.instance:startBlock("waitOpen")
	AergusiDialogModel.instance:setCurDialogProcess(var_13_0.id, var_13_0.stepId)
	TaskDispatcher.runDelay(arg_13_0._startDialogNextStep, arg_13_0, 0.1)
end

function var_0_0._startDialogNextStep(arg_14_0)
	UIBlockMgr.instance:endBlock("waitOpen")
	arg_14_0:_setDialogRt()
	AergusiController.instance:dispatchEvent(AergusiEvent.OnStartDialogNextStep, arg_14_0._stepCo)
	arg_14_0:_checkAutoOperate()
end

function var_0_0._setDialogRt(arg_15_0)
	arg_15_0._contentHeight = arg_15_0._contentHeight + arg_15_0._dialogueItemList[#arg_15_0._dialogueItemList]:getHeight() + AergusiEnum.IntervalY

	recthelper.setHeight(arg_15_0._rectTrContent, Mathf.Max(arg_15_0._contentHeight, arg_15_0._contentMinHeight))
	arg_15_0:playUpAnimation()
end

function var_0_0._checkAutoOperate(arg_16_0)
	if arg_16_0._stepCo.condition ~= "" then
		local var_16_0 = string.splitToNumber(arg_16_0._stepCo.condition, "#")

		if var_16_0[1] == AergusiEnum.OperationType.AutoBubble then
			local var_16_1 = {
				stepCo = arg_16_0._stepCo
			}

			AergusiController.instance:dispatchEvent(AergusiEvent.OnStartAutoBubbleDialog, var_16_1)
		elseif var_16_0[1] == AergusiEnum.OperationType.GetClue then
			local var_16_2 = VersionActivity2_1Enum.ActivityId.Aergusi
			local var_16_3 = arg_16_0.viewParam.episodeId
			local var_16_4 = AergusiEnum.OperationType.GetClue
			local var_16_5 = string.format("%s", arg_16_0._stepCo.stepId)

			Activity163Rpc.instance:sendAct163EvidenceOperationRequest(var_16_2, var_16_3, var_16_4, var_16_5, arg_16_0._onGetClueFinished, arg_16_0)
		end
	end
end

function var_0_0._onGetClueFinished(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_2 ~= 0 then
		return
	end

	GameFacade.showToast(ToastEnum.Act163GetClueTip)
end

function var_0_0._setDialogGroupDone(arg_18_0)
	if not AergusiDialogModel.instance:getShowingGroupState() then
		return
	end

	local var_18_0 = AergusiDialogModel.instance:getCurDialogGroup()

	if AergusiConfig.instance:getEvidenceConfig(var_18_0).dialogGroupType == AergusiEnum.DialogGroupType.Normal then
		arg_18_0:_onShowingGroupFinished()
	else
		AergusiController.instance:openAergusiDialogStartView(var_18_0, arg_18_0._onShowingGroupFinished, arg_18_0)
	end
end

function var_0_0._onShowingGroupFinished(arg_19_0)
	local var_19_0 = AergusiDialogModel.instance:getCurDialogGroup()
	local var_19_1 = AergusiConfig.instance:getEvidenceConfig(var_19_0)

	AergusiDialogModel.instance:setShowingGroup(var_19_1.dialogGroupType == AergusiEnum.DialogGroupType.Normal)
	AergusiController.instance:dispatchEvent(AergusiEvent.OnShowDialogGroupFinished, var_19_0)

	if AergusiConfig.instance:getEvidenceConfig(var_19_0).dialogGroupType == AergusiEnum.DialogGroupType.Interact then
		local var_19_2 = AergusiDialogModel.instance:getNextPromptOperate(false)
		local var_19_3 = AergusiConfig.instance:getDialogConfig(var_19_2.groupId, var_19_2.stepId)
		local var_19_4 = string.splitToNumber(var_19_3.condition, "#")

		if var_19_4[1] == AergusiEnum.OperationType.Refutation then
			AergusiController.instance:dispatchEvent(AergusiEvent.OnGuideEnterInteractRefutation)
		elseif var_19_4[1] == AergusiEnum.OperationType.Probe then
			AergusiController.instance:dispatchEvent(AergusiEvent.OnGuideEnterInteractProbe)
		end
	end

	if arg_19_0._stepCo.condition ~= "" then
		local var_19_5 = string.splitToNumber(arg_19_0._stepCo.condition, "#")

		if var_19_5[1] == AergusiEnum.OperationType.NextDialogs then
			local var_19_6 = VersionActivity2_1Enum.ActivityId.Aergusi
			local var_19_7 = arg_19_0.viewParam.episodeId
			local var_19_8 = AergusiEnum.OperationType.NextDialogs
			local var_19_9 = ""

			Activity163Rpc.instance:sendAct163EvidenceOperationRequest(var_19_6, var_19_7, var_19_8, var_19_9, arg_19_0._onNextDialogFinished, arg_19_0)
		elseif var_19_5[1] == AergusiEnum.OperationType.Submit then
			arg_19_0:_checkWaitGuide(var_19_5[3])
		elseif var_19_5[1] == AergusiEnum.OperationType.EndEpisode then
			local var_19_10 = VersionActivity2_1Enum.ActivityId.Aergusi
			local var_19_11 = arg_19_0.viewParam.episodeId
			local var_19_12 = AergusiEnum.OperationType.EndEpisode
			local var_19_13 = ""

			UIBlockMgr.instance:startBlock("waitEndEpisode")
			Activity163Rpc.instance:sendAct163EvidenceOperationRequest(var_19_10, var_19_11, var_19_12, var_19_13, arg_19_0._onEndEpisode, arg_19_0)
		end
	end

	local var_19_14 = AergusiModel.instance:getUnlockAutoTipProcess()

	if arg_19_0._stepCo.id == var_19_14[1] and arg_19_0._stepCo.stepId == var_19_14[2] then
		AergusiDialogModel.instance:setUnlockAutoShow(false)
	end
end

function var_0_0._checkWaitGuide(arg_20_0, arg_20_1)
	arg_20_0._groupId = arg_20_1

	if arg_20_0._stepCo.id == AergusiEnum.FirstGroupId and arg_20_0._stepCo.stepId == AergusiEnum.FirstGroupLastStepId and not GuideModel.instance:isGuideFinish(AergusiEnum.FirstDialogGuideId) and not GuideController.instance:isForbidGuides() then
		GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, arg_20_0._onGuideFinish, arg_20_0)

		return
	end

	arg_20_0:_openClue()
end

function var_0_0._onGuideFinish(arg_21_0, arg_21_1)
	if arg_21_1 ~= AergusiEnum.FirstDialogGuideId then
		return
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, arg_21_0._onGuideFinish, arg_21_0)
	arg_21_0:_openClue()
end

function var_0_0._openClue(arg_22_0)
	local var_22_0 = {
		episodeId = arg_22_0.viewParam.episodeId,
		type = AergusiEnum.OperationType.Submit,
		groupId = arg_22_0._groupId,
		stepId = arg_22_0._stepCo.stepId
	}

	var_22_0.couldPrompt = true
	var_22_0.callback = arg_22_0._onSubmitEvidenceFinished
	var_22_0.callbackObj = arg_22_0

	AergusiController.instance:openAergusiClueView(var_22_0)
end

function var_0_0._onEndEpisode(arg_23_0, arg_23_1, arg_23_2)
	UIBlockMgr.instance:endBlock("waitEndEpisode")

	local var_23_0 = {}
	local var_23_1 = AergusiModel.instance.instance:getEpisodeClueConfigs(arg_23_0.viewParam.episodeId, true)

	for iter_23_0, iter_23_1 in pairs(var_23_1) do
		table.insert(var_23_0, iter_23_1.clueName)
	end

	if arg_23_2 ~= 0 then
		StatController.instance:track(StatEnum.EventName.ExitArgusActivity, {
			[StatEnum.EventProperties.EpisodeId] = tostring(arg_23_0.viewParam.episodeId),
			[StatEnum.EventProperties.Result] = "Abort",
			[StatEnum.EventProperties.UseTime] = ServerTime.now() - arg_23_0._startServerTime,
			[StatEnum.EventProperties.GoalNum] = AergusiDialogModel.instance:getFinishedTargetGroupCount(),
			[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
			[StatEnum.EventProperties.HoldClueName] = var_23_0
		})
		arg_23_0:closeThis()

		return
	end

	StatController.instance:track(StatEnum.EventName.ExitArgusActivity, {
		[StatEnum.EventProperties.EpisodeId] = tostring(arg_23_0.viewParam.episodeId),
		[StatEnum.EventProperties.Result] = "Success",
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - arg_23_0._startServerTime,
		[StatEnum.EventProperties.GoalNum] = AergusiDialogModel.instance:getFinishedTargetGroupCount() + 1,
		[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
		[StatEnum.EventProperties.HoldClueName] = var_23_0
	})
	AergusiController.instance:openAergusiDialogEndView(arg_23_0.viewParam.episodeId, arg_23_0._realClose, arg_23_0)
end

function var_0_0._realClose(arg_24_0)
	if arg_24_0.viewParam and arg_24_0.viewParam.callback then
		arg_24_0.viewParam.callback(arg_24_0.viewParam.callbackObj)
	end

	TaskDispatcher.runDelay(arg_24_0._waitStoryPlay, arg_24_0, 1)
end

function var_0_0._waitStoryPlay(arg_25_0)
	arg_25_0:closeThis()
end

function var_0_0._onNextDialogFinished(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_2 ~= 0 then
		arg_26_0:closeThis()

		return
	end

	local var_26_0 = string.splitToNumber(arg_26_0._stepCo.condition, "#")

	arg_26_0:_playGroup(var_26_0[2])
end

function var_0_0._onSubmitEvidenceFinished(arg_27_0, arg_27_1)
	if arg_27_1 == -1 then
		AergusiDialogModel.instance:setShowingGroup(true)

		return
	end

	if not arg_27_1 or arg_27_1 == 0 then
		AergusiDialogModel.instance:setShowingGroup(true)

		local var_27_0, var_27_1 = AergusiDialogModel.instance:getCurDialogProcess()
		local var_27_2 = AergusiConfig.instance:getDialogConfig(var_27_0, var_27_1)
		local var_27_3 = AergusiEnum.OperationType.Submit

		AergusiController.instance:dispatchEvent(AergusiEvent.EvidenceError, var_27_2, var_27_3)

		return
	end

	arg_27_0:_playGroup(arg_27_1)
end

function var_0_0._popNextStep(arg_28_0)
	local var_28_0 = #arg_28_0.stepCoList

	if var_28_0 <= 0 then
		return
	end

	local var_28_1 = arg_28_0.stepCoList[var_28_0]

	arg_28_0.stepCoList[var_28_0] = nil

	return var_28_1
end

function var_0_0.playUpAnimation(arg_29_0)
	if arg_29_0._contentHeight <= arg_29_0._contentMinHeight then
		return
	end

	if arg_29_0._tweenId then
		ZProj.TweenHelper.KillById(arg_29_0._tweenId)

		arg_29_0._tweenId = nil
	end

	arg_29_0._tweenId = ZProj.TweenHelper.DOTweenFloat(arg_29_0._scrollcontent.verticalNormalizedPosition, 0, 0.5, arg_29_0._frameUpdate, arg_29_0._frameFinished, arg_29_0)
end

function var_0_0._frameUpdate(arg_30_0, arg_30_1)
	arg_30_0._scrollcontent.verticalNormalizedPosition = arg_30_1
end

function var_0_0._frameFinished(arg_31_0)
	gohelper.setActive(arg_31_0._goArrow, false)
end

function var_0_0.onClose(arg_32_0)
	return
end

function var_0_0._addEvents(arg_33_0)
	arg_33_0:addEventCb(AergusiController.instance, AergusiEvent.OnRefuteStartGroup, arg_33_0._OnRefuteStartGroup, arg_33_0)
	arg_33_0:addEventCb(AergusiController.instance, AergusiEvent.OnDialogAskSuccess, arg_33_0._onDialogAskSuccess, arg_33_0)
	arg_33_0:addEventCb(AergusiController.instance, AergusiEvent.OnClickEpisodeClueBtn, arg_33_0._onEpisodeClueBtnClick, arg_33_0)
end

function var_0_0._removeEvents(arg_34_0)
	arg_34_0:removeEventCb(AergusiController.instance, AergusiEvent.OnRefuteStartGroup, arg_34_0._OnRefuteStartGroup, arg_34_0)
	arg_34_0:removeEventCb(AergusiController.instance, AergusiEvent.OnDialogAskSuccess, arg_34_0._onDialogAskSuccess, arg_34_0)
	arg_34_0:removeEventCb(AergusiController.instance, AergusiEvent.OnClickEpisodeClueBtn, arg_34_0._onEpisodeClueBtnClick, arg_34_0)
end

function var_0_0._OnRefuteStartGroup(arg_35_0, arg_35_1)
	arg_35_0:_playGroup(arg_35_1)
end

function var_0_0._onDialogAskSuccess(arg_36_0, arg_36_1)
	local var_36_0 = string.splitToNumber(arg_36_1.condition, "#")

	arg_36_0:_playGroup(var_36_0[2], arg_36_1)
end

function var_0_0._onEpisodeClueBtnClick(arg_37_0)
	arg_37_0:_setDialogGroupDone()
end

function var_0_0.onDestroyView(arg_38_0)
	UIBlockMgr.instance:endBlock("waitOpen")
	TaskDispatcher.cancelTask(arg_38_0._startInitGroup, arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0._waitStoryPlay, arg_38_0)
	arg_38_0:_removeEvents()

	if arg_38_0._tweenId then
		ZProj.TweenHelper.KillById(arg_38_0._tweenId)

		arg_38_0._tweenId = nil
	end

	for iter_38_0, iter_38_1 in ipairs(arg_38_0._dialogueItemList) do
		iter_38_1:destroy()
	end
end

return var_0_0
