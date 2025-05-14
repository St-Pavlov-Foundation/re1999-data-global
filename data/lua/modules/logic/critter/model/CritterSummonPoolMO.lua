module("modules.logic.critter.model.CritterSummonPoolMO", package.seeall)

local var_0_0 = pureTable("CritterSummonPoolMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.rare = arg_1_1
	arg_1_0.uid = "0"
	arg_1_0.critterId = arg_1_2
	arg_1_0.count = arg_1_3
	arg_1_0.poolCount = arg_1_3 - arg_1_4
	arg_1_0.co = CritterConfig.instance:getCritterCfg(arg_1_2)

	arg_1_0:initCritterMo()
end

function var_0_0.initCritterMo(arg_2_0)
	arg_2_0.critterMo = CritterMO.New()

	local var_2_0 = 0
	local var_2_1 = 0
	local var_2_2 = 0
	local var_2_3 = 0
	local var_2_4 = 0
	local var_2_5 = 0
	local var_2_6 = {}

	if arg_2_0.co then
		if not string.nilorempty(arg_2_0.co.baseAttribute) then
			local var_2_7 = GameUtil.splitString2(arg_2_0.co.baseAttribute, true)

			var_2_0 = var_2_7[1][2] or 0
			var_2_1 = var_2_7[2][2] or 0
			var_2_2 = var_2_7[3][2] or 0
		end

		if not string.nilorempty(arg_2_0.co.baseAttribute) then
			local var_2_8 = GameUtil.splitString2(arg_2_0.co.attributeIncrRate, true)

			var_2_3 = var_2_8[1][2] or 0
			var_2_4 = var_2_8[2][2] or 0
			var_2_5 = var_2_8[3][2] or 0
		end

		var_2_6 = {
			tags = {
				arg_2_0.co.raceTag
			}
		}
	end

	local var_2_9 = {
		specialSkin = false,
		id = arg_2_0.uid,
		uid = arg_2_0.uid,
		defineId = arg_2_0.critterId,
		efficiency = var_2_0,
		patience = var_2_1,
		lucky = var_2_2,
		efficiencyIncrRate = var_2_3,
		patienceIncrRate = var_2_4,
		luckyIncrRate = var_2_5,
		tagAttributeRates = {},
		skillInfo = var_2_6
	}

	arg_2_0.critterMo:init(var_2_9)
end

function var_0_0.getCritterMo(arg_3_0)
	return arg_3_0.critterMo
end

function var_0_0.onRefreshPoolCount(arg_4_0, arg_4_1)
	arg_4_0.poolCount = arg_4_0.count - arg_4_1
end

function var_0_0.getPoolCount(arg_5_0)
	return arg_5_0.poolCount
end

function var_0_0.isFullPool(arg_6_0)
	return arg_6_0.count == arg_6_0.poolCount
end

return var_0_0
