module("modules.logic.versionactivity1_2.yaxian.controller.game.state.YaXianStateLock", package.seeall)

local var_0_0 = class("YaXianStateLock", YaXianStateBase)

function var_0_0.start(arg_1_0)
	logNormal("YaXianStateLock start")

	arg_1_0.stateType = YaXianGameEnum.GameStateType.Lock
end

function var_0_0.onClickPos(arg_2_0, arg_2_1, arg_2_2)
	logNormal("status YaXianStateLock")
end

return var_0_0
