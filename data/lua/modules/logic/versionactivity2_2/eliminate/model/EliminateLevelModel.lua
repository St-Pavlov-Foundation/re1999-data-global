module("modules.logic.versionactivity2_2.eliminate.model.EliminateLevelModel", package.seeall)

slot0 = class("EliminateLevelModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.initLevel(slot0, slot1, slot2, slot3)
	slot0._levelId = slot1
	slot0._warChessCharacterId = slot2
	slot0._pieceIds = slot3
	slot0.curRoundType = EliminateEnum.RoundType.TeamChess

	EliminateTeamChessModel.instance:initTeamChess(EliminateConfig.instance:getEliminateEpisodeConfig(slot0._levelId).warChessId)

	slot0.beginTime = Time.realtimeSinceStartup
end

function slot0.getCurLevelPieceIds(slot0)
	return slot0._pieceIds
end

function slot0.setCurRoundType(slot0, slot1)
	slot0.curRoundType = slot1
end

function slot0.getWarChessCharacterId(slot0)
	return slot0._warChessCharacterId
end

function slot0.setNeedChangeTeamToEliminate(slot0, slot1)
	slot0._needChangeTeamToEliminate = slot1
end

function slot0.getLevelId(slot0)
	return slot0._levelId
end

function slot0.getCurLevelConfig(slot0)
	return EliminateConfig.instance:getEliminateEpisodeConfig(slot0._levelId)
end

function slot0.getCurRoundType(slot0)
	return slot0.curRoundType
end

function slot0.getRoundNumber(slot0)
	return EliminateTeamChessModel.instance:getServerTeamChessWar() and slot1.round or 1
end

function slot0.needPlayShowView(slot0)
	return slot0:getRoundNumber() < 2
end

function slot0.getNeedChangeTeamToEliminate(slot0)
	return slot0._needChangeTeamToEliminate
end

function slot0.clear(slot0)
	slot0.curRoundType = nil
	slot0._needChangeTeamToEliminate = nil
	slot0.curRoundNumber = 1
	slot0._useSkillCount = 0
	slot0._star = 0
end

function slot0.mainCharacterSkillIsUnLock(slot0)
	if EliminateConfig.instance:getUnLockMainCharacterSkillConst() then
		return EliminateOutsideModel.instance:hasPassedEpisode(slot1)
	end

	return false
end

function slot0.sellChessIsUnLock(slot0)
	if EliminateConfig.instance:getUnLockChessSellConst() then
		return EliminateOutsideModel.instance:hasPassedEpisode(slot1)
	end

	return false
end

function slot0.selectSoliderIsUnLock(slot0)
	if tonumber(EliminateConfig.instance:getUnLockSelectSoliderConst()) then
		return EliminateOutsideModel.instance:hasPassedEpisode(slot1)
	end

	return false
end

function slot0.canReleaseSkill(slot0)
	if EliminateTeamChessModel.instance:getCurTeamMyInfo() == nil then
		return false
	end

	if not EliminateConfig.instance:getMainCharacterSkillConfig(EliminateConfig.instance:getTeamChessCharacterConfig(slot1.id).activeSkillIds) or string.nilorempty(slot3.effect) then
		return false
	end

	return slot3.cost <= slot1.power
end

function slot0.setIsWatchTeamChess(slot0, slot1)
	slot0._isWatchTeamChess = slot1
end

function slot0.getIsWatchTeamChess(slot0)
	if slot0._isWatchTeamChess == nil then
		-- Nothing
	end

	return slot0._isWatchTeamChess
end

function slot0.formatString(slot0, slot1)
	return slot0:gsub("<(.-):(.-)>", function (slot0, slot1)
		slot2 = uv0 and uv0[slot1] or EliminateTeamChessEnum.PreBattleFormatType[slot1]

		return slot2 and string.format(slot2, slot0) or slot0
	end)
end

function slot0.getAllStrongHoldId(slot0)
	slot1 = {}

	for slot6 = 1, #EliminateTeamChessModel.instance:getStrongholds() do
		table.insert(slot1, slot2[slot6].id)
	end

	return slot1
end

function slot0.getAllPieceName(slot0)
	slot1 = {}

	for slot5 = 1, #slot0._pieceIds do
		table.insert(slot1, EliminateConfig.instance:getSoldierChessConfig(slot0._pieceIds[slot5]).name)
	end

	return slot1
end

function slot0.setStar(slot0, slot1)
	slot0._star = slot1
end

function slot0.getStar(slot0)
	return slot0._star or 0
end

function slot0.resourceIdToDict(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		table.insert(slot2, {
			resources_colour = slot6,
			resources_num = slot7
		})
	end

	return slot2
end

function slot0.addMainUseSkillNum(slot0)
	slot0._useSkillCount = (slot0._useSkillCount or 0) + 1
end

function slot0.getMainUseSkillNum(slot0)
	return slot0._useSkillCount or 0
end

function slot0.sendStatData(slot0, slot1)
	slot2 = slot0:getAllStrongHoldId()
	slot4 = EliminateConfig.instance:getMainCharacterSkillConfig(EliminateConfig.instance:getTeamChessCharacterConfig(slot0._warChessCharacterId).activeSkillIds)
	slot5 = slot0:getAllPieceName()
	slot6 = slot0:getStar()
	slot8 = EliminateTeamChessModel.instance:getCurTeamEnemyInfo()
	slot9 = 0
	slot10 = 0
	slot11 = 0
	slot12 = 0

	if EliminateTeamChessModel.instance:getCurTeamMyInfo() ~= nil then
		slot9 = slot7.hp
		slot12 = slot7.hpInjury
	end

	if slot8 ~= nil then
		slot10 = slot8.hp
		slot11 = slot8.hpInjury
	end

	StatController.instance:track(StatEnum.EventName.TeamchessSettlement, {
		[StatEnum.EventProperties.EpisodeId] = tostring(slot0._levelId),
		[StatEnum.EventProperties.StrongholdId] = slot2,
		[StatEnum.EventProperties.MainFighter] = slot3.name,
		[StatEnum.EventProperties.MainFighterSkill] = slot4.name,
		[StatEnum.EventProperties.InitialChess] = slot5,
		[StatEnum.EventProperties.Result] = slot1,
		[StatEnum.EventProperties.Star] = slot6,
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - slot0.beginTime,
		[StatEnum.EventProperties.TotalRound] = slot0:getRoundNumber(),
		[StatEnum.EventProperties.OurRemainingHP] = slot9,
		[StatEnum.EventProperties.EnemyRemainingHP] = slot10,
		[StatEnum.EventProperties.SettlementHarm] = slot11,
		[StatEnum.EventProperties.SettlementInjury] = slot12,
		[StatEnum.EventProperties.GainResources] = slot0:resourceIdToDict(slot7.addDiamonds),
		[StatEnum.EventProperties.ConsumeResources] = slot0:resourceIdToDict(slot7.removeDiamonds),
		[StatEnum.EventProperties.ResidueResources] = slot0:resourceIdToDict(slot7.diamonds),
		[StatEnum.EventProperties.MainFighterSkillNum] = slot0:getMainUseSkillNum()
	})
end

slot0.instance = slot0.New()

return slot0
