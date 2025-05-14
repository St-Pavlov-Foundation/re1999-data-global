module("modules.logic.dragonboat.controller.DragonBoatFestivalController", package.seeall)

local var_0_0 = class("DragonBoatFestivalController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0._checkActivityInfo(arg_4_0)
	return
end

function var_0_0.openQuestionTipView(arg_5_0, arg_5_1)
	ViewMgr.instance:openView(ViewName.DragonBoatFestivalQuestionTipView, arg_5_1)
end

function var_0_0.openDragonBoatFestivalView(arg_6_0)
	ViewMgr.instance:openView(ViewName.DragonBoatFestivalView)
end

var_0_0.instance = var_0_0.New()

return var_0_0
