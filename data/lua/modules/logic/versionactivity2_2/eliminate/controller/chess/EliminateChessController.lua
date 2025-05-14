module("modules.logic.versionactivity2_2.eliminate.controller.chess.EliminateChessController", package.seeall)

local var_0_0 = class("EliminateChessController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._seqStepFlow = nil
	arg_1_0._flowFullEnd = false
	arg_1_0._lastExchangePos = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearFlow()

	arg_2_0._lastExchangePos = {}
end

function var_0_0.sendGetMatch3WarChessInfoRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	EliminateRpc.instance:sendGetMatch3WarChessInfoRequest(arg_3_1, arg_3_2, arg_3_3)
end

function var_0_0.handleEliminateChessInfo(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	if arg_4_1.match3ChessBoard then
		EliminateChessModel.instance:initChessInfo(arg_4_1.match3ChessBoard)
	end

	if arg_4_1.movePoint then
		EliminateChessModel.instance:updateMovePoint(arg_4_1.movePoint)
	end
end

function var_0_0.handleMatch3Tips(arg_5_0, arg_5_1)
	EliminateChessModel.instance:updateMatch3Tips(arg_5_1)

	if EliminateChessModel.instance:getTipEliminateCount() == 0 then
		EliminateRpc.instance:sendRefreshMatch3WarChessInfoRequest()
	end
end

function var_0_0.handleMovePoint(arg_6_0, arg_6_1)
	EliminateChessModel.instance:updateMovePoint(arg_6_1)
end

function var_0_0.handleTurnInfo(arg_7_0, arg_7_1, arg_7_2)
	EliminateChessModel.instance:clearCurPlayAudioCount()
	EliminateChessModel.instance:clearTotalCount()

	if not arg_7_2 and #arg_7_0._lastExchangePos > 0 then
		local var_7_0, var_7_1, var_7_2, var_7_3 = arg_7_0:getRecordExchangePos()

		arg_7_0:exchangeCellShow(var_7_0, var_7_1, var_7_2, var_7_3, EliminateEnum.AniTime.MoveRevert)
	end

	for iter_7_0 = 1, #arg_7_1 do
		arg_7_0:cacheCurTurnInfo(arg_7_1[iter_7_0])
	end

	local var_7_4 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.HandleData)

	if arg_7_0:buildSeqFlow(var_7_4) then
		arg_7_0:startSeqStepFlow()
	end

	arg_7_0:clearRecord()
	arg_7_0:setFlowEndState(true)
end

function var_0_0.cacheCurTurnInfo(arg_8_0, arg_8_1)
	if arg_8_0._turnInfo == nil then
		arg_8_0._turnInfo = {}
	end

	arg_8_0._turnInfo[#arg_8_0._turnInfo + 1] = arg_8_1
end

function var_0_0.getCurTurn(arg_9_0)
	if arg_9_0._turnInfo == nil then
		return nil
	end

	return table.remove(arg_9_0._turnInfo, 1)
end

function var_0_0.handleEliminate(arg_10_0, arg_10_1)
	if not arg_10_1 then
		return
	end

	local var_10_0 = FlowParallel.New()

	for iter_10_0 = 1, #arg_10_1 do
		local var_10_1 = arg_10_1[iter_10_0].coordinate
		local var_10_2 = arg_10_1[iter_10_0].extraData
		local var_10_3 = arg_10_1[iter_10_0].type
		local var_10_4 = arg_10_1[iter_10_0].source
		local var_10_5 = {}

		if not string.nilorempty(var_10_2) then
			local var_10_6 = cjson.decode(var_10_2)

			if var_10_6 then
				local var_10_7 = var_10_6.diamondChangeMap

				if var_10_7 then
					for iter_10_1, iter_10_2 in pairs(var_10_7) do
						table.insert(var_10_5, iter_10_1)
						EliminateTeamChessModel.instance:updateResourceData(iter_10_1, tonumber(iter_10_2))
					end
				end

				local var_10_8 = var_10_6.changePower

				if var_10_8 then
					EliminateTeamChessModel.instance:updateMainCharacterPower(EliminateTeamChessEnum.TeamChessTeamType.player, tonumber(var_10_8))
				end
			end
		end

		local var_10_9 = #var_10_1

		EliminateChessModel.instance:addTotalEliminateCount(var_10_9)

		for iter_10_3 = 1, var_10_9 do
			local var_10_10 = var_10_1[iter_10_3]
			local var_10_11 = var_10_10.x + 1
			local var_10_12 = var_10_10.y + 1

			EliminateChessModel.instance:getChessMo(var_10_11, var_10_12):setStatus(EliminateEnum.ChessState.Die)

			local var_10_13 = {
				x = var_10_11,
				y = var_10_12,
				resourceIds = var_10_5,
				source = var_10_4
			}
			local var_10_14 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Die, var_10_13)

			var_10_0:addWork(var_10_14)
		end
	end

	local var_10_15 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.PlayEffect)

	var_10_0:addWork(var_10_15)

	local var_10_16 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.PlayAudio)

	var_10_0:addWork(var_10_16)
	arg_10_0:buildSeqFlow(var_10_0)
end

function var_0_0.handleDrop(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_1 or not arg_11_2 then
		return
	end

	local var_11_0 = {}
	local var_11_1 = FlowParallel.New()

	if arg_11_1.col then
		for iter_11_0, iter_11_1 in ipairs(arg_11_1.col) do
			local var_11_2 = iter_11_1.col + 1

			for iter_11_2, iter_11_3 in ipairs(iter_11_1.oldX) do
				local var_11_3 = iter_11_3 + 1
				local var_11_4 = iter_11_1.newX[iter_11_2] + 1
				local var_11_5 = EliminateChessModel.instance:getChessMo(var_11_2, var_11_3)

				var_11_5:setStartXY(var_11_2, var_11_3)
				var_11_5:setXY(var_11_2, var_11_4)
				EliminateChessModel.instance:updateChessMo(var_11_2, var_11_4, var_11_5)

				local var_11_6 = EliminateStepUtil.createOrGetMoveStepTable(EliminateChessItemController.instance:getChessItemByModel(var_11_5), var_11_5:getMoveTime(), EliminateEnum.AnimType.drop)
				local var_11_7 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, var_11_6)

				var_11_1:addWork(var_11_7)

				var_11_0[#var_11_0 + 1] = {
					model = var_11_5,
					viewItem = EliminateChessItemController.instance:getChessItemByModel(var_11_5)
				}
			end
		end
	end

	if arg_11_1.row then
		for iter_11_4, iter_11_5 in ipairs(arg_11_1.row) do
			local var_11_8 = iter_11_5.row + 1

			for iter_11_6, iter_11_7 in ipairs(iter_11_5.oldY) do
				local var_11_9 = iter_11_7 + 1
				local var_11_10 = iter_11_5.newY[iter_11_6] + 1
				local var_11_11 = EliminateChessModel.instance:getChessMo(var_11_9, var_11_8)

				var_11_11:setStartXY(var_11_9, var_11_8)
				var_11_11:setXY(var_11_10, var_11_8)
				EliminateChessModel.instance:updateChessMo(var_11_10, var_11_8, var_11_11)

				local var_11_12 = EliminateStepUtil.createOrGetMoveStepTable(EliminateChessItemController.instance:getChessItemByModel(var_11_11), var_11_11:getMoveTime(), EliminateEnum.AnimType.drop)
				local var_11_13 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, var_11_12)

				var_11_1:addWork(var_11_13)

				var_11_0[#var_11_0 + 1] = {
					model = var_11_11,
					viewItem = EliminateChessItemController.instance:getChessItemByModel(var_11_11)
				}
			end
		end
	end

	local var_11_14 = arg_11_2.chess

	if var_11_14 then
		local var_11_15, var_11_16 = EliminateChessModel.instance:getMaxRowAndCol()

		for iter_11_8 = 1, #var_11_14 do
			local var_11_17 = var_11_14[iter_11_8]
			local var_11_18 = var_11_17.id
			local var_11_19 = var_11_17.coordinate
			local var_11_20 = var_11_19.x + 1
			local var_11_21 = var_11_19.y + 1
			local var_11_22 = EliminateChessMO.New()

			var_11_22:setXY(var_11_20, var_11_21)
			var_11_22:setStartXY(var_11_20, var_11_16 + 1)
			var_11_22:setChessId(var_11_18)
			EliminateChessModel.instance:updateChessMo(var_11_20, var_11_21, var_11_22)

			local var_11_23 = EliminateChessItemController.instance:createChess(var_11_20, var_11_21)

			var_11_23:initData(var_11_22)

			local var_11_24 = EliminateStepUtil.createOrGetMoveStepTable(var_11_23, var_11_22:getMoveTime(), EliminateEnum.AnimType.drop)
			local var_11_25 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, var_11_24)

			var_11_1:addWork(var_11_25)

			var_11_0[#var_11_0 + 1] = {
				model = var_11_22,
				viewItem = var_11_23
			}
		end
	end

	local var_11_26 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Arrange, var_11_0)
	local var_11_27 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.HandleData)

	arg_11_0:buildSeqFlow(var_11_1)
	arg_11_0:buildSeqFlow(var_11_26)
	arg_11_0:buildSeqFlow(var_11_27)

	if canLogNormal then
		-- block empty
	end
end

function var_0_0.exchangeCell(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = math.abs(arg_12_1 - arg_12_3)
	local var_12_1 = math.abs(arg_12_2 - arg_12_4)

	if not (var_12_0 <= 1) or not (var_12_1 <= 1) or var_12_0 == var_12_1 then
		return false
	end

	if arg_12_0._turnInfo ~= nil and #arg_12_0._turnInfo > 0 then
		return true
	end

	arg_12_0:setFlowEndState(false)
	arg_12_0:dispatchEvent(EliminateChessEvent.PerformBegin)
	arg_12_0:recordExchangePos(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	arg_12_0:exchangeCellShow(arg_12_1, arg_12_2, arg_12_3, arg_12_4, EliminateEnum.AniTime.Move)
	EliminateRpc.instance:sendMatch3ChessBoardSwapRequest(arg_12_1, arg_12_2, arg_12_3, arg_12_4, nil, nil)

	return true
end

function var_0_0.recordExchangePos(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if not arg_13_0._lastExchangePos then
		arg_13_0._lastExchangePos = {}
	end

	arg_13_0._lastExchangePos[#arg_13_0._lastExchangePos + 1] = arg_13_1
	arg_13_0._lastExchangePos[#arg_13_0._lastExchangePos + 1] = arg_13_2
	arg_13_0._lastExchangePos[#arg_13_0._lastExchangePos + 1] = arg_13_3
	arg_13_0._lastExchangePos[#arg_13_0._lastExchangePos + 1] = arg_13_4
end

function var_0_0.getRecordExchangePos(arg_14_0)
	return arg_14_0._lastExchangePos[1], arg_14_0._lastExchangePos[2], arg_14_0._lastExchangePos[3], arg_14_0._lastExchangePos[4]
end

function var_0_0.clearRecord(arg_15_0)
	tabletool.clear(arg_15_0._lastExchangePos)
end

function var_0_0.exchangeCellShow(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	local var_16_0 = {}
	local var_16_1 = EliminateChessModel.instance:getChessMo(arg_16_1, arg_16_2)

	var_16_1:setXY(arg_16_3, arg_16_4)

	local var_16_2 = EliminateChessModel.instance:getChessMo(arg_16_3, arg_16_4)

	var_16_2:setXY(arg_16_1, arg_16_2)
	EliminateChessModel.instance:updateChessMo(arg_16_1, arg_16_2, var_16_2)
	EliminateChessModel.instance:updateChessMo(arg_16_3, arg_16_4, var_16_1)

	local var_16_3 = EliminateStepUtil.createOrGetMoveStepTable(EliminateChessItemController.instance:getChessItemByModel(var_16_1), arg_16_5, EliminateEnum.AnimType.move)
	local var_16_4 = EliminateStepUtil.createOrGetMoveStepTable(EliminateChessItemController.instance:getChessItemByModel(var_16_2), arg_16_5, EliminateEnum.AnimType.move)
	local var_16_5 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, var_16_3)
	local var_16_6 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, var_16_4)
	local var_16_7 = arg_16_0:buildParallelFlow(var_16_5, var_16_6)
	local var_16_8, var_16_9 = arg_16_0:buildSeqFlow(var_16_7)

	var_16_0[#var_16_0 + 1] = {
		model = var_16_1,
		viewItem = EliminateChessItemController.instance:getChessItemByModel(var_16_1)
	}
	var_16_0[#var_16_0 + 1] = {
		model = var_16_2,
		viewItem = EliminateChessItemController.instance:getChessItemByModel(var_16_2)
	}

	local var_16_10 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Arrange, var_16_0)

	arg_16_0:buildSeqFlow(var_16_10)

	if canLogNormal then
		local var_16_11 = EliminateChessDebugStep.New()

		arg_16_0:buildSeqFlow(var_16_11)
	end

	if var_16_8 then
		arg_16_0:startSeqStepFlow()
	end
end

function var_0_0.createInitMoveStepAndUpdatePos(arg_17_0)
	EliminateChessModel.instance:createInitMoveState()

	local var_17_0 = EliminateChessItemController.instance:getChess()

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		for iter_17_2, iter_17_3 in pairs(iter_17_1) do
			iter_17_3:updatePos(iter_17_3)
		end
	end
end

function var_0_0.createInitMoveStep(arg_18_0)
	local var_18_0 = EliminateChessItemController.instance:getChess()
	local var_18_1 = FlowParallel.New()

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		for iter_18_2, iter_18_3 in pairs(iter_18_1) do
			iter_18_3:updatePos(iter_18_3)

			local var_18_2 = EliminateStepUtil.createOrGetMoveStepTable(iter_18_3, iter_18_3:getData():getInitMoveTime(), EliminateEnum.AnimType.init)
			local var_18_3 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, var_18_2)

			var_18_1:addWork(var_18_3)
		end
	end

	return arg_18_0:buildSeqFlow(var_18_1)
end

function var_0_0.buildSeqFlow(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._seqStepFlow == nil

	arg_19_0._seqStepFlow = arg_19_0._seqStepFlow or FlowSequence.New()

	if arg_19_1 then
		arg_19_0._seqStepFlow:addWork(arg_19_1)
	end

	return var_19_0, arg_19_0._seqStepFlow
end

function var_0_0.buildParallelFlow(arg_20_0, ...)
	local var_20_0 = FlowParallel.New()
	local var_20_1 = ... ~= nil and select("#", ...) or 0

	if var_20_1 > 0 then
		for iter_20_0 = 1, var_20_1 do
			var_20_0:addWork(select(iter_20_0, ...))
		end
	end

	return var_20_0
end

function var_0_0.getCurSeqStepFlow(arg_21_0)
	return arg_21_0._seqStepFlow
end

function var_0_0.startSeqStepFlow(arg_22_0)
	if arg_22_0._seqStepFlow then
		arg_22_0._seqStepFlow:registerDoneListener(arg_22_0.seqFlowDone, arg_22_0)
		arg_22_0._seqStepFlow:start()
	end
end

function var_0_0.checkPerformEndState(arg_23_0)
	if arg_23_0._flowFullEnd and arg_23_0._seqStepFlow == nil then
		arg_23_0:dispatchEvent(EliminateChessEvent.PerformEnd)
	end
end

function var_0_0.setFlowEndState(arg_24_0, arg_24_1)
	arg_24_0._flowFullEnd = arg_24_1

	arg_24_0:checkPerformEndState()
end

function var_0_0.seqFlowDone(arg_25_0)
	arg_25_0._seqStepFlow = nil

	arg_25_0:checkPerformEndState()
end

function var_0_0.clearFlow(arg_26_0)
	if arg_26_0._seqStepFlow then
		arg_26_0._seqStepFlow:onDestroyInternal()

		arg_26_0._seqStepFlow = nil
	end
end

function var_0_0.checkAndSetNeedResetData(arg_27_0, arg_27_1)
	EliminateChessModel.instance:setNeedResetData(arg_27_1)

	if (arg_27_0._turnInfo == nil or #arg_27_0._turnInfo == 0) and EliminateChessModel.instance:getNeedResetData() ~= nil then
		local var_27_0 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.RefreshEliminate)

		if var_0_0.instance:buildSeqFlow(var_27_0) then
			var_0_0.instance:startSeqStepFlow()
		end
	end
end

function var_0_0.checkState(arg_28_0)
	if EliminateChessModel.instance:getMovePoint() <= 0 then
		local var_28_0 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EndShowView, {
			time = EliminateEnum.ShowEndTime,
			cb = function()
				EliminateLevelController.instance:changeRoundToTeamChess()
			end,
			needShowEnd = EliminateLevelModel.instance:needPlayShowView()
		})

		var_0_0.instance:clearFlow()

		if var_0_0.instance:buildSeqFlow(var_28_0) then
			var_0_0.instance:startSeqStepFlow()
		end

		return true
	end

	return false
end

function var_0_0.openNoticeView(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5, arg_30_6, arg_30_7, arg_30_8)
	local var_30_0 = ViewMgr.instance:getSetting(ViewName.EliminateNoticeView)

	if var_30_0 then
		var_30_0.bgBlur = (arg_30_4 or arg_30_2) and 0 or 1
	end

	local var_30_1 = {
		isStart = arg_30_1,
		isFinish = arg_30_2,
		isTeamChess = arg_30_3,
		isShowEvaluate = arg_30_4,
		evaluateLevel = arg_30_5,
		closeTime = arg_30_6,
		closeCallback = arg_30_7,
		closeCallbackTarget = arg_30_8
	}

	ViewMgr.instance:openView(ViewName.EliminateNoticeView, var_30_1)
end

function var_0_0.clear(arg_31_0)
	arg_31_0:clearFlow()

	arg_31_0._flowFullEnd = false

	EliminateStepUtil.releaseMoveStepTable()

	arg_31_0._lastExchangePos = {}

	EliminateChessModel.instance:reInit()
	EliminateChessItemController.instance:clear()
end

var_0_0.instance = var_0_0.New()

return var_0_0
