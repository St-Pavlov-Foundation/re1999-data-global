module("modules.logic.survival.view.shelter.SurvivalDecreeVoteView", package.seeall)

local var_0_0 = class("SurvivalDecreeVoteView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goItem = gohelper.findChild(arg_1_0.viewGO, "Left/#go_survivaldecreeitem")
	arg_1_0.goBubbleRoot = gohelper.findChild(arg_1_0.viewGO, "Bubble")
	arg_1_0.goBubble = gohelper.findChild(arg_1_0.goBubbleRoot, "goBubble")
	arg_1_0.txtBubble = gohelper.findChildTextMesh(arg_1_0.goBubbleRoot, "goBubble/#txt_Bubble")
	arg_1_0.goAgreeItem = gohelper.findChild(arg_1_0.goBubbleRoot, "goAgree")
	arg_1_0.goDisAgreeItem = gohelper.findChild(arg_1_0.goBubbleRoot, "goDisagree")

	gohelper.setActive(arg_1_0.goBubble, false)
	gohelper.setActive(arg_1_0.goAgreeItem, false)
	gohelper.setActive(arg_1_0.goDisAgreeItem, false)

	arg_1_0.goVoteFinish = gohelper.findChild(arg_1_0.viewGO, "#go_VoteFinished")
	arg_1_0.txtVotePercent = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_VoteFinished/Rate/#txt_Percent")
	arg_1_0.txtVotePercentGlow = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_VoteFinished/Rate/#txt_Percent_glow")
	arg_1_0.goVoteState = gohelper.findChild(arg_1_0.viewGO, "#go_VoteState")
	arg_1_0.goTipsItem = gohelper.findChild(arg_1_0.viewGO, "#go_VoteState/#scroll_Tips/Viewport/Content/#go_Item")

	gohelper.setActive(arg_1_0.goTipsItem, false)

	arg_1_0.btnClose = gohelper.findChildClick(arg_1_0.viewGO, "btnClose")
	arg_1_0.goTxtClose = gohelper.findChild(arg_1_0.viewGO, "btnClose/txt_Close")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClose, arg_2_0.onClickClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnClose)
end

function var_0_0.onClickClose(arg_4_0)
	if not arg_4_0.popupFlow or arg_4_0.popupFlow:isFlowDone() then
		arg_4_0:closeThis()

		return
	end

	arg_4_0.popupFlow:tryJumpNextWork()
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0.decreeInfo = arg_5_0.viewParam.decreeInfo
	arg_5_0.weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	arg_5_0:startVote()
end

function var_0_0.startVote(arg_6_0)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnDecreeVoteStart)
	arg_6_0:initWork()
	arg_6_0:buildPlayerWork()
	arg_6_0:buildNpcWork()
	arg_6_0:buildCameraWork()
	arg_6_0:buildDelay(0.5)
	arg_6_0:buildDecreeItemWork()
	arg_6_0:buildBubbleWork()
	arg_6_0:buildToastWork()
	arg_6_0:buildVotePercentWork()
	arg_6_0.popupFlow:start()
end

function var_0_0.initWork(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.playNextToast, arg_7_0)
	gohelper.setActive(arg_7_0.goTxtClose, false)
	gohelper.setActive(arg_7_0.goBubbleRoot, false)
	gohelper.setActive(arg_7_0.goBubble, false)
	gohelper.setActive(arg_7_0.goVoteFinish, false)
	gohelper.setActive(arg_7_0.goVoteState, false)
	arg_7_0:clearFlow()
	arg_7_0:clearBubble()
	arg_7_0:buildData()

	arg_7_0.popupFlow = SurvivalDecreeVoteFlowSequence.New()

	arg_7_0.popupFlow:registerDoneListener(arg_7_0.onVoteDone, arg_7_0)
end

function var_0_0.clearFlow(arg_8_0)
	if arg_8_0.popupFlow then
		arg_8_0.popupFlow:destroy()

		arg_8_0.popupFlow = nil
	end
end

function var_0_0.buildData(arg_9_0)
	arg_9_0.toastDataList = {}

	local var_9_0 = arg_9_0.weekInfo.shelterMapId

	arg_9_0.mapCo = lua_survival_shelter.configDict[var_9_0]
	arg_9_0.unitComp = SurvivalMapHelper.instance:getScene().unit

	local var_9_1 = {}
	local var_9_2 = arg_9_0.decreeInfo:getCurPolicyGroup():getPolicyList()
	local var_9_3 = var_9_2[#var_9_2]
	local var_9_4 = SurvivalConfig.instance:getDecreeCo(var_9_3.id)

	for iter_9_0, iter_9_1 in ipairs(var_9_2) do
		local var_9_5 = SurvivalConfig.instance:getDecreeCo(iter_9_1.id)
		local var_9_6 = string.splitToNumber(var_9_5 and var_9_5.tags, "#")

		if var_9_6 then
			for iter_9_2, iter_9_3 in ipairs(var_9_6) do
				var_9_1[iter_9_3] = 1
			end
		end
	end

	local var_9_7 = var_9_3.needVoteNum
	local var_9_8 = math.min(var_9_3.currVoteNum, var_9_3.needVoteNum)

	if var_9_7 == 0 then
		arg_9_0.votePercent = 1
	else
		arg_9_0.votePercent = var_9_8 / var_9_7
	end

	arg_9_0.npcDataList = {
		{},
		{}
	}

	local var_9_9 = SurvivalShelterModel.instance:getWeekInfo().npcDict

	for iter_9_4, iter_9_5 in pairs(var_9_9) do
		local var_9_10 = {
			id = iter_9_5.id,
			resource = iter_9_5.co.resource,
			config = iter_9_5.co,
			isAgree = arg_9_0:checkTagIsAgree(var_9_1, iter_9_5.co.tag)
		}

		if var_9_10.isAgree then
			table.insert(arg_9_0.npcDataList[1], var_9_10)
		else
			table.insert(arg_9_0.npcDataList[2], var_9_10)
		end
	end
end

function var_0_0.checkTagIsAgree(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = string.splitToNumber(arg_10_2, "#")

	if var_10_0 then
		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			if arg_10_1[iter_10_1] then
				return true
			end
		end
	end

	return false
end

function var_0_0.buildDelay(arg_11_0, arg_11_1)
	local var_11_0 = {
		time = arg_11_1
	}

	arg_11_0.popupFlow:addWork(SurvivalDecreeVoteShowWork.New(var_11_0))
end

function var_0_0.buildDecreeItemWork(arg_12_0)
	if not arg_12_0.decreeItem then
		local var_12_0 = arg_12_0.viewContainer:getResInst(arg_12_0.viewContainer:getSetting().otherRes.itemRes, arg_12_0.goItem, "item")

		arg_12_0.decreeItemGO = var_12_0
		arg_12_0.decreeItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_0, SurvivalDecreeVoteItem)
	end

	arg_12_0.decreeItem:onUpdateMO(arg_12_0.decreeInfo)
	gohelper.setActive(arg_12_0.decreeItemGO, false)

	local var_12_1 = {
		time = 0.333,
		go = arg_12_0.decreeItemGO,
		audioId = AudioEnum2_8.Survival.play_ui_fuleyuan_binansuo_decide
	}

	arg_12_0.popupFlow:addWork(SurvivalDecreeVoteShowWork.New(var_12_1))
end

function var_0_0.buildCameraWork(arg_13_0)
	local var_13_0 = SurvivalShelterModel.instance:getPlayerMo().pos
	local var_13_1 = {
		playerPos = var_13_0
	}

	arg_13_0.popupFlow:addWork(SurvivalDecreeVoteBuildCameraWork.New(var_13_1))
	arg_13_0:buildDelay(0.5)
end

function var_0_0.buildNpcWork(arg_14_0)
	local var_14_0 = {
		npcDataList = arg_14_0.npcDataList,
		votePercent = arg_14_0.votePercent,
		goAgreeItem = arg_14_0.goAgreeItem,
		goDisAgreeItem = arg_14_0.goDisAgreeItem,
		mapCo = arg_14_0.mapCo,
		unitComp = arg_14_0.unitComp,
		bubbleList = arg_14_0.bubbleList,
		toastList = arg_14_0.toastDataList
	}

	arg_14_0.popupFlow:addWork(SurvivalDecreeVoteBuildNpcWork.New(var_14_0))
end

function var_0_0.buildPlayerWork(arg_15_0)
	local var_15_0 = {
		mapCo = arg_15_0.mapCo,
		goBubble = arg_15_0.goBubble
	}

	arg_15_0.popupFlow:addWork(SurvivalDecreeVoteBuildPlayerWork.New(var_15_0))
end

function var_0_0.buildBubbleWork(arg_16_0)
	local var_16_0 = {
		time = 1.2,
		callback = arg_16_0.showPlayerBubble,
		callbackObj = arg_16_0
	}

	arg_16_0.popupFlow:addWork(SurvivalDecreeVoteShowWork.New(var_16_0))

	local var_16_1 = {
		bubbleList = arg_16_0.bubbleList,
		startCallback = arg_16_0.showNpcBubble,
		startCallbackObj = arg_16_0
	}

	arg_16_0.popupFlow:addWork(SurvivalDecreeVoteNpcBubbleWork.New(var_16_1))
end

function var_0_0.showPlayerBubble(arg_17_0)
	gohelper.setAsLastSibling(arg_17_0.goBubble)
	gohelper.setActive(arg_17_0.goBubbleRoot, true)
	gohelper.setActive(arg_17_0.goBubble, true)
end

function var_0_0.showNpcBubble(arg_18_0)
	gohelper.setActive(arg_18_0.goBubbleRoot, true)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_binansuo_discuss)
end

function var_0_0.buildToastWork(arg_19_0)
	local var_19_0 = {
		goVoteState = arg_19_0.goVoteState,
		toastDataList = arg_19_0.toastDataList,
		goTipsItem = arg_19_0.goTipsItem
	}

	arg_19_0.popupFlow:addWork(SurvivalDecreeVotePlayToastWork.New(var_19_0))
end

function var_0_0.buildVotePercentWork(arg_20_0)
	local var_20_0 = {
		goVoteFinish = arg_20_0.goVoteFinish,
		txtVotePercent = arg_20_0.txtVotePercent,
		txtVotePercentGlow = arg_20_0.txtVotePercentGlow,
		votePercent = arg_20_0.votePercent
	}
	local var_20_1 = SurvivalDecreeVotePlayPercentWork.New(var_20_0)

	arg_20_0.popupFlow:addWork(var_20_1)
end

function var_0_0.onPercentDone(arg_21_0)
	if arg_21_0.decreeItem then
		arg_21_0.decreeItem:refreshHas(false)
	end
end

function var_0_0.onVoteDone(arg_22_0)
	arg_22_0:onPercentDone()
	gohelper.setActive(arg_22_0.goTxtClose, true)
end

function var_0_0.clearBubble(arg_23_0)
	if arg_23_0.bubbleList then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0.bubbleList) do
			iter_23_1:dispose()
		end
	end

	arg_23_0.bubbleList = {}
end

function var_0_0.onClose(arg_24_0)
	arg_24_0:clearFlow()
	arg_24_0:clearBubble()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnDecreeVoteEnd)
	ViewMgr.instance:openView(ViewName.SurvivalDecreeView)
end

function var_0_0.onDestroyView(arg_25_0)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.ChangeCameraScale)
end

return var_0_0
