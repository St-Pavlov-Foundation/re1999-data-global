module("modules.logic.versionactivity2_4.pinball.entity.PinballNumShowEntity", package.seeall)

local var_0_0 = class("PinballNumShowEntity", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._trans = arg_1_1.transform
	arg_1_0._txtnum = gohelper.findChildTextMesh(arg_1_1, "#txt_num")

	TaskDispatcher.runDelay(arg_1_0.dispose, arg_1_0, 2)
end

function var_0_0.setType(arg_2_0, arg_2_1)
	arg_2_0._txtnum.text = arg_2_1
end

function var_0_0.setPos(arg_3_0, arg_3_1, arg_3_2)
	recthelper.setAnchor(arg_3_0._trans, arg_3_1, arg_3_2)
end

function var_0_0.dispose(arg_4_0)
	gohelper.destroy(arg_4_0.go)
end

function var_0_0.onDestroy(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.dispose, arg_5_0)
end

return var_0_0
