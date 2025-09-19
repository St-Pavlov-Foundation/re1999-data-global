module("modules.logic.versionactivity2_8.molideer.controller.MoLiDeErGameController", package.seeall)

local var_0_0 = class("MoLiDeErGameController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._finishIndex = nil
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	arg_4_0._finishIndex = nil
end

function var_0_0.enterGame(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = MoLiDeErConfig.instance:getEpisodeConfig(arg_5_1, arg_5_2).gameId
	local var_5_1 = MoLiDeErConfig.instance:getGameConfig(var_5_0)

	if var_5_1 == nil then
		logError("找不到对应的游戏关卡 id:" .. var_5_0)

		return
	end

	if ViewMgr.instance:isOpen(ViewName.MoLiDeErGameView) then
		-- block empty
	end

	MoLiDeErGameModel.instance:setCurGameData(var_5_0, var_5_1)
	ViewMgr.instance:openView(ViewName.MoLiDeErInterludeView, {
		isNextRound = false,
		callback = arg_5_0.onInterludeAnimFinish,
		callbackObj = arg_5_0
	})
end

function var_0_0.onInterludeAnimFinish(arg_6_0)
	ViewMgr.instance:openView(ViewName.MoLiDeErGameView)
end

function var_0_0.startGame(arg_7_0, arg_7_1, arg_7_2)
	MoLiDeErRpc.instance:sendAct194EnterEpisodeRequest(arg_7_1, arg_7_2, arg_7_0.onReceiveStartGame, arg_7_0)
end

function var_0_0.resumeGame(arg_8_0, arg_8_1, arg_8_2)
	MoLiDeErRpc.instance:sendAct194GetEpisodeInfoRequest(arg_8_1, arg_8_2, arg_8_0.onReceiveResumeGame, arg_8_0)
end

function var_0_0.onReceiveStartGame(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_2 == 0 then
		local var_9_0 = arg_9_3.activityId
		local var_9_1 = arg_9_3.episodeInfo.episodeId

		arg_9_0:enterGame(var_9_0, var_9_1)
	end
end

function var_0_0.onReceiveResumeGame(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_2 == 0 then
		local var_10_0 = arg_10_3.activityId
		local var_10_1 = arg_10_3.episodeInfo.episodeId

		arg_10_0:enterGame(var_10_0, var_10_1)
	end
end

function var_0_0.useItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	MoLiDeErRpc.instance:sendAct194UseItemRequest(arg_11_1, arg_11_2, arg_11_3)
end

function var_0_0.onUseItem(arg_12_0, arg_12_1)
	arg_12_0:dispatchEvent(MoLiDeErEvent.GameUseItem, arg_12_1.itemId)
end

function var_0_0.dispatchTeam(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	MoLiDeErRpc.instance:sendAct194SendTeamExploreRequest(arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
end

function var_0_0.withDrawTeam(arg_14_0, arg_14_1)
	local var_14_0 = MessageBoxIdDefine.MoLiDeErWithdrawTeamTip

	arg_14_0._withdrawTeamId = arg_14_1

	GameFacade.showMessageBox(var_14_0, MsgBoxEnum.BoxType.Yes_No, arg_14_0.realWithdrawTeam, nil, nil, arg_14_0)
end

function var_0_0.onWithdrawReply(arg_15_0, arg_15_1)
	arg_15_0:dispatchEvent(MoLiDeErEvent.GameWithdrawTeam, arg_15_1)
end

function var_0_0.realWithdrawTeam(arg_16_0)
	local var_16_0 = MoLiDeErModel.instance:getCurActId()
	local var_16_1 = MoLiDeErModel.instance:getCurEpisodeId()

	MoLiDeErRpc.instance:sendAct194WithdrawTeamRequest(var_16_0, var_16_1, arg_16_0._withdrawTeamId)

	arg_16_0._withdrawTeamId = nil
end

function var_0_0.onDispatchTeam(arg_17_0, arg_17_1)
	arg_17_0:dispatchEvent(MoLiDeErEvent.GameDispatchTeam)
end

function var_0_0.nextRound(arg_18_0, arg_18_1, arg_18_2)
	MoLiDeErRpc.instance:sendAct194NextRoundRequest(arg_18_1, arg_18_2)
end

function var_0_0.onEpisodeInfoPush(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1.activityId
	local var_19_1 = arg_19_1.episodeInfo
	local var_19_2 = MoLiDeErGameModel.instance:getCurGameInfo()

	if var_19_2 then
		local var_19_3 = var_19_2.currentRound
		local var_19_4 = var_19_1.currentRound

		MoLiDeErGameModel.instance:setEpisodeInfo(var_19_0, var_19_1, arg_19_1.isEpisodeFinish, arg_19_1.passStar)

		if var_19_3 < var_19_4 then
			logNormal("莫莉德尔 角色活动 下一回合")
			ViewMgr.instance:openView(ViewName.MoLiDeErInterludeView, {
				isNextRound = true,
				callback = arg_19_0.sendUIRefreshEvent,
				callbackObj = arg_19_0
			})
		elseif var_19_3 == var_19_4 then
			arg_19_0:sendUIRefreshEvent()
		else
			logNormal("莫莉德尔 角色活动 重置")
			ViewMgr.instance:openView(ViewName.MoLiDeErInterludeView)
			arg_19_0:dispatchEvent(MoLiDeErEvent.GameReset)
		end
	else
		MoLiDeErGameModel.instance:setEpisodeInfo(var_19_0, var_19_1, arg_19_1.isEpisodeFinish, arg_19_1.passStar)
	end
end

function var_0_0.sendUIRefreshEvent(arg_20_0)
	arg_20_0:dispatchEvent(MoLiDeErEvent.GameUIRefresh)
end

function var_0_0.showFinishEvent(arg_21_0, arg_21_1)
	if arg_21_1 ~= nil and arg_21_1 ~= ViewName.MoLiDeErEventView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_21_0.showFinishEvent, arg_21_0)

	local var_21_0 = MoLiDeErGameModel.instance:getCurGameInfo().newFinishEventList

	if var_21_0 and #var_21_0 > 0 then
		if arg_21_0._finishIndex == nil then
			logNormal("莫莉德尔 角色活动 存在完成的事件")

			arg_21_0._finishIndex = 1
		else
			if arg_21_0._finishIndex >= #var_21_0 then
				arg_21_0._finishIndex = nil

				arg_21_0:dispatchEvent(MoLiDeErEvent.GameFinishEventShowEnd)

				return
			end

			arg_21_0._finishIndex = arg_21_0._finishIndex + 1
		end

		if ViewMgr.instance:isOpen(ViewName.MoLiDeErEventView) then
			ViewMgr.instance:closeView(ViewName.MoLiDeErEventView)
		end

		local var_21_1 = var_21_0[arg_21_0._finishIndex]
		local var_21_2 = {
			eventId = var_21_1.eventId,
			optionId = var_21_1.optionId,
			state = MoLiDeErEnum.DispatchState.Finish
		}

		ViewMgr.instance:openView(ViewName.MoLiDeErEventView, var_21_2)
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_21_0.showFinishEvent, arg_21_0)
	else
		arg_21_0:dispatchEvent(MoLiDeErEvent.GameFinishEventShowEnd)
	end
end

function var_0_0.skipGame(arg_22_0)
	local var_22_0 = MessageBoxIdDefine.MoLiDeErSkipGameTip

	GameFacade.showMessageBox(var_22_0, MsgBoxEnum.BoxType.Yes_No, arg_22_0.realSendSkip, nil, nil, arg_22_0)
end

function var_0_0.realSendSkip(arg_23_0)
	local var_23_0 = MoLiDeErModel.instance:getCurActId()
	local var_23_1 = MoLiDeErModel.instance:getCurEpisodeId()

	MoLiDeErRpc.instance:sendAct194SkipEpisodeRequest(var_23_0, var_23_1)
end

function var_0_0.onReceiveSkipGame(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = MoLiDeErModel.instance:getCurActId()
	local var_24_1 = MoLiDeErModel.instance:getCurEpisodeId()

	MoLiDeErGameModel.instance:setSkipGameTrigger(arg_24_1, arg_24_2, true)

	if var_24_0 == arg_24_1 and var_24_1 == arg_24_2 then
		arg_24_0:onSuccessExit()
	end
end

function var_0_0.resetGame(arg_25_0)
	local var_25_0 = MessageBoxIdDefine.MoLiDeErResetGameTip

	GameFacade.showMessageBox(var_25_0, MsgBoxEnum.BoxType.Yes_No, arg_25_0.realResetGame, nil, nil, arg_25_0)
end

function var_0_0.realResetGame(arg_26_0)
	local var_26_0 = MoLiDeErModel.instance:getCurActId()
	local var_26_1 = MoLiDeErModel.instance:getCurEpisodeId()

	MoLiDeErRpc.instance:sendAct194ResetEpisodeRequest(var_26_0, var_26_1)
end

function var_0_0.onResetGame(arg_27_0, arg_27_1, arg_27_2)
	MoLiDeErGameModel.instance:resetGame(arg_27_1, arg_27_2)
end

function var_0_0.onSuccessExit(arg_28_0)
	arg_28_0:dispatchEvent(MoLiDeErEvent.GameExit)
	MoLiDeErController.instance:gameFinish()

	local var_28_0 = MoLiDeErModel.instance:getCurActId()
	local var_28_1 = MoLiDeErModel.instance:getCurEpisodeId()

	MoLiDeErGameModel.instance:resetGame(var_28_0, var_28_1)
end

function var_0_0.onFailRestart(arg_29_0)
	arg_29_0:restartGame()
end

function var_0_0.restartGame(arg_30_0)
	local var_30_0 = MoLiDeErModel.instance:getCurActId()
	local var_30_1 = MoLiDeErModel.instance:getCurEpisodeId()

	arg_30_0:startGame(var_30_0, var_30_1)
end

function var_0_0.onFailExit(arg_31_0)
	arg_31_0:dispatchEvent(MoLiDeErEvent.GameExit)

	local var_31_0 = MoLiDeErModel.instance:getCurActId()
	local var_31_1 = MoLiDeErModel.instance:getCurEpisodeId()

	MoLiDeErGameModel.instance:resetGame(var_31_0, var_31_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
