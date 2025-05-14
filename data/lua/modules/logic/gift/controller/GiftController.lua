module("modules.logic.gift.controller.GiftController", package.seeall)

local var_0_0 = class("GiftController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.openGiftMultipleChoiceView(arg_5_0, arg_5_1, arg_5_2)
	ViewMgr.instance:openView(ViewName.GiftMultipleChoiceView, arg_5_1, arg_5_2)
end

function var_0_0.openOptionalGiftMultipleChoiceView(arg_6_0, arg_6_1, arg_6_2)
	ViewMgr.instance:openView(ViewName.OptionalGiftMultipleChoiceView, arg_6_1, arg_6_2)
end

function var_0_0.openGiftInsightHeroChoiceView(arg_7_0, arg_7_1)
	ViewMgr.instance:openView(ViewName.GiftInsightHeroChoiceView, arg_7_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
