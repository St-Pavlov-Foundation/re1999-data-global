module("modules.logic.sp01.linkgift.view.V2a9_LinkGiftViewContainer", package.seeall)

local var_0_0 = class("V2a9_LinkGiftViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, V2a9_LinkGiftView.New())

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0
