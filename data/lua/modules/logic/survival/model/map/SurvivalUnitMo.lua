module("modules.logic.survival.model.map.SurvivalUnitMo", package.seeall)

local var_0_0 = pureTable("SurvivalUnitMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.cfgId = arg_1_1.cfgId
	arg_1_0.unitType = arg_1_1.unitType
	arg_1_0.dir = arg_1_1.position.dir
	arg_1_0.visionVal = arg_1_1.visionVal
	arg_1_0.extraParam = arg_1_1.extraParam
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
	end

	if not arg_1_0.co and arg_1_0.unitType ~= SurvivalEnum.UnitType.Born then
		logError("没有元件配置" .. arg_1_0.cfgId .. " >> " .. arg_1_0.unitType)
	end

	arg_1_0.exPoints = {}

	if arg_1_0.co and not string.nilorempty(arg_1_0.co.grid) then
		local var_1_0 = GameUtil.splitString2(arg_1_0.co.grid, true, ",", "#")

		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			local var_1_1 = SurvivalHexNode.New(iter_1_1[1], iter_1_1[2])

			var_1_1:Add(arg_1_0.pos)
			var_1_1:rotateDir(arg_1_0.pos, arg_1_0.dir)

			arg_1_0.exPoints[iter_1_0] = var_1_1
		end
	end
end

function var_0_0.copyFrom(arg_2_0, arg_2_1)
	tabletool.clear(arg_2_0)

	for iter_2_0, iter_2_1 in pairs(arg_2_1) do
		arg_2_0[iter_2_0] = iter_2_1
	end
end

function var_0_0.getResPath(arg_3_0)
	if arg_3_0.co then
		return arg_3_0.co.resource
	end
end

function var_0_0.isInNode(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_2 and not arg_4_0:canTrigger() then
		return false
	end

	if arg_4_1 == arg_4_0.pos then
		return true
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0.exPoints) do
		if iter_4_1 == arg_4_1 then
			return true
		end
	end

	return false
end

function var_0_0.canTrigger(arg_5_0)
	if not arg_5_0.co or arg_5_0.co.enforce == 1 then
		return false
	end

	return true
end

function var_0_0.getWarmingRange(arg_6_0)
	if not arg_6_0.co or arg_6_0.unitType ~= SurvivalEnum.UnitType.Battle then
		return 0
	end

	return arg_6_0.co.warningRange
end

return var_0_0
