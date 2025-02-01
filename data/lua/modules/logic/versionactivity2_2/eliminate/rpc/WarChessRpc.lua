module("modules.logic.versionactivity2_2.eliminate.rpc.WarChessRpc", package.seeall)

slot0 = class("WarChessRpc", BaseRpc)

function slot0.sendWarChessCharacterSkillRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = WarChessModule_pb.WarChessCharacterSkillRequest()
	slot6.skillId = slot1
	slot6.params = slot2
	slot6.moduleType = slot3

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveWarChessCharacterSkillReply(slot0, slot1, slot2)
	if slot1 == 0 and EliminateLevelModel.instance:getCurRoundType() == EliminateEnum.RoundType.TeamChess then
		EliminateTeamChessController.instance:handleServerTeamFight(slot2.fight)
		EliminateTeamChessController.instance:handleTeamFightTurn(slot2.turn, false)
	end
end

function slot0.sendWarChessRoundEndRequest(slot0, slot1, slot2)
	slot0:sendMsg(WarChessModule_pb.WarChessRoundEndRequest(), slot1, slot2)
end

function slot0.onReceiveWarChessRoundEndReply(slot0, slot1, slot2)
	if slot1 == 0 then
		EliminateTeamChessController.instance:handleWarChessRoundEndReply(slot2)
	end
end

function slot0.sendWarChessPiecePlaceRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot8 = WarChessModule_pb.WarChessPiecePlaceRequest()
	slot8.pieceId = slot2
	slot8.strongholdId = slot3
	slot8.type = slot1
	slot8.pieceUid = slot4 and slot4 or 9999
	slot8.extraParams = slot5 and slot5 or ""

	slot0:sendMsg(slot8, slot6, slot7)
end

function slot0.onReceiveWarChessPiecePlaceReply(slot0, slot1, slot2)
	if slot1 == 0 then
		if slot2.turn == nil or slot3.step == nil then
			EliminateTeamChessController.instance:clearReleasePlaceSkill()
		else
			EliminateTeamChessController.instance:handleTeamFightTurn(slot2.turn, false)
		end

		EliminateLevelController.instance:updatePlayerExtraWinCondition(slot2.extraWinCondition)
	end
end

function slot0.sendWarChessPieceSellRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = WarChessModule_pb.WarChessPieceSellRequest()
	slot5.strongholdId = slot2
	slot5.uid = slot1

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveWarChessPieceSellReply(slot0, slot1, slot2)
	if slot1 == 0 then
		EliminateTeamChessController.instance:handleServerTeamFight(slot2.fight)
		EliminateTeamChessController.instance:handleTeamFightTurn(slot2.turn, false)
		EliminateLevelController.instance:updatePlayerExtraWinCondition(slot2.fight.extraWinCondition)
	end
end

function slot0.onReceiveWarChessRoundStartPush(slot0, slot1, slot2)
	if slot1 == 0 then
		EliminateTeamChessController.instance:handleTeamFight(slot2.initFight)
		EliminateTeamChessController.instance:handleServerTeamFight(slot2.fight)
		EliminateTeamChessController.instance:handleTeamFightTurn(slot2.turn, true)
	end
end

function slot0.onReceiveWarChessFightResultPush(slot0, slot1, slot2)
	if slot1 == 0 then
		EliminateTeamChessController.instance:handleTeamFightResult(slot2.fightResult)
		EliminateRpc.instance:sendGetMatch3WarChessFacadeInfoRequest()
	end
end

function slot0.sendWarChessMyRoundStartRequest(slot0, slot1, slot2)
	slot3 = WarChessModule_pb.WarChessMyRoundStartRequest()
	slot3.moduleType = 0

	slot0:sendMsg(slot3, slot1, slot2)
end

function slot0.onReceiveWarChessMyRoundStartReply(slot0, slot1, slot2)
	if slot1 == 0 then
		if EliminateLevelModel.instance:needPlayShowView() then
			EliminateTeamChessController.instance:buildSeqFlow(EliminateTeamChessStepUtil.createStep(nil, EliminateTeamChessEnum.StepWorkType.teamChessBeginViewShow))
		end

		EliminateTeamChessController.instance:handleServerTeamFight(slot2.fight)
		EliminateTeamChessController.instance:handleTeamFightTurn(slot2.turn, false)
	end
end

slot0.instance = slot0.New()

return slot0
