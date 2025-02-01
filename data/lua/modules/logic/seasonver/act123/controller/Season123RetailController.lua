module("modules.logic.seasonver.act123.controller.Season123RetailController", package.seeall)

slot0 = class("Season123RetailController", BaseController)

function slot0.onOpenView(slot0, slot1)
	Season123Controller.instance:registerCallback(Season123Event.StartEnterBattle, slot0.handleStartEnterBattle, slot0)
	Season123RetailModel.instance:init(slot1)
end

function slot0.onCloseView(slot0)
	Season123Controller.instance:unregisterCallback(Season123Event.StartEnterBattle, slot0.handleStartEnterBattle, slot0)
	Season123RetailModel.instance:release()
end

function slot0.enterRetailFightScene(slot0)
	if Season123RetailModel.instance:getUTTUTicketNum() <= 0 then
		if CurrencyConfig.instance:getCurrencyCo(Season123Config.instance:getEquipItemCoin(Season123RetailModel.instance.activityId, Activity123Enum.Const.UttuTicketsCoin)) then
			GameFacade.showToast(ToastEnum.NotEnoughId, slot4.name)
		end

		return
	end

	if Season123RetailModel.instance:getEpisodeId() then
		Season123EpisodeDetailModel.instance.lastSendEpisodeCfg = Season123RetailModel.instance.episodeCO

		slot0:startBattle(slot2, slot3)
	end
end

function slot0.startBattle(slot0, slot1, slot2)
	logNormal(string.format("startBattle with actId = %s, episodeId = %s", slot1, slot2))
	Season123Model.instance:setBattleContext(slot1, nil, , slot2)
	DungeonFightController.instance:enterSeasonFight(DungeonConfig.instance:getEpisodeCO(slot2).chapterId, slot2)
end

function slot0.handleStartEnterBattle(slot0, slot1)
	if not Season123RetailModel.instance.lastSendEpisodeCfg then
		return
	end

	slot4 = slot1.layer

	if Season123RetailModel.instance.lastSendEpisodeCfg and slot1.actId == Season123RetailModel.instance.activityId then
		DungeonFightController.instance:enterSeasonFight(slot2.chapterId, slot2.id)
	end
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
