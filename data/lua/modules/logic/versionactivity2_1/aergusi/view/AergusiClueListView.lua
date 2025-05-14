module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueListView", package.seeall)

local var_0_0 = class("AergusiClueListView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollclueitems = gohelper.findChildScrollRect(arg_1_0.viewGO, "Left/#scroll_clueitems")
	arg_1_0._goscrollcontent = gohelper.findChild(arg_1_0.viewGO, "Left/#scroll_clueitems/viewport/content")
	arg_1_0._btntimes = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/titlebg/titlecn/#btn_times")
	arg_1_0._gotimegrey = gohelper.findChild(arg_1_0.viewGO, "Left/titlebg/titlecn/#btn_times/grey")
	arg_1_0._txttimes = gohelper.findChildText(arg_1_0.viewGO, "Left/titlebg/titlecn/#btn_times/#txt_times")
	arg_1_0._btnmix = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_mix")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnmix:AddClickListener(arg_2_0._btnmixOnClick, arg_2_0)
	arg_2_0._btntimes:AddClickListener(arg_2_0._btntimesOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnmix:RemoveClickListener()
	arg_3_0._btntimes:RemoveClickListener()
end

function var_0_0._btnmixOnClick(arg_4_0)
	AergusiModel.instance:setMergeClueOpen(true)
	AergusiController.instance:dispatchEvent(AergusiEvent.OnClickStartMergeClue)
end

function var_0_0._btntimesOnClick(arg_5_0)
	if not arg_5_0.viewParam.couldPrompt then
		return
	end

	if AergusiDialogModel.instance:getLeftPromptTimes() <= 0 then
		return
	end

	local var_5_0 = AergusiDialogModel.instance:getNextPromptOperate(true)

	if not var_5_0 then
		local var_5_1 = AergusiDialogModel.instance:getLastPromptOperate(true)

		if not var_5_1 or not var_5_1.clueId or arg_5_0.viewParam.stepId ~= var_5_1.stepId then
			var_5_1 = AergusiDialogModel.instance:getLastPromptOperate(false)

			GameFacade.showToast(ToastEnum.Act163HasTiped)
			AergusiController.instance:dispatchEvent(AergusiEvent.OnClickShowResultTip, var_5_1)
			arg_5_0:closeThis()

			return
		end

		GameFacade.showToast(ToastEnum.Act163HasTiped)
		arg_5_0:_showTipClue(var_5_1.clueId)

		return
	elseif arg_5_0.viewParam.stepId ~= var_5_0.stepId and not AergusiDialogModel.instance:getNextPromptOperate(false) then
		GameFacade.showToast(ToastEnum.Act163HasTiped)

		local var_5_2 = AergusiDialogModel.instance:getLastPromptOperate(false)

		AergusiController.instance:dispatchEvent(AergusiEvent.OnClickShowResultTip, var_5_2)
		arg_5_0:closeThis()

		return
	end

	local var_5_3 = VersionActivity2_1Enum.ActivityId.Aergusi
	local var_5_4 = arg_5_0.viewParam.episodeId
	local var_5_5 = AergusiEnum.OperationType.Tip
	local var_5_6 = ""

	Activity163Rpc.instance:sendAct163EvidenceOperationRequest(var_5_3, var_5_4, var_5_5, var_5_6, arg_5_0._onShowTipFinished, arg_5_0)
end

function var_0_0._onShowTipFinished(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_2 ~= 0 then
		return
	end

	local var_6_0 = AergusiDialogModel.instance:getNextPromptOperate(true)

	if arg_6_0.viewParam.stepId ~= var_6_0.stepId then
		arg_6_0:closeThis()

		var_6_0 = AergusiDialogModel.instance:getNextPromptOperate(false)

		AergusiController.instance:dispatchEvent(AergusiEvent.OnClickShowResultTip, var_6_0)
		AergusiDialogModel.instance:addPromptOperate(var_6_0, false)

		return
	end

	arg_6_0:_showTipClue(var_6_0.clueId)
	AergusiDialogModel.instance:addPromptOperate(var_6_0, true)
end

function var_0_0._showTipClue(arg_7_0, arg_7_1)
	if not arg_7_1 or arg_7_1 <= 0 then
		return
	end

	AergusiModel.instance:setCurClueId(arg_7_1)

	local var_7_0 = AergusiConfig.instance:getClueConfig(arg_7_1)
	local var_7_1 = {}

	table.insert(var_7_1, arg_7_1)

	if var_7_0.materialId ~= "" then
		local var_7_2 = string.splitToNumber(var_7_0.materialId, "#")

		for iter_7_0, iter_7_1 in ipairs(var_7_2) do
			table.insert(var_7_1, iter_7_1)
		end
	end

	for iter_7_2, iter_7_3 in pairs(arg_7_0._clueItems) do
		local var_7_3 = false

		for iter_7_4, iter_7_5 in pairs(var_7_1) do
			if iter_7_3:getClueId() == iter_7_5 then
				var_7_3 = true
			end
		end

		iter_7_3:showTips(var_7_3)
	end

	AergusiController.instance:dispatchEvent(AergusiEvent.OnPlayPromptTip)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._drag = UIDragListenerHelper.New()

	arg_8_0._drag:createByScrollRect(arg_8_0._scrollclueitems.gameObject)
	arg_8_0:_addEvents()

	arg_8_0._clueLines = {}

	for iter_8_0 = 1, 3 do
		local var_8_0 = gohelper.findChild(arg_8_0._scrollclueitems.gameObject, "viewport/content/Line" .. iter_8_0)
		local var_8_1 = {
			go = var_8_0,
			anim = var_8_0:GetComponent(typeof(UnityEngine.Animator)),
			items = {}
		}

		for iter_8_1 = 1, 3 do
			var_8_1.items[iter_8_1] = {}
			var_8_1.items[iter_8_1].root = gohelper.findChild(var_8_1.go, string.format("clue%s_%s", iter_8_0, iter_8_1))

			local var_8_2 = arg_8_0:getResInst(arg_8_0.viewContainer:getSetting().otherRes[1], var_8_1.items[iter_8_1].root, "clueitem")

			var_8_1.items[iter_8_1].go = var_8_2
		end

		arg_8_0._clueLines[iter_8_0] = var_8_1
	end

	arg_8_0._clueItems = {}
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._isInEpisode = arg_9_0.viewParam and arg_9_0.viewParam.episodeId > 0
	arg_9_0._clueConfigs = arg_9_0:_getClueConfigs()

	local var_9_0 = arg_9_0._clueConfigs[1].clueId

	AergusiModel.instance:setCurClueId(var_9_0)
	arg_9_0:_refreshClueRoots()
	arg_9_0:_refreshItem()
	arg_9_0:_refreshBtn()
	arg_9_0:_playRootsAnim("move1")

	if AergusiDialogModel.instance:getUnlockAutoShow() then
		local var_9_1 = AergusiDialogModel.instance:getNextPromptOperate(true)

		if not var_9_1 then
			local var_9_2 = AergusiDialogModel.instance:getLastPromptOperate(true, arg_9_0.viewParam.stepId)

			GameFacade.showToast(ToastEnum.Act163HasTiped)
			arg_9_0:_showTipClue(var_9_2.clueId)

			return
		end

		arg_9_0:_showTipClue(var_9_1.clueId)
	end
end

function var_0_0._playRootsAnim(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._clueLines) do
		iter_10_1.anim:Play(arg_10_1, 0, 0)
	end
end

function var_0_0._refreshClueRoots(arg_11_0)
	local var_11_0 = #arg_11_0._clueConfigs % 3 == 0 and math.floor(#arg_11_0._clueConfigs / 3) or math.floor(#arg_11_0._clueConfigs / 3) + 1

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._clueLines) do
		gohelper.setActive(iter_11_1.go, false)
	end

	for iter_11_2 = 1, var_11_0 do
		if not arg_11_0._clueLines[iter_11_2] then
			local var_11_1 = iter_11_2 % 3 == 0 and 3 or iter_11_2 % 3
			local var_11_2 = gohelper.cloneInPlace(arg_11_0._clueLines[var_11_1].go, "Line" .. tostring(iter_11_2))
			local var_11_3 = {
				go = var_11_2,
				anim = var_11_2:GetComponent(typeof(UnityEngine.Animator)),
				items = {}
			}

			for iter_11_3 = 1, 3 do
				var_11_3.items[iter_11_3] = {}
				var_11_3.items[iter_11_3].root = gohelper.findChild(var_11_3.go, string.format("clue%s_%s", var_11_1, iter_11_3))

				local var_11_4 = gohelper.findChild(var_11_3.items[iter_11_3].root, "clueitem")

				var_11_3.items[iter_11_3].go = var_11_4
			end

			arg_11_0._clueLines[iter_11_2] = var_11_3
		end

		gohelper.setActive(arg_11_0._clueLines[iter_11_2].go, true)
	end

	if #arg_11_0._clueConfigs % 3 > 0 then
		for iter_11_4 = #arg_11_0._clueConfigs % 3, 3 do
			gohelper.setActive(arg_11_0._clueLines[var_11_0].items[iter_11_4].go, false)
		end
	end
end

function var_0_0._getClueConfigs(arg_12_0)
	local var_12_0 = {}

	if arg_12_0._isInEpisode then
		var_12_0 = AergusiModel.instance:getEpisodeClueConfigs(arg_12_0.viewParam.episodeId, arg_12_0._isInEpisode)
	else
		var_12_0 = AergusiModel.instance:getAllClues(arg_12_0._isInEpisode)
	end

	return var_12_0
end

function var_0_0._refreshItem(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0._clueItems) do
		iter_13_1:hide()
	end

	for iter_13_2, iter_13_3 in ipairs(arg_13_0._clueConfigs) do
		if not arg_13_0._clueItems[iter_13_2] then
			local var_13_0 = iter_13_2 % 3 == 0 and math.floor(iter_13_2 / 3) or math.floor(iter_13_2 / 3) + 1
			local var_13_1 = iter_13_2 - 3 * (var_13_0 - 1)
			local var_13_2 = AergusiClueItem.New()
			local var_13_3 = arg_13_0._clueLines[var_13_0].items[var_13_1].go

			var_13_2:init(var_13_3, iter_13_2)

			arg_13_0._clueItems[iter_13_2] = var_13_2
		end

		arg_13_0._clueItems[iter_13_2]:setInEpisode(arg_13_0._isInEpisode)
		arg_13_0._clueItems[iter_13_2]:refresh(iter_13_3, arg_13_0.viewParam and arg_13_0.viewParam.stepId)
	end
end

function var_0_0._refreshBtn(arg_14_0)
	local var_14_0 = false

	if arg_14_0.viewParam and arg_14_0.viewParam.episodeId then
		local var_14_1 = AergusiDialogModel.instance:getLeftPromptTimes()

		arg_14_0._txttimes.text = var_14_1

		local var_14_2 = AergusiDialogModel.instance:getCurDialogGroup()
		local var_14_3 = AergusiConfig.instance:getEvidenceConfig(var_14_2)
		local var_14_4 = AergusiModel.instance:getCouldMergeClues(arg_14_0._clueConfigs)

		var_14_0 = var_14_3.showFusion > 0 and #var_14_4 > 0

		gohelper.setActive(arg_14_0._btntimes.gameObject, true)
		gohelper.setActive(arg_14_0._gotimegrey, not arg_14_0.viewParam.couldPrompt or var_14_1 <= 0)
	else
		gohelper.setActive(arg_14_0._btntimes.gameObject, false)
	end

	if var_14_0 then
		AergusiController.instance:dispatchEvent(AergusiEvent.OnGuideShowClueMerge)
	end

	gohelper.setActive(arg_14_0._btnmix.gameObject, var_14_0)
end

function var_0_0._addEvents(arg_15_0)
	AergusiController.instance:registerCallback(AergusiEvent.StartOperation, arg_15_0._onRefreshClueList, arg_15_0)
	AergusiController.instance:registerCallback(AergusiEvent.OnPlayMergeSuccess, arg_15_0._onRefreshClueList, arg_15_0)
	arg_15_0._drag:registerCallback(arg_15_0._drag.EventBegin, arg_15_0._onDragBegin, arg_15_0)
	arg_15_0._drag:registerCallback(arg_15_0._drag.EventEnd, arg_15_0._onDragEnd, arg_15_0)
end

function var_0_0._removeEvents(arg_16_0)
	AergusiController.instance:unregisterCallback(AergusiEvent.StartOperation, arg_16_0._onRefreshClueList, arg_16_0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnPlayMergeSuccess, arg_16_0._onRefreshClueList, arg_16_0)
	arg_16_0._drag:release()
end

function var_0_0._onDragBegin(arg_17_0)
	arg_17_0._positionX, arg_17_0._positionY = transformhelper.getPos(arg_17_0._goscrollcontent.transform)
end

function var_0_0._onDragEnd(arg_18_0)
	local var_18_0, var_18_1 = transformhelper.getPos(arg_18_0._goscrollcontent.transform)

	if var_18_1 - 50 < arg_18_0._positionY then
		arg_18_0:_playRootsAnim("move2")
	elseif var_18_1 + 50 > arg_18_0._positionY then
		arg_18_0:_playRootsAnim("move1")
	end
end

function var_0_0._onRefreshClueList(arg_19_0)
	arg_19_0._clueConfigs = arg_19_0:_getClueConfigs()

	arg_19_0:_refreshClueRoots()
	arg_19_0:_refreshItem()
	arg_19_0:_refreshBtn()
end

function var_0_0.onClose(arg_20_0)
	return
end

function var_0_0.onDestroyView(arg_21_0)
	arg_21_0:_removeEvents()

	if arg_21_0._clueItems then
		for iter_21_0, iter_21_1 in pairs(arg_21_0._clueItems) do
			iter_21_1:destroy()
		end

		arg_21_0._clueItems = nil
	end
end

return var_0_0
