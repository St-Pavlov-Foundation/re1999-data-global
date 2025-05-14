module("modules.logic.player.controller.PlayerController", package.seeall)

local var_0_0 = class("PlayerController", BaseController)

function var_0_0.enterSelectScene(arg_1_0)
	ViewMgr.instance:openView(ViewName.PlayerView)
end

function var_0_0.openPlayerView(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = {
		playerInfo = arg_2_1,
		playerSelf = arg_2_2,
		heroCover = arg_2_3
	}

	ViewMgr.instance:openView(ViewName.PlayerView, var_2_0)
end

function var_0_0.openSelfPlayerView(arg_3_0)
	local var_3_0 = PlayerModel.instance:getPlayinfo()

	arg_3_0:openPlayerView(var_3_0, true)
end

function var_0_0.onInit(arg_4_0)
	return
end

function var_0_0.onInitFinish(arg_5_0)
	return
end

function var_0_0.addConstEvents(arg_6_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_6_0._OnDailyRefresh, arg_6_0)
end

function var_0_0._OnDailyRefresh(arg_7_0)
	PlayerModel.instance:checkCanRenameReset()
	PlayerRpc.instance:sendMarkMainThumbnailRequest()
	PlayerRpc.instance:sendGetPlayerInfoRequest(arg_7_0._onDailyRefreshGetPlayerInfo, arg_7_0)
	logNormal("每日五点刷新， 发送获取player信息的请求， PlayerRpc")
end

function var_0_0.updateAssistRewardCount(arg_8_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend) then
		return
	end

	PlayerRpc.instance:sendGetAssistBonusRequest()
end

function var_0_0.getAssistReward(arg_9_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend) then
		return
	end

	if not PlayerModel.instance:isHasAssistReward() then
		GameFacade.showToast(ToastEnum.NoRewardCanGet)

		return
	end

	PlayerRpc.instance:sendReceiveAssistBonusRequest()
end

function var_0_0.reInit(arg_10_0)
	return
end

function var_0_0._onDailyRefreshGetPlayerInfo(arg_11_0)
	arg_11_0:dispatchEvent(PlayerEvent.OnDailyRefresh)
end

var_0_0.instance = var_0_0.New()

return var_0_0
