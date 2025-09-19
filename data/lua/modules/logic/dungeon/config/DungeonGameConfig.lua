module("modules.logic.dungeon.config.DungeonGameConfig", package.seeall)

local var_0_0 = class("DungeonGameConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._dungeonMazeMapCfg = nil
	arg_1_0._dungeonMazeConstCfg = nil
	arg_1_0._dungeonMazeEventCfg = nil
	arg_1_0._jumpGameMapCfg = nil
	arg_1_0._jumpGameConstCfg = nil
	arg_1_0._jumpGameEventCfg = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"dungeon_maze",
		"dungeon_maze_event",
		"dungeon_maze_const",
		"dungeon_jump",
		"dungeon_jump_event",
		"dungeon_jump_const"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "dungeon_maze" then
		arg_3_0._dungeonMazeMapCfg = arg_3_2
	elseif arg_3_1 == "dungeon_maze_event" then
		arg_3_0._dungeonMazeEventCfg = arg_3_2
	elseif arg_3_1 == "dungeon_maze_const" then
		arg_3_0._dungeonMazeConstCfg = arg_3_2
	elseif arg_3_1 == "dungeon_jump" then
		arg_3_0._jumpGameMapCfg = arg_3_2
	elseif arg_3_1 == "dungeon_jump_event" then
		arg_3_0._jumpGameEventCfg = arg_3_2
	elseif arg_3_1 == "dungeon_jump_const" then
		arg_3_0._jumpGameConstCfg = arg_3_2
	end
end

function var_0_0.getJumpMap(arg_4_0, arg_4_1)
	return arg_4_0._jumpGameMapCfg.configDict[arg_4_1]
end

function var_0_0.getJumpGameEventCfg(arg_5_0, arg_5_1)
	return arg_5_0._jumpGameEventCfg.configDict[arg_5_1]
end

function var_0_0.getJumpGameConst(arg_6_0, arg_6_1)
	return arg_6_0._jumpGameConstCfg.configDict[arg_6_1]
end

function var_0_0.getMazeMap(arg_7_0, arg_7_1)
	return arg_7_0._dungeonMazeMapCfg.configDict[arg_7_1]
end

function var_0_0.getMazeEventCfg(arg_8_0, arg_8_1)
	return arg_8_0._dungeonMazeEventCfg.configDict[arg_8_1]
end

function var_0_0.getMazeGameConst(arg_9_0, arg_9_1)
	return arg_9_0._dungeonMazeConstCfg.configDict[arg_9_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
