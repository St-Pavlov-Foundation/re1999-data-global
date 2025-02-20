module("modules.logic.versionactivity2_2.eliminate.model.EliminateTeamChessModel", package.seeall)

slot0 = class("EliminateTeamChessModel", BaseModel)

function slot0.onInit(slot0)
	slot0.curTeamChessWar = nil
	slot0.serverTeamChessWar = nil
	slot0.warFightResult = nil
	slot0.teamChessStepList = {}
	slot0._curTeamRoundStepState = EliminateTeamChessEnum.TeamChessRoundType.enemy
end

function slot0.reInit(slot0)
	slot0.curTeamChessWar = nil
	slot0.serverTeamChessWar = nil
	slot0.warFightResult = nil
	slot0._teamChessSkillState = nil
	slot0.teamChessStepList = {}
end

function slot0.initTeamChess(slot0, slot1)
	slot0._warChessId = slot1
end

function slot0.getCurWarChessEpisodeConfig(slot0)
	return EliminateConfig.instance:getWarChessEpisodeConfig(slot0._warChessId)
end

function slot0.handleCurTeamChessWarFightInfo(slot0, slot1)
	if slot0.curTeamChessWar == nil then
		slot0.curTeamChessWar = EliminateTeamChessWarMO.New()

		slot0.curTeamChessWar:init(slot1)
	end

	slot0.curTeamChessWar:updateInfo(slot1)
end

function slot0.handleServerTeamChessWarFightInfo(slot0, slot1)
	if slot0.serverTeamChessWar == nil then
		slot0.serverTeamChessWar = EliminateTeamChessWarMO.New()

		slot0.serverTeamChessWar:init(slot1)
	end

	slot0.serverTeamChessWar:updateInfo(slot1)
end

function slot0.handleTeamFightResult(slot0, slot1)
	if not slot0.warFightResult then
		slot0.warFightResult = WarChessFightResultMO.New()
	end

	slot0.warFightResult:updateInfo(slot1)
end

function slot0.handleTeamFightTurn(slot0, slot1)
	if slot1 == nil or slot1.step == nil then
		return
	end

	for slot5, slot6 in ipairs(slot1.step) do
		slot7 = WarChessStepMO.New()

		slot7:init(slot6)

		slot0.teamChessStepList[#slot0.teamChessStepList + 1] = slot7
	end
end

function slot0.getTeamChessStepList(slot0)
	return slot0.teamChessStepList
end

function slot0.getCurTeamChessWar(slot0)
	return slot0.curTeamChessWar
end

function slot0.getServerTeamChessWar(slot0)
	return slot0.serverTeamChessWar
end

function slot0.getSlotIds(slot0)
	return slot0.curTeamChessWar and slot0.curTeamChessWar:getSlotIds() or {}
end

function slot0.getStrongholds(slot0)
	return slot0.curTeamChessWar and slot0.curTeamChessWar:getStrongholds() or {}
end

function slot0.getStronghold(slot0, slot1)
	return slot0.curTeamChessWar and slot0.curTeamChessWar:getStronghold(slot1) or nil
end

function slot0.getCurTeamMyInfo(slot0)
	return slot0.curTeamChessWar and slot0.curTeamChessWar.myCharacter or nil
end

function slot0.getCurTeamEnemyInfo(slot0)
	return slot0.curTeamChessWar and slot0.curTeamChessWar.enemyCharacter or nil
end

function slot0.getEnemyForecastChess(slot0)
	if uv0.instance:getCurTeamEnemyInfo() and #slot1.forecastBehavior ~= 0 then
		return slot2
	end

	return nil
end

function slot0.getAllPlayerSoliderCount(slot0)
	for slot6, slot7 in pairs(slot0:getStrongholds()) do
		slot2 = 0 + slot7:getPlayerSoliderCount()
	end

	return slot2
end

function slot0.getCurTeamResource(slot0)
	return slot0:getCurTeamMyInfo() and slot1.diamonds or {}
end

function slot0.getResourceNumber(slot0, slot1)
	return slot0:getCurTeamMyInfo() and slot2.diamonds and slot2.diamonds[slot1] or 0
end

function slot0.getWarFightResult(slot0)
	return slot0.warFightResult
end

function slot0.updateChessPower(slot0, slot1, slot2)
	if slot0.curTeamChessWar then
		slot0.curTeamChessWar:updateChessPower(slot1, slot2)
	end
end

function slot0.updateDisplacementState(slot0, slot1, slot2)
	if slot0.curTeamChessWar then
		slot0.curTeamChessWar:updateDisplacementState(slot1, slot2)
	end
end

function slot0.updateStrongholdsScore(slot0, slot1, slot2, slot3)
	if slot0.curTeamChessWar then
		slot0.curTeamChessWar:updateStrongholdsScore(slot1, slot2, slot3)
	end
end

function slot0.updateMainCharacterHp(slot0, slot1, slot2)
	if slot0.curTeamChessWar then
		slot0.curTeamChessWar:updateMainCharacterHp(slot1, slot2)
	end
end

function slot0.updateMainCharacterPower(slot0, slot1, slot2)
	if slot0.curTeamChessWar then
		slot0.curTeamChessWar:updateMainCharacterPower(slot1, slot2)
	end
end

function slot0.updateResourceData(slot0, slot1, slot2)
	if slot0.curTeamChessWar then
		slot0.curTeamChessWar:updateResourceData(slot1, slot2)
	end
end

function slot0.removeStrongholdChess(slot0, slot1, slot2)
	if slot0.curTeamChessWar then
		slot0.curTeamChessWar:removeStrongholdChess(slot1, slot2)
	end
end

function slot0.getChess(slot0, slot1)
	if slot0.curTeamChessWar then
		return slot0.curTeamChessWar:getChess(slot1)
	end

	return nil
end

function slot0.strongHoldSettle(slot0, slot1, slot2)
	if slot0.curTeamChessWar then
		slot0.curTeamChessWar:strongHoldSettle(slot1, slot2)
	end
end

function slot0.updateSkillGrowUp(slot0, slot1, slot2, slot3)
	if slot0.curTeamChessWar then
		slot0.curTeamChessWar:updateSkillGrowUp(slot1, slot2, slot3)
	end
end

function slot0.diamondsIsEnough(slot0, slot1, slot2)
	if not slot0.curTeamChessWar then
		return false
	end

	return slot0.curTeamChessWar:diamondsIsEnough(slot1, slot2)
end

function slot0.getViewCanvas(slot0)
	return slot0._canvas
end

function slot0.setViewCanvas(slot0, slot1)
	slot0._canvas = slot1
end

function slot0.getTipViewParent(slot0)
	return slot0._tipViewParent
end

function slot0.setTipViewParent(slot0, slot1)
	slot0._tipViewParent = slot1
end

function slot0.setCurTeamRoundStepState(slot0, slot1)
	slot0._curTeamRoundStepState = slot1
end

function slot0.getCurTeamRoundStepState(slot0)
	return slot0._curTeamRoundStepState
end

function slot0.clear(slot0)
	slot0._canvas = nil
	slot0._tipViewParent = nil
	slot0.curTeamChessWar = nil
	slot0.serverTeamChessWar = nil
	slot0.warFightResult = nil
	slot0.teamChessStepList = {}

	if slot0._cacheRuleLimit ~= nil then
		slot0._cacheRuleLimit = nil
	end

	slot0._curTeamRoundStepState = EliminateTeamChessEnum.TeamChessRoundType.enemy
end

function slot0.getSellResourceData(slot0, slot1)
	slot2 = {}

	for slot7 = 1, #slot1 do
		slot8 = slot1[slot7]

		table.insert(slot2, {
			slot8[1],
			math.floor(slot8[2] * EliminateConfig.instance:getSellSoliderPermillage() / 1000)
		})
	end

	return slot2
end

function slot0.canUseChess(slot0, slot1)
	slot3 = true

	if EliminateConfig.instance:getSoldierChessConfigConst(slot1) then
		for slot7, slot8 in ipairs(slot2) do
			if slot0:getResourceNumber(slot8[1]) < tonumber(slot8[2]) then
				slot3 = false

				break
			end
		end
	else
		slot3 = true
	end

	return slot3
end

function slot0.getSoliderIdEffectParam(slot0, slot1)
	slot8 = EliminateConfig.instance:getSoldierChessConfig(slot1) and slot2.skillId or ""

	for slot7, slot8 in ipairs(string.splitToNumber(slot8, "#")) do
		if EliminateTeamChessEnum.placeSkillEffectParamConfigEnum[string.split(EliminateConfig.instance:getSoldierSkillConfig(slot8) and slot9.effect or "", "#")[1]] and EliminateTeamChessEnum.placeSkillEffectParamConfigEnum[slot11][slot10[2]] then
			return slot13.teamType, slot13.count, slot13.limitStrongHold
		end
	end

	return nil, , false
end

function slot0.createPlaceMo(slot0, slot1, slot2, slot3)
	slot4 = SoliderSkillMOBase.New()

	slot4:init(slot1, slot2, slot3)

	return slot4
end

function slot0.haveSoliderByTeamTypeAndStrongholdId(slot0, slot1, slot2)
	for slot8 = 1, #slot0:getStrongholds() do
		if slot2 == nil or slot2 == slot2 then
			if not false then
				if slot1 == EliminateTeamChessEnum.TeamChessTeamType.player then
					slot4 = #slot3[slot8].mySidePiece > 0
				end

				if slot1 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
					slot4 = #slot9.enemySidePiece > 0
				end
			else
				break
			end
		end
	end

	return slot4
end

function slot0.sourceStrongHoldInRight(slot0, slot1, slot2)
	slot4 = 0
	slot5 = 0

	for slot9 = 1, #slot0:getStrongholds() do
		if slot3[slot9].id == slot2 then
			slot4 = slot9
		end

		if slot10.id == slot1 then
			slot5 = slot9
		end
	end

	return slot5 < slot4
end

function slot0.strongHoldIsFull(slot0, slot1)
	for slot6 = 1, #slot0:getStrongholds() do
		if slot1 == slot2[slot6].id then
			return slot7:isFull(EliminateTeamChessEnum.TeamChessTeamType.player)
		end
	end

	return false
end

function slot0.allStrongHoldIsIsFull(slot0)
	slot1 = false

	for slot6 = 1, #slot0:getStrongholds() do
		if slot2[slot6]:isFull(EliminateTeamChessEnum.TeamChessTeamType.player) then
			slot1 = true
		end
	end

	return slot1
end

function slot0.haveEnoughResource(slot0)
	if EliminateLevelModel.instance:getCurLevelPieceIds() ~= nil then
		for slot5 = 1, #slot1 do
			if slot0:canUseChess(slot1[slot5]) then
				return true
			end
		end
	end

	return false
end

function slot0.canReleaseSkillAddResource(slot0)
	if not EliminateLevelModel.instance:mainCharacterSkillIsUnLock() then
		return false
	end

	slot2 = false

	if uv0.instance:getCurTeamMyInfo() then
		slot3 = nil
		slot5 = EliminateConfig.instance:getMainCharacterSkillConfig(EliminateConfig.instance:getTeamChessCharacterConfig(slot1.id).activeSkillIds)
		slot2 = EliminateLevelController.instance:canReleaseByRound(EliminateLevelController.instance:getTempSkillMo(slot5.id, slot5.effect)) and slot5.cost <= slot1.power
	end

	return slot2
end

function slot0.strongHoldTotalScoreWin(slot0)
	for slot7 = 1, #slot0:getStrongholds() do
		slot8 = slot3[slot7]
		slot1 = 0 + slot8.enemyScore
		slot2 = 0 + slot8.myScore
	end

	return slot1 < slot2
end

function slot0.calDamageGear(slot0, slot1)
	slot3 = 1

	if EliminateConfig.instance:getCharacterDamageGear() and #slot2 == 2 and slot1 then
		slot3 = slot1 < slot2[2] and (slot2[1] <= slot1 and 2 or 1) or 3
	end

	return slot3
end

function slot0.isCanPlaceByStrongHoldRule(slot0, slot1, slot2)
	slot5 = EliminateLevelModel.instance:getRoundNumber()
	slot6 = EliminateConfig.instance:getStrongHoldRuleRuleConfig(EliminateConfig.instance:getStrongHoldConfig(slot1).ruleId) and slot4.putLimit or 0

	if slot0._cacheRuleLimit == nil then
		slot0._cacheRuleLimit = {}
	end

	if slot0._cacheRuleLimit[slot4.id] == nil then
		slot0._cacheRuleLimit[slot4.id] = string.splitToNumber(slot6, "#")
		slot7 = slot0._cacheRuleLimit[slot4.id]
	end

	if slot4.startEffectRound <= slot5 and slot5 <= slot4.endEffectRound and tabletool.len(slot7) > 0 then
		for slot12 = 1, #slot7 do
			if tonumber(slot7[slot12]) == EliminateConfig.instance:getSoldierChessConfig(slot2).level then
				return false
			end
		end
	end

	return true
end

function slot0.setTeamChessSkillState(slot0, slot1)
	slot0._teamChessSkillState = slot1
end

function slot0.getTeamChessSkillState(slot0)
	if slot0._teamChessSkillState == nil then
		-- Nothing
	end

	return slot0._teamChessSkillState
end

function slot0.chessSkillIsGrowUp(slot0)
	return EliminateConfig.instance:getSoliderSkillConfig(slot0) and slot1.type == EliminateTeamChessEnum.SoliderSkillType.GrowUp
end

slot0.instance = slot0.New()

return slot0
