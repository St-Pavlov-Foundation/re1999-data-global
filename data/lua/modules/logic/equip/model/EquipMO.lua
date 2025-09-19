module("modules.logic.equip.model.EquipMO", package.seeall)

local var_0_0 = pureTable("EquipMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = tonumber(arg_1_1.uid)
	arg_1_0.config = EquipConfig.instance:getEquipCo(arg_1_1.equipId)
	arg_1_0._canBreak = nil
	arg_1_0.equipId = arg_1_1.equipId
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.level = arg_1_1.level
	arg_1_0.exp = arg_1_1.exp
	arg_1_0.breakLv = arg_1_1.breakLv
	arg_1_0.count = arg_1_1.count
	arg_1_0.isLock = arg_1_1.isLock
	arg_1_0.refineLv = arg_1_1.refineLv
	arg_1_0.equipType = EquipEnum.ClientEquipType.Normal

	arg_1_0:clearRecommend()
end

function var_0_0.getBreakLvByLevel(arg_2_0, arg_2_1)
	local var_2_0 = math.huge

	if arg_2_0.config then
		for iter_2_0, iter_2_1 in pairs(lua_equip_break_cost.configDict[arg_2_0.config.rare]) do
			if iter_2_0 < var_2_0 and arg_2_1 <= iter_2_1.level then
				var_2_0 = iter_2_0
			end
		end
	else
		var_2_0 = 0
	end

	return var_2_0
end

function var_0_0.setBreakLvByLevel(arg_3_0, arg_3_1)
	arg_3_0.breakLv = arg_3_0:getBreakLvByLevel(arg_3_1 or arg_3_0.level)
end

function var_0_0.initByConfig(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_1 = arg_4_1 or "-9999999999"
	arg_4_0.id = tonumber(arg_4_1)
	arg_4_0.uid = arg_4_1
	arg_4_0.equipId = arg_4_2
	arg_4_0.level = arg_4_3
	arg_4_0.refineLv = math.max(1, arg_4_4)
	arg_4_0.config = EquipConfig.instance:getEquipCo(arg_4_2)
	arg_4_0.exp = 0

	local var_4_0 = math.huge

	if arg_4_0.config then
		for iter_4_0, iter_4_1 in pairs(lua_equip_break_cost.configDict[arg_4_0.config.rare]) do
			if iter_4_0 < var_4_0 and iter_4_1.level >= arg_4_0.level then
				var_4_0 = iter_4_0
			end
		end
	else
		var_4_0 = 1

		logError("试用角色心相不存在   >>>  " .. tostring(arg_4_0.equipId))
	end

	arg_4_0.breakLv = var_4_0
	arg_4_0.count = 1
	arg_4_0.isLock = true
	arg_4_0.equipType = EquipEnum.ClientEquipType.Config
end

function var_0_0.initByTrialCO(arg_5_0, arg_5_1)
	arg_5_0:initByConfig(tostring(-arg_5_1.equipId - 1099511627776), arg_5_1.equipId, arg_5_1.equipLv, arg_5_1.equipRefine)

	arg_5_0.equipType = EquipEnum.ClientEquipType.TrialHero
end

function var_0_0.initByTrialEquipCO(arg_6_0, arg_6_1)
	arg_6_0:initByConfig(tostring(-arg_6_1.id), arg_6_1.equipId, arg_6_1.equipLv, arg_6_1.equipRefine)

	arg_6_0.equipType = EquipEnum.ClientEquipType.TrialEquip
end

function var_0_0.initOtherPlayerEquip(arg_7_0, arg_7_1)
	arg_7_0:init(arg_7_1)

	arg_7_0.equipType = EquipEnum.ClientEquipType.OtherPlayer
end

function var_0_0.clone(arg_8_0, arg_8_1)
	local var_8_0 = var_0_0.New()

	var_8_0:init(arg_8_0)

	var_8_0.count = 1
	var_8_0.id = arg_8_1

	return var_8_0
end

function var_0_0.clearRecommend(arg_9_0)
	arg_9_0.recommondIndex = -1
end

return var_0_0
