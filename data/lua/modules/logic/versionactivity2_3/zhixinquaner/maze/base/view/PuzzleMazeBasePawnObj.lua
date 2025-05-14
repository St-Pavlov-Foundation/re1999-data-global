module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.view.PuzzleMazeBasePawnObj", package.seeall)

local var_0_0 = class("PuzzleMazeBasePawnObj", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
end

function var_0_0.onInit(arg_2_0, arg_2_1)
	arg_2_0._mo = arg_2_1
end

function var_0_0.onBeginDrag(arg_3_0)
	return
end

function var_0_0.onDraging(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:setPos(arg_4_1, arg_4_2)
end

function var_0_0.onEndDrag(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:setPos(arg_5_1, arg_5_2)
end

function var_0_0.setDir(arg_6_0, arg_6_1)
	arg_6_0.dir = arg_6_1
end

function var_0_0.getDir(arg_7_0)
	return arg_7_0.dir
end

function var_0_0.setPos(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.x = arg_8_1 or 0
	arg_8_0.y = arg_8_2 or 0
end

function var_0_0.getPos(arg_9_0)
	return arg_9_0.x or 0, arg_9_0.y or 0
end

function var_0_0.destroy(arg_10_0)
	arg_10_0:__onDispose()
end

return var_0_0
