module("modules.logic.versionactivity3_1.yeshumei.controller.YeShuMeiGameController", package.seeall)

local var_0_0 = class("YeShuMeiGameController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	return
end

function var_0_0.enterGame(arg_5_0, arg_5_1)
	arg_5_0:reInit()

	arg_5_0.episodeId = arg_5_1
	arg_5_0._episodeconfig = YeShuMeiConfig.instance:getYeShuMeiEpisodeConfigById(VersionActivity3_1Enum.ActivityId.YeShuMei, arg_5_1)

	local var_5_0 = arg_5_0._episodeconfig.gameId
	local var_5_1 = YeShuMeiModel.instance:getEpisodeIndex(arg_5_1)

	YeShuMeiModel.instance:setCurEpisode(var_5_1, arg_5_1)
	arg_5_0:reallyEnterGame(var_5_0)
end

function var_0_0.reallyEnterGame(arg_6_0, arg_6_1)
	YeShuMeiGameModel.instance:initGameData(arg_6_1)
	YeShuMeiStatHelper.instance:enterGame()
	ViewMgr.instance:openView(ViewName.YeShuMeiGameView, arg_6_0.episodeId)
end

function var_0_0.restartGame(arg_7_0)
	arg_7_0:reInit()

	local var_7_0 = YeShuMeiGameModel.instance:getCurGameId()

	YeShuMeiGameModel.instance:clear()
	YeShuMeiGameModel.instance:initGameData(var_7_0)
end

function var_0_0.finishGame(arg_8_0)
	ViewMgr.instance:openView(ViewName.YeShuMeiResultView)
end

function var_0_0.reInit(arg_9_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
