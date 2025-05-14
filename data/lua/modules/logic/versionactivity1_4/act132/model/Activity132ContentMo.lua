module("modules.logic.versionactivity1_4.act132.model.Activity132ContentMo", package.seeall)

local var_0_0 = class("Activity132ContentMo")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.activityId = arg_1_1.activityId
	arg_1_0.contentId = arg_1_1.contentId
	arg_1_0.content = arg_1_1.content
	arg_1_0.condition = arg_1_1.condition
	arg_1_0.unlockDesc = arg_1_1.unlockDesc
	arg_1_0._cfg = arg_1_1
end

function var_0_0.getUnlockDesc(arg_2_0)
	return arg_2_0._cfg.unlockDesc
end

function var_0_0.getContent(arg_3_0)
	return arg_3_0._cfg.content
end

return var_0_0
