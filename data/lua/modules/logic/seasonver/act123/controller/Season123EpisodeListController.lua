module("modules.logic.seasonver.act123.controller.Season123EpisodeListController", package.seeall)

slot0 = class("Season123EpisodeListController", BaseController)

function slot0.onOpenView(slot0, slot1, slot2)
	Season123Controller.instance:registerCallback(Season123Event.GetActInfo, slot0.handleGetActInfo, slot0)
	Season123Controller.instance:registerCallback(Season123Event.GetActInfoBattleFinish, slot0.handleGetActInfo, slot0)
	Season123Controller.instance:registerCallback(Season123Event.ResetStageFinished, slot0.handleResetStageFinished, slot0)
	Season123Controller.instance:registerCallback(Season123Event.OnResetSucc, slot0.fixCurSelectedUnlock, slot0)
	Season123EpisodeListModel.instance:init(slot1, slot2)
	Season123Controller.instance:checkAndHandleEffectEquip({
		actId = slot1,
		stage = slot2
	})
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Season123
	})
end

function slot0.onCloseView(slot0)
	Season123Controller.instance:unregisterCallback(Season123Event.GetActInfo, slot0.handleGetActInfo, slot0)
	Season123Controller.instance:unregisterCallback(Season123Event.GetActInfoBattleFinish, slot0.handleGetActInfo, slot0)
	Season123Controller.instance:unregisterCallback(Season123Event.ResetStageFinished, slot0.handleResetStageFinished, slot0)
	Season123Controller.instance:unregisterCallback(Season123Event.OnResetSucc, slot0.fixCurSelectedUnlock, slot0)
	Season123EpisodeListModel.instance:release()
	Season123EpisodeRewardModel.instance:release()
end

function slot0.processJumpParam(slot0, slot1)
	if slot1.jumpId == Activity123Enum.JumpId.Market then
		slot0:setSelectLayer(slot1.jumpParam.tarLayer)

		if Season123EpisodeListModel.instance.activityId == Activity123Enum.SeasonID.Season1 and slot1.stage == 1 and slot2 and slot2 == 2 then
			return
		end

		slot0:enterEpisode()
	elseif slot1.jumpId == Activity123Enum.JumpId.MarketNoResult then
		ViewMgr.instance:openView(Season123Controller.instance:getEpisodeMarketViewName(), {
			actId = Season123EpisodeListModel.instance.activityId,
			stage = Season123EpisodeListModel.instance.stage,
			layer = slot1.jumpParam.tarLayer
		})
	end
end

function slot0.handleGetActInfo(slot0, slot1)
	if slot1 ~= Season123EpisodeListModel.instance.activityId then
		return
	end

	Season123EpisodeListModel.instance:initEpisodeList()

	if not slot0:fixCurSelectedUnlock() then
		slot0:notifyView()
	end
end

function slot0.handlePickHeroSuccess(slot0)
	Activity123Rpc.instance:sendGet123InfosRequest(Season123EpisodeListModel.instance.activityId, slot0.handleEnterStage, slot0)
end

function slot0.handleEnterStage(slot0)
	slot0:notifyView()
end

function slot0.handleResetStageFinished(slot0)
	Activity123Rpc.instance:sendGet123InfosRequest(Season123EpisodeListModel.instance.activityId, slot0.handleGet123InfosAfterRest, slot0)
	Season123Controller.instance:dispatchEvent(Season123Event.ResetCloseEpisodeList)
	Season123ShowHeroModel.instance:clearPlayHeroDieAnim(Season123EpisodeListModel.instance.stage)
end

function slot0.handleGet123InfosAfterRest(slot0)
	uv0.instance:setSelectLayer(1)
	slot0:notifyView()
end

function slot0.fixCurSelectedUnlock(slot0)
	if Season123EpisodeListModel.instance:getCurrentChallengeLayer() < Season123EpisodeListModel.instance.curSelectLayer then
		slot0:setSelectLayer(slot2)

		return true
	end

	return false
end

function slot0.openDetails(slot0)
	EnemyInfoController.instance:openSeason123EnemyInfoView(Season123EpisodeListModel.instance.activityId, Season123EpisodeListModel.instance.stage, Season123EpisodeListModel.instance:getCurrentChallengeLayer())
end

function slot0.enterEpisode(slot0, slot1)
	if not Season123EpisodeListModel.instance.curSelectLayer then
		return
	end

	if not Season123EpisodeListModel.instance:getById(slot2) then
		return
	end

	uv0.instance:setSelectLayer(slot2)

	slot5 = Season123EpisodeListModel.instance.stage

	if Season123EpisodeListModel.instance:isEpisodeUnlock(slot2) then
		logNormal("open layer = " .. tostring(slot2))

		if slot1 and (slot2 ~= 1 or slot3.isFinished or not Season123EpisodeListModel.instance:isLoadingAnimNeedPlay(slot5)) then
			ViewMgr.instance:openView(Season123Controller.instance:getEpisodeMarketViewName(), {
				actId = Season123EpisodeListModel.instance.activityId,
				stage = slot5,
				layer = slot2
			})
		else
			Season123EpisodeListModel.instance:savePlayLoadingAnimRecord(slot5)
			ViewMgr.instance:openView(Season123Controller.instance:getEpisodeLoadingViewName(), {
				actId = slot4,
				stage = slot5,
				layer = slot2
			})
		end
	else
		logNormal(string.format("layer [%s] is lock!!!!", tostring(slot2)))
	end
end

function slot0.setSelectLayer(slot0, slot1)
	Season123EpisodeListModel.instance:setSelectLayer(slot1)
	slot0:notifyView()
end

function slot0.notifyView(slot0)
	Season123Controller.instance:dispatchEvent(Season123Event.EpisodeViewRefresh)
end

function slot0.onReceiveEnterStage(slot0, slot1)
	Season123EpisodeListModel.instance:cleanPlayLoadingAnimRecord(slot1)
end

slot0.instance = slot0.New()

return slot0
