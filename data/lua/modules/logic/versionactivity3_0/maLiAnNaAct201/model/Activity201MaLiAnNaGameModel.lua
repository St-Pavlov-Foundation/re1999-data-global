module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.Activity201MaLiAnNaGameModel", package.seeall)

local var_0_0 = class("Activity201MaLiAnNaGameModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._curGameId = nil
	arg_2_0._disPatchId = 1
	arg_2_0._disPatchSlotList = {}
	arg_2_0._allDisPatchSolider = {}
	arg_2_0._gameTime = 0
	arg_2_0._maxGameTime = 0

	MaLiAnNaLaSoliderMoUtil.instance:init()

	arg_2_0._allActiveSkill = {}
end

function var_0_0.initGameData(arg_3_0, arg_3_1)
	arg_3_0:clear()

	arg_3_0._curGameId = arg_3_1
	arg_3_0._gameConfig = Activity201MaLiAnNaConfig.instance:getGameConfigById(arg_3_1)
	arg_3_0._winCondition = Activity201MaLiAnNaConfig.instance:getWinConditionById(arg_3_1)
	arg_3_0._loseCondition = Activity201MaLiAnNaConfig.instance:getLoseConditionById(arg_3_1)

	local var_3_0 = arg_3_0._gameConfig.battleGroup

	arg_3_0._gameMo = MaLiAnNaGameMo.create(var_3_0)

	local var_3_1 = Activity201MaLiAnNaConfig.instance:getMaLiAnNaLevelDataByLevelId(var_3_0)

	arg_3_0._gameMo:init(var_3_1)

	arg_3_0._gameTime = 0
	arg_3_0._maxGameTime = arg_3_0._gameConfig.battleTime or 0
	arg_3_0._dispatchHeroFirst = false

	arg_3_0:_initActiveSkill()
end

function var_0_0.getCurGameId(arg_4_0)
	return arg_4_0._curGameId
end

function var_0_0.update(arg_5_0, arg_5_1)
	arg_5_0._gameTime = arg_5_0._gameTime + arg_5_1

	if arg_5_0._gameMo ~= nil then
		arg_5_0._gameMo:update(arg_5_1)
	end

	if arg_5_0._allDisPatchSolider ~= nil then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._allDisPatchSolider) do
			if iter_5_1 then
				iter_5_1:update(arg_5_1)

				if isDebugBuild then
					-- block empty
				end
			end
		end
	end

	arg_5_0:updateAllActive(arg_5_1)
end

function var_0_0.getGameMo(arg_6_0)
	return arg_6_0._gameMo
end

function var_0_0.getDispatchHeroFirst(arg_7_0)
	return arg_7_0._dispatchHeroFirst
end

function var_0_0.setDispatchHeroFirst(arg_8_0, arg_8_1)
	arg_8_0._dispatchHeroFirst = arg_8_1
end

function var_0_0.getCurGameConfig(arg_9_0)
	return arg_9_0._gameConfig
end

function var_0_0.getAllSlot(arg_10_0)
	if arg_10_0._gameMo == nil then
		return nil
	end

	return arg_10_0._gameMo:getAllSlot()
end

function var_0_0.allDisPatchSolider(arg_11_0)
	return arg_11_0._allDisPatchSolider
end

function var_0_0.getSlotById(arg_12_0, arg_12_1)
	if arg_12_0._gameMo == nil then
		return nil
	end

	return arg_12_0._gameMo:getSlotById(arg_12_1)
end

function var_0_0.getSlotByConfigId(arg_13_0, arg_13_1)
	if arg_13_0._gameMo == nil then
		return nil
	end

	return arg_13_0._gameMo:getSlotByConfigId(arg_13_1)
end

function var_0_0.getAllRoad(arg_14_0)
	if arg_14_0._gameMo == nil then
		return nil
	end

	return arg_14_0._gameMo.roads
end

function var_0_0.getRoadGraph(arg_15_0)
	if arg_15_0._gameMo == nil then
		return nil
	end

	return arg_15_0._gameMo:getRoadGraph()
end

function var_0_0.addDisPatchSolider(arg_16_0, arg_16_1)
	if arg_16_0._allDisPatchSolider == nil then
		arg_16_0._allDisPatchSolider = {}
	end

	if arg_16_1 then
		arg_16_0._allDisPatchSolider[arg_16_1:getId()] = arg_16_1
	end
end

function var_0_0.isInAttackState(arg_17_0, arg_17_1)
	if arg_17_0._allDisPatchSolider == nil then
		return false
	end

	for iter_17_0, iter_17_1 in pairs(arg_17_0._allDisPatchSolider) do
		if iter_17_1 and iter_17_1:getCurState() == Activity201MaLiAnNaEnum.SoliderState.Moving and iter_17_1:getTargetSlotId() == arg_17_1:getId() then
			return true
		end
	end

	return false
end

function var_0_0.soliderDead(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getAllSlot()

	if var_18_0 then
		for iter_18_0, iter_18_1 in pairs(var_18_0) do
			if iter_18_1:soliderDead(arg_18_1) then
				return
			end
		end
	end
end

function var_0_0.removeDisPatchSolider(arg_19_0, arg_19_1)
	if arg_19_1 == nil or arg_19_0._allDisPatchSolider == nil then
		return false
	end

	if arg_19_0._allDisPatchSolider[arg_19_1] then
		arg_19_0._allDisPatchSolider[arg_19_1] = nil

		return true
	end

	return false
end

function var_0_0.getShowTime(arg_20_0)
	return math.max(0, math.floor(arg_20_0._maxGameTime - arg_20_0._gameTime))
end

function var_0_0.getGameTime(arg_21_0)
	return arg_21_0._gameTime
end

function var_0_0.isLoseByTime(arg_22_0)
	return arg_22_0._gameTime >= arg_22_0._maxGameTime
end

function var_0_0.isLoseByTarget(arg_23_0)
	if arg_23_0._loseCondition == nil then
		return false
	end

	local var_23_0 = false
	local var_23_1

	for iter_23_0 = 1, #arg_23_0._loseCondition do
		local var_23_2 = arg_23_0._loseCondition[iter_23_0]

		if arg_23_0:checkCondition(var_23_2) then
			var_23_0 = true
			var_23_1 = var_23_2

			break
		end
	end

	return var_23_0, var_23_1
end

function var_0_0.isWin(arg_24_0)
	if arg_24_0._winCondition == nil then
		return false
	end

	local var_24_0 = true

	for iter_24_0 = 1, #arg_24_0._winCondition do
		local var_24_1 = arg_24_0._winCondition[iter_24_0]

		if not arg_24_0:checkCondition(var_24_1) then
			var_24_0 = false

			break
		end
	end

	return var_24_0
end

function var_0_0.gameIsOver(arg_25_0)
	local var_25_0 = arg_25_0:isWin()
	local var_25_1 = arg_25_0:isLoseByTime() or arg_25_0:isLoseByTarget()

	return var_25_0 or var_25_1, var_25_0, var_25_1
end

function var_0_0.canDisPatch(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_1 == nil and arg_26_2 == nil then
		return false
	end

	if arg_26_2 == nil then
		return true
	end

	local var_26_0 = arg_26_0:getSlotById(arg_26_1)
	local var_26_1 = arg_26_0:getSlotById(arg_26_2)

	if var_26_0 and var_26_1 then
		return (arg_26_0._gameMo:haveRoad(arg_26_1, arg_26_2))
	end

	return false
end

function var_0_0.checkPosAndDisPatch(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0
	local var_27_1 = arg_27_0:getAllSlot()

	for iter_27_0, iter_27_1 in pairs(var_27_1) do
		if iter_27_1 and iter_27_1:isInCanSelectRange(arg_27_1, arg_27_2) then
			var_27_0 = iter_27_1:getId()

			break
		end
	end

	if var_27_0 ~= nil then
		arg_27_0:_addDisPatch(var_27_0)
	end
end

function var_0_0.inSlotCanSelectRange(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0
	local var_28_1 = arg_28_0:getAllSlot()

	for iter_28_0, iter_28_1 in pairs(var_28_1) do
		if iter_28_1 and iter_28_1:isInCanSelectRange(arg_28_1, arg_28_2) then
			var_28_0 = iter_28_1:getId()

			break
		end
	end

	return var_28_0 ~= nil, var_28_0
end

function var_0_0._addDisPatch(arg_29_0, arg_29_1)
	if arg_29_0._disPatchSlotList == nil then
		arg_29_0._disPatchSlotList = {}
	end

	local var_29_0 = #arg_29_0._disPatchSlotList
	local var_29_1 = var_29_0 == 0 and arg_29_1 or arg_29_0._disPatchSlotList[#arg_29_0._disPatchSlotList]
	local var_29_2 = var_29_0 > 0 and arg_29_1 or nil
	local var_29_3 = true

	for iter_29_0 = 1, var_29_0 do
		if arg_29_0._disPatchSlotList[iter_29_0] == arg_29_1 then
			var_29_3 = false
		end
	end

	if var_29_3 and arg_29_0:canDisPatch(var_29_1, var_29_2) then
		table.insert(arg_29_0._disPatchSlotList, arg_29_1)

		return true
	end

	return false
end

function var_0_0.disPatch(arg_30_0, arg_30_1)
	if arg_30_0._disPatchSlotList == nil or #arg_30_0._disPatchSlotList <= 1 then
		arg_30_0:clearDisPatch()

		return
	end

	local var_30_0 = arg_30_0._disPatchSlotList[1]
	local var_30_1 = arg_30_0._gameMo:getSlotById(var_30_0)

	if var_30_1 then
		var_30_1:setDispatchSoldierInfo(arg_30_1, arg_30_0._disPatchSlotList, arg_30_0:getDispatchHeroFirst())
	end

	arg_30_0:clearDisPatch()
end

function var_0_0.getDisPatchSlotList(arg_31_0)
	return arg_31_0._disPatchSlotList
end

function var_0_0.clearDisPatch(arg_32_0)
	if arg_32_0._disPatchSlotList then
		tabletool.clear(arg_32_0._disPatchSlotList)
	end
end

function var_0_0.getNextDisPatchId(arg_33_0)
	if arg_33_0._disPatchId == nil then
		arg_33_0._disPatchId = 0
	end

	arg_33_0._disPatchId = arg_33_0._disPatchId + 1

	return arg_33_0._disPatchId
end

function var_0_0.checkCondition(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = false

	if arg_34_1 == nil then
		return var_34_0, nil
	end

	local var_34_1 = arg_34_1[1]

	if Activity201MaLiAnNaEnum.ConditionType.occupySlot == var_34_1 then
		local var_34_2 = arg_34_1[2]
		local var_34_3 = arg_34_1[3]
		local var_34_4 = arg_34_0:getSlotByConfigId(var_34_2)

		if var_34_4 and var_34_3 and var_34_4:getSlotCamp() == var_34_3 then
			var_34_0 = true
		end
	end

	if Activity201MaLiAnNaEnum.ConditionType.soldierHeroDead == var_34_1 then
		local var_34_5 = arg_34_1[2]

		if var_34_5 then
			local var_34_6 = MaLiAnNaLaSoliderMoUtil.instance:getSoliderMoByConfigId(var_34_5)

			if var_34_6 == nil or var_34_6:getCurState() == Activity201MaLiAnNaEnum.SoliderState.Dead then
				var_34_0 = true
			end
		end
	end

	if Activity201MaLiAnNaEnum.ConditionType.gameStart == var_34_1 or Activity201MaLiAnNaEnum.ConditionType.gameOverAndWin == var_34_1 then
		var_34_0 = true
	end

	if Activity201MaLiAnNaEnum.ConditionType.useSkill == var_34_1 then
		local var_34_7 = arg_34_1[2]

		if arg_34_2 then
			local var_34_8 = arg_34_2.skillId

			if var_34_8 and var_34_7 == var_34_8 then
				var_34_0 = true
			end
		end
	end

	return var_34_0, var_34_1
end

function var_0_0._initActiveSkill(arg_35_0)
	local var_35_0 = arg_35_0._gameConfig.skill

	if not string.nilorempty(var_35_0) then
		local var_35_1 = string.splitToNumber(var_35_0, "#")

		for iter_35_0, iter_35_1 in ipairs(var_35_1) do
			local var_35_2 = MaLiAnNaSkillUtils.instance.createSkill(iter_35_1)

			if var_35_2 then
				arg_35_0._allActiveSkill[#arg_35_0._allActiveSkill + 1] = var_35_2
			end
		end
	end
end

function var_0_0.getAllActiveSkill(arg_36_0)
	return arg_36_0._allActiveSkill
end

function var_0_0.updateAllActive(arg_37_0, arg_37_1)
	if arg_37_0._allActiveSkill == nil or #arg_37_0._allActiveSkill <= 0 then
		return
	end

	for iter_37_0, iter_37_1 in ipairs(arg_37_0._allActiveSkill) do
		if iter_37_1 then
			iter_37_1:update(arg_37_1)
		end
	end
end

function var_0_0.isMyCampBase(arg_38_0, arg_38_1)
	if arg_38_0._loseCondition == nil or arg_38_1 == nil then
		return false
	end

	if arg_38_0._loseCondition then
		for iter_38_0 = 1, #arg_38_0._loseCondition do
			local var_38_0 = arg_38_0._loseCondition[iter_38_0]

			if var_38_0 then
				local var_38_1 = var_38_0[1]

				if Activity201MaLiAnNaEnum.ConditionType.occupySlot == var_38_1 and var_38_0[2] == arg_38_1 then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.isEnemyBase(arg_39_0, arg_39_1)
	if arg_39_0._winCondition == nil or arg_39_1 == nil then
		return false
	end

	if arg_39_0._winCondition then
		for iter_39_0 = 1, #arg_39_0._winCondition do
			local var_39_0 = arg_39_0._winCondition[iter_39_0]

			if var_39_0 then
				local var_39_1 = var_39_0[1]

				if Activity201MaLiAnNaEnum.ConditionType.occupySlot == var_39_1 and var_39_0[2] == arg_39_1 then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.clear(arg_40_0)
	if arg_40_0._allDisPatchSolider ~= nil then
		tabletool.clear(arg_40_0._allDisPatchSolider)

		arg_40_0._allDisPatchSolider = nil
	end

	MaLiAnNaLaSoliderMoUtil.instance:clear()
	arg_40_0:reInit()
end

function var_0_0.destroy(arg_41_0)
	arg_41_0:clear()

	if arg_41_0._gameMo then
		arg_41_0._gameMo:destroy()

		arg_41_0._gameMo = nil
	end

	arg_41_0._allDisPatchSolider = nil
	arg_41_0._disPatchSlotList = nil

	if arg_41_0._allActiveSkill then
		for iter_41_0, iter_41_1 in ipairs(arg_41_0._allActiveSkill) do
			if iter_41_1 then
				iter_41_1:destroy()
			end
		end
	end

	arg_41_0._allActiveSkill = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
