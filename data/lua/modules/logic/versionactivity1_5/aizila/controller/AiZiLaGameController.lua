module("modules.logic.versionactivity1_5.aizila.controller.AiZiLaGameController", package.seeall)

local var_0_0 = class("AiZiLaGameController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.exitGame(arg_5_0)
	if ViewMgr.instance:isOpen(ViewName.AiZiLaGameEventResult) then
		var_0_0.instance:leaveEventResult()

		return
	end

	if ViewMgr.instance:isOpen(ViewName.AiZiLaGameEventView) then
		ViewMgr.instance:closeView(ViewName.AiZiLaGameEventView)

		return
	end

	local var_5_0 = AiZiLaGameModel.instance:getEpisodeMO()
	local var_5_1 = 0
	local var_5_2 = var_5_0:getRoundCfg()

	if var_5_2 then
		var_5_1 = 1000 - var_5_2.keepMaterialRate
	end

	if var_5_0:isCanSafe() or var_5_1 == 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.V1a5AiZiLaSafeExitGame, MsgBoxEnum.BoxType.Yes_No, var_0_0._onExitGameYes)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.V1a5AiZiLaNotSafeExitGame, MsgBoxEnum.BoxType.Yes_No, var_0_0._onExitGameYes, nil, nil, arg_5_0, nil, nil, var_5_1 * 0.1)
	end
end

function var_0_0._onExitGameYes()
	var_0_0.instance:settleEpisode()
end

function var_0_0.enterGame(arg_7_0, arg_7_1)
	AiZiLaGameModel.instance:reInit()
	AiZiLaGameModel.instance:setEpisodeId(arg_7_1)

	local var_7_0 = AiZiLaGameModel.instance:getActivityID()
	local var_7_1 = AiZiLaConfig.instance:getEpisodeCo(var_7_0, arg_7_1)

	arg_7_0._enterStoryFinish = true
	arg_7_0._enterRpcFinish = false

	if arg_7_0:_checkCanPlayStory(var_7_1.storyBefore) then
		arg_7_0._enterStoryFinish = false

		arg_7_0:_playStory(var_7_1.storyBefore, arg_7_0._afterPlayEnterStory, arg_7_0)
	end

	Activity144Rpc.instance:sendAct144EnterEpisodeRequest(var_7_0, arg_7_1, arg_7_0._onEnterGameRequest, arg_7_0)
end

function var_0_0._checkCanPlayStory(arg_8_0, arg_8_1)
	if arg_8_1 and arg_8_1 ~= 0 and not StoryModel.instance:isStoryHasPlayed(arg_8_1) then
		return true
	end

	return false
end

function var_0_0.playStory(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0:_playStory(arg_9_1)
end

function var_0_0._playStory(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = {}

	var_10_0.blur = true
	var_10_0.hideStartAndEndDark = true
	var_10_0.mark = true
	var_10_0.isReplay = false

	StoryController.instance:playStory(arg_10_1, var_10_0, arg_10_2, arg_10_3)
end

function var_0_0._afterPlayEnterStory(arg_11_0)
	arg_11_0._enterStoryFinish = true

	arg_11_0:dispatchEvent(AiZiLaEvent.GameStoryPlayFinish)
	arg_11_0:_checkEnterGame()
end

function var_0_0._onEnterGameRequest(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_2 == 0 then
		arg_12_0._enterRpcFinish = true

		AiZiLaGameModel.instance:updateEpisode(arg_12_3.act144Episode)
		arg_12_0:_checkEnterGame()
	end
end

function var_0_0._checkEnterGame(arg_13_0)
	if arg_13_0._enterRpcFinish and arg_13_0._enterStoryFinish then
		arg_13_0:_startGame()
		ViewMgr.instance:openView(ViewName.AiZiLaGameOpenEffectView, {
			callback = arg_13_0._afterOpenEffect,
			callbackObj = arg_13_0
		})
	end
end

function var_0_0._afterOpenEffect(arg_14_0)
	ViewMgr.instance:openView(ViewName.AiZiLaGameView)
	ViewMgr.instance:closeView(ViewName.AiZiLaEpsiodeDetailView)
	ViewMgr.instance:closeView(ViewName.AiZiLaTaskView)
end

function var_0_0.gameResult(arg_15_0)
	arg_15_0:_delayGameResult(0.05)
end

function var_0_0._delayGameResult(arg_16_0, arg_16_1)
	TaskDispatcher.cancelTask(arg_16_0._onGameResult, arg_16_0)
	TaskDispatcher.runDelay(arg_16_0._onGameResult, arg_16_0, arg_16_1)
end

function var_0_0._onGameResult(arg_17_0)
	if arg_17_0._storyClearPlayIng then
		return
	end

	if arg_17_0._isWaitingEventResult then
		arg_17_0._isWaitingGameResult = true

		return
	end

	arg_17_0._isWaitingGameResult = false

	ViewMgr.instance:openView(ViewName.AiZiLaGameResultView)
	arg_17_0:_endGame()
end

function var_0_0.gameResultOver(arg_18_0)
	if ViewMgr.instance:isOpenFinish(ViewName.AiZiLaGameResultView) then
		local var_18_0 = AiZiLaGameModel.instance:getActivityID()
		local var_18_1 = AiZiLaGameModel.instance:getEpisodeId()
		local var_18_2 = AiZiLaConfig.instance:getEpisodeCo(var_18_0, var_18_1)

		arg_18_0._storyClearPlayIng = false

		if arg_18_0:_checkCanPlayStory(var_18_2.storyClear) and AiZiLaGameModel.instance:isPass() then
			arg_18_0._storyClearPlayIng = true

			arg_18_0:_playStory(var_18_2.storyClear, arg_18_0._afterPlayStoryClear, arg_18_0)
			ViewMgr.instance:closeView(ViewName.AiZiLaGameResultView)
		else
			AiZiLaController.instance:dispatchEvent(AiZiLaEvent.ExitGame)
		end
	end
end

function var_0_0._startGame(arg_19_0)
	if arg_19_0._statGameTime then
		return
	end

	arg_19_0._statGameTime = ServerTime.now()
end

function var_0_0._endGame(arg_20_0)
	if not arg_20_0._statGameTime then
		return
	end

	local var_20_0 = ServerTime.now() - arg_20_0._statGameTime
	local var_20_1 = AiZiLaGameModel.instance:getEpisodeMO()

	if not var_20_1 then
		return
	end

	local var_20_2 = var_20_1:getConfig()
	local var_20_3 = AiZiLaGameModel.instance:getIsSafe()
	local var_20_4 = {}

	if AiZiLaGameModel.instance:getIsFirstPass() and var_20_2 then
		AiZiLaHelper.getItemMOListByBonusStr(var_20_2.bonus, var_20_4)
	end

	tabletool.addValues(var_20_4, AiZiLaGameModel.instance:getResultItemList())

	local var_20_5 = {}

	for iter_20_0, iter_20_1 in ipairs(var_20_4) do
		local var_20_6 = iter_20_1:getConfig()

		if var_20_6 then
			table.insert(var_20_5, {
				materialtype = 1,
				materialname = var_20_6.name,
				materialnum = iter_20_1:getQuantity()
			})
		end
	end

	local var_20_7 = {}
	local var_20_8 = AiZiLaModel.instance:getEquipMOList()

	for iter_20_2, iter_20_3 in ipairs(var_20_8) do
		local var_20_9 = iter_20_3:getConfig()

		if var_20_9 then
			table.insert(var_20_7, {
				Ezra_equipname = var_20_9.name,
				Ezra_equip_level = var_20_9.level
			})
		end
	end

	arg_20_0._statGameTime = nil

	StatController.instance:track(StatEnum.EventName.ExitEzraActivity, {
		[StatEnum.EventProperties.UseTime] = var_20_0,
		[StatEnum.EventProperties.EpisodeId] = string.format("%s", var_20_1.episodeId),
		[StatEnum.EventProperties.ChallengesNum] = var_20_1.enterTimes,
		[StatEnum.EventProperties.RoundNum] = var_20_1.round,
		[StatEnum.EventProperties.RemainingMobility] = var_20_1.actionPoint,
		[StatEnum.EventProperties.CurrentAltitude] = var_20_1.altitude,
		[StatEnum.EventProperties.Result] = var_20_3 and "安全撤离" or "紧急撤离",
		[StatEnum.EventProperties.EquipInformation] = var_20_7,
		[StatEnum.EventProperties.Reward] = var_20_5
	})
end

function var_0_0._afterPlayStoryClear(arg_21_0)
	arg_21_0._storyClearPlayIng = false

	arg_21_0:dispatchEvent(AiZiLaEvent.GameStoryPlayFinish)
	AiZiLaController.instance:dispatchEvent(AiZiLaEvent.ExitGame)
end

var_0_0.GAME_FORWARD_GAME_BLOCK_KEY = "AiZiLaGameController.GAME_FORWARD_GAME_BLOCK_KEY"

function var_0_0.forwardGame(arg_22_0)
	AiZiLaHelper.startBlock(var_0_0.GAME_FORWARD_GAME_BLOCK_KEY)

	local var_22_0 = AiZiLaGameModel.instance:getActivityID()

	Activity144Rpc.instance:sendAct144NextDayRequest(var_22_0, arg_22_0._onForwardGameRequest, arg_22_0)
end

function var_0_0._onForwardGameRequest(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if arg_23_2 == 0 then
		AiZiLaGameModel.instance:updateEpisode(arg_23_3.act144Episode)
		ViewMgr.instance:openView(ViewName.AiZiLaGameEventView)
		arg_23_0:dispatchEvent(AiZiLaEvent.RefreshGameEpsiode)
	end

	AiZiLaHelper.endBlock(var_0_0.GAME_FORWARD_GAME_BLOCK_KEY)
end

var_0_0.GAME_SELECT_OPTION_BLOCK_KEY = "AiZiLaGameController.GAME_SELECT_OPTION_BLOCK_KEY"

function var_0_0.selectOption(arg_24_0, arg_24_1)
	AiZiLaHelper.startBlock(var_0_0.GAME_SELECT_OPTION_BLOCK_KEY)

	local var_24_0 = AiZiLaGameModel.instance:getActivityID()

	arg_24_0._isWaitingEventResult = true

	Activity144Rpc.instance:sendAct144SelectOptionRequest(var_24_0, arg_24_1, arg_24_0._onSelectOptionRequest, arg_24_0)
end

function var_0_0._onSelectOptionRequest(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if arg_25_2 == 0 then
		local var_25_0 = arg_25_3.act144Episode
		local var_25_1 = {
			eventId = var_25_0.eventId,
			actId = arg_25_3.activityId,
			optionId = var_25_0.option,
			optionResultId = var_25_0.optionResultId,
			itemMOList = {}
		}

		arg_25_0._eventResultViewParams = var_25_1

		local var_25_2 = AiZiLaGameModel.instance
		local var_25_3 = var_25_0 and var_25_0.tempAct144Items or {}

		var_25_2:updateEpisode(var_25_0)
		var_25_2:setAct144Items(var_25_3)

		local var_25_4 = AiZiLaConfig.instance:getOptionResultCo(arg_25_3.activityId, var_25_0.optionResultId)

		if var_25_4 and not string.nilorempty(var_25_4.bonus) then
			AiZiLaHelper.getItemMOListByBonusStr(var_25_4.bonus, var_25_1.itemMOList)
		end

		AiZiLaHelper.playViewAnimator(ViewName.AiZiLaGameEventView, UIAnimationName.Switch)
		TaskDispatcher.runDelay(arg_25_0._onOpenGameEventResult, arg_25_0, AiZiLaEnum.AnimatorTime.GameEventViewClose)
		arg_25_0:dispatchEvent(AiZiLaEvent.RefreshGameEpsiode)
	else
		arg_25_0._eventResultViewParams = nil
		arg_25_0._isWaitingEventResult = false

		TaskDispatcher.cancelTask(arg_25_0._onOpenGameEventResult, arg_25_0)
		AiZiLaHelper.endBlock(var_0_0.GAME_SELECT_OPTION_BLOCK_KEY)
	end
end

function var_0_0._onOpenGameEventResult(arg_26_0)
	AiZiLaHelper.endBlock(var_0_0.GAME_SELECT_OPTION_BLOCK_KEY)

	arg_26_0._isWaitingEventResult = false

	if arg_26_0._eventResultViewParams then
		local var_26_0 = arg_26_0._eventResultViewParams

		arg_26_0._eventResultViewParams = nil

		ViewMgr.instance:openView(ViewName.AiZiLaGameEventResult, var_26_0)
		ViewMgr.instance:closeView(ViewName.AiZiLaGameEventView, true)
	end
end

function var_0_0.settleEpisode(arg_27_0)
	Activity144Rpc.instance:sendAct144SettleEpisodeRequest(VersionActivity1_5Enum.ActivityId.AiZiLa)
end

function var_0_0.leaveEventResult(arg_28_0)
	if arg_28_0._isWaitingGameResult then
		local var_28_0 = ViewMgr.instance:getContainer(ViewName.AiZiLaGameView)

		if var_28_0 and var_28_0:needPlayRiseAnim() then
			arg_28_0:_delayGameResult(AiZiLaEnum.AnimatorTime.MapViewRise)
		else
			arg_28_0:gameResult()
		end
	end

	ViewMgr.instance:closeView(ViewName.AiZiLaGameEventResult)
end

var_0_0.instance = var_0_0.New()

return var_0_0
