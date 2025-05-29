module("modules.logic.versionactivity2_6.xugouji.model.Activity188StatMo", package.seeall)

local var_0_0 = pureTable("Activity188StatMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.beginTime = Time.realtimeSinceStartup
end

function var_0_0.reset(arg_2_0)
	arg_2_0.beginTime = Time.realtimeSinceStartup
	arg_2_0._actId, arg_2_0._gameId, arg_2_0.episdoeId, arg_2_0.result = nil
	arg_2_0._roundNum, arg_2_0._playerHp, arg_2_0._enemyHp, arg_2_0._playerPair, arg_2_0._enemyPair = nil
end

function var_0_0.setBaseData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0._actId = arg_3_1 and arg_3_1 or arg_3_0._actId
	arg_3_0._gameId = arg_3_3 and arg_3_3 or arg_3_0._gameId
	arg_3_0.episdoeId = arg_3_2 and arg_3_2 or arg_3_0.episdoeId
end

function var_0_0.setGameData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	arg_4_0.result = arg_4_1 and arg_4_1 or arg_4_0.result
	arg_4_0._roundNum = arg_4_2 and arg_4_2 or arg_4_0._roundNum
	arg_4_0._playerHp = arg_4_3 and arg_4_3 or arg_4_0._playerHp
	arg_4_0._enemyHp = arg_4_4 and arg_4_4 or arg_4_0._enemyHp
	arg_4_0._playerPair = arg_4_5 and arg_4_5 or arg_4_0._playerPair
	arg_4_0._enemyPair = arg_4_6 and arg_4_6 or arg_4_0._enemyPair
end

function var_0_0.sendDungeonFinishStatData(arg_5_0)
	StatController.instance:track(StatEnum.EventName.Act188DungeonFinish, {
		[StatEnum.EventProperties.ActivityId] = tostring(arg_5_0._actId),
		[StatEnum.EventProperties.EpisodeId] = tostring(arg_5_0.episdoeId),
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - arg_5_0.beginTime
	})
end

function var_0_0.sendGameFinishStatData(arg_6_0)
	local var_6_0 = {
		[StatEnum.EventProperties.RoundNum] = arg_6_0._roundNum,
		[StatEnum.EventProperties.Act188GamePlayerHp] = arg_6_0._playerHp,
		[StatEnum.EventProperties.Act188GameEnemyHp] = arg_6_0._enemyHp,
		[StatEnum.EventProperties.Act188GamePlayerPair] = arg_6_0._playerPair,
		[StatEnum.EventProperties.Act188GameEnemyPair] = arg_6_0._enemyPair
	}

	StatController.instance:track(StatEnum.EventName.Act188MapFinish, {
		[StatEnum.EventProperties.ActivityId] = tostring(arg_6_0._actId),
		[StatEnum.EventProperties.MapId] = tostring(arg_6_0._gameId),
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - arg_6_0.beginTime,
		[StatEnum.EventProperties.Result] = arg_6_0.result == 1 and "success" or "fail",
		[StatEnum.EventProperties.Act188GameObj] = var_6_0
	})
end

function var_0_0.sendGameGiveUpStatData(arg_7_0)
	local var_7_0 = {
		[StatEnum.EventProperties.RoundNum] = arg_7_0._roundNum,
		[StatEnum.EventProperties.Act188GamePlayerHp] = arg_7_0._playerHp,
		[StatEnum.EventProperties.Act188GameEnemyHp] = arg_7_0._enemyHp,
		[StatEnum.EventProperties.Act188GamePlayerPair] = arg_7_0._playerPair,
		[StatEnum.EventProperties.Act188GameEnemyPair] = arg_7_0._enemyPair
	}

	StatController.instance:track(StatEnum.EventName.Act188MapGiveUp, {
		[StatEnum.EventProperties.ActivityId] = tostring(arg_7_0._actId),
		[StatEnum.EventProperties.MapId] = tostring(arg_7_0._gameId),
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - arg_7_0.beginTime,
		[StatEnum.EventProperties.Act188GameObj] = var_7_0
	})
end

return var_0_0
