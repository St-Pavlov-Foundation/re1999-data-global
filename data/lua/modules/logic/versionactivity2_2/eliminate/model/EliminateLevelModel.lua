module("modules.logic.versionactivity2_2.eliminate.model.EliminateLevelModel", package.seeall)

local var_0_0 = class("EliminateLevelModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.initLevel(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0._levelId = arg_3_1
	arg_3_0._warChessCharacterId = arg_3_2
	arg_3_0._pieceIds = arg_3_3
	arg_3_0.curRoundType = EliminateEnum.RoundType.TeamChess

	local var_3_0 = EliminateConfig.instance:getEliminateEpisodeConfig(arg_3_0._levelId)

	EliminateTeamChessModel.instance:initTeamChess(var_3_0.warChessId)

	arg_3_0.beginTime = Time.realtimeSinceStartup
end

function var_0_0.getCurLevelPieceIds(arg_4_0)
	return arg_4_0._pieceIds
end

function var_0_0.setCurRoundType(arg_5_0, arg_5_1)
	arg_5_0.curRoundType = arg_5_1
end

function var_0_0.getWarChessCharacterId(arg_6_0)
	return arg_6_0._warChessCharacterId
end

function var_0_0.setNeedChangeTeamToEliminate(arg_7_0, arg_7_1)
	arg_7_0._needChangeTeamToEliminate = arg_7_1
end

function var_0_0.getLevelId(arg_8_0)
	return arg_8_0._levelId
end

function var_0_0.getCurLevelConfig(arg_9_0)
	return EliminateConfig.instance:getEliminateEpisodeConfig(arg_9_0._levelId)
end

function var_0_0.getCurRoundType(arg_10_0)
	return arg_10_0.curRoundType
end

function var_0_0.getRoundNumber(arg_11_0)
	local var_11_0 = EliminateTeamChessModel.instance:getServerTeamChessWar()

	return var_11_0 and var_11_0.round or 1
end

function var_0_0.needPlayShowView(arg_12_0)
	return arg_12_0:getRoundNumber() < 2
end

function var_0_0.getNeedChangeTeamToEliminate(arg_13_0)
	return arg_13_0._needChangeTeamToEliminate
end

function var_0_0.clear(arg_14_0)
	arg_14_0.curRoundType = nil
	arg_14_0._needChangeTeamToEliminate = nil
	arg_14_0.curRoundNumber = 1
	arg_14_0._useSkillCount = 0
	arg_14_0._star = 0
end

function var_0_0.mainCharacterSkillIsUnLock(arg_15_0)
	local var_15_0 = EliminateConfig.instance:getUnLockMainCharacterSkillConst()

	if var_15_0 then
		return (EliminateOutsideModel.instance:hasPassedEpisode(var_15_0))
	end

	return false
end

function var_0_0.sellChessIsUnLock(arg_16_0)
	local var_16_0 = EliminateConfig.instance:getUnLockChessSellConst()

	if var_16_0 then
		return (EliminateOutsideModel.instance:hasPassedEpisode(var_16_0))
	end

	return false
end

function var_0_0.selectSoliderIsUnLock(arg_17_0)
	local var_17_0 = EliminateConfig.instance:getUnLockSelectSoliderConst()
	local var_17_1 = tonumber(var_17_0)

	if var_17_1 then
		return (EliminateOutsideModel.instance:hasPassedEpisode(var_17_1))
	end

	return false
end

function var_0_0.canReleaseSkill(arg_18_0)
	local var_18_0 = EliminateTeamChessModel.instance:getCurTeamMyInfo()

	if var_18_0 == nil then
		return false
	end

	local var_18_1 = EliminateConfig.instance:getTeamChessCharacterConfig(var_18_0.id)
	local var_18_2 = EliminateConfig.instance:getMainCharacterSkillConfig(var_18_1.activeSkillIds)

	if not var_18_2 or string.nilorempty(var_18_2.effect) then
		return false
	end

	return var_18_0.power >= var_18_2.cost
end

function var_0_0.setIsWatchTeamChess(arg_19_0, arg_19_1)
	arg_19_0._isWatchTeamChess = arg_19_1
end

function var_0_0.getIsWatchTeamChess(arg_20_0)
	if arg_20_0._isWatchTeamChess == nil then
		-- block empty
	end

	return arg_20_0._isWatchTeamChess
end

function var_0_0.formatString(arg_21_0, arg_21_1)
	return (arg_21_0:gsub("<(.-):(.-)>", function(arg_22_0, arg_22_1)
		local var_22_0 = arg_21_1 and arg_21_1[arg_22_1] or EliminateTeamChessEnum.PreBattleFormatType[arg_22_1]

		return var_22_0 and string.format(var_22_0, arg_22_0) or arg_22_0
	end))
end

function var_0_0.getAllStrongHoldId(arg_23_0)
	local var_23_0 = {}
	local var_23_1 = EliminateTeamChessModel.instance:getStrongholds()

	for iter_23_0 = 1, #var_23_1 do
		local var_23_2 = var_23_1[iter_23_0]

		table.insert(var_23_0, var_23_2.id)
	end

	return var_23_0
end

function var_0_0.getAllPieceName(arg_24_0)
	local var_24_0 = {}

	for iter_24_0 = 1, #arg_24_0._pieceIds do
		local var_24_1 = EliminateConfig.instance:getSoldierChessConfig(arg_24_0._pieceIds[iter_24_0])

		table.insert(var_24_0, var_24_1.name)
	end

	return var_24_0
end

function var_0_0.setStar(arg_25_0, arg_25_1)
	arg_25_0._star = arg_25_1
end

function var_0_0.getStar(arg_26_0)
	return arg_26_0._star or 0
end

function var_0_0.resourceIdToDict(arg_27_0, arg_27_1)
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in pairs(arg_27_1) do
		local var_27_1 = {
			resources_colour = iter_27_0,
			resources_num = iter_27_1
		}

		table.insert(var_27_0, var_27_1)
	end

	return var_27_0
end

function var_0_0.addMainUseSkillNum(arg_28_0)
	arg_28_0._useSkillCount = (arg_28_0._useSkillCount or 0) + 1
end

function var_0_0.getMainUseSkillNum(arg_29_0)
	return arg_29_0._useSkillCount or 0
end

function var_0_0.sendStatData(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:getAllStrongHoldId()
	local var_30_1 = EliminateConfig.instance:getTeamChessCharacterConfig(arg_30_0._warChessCharacterId)
	local var_30_2 = EliminateConfig.instance:getMainCharacterSkillConfig(var_30_1.activeSkillIds)
	local var_30_3 = arg_30_0:getAllPieceName()
	local var_30_4 = arg_30_0:getStar()
	local var_30_5 = EliminateTeamChessModel.instance:getCurTeamMyInfo()
	local var_30_6 = EliminateTeamChessModel.instance:getCurTeamEnemyInfo()
	local var_30_7 = 0
	local var_30_8 = 0
	local var_30_9 = 0
	local var_30_10 = 0

	if var_30_5 ~= nil then
		var_30_7 = var_30_5.hp
		var_30_10 = var_30_5.hpInjury
	end

	if var_30_6 ~= nil then
		var_30_8 = var_30_6.hp
		var_30_9 = var_30_6.hpInjury
	end

	local var_30_11 = arg_30_0:resourceIdToDict(var_30_5.addDiamonds)
	local var_30_12 = arg_30_0:resourceIdToDict(var_30_5.removeDiamonds)
	local var_30_13 = arg_30_0:resourceIdToDict(var_30_5.diamonds)
	local var_30_14 = arg_30_0:getMainUseSkillNum()

	StatController.instance:track(StatEnum.EventName.TeamchessSettlement, {
		[StatEnum.EventProperties.EpisodeId] = tostring(arg_30_0._levelId),
		[StatEnum.EventProperties.StrongholdId] = var_30_0,
		[StatEnum.EventProperties.MainFighter] = var_30_1.name,
		[StatEnum.EventProperties.MainFighterSkill] = var_30_2.name,
		[StatEnum.EventProperties.InitialChess] = var_30_3,
		[StatEnum.EventProperties.Result] = arg_30_1,
		[StatEnum.EventProperties.Star] = var_30_4,
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - arg_30_0.beginTime,
		[StatEnum.EventProperties.TotalRound] = arg_30_0:getRoundNumber(),
		[StatEnum.EventProperties.OurRemainingHP] = var_30_7,
		[StatEnum.EventProperties.EnemyRemainingHP] = var_30_8,
		[StatEnum.EventProperties.SettlementHarm] = var_30_9,
		[StatEnum.EventProperties.SettlementInjury] = var_30_10,
		[StatEnum.EventProperties.GainResources] = var_30_11,
		[StatEnum.EventProperties.ConsumeResources] = var_30_12,
		[StatEnum.EventProperties.ResidueResources] = var_30_13,
		[StatEnum.EventProperties.MainFighterSkillNum] = var_30_14
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
