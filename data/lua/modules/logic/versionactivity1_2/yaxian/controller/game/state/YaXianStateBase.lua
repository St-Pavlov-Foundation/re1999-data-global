module("modules.logic.versionactivity1_2.yaxian.controller.game.state.YaXianStateBase", package.seeall)

local var_0_0 = class("YaXianStateBase")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.originData = arg_1_1
end

function var_0_0.start(arg_2_0)
	arg_2_0.stateType = nil
end

function var_0_0.onClickPos(arg_3_0, arg_3_1, arg_3_2)
	return
end

function var_0_0.getStateType(arg_4_0)
	return arg_4_0.stateType
end

function var_0_0.dispose(arg_5_0)
	return
end

return var_0_0
