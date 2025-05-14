module("modules.logic.explore.controller.steps.ExploreAddMaterialStep", package.seeall)

local var_0_0 = class("ExploreAddMaterialStep", ExploreStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = {}

	for iter_1_0 = 1, #arg_1_0._data.materialData do
		var_1_0[iter_1_0] = cjson.decode(arg_1_0._data.materialData[iter_1_0])
	end

	ExploreController.instance:addItem(var_1_0)

	if PopupController.instance:getPopupCount() > 0 or ViewMgr.instance:isOpen(ViewName.ExploreGetItemView) or ViewMgr.instance:isOpen(ViewName.CommonPropView) then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0.checkHavePopup, arg_1_0)
	else
		arg_1_0:onDone()
	end
end

function var_0_0.checkHavePopup(arg_2_0)
	if PopupController.instance:getPopupCount() > 0 or ViewMgr.instance:isOpen(ViewName.ExploreGetItemView) or ViewMgr.instance:isOpen(ViewName.CommonPropView) then
		-- block empty
	else
		arg_2_0:onDone()
	end
end

function var_0_0.onDestory(arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0.checkHavePopup, arg_3_0)
	var_0_0.super.onDestory(arg_3_0)
end

return var_0_0
