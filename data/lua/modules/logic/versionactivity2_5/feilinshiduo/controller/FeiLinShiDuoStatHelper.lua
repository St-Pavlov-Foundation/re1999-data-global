module("modules.logic.versionactivity2_5.feilinshiduo.controller.FeiLinShiDuoStatHelper", package.seeall)

local var_0_0 = class("FeiLinShiDuoStatHelper")

function var_0_0.ctor(arg_1_0)
	arg_1_0.gameStartTime = 0
	arg_1_0.resetStartTime = 0
	arg_1_0.episodeStartTime = 0
	arg_1_0.curEpisodeId = 0
end

function var_0_0.initGameStartTime(arg_2_0)
	arg_2_0.gameStartTime = UnityEngine.Time.realtimeSinceStartup
end

function var_0_0.initResetStartTime(arg_3_0)
	arg_3_0.resetStartTime = UnityEngine.Time.realtimeSinceStartup
end

function var_0_0.initEpisodeStartTime(arg_4_0, arg_4_1)
	arg_4_0.curEpisodeId = arg_4_1
	arg_4_0.episodeStartTime = UnityEngine.Time.realtimeSinceStartup
end

function var_0_0.setSceneInfo(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = FeiLinShiDuoGameModel.instance:getElementMap()[FeiLinShiDuoEnum.ObjectType.Box]
	local var_5_2 = {}

	var_5_2.id = 0
	var_5_2.x = arg_5_1.transform.localPosition.x
	var_5_2.y = arg_5_1.transform.localPosition.y

	table.insert(var_5_0, var_5_2)

	for iter_5_0, iter_5_1 in pairs(var_5_1) do
		local var_5_3 = {
			id = iter_5_1.id,
			x = iter_5_1.pos[1],
			y = iter_5_1.pos[2]
		}

		table.insert(var_5_0, var_5_3)
	end

	table.sort(var_5_0, function(arg_6_0, arg_6_1)
		return arg_6_0.id < arg_6_1.id
	end)

	return var_5_0
end

function var_0_0.sendExitGameMap(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0 = arg_7_0:setSceneInfo(arg_7_1)

	StatController.instance:track(StatEnum.EventName.Act185MapExit, {
		[StatEnum.EventProperties.FeiLinShiDuo_ActId] = tostring(FeiLinShiDuoModel.instance:getCurActId()),
		[StatEnum.EventProperties.FeiLinShiDuo_MapId] = tostring(FeiLinShiDuoGameModel.instance:getCurMapId()),
		[StatEnum.EventProperties.FeiLinShiDuo_UseTime] = UnityEngine.Time.realtimeSinceStartup - arg_7_0.gameStartTime,
		[StatEnum.EventProperties.FeiLinShiDuo_IsBlindness] = FeiLinShiDuoGameModel.instance:getBlindnessModeState(),
		[StatEnum.EventProperties.FeiLinShiDuo_SceneInfo] = var_7_0
	})
end

function var_0_0.sendResetGameMap(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return
	end

	local var_8_0 = arg_8_0:setSceneInfo(arg_8_1)

	StatController.instance:track(StatEnum.EventName.Act185MapReset, {
		[StatEnum.EventProperties.FeiLinShiDuo_ActId] = tostring(FeiLinShiDuoModel.instance:getCurActId()),
		[StatEnum.EventProperties.FeiLinShiDuo_MapId] = tostring(FeiLinShiDuoGameModel.instance:getCurMapId()),
		[StatEnum.EventProperties.FeiLinShiDuo_UseTime] = UnityEngine.Time.realtimeSinceStartup - arg_8_0.resetStartTime,
		[StatEnum.EventProperties.FeiLinShiDuo_IsBlindness] = FeiLinShiDuoGameModel.instance:getBlindnessModeState(),
		[StatEnum.EventProperties.FeiLinShiDuo_SceneInfo] = var_8_0
	})
	arg_8_0:initResetStartTime()
end

function var_0_0.sendMapFinish(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	local var_9_0 = arg_9_0:setSceneInfo(arg_9_1)

	StatController.instance:track(StatEnum.EventName.Act185MapFinish, {
		[StatEnum.EventProperties.FeiLinShiDuo_ActId] = tostring(FeiLinShiDuoModel.instance:getCurActId()),
		[StatEnum.EventProperties.FeiLinShiDuo_MapId] = tostring(FeiLinShiDuoGameModel.instance:getCurMapId()),
		[StatEnum.EventProperties.FeiLinShiDuo_UseTime] = UnityEngine.Time.realtimeSinceStartup - arg_9_0.gameStartTime,
		[StatEnum.EventProperties.FeiLinShiDuo_IsBlindness] = FeiLinShiDuoGameModel.instance:getBlindnessModeState(),
		[StatEnum.EventProperties.FeiLinShiDuo_SceneInfo] = var_9_0
	})
end

function var_0_0.sendDungeonFinish(arg_10_0)
	StatController.instance:track(StatEnum.EventName.Act185DungeonFinish, {
		[StatEnum.EventProperties.FeiLinShiDuo_EpisodeId] = arg_10_0.curEpisodeId,
		[StatEnum.EventProperties.FeiLinShiDuo_EpisodeUseTime] = UnityEngine.Time.realtimeSinceStartup - arg_10_0.episodeStartTime
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
