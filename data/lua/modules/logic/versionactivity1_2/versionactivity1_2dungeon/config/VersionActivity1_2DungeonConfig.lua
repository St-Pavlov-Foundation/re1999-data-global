module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.config.VersionActivity1_2DungeonConfig", package.seeall)

local var_0_0 = class("VersionActivity1_2DungeonConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._elements = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity116_building",
		"activity116_episode_sp"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity116_building" then
		arg_3_0:_initConfig()
	end
end

function var_0_0._initConfig(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(lua_activity116_building.configList) do
		arg_4_0._elements[iter_4_1.elementId] = arg_4_0._elements[iter_4_1.elementId] or {}
		arg_4_0._elements[iter_4_1.elementId][iter_4_1.id] = iter_4_1
	end
end

function var_0_0.getBuildingConfigsByElementID(arg_5_0, arg_5_1)
	return arg_5_0._elements and arg_5_0._elements[arg_5_1]
end

function var_0_0.get1_2EpisodeMapConfig(arg_6_0, arg_6_1)
	local var_6_0 = DungeonConfig.instance:getEpisodeCO(arg_6_1)
	local var_6_1 = arg_6_1 % 100
	local var_6_2 = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1)[1].id
	local var_6_3 = var_6_2 - var_6_2 % 100 + var_6_1
	local var_6_4 = DungeonConfig.instance:getEpisodeCO(var_6_3)

	return DungeonConfig.instance:getChapterMapCfg(var_6_4.chapterId, var_6_4.preEpisode)
end

function var_0_0.getEpisodeIndex(arg_7_0, arg_7_1)
	local var_7_0 = DungeonConfig.instance:get1_2VersionActivityEpisodeCoList(arg_7_1)
	local var_7_1 = var_7_0 and DungeonConfig.instance:getEpisodeCO(var_7_0[1]) or DungeonConfig.instance:getEpisodeCO(arg_7_1)

	if var_7_1.chapterId == VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard then
		local var_7_2 = arg_7_1 % 100
		local var_7_3 = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1)[1].id
		local var_7_4 = var_7_3 - var_7_3 % 100 + var_7_2

		return DungeonConfig.instance:getChapterEpisodeIndexWithSP(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1, var_7_4)
	else
		return DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_7_1.chapterId, var_7_1.id)
	end
end

function var_0_0.getConfigByEpisodeId(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._buildingType4 or arg_8_0:getType4List()

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_1 = string.splitToNumber(iter_8_1.configType, "#")

		for iter_8_2, iter_8_3 in ipairs(var_8_1) do
			if iter_8_3 == arg_8_1 then
				return iter_8_1
			end
		end
	end
end

function var_0_0.getType4List(arg_9_0)
	if arg_9_0._buildingType4 then
		return arg_9_0._buildingType4
	end

	arg_9_0._buildingType4 = {}

	for iter_9_0, iter_9_1 in ipairs(lua_activity116_building.configList) do
		if iter_9_1.buildingType == 4 then
			table.insert(arg_9_0._buildingType4, iter_9_1)
		end
	end

	return arg_9_0._buildingType4
end

var_0_0.instance = var_0_0.New()

return var_0_0
