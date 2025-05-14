module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.EliminateTeamChessController", package.seeall)

local var_0_0 = class("EliminateTeamChessController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.handleTeamFight(arg_3_0, arg_3_1)
	EliminateTeamChessModel.instance:handleCurTeamChessWarFightInfo(arg_3_1)
end

function var_0_0.handleServerTeamFight(arg_4_0, arg_4_1)
	EliminateTeamChessModel.instance:handleServerTeamChessWarFightInfo(arg_4_1)
end

function var_0_0.handleWarChessRoundEndReply(arg_5_0, arg_5_1)
	EliminateTeamChessModel.instance:setCurTeamRoundStepState(EliminateTeamChessEnum.TeamChessRoundType.settlement)
	var_0_0.instance:handleTeamFightTurn(arg_5_1.turn, not arg_5_1.isFinish)
	var_0_0.instance:handleServerTeamFight(arg_5_1.fight)
	EliminateLevelModel.instance:setNeedChangeTeamToEliminate(not arg_5_1.isFinish)
end

function var_0_0.handleTeamFightResult(arg_6_0, arg_6_1)
	EliminateTeamChessModel.instance:handleTeamFightResult(arg_6_1)
	arg_6_0:buildSeqFlow(EliminateTeamChessStepUtil.createStep(nil, EliminateTeamChessEnum.StepWorkType.teamChessFightResult))
end

function var_0_0.handleTeamFightTurn(arg_7_0, arg_7_1, arg_7_2)
	EliminateTeamChessModel.instance:handleTeamFightTurn(arg_7_1)
	arg_7_0:buildFlowByTurn()
	arg_7_0:buildSeqFlow(EliminateTeamChessStepUtil.createStep(nil, EliminateTeamChessEnum.StepWorkType.teamChessServerDataDiff))

	if arg_7_2 then
		arg_7_0:buildSeqFlow(EliminateTeamChessStepUtil.createStep(nil, EliminateTeamChessEnum.StepWorkType.teamChessCheckRoundState))
	end
end

function var_0_0.buildFlowByTurn(arg_8_0)
	local var_8_0 = EliminateTeamChessModel.instance:getTeamChessStepList()

	if var_8_0 == nil or #var_8_0 == 0 then
		return
	end

	local var_8_1 = #var_8_0

	for iter_8_0 = 1, var_8_1 do
		local var_8_2 = table.remove(var_8_0, 1):buildSteps()

		for iter_8_1, iter_8_2 in ipairs(var_8_2) do
			arg_8_0:buildSeqFlow(iter_8_2)
		end
	end
end

function var_0_0.buildSeqFlow(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._seqStepFlow == nil

	arg_9_0._seqStepFlow = arg_9_0._seqStepFlow or FlowSequence.New()

	arg_9_0._seqStepFlow:addWork(arg_9_1)

	if var_9_0 and arg_9_0._canStart then
		arg_9_0:startSeqStepFlow()
	end
end

function var_0_0.setStartStepFlow(arg_10_0, arg_10_1)
	arg_10_0._canStart = arg_10_1
end

function var_0_0.startSeqStepFlow(arg_11_0)
	if arg_11_0._seqStepFlow ~= nil and arg_11_0._seqStepFlow.status ~= WorkStatus.Running and #arg_11_0._seqStepFlow:getWorkList() > 0 then
		arg_11_0:dispatchEvent(EliminateChessEvent.TeamChessOnFlowStart)
		arg_11_0._seqStepFlow:registerDoneListener(arg_11_0.seqFlowDone, arg_11_0)
		arg_11_0._seqStepFlow:start()
	end
end

function var_0_0.seqFlowDone(arg_12_0, arg_12_1)
	arg_12_0:dispatchEvent(EliminateChessEvent.TeamChessOnFlowEnd, arg_12_1)

	arg_12_0._seqStepFlow = nil
end

function var_0_0.sendWarChessPiecePlaceRequest(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6)
	local var_13_0 = EliminateTeamChessEnum.ChessPlaceType.place

	if arg_13_2 ~= nil then
		var_13_0 = EliminateTeamChessEnum.ChessPlaceType.activeMove
	end

	logNormal("sendWarChessPiecePlaceRequest", var_13_0, arg_13_1, arg_13_3, arg_13_2, arg_13_4)
	WarChessRpc.instance:sendWarChessPiecePlaceRequest(var_13_0, arg_13_1, arg_13_3, arg_13_2, arg_13_4, arg_13_5, arg_13_6)
end

function var_0_0.sendWarChessRoundEndRequest(arg_14_0, arg_14_1, arg_14_2)
	WarChessRpc.instance:sendWarChessRoundEndRequest(arg_14_1, arg_14_2)
end

function var_0_0.createPlaceSkill(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0._soliderPlaceSkill = EliminateTeamChessModel.instance:createPlaceMo(arg_15_1, arg_15_2, arg_15_3)
end

function var_0_0.getPlaceSkill(arg_16_0)
	return arg_16_0._soliderPlaceSkill
end

function var_0_0.setShowSkillEntityState(arg_17_0, arg_17_1)
	if arg_17_0._soliderPlaceSkill then
		local var_17_0 = arg_17_0._soliderPlaceSkill:getNeedSelectSoliderType()

		if arg_17_1 then
			TeamChessUnitEntityMgr.instance:setTempShowModeAndCacheByTeamType(var_17_0, EliminateTeamChessEnum.ModeType.Outline)
		else
			TeamChessUnitEntityMgr.instance:restoreTempShowModeAndCacheByTeamType(var_17_0)
		end
	end
end

function var_0_0.checkAndReleasePlaceSkill(arg_18_0)
	if arg_18_0._soliderPlaceSkill then
		return arg_18_0._soliderPlaceSkill:releaseSkill(arg_18_0.clearTemp, arg_18_0)
	end

	return false
end

function var_0_0.addTempChessAndPlace(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0, var_19_1 = EliminateTeamChessModel.instance:getStronghold(arg_19_3):addTempPiece(EliminateTeamChessEnum.TeamChessTeamType.player, arg_19_1)

	arg_19_0:dispatchEvent(EliminateChessEvent.AddStrongholdChess, var_19_0, arg_19_3, var_19_1)
	arg_19_0:setShowSkillEntityState(true)
end

function var_0_0.removeTempChessAndPlace(arg_20_0, arg_20_1)
	local var_20_0 = EliminateTeamChessModel.instance:getStronghold(arg_20_1)
	local var_20_1 = EliminateTeamChessEnum.tempPieceUid

	var_20_0:removeChess(var_20_1)
	arg_20_0:dispatchEvent(EliminateChessEvent.RemoveStrongholdChess, arg_20_1, var_20_1)
	arg_20_0:setShowSkillEntityState(false)
end

function var_0_0.clearTemp(arg_21_0)
	arg_21_0:clearReleasePlaceSkill()
	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessSelectEffectEnd)
end

function var_0_0.clearReleasePlaceSkill(arg_22_0)
	if arg_22_0._soliderPlaceSkill and arg_22_0._soliderPlaceSkill:needClearTemp() then
		arg_22_0:removeTempChessAndPlace(arg_22_0._soliderPlaceSkill._strongholdId)
	end

	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessSelectEffectEnd)

	arg_22_0._soliderPlaceSkill = nil
end

function var_0_0.clear(arg_23_0)
	arg_23_0._canStart = false

	if arg_23_0._seqStepFlow then
		arg_23_0._seqStepFlow:onDestroyInternal()

		arg_23_0._seqStepFlow = nil
	end

	arg_23_0:clearReleasePlaceSkill()
	TeamChessUnitEntityMgr.instance:clear()
	EliminateTeamChessModel.instance:clear()
end

var_0_0.instance = var_0_0.New()

return var_0_0
