module("modules.logic.explore.map.unit.ExploreBagItemRewardUnit", package.seeall)

local var_0_0 = class("ExploreBagItemRewardUnit", ExploreBaseDisplayUnit)

function var_0_0.needInteractAnim(arg_1_0)
	return true
end

function var_0_0.playAnim(arg_2_0, arg_2_1)
	if arg_2_1 == ExploreAnimEnum.AnimName.exit then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0.checkHavePopup, arg_2_0)
	else
		var_0_0.super.playAnim(arg_2_0, arg_2_1)
	end
end

function var_0_0.checkHavePopup(arg_3_0)
	if PopupController.instance:getPopupCount() > 0 or ViewMgr.instance:isOpen(ViewName.ExploreGetItemView) or ViewMgr.instance:isOpen(ViewName.CommonPropView) then
		return true
	else
		arg_3_0:onPopupEnd()
	end
end

function var_0_0.onPopupEnd(arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_4_0.checkHavePopup, arg_4_0)
	arg_4_0.animComp:playAnim(ExploreAnimEnum.AnimName.exit)
end

function var_0_0.onDestroy(arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_5_0.checkHavePopup, arg_5_0)
	var_0_0.super.onDestroy(arg_5_0)
end

return var_0_0
