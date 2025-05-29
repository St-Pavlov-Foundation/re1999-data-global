module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepOperateNumUpdate", package.seeall)

local var_0_0 = class("XugoujiGameStepOperateNumUpdate", XugoujiGameStepBase)
local var_0_1 = VersionActivity2_6Enum.ActivityId.Xugouji

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0._stepData.remainReverseCount
	local var_1_1 = arg_1_0._stepData.isSelf

	Activity188Model.instance:setCurTurnOperateTime(var_1_0, not var_1_1)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.OperateTimeUpdated)

	if var_1_1 then
		Activity188Model.instance:setGameViewState(var_1_0 == 0 and XugoujiEnum.GameViewState.PlayerOperaDisplay or XugoujiEnum.GameViewState.PlayerOperating)
	else
		Activity188Model.instance:setGameViewState(var_1_0 == 0 and XugoujiEnum.GameViewState.EnemyOperaDisplay or XugoujiEnum.GameViewState.EnemyOperatingng)
	end

	arg_1_0:finish()
end

return var_0_0
