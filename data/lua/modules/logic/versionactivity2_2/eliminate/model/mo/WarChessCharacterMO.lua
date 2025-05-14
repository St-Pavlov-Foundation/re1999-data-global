module("modules.logic.versionactivity2_2.eliminate.model.mo.WarChessCharacterMO", package.seeall)

local var_0_0 = class("WarChessCharacterMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.slotIds = {}
	arg_1_0.diamonds = {}
	arg_1_0.addDiamonds = {}
	arg_1_0.removeDiamonds = {}
	arg_1_0.powerMax = arg_1_1.powerMax
	arg_1_0.hpInjury = 0

	arg_1_0:updateInfo(arg_1_1)
	arg_1_0:updateSlotInfo(arg_1_1.slotBox)
end

function var_0_0.updateInfo(arg_2_0, arg_2_1)
	arg_2_0.hp = arg_2_1.hp
	arg_2_0.power = arg_2_1.power
	arg_2_0.forecastBehavior = tabletool.copy(arg_2_1.forecastBehavior)

	arg_2_0:updateDiamondBox(arg_2_1.diamondBox)
end

function var_0_0.updateSlotInfo(arg_3_0, arg_3_1)
	if arg_3_1 then
		arg_3_0.slotIds = tabletool.copy(arg_3_1.pieceId)
	end
end

function var_0_0.updateDiamondBox(arg_4_0, arg_4_1)
	if arg_4_1 and arg_4_1.diamond then
		tabletool.clear(arg_4_0.diamonds)

		for iter_4_0, iter_4_1 in ipairs(arg_4_1.diamond) do
			local var_4_0 = iter_4_1.type
			local var_4_1 = iter_4_1.count

			arg_4_0.diamonds[var_4_0] = var_4_1
		end
	end
end

function var_0_0.updateHp(arg_5_0, arg_5_1)
	if arg_5_1 < 0 then
		arg_5_0.hpInjury = arg_5_0.hpInjury + math.abs(arg_5_1)
	end

	arg_5_0.hp = arg_5_0.hp + arg_5_1

	if arg_5_0.hp < 0 then
		arg_5_0.hp = 0
	end
end

function var_0_0.updatePower(arg_6_0, arg_6_1)
	arg_6_0.power = arg_6_0.power + arg_6_1
end

function var_0_0.updateForecastBehavior(arg_7_0, arg_7_1)
	arg_7_0.forecastBehavior = tabletool.copy(arg_7_1)
end

function var_0_0.updateDiamondInfo(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0.diamonds[arg_8_1] == nil then
		arg_8_0.diamonds[arg_8_1] = arg_8_2
	else
		arg_8_0.diamonds[arg_8_1] = arg_8_0.diamonds[arg_8_1] + arg_8_2
	end

	if arg_8_2 > 0 then
		local var_8_0 = arg_8_0.addDiamonds[arg_8_1] or 0

		arg_8_0.addDiamonds[arg_8_1] = var_8_0 + arg_8_2
	else
		local var_8_1 = arg_8_0.removeDiamonds[arg_8_1] or 0

		arg_8_0.removeDiamonds[arg_8_1] = var_8_1 + math.abs(arg_8_2)
	end
end

function var_0_0.diamondsIsEnough(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0.diamonds or not arg_9_0.diamonds[arg_9_1] then
		return false
	end

	return arg_9_2 <= arg_9_0.diamonds[arg_9_1]
end

function var_0_0.diffData(arg_10_0, arg_10_1)
	local var_10_0 = true

	if arg_10_0.id ~= arg_10_1.id then
		var_10_0 = false
	end

	if arg_10_0.power ~= arg_10_1.power then
		var_10_0 = false
	end

	if arg_10_0.hp ~= arg_10_1.hp then
		var_10_0 = false
	end

	if arg_10_0.diamonds and arg_10_1.diamonds then
		for iter_10_0, iter_10_1 in pairs(arg_10_0.diamonds) do
			if iter_10_1 ~= arg_10_1.diamonds[iter_10_0] then
				var_10_0 = false
			end
		end
	end

	if arg_10_0.slotIds and arg_10_1.slotIds then
		for iter_10_2, iter_10_3 in ipairs(arg_10_0.slotIds) do
			if iter_10_3 ~= arg_10_1.slotIds[iter_10_2] then
				var_10_0 = false
			end
		end
	end

	return var_10_0
end

return var_0_0
