module("modules.logic.survival.model.shelter.SurvivalEquipSlotMo", package.seeall)

local var_0_0 = pureTable("SurvivalEquipSlotMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.parent = arg_1_2 or arg_1_0.parent
	arg_1_0.slotId = arg_1_1.slotId
	arg_1_0.level = arg_1_1.level
	arg_1_0.item = SurvivalBagItemMo.New()

	arg_1_0.item:init(arg_1_1.item)

	arg_1_0.item.source = SurvivalEnum.ItemSource.Equip
	arg_1_0.item.slotMo = arg_1_0
	arg_1_0.item.index = arg_1_0.slotId
	arg_1_0.values = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.values) do
		arg_1_0.values[iter_1_1.id] = iter_1_1.value
	end

	arg_1_0.item.equipValues = arg_1_0.values
	arg_1_0.unlock = arg_1_1.unlock
	arg_1_0.newFlag = arg_1_1.newFlag

	local var_1_0 = 0

	if arg_1_0.item.equipCo and not string.nilorempty(arg_1_0.item.equipCo.effect) then
		local var_1_1 = string.splitToNumber(arg_1_0.item.equipCo.effect, "#")

		for iter_1_2, iter_1_3 in ipairs(var_1_1) do
			local var_1_2 = lua_survival_equip_effect.configDict[iter_1_3]
			local var_1_3 = {}

			if var_1_2 and not string.nilorempty(var_1_2.effect_score) then
				local var_1_4 = GameUtil.splitString2(var_1_2.effect_score, true)

				for iter_1_4, iter_1_5 in ipairs(var_1_4) do
					local var_1_5 = iter_1_5[1] or 0
					local var_1_6 = iter_1_5[2] or 0
					local var_1_7 = iter_1_5[3] or 0

					if arg_1_0.values[var_1_5] and var_1_6 <= arg_1_0.values[var_1_5] and (not var_1_3[var_1_5] or var_1_7 > var_1_3[var_1_5]) then
						var_1_3[var_1_5] = var_1_7
					end
				end

				for iter_1_6, iter_1_7 in pairs(var_1_3) do
					var_1_0 = var_1_0 + iter_1_7
				end
			end
		end
	end

	arg_1_0.item.exScore = var_1_0
end

function var_0_0.getScore(arg_2_0)
	if not arg_2_0.item.equipCo then
		return 0
	end

	return arg_2_0.item.equipCo.score + arg_2_0.item.exScore
end

return var_0_0
