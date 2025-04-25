module("modules.logic.player.controller.PlayerController", package.seeall)

slot0 = class("PlayerController", BaseController)

function slot0.enterSelectScene(slot0)
	ViewMgr.instance:openView(ViewName.PlayerView)
end

function slot0.openPlayerView(slot0, slot1, slot2, slot3)
	ViewMgr.instance:openView(ViewName.PlayerView, {
		playerInfo = slot1,
		playerSelf = slot2,
		heroCover = slot3
	})
end

function slot0.openSelfPlayerView(slot0)
	slot0:openPlayerView(PlayerModel.instance:getPlayinfo(), true)
end

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._OnDailyRefresh, slot0)
end

function slot0._OnDailyRefresh(slot0)
	PlayerModel.instance:checkCanRenameReset()
	PlayerRpc.instance:sendMarkMainThumbnailRequest()
	PlayerRpc.instance:sendGetPlayerInfoRequest(slot0._onDailyRefreshGetPlayerInfo, slot0)
	logNormal("每日五点刷新， 发送获取player信息的请求， PlayerRpc")
end

function slot0.updateAssistRewardCount(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend) then
		return
	end

	PlayerRpc.instance:sendGetAssistBonusRequest()
end

function slot0.getAssistReward(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend) then
		return
	end

	if not PlayerModel.instance:isHasAssistReward() then
		GameFacade.showToast(ToastEnum.NoRewardCanGet)

		return
	end

	PlayerRpc.instance:sendReceiveAssistBonusRequest()
end

function slot0.reInit(slot0)
end

function slot0._onDailyRefreshGetPlayerInfo(slot0)
	slot0:dispatchEvent(PlayerEvent.OnDailyRefresh)
end

slot0.instance = slot0.New()

return slot0
