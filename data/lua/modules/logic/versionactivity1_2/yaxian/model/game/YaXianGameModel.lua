module("modules.logic.versionactivity1_2.yaxian.model.game.YaXianGameModel", package.seeall)

local var_0_0 = class("YaXianGameModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.release(arg_3_0)
	arg_3_0.actId = nil
	arg_3_0.mapId = nil
	arg_3_0.episodeId = nil
	arg_3_0.episodeCo = nil
	arg_3_0.width = nil
	arg_3_0.height = nil
	arg_3_0.round = nil
	arg_3_0.result = nil
	arg_3_0.mapTileBaseList = nil
	arg_3_0.mapInteractMoList = nil
	arg_3_0.playerInteractMo = nil
	arg_3_0.finishInteract = nil
	arg_3_0.baffleList = nil
	arg_3_0.skillDict = nil
	arg_3_0.mapOffsetX = nil
	arg_3_0.mapOffsetY = nil
	arg_3_0.canWalkTargetPosDict = nil
	arg_3_0.gameLoadOne = nil
	arg_3_0.currentDeleteInteractId = nil
end

function var_0_0.initLocalConfig(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.episodeCo = YaXianConfig.instance:getEpisodeConfig(arg_4_1, arg_4_2)
	arg_4_0.episodeId = arg_4_2
	arg_4_0.actId = arg_4_1
	arg_4_0.mapId = arg_4_0.episodeCo.mapId
	arg_4_0.mapCo = YaXianConfig.instance:getMapConfig(arg_4_1, arg_4_0.mapId)
	arg_4_0.width = arg_4_0.mapCo.width
	arg_4_0.height = arg_4_0.mapCo.height

	if arg_4_0.mapCo and not string.nilorempty(arg_4_0.mapCo.offset) then
		local var_4_0 = string.splitToNumber(arg_4_0.mapCo.offset, ",")

		arg_4_0.mapOffsetX = var_4_0[1]
		arg_4_0.mapOffsetY = var_4_0[2]
	else
		arg_4_0.mapOffsetX = YaXianGameEnum.ChessBoardOffsetX
		arg_4_0.mapOffsetY = YaXianGameEnum.ChessBoardOffsetY
	end

	arg_4_0.mapTileBaseList = string.splitToNumber(arg_4_0.mapCo.tilebase, ",")

	arg_4_0:initBaffleData()
end

function var_0_0.initBaffleData(arg_5_0)
	arg_5_0.baffleList = {}

	local var_5_0
	local var_5_1

	for iter_5_0 = 0, arg_5_0.width - 1 do
		for iter_5_1 = 0, arg_5_0.height - 1 do
			local var_5_2 = arg_5_0.mapTileBaseList[arg_5_0:getIndex(iter_5_0, iter_5_1)]

			if var_5_2 > 1 then
				if YaXianGameHelper.hasBaffle(var_5_2, YaXianGameEnum.BaffleDirectionPowerPos.Left) then
					local var_5_3 = YaXianGameHelper.getBaffleType(var_5_2, YaXianGameEnum.BaffleDirectionPowerPos.Left)

					table.insert(arg_5_0.baffleList, arg_5_0:buildBaffleData(iter_5_0, iter_5_1, YaXianGameEnum.BaffleDirection.Left, var_5_3))
				end

				if YaXianGameHelper.hasBaffle(var_5_2, YaXianGameEnum.BaffleDirectionPowerPos.Right) then
					local var_5_4 = YaXianGameHelper.getBaffleType(var_5_2, YaXianGameEnum.BaffleDirectionPowerPos.Right)

					table.insert(arg_5_0.baffleList, arg_5_0:buildBaffleData(iter_5_0, iter_5_1, YaXianGameEnum.BaffleDirection.Right, var_5_4))
				end

				if YaXianGameHelper.hasBaffle(var_5_2, YaXianGameEnum.BaffleDirectionPowerPos.Top) then
					local var_5_5 = YaXianGameHelper.getBaffleType(var_5_2, YaXianGameEnum.BaffleDirectionPowerPos.Top)

					table.insert(arg_5_0.baffleList, arg_5_0:buildBaffleData(iter_5_0, iter_5_1, YaXianGameEnum.BaffleDirection.Top, var_5_5))
				end

				if YaXianGameHelper.hasBaffle(var_5_2, YaXianGameEnum.BaffleDirectionPowerPos.Bottom) then
					local var_5_6 = YaXianGameHelper.getBaffleType(var_5_2, YaXianGameEnum.BaffleDirectionPowerPos.Bottom)

					table.insert(arg_5_0.baffleList, arg_5_0:buildBaffleData(iter_5_0, iter_5_1, YaXianGameEnum.BaffleDirection.Bottom, var_5_6))
				end
			end
		end
	end
end

function var_0_0.initServerDataByServerData(arg_6_0, arg_6_1)
	arg_6_0:setRound(arg_6_1.currentRound)
	arg_6_0:initObjects(arg_6_1.interactObjects)
	arg_6_0:updateFinishInteracts(arg_6_1.finishInteracts)
end

function var_0_0.initServerDataByMapMo(arg_7_0, arg_7_1)
	arg_7_0:setRound(arg_7_1.currentRound)
	arg_7_0:setObjects(arg_7_1.interactObjs)
	arg_7_0:updateFinishInteracts(arg_7_1.finishInteracts)
end

function var_0_0.getBaffleList(arg_8_0)
	return arg_8_0.baffleList
end

function var_0_0.addInteractMo(arg_9_0, arg_9_1)
	table.insert(arg_9_0.mapInteractMoList, arg_9_1)
end

function var_0_0.removeInteractMo(arg_10_0, arg_10_1)
	tabletool.removeValue(arg_10_0.mapInteractMoList, arg_10_1)
end

function var_0_0.getPlayerInteractMo(arg_11_0)
	return arg_11_0.playerInteractMo
end

function var_0_0.setPlayerInteractMo(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.mapInteractMoList) do
		if iter_12_1.config.interactType == YaXianGameEnum.InteractType.Player then
			arg_12_0.playerInteractMo = iter_12_1

			return
		end
	end

	logError("not found Player InteractMo")
end

function var_0_0.getExitInteractMo(arg_13_0)
	return arg_13_0.exitInteractMo
end

function var_0_0.setExitInteractMo(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.mapInteractMoList) do
		if iter_14_1.config.interactType == YaXianGameEnum.InteractType.TriggerVictory then
			arg_14_0.exitInteractMo = iter_14_1

			return
		end
	end

	logError("not found Exit InteractMo")
end

function var_0_0.initObjects(arg_15_0, arg_15_1)
	arg_15_0.mapInteractMoList = {}

	local var_15_0 = #arg_15_1

	for iter_15_0 = 1, var_15_0 do
		local var_15_1 = arg_15_1[iter_15_0]
		local var_15_2 = YaXianGameInteractMO.New()

		var_15_2:init(arg_15_0.actId, var_15_1)
		table.insert(arg_15_0.mapInteractMoList, var_15_2)
	end

	arg_15_0:setPlayerInteractMo()
	arg_15_0:setExitInteractMo()
	arg_15_0:initInteractData()
end

function var_0_0.setObjects(arg_16_0, arg_16_1)
	arg_16_0.mapInteractMoList = arg_16_1

	arg_16_0:setPlayerInteractMo()
	arg_16_0:setExitInteractMo()
	arg_16_0:initInteractData()
end

function var_0_0.addObject(arg_17_0, arg_17_1)
	local var_17_0 = YaXianGameInteractMO.New()

	var_17_0:init(arg_17_0.actId, arg_17_1)
	table.insert(arg_17_0.mapInteractMoList, var_17_0)

	return var_17_0
end

function var_0_0.removeObjectById(arg_18_0, arg_18_1)
	for iter_18_0 = 1, #arg_18_0.mapInteractMoList do
		if arg_18_0.mapInteractMoList[iter_18_0].id == arg_18_1 then
			local var_18_0 = arg_18_0.mapInteractMoList[iter_18_0]

			table.remove(arg_18_0.mapInteractMoList, iter_18_0)

			return var_18_0
		end
	end
end

function var_0_0.initInteractData(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.mapInteractMoList) do
		if iter_19_1.config.interactType == YaXianGameEnum.InteractType.Player then
			if arg_19_0:updateSkillInfoAndCheckHasChange(iter_19_1.data and iter_19_1.data.skills) then
				YaXianGameController.instance:dispatchEvent(YaXianEvent.OnUpdateSkillInfo)
			end

			if arg_19_0:updateEffectsAndCheckHasChange(iter_19_1.data and iter_19_1.data.effects) then
				YaXianGameController.instance:dispatchEvent(YaXianEvent.OnUpdateEffectInfo)
			end
		end
	end
end

function var_0_0.updateFinishInteracts(arg_20_0, arg_20_1)
	arg_20_0.finishInteract = {}

	if arg_20_1 then
		for iter_20_0 = 1, #arg_20_1 do
			arg_20_0.finishInteract[arg_20_1[iter_20_0]] = true
		end
	end
end

function var_0_0.setFinishInteracts(arg_21_0, arg_21_1)
	arg_21_0.finishInteract = arg_21_1
end

function var_0_0.isAlertArea(arg_22_0, arg_22_1, arg_22_2)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0.mapInteractMoList) do
		if iter_22_1.alertPosList then
			for iter_22_2, iter_22_3 in ipairs(iter_22_1.alertPosList) do
				if arg_22_1 == iter_22_3.posX and arg_22_2 == iter_22_3.posY then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.hasInteract(arg_23_0, arg_23_1, arg_23_2)
	for iter_23_0, iter_23_1 in ipairs(arg_23_0.mapInteractMoList) do
		if arg_23_1 == iter_23_1.posX and arg_23_2 == iter_23_1.posY and iter_23_1.config.interactType ~= YaXianGameEnum.InteractType.Player then
			return true
		end
	end

	return false
end

function var_0_0.updateSkillInfo(arg_24_0, arg_24_1)
	if not arg_24_1 then
		arg_24_0.skillDict = nil

		return
	end

	arg_24_0.skillDict = arg_24_0.skillDict or {}

	for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
		local var_24_0 = arg_24_0.skillDict[iter_24_1.skillId]

		if not var_24_0 then
			var_24_0 = YaXianGameSkillMo.New()

			var_24_0:init(arg_24_0.actId, iter_24_1)

			arg_24_0.skillDict[iter_24_1.skillId] = var_24_0
		else
			var_24_0:updateMO(iter_24_1)
		end
	end
end

function var_0_0.updateSkillInfoAndCheckHasChange(arg_25_0, arg_25_1)
	if not arg_25_1 then
		if not arg_25_0.skillDict then
			return false
		else
			arg_25_0:updateSkillInfo(arg_25_1)

			return true
		end
	end

	arg_25_0.skillDict = arg_25_0.skillDict or {}

	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		local var_25_0 = arg_25_0.skillDict[iter_25_1.skillId]

		if not var_25_0 then
			arg_25_0:updateSkillInfo(arg_25_1)

			return true
		elseif var_25_0.canUseCount ~= iter_25_1.canUseCount then
			arg_25_0:updateSkillInfo(arg_25_1)

			return true
		end
	end

	return false
end

function var_0_0.getSkillMo(arg_26_0, arg_26_1)
	return arg_26_0.skillDict and arg_26_0.skillDict[arg_26_1]
end

function var_0_0.hasSkill(arg_27_0)
	return arg_27_0.skillDict ~= nil
end

function var_0_0.updateEffects(arg_28_0, arg_28_1)
	if not arg_28_1 then
		arg_28_0._effectsDict = nil

		return
	end

	arg_28_0.effectsPool = arg_28_0.effectsPool or {}

	if arg_28_0._effectsDict then
		for iter_28_0, iter_28_1 in pairs(arg_28_0._effectsDict) do
			arg_28_0.effectsPool[iter_28_0] = iter_28_1
		end
	end

	arg_28_0._effectsDict = {}

	for iter_28_2, iter_28_3 in ipairs(arg_28_1) do
		local var_28_0 = arg_28_0.effectsPool[iter_28_3.effectType]

		if not var_28_0 then
			var_28_0 = YaXianGameSkillEffectMo.New()

			var_28_0:init(arg_28_0.actId, iter_28_3)
		else
			var_28_0:updateMO(iter_28_3)
		end

		arg_28_0._effectsDict[var_28_0.effectType] = var_28_0
	end
end

function var_0_0.updateEffectsAndCheckHasChange(arg_29_0, arg_29_1)
	if not arg_29_1 and not arg_29_0._effectsDict then
		arg_29_0._effectsDict = nil

		return false
	end

	if not arg_29_1 then
		arg_29_0._effectsDict = nil

		return true
	end

	if not arg_29_0._effectsDict then
		arg_29_0:updateEffects(arg_29_1)

		return true
	end

	if #arg_29_1 ~= tabletool.len(arg_29_0._effectsDict) then
		arg_29_0:updateEffects(arg_29_1)

		return true
	end

	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		local var_29_0 = arg_29_0._effectsDict[iter_29_1.effectType]

		if not var_29_0 then
			arg_29_0:updateEffects(arg_29_1)

			return true
		elseif var_29_0.remainRound ~= arg_29_1.remainRound then
			arg_29_0:updateEffects(arg_29_1)

			return true
		end
	end
end

function var_0_0.getEffectByType(arg_30_0, arg_30_1)
	return arg_30_0._effectsDict and arg_30_0._effectsDict[arg_30_1]
end

function var_0_0.isShowVisibleStatus(arg_31_0)
	return arg_31_0._effectsDict and arg_31_0._effectsDict[YaXianGameEnum.SkillType.InVisible] and arg_31_0._effectsDict[YaXianGameEnum.SkillType.InVisible].remainRound > 0
end

function var_0_0.isShowThroughStatus(arg_32_0)
	return arg_32_0._effectsDict and arg_32_0._effectsDict[YaXianGameEnum.SkillType.ThroughWall] and arg_32_0._effectsDict[YaXianGameEnum.SkillType.ThroughWall].remainRound > 0
end

function var_0_0.hasInVisibleEffect(arg_33_0)
	return arg_33_0._effectsDict and arg_33_0._effectsDict[YaXianGameEnum.SkillType.InVisible] and arg_33_0._effectsDict[YaXianGameEnum.SkillType.InVisible].remainRound > 1
end

function var_0_0.hasThroughWallEffect(arg_34_0)
	return arg_34_0._effectsDict and arg_34_0._effectsDict[YaXianGameEnum.SkillType.ThroughWall] and arg_34_0._effectsDict[YaXianGameEnum.SkillType.ThroughWall].remainRound > 0
end

function var_0_0.addFinishInteract(arg_35_0, arg_35_1)
	arg_35_0.finishInteract[arg_35_1] = true
end

function var_0_0.isInteractFinish(arg_36_0, arg_36_1)
	if arg_36_0.finishInteract then
		return arg_36_0.finishInteract[arg_36_1]
	end
end

function var_0_0.getBaseTile(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_0:getIndex(arg_37_1, arg_37_2)

	return arg_37_0.mapTileBaseList[var_37_0]
end

function var_0_0.setBaseTile(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = arg_38_0:getIndex(arg_38_1, arg_38_2)

	arg_38_0.mapTileBaseList[var_38_0] = arg_38_3
end

function var_0_0.setRound(arg_39_0, arg_39_1)
	arg_39_0.round = arg_39_1
end

function var_0_0.setResult(arg_40_0, arg_40_1)
	arg_40_0.result = arg_40_1
end

function var_0_0.getResult(arg_41_0)
	return arg_41_0.result
end

function var_0_0.getInteractMoList(arg_42_0)
	return arg_42_0.mapInteractMoList
end

function var_0_0.getInteractMo(arg_43_0, arg_43_1)
	for iter_43_0, iter_43_1 in ipairs(arg_43_0.mapInteractMoList) do
		if iter_43_1.id == arg_43_1 then
			return iter_43_1
		end
	end
end

function var_0_0.getIndex(arg_44_0, arg_44_1, arg_44_2)
	return arg_44_2 * arg_44_0.width + arg_44_1 + 1
end

function var_0_0.getGameSize(arg_45_0)
	return arg_45_0.width, arg_45_0.height
end

function var_0_0.getMapId(arg_46_0)
	return arg_46_0.mapId
end

function var_0_0.getActId(arg_47_0)
	return arg_47_0.actId
end

function var_0_0.getRound(arg_48_0)
	return math.max(arg_48_0.round or 1, 1)
end

function var_0_0.isRoundUseUp(arg_49_0)
	return arg_49_0:getRound() == arg_49_0.episodeCo.maxRound
end

function var_0_0.getEpisodeId(arg_50_0)
	return arg_50_0.episodeId
end

function var_0_0.getEpisodeCo(arg_51_0)
	return arg_51_0.episodeCo
end

function var_0_0.isPosInChessBoard(arg_52_0, arg_52_1, arg_52_2)
	return arg_52_1 >= 0 and arg_52_1 < arg_52_0.width and arg_52_2 >= 0 and arg_52_2 < arg_52_0.height
end

function var_0_0.buildBaffleData(arg_53_0, arg_53_1, arg_53_2, arg_53_3, arg_53_4)
	return {
		x = arg_53_1,
		y = arg_53_2,
		direction = arg_53_3,
		type = arg_53_4
	}
end

function var_0_0.setCanWalkTargetPosDict(arg_54_0, arg_54_1)
	arg_54_0.canWalkDirection2Pos = arg_54_1
	arg_54_0.canWalkPos2Direction = {}

	for iter_54_0, iter_54_1 in pairs(arg_54_0.canWalkDirection2Pos) do
		arg_54_0.canWalkPos2Direction[YaXianGameHelper.getPosHashKey(iter_54_1.x, iter_54_1.y)] = iter_54_0
	end
end

function var_0_0.getCanWalkTargetPosDict(arg_55_0)
	return arg_55_0.canWalkDirection2Pos
end

function var_0_0.getCanWalkPos2Direction(arg_56_0)
	return arg_56_0.canWalkPos2Direction
end

function var_0_0.setGameLoadDone(arg_57_0, arg_57_1)
	arg_57_0.gameLoadOne = arg_57_1
end

function var_0_0.gameIsLoadDone(arg_58_0)
	return arg_58_0.gameLoadOne
end

function var_0_0.setNeedFeatureInteractMo(arg_59_0, arg_59_1)
	arg_59_0.needFeatureInteractMo = arg_59_1
	arg_59_0.featurePrePosX = arg_59_0.needFeatureInteractMo.prePosX
	arg_59_0.featurePrePosY = arg_59_0.needFeatureInteractMo.prePosY
	arg_59_0.featurePreDirection = arg_59_0.needFeatureInteractMo.preDirection
end

function var_0_0.clearFeatureInteract(arg_60_0)
	arg_60_0.needFeatureInteractMo = nil
	arg_60_0.featurePrePosX = nil
	arg_60_0.featurePrePosY = nil
	arg_60_0.featurePreDirection = nil
end

function var_0_0.getNeedFeatureInteractMo(arg_61_0)
	return arg_61_0.needFeatureInteractMo
end

function var_0_0.checkFinishCondition(arg_62_0, arg_62_1, arg_62_2)
	if arg_62_1 == YaXianGameEnum.ConditionType.PassEpisode then
		return arg_62_0.result
	elseif arg_62_1 == YaXianGameEnum.ConditionType.Round then
		return arg_62_0.result and arg_62_2 >= arg_62_0.round
	elseif arg_62_1 == YaXianGameEnum.ConditionType.FinishInteract then
		return arg_62_0:isInteractFinish(arg_62_2)
	elseif arg_62_1 == YaXianGameEnum.ConditionType.FinishAllInteract then
		if arg_62_2 > 0 and arg_62_2 < arg_62_0.round then
			return false
		end

		local var_62_0 = 0

		if arg_62_0.finishInteract then
			for iter_62_0, iter_62_1 in pairs(arg_62_0.finishInteract) do
				if YaXianConfig.instance:checkInteractCanFinish(YaXianConfig.instance:getInteractObjectCo(arg_62_0.actId, iter_62_0)) then
					var_62_0 = var_62_0 + 1
				end
			end
		end

		return var_62_0 == YaXianConfig.instance:getEpisodeCanFinishInteractCount(arg_62_0.episodeCo)
	else
		logError("un support condition type")

		return false
	end
end

function var_0_0.getFinishConditionCount(arg_63_0)
	local var_63_0 = YaXianConfig.instance:getConditionList(arg_63_0.episodeCo)
	local var_63_1 = 0

	for iter_63_0, iter_63_1 in ipairs(var_63_0) do
		if arg_63_0:checkFinishCondition(iter_63_1[1], iter_63_1[2]) then
			var_63_1 = var_63_1 + 1
		end
	end

	return var_63_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
