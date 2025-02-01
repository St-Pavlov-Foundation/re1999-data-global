module("modules.logic.versionactivity2_2.eliminate.model.mo.TeamChessUnitMO", package.seeall)

slot0 = class("TeamChessUnitMO")

function slot0.init(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.uid = slot1 or 0
	slot0.soldierId = slot2 or 0
	slot0.stronghold = slot3 or 0
	slot0.pos = slot4 or 0
	slot0.teamType = slot5 or 0
end

function slot0.update(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.uid = slot1
	slot0.soldierId = slot2
	slot0.stronghold = slot3
	slot0.pos = slot4
	slot0.teamType = slot5
end

function slot0.getUid(slot0)
	return slot0.uid
end

function slot0.getSoldierConfig(slot0)
	return EliminateConfig.instance:getSoldierChessConfig(slot0.soldierId)
end

function slot0.getUnitPath(slot0)
	return EliminateConfig.instance:getSoldierChessModelPath(slot0.soldierId)
end

function slot0.getScale(slot0)
	return slot0:getSoldierConfig().resZoom
end

function slot0.getOrder(slot0)
	slot1 = 0

	if slot0.teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		slot1 = EliminateConfig.instance:getStrongHoldConfig(slot0.stronghold).enemyCapacity - EliminateTeamChessModel.instance:getStronghold(slot0.stronghold):getEnemySideIndexByUid(slot0.uid)
	end

	if slot0.teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		slot1 = slot2:getMySideIndexByUid(slot0.uid)
	end

	return slot1
end

function slot0.canActiveMove(slot0)
	return EliminateTeamChessModel.instance:getChess(slot0.uid) and slot1:canActiveMove() or false
end

function slot0.clear(slot0)
	slot0.uid = 0
	slot0.soldierId = 0
	slot0.stronghold = 0
	slot0.pos = 0
	slot0.teamType = 0
end

return slot0
