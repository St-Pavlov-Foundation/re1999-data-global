module("modules.logic.versionactivity2_2.eliminate.model.soldierSkillMo.SoliderSkillMOBase", package.seeall)

slot0 = class("SoliderSkillMOBase")

function slot0.init(slot0, slot1, slot2, slot3)
	slot0._soldierId = slot1
	slot0._uid = slot2
	slot0._strongholdId = slot3
	slot0._selectSoliderIds = {}

	slot0:initSkill()
end

function slot0.initSkill(slot0)
	slot1, slot0._needSelectSoliderCount, slot3 = EliminateTeamChessModel.instance:getSoliderIdEffectParam(slot0._soldierId)

	if slot1 ~= nil then
		slot0._needSelectSoliderType = slot1
		slot0._needSelectSoliderCount = EliminateTeamChessModel.instance:haveSoliderByTeamTypeAndStrongholdId(slot0._needSelectSoliderType, slot3 and slot0._strongholdId or nil) and slot0._needSelectSoliderCount or 0
	else
		slot0._needSelectSoliderCount = 0
	end
end

function slot0.setSelectSoliderId(slot0, slot1)
	if slot0:canRelease() then
		return true
	end

	if tonumber(slot1) == EliminateTeamChessEnum.tempPieceUid then
		return false
	end

	if slot2 > 0 and slot0._needSelectSoliderType == EliminateTeamChessEnum.TeamChessTeamType.player or slot2 < 0 and slot0._needSelectSoliderType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		table.insert(slot0._selectSoliderIds, slot1)

		return true
	end

	return false
end

function slot0.getNeedSelectSoliderType(slot0)
	return slot0._needSelectSoliderType
end

function slot0.canRelease(slot0)
	if slot0._needSelectSoliderCount then
		return slot0._needSelectSoliderCount <= #slot0._selectSoliderIds
	end

	return true
end

function slot0._getReleaseExParam(slot0)
	if slot0._selectSoliderIds and #slot0._selectSoliderIds > 0 then
		return slot0._selectSoliderIds[1]
	end

	return ""
end

function slot0.needClearTemp(slot0)
	return slot0._needSelectSoliderCount > 0
end

function slot0.releaseSkill(slot0, slot1, slot2)
	if slot0:canRelease() then
		EliminateTeamChessController.instance:sendWarChessPiecePlaceRequest(slot0._soldierId, slot0._uid, slot0._strongholdId, slot0:_getReleaseExParam(), slot1, slot2)
	end

	return slot0:canRelease()
end

return slot0
