module("modules.logic.activity.view.LinkageActivity_Page1", package.seeall)

local var_0_0 = class("LinkageActivity_Page1", LinkageActivity_PageBase)

function var_0_0.ctor(arg_1_0, ...)
	var_0_0.super.ctor(arg_1_0, ...)
end

function var_0_0.getDurationTimeStr(arg_2_0)
	local var_2_0 = arg_2_0:getLinkageActivityCO()

	return StoreController.instance:getRecommendStoreTime(var_2_0)
end

return var_0_0
