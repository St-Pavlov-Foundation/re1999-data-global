module("modules.logic.fight.model.data.FightProgressInfoData", package.seeall)

local var_0_0 = FightDataClass("FightProgressInfoData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		local var_1_0 = {}
		local var_1_1 = iter_1_1.id

		var_1_0.id = var_1_1
		var_1_0.max = iter_1_1.max
		var_1_0.value = iter_1_1.value
		var_1_0.showId = iter_1_1.showId
		arg_1_0[var_1_1] = var_1_0
	end
end

function var_0_0.getDataByShowId(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return
	end

	for iter_2_0, iter_2_1 in pairs(arg_2_0) do
		if iter_2_1.showId == arg_2_1 then
			return iter_2_1
		end
	end
end

return var_0_0
