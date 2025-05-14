module("modules.logic.rouge.config.RougeConfig1", package.seeall)

local var_0_0 = class("RougeConfig1", RougeConfig)

function var_0_0.season(arg_1_0)
	return 1
end

function var_0_0.openUnlockId(arg_2_0)
	return OpenEnum.UnlockFunc.Rouge1
end

function var_0_0.achievementJumpId(arg_3_0)
	return (tonumber(lua_rouge_const.configDict[RougeEnum.Const.AchievementJumpId].value))
end

function var_0_0.getRougeDifficultyViewStyleIndex(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	local var_4_0 = tonumber(arg_4_0:getConstValueByID(11)) or 1
	local var_4_1 = tonumber(arg_4_0:getConstValueByID(12)) or 1
	local var_4_2 = math.ceil(arg_4_1 / var_4_0)

	return math.min(var_4_1, var_4_2)
end

function var_0_0.calcStyleCOPassiveSkillDescsList(arg_5_0, arg_5_1)
	local var_5_0 = {
		arg_5_1.passiveSkillDescs
	}
	local var_5_1 = 2
	local var_5_2 = arg_5_1["passiveSkillDescs" .. tostring(var_5_1)]

	while var_5_2 do
		var_5_0[#var_5_0 + 1] = var_5_2
		var_5_1 = var_5_1 + 1
		var_5_2 = arg_5_1["passiveSkillDescs" .. tostring(var_5_1)]
	end

	return var_5_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
