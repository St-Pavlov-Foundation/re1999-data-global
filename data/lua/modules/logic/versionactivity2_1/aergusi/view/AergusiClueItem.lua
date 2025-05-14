module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueItem", package.seeall)

local var_0_0 = class("AergusiClueItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0._index = arg_1_2
	arg_1_0._simageclue = gohelper.findChildSingleImage(arg_1_0.go, "#simage_clue")
	arg_1_0._gorefresh = gohelper.findChild(arg_1_0.go, "vx_refresh")
	arg_1_0._goindexbg = gohelper.findChild(arg_1_0.go, "indexbg")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.go, "#txt_index")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.go, "selectframe")
	arg_1_0._goselectani = gohelper.findChild(arg_1_0.go, "selectframe/ani")
	arg_1_0._gomaskgrey = gohelper.findChild(arg_1_0.go, "mask_grey")
	arg_1_0._gonew = gohelper.findChild(arg_1_0.go, "#go_new")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.go, "#btn_click")
	arg_1_0._txtindex.text = arg_1_0._index

	gohelper.setAsFirstSibling(arg_1_0.go)
	gohelper.setActive(arg_1_0._gonew, false)
	gohelper.setActive(arg_1_0._gorefresh, false)

	arg_1_0._hasRefresh = false

	arg_1_0:_addEvents()
end

function var_0_0.hide(arg_2_0)
	gohelper.setActive(arg_2_0.go, false)
end

function var_0_0.showTips(arg_3_0, arg_3_1)
	arg_3_0._showTip = arg_3_1

	TaskDispatcher.cancelTask(arg_3_0._reshowAni, arg_3_0)

	if arg_3_1 then
		gohelper.setActive(arg_3_0._goselect, true)
		gohelper.setActive(arg_3_0._goselectani, true)
		TaskDispatcher.runRepeat(arg_3_0._reshowAni, arg_3_0, 2)
	else
		gohelper.setActive(arg_3_0._goselect, false)
	end
end

function var_0_0.getClueId(arg_4_0)
	return arg_4_0._clueConfig.clueId
end

function var_0_0._reshowAni(arg_5_0)
	gohelper.setActive(arg_5_0._goselectani, false)
	gohelper.setActive(arg_5_0._goselectani, true)
end

function var_0_0.refresh(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0._clueConfig or arg_6_0._clueConfig.clueId ~= arg_6_1.clueId then
		arg_6_0._hasRefresh = false
	end

	arg_6_0._clueConfig = arg_6_1
	arg_6_0._stepId = arg_6_2

	gohelper.setActive(arg_6_0.go, true)
	arg_6_0:_sendReadClue()
	arg_6_0:_refreshItem()
end

function var_0_0._btnClickOnClick(arg_7_0)
	if arg_7_0._inEpisode and AergusiDialogModel.instance:isCurClueHasOperateError(arg_7_0._stepId, arg_7_0._clueConfig.clueId) or false then
		GameFacade.showToast(ToastEnum.Act163ChangeClue)
	end

	arg_7_0._hasRefresh = false

	if AergusiModel.instance:isMergeClueOpen() then
		if AergusiModel.instance:isClueInMerge(arg_7_0._clueConfig.clueId) then
			return
		end

		local var_7_0 = AergusiModel.instance:getSelectPos()

		if var_7_0 <= 0 then
			return
		end

		AergusiModel.instance:setClueMergePosClueId(var_7_0, arg_7_0._clueConfig.clueId)
		AergusiController.instance:dispatchEvent(AergusiEvent.OnClickClueMergeSelect)
	else
		AergusiModel.instance:setCurClueId(arg_7_0._clueConfig.clueId)

		if arg_7_0._inEpisode and arg_7_0._clueConfig.clueId == AergusiEnum.AdamClueId then
			local var_7_1, var_7_2 = AergusiDialogModel.instance:getCurDialogProcess()

			if var_7_1 == AergusiEnum.FirstGroupId and var_7_2 == AergusiEnum.FirstGroupLastStepId then
				AergusiController.instance:dispatchEvent(AergusiEvent.OnGuideSelectAdam)
			end
		end

		AergusiController.instance:dispatchEvent(AergusiEvent.OnClickClueItem)
	end

	arg_7_0:_sendReadClue()
end

function var_0_0._sendReadClue(arg_8_0)
	local var_8_0 = AergusiModel.instance:getCurClueId()
	local var_8_1 = AergusiModel.instance:isClueReaded(arg_8_0._clueConfig.clueId)

	if not arg_8_0._hasRefresh and not var_8_1 and var_8_0 == arg_8_0._clueConfig.clueId then
		local var_8_2 = VersionActivity2_1Enum.ActivityId.Aergusi

		if arg_8_0._inEpisode then
			local var_8_3 = AergusiModel.instance:getCurEpisode()
			local var_8_4 = AergusiEnum.OperationType.New
			local var_8_5 = string.format("%s", arg_8_0._clueConfig.clueId)

			Activity163Rpc.instance:sendAct163EvidenceOperationRequest(var_8_2, var_8_3, var_8_4, var_8_5)
		else
			Activity163Rpc.instance:sendAct163ReadClueRequest(var_8_2, arg_8_0._clueConfig.clueId)
		end
	end

	arg_8_0._hasRefresh = true
end

function var_0_0.setInEpisode(arg_9_0, arg_9_1)
	arg_9_0._inEpisode = arg_9_1
end

function var_0_0._refreshItem(arg_10_0)
	local var_10_0 = arg_10_0._inEpisode and AergusiDialogModel.instance:isCurClueHasOperateError(arg_10_0._stepId, arg_10_0._clueConfig.clueId) or false
	local var_10_1 = AergusiModel.instance:isMergeClueOpen()
	local var_10_2 = AergusiModel.instance:getCurClueId()

	if var_10_1 then
		local var_10_3 = AergusiModel.instance:isClueInMerge(arg_10_0._clueConfig.clueId) or var_10_0

		gohelper.setActive(arg_10_0._gomaskgrey, var_10_3)

		local var_10_4 = var_10_3 and 1 or 0

		ZProj.UGUIHelper.SetGrayFactor(arg_10_0._simageclue.gameObject, var_10_4)
		ZProj.UGUIHelper.SetGrayFactor(arg_10_0._goindexbg, var_10_4)
		gohelper.setActive(arg_10_0._goselect, arg_10_0._showTip)
		gohelper.setActive(arg_10_0._goselectani, arg_10_0._showTip)
	else
		gohelper.setActive(arg_10_0._gomaskgrey, var_10_0)

		local var_10_5 = var_10_0 and 1 or 0

		ZProj.UGUIHelper.SetGrayFactor(arg_10_0._simageclue.gameObject, var_10_5)
		ZProj.UGUIHelper.SetGrayFactor(arg_10_0._goindexbg, var_10_5)
		gohelper.setActive(arg_10_0._goselect, var_10_2 == arg_10_0._clueConfig.clueId or arg_10_0._showTip)
		gohelper.setActive(arg_10_0._goselectani, arg_10_0._showTip)
		arg_10_0._simageclue:LoadImage(ResUrl.getV2a1AergusiSingleBg(arg_10_0._clueConfig.clueIcon))
	end

	local var_10_6 = AergusiModel.instance:isClueReaded(arg_10_0._clueConfig.clueId)

	gohelper.setActive(arg_10_0._gonew, not var_10_6)
end

function var_0_0._addEvents(arg_11_0)
	arg_11_0._btnclick:AddClickListener(arg_11_0._btnClickOnClick, arg_11_0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickStartMergeClue, arg_11_0._onStartMergeClue, arg_11_0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClueReadUpdate, arg_11_0._refreshItem, arg_11_0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickClueItem, arg_11_0._onClickClueItem, arg_11_0)
	AergusiController.instance:registerCallback(AergusiEvent.OnPlayClueItemNewMerge, arg_11_0._onPlayClueItemNewMerge, arg_11_0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickClueMergeItem, arg_11_0._refreshItem, arg_11_0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickClueMergeSelect, arg_11_0._refreshItem, arg_11_0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickCloseMergeClue, arg_11_0._refreshItem, arg_11_0)
end

function var_0_0._removeEvents(arg_12_0)
	arg_12_0._btnclick:RemoveClickListener()
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickStartMergeClue, arg_12_0._onStartMergeClue, arg_12_0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClueReadUpdate, arg_12_0._refreshItem, arg_12_0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickClueItem, arg_12_0._onClickClueItem, arg_12_0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnPlayClueItemNewMerge, arg_12_0._onPlayClueItemNewMerge, arg_12_0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickClueMergeItem, arg_12_0._refreshItem, arg_12_0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickClueMergeSelect, arg_12_0._refreshItem, arg_12_0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickCloseMergeClue, arg_12_0._refreshItem, arg_12_0)
end

function var_0_0._onClickClueItem(arg_13_0)
	arg_13_0:_refreshItem()
end

function var_0_0._onStartMergeClue(arg_14_0)
	arg_14_0:_refreshItem()
end

function var_0_0._onPlayClueItemNewMerge(arg_15_0, arg_15_1)
	TaskDispatcher.cancelTask(arg_15_0._reshowAni, arg_15_0)

	if arg_15_1 == arg_15_0._clueConfig.clueId then
		gohelper.setActive(arg_15_0._gorefresh, true)
		gohelper.setActive(arg_15_0._goselect, true)
		arg_15_0:_refreshItem()
	else
		TaskDispatcher.cancelTask(arg_15_0._reshowAni, arg_15_0)

		arg_15_0._showTip = false

		gohelper.setActive(arg_15_0._gorefresh, false)
		gohelper.setActive(arg_15_0._goselect, false)
	end
end

function var_0_0.destroy(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._reshowAni, arg_16_0)
	arg_16_0._simageclue:UnLoadImage()
	arg_16_0:_removeEvents()
end

return var_0_0
