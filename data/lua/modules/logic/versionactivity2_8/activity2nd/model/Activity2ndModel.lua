module("modules.logic.versionactivity2_8.activity2nd.model.Activity2ndModel", package.seeall)

local var_0_0 = class("Activity2ndModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._showTypeMechine = false
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._showTypeMechine = false
end

function var_0_0.changeShowTypeMechine(arg_3_0)
	arg_3_0._showTypeMechine = not arg_3_0._showTypeMechine
end

function var_0_0.getShowTypeMechine(arg_4_0)
	return arg_4_0._showTypeMechine
end

function var_0_0.cleanShowTypeMechine(arg_5_0)
	arg_5_0._showTypeMechine = false
end

function var_0_0.checkAnnualReviewShowRed(arg_6_0)
	return ActivityHelper.isOpen(Activity2ndEnum.ActivityId.AnnualReview) and GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Activity2ndAnnualReview, 0) == 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
