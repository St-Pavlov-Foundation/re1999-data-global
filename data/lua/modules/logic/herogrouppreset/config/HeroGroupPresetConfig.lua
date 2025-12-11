module("modules.logic.herogrouppreset.config.HeroGroupPresetConfig", package.seeall)

local var_0_0 = class("HeroGroupPresetConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"hero_team"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "hero_team" then
		arg_3_0:_initHeroTeam()
	end
end

function var_0_0._initHeroTeam(arg_4_0)
	arg_4_0._heroTeamList = {}

	for iter_4_0, iter_4_1 in ipairs(lua_hero_team.configList) do
		if iter_4_1.isDisplay == 1 then
			table.insert(arg_4_0._heroTeamList, iter_4_1)
		end
	end

	table.sort(arg_4_0._heroTeamList, function(arg_5_0, arg_5_1)
		return arg_5_0.sort < arg_5_1.sort
	end)
end

function var_0_0.getHeroTeamList(arg_6_0)
	return arg_6_0._heroTeamList
end

var_0_0.instance = var_0_0.New()

return var_0_0
