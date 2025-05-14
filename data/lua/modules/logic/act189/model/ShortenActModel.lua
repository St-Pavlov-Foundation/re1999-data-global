module("modules.logic.act189.model.ShortenActModel", package.seeall)

local var_0_0 = class("ShortenActModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.getActivityId(arg_3_0)
	return ShortenActConfig.instance:getActivityId()
end

function var_0_0.isClaimable(arg_4_0)
	return Activity189Model.instance:isClaimable(arg_4_0:getActivityId())
end

var_0_0.instance = var_0_0.New()

return var_0_0
