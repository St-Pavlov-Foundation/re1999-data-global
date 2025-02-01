module("modules.logic.seasonver.act166.controller.Season166TrainController", package.seeall)

slot0 = class("Season166TrainController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.enterTrainFightScene(slot0)
	if Season166TrainModel.instance.curEpisodeId then
		slot0:startBattle(Season166Model.instance:getCurSeasonId(), slot2)
	end
end

function slot0.startBattle(slot0, slot1, slot2)
	logNormal(string.format("startBattle with actId = %s, episodeId = %s", slot1, slot2))
	Season166Model.instance:setBattleContext(slot1, slot2, nil, Season166Model.getPrefsTalent(), Season166TrainModel.instance.curTrainId)
	DungeonFightController.instance:enterSeasonFight(DungeonConfig.instance:getEpisodeCO(slot2).chapterId, slot2)
end

slot0.instance = slot0.New()

return slot0
