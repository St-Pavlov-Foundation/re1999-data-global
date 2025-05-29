module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepSetHp", package.seeall)

local var_0_0 = class("XugoujiGameStepSetHp", XugoujiGameStepBase)

function var_0_0.start(arg_1_0)
	arg_1_0:finish()
end

function var_0_0.finish(arg_2_0)
	local var_2_0 = arg_2_0.originData.hp

	Activity188Model.instance:setHp(var_2_0)
	XugoujiController.instance:dispatchEvent(Va3ChessEvent.CurrentHpUpdate)
	var_0_0.super.finish(arg_2_0)
end

return var_0_0
