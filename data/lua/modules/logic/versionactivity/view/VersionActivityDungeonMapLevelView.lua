-- chunkname: @modules/logic/versionactivity/view/VersionActivityDungeonMapLevelView.lua

module("modules.logic.versionactivity.view.VersionActivityDungeonMapLevelView", package.seeall)

local VersionActivityDungeonMapLevelView = class("VersionActivityDungeonMapLevelView", VersionActivityDungeonBaseMapLevelView)

function VersionActivityDungeonMapLevelView:getEpisodeIndex()
	local mode = ActivityConfig.instance:getChapterIdMode(self.originEpisodeConfig.chapterId)

	if mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		return VersionActivityDungeonMapLevelView.super.getEpisodeIndex(self)
	end

	local episodeList = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(self.originEpisodeConfig)

	return DungeonConfig.instance:getEpisodeLevelIndex(episodeList[1])
end

function VersionActivityDungeonMapLevelView:buildEpisodeName()
	local name = self.showEpisodeCo.name
	local firstName = GameUtil.utf8sub(name, 1, 1)
	local remainName = ""
	local nameLen = GameUtil.utf8len(name)

	if nameLen > 1 then
		remainName = GameUtil.utf8sub(name, 2, nameLen - 1)
	end

	local txtColor = self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and "#bc9999" or "#bcbaaa"
	local _firstSize = 112

	if GameConfig:GetCurLangType() == LangSettings.en then
		_firstSize = 90
	elseif GameConfig:GetCurLangType() == LangSettings.kr then
		_firstSize = 100
	end

	return self:buildColorText(string.format("<size=%s>%s</size>%s", _firstSize, firstName, remainName), txtColor)
end

return VersionActivityDungeonMapLevelView
