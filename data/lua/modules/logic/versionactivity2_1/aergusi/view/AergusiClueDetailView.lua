module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueDetailView", package.seeall)

slot0 = class("AergusiClueDetailView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocluedetail = gohelper.findChild(slot0.viewGO, "Right/#go_cluedetail")
	slot0._goevidence = gohelper.findChild(slot0.viewGO, "Right/#go_cluedetail/evidence")
	slot0._simageclueitem = gohelper.findChildSingleImage(slot0.viewGO, "Right/#go_cluedetail/evidence/#simage_clueitem")
	slot0._txtcluename = gohelper.findChildText(slot0.viewGO, "Right/#go_cluedetail/evidence/#txt_cluename")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "Right/#go_cluedetail/#scroll_desc")
	slot0._godesccontent = gohelper.findChild(slot0.viewGO, "Right/#go_cluedetail/#scroll_desc/Viewport/#go_desccontent")
	slot0._godescitem = gohelper.findChild(slot0.viewGO, "Right/#go_cluedetail/#scroll_desc/Viewport/#go_desccontent/#go_descitem")
	slot0._btnevidence = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_cluedetail/#btn_evidence")
	slot0._imageEvidence = gohelper.findChildImage(slot0.viewGO, "Right/#go_cluedetail/#btn_evidence")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnevidence:AddClickListener(slot0._btnevidenceOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnevidence:RemoveClickListener()
end

function slot0._btnevidenceOnClick(slot0)
	Activity163Rpc.instance:sendAct163EvidenceOperationRequest(VersionActivity2_1Enum.ActivityId.Aergusi, slot0.viewParam.episodeId, slot0.viewParam.type, string.format("%s#%s", slot0.viewParam.stepId, AergusiModel.instance:getCurClueId()), slot0._evidenceFinished, slot0)
end

function slot0._evidenceFinished(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	slot4 = 0

	for slot10, slot11 in pairs(AergusiModel.instance.instance:getEpisodeClueConfigs(slot0.viewParam.episodeId, true)) do
		table.insert({}, slot11.clueName)
	end

	slot7 = AergusiModel.instance:getCurClueId()
	slot8 = AergusiDialogModel.instance:getCurDialogGroup()

	if slot3.operationResult == "0" then
		slot4 = slot0.viewParam.groupId

		StatController.instance:track(StatEnum.EventName.AergusiClueInteractive, {
			[StatEnum.EventProperties.EpisodeId] = tostring(slot0.viewParam.episodeId),
			[StatEnum.EventProperties.ClueInteractiveType] = slot0.viewParam.type == AergusiEnum.OperationType.Refutation and "Refute" or "Evidence",
			[StatEnum.EventProperties.TargetTip] = AergusiConfig.instance:getEvidenceConfig(slot8).conditionStr,
			[StatEnum.EventProperties.ClueId] = tostring(slot7),
			[StatEnum.EventProperties.ClueName] = AergusiConfig.instance:getClueConfig(slot7).clueName,
			[StatEnum.EventProperties.RefuteDialogId] = tostring(slot8),
			[StatEnum.EventProperties.RefuteStepId] = tostring(slot0.viewParam.stepId),
			[StatEnum.EventProperties.ClueInteractiveResult] = "Success",
			[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
			[StatEnum.EventProperties.HoldClueName] = slot5
		})
	else
		StatController.instance:track(StatEnum.EventName.AergusiClueInteractive, {
			[StatEnum.EventProperties.EpisodeId] = tostring(slot0.viewParam.episodeId),
			[StatEnum.EventProperties.ClueInteractiveType] = slot0.viewParam.type == AergusiEnum.OperationType.Refutation and "Refute" or "Evidence",
			[StatEnum.EventProperties.TargetTip] = AergusiConfig.instance:getEvidenceConfig(slot8).conditionStr,
			[StatEnum.EventProperties.ClueId] = tostring(slot7),
			[StatEnum.EventProperties.ClueName] = AergusiConfig.instance:getClueConfig(slot7).clueName,
			[StatEnum.EventProperties.RefuteDialogId] = tostring(slot8),
			[StatEnum.EventProperties.RefuteStepId] = tostring(slot0.viewParam.stepId),
			[StatEnum.EventProperties.ClueInteractiveResult] = "Fail",
			[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
			[StatEnum.EventProperties.HoldClueName] = slot5
		})
		AergusiDialogModel.instance:addErrorOperate({
			groupId = slot8,
			stepId = slot0.viewParam.stepId,
			type = slot0.viewParam.type,
			clueId = slot7
		})
		GameFacade.showToast(ToastEnum.Act163EvidenceWrongClue)
	end

	if slot0.viewParam.callback then
		slot0.viewParam.callback(slot0.viewParam.callbackObj, slot4)
	end

	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._evidenceAnim = slot0._goevidence:GetComponent(typeof(UnityEngine.Animator))
	slot0._descItems = {}

	slot0:_addEvents()
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._gocluedetail, true)

	slot0._isInEpisode = slot0.viewParam and slot0.viewParam.episodeId > 0

	slot0:_refreshDetail()
end

function slot0._refreshDetail(slot0)
	slot1 = false

	if slot0.viewParam and slot0.viewParam.type and (slot0.viewParam.type == AergusiEnum.OperationType.Submit or slot0.viewParam.type == AergusiEnum.OperationType.Refutation) then
		slot1 = true
	end

	gohelper.setActive(slot0._btnevidence.gameObject, slot1)

	slot3 = AergusiConfig.instance:getClueConfig(AergusiModel.instance:getCurClueId())
	slot7 = slot3.clueIcon

	slot0._simageclueitem:LoadImage(ResUrl.getV2a1AergusiSingleBg(slot7))

	slot0._txtcluename.text = slot3.clueName

	for slot7, slot8 in ipairs(slot0._descItems) do
		slot8:hide()
	end

	for slot8 = 1, #string.split(slot3.clueDesc, "|") do
		if not slot0._descItems[slot8] then
			slot0._descItems[slot8] = AergusiClueDescItem.New()

			slot0._descItems[slot8]:init(gohelper.cloneInPlace(slot0._godescitem, "item" .. slot8))
		end

		slot0._descItems[slot8]:refreshItem(slot4[slot8])
	end

	if slot0._isInEpisode and AergusiDialogModel.instance:isCurClueHasOperateError(slot0.viewParam.stepId, slot2) or false then
		UISpriteSetMgr.instance:setV2a1AergusiSprite(slot0._imageEvidence, "v2a1_aergusi_clue_btn2")
	else
		UISpriteSetMgr.instance:setV2a1AergusiSprite(slot0._imageEvidence, "v2a1_aergusi_clue_btn1")
	end
end

function slot0.onClose(slot0)
end

function slot0._addEvents(slot0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickClueItem, slot0._onClickClue, slot0)
	AergusiController.instance:registerCallback(AergusiEvent.OnPlayMergeSuccess, slot0._onPlayMergeSuccess, slot0)
	AergusiController.instance:registerCallback(AergusiEvent.OnPlayPromptTip, slot0._refreshDetail, slot0)
end

function slot0._removeEvents(slot0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickClueItem, slot0._onClickClue, slot0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnPlayMergeSuccess, slot0._onPlayMergeSuccess, slot0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnPlayPromptTip, slot0._refreshDetail, slot0)
end

function slot0._onClickClue(slot0)
	slot0._evidenceAnim:Play("switch", 0, 0)
	TaskDispatcher.runDelay(slot0._refreshDetail, slot0, 0.2)
end

function slot0._onPlayMergeSuccess(slot0, slot1)
	slot0._evidenceAnim:Play("open", 0, 0)
	slot0:_refreshDetail()
	UIBlockMgr.instance:startBlock("waitOpen")
	TaskDispatcher.runDelay(function ()
		UIBlockMgr.instance:endBlock("waitOpen")
		AergusiController.instance:dispatchEvent(AergusiEvent.OnPlayClueItemNewMerge, uv0)
	end, nil, 0.5)
end

function slot0.onDestroyView(slot0)
	UIBlockMgr.instance:endBlock("waitOpen")
	TaskDispatcher.cancelTask(slot0._refreshDetail, slot0)
	slot0._simageclueitem:UnLoadImage()
	slot0:_removeEvents()

	if slot0._descItems then
		for slot4, slot5 in pairs(slot0._descItems) do
			slot5:destroy()
		end

		slot0._descItems = nil
	end
end

return slot0
