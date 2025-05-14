module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotTeamModel", package.seeall)

local var_0_0 = class("V1a6_CachotTeamModel")

function var_0_0.setSelectLevel(arg_1_0, arg_1_1)
	arg_1_0._selectLevel = arg_1_1
	arg_1_0._difficulty = lua_rogue_difficulty.configDict[arg_1_0._selectLevel]
	arg_1_0._seatLevel = string.splitToNumber(arg_1_0._difficulty.initLevel, "#")
end

function var_0_0.getPrepareNum(arg_2_0)
	return arg_2_0._difficulty.initHeroCount - V1a6_CachotEnum.HeroCountInGroup
end

function var_0_0.getSelectLevel(arg_3_0)
	return arg_3_0._selectLevel
end

function var_0_0.getInitSeatLevel(arg_4_0, arg_4_1)
	return arg_4_0._seatLevel[arg_4_1]
end

function var_0_0.getSeatLevel(arg_5_0, arg_5_1)
	return V1a6_CachotModel.instance:getRogueInfo().teamInfo.groupBoxStar[arg_5_1]
end

function var_0_0.clearSeatInfos(arg_6_0)
	arg_6_0._seatInfo = {}
end

function var_0_0.setSeatInfo(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not arg_7_1 or not arg_7_2 then
		return
	end

	arg_7_0._seatInfo[arg_7_3] = {
		arg_7_1,
		arg_7_2
	}
end

function var_0_0.getSeatInfo(arg_8_0, arg_8_1)
	return arg_8_0._seatInfo and arg_8_0._seatInfo[arg_8_1]
end

function var_0_0.getHeroMaxLevel(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_2 then
		return arg_9_1.level, arg_9_1.talent
	end

	local var_9_0 = CharacterEnum.Star[arg_9_1.config.rare]
	local var_9_1 = lua_rogue_field.configDict[arg_9_2]
	local var_9_2 = var_9_1[var_9_0 > 4 and "level" .. var_9_0 or "level4"]
	local var_9_3 = var_9_1.talentLevel
	local var_9_4 = HeroResonanceConfig.instance:getHeroMaxTalentLv(arg_9_1.heroId)
	local var_9_5 = math.min(var_9_3, var_9_4)

	if arg_9_0:isNoLimitLevel() then
		return var_9_2, var_9_5
	end

	return math.min(arg_9_1.level, var_9_2), math.min(arg_9_1.talent, var_9_5)
end

function var_0_0.getEquipMaxLevel(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_2 then
		return arg_10_1.level, arg_10_1.breakLv
	end

	local var_10_0 = lua_rogue_field.configDict[arg_10_2]
	local var_10_1 = 0

	if arg_10_0:isNoLimitLevel() then
		var_10_1 = var_10_0.equipLevel
	else
		var_10_1 = math.min(arg_10_1.level, var_10_0.equipLevel)
	end

	return var_10_1, arg_10_1:getBreakLvByLevel(var_10_1)
end

function var_0_0.isNoLimitLevel(arg_11_0)
	local var_11_0 = arg_11_0._selectLevel

	if not var_11_0 then
		local var_11_1 = V1a6_CachotModel.instance:getRogueInfo()

		if not var_11_1 then
			return false
		end

		var_11_0 = var_11_1.difficulty
	end

	local var_11_2 = lua_rogue_difficulty.configDict[var_11_0]
	local var_11_3 = string.split(var_11_2.effect2, "|")

	for iter_11_0, iter_11_1 in ipairs(var_11_3) do
		if iter_11_1 == V1a6_CachotEnum.NoLimit then
			return true
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
