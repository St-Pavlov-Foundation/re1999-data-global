module("modules.logic.versionactivity.view.VersionActivityDungeonMapLevelView", package.seeall)

slot0 = class("VersionActivityDungeonMapLevelView", VersionActivityDungeonBaseMapLevelView)

function slot0.getEpisodeIndex(slot0)
	if ActivityConfig.instance:getChapterIdMode(slot0.originEpisodeConfig.chapterId) == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		return uv0.super.getEpisodeIndex(slot0)
	end

	return DungeonConfig.instance:getEpisodeLevelIndex(DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(slot0.originEpisodeConfig)[1])
end

function slot0.buildEpisodeName(slot0)
	slot1 = slot0.showEpisodeCo.name
	slot2 = GameUtil.utf8sub(slot1, 1, 1)
	slot3 = ""

	if GameUtil.utf8len(slot1) > 1 then
		slot3 = GameUtil.utf8sub(slot1, 2, slot4 - 1)
	end

	slot5 = slot0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and "#bc9999" or "#bcbaaa"
	slot6 = 112

	if GameConfig:GetCurLangType() == LangSettings.en then
		slot6 = 90
	elseif GameConfig:GetCurLangType() == LangSettings.kr then
		slot6 = 100
	end

	return slot0:buildColorText(string.format("<size=%s>%s</size>%s", slot6, slot2, slot3), slot5)
end

return slot0
