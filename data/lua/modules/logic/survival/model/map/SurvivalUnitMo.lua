module("modules.logic.survival.model.map.SurvivalUnitMo", package.seeall)

local var_0_0 = pureTable("SurvivalUnitMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.cfgId = arg_1_1.cfgId
	arg_1_0.unitType = arg_1_1.unitType
	arg_1_0.dir = arg_1_1.position.dir
	arg_1_0.visionVal = arg_1_1.visionVal
	arg_1_0.fall = arg_1_1.fall
	arg_1_0.extraParam = {}

	if not string.nilorempty(arg_1_1.extraParam) then
		local var_1_0, var_1_1 = pcall(cjson.decode, arg_1_1.extraParam)

		if var_1_0 then
			arg_1_0.extraParam = var_1_1
		else
			logError("非法json" .. arg_1_1.extraParam)
		end
	end

	arg_1_0.pos = SurvivalHexNode.New(arg_1_1.position.hex.q, arg_1_1.position.hex.r)

	if arg_1_0.unitType == SurvivalEnum.UnitType.Battle then
		arg_1_0.co = lua_survival_fight.configDict[arg_1_0.cfgId]
	elseif arg_1_0.unitType == SurvivalEnum.UnitType.NPC then
		arg_1_0.co = SurvivalConfig.instance:getNpcConfig(arg_1_0.cfgId)
	elseif arg_1_0.unitType == SurvivalEnum.UnitType.Search then
		arg_1_0.co = lua_survival_search.configDict[arg_1_0.cfgId]
	elseif arg_1_0.unitType == SurvivalEnum.UnitType.Treasure then
		arg_1_0.co = lua_survival_mission.configDict[arg_1_0.cfgId]
	elseif arg_1_0.unitType == SurvivalEnum.UnitType.Task then
		arg_1_0.co = lua_survival_mission.configDict[arg_1_0.cfgId]
	elseif arg_1_0.unitType == SurvivalEnum.UnitType.Door then
		arg_1_0.co = lua_survival_mission.configDict[arg_1_0.cfgId]
	elseif arg_1_0.unitType == SurvivalEnum.UnitType.Exit then
		arg_1_0.co = lua_survival_mission.configDict[arg_1_0.cfgId]
	elseif arg_1_0.unitType == SurvivalEnum.UnitType.Block then
		arg_1_0.co = lua_survival_block.configDict[arg_1_0.cfgId]
	end

	if not arg_1_0.co and arg_1_0.unitType ~= SurvivalEnum.UnitType.Born then
		logError("没有元件配置" .. arg_1_0.cfgId .. " >> " .. arg_1_0.unitType)
	end

	arg_1_0.exPoints = {}

	if arg_1_0.co and not string.nilorempty(arg_1_0.co.grid) then
		local var_1_2 = GameUtil.splitString2(arg_1_0.co.grid, true, ",", "#")

		for iter_1_0, iter_1_1 in ipairs(var_1_2) do
			local var_1_3 = SurvivalHexNode.New(iter_1_1[1], iter_1_1[2])

			var_1_3:Add(arg_1_0.pos)
			var_1_3:rotateDir(arg_1_0.pos, arg_1_0.dir)

			arg_1_0.exPoints[iter_1_0] = var_1_3
		end
	end
end

function var_0_0.isSearched(arg_2_0)
	return arg_2_0.extraParam.panelUid and arg_2_0.extraParam.panelUid > 0
end

function var_0_0.isDestory(arg_3_0)
	return arg_3_0.extraParam.destroy
end

function var_0_0.copyFrom(arg_4_0, arg_4_1)
	tabletool.clear(arg_4_0)

	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		arg_4_0[iter_4_0] = iter_4_1
	end
end

function var_0_0.getResPath(arg_5_0)
	if arg_5_0.co then
		return arg_5_0.co.resource
	end
end

function var_0_0.getSceneResPath(arg_6_0)
	if SurvivalMapModel.instance:getSceneMo():getBlockTypeByPos(arg_6_0.pos) == SurvivalEnum.UnitSubType.Water and arg_6_0.co and not string.nilorempty(arg_6_0.co.waterResource) then
		return arg_6_0.co.waterResource
	end

	return arg_6_0:getResPath()
end

function var_0_0.isInNode(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_2 and not arg_7_0:canTrigger() then
		return false
	end

	if arg_7_1 == arg_7_0.pos then
		return true
	end

	for iter_7_0, iter_7_1 in pairs(arg_7_0.exPoints) do
		if iter_7_1 == arg_7_1 then
			return true
		end
	end

	return false
end

function var_0_0.canTrigger(arg_8_0)
	if not arg_8_0.co or arg_8_0.co.enforce == 1 then
		return false
	end

	if arg_8_0:isBlock() then
		return false
	end

	return true
end

function var_0_0.getWarmingRange(arg_9_0)
	if not arg_9_0.co or arg_9_0.unitType ~= SurvivalEnum.UnitType.Battle then
		return false
	end

	local var_9_0 = SurvivalShelterModel.instance:getWeekInfo()

	if not var_9_0 then
		return false
	end

	if arg_9_0.fall then
		return false
	end

	if arg_9_0.co.skip == 1 and arg_9_0.co.fightLevel <= var_9_0:getAttr(SurvivalEnum.AttrType.HeroFightLevel) then
		return false
	end

	local var_9_1 = arg_9_0.co.warningRange

	if var_9_1 > 0 then
		var_9_1 = var_9_1 + var_9_0:getAttr(SurvivalEnum.AttrType.WarningRange)
	end

	if var_9_1 > 0 and arg_9_0.visionVal ~= 8 then
		return var_9_1
	end
end

function var_0_0.isPointInWarming(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getWarmingRange()

	if not var_10_0 then
		return false
	end

	return var_10_0 >= SurvivalHelper.instance:getDistance(arg_10_1, arg_10_0.pos)
end

function var_0_0.isBlock(arg_11_0)
	return arg_11_0.unitType == SurvivalEnum.UnitType.Block
end

function var_0_0.isBlockEvent(arg_12_0)
	return arg_12_0.co and arg_12_0.co.subType == SurvivalEnum.UnitSubType.BlockEvent
end

function var_0_0.getSubType(arg_13_0)
	return arg_13_0.co and arg_13_0.co.subType or 0
end

return var_0_0
