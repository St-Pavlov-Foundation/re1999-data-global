module("modules.logic.versionactivity2_2.eliminate.controller.chess.EliminateChessController", package.seeall)

slot0 = class("EliminateChessController", BaseController)

function slot0.onInit(slot0)
	slot0._seqStepFlow = nil
	slot0._flowFullEnd = false
	slot0._lastExchangePos = {}
end

function slot0.reInit(slot0)
	slot0:clearFlow()

	slot0._lastExchangePos = {}
end

function slot0.sendGetMatch3WarChessInfoRequest(slot0, slot1, slot2, slot3)
	EliminateRpc.instance:sendGetMatch3WarChessInfoRequest(slot1, slot2, slot3)
end

function slot0.handleEliminateChessInfo(slot0, slot1)
	if not slot1 then
		return
	end

	if slot1.match3ChessBoard then
		EliminateChessModel.instance:initChessInfo(slot1.match3ChessBoard)
	end

	if slot1.movePoint then
		EliminateChessModel.instance:updateMovePoint(slot1.movePoint)
	end
end

function slot0.handleMatch3Tips(slot0, slot1)
	EliminateChessModel.instance:updateMatch3Tips(slot1)

	if EliminateChessModel.instance:getTipEliminateCount() == 0 then
		EliminateRpc.instance:sendRefreshMatch3WarChessInfoRequest()
	end
end

function slot0.handleMovePoint(slot0, slot1)
	EliminateChessModel.instance:updateMovePoint(slot1)
end

function slot0.handleTurnInfo(slot0, slot1, slot2)
	EliminateChessModel.instance:clearCurPlayAudioCount()
	EliminateChessModel.instance:clearTotalCount()

	if not slot2 and #slot0._lastExchangePos > 0 then
		slot3, slot4, slot5, slot6 = slot0:getRecordExchangePos()

		slot0:exchangeCellShow(slot3, slot4, slot5, slot6, EliminateEnum.AniTime.MoveRevert)
	end

	for slot6 = 1, #slot1 do
		slot0:cacheCurTurnInfo(slot1[slot6])
	end

	if slot0:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.HandleData)) then
		slot0:startSeqStepFlow()
	end

	slot0:clearRecord()
	slot0:setFlowEndState(true)
end

function slot0.cacheCurTurnInfo(slot0, slot1)
	if slot0._turnInfo == nil then
		slot0._turnInfo = {}
	end

	slot0._turnInfo[#slot0._turnInfo + 1] = slot1
end

function slot0.getCurTurn(slot0)
	if slot0._turnInfo == nil then
		return nil
	end

	return table.remove(slot0._turnInfo, 1)
end

function slot0.handleEliminate(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = FlowParallel.New()

	for slot6 = 1, #slot1 do
		slot7 = slot1[slot6].coordinate
		slot9 = slot1[slot6].type
		slot10 = slot1[slot6].source
		slot11 = {}

		if not string.nilorempty(slot1[slot6].extraData) and cjson.decode(slot8) then
			if slot12.diamondChangeMap then
				for slot17, slot18 in pairs(slot13) do
					table.insert(slot11, slot17)
					EliminateTeamChessModel.instance:updateResourceData(slot17, tonumber(slot18))
				end
			end

			if slot12.changePower then
				EliminateTeamChessModel.instance:updateMainCharacterPower(EliminateTeamChessEnum.TeamChessTeamType.player, tonumber(slot14))
			end
		end

		slot12 = #slot7
		slot16 = slot12

		EliminateChessModel.instance:addTotalEliminateCount(slot16)

		for slot16 = 1, slot12 do
			slot17 = slot7[slot16]
			slot18 = slot17.x + 1
			slot19 = slot17.y + 1

			EliminateChessModel.instance:getChessMo(slot18, slot19):setStatus(EliminateEnum.ChessState.Die)
			slot2:addWork(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Die, {
				x = slot18,
				y = slot19,
				resourceIds = slot11,
				source = slot10
			}))
		end
	end

	slot2:addWork(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.PlayEffect))
	slot2:addWork(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.PlayAudio))
	slot0:buildSeqFlow(slot2)
end

function slot0.handleDrop(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return
	end

	slot3 = {}
	slot4 = FlowParallel.New()

	if slot1.col then
		for slot8, slot9 in ipairs(slot1.col) do
			slot10 = slot9.col + 1

			for slot14, slot15 in ipairs(slot9.oldX) do
				slot16 = slot15 + 1
				slot17 = slot9.newX[slot14] + 1
				slot18 = EliminateChessModel.instance:getChessMo(slot10, slot16)

				slot18:setStartXY(slot10, slot16)
				slot18:setXY(slot10, slot17)
				EliminateChessModel.instance:updateChessMo(slot10, slot17, slot18)
				slot4:addWork(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, EliminateStepUtil.createOrGetMoveStepTable(EliminateChessItemController.instance:getChessItemByModel(slot18), slot18:getMoveTime(), EliminateEnum.AnimType.drop)))

				slot3[#slot3 + 1] = {
					model = slot18,
					viewItem = EliminateChessItemController.instance:getChessItemByModel(slot18)
				}
			end
		end
	end

	if slot1.row then
		for slot8, slot9 in ipairs(slot1.row) do
			slot10 = slot9.row + 1

			for slot14, slot15 in ipairs(slot9.oldY) do
				slot16 = slot15 + 1
				slot17 = slot9.newY[slot14] + 1
				slot18 = EliminateChessModel.instance:getChessMo(slot16, slot10)

				slot18:setStartXY(slot16, slot10)
				slot18:setXY(slot17, slot10)
				EliminateChessModel.instance:updateChessMo(slot17, slot10, slot18)
				slot4:addWork(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, EliminateStepUtil.createOrGetMoveStepTable(EliminateChessItemController.instance:getChessItemByModel(slot18), slot18:getMoveTime(), EliminateEnum.AnimType.drop)))

				slot3[#slot3 + 1] = {
					model = slot18,
					viewItem = EliminateChessItemController.instance:getChessItemByModel(slot18)
				}
			end
		end
	end

	if slot2.chess then
		slot6, slot7 = EliminateChessModel.instance:getMaxRowAndCol()

		for slot11 = 1, #slot5 do
			slot12 = slot5[slot11]
			slot14 = slot12.coordinate
			slot15 = slot14.x + 1
			slot16 = slot14.y + 1
			slot17 = EliminateChessMO.New()

			slot17:setXY(slot15, slot16)
			slot17:setStartXY(slot15, slot7 + 1)
			slot17:setChessId(slot12.id)
			EliminateChessModel.instance:updateChessMo(slot15, slot16, slot17)

			slot18 = EliminateChessItemController.instance:createChess(slot15, slot16)

			slot18:initData(slot17)
			slot4:addWork(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, EliminateStepUtil.createOrGetMoveStepTable(slot18, slot17:getMoveTime(), EliminateEnum.AnimType.drop)))

			slot3[#slot3 + 1] = {
				model = slot17,
				viewItem = slot18
			}
		end
	end

	slot0:buildSeqFlow(slot4)
	slot0:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Arrange, slot3))
	slot0:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.HandleData))

	if canLogNormal then
		-- Nothing
	end
end

function slot0.exchangeCell(slot0, slot1, slot2, slot3, slot4)
	slot6 = math.abs(slot2 - slot4)

	if math.abs(slot1 - slot3) > 1 or slot6 > 1 or slot5 == slot6 then
		return false
	end

	if slot0._turnInfo ~= nil and #slot0._turnInfo > 0 then
		return true
	end

	slot0:setFlowEndState(false)
	slot0:dispatchEvent(EliminateChessEvent.PerformBegin)
	slot0:recordExchangePos(slot1, slot2, slot3, slot4)
	slot0:exchangeCellShow(slot1, slot2, slot3, slot4, EliminateEnum.AniTime.Move)
	EliminateRpc.instance:sendMatch3ChessBoardSwapRequest(slot1, slot2, slot3, slot4, nil, )

	return true
end

function slot0.recordExchangePos(slot0, slot1, slot2, slot3, slot4)
	if not slot0._lastExchangePos then
		slot0._lastExchangePos = {}
	end

	slot0._lastExchangePos[#slot0._lastExchangePos + 1] = slot1
	slot0._lastExchangePos[#slot0._lastExchangePos + 1] = slot2
	slot0._lastExchangePos[#slot0._lastExchangePos + 1] = slot3
	slot0._lastExchangePos[#slot0._lastExchangePos + 1] = slot4
end

function slot0.getRecordExchangePos(slot0)
	return slot0._lastExchangePos[1], slot0._lastExchangePos[2], slot0._lastExchangePos[3], slot0._lastExchangePos[4]
end

function slot0.clearRecord(slot0)
	tabletool.clear(slot0._lastExchangePos)
end

function slot0.exchangeCellShow(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = {}
	slot7 = EliminateChessModel.instance:getChessMo(slot1, slot2)

	slot7:setXY(slot3, slot4)

	slot8 = EliminateChessModel.instance:getChessMo(slot3, slot4)

	slot8:setXY(slot1, slot2)
	EliminateChessModel.instance:updateChessMo(slot1, slot2, slot8)
	EliminateChessModel.instance:updateChessMo(slot3, slot4, slot7)

	slot14, slot15 = slot0:buildSeqFlow(slot0:buildParallelFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, EliminateStepUtil.createOrGetMoveStepTable(EliminateChessItemController.instance:getChessItemByModel(slot7), slot5, EliminateEnum.AnimType.move)), EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, EliminateStepUtil.createOrGetMoveStepTable(EliminateChessItemController.instance:getChessItemByModel(slot8), slot5, EliminateEnum.AnimType.move))))
	slot6[#slot6 + 1] = {
		model = slot7,
		viewItem = EliminateChessItemController.instance:getChessItemByModel(slot7)
	}
	slot6[#slot6 + 1] = {
		model = slot8,
		viewItem = EliminateChessItemController.instance:getChessItemByModel(slot8)
	}

	slot0:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Arrange, slot6))

	if canLogNormal then
		slot0:buildSeqFlow(EliminateChessDebugStep.New())
	end

	if slot14 then
		slot0:startSeqStepFlow()
	end
end

function slot0.createInitMoveStepAndUpdatePos(slot0)
	EliminateChessModel.instance:createInitMoveState()

	for slot5, slot6 in ipairs(EliminateChessItemController.instance:getChess()) do
		for slot10, slot11 in pairs(slot6) do
			slot11:updatePos(slot11)
		end
	end
end

function slot0.createInitMoveStep(slot0)
	slot2 = FlowParallel.New()

	for slot6, slot7 in ipairs(EliminateChessItemController.instance:getChess()) do
		for slot11, slot12 in pairs(slot7) do
			slot12:updatePos(slot12)
			slot2:addWork(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.Move, EliminateStepUtil.createOrGetMoveStepTable(slot12, slot12:getData():getInitMoveTime(), EliminateEnum.AnimType.init)))
		end
	end

	return slot0:buildSeqFlow(slot2)
end

function slot0.buildSeqFlow(slot0, slot1)
	slot2 = slot0._seqStepFlow == nil
	slot0._seqStepFlow = slot0._seqStepFlow or FlowSequence.New()

	if slot1 then
		slot0._seqStepFlow:addWork(slot1)
	end

	return slot2, slot0._seqStepFlow
end

function slot0.buildParallelFlow(slot0, ...)
	slot1 = FlowParallel.New()

	if (... ~= nil and select("#", ...) or 0) > 0 then
		for slot7 = 1, slot3 do
			slot1:addWork(select(slot7, ...))
		end
	end

	return slot1
end

function slot0.getCurSeqStepFlow(slot0)
	return slot0._seqStepFlow
end

function slot0.startSeqStepFlow(slot0)
	if slot0._seqStepFlow then
		slot0._seqStepFlow:registerDoneListener(slot0.seqFlowDone, slot0)
		slot0._seqStepFlow:start()
	end
end

function slot0.checkPerformEndState(slot0)
	if slot0._flowFullEnd and slot0._seqStepFlow == nil then
		slot0:dispatchEvent(EliminateChessEvent.PerformEnd)
	end
end

function slot0.setFlowEndState(slot0, slot1)
	slot0._flowFullEnd = slot1

	slot0:checkPerformEndState()
end

function slot0.seqFlowDone(slot0)
	slot0._seqStepFlow = nil

	slot0:checkPerformEndState()
end

function slot0.clearFlow(slot0)
	if slot0._seqStepFlow then
		slot0._seqStepFlow:onDestroyInternal()

		slot0._seqStepFlow = nil
	end
end

function slot0.checkAndSetNeedResetData(slot0, slot1)
	EliminateChessModel.instance:setNeedResetData(slot1)

	if (slot0._turnInfo == nil or #slot0._turnInfo == 0) and EliminateChessModel.instance:getNeedResetData() ~= nil and uv0.instance:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.RefreshEliminate)) then
		uv0.instance:startSeqStepFlow()
	end
end

function slot0.checkState(slot0)
	if EliminateChessModel.instance:getMovePoint() <= 0 then
		uv0.instance:clearFlow()

		if uv0.instance:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EndShowView, {
			time = EliminateEnum.ShowEndTime,
			cb = function ()
				EliminateLevelController.instance:changeRoundToTeamChess()
			end,
			needShowEnd = EliminateLevelModel.instance:needPlayShowView()
		})) then
			uv0.instance:startSeqStepFlow()
		end

		return true
	end

	return false
end

function slot0.openNoticeView(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	if ViewMgr.instance:getSetting(ViewName.EliminateNoticeView) then
		slot9.bgBlur = (slot4 or slot2) and 0 or 1
	end

	ViewMgr.instance:openView(ViewName.EliminateNoticeView, {
		isStart = slot1,
		isFinish = slot2,
		isTeamChess = slot3,
		isShowEvaluate = slot4,
		evaluateLevel = slot5,
		closeTime = slot6,
		closeCallback = slot7,
		closeCallbackTarget = slot8
	})
end

function slot0.clear(slot0)
	slot0:clearFlow()

	slot0._flowFullEnd = false

	EliminateStepUtil.releaseMoveStepTable()

	slot0._lastExchangePos = {}

	EliminateChessModel.instance:reInit()
	EliminateChessItemController.instance:clear()
end

slot0.instance = slot0.New()

return slot0
