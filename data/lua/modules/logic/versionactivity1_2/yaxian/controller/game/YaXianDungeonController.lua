module("modules.logic.versionactivity1_2.yaxian.controller.game.YaXianDungeonController", package.seeall)

slot0 = class("YaXianDungeonController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.enterFight(slot0, slot1)
	slot2 = YaXianGameEnum.EpisodeId
	DungeonModel.instance.versionActivityChapterType = DungeonEnum.ChapterType.YaXian

	DungeonFightController.instance:enterFightByBattleId(DungeonConfig.instance:getEpisodeCO(slot2).chapterId, slot2, slot1)
end

function slot0.openGameAfterFight(slot0)
	if not YaXianModel.instance.currentMapMo then
		logError("not playing map data")

		return
	end

	YaXianGameController.instance:initMapByMapMo(slot1)
	ViewMgr.instance:openView(ViewName.YaXianGameView)
end

slot0.instance = slot0.New()

return slot0
