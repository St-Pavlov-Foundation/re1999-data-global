module("modules.logic.versionactivity2_8.dungeonboss.config.VersionActivity2_8BossConfig", package.seeall)

local var_0_0 = class("VersionActivity2_8BossConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"story_mode_battle_field",
		"single_mode_episode",
		"boss_fight_mode_const"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._taskDict = {}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "story_mode_battle_field" then
		arg_3_0:_initStoryModeBattleField()
	end
end

function var_0_0._initStoryModeBattleField(arg_4_0)
	arg_4_0._storyEpisodeMapId = {}

	local var_4_0 = lua_story_mode_battle_field.configList

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		local var_4_1 = string.split(iter_4_1.episodeIds, "#")
		local var_4_2 = string.split(iter_4_1.chapterMapIds, "#")

		for iter_4_2, iter_4_3 in ipairs(var_4_1) do
			local var_4_3 = var_4_2[iter_4_2]

			arg_4_0._storyEpisodeMapId[tonumber(iter_4_3)] = tonumber(var_4_3)
		end
	end
end

function var_0_0.getEpisodeMapId(arg_5_0, arg_5_1)
	return arg_5_0._storyEpisodeMapId[arg_5_1]
end

function var_0_0.getHeroGroupId(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(lua_story_mode_battle_field.configList) do
		if string.find(iter_6_1.episodeIds, arg_6_1) then
			return iter_6_1.heroGroupTypeId
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
