module("modules.logic.versionactivity1_2.yaxian.controller.game.state.YaXianStateNormal", package.seeall)

local var_0_0 = class("YaXianStateNormal", YaXianStateBase)

function var_0_0.start(arg_1_0)
	logNormal("YaXianStateNormal start")

	arg_1_0.stateType = YaXianGameEnum.GameStateType.Normal
end

function var_0_0.onClickPos(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = YaXianGameController.instance:getSelectedInteractItem()

	if var_2_0 and not var_2_0.delete and var_2_0:getHandler() then
		var_2_0:getHandler():onSelectPos(arg_2_1, arg_2_2)
	else
		logError("select obj missing!")
	end
end

return var_0_0
