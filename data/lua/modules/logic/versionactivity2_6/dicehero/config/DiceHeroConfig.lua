module("modules.logic.versionactivity2_6.dicehero.config.DiceHeroConfig", package.seeall)

local var_0_0 = class("DiceHeroConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"dice",
		"dice_buff",
		"dice_card",
		"dice_character",
		"dice_enemy",
		"dice_level",
		"dice_pattern",
		"dice_relic",
		"dice_point",
		"dice_suit",
		"dice_dialogue",
		"dice_task"
	}
end

function var_0_0.getTaskList(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(lua_dice_task.configList) do
		if iter_2_1.isOnline == 1 then
			table.insert(var_2_0, iter_2_1)
		end
	end

	return var_2_0
end

function var_0_0.getLevelCo(arg_3_0, arg_3_1, arg_3_2)
	for iter_3_0, iter_3_1 in ipairs(lua_dice_level.configList) do
		if iter_3_1.chapter == arg_3_1 and iter_3_1.room == arg_3_2 then
			return iter_3_1
		end
	end
end

function var_0_0.getLevelCos(arg_4_0, arg_4_1)
	if not arg_4_0._levelCos then
		arg_4_0._levelCos = {}

		for iter_4_0, iter_4_1 in ipairs(lua_dice_level.configList) do
			if not arg_4_0._levelCos[iter_4_1.chapter] then
				arg_4_0._levelCos[iter_4_1.chapter] = {}
			end

			arg_4_0._levelCos[iter_4_1.chapter][iter_4_1.room] = iter_4_1
		end
	end

	return arg_4_0._levelCos[arg_4_1] or {}
end

function var_0_0.getDiceSuitDict(arg_5_0, arg_5_1)
	if not arg_5_0._suitDict then
		arg_5_0._suitDict = {}

		for iter_5_0, iter_5_1 in ipairs(lua_dice_suit.configList) do
			local var_5_0 = {}

			for iter_5_2, iter_5_3 in ipairs(string.splitToNumber(iter_5_1.suit, "#") or {}) do
				var_5_0[iter_5_3] = true
			end

			arg_5_0._suitDict[iter_5_1.id] = var_5_0
		end

		local var_5_1 = {}

		GameUtil.setDefaultValue(var_5_1, true)

		arg_5_0._suitDict[0] = var_5_1
	end

	return arg_5_0._suitDict[arg_5_1]
end

function var_0_0.getDicePointDict(arg_6_0, arg_6_1)
	if not arg_6_0._pointDict then
		arg_6_0._pointDict = {}

		for iter_6_0, iter_6_1 in ipairs(lua_dice_point.configList) do
			local var_6_0 = {}

			for iter_6_2, iter_6_3 in ipairs(string.splitToNumber(iter_6_1.pointList, "#") or {}) do
				var_6_0[iter_6_3] = true
			end

			arg_6_0._pointDict[iter_6_1.id] = var_6_0
		end

		local var_6_1 = {}

		GameUtil.setDefaultValue(var_6_1, true)

		arg_6_0._pointDict[0] = var_6_1
	end

	return arg_6_0._pointDict[arg_6_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
