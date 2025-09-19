module("modules.logic.dungeon.model.DungeonGameMo", package.seeall)

local var_0_0 = pureTable("DungeonGameMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.beginTime = Time.realtimeSinceStartup
end

function var_0_0.sendMazeGameStatData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	StatController.instance:track(StatEnum.EventName.DungeonMazeGame, {
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - arg_2_0.beginTime,
		[StatEnum.EventProperties.Result] = arg_2_1,
		[StatEnum.EventProperties.DungeonMazeCellId] = tostring(arg_2_2),
		[StatEnum.EventProperties.DungeonMazeChaosValue] = arg_2_3
	})
end

function var_0_0.sendJumpGameStatData(arg_3_0, arg_3_1, arg_3_2)
	StatController.instance:track(StatEnum.EventName.DungeonJumpGame, {
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - arg_3_0.beginTime,
		[StatEnum.EventProperties.Result] = arg_3_1,
		[StatEnum.EventProperties.DungeonMazeCellId] = tostring(arg_3_2)
	})
end

return var_0_0
