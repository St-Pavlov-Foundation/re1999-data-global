module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueMergeView", package.seeall)

local var_0_0 = class("AergusiClueMergeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocluemerge = gohelper.findChild(arg_1_0.viewGO, "Right/#go_cluemerge")
	arg_1_0._simagenotebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#go_cluemerge/#simage_notebg2")
	arg_1_0._btnmergeclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_cluemerge/#btn_mergeclose")
	arg_1_0._gofailedtips = gohelper.findChild(arg_1_0.viewGO, "Right/#go_cluemerge/#go_failedtips")
	arg_1_0._btnok = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_cluemerge/#btn_ok")
	arg_1_0._btnlocked = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_cluemerge/#btn_locked")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnmergeclose:AddClickListener(arg_2_0._btnmergecloseOnClick, arg_2_0)
	arg_2_0._btnok:AddClickListener(arg_2_0._btnokOnClick, arg_2_0)
	arg_2_0._btnlocked:AddClickListener(arg_2_0._btnlockedOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnmergeclose:RemoveClickListener()
	arg_3_0._btnok:RemoveClickListener()
	arg_3_0._btnlocked:RemoveClickListener()
end

function var_0_0._btnmergecloseOnClick(arg_4_0)
	arg_4_0._mergeAni:Play("close", 0, 0)
	TaskDispatcher.runDelay(arg_4_0._realCloseClueMerge, arg_4_0, 0.34)
end

function var_0_0._realCloseClueMerge(arg_5_0)
	AergusiModel.instance:setMergeClueOpen(false)
	AergusiModel.instance:clearMergePosState()

	for iter_5_0 = 1, 2 do
		arg_5_0._clueMergeItems[iter_5_0]:refreshItem()
	end

	gohelper.setActive(arg_5_0._gocluemerge, false)
	AergusiController.instance:dispatchEvent(AergusiEvent.OnClickCloseMergeClue)
end

function var_0_0._btnokOnClick(arg_6_0)
	local var_6_0 = AergusiModel.instance:getMergeClues()

	arg_6_0._targetClue = AergusiModel.instance:getTargetMergeClue(var_6_0[1], var_6_0[2])

	if arg_6_0._targetClue > 0 then
		local var_6_1 = VersionActivity2_1Enum.ActivityId.Aergusi
		local var_6_2 = arg_6_0.viewParam.episodeId
		local var_6_3 = AergusiEnum.OperationType.Merge
		local var_6_4 = string.format("%s#%s#%s", var_6_0[1], var_6_0[2], arg_6_0._targetClue)
		local var_6_5 = arg_6_0._mergeSuccess
		local var_6_6 = arg_6_0

		Activity163Rpc.instance:sendAct163EvidenceOperationRequest(var_6_1, var_6_2, var_6_3, var_6_4, var_6_5, var_6_6)
	else
		logError(string.format("线索%s与线索%s没法融合，请重新选择需要融合的线索！", var_6_0[1], var_6_0[2]))
	end
end

function var_0_0._mergeSuccess(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_2 ~= 0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_hybrid)
	arg_7_0._mergeAni:Play("merge", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("clueMerge")
	TaskDispatcher.runDelay(arg_7_0._mergeFinished, arg_7_0, 0.83)
end

function var_0_0._mergeFinished(arg_8_0)
	AergusiModel.instance:setCurClueId(arg_8_0._targetClue)
	AergusiModel.instance:clearMergePosState()
	AergusiController.instance:dispatchEvent(AergusiEvent.OnPlayMergeSuccess, arg_8_0._targetClue)
	TaskDispatcher.runDelay(function()
		AergusiModel.instance:setMergeClueOpen(false)
		AergusiModel.instance:clearMergePosState()

		for iter_9_0 = 1, 2 do
			arg_8_0._clueMergeItems[iter_9_0]:refreshItem()
		end

		gohelper.setActive(arg_8_0._gocluemerge, false)
		UIBlockMgr.instance:endBlock("clueMerge")
		AergusiController.instance:dispatchEvent(AergusiEvent.OnGuideClueMergeSuccess)
	end, nil, 0.83)
end

function var_0_0._btnlockedOnClick(arg_10_0)
	return
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0:_addEvents()

	arg_11_0._mergeAni = arg_11_0._gocluemerge:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onOpen(arg_12_0)
	AergusiModel.instance:clearMergePosState()

	arg_12_0._clueMergeItems = {}

	for iter_12_0 = 1, 2 do
		arg_12_0._clueMergeItems[iter_12_0] = AergusiClueMergeEvidenceItem.New()

		local var_12_0 = gohelper.findChild(arg_12_0.viewGO, "Right/#go_cluemerge/evidence" .. iter_12_0)

		arg_12_0._clueMergeItems[iter_12_0]:init(var_12_0, iter_12_0)
	end

	gohelper.setActive(arg_12_0._gocluemerge, false)
end

function var_0_0._refreshMerge(arg_13_0)
	local var_13_0 = AergusiModel.instance:getMergeClues()
	local var_13_1 = var_13_0[1] > 0 and var_13_0[2] > 0
	local var_13_2 = AergusiModel.instance:getTargetMergeClue(var_13_0[1], var_13_0[2])
	local var_13_3 = var_13_1 and var_13_2 > 0

	gohelper.setActive(arg_13_0._btnok.gameObject, var_13_3)
	gohelper.setActive(arg_13_0._btnlocked.gameObject, not var_13_3 and not var_13_1)
	gohelper.setActive(arg_13_0._gofailedtips.gameObject, not var_13_3 and var_13_1)
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0._addEvents(arg_15_0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickStartMergeClue, arg_15_0._onShowMerge, arg_15_0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickClueMergeSelect, arg_15_0._refreshMerge, arg_15_0)
end

function var_0_0._removeEvents(arg_16_0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickStartMergeClue, arg_16_0._onShowMerge, arg_16_0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickClueMergeSelect, arg_16_0._refreshMerge, arg_16_0)
end

function var_0_0._onShowMerge(arg_17_0)
	arg_17_0._mergeAni:Play("open", 0, 0)
	gohelper.setActive(arg_17_0._gocluemerge, true)
end

function var_0_0.onDestroyView(arg_18_0)
	UIBlockMgr.instance:endBlock("clueMerge")
	TaskDispatcher.cancelTask(arg_18_0._realCloseClueMerge, arg_18_0)

	if arg_18_0._clueMergeItems then
		for iter_18_0, iter_18_1 in pairs(arg_18_0._clueMergeItems) do
			iter_18_1:destroy()
		end

		arg_18_0._clueMergeItems = nil
	end

	arg_18_0:_removeEvents()
end

return var_0_0
