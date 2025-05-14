module("modules.logic.critter.model.CritterSummonMO", package.seeall)

local var_0_0 = pureTable("CritterSummonMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id or arg_1_1.poolId
	arg_1_0.poolId = arg_1_1.poolId
	arg_1_0.hasSummonCritter = {}

	for iter_1_0 = 1, #arg_1_1.hasSummonCritter do
		local var_1_0 = arg_1_1.hasSummonCritter[iter_1_0]
		local var_1_1 = var_1_0.materialId
		local var_1_2 = var_1_0.quantity

		arg_1_0.hasSummonCritter[var_1_1] = var_1_2
	end

	arg_1_0.critterMos = {}

	local var_1_3 = CritterConfig.instance:getCritterSummonPoolCfg(arg_1_1.poolId)

	if var_1_3 then
		for iter_1_1, iter_1_2 in pairs(var_1_3) do
			local var_1_4 = GameUtil.splitString2(iter_1_2.critterIds, true)

			for iter_1_3, iter_1_4 in pairs(var_1_4) do
				local var_1_5 = CritterSummonPoolMO.New()
				local var_1_6 = iter_1_4[1]
				local var_1_7 = iter_1_4[2]
				local var_1_8 = arg_1_0.hasSummonCritter[var_1_6] or 0

				var_1_5:init(iter_1_2.rare, var_1_6, var_1_7, var_1_8)
				table.insert(arg_1_0.critterMos, var_1_5)
			end
		end
	end
end

function var_0_0.onRefresh(arg_2_0, arg_2_1)
	arg_2_0.hasSummonCritter = {}

	for iter_2_0 = 1, #arg_2_1 do
		local var_2_0 = arg_2_1[iter_2_0]
		local var_2_1 = var_2_0.materialId
		local var_2_2 = var_2_0.quantity

		arg_2_0.hasSummonCritter[var_2_1] = var_2_2

		local var_2_3 = arg_2_0:getCritterMoById(var_2_1)

		if var_2_3 then
			var_2_3:onRefreshPoolCount(var_2_2)
		end
	end
end

function var_0_0.getCritterMoById(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.critterMos) do
		if iter_3_1.critterId == arg_3_1 then
			return iter_3_1
		end
	end
end

function var_0_0.getCritterMos(arg_4_0)
	return arg_4_0.critterMos
end

function var_0_0.getCritterCount(arg_5_0)
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.critterMos) do
		var_5_0 = var_5_0 + iter_5_1:getPoolCount()
	end

	return var_5_0
end

return var_0_0
