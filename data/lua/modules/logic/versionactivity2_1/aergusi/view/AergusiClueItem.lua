module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueItem", package.seeall)

slot0 = class("AergusiClueItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2)
	slot0.go = slot1
	slot0._index = slot2
	slot0._simageclue = gohelper.findChildSingleImage(slot0.go, "#simage_clue")
	slot0._gorefresh = gohelper.findChild(slot0.go, "vx_refresh")
	slot0._goindexbg = gohelper.findChild(slot0.go, "indexbg")
	slot0._txtindex = gohelper.findChildText(slot0.go, "#txt_index")
	slot0._goselect = gohelper.findChild(slot0.go, "selectframe")
	slot0._goselectani = gohelper.findChild(slot0.go, "selectframe/ani")
	slot0._gomaskgrey = gohelper.findChild(slot0.go, "mask_grey")
	slot0._gonew = gohelper.findChild(slot0.go, "#go_new")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.go, "#btn_click")
	slot0._txtindex.text = slot0._index

	gohelper.setAsFirstSibling(slot0.go)
	gohelper.setActive(slot0._gonew, false)
	gohelper.setActive(slot0._gorefresh, false)

	slot0._hasRefresh = false

	slot0:_addEvents()
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.showTips(slot0, slot1)
	slot0._showTip = slot1

	TaskDispatcher.cancelTask(slot0._reshowAni, slot0)

	if slot1 then
		gohelper.setActive(slot0._goselect, true)
		gohelper.setActive(slot0._goselectani, true)
		TaskDispatcher.runRepeat(slot0._reshowAni, slot0, 2)
	else
		gohelper.setActive(slot0._goselect, false)
	end
end

function slot0.getClueId(slot0)
	return slot0._clueConfig.clueId
end

function slot0._reshowAni(slot0)
	gohelper.setActive(slot0._goselectani, false)
	gohelper.setActive(slot0._goselectani, true)
end

function slot0.refresh(slot0, slot1, slot2)
	if not slot0._clueConfig or slot0._clueConfig.clueId ~= slot1.clueId then
		slot0._hasRefresh = false
	end

	slot0._clueConfig = slot1
	slot0._stepId = slot2

	gohelper.setActive(slot0.go, true)
	slot0:_sendReadClue()
	slot0:_refreshItem()
end

function slot0._btnClickOnClick(slot0)
	if slot0._inEpisode and AergusiDialogModel.instance:isCurClueHasOperateError(slot0._stepId, slot0._clueConfig.clueId) or false then
		GameFacade.showToast(ToastEnum.Act163ChangeClue)
	end

	slot0._hasRefresh = false

	if AergusiModel.instance:isMergeClueOpen() then
		if AergusiModel.instance:isClueInMerge(slot0._clueConfig.clueId) then
			return
		end

		if AergusiModel.instance:getSelectPos() <= 0 then
			return
		end

		AergusiModel.instance:setClueMergePosClueId(slot4, slot0._clueConfig.clueId)
		AergusiController.instance:dispatchEvent(AergusiEvent.OnClickClueMergeSelect)
	else
		AergusiModel.instance:setCurClueId(slot0._clueConfig.clueId)

		if slot0._inEpisode and slot0._clueConfig.clueId == AergusiEnum.AdamClueId then
			slot3, slot4 = AergusiDialogModel.instance:getCurDialogProcess()

			if slot3 == AergusiEnum.FirstGroupId and slot4 == AergusiEnum.FirstGroupLastStepId then
				AergusiController.instance:dispatchEvent(AergusiEvent.OnGuideSelectAdam)
			end
		end

		AergusiController.instance:dispatchEvent(AergusiEvent.OnClickClueItem)
	end

	slot0:_sendReadClue()
end

function slot0._sendReadClue(slot0)
	if not slot0._hasRefresh and not AergusiModel.instance:isClueReaded(slot0._clueConfig.clueId) and AergusiModel.instance:getCurClueId() == slot0._clueConfig.clueId then
		if slot0._inEpisode then
			Activity163Rpc.instance:sendAct163EvidenceOperationRequest(VersionActivity2_1Enum.ActivityId.Aergusi, AergusiModel.instance:getCurEpisode(), AergusiEnum.OperationType.New, string.format("%s", slot0._clueConfig.clueId))
		else
			Activity163Rpc.instance:sendAct163ReadClueRequest(slot3, slot0._clueConfig.clueId)
		end
	end

	slot0._hasRefresh = true
end

function slot0.setInEpisode(slot0, slot1)
	slot0._inEpisode = slot1
end

function slot0._refreshItem(slot0)
	slot3 = AergusiModel.instance:getCurClueId()

	if AergusiModel.instance:isMergeClueOpen() then
		slot5 = AergusiModel.instance:isClueInMerge(slot0._clueConfig.clueId) or (slot0._inEpisode and AergusiDialogModel.instance:isCurClueHasOperateError(slot0._stepId, slot0._clueConfig.clueId) or false)

		gohelper.setActive(slot0._gomaskgrey, slot5)

		slot6 = slot5 and 1 or 0

		ZProj.UGUIHelper.SetGrayFactor(slot0._simageclue.gameObject, slot6)
		ZProj.UGUIHelper.SetGrayFactor(slot0._goindexbg, slot6)
		gohelper.setActive(slot0._goselect, slot0._showTip)
		gohelper.setActive(slot0._goselectani, slot0._showTip)
	else
		gohelper.setActive(slot0._gomaskgrey, slot1)

		slot4 = slot1 and 1 or 0

		ZProj.UGUIHelper.SetGrayFactor(slot0._simageclue.gameObject, slot4)
		ZProj.UGUIHelper.SetGrayFactor(slot0._goindexbg, slot4)
		gohelper.setActive(slot0._goselect, slot3 == slot0._clueConfig.clueId or slot0._showTip)
		gohelper.setActive(slot0._goselectani, slot0._showTip)
		slot0._simageclue:LoadImage(ResUrl.getV2a1AergusiSingleBg(slot0._clueConfig.clueIcon))
	end

	gohelper.setActive(slot0._gonew, not AergusiModel.instance:isClueReaded(slot0._clueConfig.clueId))
end

function slot0._addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnClickOnClick, slot0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickStartMergeClue, slot0._onStartMergeClue, slot0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClueReadUpdate, slot0._refreshItem, slot0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickClueItem, slot0._onClickClueItem, slot0)
	AergusiController.instance:registerCallback(AergusiEvent.OnPlayClueItemNewMerge, slot0._onPlayClueItemNewMerge, slot0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickClueMergeItem, slot0._refreshItem, slot0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickClueMergeSelect, slot0._refreshItem, slot0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickCloseMergeClue, slot0._refreshItem, slot0)
end

function slot0._removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickStartMergeClue, slot0._onStartMergeClue, slot0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClueReadUpdate, slot0._refreshItem, slot0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickClueItem, slot0._onClickClueItem, slot0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnPlayClueItemNewMerge, slot0._onPlayClueItemNewMerge, slot0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickClueMergeItem, slot0._refreshItem, slot0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickClueMergeSelect, slot0._refreshItem, slot0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickCloseMergeClue, slot0._refreshItem, slot0)
end

function slot0._onClickClueItem(slot0)
	slot0:_refreshItem()
end

function slot0._onStartMergeClue(slot0)
	slot0:_refreshItem()
end

function slot0._onPlayClueItemNewMerge(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._reshowAni, slot0)

	if slot1 == slot0._clueConfig.clueId then
		gohelper.setActive(slot0._gorefresh, true)
		gohelper.setActive(slot0._goselect, true)
		slot0:_refreshItem()
	else
		TaskDispatcher.cancelTask(slot0._reshowAni, slot0)

		slot0._showTip = false

		gohelper.setActive(slot0._gorefresh, false)
		gohelper.setActive(slot0._goselect, false)
	end
end

function slot0.destroy(slot0)
	TaskDispatcher.cancelTask(slot0._reshowAni, slot0)
	slot0._simageclue:UnLoadImage()
	slot0:_removeEvents()
end

return slot0
