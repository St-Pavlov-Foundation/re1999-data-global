module("modules.logic.versionactivity2_8.act197.controller.Activity197Controller", package.seeall)

local var_0_0 = class("Activity197Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._cachePopupViewList = {}
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.openView(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	return
end

function var_0_0.reInit(arg_5_0)
	arg_5_0:onInit()
end

function var_0_0.setRummageReward(arg_6_0, arg_6_1, arg_6_2)
	table.insert(arg_6_0._cachePopupViewList, 1, {
		viewName = arg_6_1,
		param = arg_6_2
	})
end

function var_0_0.popupRewardView(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._cachePopupViewList) do
		if iter_7_1.viewName == ViewName.CommonPropView then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, iter_7_1.viewName, iter_7_1.param)
		end
	end

	tabletool.clear(arg_7_0._cachePopupViewList)
end

var_0_0.instance = var_0_0.New()

return var_0_0
