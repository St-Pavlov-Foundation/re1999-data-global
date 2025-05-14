module("modules.logic.seasonver.act166.model.Season166HeroSingleGroupMO", package.seeall)

local var_0_0 = pureTable("Season166HeroSingleGroupMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = nil
	arg_1_0.heroUid = nil
	arg_1_0.aid = nil
	arg_1_0.trial = nil
	arg_1_0.trialTemplate = nil
	arg_1_0.trialPos = nil
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.id = arg_2_1
	arg_2_0.heroUid = arg_2_2 or "0"
	arg_2_0.trial = nil
	arg_2_0.trialTemplate = nil
	arg_2_0.trialPos = nil
end

function var_0_0.setAid(arg_3_0, arg_3_1)
	arg_3_0.aid = arg_3_1
end

function var_0_0.setTrial(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = Season166HeroGroupModel.instance:getCurGroupMO()

	if arg_4_0.trial and not arg_4_4 and arg_4_0:getTrialCO().equipId > 0 then
		var_4_0:updatePosEquips({
			index = arg_4_0.id - 1
		})
	end

	arg_4_0.trial = arg_4_1
	arg_4_0.trialTemplate = arg_4_2 or 0
	arg_4_0.trialPos = arg_4_0.trialPos or arg_4_3

	if not arg_4_1 then
		arg_4_0.trialPos = nil
	end

	if arg_4_1 and not arg_4_4 and arg_4_0:getTrialCO().equipId > 0 then
		var_4_0:updatePosEquips({
			index = arg_4_0.id - 1
		})
	end
end

function var_0_0.getHeroMO(arg_5_0)
	return arg_5_0.heroUid and HeroModel.instance:getById(arg_5_0.heroUid)
end

function var_0_0.getHeroCO(arg_6_0)
	local var_6_0 = arg_6_0:getHeroMO()

	return var_6_0 and lua_character.configDict[var_6_0.heroId]
end

function var_0_0.getMonsterCO(arg_7_0)
	return arg_7_0.aid and lua_monster.configDict[arg_7_0.aid]
end

function var_0_0.getTrialCO(arg_8_0)
	return arg_8_0.trial and lua_hero_trial.configDict[arg_8_0.trial][arg_8_0.trialTemplate]
end

function var_0_0.setEmpty(arg_9_0)
	arg_9_0.heroUid = "0"

	arg_9_0:setTrial()
end

function var_0_0.setHeroUid(arg_10_0, arg_10_1)
	arg_10_0.heroUid = arg_10_1
end

function var_0_0.isEqual(arg_11_0, arg_11_1)
	return not arg_11_0:isEmpty() and arg_11_0.heroUid == arg_11_1
end

function var_0_0.isEmpty(arg_12_0)
	if arg_12_0.aid then
		return arg_12_0.aid == -1
	else
		return not arg_12_0.heroUid or arg_12_0.heroUid == "0"
	end
end

function var_0_0.canAddHero(arg_13_0)
	if arg_13_0.aid then
		return false
	else
		return not arg_13_0.heroUid or arg_13_0.heroUid == "0"
	end
end

function var_0_0.isAidConflict(arg_14_0, arg_14_1)
	if not arg_14_0.aid or arg_14_0.aid == -1 then
		return false
	end

	local var_14_0 = lua_monster.configDict[tonumber(arg_14_0.aid)]
	local var_14_1 = var_14_0 and tonumber(string.sub(tostring(var_14_0.skinId), 1, 4))

	if var_14_1 and var_14_1 == tonumber(arg_14_1) then
		return true
	end

	return false
end

return var_0_0
