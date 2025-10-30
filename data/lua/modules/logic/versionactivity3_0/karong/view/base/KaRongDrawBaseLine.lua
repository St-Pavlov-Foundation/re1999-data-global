module("modules.logic.versionactivity3_0.karong.view.base.KaRongDrawBaseLine", package.seeall)

local var_0_0 = class("KaRongDrawBaseLine", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
end

function var_0_0.onInit(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.x1, arg_2_0.y1, arg_2_0.x2, arg_2_0.y2 = arg_2_1, arg_2_2, arg_2_3, arg_2_4

	local var_2_0 = KaRongDrawHelper.getFromToDir(arg_2_1, arg_2_2, arg_2_3, arg_2_4)

	arg_2_0:setDir(var_2_0)
end

function var_0_0.onCrossFull(arg_3_0, arg_3_1)
	arg_3_0:setDir(arg_3_1)
	arg_3_0:setProgress(1)
end

function var_0_0.onCrossHalf(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:setDir(arg_4_1)
	arg_4_0:setProgress(arg_4_2)
end

function var_0_0.onAlert(arg_5_0, arg_5_1)
	return
end

function var_0_0.setProgress(arg_6_0, arg_6_1)
	arg_6_0.progress = arg_6_1 or 0
end

function var_0_0.getProgress(arg_7_0)
	return arg_7_0.progress or 0
end

function var_0_0.setDir(arg_8_0, arg_8_1)
	arg_8_0.dir = arg_8_1
end

function var_0_0.getDir(arg_9_0)
	return arg_9_0.dir
end

function var_0_0.clear(arg_10_0)
	arg_10_0:setProgress(0)

	arg_10_0.dir = nil
end

function var_0_0.destroy(arg_11_0)
	gohelper.destroy(arg_11_0.go)
	arg_11_0:__onDispose()
end

return var_0_0
