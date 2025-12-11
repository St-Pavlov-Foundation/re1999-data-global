module("modules.logic.versionactivity3_1.yeshumei.controller.YeShuMeiStatHelper", package.seeall)

local var_0_0 = class("YeShuMeiStatHelper")

function var_0_0.ctor(arg_1_0)
	arg_1_0.episodeId = "0"
end

function var_0_0.enterGame(arg_2_0)
	arg_2_0.gameStartTime = UnityEngine.Time.realtimeSinceStartup
end

function var_0_0.sendGameFinish(arg_3_0)
	StatController.instance:track(StatEnum.EventName.ExitYeShuMei, {
		[StatEnum.EventProperties.EpisodeId] = tostring(YeShuMeiModel.instance:getCurEpisode()),
		[StatEnum.EventProperties.Result] = StatEnum.Result2Cn[StatEnum.Result.Success],
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - arg_3_0.gameStartTime,
		[StatEnum.EventProperties.GoalNum] = YeShuMeiGameModel.instance:getCompleteLevelNum()
	})
end

function var_0_0.sendGameAbort(arg_4_0)
	StatController.instance:track(StatEnum.EventName.ExitYeShuMei, {
		[StatEnum.EventProperties.EpisodeId] = tostring(YeShuMeiModel.instance:getCurEpisode()),
		[StatEnum.EventProperties.Result] = StatEnum.Result2Cn[StatEnum.Result.Abort],
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - arg_4_0.gameStartTime,
		[StatEnum.EventProperties.GoalNum] = YeShuMeiGameModel.instance:getCompleteLevelNum()
	})
end

function var_0_0.sendGameReset(arg_5_0)
	StatController.instance:track(StatEnum.EventName.ExitYeShuMei, {
		[StatEnum.EventProperties.EpisodeId] = tostring(YeShuMeiModel.instance:getCurEpisode()),
		[StatEnum.EventProperties.Result] = StatEnum.Result2Cn[StatEnum.Result.Reset],
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - arg_5_0.gameStartTime,
		[StatEnum.EventProperties.GoalNum] = YeShuMeiGameModel.instance:getCompleteLevelNum()
	})
	arg_5_0:enterGame()
end

var_0_0.instance = var_0_0.New()

return var_0_0
