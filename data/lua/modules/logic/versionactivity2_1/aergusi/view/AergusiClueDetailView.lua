module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueDetailView", package.seeall)

local var_0_0 = class("AergusiClueDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocluedetail = gohelper.findChild(arg_1_0.viewGO, "Right/#go_cluedetail")
	arg_1_0._goevidence = gohelper.findChild(arg_1_0.viewGO, "Right/#go_cluedetail/evidence")
	arg_1_0._simageclueitem = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#go_cluedetail/evidence/#simage_clueitem")
	arg_1_0._txtcluename = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_cluedetail/evidence/#txt_cluename")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/#go_cluedetail/#scroll_desc")
	arg_1_0._godesccontent = gohelper.findChild(arg_1_0.viewGO, "Right/#go_cluedetail/#scroll_desc/Viewport/#go_desccontent")
	arg_1_0._godescitem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_cluedetail/#scroll_desc/Viewport/#go_desccontent/#go_descitem")
	arg_1_0._btnevidence = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_cluedetail/#btn_evidence")
	arg_1_0._imageEvidence = gohelper.findChildImage(arg_1_0.viewGO, "Right/#go_cluedetail/#btn_evidence")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnevidence:AddClickListener(arg_2_0._btnevidenceOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnevidence:RemoveClickListener()
end

function var_0_0._btnevidenceOnClick(arg_4_0)
	local var_4_0 = VersionActivity2_1Enum.ActivityId.Aergusi
	local var_4_1 = arg_4_0.viewParam.episodeId
	local var_4_2 = arg_4_0.viewParam.type
	local var_4_3 = arg_4_0.viewParam.stepId
	local var_4_4 = string.format("%s#%s", var_4_3, AergusiModel.instance:getCurClueId())

	Activity163Rpc.instance:sendAct163EvidenceOperationRequest(var_4_0, var_4_1, var_4_2, var_4_4, arg_4_0._evidenceFinished, arg_4_0)
end

function var_0_0._evidenceFinished(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2 ~= 0 then
		return
	end

	local var_5_0 = 0
	local var_5_1 = {}
	local var_5_2 = AergusiModel.instance.instance:getEpisodeClueConfigs(arg_5_0.viewParam.episodeId, true)

	for iter_5_0, iter_5_1 in pairs(var_5_2) do
		table.insert(var_5_1, iter_5_1.clueName)
	end

	local var_5_3 = AergusiModel.instance:getCurClueId()
	local var_5_4 = AergusiDialogModel.instance:getCurDialogGroup()

	if arg_5_3.operationResult == "0" then
		var_5_0 = arg_5_0.viewParam.groupId

		StatController.instance:track(StatEnum.EventName.AergusiClueInteractive, {
			[StatEnum.EventProperties.EpisodeId] = tostring(arg_5_0.viewParam.episodeId),
			[StatEnum.EventProperties.ClueInteractiveType] = arg_5_0.viewParam.type == AergusiEnum.OperationType.Refutation and "Refute" or "Evidence",
			[StatEnum.EventProperties.TargetTip] = AergusiConfig.instance:getEvidenceConfig(var_5_4).conditionStr,
			[StatEnum.EventProperties.ClueId] = tostring(var_5_3),
			[StatEnum.EventProperties.ClueName] = AergusiConfig.instance:getClueConfig(var_5_3).clueName,
			[StatEnum.EventProperties.RefuteDialogId] = tostring(var_5_4),
			[StatEnum.EventProperties.RefuteStepId] = tostring(arg_5_0.viewParam.stepId),
			[StatEnum.EventProperties.ClueInteractiveResult] = "Success",
			[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
			[StatEnum.EventProperties.HoldClueName] = var_5_1
		})
	else
		StatController.instance:track(StatEnum.EventName.AergusiClueInteractive, {
			[StatEnum.EventProperties.EpisodeId] = tostring(arg_5_0.viewParam.episodeId),
			[StatEnum.EventProperties.ClueInteractiveType] = arg_5_0.viewParam.type == AergusiEnum.OperationType.Refutation and "Refute" or "Evidence",
			[StatEnum.EventProperties.TargetTip] = AergusiConfig.instance:getEvidenceConfig(var_5_4).conditionStr,
			[StatEnum.EventProperties.ClueId] = tostring(var_5_3),
			[StatEnum.EventProperties.ClueName] = AergusiConfig.instance:getClueConfig(var_5_3).clueName,
			[StatEnum.EventProperties.RefuteDialogId] = tostring(var_5_4),
			[StatEnum.EventProperties.RefuteStepId] = tostring(arg_5_0.viewParam.stepId),
			[StatEnum.EventProperties.ClueInteractiveResult] = "Fail",
			[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
			[StatEnum.EventProperties.HoldClueName] = var_5_1
		})

		local var_5_5 = {
			groupId = var_5_4,
			stepId = arg_5_0.viewParam.stepId,
			type = arg_5_0.viewParam.type,
			clueId = var_5_3
		}

		AergusiDialogModel.instance:addErrorOperate(var_5_5)
		GameFacade.showToast(ToastEnum.Act163EvidenceWrongClue)
	end

	if arg_5_0.viewParam.callback then
		arg_5_0.viewParam.callback(arg_5_0.viewParam.callbackObj, var_5_0)
	end

	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._evidenceAnim = arg_6_0._goevidence:GetComponent(typeof(UnityEngine.Animator))
	arg_6_0._descItems = {}

	arg_6_0:_addEvents()
end

function var_0_0.onOpen(arg_7_0)
	gohelper.setActive(arg_7_0._gocluedetail, true)

	arg_7_0._isInEpisode = arg_7_0.viewParam and arg_7_0.viewParam.episodeId > 0

	arg_7_0:_refreshDetail()
end

function var_0_0._refreshDetail(arg_8_0)
	local var_8_0 = false

	if arg_8_0.viewParam and arg_8_0.viewParam.type and (arg_8_0.viewParam.type == AergusiEnum.OperationType.Submit or arg_8_0.viewParam.type == AergusiEnum.OperationType.Refutation) then
		var_8_0 = true
	end

	gohelper.setActive(arg_8_0._btnevidence.gameObject, var_8_0)

	local var_8_1 = AergusiModel.instance:getCurClueId()
	local var_8_2 = AergusiConfig.instance:getClueConfig(var_8_1)

	arg_8_0._simageclueitem:LoadImage(ResUrl.getV2a1AergusiSingleBg(var_8_2.clueIcon))

	arg_8_0._txtcluename.text = var_8_2.clueName

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._descItems) do
		iter_8_1:hide()
	end

	local var_8_3 = string.split(var_8_2.clueDesc, "|")

	for iter_8_2 = 1, #var_8_3 do
		if not arg_8_0._descItems[iter_8_2] then
			local var_8_4 = gohelper.cloneInPlace(arg_8_0._godescitem, "item" .. iter_8_2)

			arg_8_0._descItems[iter_8_2] = AergusiClueDescItem.New()

			arg_8_0._descItems[iter_8_2]:init(var_8_4)
		end

		arg_8_0._descItems[iter_8_2]:refreshItem(var_8_3[iter_8_2])
	end

	if arg_8_0._isInEpisode and AergusiDialogModel.instance:isCurClueHasOperateError(arg_8_0.viewParam.stepId, var_8_1) or false then
		UISpriteSetMgr.instance:setV2a1AergusiSprite(arg_8_0._imageEvidence, "v2a1_aergusi_clue_btn2")
	else
		UISpriteSetMgr.instance:setV2a1AergusiSprite(arg_8_0._imageEvidence, "v2a1_aergusi_clue_btn1")
	end
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0._addEvents(arg_10_0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickClueItem, arg_10_0._onClickClue, arg_10_0)
	AergusiController.instance:registerCallback(AergusiEvent.OnPlayMergeSuccess, arg_10_0._onPlayMergeSuccess, arg_10_0)
	AergusiController.instance:registerCallback(AergusiEvent.OnPlayPromptTip, arg_10_0._refreshDetail, arg_10_0)
end

function var_0_0._removeEvents(arg_11_0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickClueItem, arg_11_0._onClickClue, arg_11_0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnPlayMergeSuccess, arg_11_0._onPlayMergeSuccess, arg_11_0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnPlayPromptTip, arg_11_0._refreshDetail, arg_11_0)
end

function var_0_0._onClickClue(arg_12_0)
	arg_12_0._evidenceAnim:Play("switch", 0, 0)
	TaskDispatcher.runDelay(arg_12_0._refreshDetail, arg_12_0, 0.2)
end

function var_0_0._onPlayMergeSuccess(arg_13_0, arg_13_1)
	arg_13_0._evidenceAnim:Play("open", 0, 0)
	arg_13_0:_refreshDetail()
	UIBlockMgr.instance:startBlock("waitOpen")
	TaskDispatcher.runDelay(function()
		UIBlockMgr.instance:endBlock("waitOpen")
		AergusiController.instance:dispatchEvent(AergusiEvent.OnPlayClueItemNewMerge, arg_13_1)
	end, nil, 0.5)
end

function var_0_0.onDestroyView(arg_15_0)
	UIBlockMgr.instance:endBlock("waitOpen")
	TaskDispatcher.cancelTask(arg_15_0._refreshDetail, arg_15_0)
	arg_15_0._simageclueitem:UnLoadImage()
	arg_15_0:_removeEvents()

	if arg_15_0._descItems then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._descItems) do
			iter_15_1:destroy()
		end

		arg_15_0._descItems = nil
	end
end

return var_0_0
