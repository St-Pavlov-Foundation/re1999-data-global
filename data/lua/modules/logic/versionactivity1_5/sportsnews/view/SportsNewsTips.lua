module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsTips", package.seeall)

local var_0_0 = class("SportsNewsTips", ActivityWarmUpTips)

function var_0_0.onOpen(arg_1_0)
	var_0_0.super.onOpen(arg_1_0)

	local var_1_0 = arg_1_0.viewParam.orderId
	local var_1_1 = arg_1_0.viewParam.actId

	SportsNewsModel.instance:onReadEnd(var_1_1, var_1_0)
end

return var_0_0
