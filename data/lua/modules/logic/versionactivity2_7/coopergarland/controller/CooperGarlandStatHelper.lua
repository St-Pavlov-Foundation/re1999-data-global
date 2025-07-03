module("modules.logic.versionactivity2_7.coopergarland.controller.CooperGarlandStatHelper", package.seeall)

local var_0_0 = class("CooperGarlandStatHelper")

function var_0_0.ctor(arg_1_0)
	arg_1_0.episodeId = "0"
	arg_1_0.failCount = 0
	arg_1_0.resetCount = 0
	arg_1_0.mapResetCount = 0
	arg_1_0.episodeStartTime = 0
	arg_1_0.gameStartTime = 0
	arg_1_0.mapStartTime = 0
	arg_1_0.resetStartTime = 0
end

function var_0_0.enterEpisode(arg_2_0, arg_2_1)
	arg_2_0.episodeId = tostring(arg_2_1)
	arg_2_0.episodeStartTime = UnityEngine.Time.realtimeSinceStartup
end

function var_0_0.enterGame(arg_3_0)
	arg_3_0.failCount = 0
	arg_3_0.resetCount = 0
	arg_3_0.gameStartTime = UnityEngine.Time.realtimeSinceStartup
end

function var_0_0.setupMap(arg_4_0)
	arg_4_0.mapResetCount = 0
	arg_4_0.mapStartTime = UnityEngine.Time.realtimeSinceStartup
	arg_4_0.resetStartTime = UnityEngine.Time.realtimeSinceStartup
end

function var_0_0.sendEpisodeFinish(arg_5_0)
	StatController.instance:track(StatEnum.EventName.Act192DungeonFinish, {
		[StatEnum.EventProperties.CooperGarland_ActId] = tostring(CooperGarlandModel.instance:getAct192Id()),
		[StatEnum.EventProperties.CooperGarland_EpisodeId] = arg_5_0.episodeId,
		[StatEnum.EventProperties.CooperGarland_UseTime] = UnityEngine.Time.realtimeSinceStartup - arg_5_0.episodeStartTime
	})
end

function var_0_0.sendGameFinish(arg_6_0)
	StatController.instance:track(StatEnum.EventName.Act192GameFinish, {
		[StatEnum.EventProperties.CooperGarland_ActId] = tostring(CooperGarlandModel.instance:getAct192Id()),
		[StatEnum.EventProperties.CooperGarland_EpisodeId] = arg_6_0.episodeId,
		[StatEnum.EventProperties.CooperGarland_GameId] = CooperGarlandGameModel.instance:getGameId(),
		[StatEnum.EventProperties.CooperGarland_IsJoystick] = CooperGarlandGameModel.instance:getIsJoystick(),
		[StatEnum.EventProperties.CooperGarland_UseTime] = UnityEngine.Time.realtimeSinceStartup - arg_6_0.gameStartTime,
		[StatEnum.EventProperties.CooperGarland_FailTimes] = arg_6_0.failCount,
		[StatEnum.EventProperties.CooperGarland_ResetTimes] = arg_6_0.resetCount
	})
end

function var_0_0.sendGameExit(arg_7_0, arg_7_1)
	StatController.instance:track(StatEnum.EventName.Act192GameExit, {
		[StatEnum.EventProperties.CooperGarland_ActId] = tostring(CooperGarlandModel.instance:getAct192Id()),
		[StatEnum.EventProperties.CooperGarland_EpisodeId] = arg_7_0.episodeId,
		[StatEnum.EventProperties.CooperGarland_GameId] = CooperGarlandGameModel.instance:getGameId(),
		[StatEnum.EventProperties.CooperGarland_IsJoystick] = CooperGarlandGameModel.instance:getIsJoystick(),
		[StatEnum.EventProperties.CooperGarland_BrowseTime] = UnityEngine.Time.realtimeSinceStartup - arg_7_0.episodeStartTime,
		[StatEnum.EventProperties.CooperGarland_UseTime] = UnityEngine.Time.realtimeSinceStartup - arg_7_0.gameStartTime,
		[StatEnum.EventProperties.CooperGarland_FailTimes] = arg_7_0.failCount,
		[StatEnum.EventProperties.CooperGarland_ResetTimes] = arg_7_0.resetCount,
		[StatEnum.EventProperties.CooperGarland_MapUseTime] = UnityEngine.Time.realtimeSinceStartup - arg_7_0.mapStartTime,
		[StatEnum.EventProperties.CooperGarland_MapId] = CooperGarlandGameModel.instance:getMapId(),
		[StatEnum.EventProperties.CooperGarland_From] = arg_7_1
	})
end

function var_0_0.sendMapArrive(arg_8_0)
	StatController.instance:track(StatEnum.EventName.Act192MapArrive, {
		[StatEnum.EventProperties.CooperGarland_ActId] = tostring(CooperGarlandModel.instance:getAct192Id()),
		[StatEnum.EventProperties.CooperGarland_EpisodeId] = arg_8_0.episodeId,
		[StatEnum.EventProperties.CooperGarland_GameId] = CooperGarlandGameModel.instance:getGameId(),
		[StatEnum.EventProperties.CooperGarland_IsJoystick] = CooperGarlandGameModel.instance:getIsJoystick(),
		[StatEnum.EventProperties.CooperGarland_MapId] = CooperGarlandGameModel.instance:getMapId(),
		[StatEnum.EventProperties.CooperGarland_MapUseTime] = UnityEngine.Time.realtimeSinceStartup - arg_8_0.mapStartTime,
		[StatEnum.EventProperties.CooperGarland_RemoveComp] = CooperGarlandGameEntityMgr.instance:getRemoveCompList(),
		[StatEnum.EventProperties.CooperGarland_MapResetTimes] = arg_8_0.mapResetCount
	})
end

function var_0_0.sendMapFail(arg_9_0, arg_9_1)
	arg_9_0.failCount = arg_9_0.failCount + 1

	StatController.instance:track(StatEnum.EventName.Act192MapFail, {
		[StatEnum.EventProperties.CooperGarland_ActId] = tostring(CooperGarlandModel.instance:getAct192Id()),
		[StatEnum.EventProperties.CooperGarland_EpisodeId] = arg_9_0.episodeId,
		[StatEnum.EventProperties.CooperGarland_GameId] = CooperGarlandGameModel.instance:getGameId(),
		[StatEnum.EventProperties.CooperGarland_IsJoystick] = CooperGarlandGameModel.instance:getIsJoystick(),
		[StatEnum.EventProperties.CooperGarland_CompId] = arg_9_1,
		[StatEnum.EventProperties.CooperGarland_MapId] = CooperGarlandGameModel.instance:getMapId(),
		[StatEnum.EventProperties.CooperGarland_UseTime] = UnityEngine.Time.realtimeSinceStartup - arg_9_0.gameStartTime,
		[StatEnum.EventProperties.CooperGarland_MapUseTime] = UnityEngine.Time.realtimeSinceStartup - arg_9_0.mapStartTime,
		[StatEnum.EventProperties.CooperGarland_ResetUseTime] = UnityEngine.Time.realtimeSinceStartup - arg_9_0.resetStartTime,
		[StatEnum.EventProperties.CooperGarland_RemoveComp] = CooperGarlandGameEntityMgr.instance:getRemoveCompList()
	})
end

function var_0_0.sendMapReset(arg_10_0, arg_10_1)
	arg_10_0.resetCount = arg_10_0.resetCount + 1
	arg_10_0.mapResetCount = arg_10_0.mapResetCount + 1

	StatController.instance:track(StatEnum.EventName.Act192MapReset, {
		[StatEnum.EventProperties.CooperGarland_ActId] = tostring(CooperGarlandModel.instance:getAct192Id()),
		[StatEnum.EventProperties.CooperGarland_EpisodeId] = arg_10_0.episodeId,
		[StatEnum.EventProperties.CooperGarland_GameId] = CooperGarlandGameModel.instance:getGameId(),
		[StatEnum.EventProperties.CooperGarland_IsJoystick] = CooperGarlandGameModel.instance:getIsJoystick(),
		[StatEnum.EventProperties.CooperGarland_MapId] = CooperGarlandGameModel.instance:getMapId(),
		[StatEnum.EventProperties.CooperGarland_UseTime] = UnityEngine.Time.realtimeSinceStartup - arg_10_0.gameStartTime,
		[StatEnum.EventProperties.CooperGarland_MapUseTime] = UnityEngine.Time.realtimeSinceStartup - arg_10_0.mapStartTime,
		[StatEnum.EventProperties.CooperGarland_ResetUseTime] = UnityEngine.Time.realtimeSinceStartup - arg_10_0.resetStartTime,
		[StatEnum.EventProperties.CooperGarland_RemoveComp] = CooperGarlandGameEntityMgr.instance:getRemoveCompList(),
		[StatEnum.EventProperties.CooperGarland_From] = arg_10_1
	})

	arg_10_0.resetStartTime = UnityEngine.Time.realtimeSinceStartup
end

var_0_0.instance = var_0_0.New()

return var_0_0
