module("modules.logic.versionactivity2_7.lengzhou6.controller.LengZhou6EliminateController", package.seeall)

local var_0_0 = class("LengZhou6EliminateController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.enterLevel(arg_2_0, arg_2_1)
	arg_2_0:initEliminateData(arg_2_1)
	arg_2_0:resetCurEliminateCount()
end

function var_0_0.initEliminateData(arg_3_0, arg_3_1)
	local var_3_0 = LengZhou6GameModel.instance:getRecordServerData()
	local var_3_1 = LengZhou6EliminateConfig.instance:getEliminateChessLevelConfig(arg_3_1)

	if var_3_0 and var_3_0._data and var_3_0._data.chessData then
		local var_3_2 = var_3_0._data.chessData

		if tabletool.len(var_3_2) > 0 then
			var_3_1 = var_3_0._data.chessData
		end
	end

	LocalEliminateChessModel.instance:initByData(var_3_1)
end

function var_0_0.exchangeCell(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0:recordExchangePos(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	LocalEliminateChessModel.instance:_exchangeCell(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0:exchangeCellShow(arg_4_1, arg_4_2, arg_4_3, arg_4_4, EliminateEnum.AniTime.Move)

	local var_4_0 = LocalEliminateChessModel.instance:exchangeCell(arg_4_1, arg_4_2, arg_4_3, arg_4_4, false)

	if not var_4_0 then
		if #arg_4_0._lastExchangePos > 0 then
			local var_4_1 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateChessRevert)

			arg_4_0:buildSeqFlow(var_4_1)
		end
	else
		local var_4_2 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, true)

		arg_4_0:buildSeqFlow(var_4_2)
	end

	return var_4_0
end

function var_0_0.revertRecord(arg_5_0)
	local var_5_0, var_5_1, var_5_2, var_5_3 = arg_5_0:getRecordExchangePos()

	LocalEliminateChessModel.instance:_exchangeCell(var_5_0, var_5_1, var_5_2, var_5_3)
	arg_5_0:exchangeCellShow(var_5_0, var_5_1, var_5_2, var_5_3, EliminateEnum.AniTime.MoveRevert)
	arg_5_0:clearRecord()
	arg_5_0:setFlowEndState(true)
end

function var_0_0.eliminateCheck(arg_6_0, arg_6_1)
	local var_6_0 = LocalEliminateChessModel.instance:check(true, false)

	if var_6_0 then
		LocalEliminateChessModel.instance:checkEliminate()
		arg_6_0:handleEliminate()
		arg_6_0:handleDrop()
		LocalEliminateChessModel.instance:getEliminateRecordShowData():reset()

		local var_6_1

		if isDebugBuild then
			local var_6_2 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateChessDebug2_7)

			arg_6_0:buildSeqFlow(var_6_2)
		end

		arg_6_0:calCurEliminateCount()
		arg_6_0:dispatchEvent(LengZhou6Event.ShowCombos, arg_6_0._eliminateCount)
		LengZhou6GameController.instance:playerSettle()
		LengZhou6GameModel.instance:setCurGameStep(LengZhou6Enum.BattleStep.addBuff)

		local var_6_3 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, arg_6_1)

		arg_6_0:buildSeqFlow(var_6_3)
	else
		LengZhou6GameController.instance:gameUpdateRound(arg_6_1)

		local var_6_4 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateChessUpdateGameInfo)

		arg_6_0:buildSeqFlow(var_6_4)
		arg_6_0:setFlowEndState(true)
	end

	arg_6_0:clearRecord()

	return var_6_0
end

function var_0_0.calCurEliminateCount(arg_7_0)
	local var_7_0 = LocalEliminateChessModel.instance:getCurEliminateRecordData():getEliminateTypeMap()
	local var_7_1 = true

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		local var_7_2 = iter_7_1[1]

		if var_7_2 ~= nil and var_7_2.eliminateType == EliminateEnum_2_7.eliminateType.base then
			var_7_1 = false

			break
		end

		if var_7_1 then
			arg_7_0._eliminateCount = arg_7_0._eliminateCount + #iter_7_1
		end
	end

	if not var_7_1 then
		arg_7_0._eliminateCount = arg_7_0._eliminateCount + 1
	end
end

function var_0_0.dispatchShowAssess(arg_8_0)
	local var_8_0

	for iter_8_0 = 1, #EliminateEnum_2_7.AssessLevel do
		if EliminateEnum_2_7.AssessLevel[iter_8_0] <= arg_8_0._eliminateCount then
			var_8_0 = iter_8_0
		end
	end

	if var_8_0 ~= nil then
		arg_8_0:dispatchEvent(LengZhou6Event.ShowAssess, var_8_0)
	end

	return var_8_0
end

function var_0_0.resetCurEliminateCount(arg_9_0)
	arg_9_0._eliminateCount = 0
end

function var_0_0.setDieType(arg_10_0)
	return
end

function var_0_0.handleEliminate(arg_11_0)
	local var_11_0 = LocalEliminateChessModel.instance:getEliminateRecordShowData()
	local var_11_1 = var_11_0:getChangeType()
	local var_11_2 = var_11_0:getEliminate()
	local var_11_3 = FlowParallel.New()
	local var_11_4 = FlowParallel.New()
	local var_11_5 = #var_11_1

	for iter_11_0 = 1, var_11_5 / 3 do
		local var_11_6 = var_11_1[iter_11_0 * 3 - 2]
		local var_11_7 = var_11_1[iter_11_0 * 3 - 1]
		local var_11_8 = var_11_1[iter_11_0 * 3]
		local var_11_9 = {
			x = var_11_6,
			y = var_11_7,
			fromState = var_11_8
		}
		local var_11_10 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.ChangeState, var_11_9)

		var_11_3:addWork(var_11_10)
	end

	local var_11_11 = #var_11_2

	for iter_11_1 = 1, var_11_11 / 3 do
		local var_11_12 = var_11_2[iter_11_1 * 3 - 2]
		local var_11_13 = var_11_2[iter_11_1 * 3 - 1]
		local var_11_14 = var_11_2[iter_11_1 * 3]
		local var_11_15 = {
			x = var_11_12,
			y = var_11_13,
			skillEffect = var_11_14
		}
		local var_11_16 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.DieEffect, var_11_15)

		var_11_4:addWork(var_11_16)
	end

	local var_11_17 = LocalEliminateChessModel.instance:getEliminateDieEffect()
	local var_11_18 = AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_boom

	if var_11_17 and var_11_17 == LengZhou6Enum.SkillEffect.EliminationRange then
		var_11_18 = AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_explosion

		LocalEliminateChessModel.instance:setEliminateDieEffect(nil)
	end

	if var_11_17 and var_11_17 == LengZhou6Enum.SkillEffect.EliminationCross then
		var_11_18 = AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_combustion

		LocalEliminateChessModel.instance:setEliminateDieEffect(nil)
	end

	local var_11_19 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.PlayAudio, var_11_18)

	var_11_4:addWork(var_11_19)
	arg_11_0:buildSeqFlow(var_11_3)
	arg_11_0:buildSeqFlow(var_11_4)
end

function var_0_0.handleDrop(arg_12_0)
	local var_12_0 = LocalEliminateChessModel.instance:getEliminateRecordShowData()
	local var_12_1 = var_12_0:getMove()
	local var_12_2 = var_12_0:getNew()

	if not var_12_1 or not var_12_2 then
		return
	end

	local var_12_3 = {}
	local var_12_4 = FlowParallel.New()
	local var_12_5 = #var_12_1

	for iter_12_0 = 1, var_12_5 / 4 do
		local var_12_6 = var_12_1[iter_12_0 * 4 - 3]
		local var_12_7 = var_12_1[iter_12_0 * 4 - 2]
		local var_12_8 = var_12_1[iter_12_0 * 4 - 1]
		local var_12_9 = var_12_1[iter_12_0 * 4]
		local var_12_10 = LengZhou6EliminateChessItemController.instance:getChessItem(var_12_6, var_12_7)
		local var_12_11 = EliminateStepUtil.createOrGetMoveStepTable(var_12_10, EliminateEnum.AniTime.Drop, EliminateEnum.AnimType.drop)
		local var_12_12 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, var_12_11)

		var_12_4:addWork(var_12_12)

		var_12_3[#var_12_3 + 1] = {
			x = var_12_8,
			y = var_12_9,
			viewItem = var_12_10
		}
	end

	local var_12_13 = #var_12_2

	for iter_12_1 = 1, var_12_13 / 2 do
		local var_12_14 = var_12_2[iter_12_1 * 2 - 1]
		local var_12_15 = var_12_2[iter_12_1 * 2]
		local var_12_16 = LocalEliminateChessModel.instance:getCell(var_12_14, var_12_15)
		local var_12_17 = LengZhou6EliminateChessItemController.instance:createChess(var_12_14, var_12_15)

		var_12_17:initData(var_12_16)

		local var_12_18 = EliminateStepUtil.createOrGetMoveStepTable(var_12_17, EliminateEnum.AniTime.Drop, EliminateEnum.AnimType.drop)
		local var_12_19 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, var_12_18)

		var_12_4:addWork(var_12_19)

		var_12_3[#var_12_3 + 1] = {
			x = var_12_14,
			y = var_12_15,
			viewItem = var_12_17
		}
	end

	local var_12_20 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Arrange_XY, var_12_3)

	arg_12_0:buildSeqFlow(var_12_4)
	arg_12_0:buildSeqFlow(var_12_20)
end

function var_0_0.updateAllItemPos(arg_13_0, arg_13_1)
	if arg_13_1 == nil then
		return
	end

	local var_13_0 = {}
	local var_13_1 = FlowParallel.New()
	local var_13_2 = #arg_13_1

	for iter_13_0 = 1, var_13_2 / 4 do
		local var_13_3 = arg_13_1[iter_13_0 * 4 - 3]
		local var_13_4 = arg_13_1[iter_13_0 * 4 - 2]
		local var_13_5 = arg_13_1[iter_13_0 * 4 - 1]
		local var_13_6 = arg_13_1[iter_13_0 * 4]
		local var_13_7 = LengZhou6EliminateChessItemController.instance:getChessItem(var_13_3, var_13_4)
		local var_13_8 = LengZhou6EliminateChessItemController.instance:getChessItem(var_13_5, var_13_6)
		local var_13_9 = EliminateStepUtil.createOrGetMoveStepTable(var_13_7, EliminateEnum.AniTime.Move, EliminateEnum.AnimType.move)
		local var_13_10 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, var_13_9)

		var_13_1:addWork(var_13_10)

		local var_13_11 = EliminateStepUtil.createOrGetMoveStepTable(var_13_8, EliminateEnum.AniTime.Move, EliminateEnum.AnimType.move)
		local var_13_12 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, var_13_11)

		var_13_1:addWork(var_13_12)
		table.insert(var_13_0, {
			x = var_13_5,
			y = var_13_6
		})
	end

	arg_13_0:buildSeqFlow(var_13_1)

	local var_13_13 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Arrange_XY, var_13_0)

	arg_13_0:buildSeqFlow(var_13_13)

	if isDebugBuild then
		local var_13_14 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateChessDebug2_7)

		arg_13_0:buildSeqFlow(var_13_14)
	end

	local var_13_15 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, false)

	arg_13_0:buildSeqFlow(var_13_15)
end

function var_0_0.recordExchangePos(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if not arg_14_0._lastExchangePos then
		arg_14_0._lastExchangePos = {}
	end

	arg_14_0._lastExchangePos[#arg_14_0._lastExchangePos + 1] = arg_14_1
	arg_14_0._lastExchangePos[#arg_14_0._lastExchangePos + 1] = arg_14_2
	arg_14_0._lastExchangePos[#arg_14_0._lastExchangePos + 1] = arg_14_3
	arg_14_0._lastExchangePos[#arg_14_0._lastExchangePos + 1] = arg_14_4
end

function var_0_0.getRecordExchangePos(arg_15_0)
	return arg_15_0._lastExchangePos[1], arg_15_0._lastExchangePos[2], arg_15_0._lastExchangePos[3], arg_15_0._lastExchangePos[4]
end

function var_0_0.clearRecord(arg_16_0)
	if arg_16_0._lastExchangePos == nil then
		return
	end

	tabletool.clear(arg_16_0._lastExchangePos)
end

function var_0_0.exchangeCellShow(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	local var_17_0 = {}
	local var_17_1 = EliminateStepUtil.createOrGetMoveStepTable(LengZhou6EliminateChessItemController.instance:getChessItem(arg_17_1, arg_17_2), arg_17_5, EliminateEnum.AnimType.move)
	local var_17_2 = EliminateStepUtil.createOrGetMoveStepTable(LengZhou6EliminateChessItemController.instance:getChessItem(arg_17_3, arg_17_4), arg_17_5, EliminateEnum.AnimType.move)
	local var_17_3 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, var_17_1)
	local var_17_4 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, var_17_2)
	local var_17_5 = arg_17_0:buildParallelFlow(var_17_3, var_17_4)

	arg_17_0:buildSeqFlow(var_17_5)

	var_17_0[#var_17_0 + 1] = {
		x = arg_17_3,
		y = arg_17_4,
		viewItem = LengZhou6EliminateChessItemController.instance:getChessItem(arg_17_1, arg_17_2)
	}
	var_17_0[#var_17_0 + 1] = {
		x = arg_17_1,
		y = arg_17_2,
		viewItem = LengZhou6EliminateChessItemController.instance:getChessItem(arg_17_3, arg_17_4)
	}

	local var_17_6 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Arrange_XY, var_17_0)

	arg_17_0:buildSeqFlow(var_17_6)

	if isDebugBuild then
		local var_17_7 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateChessDebug2_7)

		arg_17_0:buildSeqFlow(var_17_7)
	end
end

function var_0_0.createInitMoveStepAndUpdatePos(arg_18_0)
	LengZhou6EliminateChessItemController.instance:tempClearAllChess()
	LengZhou6EliminateChessItemController.instance:InitChess()
	arg_18_0:createInitMoveStep()
end

function var_0_0.createInitMoveStep(arg_19_0)
	local var_19_0 = LengZhou6EliminateChessItemController.instance:getChess()
	local var_19_1 = FlowParallel.New()

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		for iter_19_2, iter_19_3 in pairs(iter_19_1) do
			local var_19_2 = EliminateEnum_2_7.InitDropTime * iter_19_2
			local var_19_3 = EliminateStepUtil.createOrGetMoveStepTable(iter_19_3, var_19_2, EliminateEnum.AnimType.init)
			local var_19_4 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, var_19_3)

			var_19_1:addWork(var_19_4)
		end
	end

	arg_19_0:buildSeqFlow(var_19_1)
	arg_19_0:setFlowEndState(true)
end

function var_0_0.buildSeqFlow(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0._seqStepFlow == nil

	arg_20_0._seqStepFlow = arg_20_0._seqStepFlow or FlowSequence.New()

	if arg_20_1 then
		arg_20_0._seqStepFlow:addWork(arg_20_1)
	end

	if var_20_0 and arg_20_0._seqStepFlow ~= nil then
		arg_20_0:startSeqStepFlow()
	end

	return arg_20_0._seqStepFlow
end

function var_0_0.buildParallelFlow(arg_21_0, ...)
	local var_21_0 = FlowParallel.New()
	local var_21_1 = ... ~= nil and select("#", ...) or 0

	if var_21_1 > 0 then
		for iter_21_0 = 1, var_21_1 do
			var_21_0:addWork(select(iter_21_0, ...))
		end
	end

	return var_21_0
end

function var_0_0.getCurSeqStepFlow(arg_22_0)
	return arg_22_0._seqStepFlow
end

function var_0_0.startSeqStepFlow(arg_23_0)
	if arg_23_0._seqStepFlow ~= nil then
		arg_23_0._seqStepFlow:registerDoneListener(arg_23_0.seqFlowDone, arg_23_0)
		arg_23_0:dispatchEvent(LengZhou6Event.PerformBegin)
		arg_23_0:setPerformIsFinish(false)
		arg_23_0._seqStepFlow:start()
	end
end

function var_0_0.checkPerformEndState(arg_24_0)
	if arg_24_0._flowFullEnd and arg_24_0._seqStepFlow == nil then
		arg_24_0:dispatchEvent(LengZhou6Event.PerformEnd)
		arg_24_0:setPerformIsFinish(true)
	end
end

function var_0_0.getPerformIsFinish(arg_25_0)
	return arg_25_0._performIsFinish
end

function var_0_0.setPerformIsFinish(arg_26_0, arg_26_1)
	arg_26_0._performIsFinish = arg_26_1
end

function var_0_0.setFlowEndState(arg_27_0, arg_27_1)
	arg_27_0._flowFullEnd = arg_27_1

	arg_27_0:checkPerformEndState()
end

function var_0_0.seqFlowDone(arg_28_0)
	arg_28_0._seqStepFlow = nil

	arg_28_0:checkPerformEndState()
end

function var_0_0.clearFlow(arg_29_0)
	if arg_29_0._seqStepFlow then
		arg_29_0._seqStepFlow:onDestroyInternal()

		arg_29_0._seqStepFlow = nil
	end
end

function var_0_0.checkAndSetNeedResetData(arg_30_0, arg_30_1)
	EliminateChessModel.instance:setNeedResetData(arg_30_1)

	if (arg_30_0._turnInfo == nil or #arg_30_0._turnInfo == 0) and EliminateChessModel.instance:getNeedResetData() ~= nil then
		local var_30_0 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.RefreshEliminate)

		var_0_0.instance:buildSeqFlow(var_30_0)
	end
end

function var_0_0.checkState(arg_31_0)
	if EliminateChessModel.instance:getMovePoint() <= 0 then
		local var_31_0 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EndShowView, {
			time = EliminateEnum.ShowEndTime,
			cb = function()
				EliminateLevelController.instance:changeRoundToTeamChess()
			end,
			needShowEnd = EliminateLevelModel.instance:needPlayShowView()
		})

		var_0_0.instance:clearFlow()
		var_0_0.instance:buildSeqFlow(var_31_0)

		return true
	end

	return false
end

function var_0_0.clear(arg_33_0)
	arg_33_0:clearFlow()

	arg_33_0._flowFullEnd = false

	EliminateStepUtil.releaseMoveStepTable()

	arg_33_0._lastExchangePos = nil

	LocalEliminateChessModel.instance:clear()
	LengZhou6EliminateChessItemController.instance:clear()
end

function var_0_0.changeCellType(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	if arg_34_1 == nil or arg_34_2 == nil or arg_34_3 == nil then
		return
	end

	local var_34_0 = LocalEliminateChessModel.instance:changeCellId(arg_34_1, arg_34_2, EliminateEnum_2_7.ChessTypeToIndex[arg_34_3])

	if var_34_0 ~= nil then
		LengZhou6EliminateChessItemController.instance:getChessItem(arg_34_1, arg_34_2):initData(var_34_0)
		LocalEliminateChessModel.instance:addChangePoints(arg_34_1, arg_34_2)

		local var_34_1 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, true)

		arg_34_0:buildSeqFlow(var_34_1)
	end
end

function var_0_0.changeCellState(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	if arg_35_1 == nil or arg_35_2 == nil or arg_35_3 == nil then
		return
	end

	LocalEliminateChessModel.instance:changeCellState(arg_35_1, arg_35_2, arg_35_3)

	local var_35_0 = {
		x = arg_35_1,
		y = arg_35_2
	}
	local var_35_1 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.ChangeState, var_35_0)
	local var_35_2 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, true)

	arg_35_0:buildSeqFlow(var_35_1)
	arg_35_0:buildSeqFlow(var_35_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
