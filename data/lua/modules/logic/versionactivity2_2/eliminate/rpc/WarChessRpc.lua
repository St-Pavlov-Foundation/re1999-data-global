module("modules.logic.versionactivity2_2.eliminate.rpc.WarChessRpc", package.seeall)

local var_0_0 = class("WarChessRpc", BaseRpc)

function var_0_0.sendWarChessCharacterSkillRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	local var_1_0 = WarChessModule_pb.WarChessCharacterSkillRequest()

	var_1_0.skillId = arg_1_1
	var_1_0.params = arg_1_2
	var_1_0.moduleType = arg_1_3

	arg_1_0:sendMsg(var_1_0, arg_1_4, arg_1_5)
end

function var_0_0.onReceiveWarChessCharacterSkillReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 and EliminateLevelModel.instance:getCurRoundType() == EliminateEnum.RoundType.TeamChess then
		EliminateTeamChessController.instance:handleServerTeamFight(arg_2_2.fight)
		EliminateTeamChessController.instance:handleTeamFightTurn(arg_2_2.turn, false)
	end
end

function var_0_0.sendWarChessRoundEndRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = WarChessModule_pb.WarChessRoundEndRequest()

	arg_3_0:sendMsg(var_3_0, arg_3_1, arg_3_2)
end

function var_0_0.onReceiveWarChessRoundEndReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		EliminateTeamChessController.instance:handleWarChessRoundEndReply(arg_4_2)
	end
end

function var_0_0.sendWarChessPiecePlaceRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7)
	local var_5_0 = WarChessModule_pb.WarChessPiecePlaceRequest()

	var_5_0.pieceId = arg_5_2
	var_5_0.strongholdId = arg_5_3
	var_5_0.type = arg_5_1
	var_5_0.pieceUid = arg_5_4 and arg_5_4 or 9999
	var_5_0.extraParams = arg_5_5 and arg_5_5 or ""

	arg_5_0:sendMsg(var_5_0, arg_5_6, arg_5_7)
end

function var_0_0.onReceiveWarChessPiecePlaceReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		local var_6_0 = arg_6_2.turn

		if var_6_0 == nil or var_6_0.step == nil then
			EliminateTeamChessController.instance:clearReleasePlaceSkill()
		else
			EliminateTeamChessController.instance:handleTeamFightTurn(arg_6_2.turn, false)
		end

		EliminateLevelController.instance:updatePlayerExtraWinCondition(arg_6_2.extraWinCondition)
	end
end

function var_0_0.sendWarChessPieceSellRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = WarChessModule_pb.WarChessPieceSellRequest()

	var_7_0.strongholdId = arg_7_2
	var_7_0.uid = arg_7_1

	arg_7_0:sendMsg(var_7_0, arg_7_3, arg_7_4)
end

function var_0_0.onReceiveWarChessPieceSellReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		EliminateTeamChessController.instance:handleServerTeamFight(arg_8_2.fight)
		EliminateTeamChessController.instance:handleTeamFightTurn(arg_8_2.turn, false)
		EliminateLevelController.instance:updatePlayerExtraWinCondition(arg_8_2.fight.extraWinCondition)
	end
end

function var_0_0.onReceiveWarChessRoundStartPush(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		EliminateTeamChessController.instance:handleTeamFight(arg_9_2.initFight)
		EliminateTeamChessController.instance:handleServerTeamFight(arg_9_2.fight)
		EliminateTeamChessController.instance:handleTeamFightTurn(arg_9_2.turn, true)
	end
end

function var_0_0.onReceiveWarChessFightResultPush(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		EliminateTeamChessController.instance:handleTeamFightResult(arg_10_2.fightResult)
		EliminateRpc.instance:sendGetMatch3WarChessFacadeInfoRequest()
	end
end

function var_0_0.sendWarChessMyRoundStartRequest(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = WarChessModule_pb.WarChessMyRoundStartRequest()

	var_11_0.moduleType = 0

	arg_11_0:sendMsg(var_11_0, arg_11_1, arg_11_2)
end

function var_0_0.onReceiveWarChessMyRoundStartReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == 0 then
		if EliminateLevelModel.instance:needPlayShowView() then
			local var_12_0 = EliminateTeamChessStepUtil.createStep(nil, EliminateTeamChessEnum.StepWorkType.teamChessBeginViewShow)

			EliminateTeamChessController.instance:buildSeqFlow(var_12_0)
		end

		EliminateTeamChessController.instance:handleServerTeamFight(arg_12_2.fight)
		EliminateTeamChessController.instance:handleTeamFightTurn(arg_12_2.turn, false)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
