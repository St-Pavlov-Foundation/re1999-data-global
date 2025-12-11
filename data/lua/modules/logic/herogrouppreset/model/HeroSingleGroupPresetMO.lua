module("modules.logic.herogrouppreset.model.HeroSingleGroupPresetMO", package.seeall)

local var_0_0 = pureTable("HeroSingleGroupPresetMO")

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

function var_0_0.setHeroGroup(arg_4_0, arg_4_1)
	arg_4_0._heroGroupMO = arg_4_1
end

function var_0_0.setTrial(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = arg_5_0._heroGroupMO

	if arg_5_0.trial and not arg_5_4 and arg_5_0:getTrialCO().equipId > 0 then
		var_5_0:updatePosEquips({
			index = arg_5_0.id - 1
		})
	end

	arg_5_0.trial = arg_5_1
	arg_5_0.trialTemplate = arg_5_2 or 0
	arg_5_0.trialPos = arg_5_0.trialPos or arg_5_3

	if not arg_5_1 then
		arg_5_0.trialPos = nil
	end

	if arg_5_1 and not arg_5_4 and arg_5_0:getTrialCO().equipId > 0 then
		var_5_0:updatePosEquips({
			index = arg_5_0.id - 1
		})
	end
end

function var_0_0.getHeroMO(arg_6_0)
	return arg_6_0.heroUid and HeroModel.instance:getById(arg_6_0.heroUid)
end

function var_0_0.getHeroCO(arg_7_0)
	local var_7_0 = arg_7_0:getHeroMO()

	return var_7_0 and lua_character.configDict[var_7_0.heroId]
end

function var_0_0.getMonsterCO(arg_8_0)
	return arg_8_0.aid and lua_monster.configDict[arg_8_0.aid]
end

function var_0_0.getTrialCO(arg_9_0)
	return arg_9_0.trial and lua_hero_trial.configDict[arg_9_0.trial][arg_9_0.trialTemplate]
end

function var_0_0.setEmpty(arg_10_0)
	arg_10_0.heroUid = "0"

	arg_10_0:setTrial()
end

function var_0_0.setHeroUid(arg_11_0, arg_11_1)
	arg_11_0.heroUid = arg_11_1
end

function var_0_0.isEqual(arg_12_0, arg_12_1)
	return not arg_12_0:isEmpty() and arg_12_0.heroUid == arg_12_1
end

function var_0_0.isEmpty(arg_13_0)
	if arg_13_0.aid then
		return arg_13_0.aid == -1
	else
		return not arg_13_0.heroUid or arg_13_0.heroUid == "0"
	end
end

function var_0_0.canAddHero(arg_14_0)
	if arg_14_0.aid then
		return false
	else
		return not arg_14_0.heroUid or arg_14_0.heroUid == "0"
	end
end

function var_0_0.isAidConflict(arg_15_0, arg_15_1)
	if not arg_15_0.aid or arg_15_0.aid == -1 then
		return false
	end

	local var_15_0 = lua_monster.configDict[tonumber(arg_15_0.aid)]
	local var_15_1 = var_15_0 and tonumber(string.sub(tostring(var_15_0.skinId), 1, 4))

	if var_15_1 and var_15_1 == tonumber(arg_15_1) then
		return true
	end

	return false
end

return var_0_0
