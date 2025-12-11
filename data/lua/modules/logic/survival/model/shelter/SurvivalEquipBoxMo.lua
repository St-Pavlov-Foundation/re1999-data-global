module("modules.logic.survival.model.shelter.SurvivalEquipBoxMo", package.seeall)

local var_0_0 = pureTable("SurvivalEquipBoxMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.currPlanId = arg_1_1.currPlanId
	arg_1_0.maxTagId = arg_1_1.maxTagId
	arg_1_0.slots = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.slots) do
		local var_1_0 = SurvivalEquipSlotMo.New()

		var_1_0:init(iter_1_1, arg_1_0)

		arg_1_0.slots[var_1_0.slotId] = var_1_0
	end

	arg_1_0.jewelrySlots = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.jewelrySlots) do
		local var_1_1 = SurvivalEquipSlotMo.New()

		var_1_1:init(iter_1_3, arg_1_0)

		arg_1_0.jewelrySlots[var_1_1.slotId] = var_1_1
	end

	arg_1_0:calcAttrs()
end

function var_0_0.calcAttrs(arg_2_0)
	arg_2_0.values = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_0.slots) do
		for iter_2_2, iter_2_3 in pairs(iter_2_1.values) do
			if arg_2_0.values[iter_2_2] then
				arg_2_0.values[iter_2_2] = arg_2_0.values[iter_2_2] + iter_2_3
			else
				arg_2_0.values[iter_2_2] = iter_2_3
			end
		end
	end

	for iter_2_4, iter_2_5 in pairs(arg_2_0.jewelrySlots) do
		for iter_2_6, iter_2_7 in pairs(iter_2_5.values) do
			if arg_2_0.values[iter_2_6] then
				arg_2_0.values[iter_2_6] = arg_2_0.values[iter_2_6] + iter_2_7
			else
				arg_2_0.values[iter_2_6] = iter_2_7
			end
		end
	end
end

function var_0_0.getAllScore(arg_3_0)
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in pairs(arg_3_0.slots) do
		var_3_0 = var_3_0 + iter_3_1:getScore()
	end

	for iter_3_2, iter_3_3 in pairs(arg_3_0.jewelrySlots) do
		var_3_0 = var_3_0 + iter_3_3:getScore()
	end

	return var_3_0
end

return var_0_0
