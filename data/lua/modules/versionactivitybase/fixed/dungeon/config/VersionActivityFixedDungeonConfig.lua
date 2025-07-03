module("modules.versionactivitybase.fixed.dungeon.config.VersionActivityFixedDungeonConfig", package.seeall)

local var_0_0 = class("VersionActivityFixedDungeonConfig", BaseConfig)

local function var_0_1(arg_1_0)
	local var_1_0 = DungeonConfig.instance:getEpisodeCO(arg_1_0)

	if var_1_0.chapterId ~= VersionActivityFixedHelper.getVersionActivityDungeonEnum().DungeonChapterId.ElementFight then
		if var_1_0.chapterId == VersionActivityFixedHelper.getVersionActivityDungeonEnum().DungeonChapterId.Hard then
			arg_1_0 = arg_1_0 - 10000
			var_1_0 = DungeonConfig.instance:getEpisodeCO(arg_1_0)
		else
			while var_1_0.chapterId ~= VersionActivityFixedHelper.getVersionActivityDungeonEnum().DungeonChapterId.Story do
				var_1_0 = DungeonConfig.instance:getEpisodeCO(var_1_0.preEpisode)
			end
		end
	end

	return var_1_0
end

function var_0_0.getEpisodeMapConfig(arg_2_0, arg_2_1)
	local var_2_0 = var_0_1(arg_2_1)

	return DungeonConfig.instance:getChapterMapCfg(VersionActivityFixedHelper.getVersionActivityDungeonEnum().DungeonChapterId.Story, var_2_0.preEpisode)
end

function var_0_0.checkElementBelongMapId(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {
		arg_3_1.mapId
	}

	return tabletool.indexOf(var_3_0, arg_3_2)
end

function var_0_0.getEpisodeIndex(arg_4_0, arg_4_1)
	local var_4_0 = var_0_1(arg_4_1)

	return DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_4_0.chapterId, var_4_0.id)
end

function var_0_0.getStoryEpisodeCo(arg_5_0, arg_5_1)
	return var_0_1(arg_5_1)
end

function var_0_0.getEpisodeIdByElementId(arg_6_0, arg_6_1)
	return DungeonConfig.instance:getChapterMapElement(arg_6_1).mapId
end

var_0_0.instance = var_0_0.New()

return var_0_0
