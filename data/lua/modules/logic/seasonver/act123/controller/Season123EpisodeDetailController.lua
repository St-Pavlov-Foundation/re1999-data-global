module("modules.logic.seasonver.act123.controller.Season123EpisodeDetailController", package.seeall)

slot0 = class("Season123EpisodeDetailController", BaseController)

function slot0.onOpenView(slot0, slot1, slot2, slot3)
	Season123Controller.instance:registerCallback(Season123Event.StartEnterBattle, slot0.handleStartEnterBattle, slot0)
	Season123Controller.instance:registerCallback(Season123Event.StageInfoChanged, slot0.handleDataChanged, slot0)
	Season123Controller.instance:registerCallback(Season123Event.GetActInfo, slot0.handleDataChanged, slot0)
	Season123Controller.instance:registerCallback(Season123Event.OnResetSucc, slot0.handleDataChanged, slot0)
	Season123EpisodeDetailModel.instance:init(slot1, slot2, slot3)
	Season123Controller.instance:checkAndHandleEffectEquip({
		actId = slot1,
		stage = slot2,
		layer = slot3
	})
end

function slot0.onCloseView(slot0)
	Season123Controller.instance:unregisterCallback(Season123Event.StartEnterBattle, slot0.handleStartEnterBattle, slot0)
	Season123Controller.instance:unregisterCallback(Season123Event.StageInfoChanged, slot0.handleDataChanged, slot0)
	Season123Controller.instance:unregisterCallback(Season123Event.GetActInfo, slot0.handleDataChanged, slot0)
	Season123Controller.instance:unregisterCallback(Season123Event.OnResetSucc, slot0.handleDataChanged, slot0)
	Season123EpisodeDetailModel.instance:release()
end

function slot0.canSwitchLayer(slot0, slot1)
	if slot1 then
		if not Season123EpisodeDetailModel.instance:isEpisodeUnlock(Season123EpisodeDetailModel.instance.layer + 1) then
			return false
		end
	elseif slot2 < 2 then
		return false
	end

	return true
end

function slot0.switchLayer(slot0, slot1)
	slot2 = Season123EpisodeDetailModel.instance.layer
	Season123EpisodeDetailModel.instance.layer = slot1 and slot2 + 1 or slot2 - 1

	Season123Controller.instance:dispatchEvent(Season123Event.DetailSwitchLayer, {
		isNext = slot1
	})
end

function slot0.checkEnterFightScene(slot0)
	if slot0:isStageNeedClean() then
		GameFacade.showMessageBox(MessageBoxIdDefine.Season123WarningCleanStage, MsgBoxEnum.BoxType.Yes_No, slot0.checkCleanNextLayers, nil, , slot0, nil, )

		return
	end

	slot0:checkCleanNextLayers()
end

function slot0.checkCleanNextLayers(slot0)
	if slot0:isNextLayersNeedClean() then
		GameFacade.showMessageBox(MessageBoxIdDefine.Season123WarningCleanLayer, MsgBoxEnum.BoxType.Yes_No, slot0.enterFightScene, nil, , slot0, nil, )

		return
	end

	slot0:enterFightScene()
end

function slot0.isStageNeedClean(slot0)
	slot2 = Season123EpisodeDetailModel.instance.stage

	if not Season123Model.instance:getActInfo(Season123EpisodeDetailModel.instance.activityId) then
		return false
	end

	return slot3.stage ~= 0 and slot3.stage ~= slot2
end

function slot0.isNextLayersNeedClean(slot0)
	slot2 = Season123EpisodeDetailModel.instance.stage
	slot3 = Season123EpisodeDetailModel.instance.layer

	if not Season123Model.instance:getActInfo(Season123EpisodeDetailModel.instance.activityId) then
		return false
	end

	if not slot4.stageMap[slot2] or not slot5.episodeMap then
		return false
	end

	for slot9, slot10 in pairs(slot5.episodeMap) do
		if slot3 <= slot10.layer and slot10:isFinished() then
			return true
		end
	end

	return false
end

function slot0.enterFightScene(slot0)
	slot3 = Season123EpisodeDetailModel.instance.layer

	if slot0:isStageNeedClean() then
		Activity123Rpc.instance:sendAct123ResetOtherStageRequest(Season123EpisodeDetailModel.instance.activityId, Season123EpisodeDetailModel.instance.stage, slot0.handleResetOtherStage, slot0)

		return
	end

	slot0:handleResetOtherStage()
end

function slot0.handleResetOtherStage(slot0)
	slot2 = Season123EpisodeDetailModel.instance.stage
	slot3 = Season123EpisodeDetailModel.instance.layer

	if not Season123Model.instance:getActInfo(Season123EpisodeDetailModel.instance.activityId) then
		return
	end

	if not slot4:getStageMO(slot2) then
		return
	end

	if slot5.episodeMap[slot3 + 1] and slot5.episodeMap[slot3 + 1]:isFinished() then
		Activity123Rpc.instance:sendAct123ResetHighLayerRequest(slot1, slot2, slot3, slot0.enterBattle, slot0)

		return
	end

	slot0:enterBattle()
end

function slot0.enterBattle(slot0)
	if Season123Config.instance:getSeasonEpisodeCo(Season123EpisodeDetailModel.instance.activityId, Season123EpisodeDetailModel.instance.stage, Season123EpisodeDetailModel.instance.layer) then
		Season123EpisodeDetailModel.instance.lastSendEpisodeCfg = slot4
		slot6 = Season123EpisodeDetailModel.instance:getByIndex(slot3).cfg.episodeId

		slot0:startBattle(slot1, slot2, slot3, slot4.episodeId)
	end
end

function slot0.startBattle(slot0, slot1, slot2, slot3, slot4)
	logNormal(string.format("startBattle with actId = %s, stage = %s, layer = %s, episodeId = %s", slot1, slot2, slot3, slot4))
	Season123Model.instance:setBattleContext(slot1, slot2, slot3, slot4)
	DungeonFightController.instance:enterSeasonFight(DungeonConfig.instance:getEpisodeCO(slot4).chapterId, slot4)
end

function slot0.handleStartEnterBattle(slot0, slot1)
	if not Season123EpisodeDetailModel.instance.lastSendEpisodeCfg then
		return
	end

	if Season123EpisodeDetailModel.instance.lastSendEpisodeCfg and slot1.actId == Season123EpisodeDetailModel.instance.activityId and slot1.layer == slot2.layer then
		if DungeonConfig.instance:getEpisodeCO(slot2.episodeId) then
			DungeonFightController.instance:enterSeasonFight(slot5.chapterId, slot5.id)
		else
			logError(string.format("episode cfg not found ! id = [%s]", slot2.episodeId))
		end
	end
end

function slot0.handleDataChanged(slot0)
	Season123EpisodeDetailModel.instance:initEpisodeList()

	if not Season123EpisodeDetailModel.instance:isEpisodeUnlock(Season123EpisodeDetailModel.instance.layer) then
		for slot5 = slot1, 1, -1 do
			if Season123EpisodeDetailModel.instance:isEpisodeUnlock(slot5) then
				Season123EpisodeDetailModel.instance.layer = slot5

				break
			end
		end
	end

	slot0:notifyView()
end

function slot0.notifyView(slot0)
	Season123Controller.instance:dispatchEvent(Season123Event.RefreshDetailView)
end

slot0.instance = slot0.New()

return slot0
