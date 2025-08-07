module("modules.logic.main.controller.work.Activity101SignMonthCardPatFaceWork", package.seeall)

local var_0_0 = class("Activity101SignMonthCardPatFaceWork", Activity101SignPatFaceWork)

function var_0_0.checkCanPat(arg_1_0)
	return (V2a9FreeMonthCardModel.instance:isCurDayCouldGet())
end

return var_0_0
