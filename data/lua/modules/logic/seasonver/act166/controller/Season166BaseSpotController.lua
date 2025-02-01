module("modules.logic.seasonver.act166.controller.Season166BaseSpotController", package.seeall)

slot0 = class("Season166BaseSpotController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.enterBaseSpotFightScene(slot0, slot1)
	if Season166BaseSpotModel.instance.curEpisodeId then
		slot0:startBattle(slot1.actId, slot2)
	end
end

function slot0.startBattle(slot0, slot1, slot2)
	logNormal(string.format("startBattle with actId = %s, episodeId = %s", slot1, slot2))
	Season166Model.instance:setBattleContext(slot1, slot2, Season166BaseSpotModel.instance.curBaseSpotId, Season166BaseSpotModel.instance.talentId)
	DungeonFightController.instance:enterSeasonFight(DungeonConfig.instance:getEpisodeCO(slot2).chapterId, slot2)
end

slot0.instance = slot0.New()

return slot0
