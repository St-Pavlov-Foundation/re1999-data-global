module("modules.logic.versionactivity.view.VersionActivityDungeonMapLevelView", package.seeall)

local var_0_0 = class("VersionActivityDungeonMapLevelView", VersionActivityDungeonBaseMapLevelView)

function var_0_0.getEpisodeIndex(arg_1_0)
	if ActivityConfig.instance:getChapterIdMode(arg_1_0.originEpisodeConfig.chapterId) == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		return var_0_0.super.getEpisodeIndex(arg_1_0)
	end

	local var_1_0 = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(arg_1_0.originEpisodeConfig)

	return DungeonConfig.instance:getEpisodeLevelIndex(var_1_0[1])
end

function var_0_0.buildEpisodeName(arg_2_0)
	local var_2_0 = arg_2_0.showEpisodeCo.name
	local var_2_1 = GameUtil.utf8sub(var_2_0, 1, 1)
	local var_2_2 = ""
	local var_2_3 = GameUtil.utf8len(var_2_0)

	if var_2_3 > 1 then
		var_2_2 = GameUtil.utf8sub(var_2_0, 2, var_2_3 - 1)
	end

	local var_2_4 = arg_2_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and "#bc9999" or "#bcbaaa"
	local var_2_5 = 112

	if GameConfig:GetCurLangType() == LangSettings.en then
		var_2_5 = 90
	elseif GameConfig:GetCurLangType() == LangSettings.kr then
		var_2_5 = 100
	end

	return arg_2_0:buildColorText(string.format("<size=%s>%s</size>%s", var_2_5, var_2_1, var_2_2), var_2_4)
end

return var_0_0
