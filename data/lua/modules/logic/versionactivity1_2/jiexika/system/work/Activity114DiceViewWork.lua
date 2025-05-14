module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114DiceViewWork", package.seeall)

local var_0_0 = class("Activity114DiceViewWork", Activity114OpenViewWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if arg_1_0.context.diceResult then
		arg_1_0._viewName = ViewName.Activity114DiceView

		var_0_0.super.onStart(arg_1_0, arg_1_1)
	else
		arg_1_0:onDone(true)
	end
end

return var_0_0
