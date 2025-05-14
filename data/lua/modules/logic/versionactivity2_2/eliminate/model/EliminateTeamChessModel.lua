module("modules.logic.versionactivity2_2.eliminate.model.EliminateTeamChessModel", package.seeall)

local var_0_0 = class("EliminateTeamChessModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.curTeamChessWar = nil
	arg_1_0.serverTeamChessWar = nil
	arg_1_0.warFightResult = nil
	arg_1_0.teamChessStepList = {}
	arg_1_0._curTeamRoundStepState = EliminateTeamChessEnum.TeamChessRoundType.enemy
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.curTeamChessWar = nil
	arg_2_0.serverTeamChessWar = nil
	arg_2_0.warFightResult = nil
	arg_2_0._teamChessSkillState = nil
	arg_2_0.teamChessStepList = {}
end

function var_0_0.initTeamChess(arg_3_0, arg_3_1)
	arg_3_0._warChessId = arg_3_1
end

function var_0_0.getCurWarChessEpisodeConfig(arg_4_0)
	return EliminateConfig.instance:getWarChessEpisodeConfig(arg_4_0._warChessId)
end

function var_0_0.handleCurTeamChessWarFightInfo(arg_5_0, arg_5_1)
	if arg_5_0.curTeamChessWar == nil then
		arg_5_0.curTeamChessWar = EliminateTeamChessWarMO.New()

		arg_5_0.curTeamChessWar:init(arg_5_1)
	end

	arg_5_0.curTeamChessWar:updateInfo(arg_5_1)
end

function var_0_0.handleServerTeamChessWarFightInfo(arg_6_0, arg_6_1)
	if arg_6_0.serverTeamChessWar == nil then
		arg_6_0.serverTeamChessWar = EliminateTeamChessWarMO.New()

		arg_6_0.serverTeamChessWar:init(arg_6_1)
	end

	arg_6_0.serverTeamChessWar:updateInfo(arg_6_1)
end

function var_0_0.handleTeamFightResult(arg_7_0, arg_7_1)
	if not arg_7_0.warFightResult then
		arg_7_0.warFightResult = WarChessFightResultMO.New()
	end

	arg_7_0.warFightResult:updateInfo(arg_7_1)
end

function var_0_0.handleTeamFightTurn(arg_8_0, arg_8_1)
	if arg_8_1 == nil or arg_8_1.step == nil then
		return
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_1.step) do
		local var_8_0 = WarChessStepMO.New()

		var_8_0:init(iter_8_1)

		arg_8_0.teamChessStepList[#arg_8_0.teamChessStepList + 1] = var_8_0
	end
end

function var_0_0.getTeamChessStepList(arg_9_0)
	return arg_9_0.teamChessStepList
end

function var_0_0.getCurTeamChessWar(arg_10_0)
	return arg_10_0.curTeamChessWar
end

function var_0_0.getServerTeamChessWar(arg_11_0)
	return arg_11_0.serverTeamChessWar
end

function var_0_0.getSlotIds(arg_12_0)
	return arg_12_0.curTeamChessWar and arg_12_0.curTeamChessWar:getSlotIds() or {}
end

function var_0_0.getStrongholds(arg_13_0)
	return arg_13_0.curTeamChessWar and arg_13_0.curTeamChessWar:getStrongholds() or {}
end

function var_0_0.getStronghold(arg_14_0, arg_14_1)
	return arg_14_0.curTeamChessWar and arg_14_0.curTeamChessWar:getStronghold(arg_14_1) or nil
end

function var_0_0.getCurTeamMyInfo(arg_15_0)
	return arg_15_0.curTeamChessWar and arg_15_0.curTeamChessWar.myCharacter or nil
end

function var_0_0.getCurTeamEnemyInfo(arg_16_0)
	return arg_16_0.curTeamChessWar and arg_16_0.curTeamChessWar.enemyCharacter or nil
end

function var_0_0.getEnemyForecastChess(arg_17_0)
	local var_17_0 = var_0_0.instance:getCurTeamEnemyInfo()

	if var_17_0 then
		local var_17_1 = var_17_0.forecastBehavior

		if #var_17_1 ~= 0 then
			return var_17_1
		end
	end

	return nil
end

function var_0_0.getAllPlayerSoliderCount(arg_18_0)
	local var_18_0 = arg_18_0:getStrongholds()
	local var_18_1 = 0

	for iter_18_0, iter_18_1 in pairs(var_18_0) do
		var_18_1 = var_18_1 + iter_18_1:getPlayerSoliderCount()
	end

	return var_18_1
end

function var_0_0.getCurTeamResource(arg_19_0)
	local var_19_0 = arg_19_0:getCurTeamMyInfo()

	return var_19_0 and var_19_0.diamonds or {}
end

function var_0_0.getResourceNumber(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:getCurTeamMyInfo()

	return var_20_0 and var_20_0.diamonds and var_20_0.diamonds[arg_20_1] or 0
end

function var_0_0.getWarFightResult(arg_21_0)
	return arg_21_0.warFightResult
end

function var_0_0.updateChessPower(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0.curTeamChessWar then
		arg_22_0.curTeamChessWar:updateChessPower(arg_22_1, arg_22_2)
	end
end

function var_0_0.updateDisplacementState(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0.curTeamChessWar then
		arg_23_0.curTeamChessWar:updateDisplacementState(arg_23_1, arg_23_2)
	end
end

function var_0_0.updateStrongholdsScore(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_0.curTeamChessWar then
		arg_24_0.curTeamChessWar:updateStrongholdsScore(arg_24_1, arg_24_2, arg_24_3)
	end
end

function var_0_0.updateMainCharacterHp(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_0.curTeamChessWar then
		arg_25_0.curTeamChessWar:updateMainCharacterHp(arg_25_1, arg_25_2)
	end
end

function var_0_0.updateMainCharacterPower(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_0.curTeamChessWar then
		arg_26_0.curTeamChessWar:updateMainCharacterPower(arg_26_1, arg_26_2)
	end
end

function var_0_0.updateResourceData(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_0.curTeamChessWar then
		arg_27_0.curTeamChessWar:updateResourceData(arg_27_1, arg_27_2)
	end
end

function var_0_0.removeStrongholdChess(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_0.curTeamChessWar then
		arg_28_0.curTeamChessWar:removeStrongholdChess(arg_28_1, arg_28_2)
	end
end

function var_0_0.getChess(arg_29_0, arg_29_1)
	if arg_29_0.curTeamChessWar then
		return arg_29_0.curTeamChessWar:getChess(arg_29_1)
	end

	return nil
end

function var_0_0.strongHoldSettle(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_0.curTeamChessWar then
		arg_30_0.curTeamChessWar:strongHoldSettle(arg_30_1, arg_30_2)
	end
end

function var_0_0.updateSkillGrowUp(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if arg_31_0.curTeamChessWar then
		arg_31_0.curTeamChessWar:updateSkillGrowUp(arg_31_1, arg_31_2, arg_31_3)
	end
end

function var_0_0.diamondsIsEnough(arg_32_0, arg_32_1, arg_32_2)
	if not arg_32_0.curTeamChessWar then
		return false
	end

	return arg_32_0.curTeamChessWar:diamondsIsEnough(arg_32_1, arg_32_2)
end

function var_0_0.getViewCanvas(arg_33_0)
	return arg_33_0._canvas
end

function var_0_0.setViewCanvas(arg_34_0, arg_34_1)
	arg_34_0._canvas = arg_34_1
end

function var_0_0.getTipViewParent(arg_35_0)
	return arg_35_0._tipViewParent
end

function var_0_0.setTipViewParent(arg_36_0, arg_36_1)
	arg_36_0._tipViewParent = arg_36_1
end

function var_0_0.setCurTeamRoundStepState(arg_37_0, arg_37_1)
	arg_37_0._curTeamRoundStepState = arg_37_1
end

function var_0_0.getCurTeamRoundStepState(arg_38_0)
	return arg_38_0._curTeamRoundStepState
end

function var_0_0.clear(arg_39_0)
	arg_39_0._canvas = nil
	arg_39_0._tipViewParent = nil
	arg_39_0.curTeamChessWar = nil
	arg_39_0.serverTeamChessWar = nil
	arg_39_0.warFightResult = nil
	arg_39_0.teamChessStepList = {}

	if arg_39_0._cacheRuleLimit ~= nil then
		arg_39_0._cacheRuleLimit = nil
	end

	arg_39_0._curTeamRoundStepState = EliminateTeamChessEnum.TeamChessRoundType.enemy
end

function var_0_0.getSellResourceData(arg_40_0, arg_40_1)
	local var_40_0 = {}
	local var_40_1 = EliminateConfig.instance:getSellSoliderPermillage()

	for iter_40_0 = 1, #arg_40_1 do
		local var_40_2 = arg_40_1[iter_40_0]
		local var_40_3 = math.floor(var_40_2[2] * var_40_1 / 1000)

		table.insert(var_40_0, {
			var_40_2[1],
			var_40_3
		})
	end

	return var_40_0
end

function var_0_0.canUseChess(arg_41_0, arg_41_1)
	local var_41_0 = EliminateConfig.instance:getSoldierChessConfigConst(arg_41_1)
	local var_41_1 = true

	if var_41_0 then
		for iter_41_0, iter_41_1 in ipairs(var_41_0) do
			local var_41_2 = iter_41_1[1]

			if tonumber(iter_41_1[2]) > arg_41_0:getResourceNumber(var_41_2) then
				var_41_1 = false

				break
			end
		end
	else
		var_41_1 = true
	end

	return var_41_1
end

function var_0_0.getSoliderIdEffectParam(arg_42_0, arg_42_1)
	local var_42_0 = EliminateConfig.instance:getSoldierChessConfig(arg_42_1)
	local var_42_1 = var_42_0 and var_42_0.skillId or ""

	for iter_42_0, iter_42_1 in ipairs(string.splitToNumber(var_42_1, "#")) do
		local var_42_2 = EliminateConfig.instance:getSoldierSkillConfig(iter_42_1)
		local var_42_3 = string.split(var_42_2 and var_42_2.effect or "", "#")
		local var_42_4 = var_42_3[1]

		if EliminateTeamChessEnum.placeSkillEffectParamConfigEnum[var_42_4] then
			local var_42_5 = var_42_3[2]
			local var_42_6 = EliminateTeamChessEnum.placeSkillEffectParamConfigEnum[var_42_4][var_42_5]

			if var_42_6 then
				return var_42_6.teamType, var_42_6.count, var_42_6.limitStrongHold
			end
		end
	end

	return nil, nil, false
end

function var_0_0.createPlaceMo(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	local var_43_0 = SoliderSkillMOBase.New()

	var_43_0:init(arg_43_1, arg_43_2, arg_43_3)

	return var_43_0
end

function var_0_0.haveSoliderByTeamTypeAndStrongholdId(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = arg_44_0:getStrongholds()
	local var_44_1 = false

	for iter_44_0 = 1, #var_44_0 do
		local var_44_2 = var_44_0[iter_44_0]

		if arg_44_2 == nil or arg_44_2 == arg_44_2 then
			if not var_44_1 then
				if arg_44_1 == EliminateTeamChessEnum.TeamChessTeamType.player then
					var_44_1 = #var_44_2.mySidePiece > 0
				end

				if arg_44_1 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
					var_44_1 = #var_44_2.enemySidePiece > 0
				end
			else
				break
			end
		end
	end

	return var_44_1
end

function var_0_0.sourceStrongHoldInRight(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = arg_45_0:getStrongholds()
	local var_45_1 = 0
	local var_45_2 = 0

	for iter_45_0 = 1, #var_45_0 do
		local var_45_3 = var_45_0[iter_45_0]

		if var_45_3.id == arg_45_2 then
			var_45_1 = iter_45_0
		end

		if var_45_3.id == arg_45_1 then
			var_45_2 = iter_45_0
		end
	end

	return var_45_2 < var_45_1
end

function var_0_0.strongHoldIsFull(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0:getStrongholds()

	for iter_46_0 = 1, #var_46_0 do
		local var_46_1 = var_46_0[iter_46_0]

		if arg_46_1 == var_46_1.id then
			return var_46_1:isFull(EliminateTeamChessEnum.TeamChessTeamType.player)
		end
	end

	return false
end

function var_0_0.allStrongHoldIsIsFull(arg_47_0)
	local var_47_0 = false
	local var_47_1 = arg_47_0:getStrongholds()

	for iter_47_0 = 1, #var_47_1 do
		if var_47_1[iter_47_0]:isFull(EliminateTeamChessEnum.TeamChessTeamType.player) then
			var_47_0 = true
		end
	end

	return var_47_0
end

function var_0_0.haveEnoughResource(arg_48_0)
	local var_48_0 = EliminateLevelModel.instance:getCurLevelPieceIds()

	if var_48_0 ~= nil then
		for iter_48_0 = 1, #var_48_0 do
			local var_48_1 = var_48_0[iter_48_0]

			if arg_48_0:canUseChess(var_48_1) then
				return true
			end
		end
	end

	return false
end

function var_0_0.canReleaseSkillAddResource(arg_49_0)
	if not EliminateLevelModel.instance:mainCharacterSkillIsUnLock() then
		return false
	end

	local var_49_0 = var_0_0.instance:getCurTeamMyInfo()
	local var_49_1 = false

	if var_49_0 then
		local var_49_2
		local var_49_3 = EliminateConfig.instance:getTeamChessCharacterConfig(var_49_0.id)
		local var_49_4 = EliminateConfig.instance:getMainCharacterSkillConfig(var_49_3.activeSkillIds)
		local var_49_5 = EliminateLevelController.instance:getTempSkillMo(var_49_4.id, var_49_4.effect)

		var_49_1 = EliminateLevelController.instance:canReleaseByRound(var_49_5) and var_49_0.power >= var_49_4.cost
	end

	return var_49_1
end

function var_0_0.strongHoldTotalScoreWin(arg_50_0)
	local var_50_0 = 0
	local var_50_1 = 0
	local var_50_2 = arg_50_0:getStrongholds()

	for iter_50_0 = 1, #var_50_2 do
		local var_50_3 = var_50_2[iter_50_0]

		var_50_0 = var_50_0 + var_50_3.enemyScore
		var_50_1 = var_50_1 + var_50_3.myScore
	end

	return var_50_0 < var_50_1
end

function var_0_0.calDamageGear(arg_51_0, arg_51_1)
	local var_51_0 = EliminateConfig.instance:getCharacterDamageGear()
	local var_51_1 = 1

	if var_51_0 and #var_51_0 == 2 and arg_51_1 then
		if arg_51_1 < var_51_0[2] then
			var_51_1 = arg_51_1 >= var_51_0[1] and 2 or 1
		else
			var_51_1 = 3
		end
	end

	return var_51_1
end

function var_0_0.isCanPlaceByStrongHoldRule(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = EliminateConfig.instance:getStrongHoldConfig(arg_52_1)
	local var_52_1 = EliminateConfig.instance:getStrongHoldRuleRuleConfig(var_52_0.ruleId)
	local var_52_2 = EliminateLevelModel.instance:getRoundNumber()
	local var_52_3 = var_52_1 and var_52_1.putLimit or 0

	if arg_52_0._cacheRuleLimit == nil then
		arg_52_0._cacheRuleLimit = {}
	end

	local var_52_4 = arg_52_0._cacheRuleLimit[var_52_1.id]

	if var_52_4 == nil then
		arg_52_0._cacheRuleLimit[var_52_1.id] = string.splitToNumber(var_52_3, "#")
		var_52_4 = arg_52_0._cacheRuleLimit[var_52_1.id]
	end

	if var_52_2 >= var_52_1.startEffectRound and var_52_2 <= var_52_1.endEffectRound and tabletool.len(var_52_4) > 0 then
		local var_52_5 = EliminateConfig.instance:getSoldierChessConfig(arg_52_2)

		for iter_52_0 = 1, #var_52_4 do
			local var_52_6 = var_52_4[iter_52_0]

			if tonumber(var_52_6) == var_52_5.level then
				return false
			end
		end
	end

	return true
end

function var_0_0.setTeamChessSkillState(arg_53_0, arg_53_1)
	arg_53_0._teamChessSkillState = arg_53_1
end

function var_0_0.getTeamChessSkillState(arg_54_0)
	if arg_54_0._teamChessSkillState == nil then
		-- block empty
	end

	return arg_54_0._teamChessSkillState
end

function var_0_0.chessSkillIsGrowUp(arg_55_0)
	local var_55_0 = EliminateConfig.instance:getSoliderSkillConfig(arg_55_0)

	return var_55_0 and var_55_0.type == EliminateTeamChessEnum.SoliderSkillType.GrowUp
end

var_0_0.instance = var_0_0.New()

return var_0_0
