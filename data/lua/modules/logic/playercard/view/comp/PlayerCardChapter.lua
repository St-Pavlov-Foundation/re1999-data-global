module("modules.logic.playercard.view.comp.PlayerCardChapter", package.seeall)

slot0 = class("PlayerCardChapter", BasePlayerCardComp)

function slot0.onInitView(slot0)
	slot0.txtChapter = gohelper.findChildTextMesh(slot0.viewGO, "#txt_chapter")
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onRefreshView(slot0)
	if slot0:getPlayerInfo().lastEpisodeId and lua_episode.configDict[slot2] then
		if DungeonConfig.instance:getChapterCO(slot3.chapterId).type == DungeonEnum.ChapterType.Simple then
			slot3 = lua_episode.configDict[slot3.normalEpisodeId]
		end

		if slot3 then
			slot0.txtChapter.text = string.format("《%s %s》", DungeonController.getEpisodeName(slot3), slot3.name)
		end
	end
end

function slot0.onDestroy(slot0)
end

return slot0
