module("modules.logic.versionactivity2_6.xugouji.controller.XugoujiController", package.seeall)

local var_0_0 = class("XugoujiController", BaseController)
local var_0_1 = VersionActivity2_6Enum.ActivityId.Xugouji

function var_0_0.onInit(arg_1_0)
	arg_1_0._debugMode = PlayerPrefsHelper.getNumber("XugoujiDebugMode", 0) == 1
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0._setGuideMode(arg_4_0, arg_4_1)
	Activity188Model.instance:setGameGuideMode(arg_4_1)
end

function var_0_0.openXugoujiLevelView(arg_5_0)
	arg_5_0:registerCallback(XugoujiEvent.SetGameGuideMode, arg_5_0._setGuideMode, arg_5_0)

	local var_5_0 = ActivityModel.instance:getActMO(var_0_1)
	local var_5_1 = var_5_0 and var_5_0.config and var_5_0.config.storyId

	if arg_5_0:_checkCanPlayStory(var_5_1) then
		StoryController.instance:playStory(var_5_1, nil, arg_5_0._requestActInfo, arg_5_0)
	else
		arg_5_0:_requestActInfo()
	end
end

function var_0_0._requestActInfo(arg_6_0)
	Activity188Rpc.instance:sendGet188InfosRequest(VersionActivity2_6Enum.ActivityId.Xugouji, arg_6_0._onReceivedActInfo, arg_6_0)
end

function var_0_0._onReceivedActInfo(arg_7_0)
	ViewMgr.instance:openView(ViewName.XugoujiLevelView)
end

function var_0_0.openXugoujiGameView(arg_8_0)
	ViewMgr.instance:openView(ViewName.XugoujiGameView)
end

function var_0_0.openTaskView(arg_9_0)
	ViewMgr.instance:openView(ViewName.XugoujiTaskView)
end

function var_0_0.openCardInfoView(arg_10_0, arg_10_1)
	arg_10_1 = arg_10_1 or Activity188Model.instance:getLastCardId()
	arg_10_0._lastCardInfoUId = arg_10_1

	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardInfo)
	ViewMgr.instance:openView(ViewName.XugoujiCardInfoView, {
		cardId = arg_10_1
	})
end

function var_0_0.openGameResultView(arg_11_0, arg_11_1)
	if arg_11_0._isWaitingEventResult then
		arg_11_0._isWaitingGameResult = true

		return
	end

	arg_11_0._isWaitingGameResult = false

	arg_11_0:dispatchEvent(XugoujiEvent.OnOpenGameResultView)
	ViewMgr.instance:openView(ViewName.XugoujiGameResultView, arg_11_1)

	local var_11_0 = arg_11_0:getStatMo()
	local var_11_1 = arg_11_1.reason == XugoujiEnum.ResultEnum.Completed and 1 or 0
	local var_11_2 = Activity188Model.instance:getRound()
	local var_11_3 = Activity188Model.instance:getCurHP()
	local var_11_4 = Activity188Model.instance:getEnemyHP()
	local var_11_5 = Activity188Model.instance:getCurPairCount()
	local var_11_6 = Activity188Model.instance:getEnemyPairCount()

	var_11_0:setGameData(var_11_1, var_11_2, var_11_3, var_11_4, var_11_5, var_11_6)
	var_11_0:sendGameFinishStatData()
end

function var_0_0.enterEpisode(arg_12_0, arg_12_1)
	Activity188Model.instance:setCurActId(VersionActivity2_6Enum.ActivityId.Xugouji)

	arg_12_0._curEnterEpisode = arg_12_1

	Activity188Rpc.instance:sendAct188EnterEpisodeRequest(VersionActivity2_6Enum.ActivityId.Xugouji, arg_12_1, arg_12_0._onEnterGameReply, arg_12_0)
	Activity188Rpc.instance:SetEpisodePushCallback(arg_12_0._onEpisodeUpdate, arg_12_0)
end

function var_0_0._onEnterGameReply(arg_13_0)
	local var_13_0 = Activity188Config.instance:getEpisodeCfg(var_0_1, arg_13_0._curEnterEpisode).gameId
	local var_13_1 = Activity188Config.instance:getGameCfg(var_0_1, var_13_0)
	local var_13_2 = arg_13_0:getStatMo()

	var_13_2:reset()
	var_13_2:setBaseData(var_0_1, arg_13_0._curEnterEpisode)

	if var_13_1 then
		arg_13_0._lastCardInfoUId = -1

		XugoujiGameStepController.instance:clear()
		var_13_2:setBaseData(var_0_1, arg_13_0._curEnterEpisode, var_13_1.id)
	end

	Activity188Model.instance:setCurEpisodeId(arg_13_0._curEnterEpisode)
	arg_13_0:dispatchEvent(XugoujiEvent.EnterEpisode, arg_13_0._curEnterEpisode)
end

function var_0_0.restartEpisode(arg_14_0)
	Activity188Rpc.instance:sendAct188EnterEpisodeRequest(VersionActivity2_6Enum.ActivityId.Xugouji, arg_14_0._curEnterEpisode, arg_14_0._onRestartGameReply, arg_14_0)
	Activity188Rpc.instance:SetEpisodePushCallback(arg_14_0._onEpisodeUpdate, arg_14_0)
end

function var_0_0._onRestartGameReply(arg_15_0)
	local var_15_0 = Activity188Model.instance:getCurGameId()
	local var_15_1 = Activity188Config.instance:getGameCfg(var_0_1, var_15_0)

	Activity188Model.instance:setCurEpisodeId(arg_15_0._curEnterEpisode)
	XugoujiGameStepController.instance:clear()

	local var_15_2 = arg_15_0:getStatMo()

	var_15_2:reset()
	var_15_2:setBaseData(var_0_1, arg_15_0._curEnterEpisode, var_15_1.id)
	XugoujiGameStepController.instance:insertStepListClient({
		{
			stepType = XugoujiEnum.GameStepType.GameReStart
		},
		{
			stepType = XugoujiEnum.GameStepType.UpdateInitialCard
		}
	})
	arg_15_0:dispatchEvent(XugoujiEvent.GameRestart)
end

function var_0_0.finishStoryPlay(arg_16_0)
	local var_16_0 = Activity188Model.instance:getCurEpisodeId()

	Activity188Rpc.instance:sendAct188StoryRequest(VersionActivity2_6Enum.ActivityId.Xugouji, var_16_0, arg_16_0._onEpisodeUpdate, arg_16_0)
	var_0_0.instance:getStatMo():sendDungeonFinishStatData()
end

function var_0_0.selectCardItem(arg_17_0, arg_17_1)
	local var_17_0 = Activity188Model.instance:getCurTurnOperateTime()

	if var_17_0 == 0 then
		return
	end

	if Activity188Model.instance:isHpZero() then
		return
	end

	if arg_17_1 == Activity188Model.instance:getCurCardUid() then
		return
	end

	Activity188Model.instance:setCurTurnOperateTime(var_17_0 - 1, false)
	arg_17_0:dispatchEvent(XugoujiEvent.OperateTimeUpdated)
	Activity188Model.instance:setCurCardUid(arg_17_1)
	Activity188Rpc.instance:sendAct188ReverseCardRequest(var_0_1, arg_17_0._curEnterEpisode, arg_17_1, arg_17_0._onOperateCardReply, arg_17_0)
end

function var_0_0._onOperateCardReply(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = Activity188Model.instance:getCurCardUid()

	arg_18_0:dispatchEvent(XugoujiEvent.OperateCard, var_18_0)
end

function var_0_0.manualExitGame(arg_19_0)
	XugoujiGameStepController.instance:disposeAllStep()
	arg_19_0:dispatchEvent(XugoujiEvent.ManualExitGame)
end

function var_0_0.sendExitGameStat(arg_20_0)
	local var_20_0 = arg_20_0:getStatMo()
	local var_20_1 = Activity188Model.instance:getRound()
	local var_20_2 = Activity188Model.instance:getCurHP()
	local var_20_3 = Activity188Model.instance:getEnemyHP()
	local var_20_4 = Activity188Model.instance:getCurPairCount()
	local var_20_5 = Activity188Model.instance:getEnemyPairCount()

	var_20_0:setGameData(nil, var_20_1, var_20_2, var_20_3, var_20_4, var_20_5)
	var_20_0:sendGameGiveUpStatData()
	var_20_0:sendDungeonFinishStatData()
end

function var_0_0.gameResultOver(arg_21_0)
	arg_21_0:dispatchEvent(XugoujiEvent.ExitGame)
end

function var_0_0._onEpisodeUpdate(arg_22_0)
	arg_22_0:dispatchEvent(XugoujiEvent.EpisodeUpdate)
end

function var_0_0._checkCanPlayStory(arg_23_0, arg_23_1)
	if arg_23_1 and arg_23_1 ~= 0 and not StoryModel.instance:isStoryHasPlayed(arg_23_1) then
		return true
	end

	return false
end

function var_0_0.checkOptionChoosed(arg_24_0, arg_24_1)
	if not arg_24_0._optionDescRecord then
		arg_24_0._optionDescRecord = {}
		arg_24_0._optionDescRecordStr = ""
		arg_24_0._optionDescRecordStr = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_2LoperaOptionDesc, "")

		local var_24_0 = string.splitToNumber(arg_24_0._optionDescRecordStr, ",")

		for iter_24_0, iter_24_1 in pairs(var_24_0) do
			arg_24_0._optionDescRecord[iter_24_1] = true
		end
	end

	return arg_24_0._optionDescRecord[arg_24_1]
end

function var_0_0.saveOptionChoosed(arg_25_0, arg_25_1)
	arg_25_0._optionDescRecord[arg_25_1] = true

	if string.nilorempty(arg_25_0._optionDescRecordStr) then
		arg_25_0._optionDescRecordStr = arg_25_1
	else
		arg_25_0._optionDescRecordStr = arg_25_0._optionDescRecordStr .. "," .. arg_25_1
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_2LoperaOptionDesc, arg_25_0._optionDescRecordStr)
end

function var_0_0.getStatMo(arg_26_0)
	if not arg_26_0.statMo then
		arg_26_0.statMo = Activity188StatMo.New()
	end

	return arg_26_0.statMo
end

function var_0_0.setDebugMode(arg_27_0, arg_27_1)
	arg_27_0._debugMode = arg_27_1
end

function var_0_0.isDebugMode(arg_28_0)
	return arg_28_0._debugMode
end

var_0_0.instance = var_0_0.New()

return var_0_0
