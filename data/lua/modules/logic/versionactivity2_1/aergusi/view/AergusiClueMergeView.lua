module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueMergeView", package.seeall)

slot0 = class("AergusiClueMergeView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocluemerge = gohelper.findChild(slot0.viewGO, "Right/#go_cluemerge")
	slot0._simagenotebg2 = gohelper.findChildSingleImage(slot0.viewGO, "Right/#go_cluemerge/#simage_notebg2")
	slot0._btnmergeclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_cluemerge/#btn_mergeclose")
	slot0._gofailedtips = gohelper.findChild(slot0.viewGO, "Right/#go_cluemerge/#go_failedtips")
	slot0._btnok = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_cluemerge/#btn_ok")
	slot0._btnlocked = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_cluemerge/#btn_locked")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnmergeclose:AddClickListener(slot0._btnmergecloseOnClick, slot0)
	slot0._btnok:AddClickListener(slot0._btnokOnClick, slot0)
	slot0._btnlocked:AddClickListener(slot0._btnlockedOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnmergeclose:RemoveClickListener()
	slot0._btnok:RemoveClickListener()
	slot0._btnlocked:RemoveClickListener()
end

function slot0._btnmergecloseOnClick(slot0)
	slot0._mergeAni:Play("close", 0, 0)
	TaskDispatcher.runDelay(slot0._realCloseClueMerge, slot0, 0.34)
end

function slot0._realCloseClueMerge(slot0)
	AergusiModel.instance:setMergeClueOpen(false)
	AergusiModel.instance:clearMergePosState()

	for slot4 = 1, 2 do
		slot0._clueMergeItems[slot4]:refreshItem()
	end

	gohelper.setActive(slot0._gocluemerge, false)
	AergusiController.instance:dispatchEvent(AergusiEvent.OnClickCloseMergeClue)
end

function slot0._btnokOnClick(slot0)
	slot1 = AergusiModel.instance:getMergeClues()
	slot0._targetClue = AergusiModel.instance:getTargetMergeClue(slot1[1], slot1[2])

	if slot0._targetClue > 0 then
		Activity163Rpc.instance:sendAct163EvidenceOperationRequest(VersionActivity2_1Enum.ActivityId.Aergusi, slot0.viewParam.episodeId, AergusiEnum.OperationType.Merge, string.format("%s#%s#%s", slot1[1], slot1[2], slot0._targetClue), slot0._mergeSuccess, slot0)
	else
		logError(string.format("线索%s与线索%s没法融合，请重新选择需要融合的线索！", slot1[1], slot1[2]))
	end
end

function slot0._mergeSuccess(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_hybrid)
	slot0._mergeAni:Play("merge", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("clueMerge")
	TaskDispatcher.runDelay(slot0._mergeFinished, slot0, 0.83)
end

function slot0._mergeFinished(slot0)
	AergusiModel.instance:setCurClueId(slot0._targetClue)
	AergusiModel.instance:clearMergePosState()
	AergusiController.instance:dispatchEvent(AergusiEvent.OnPlayMergeSuccess, slot0._targetClue)
	TaskDispatcher.runDelay(function ()
		AergusiModel.instance:setMergeClueOpen(false)
		AergusiModel.instance:clearMergePosState()

		for slot3 = 1, 2 do
			uv0._clueMergeItems[slot3]:refreshItem()
		end

		gohelper.setActive(uv0._gocluemerge, false)
		UIBlockMgr.instance:endBlock("clueMerge")
		AergusiController.instance:dispatchEvent(AergusiEvent.OnGuideClueMergeSuccess)
	end, nil, 0.83)
end

function slot0._btnlockedOnClick(slot0)
end

function slot0._editableInitView(slot0)
	slot0:_addEvents()

	slot0._mergeAni = slot0._gocluemerge:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.onOpen(slot0)
	AergusiModel.instance:clearMergePosState()

	slot0._clueMergeItems = {}

	for slot4 = 1, 2 do
		slot0._clueMergeItems[slot4] = AergusiClueMergeEvidenceItem.New()

		slot0._clueMergeItems[slot4]:init(gohelper.findChild(slot0.viewGO, "Right/#go_cluemerge/evidence" .. slot4), slot4)
	end

	gohelper.setActive(slot0._gocluemerge, false)
end

function slot0._refreshMerge(slot0)
	slot2 = AergusiModel.instance:getMergeClues()[1] > 0 and slot1[2] > 0
	slot4 = slot2 and AergusiModel.instance:getTargetMergeClue(slot1[1], slot1[2]) > 0

	gohelper.setActive(slot0._btnok.gameObject, slot4)
	gohelper.setActive(slot0._btnlocked.gameObject, not slot4 and not slot2)
	gohelper.setActive(slot0._gofailedtips.gameObject, not slot4 and slot2)
end

function slot0.onClose(slot0)
end

function slot0._addEvents(slot0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickStartMergeClue, slot0._onShowMerge, slot0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickClueMergeSelect, slot0._refreshMerge, slot0)
end

function slot0._removeEvents(slot0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickStartMergeClue, slot0._onShowMerge, slot0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickClueMergeSelect, slot0._refreshMerge, slot0)
end

function slot0._onShowMerge(slot0)
	slot0._mergeAni:Play("open", 0, 0)
	gohelper.setActive(slot0._gocluemerge, true)
end

function slot0.onDestroyView(slot0)
	UIBlockMgr.instance:endBlock("clueMerge")
	TaskDispatcher.cancelTask(slot0._realCloseClueMerge, slot0)

	if slot0._clueMergeItems then
		for slot4, slot5 in pairs(slot0._clueMergeItems) do
			slot5:destroy()
		end

		slot0._clueMergeItems = nil
	end

	slot0:_removeEvents()
end

return slot0
