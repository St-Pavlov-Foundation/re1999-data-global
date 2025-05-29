module("modules.logic.versionactivity1_4.act136.view.Activity136MainBtnItem", package.seeall)

local var_0_0 = class("Activity136MainBtnItem", ActCenterItemBase)

function var_0_0.onOpen(arg_1_0)
	arg_1_0.redDot = RedDotController.instance:addNotEventRedDot(arg_1_0._goactivityreddot, Activity136Model.isShowRedDot, Activity136Model.instance)
end

function var_0_0.onRefresh(arg_2_0)
	local var_2_0 = arg_2_0:getMainActAtmosphereConfig()
	local var_2_1 = arg_2_0:isShowActivityEffect() and var_2_0.mainViewActBtnPrefix .. "icon_5" or "icon_5"

	UISpriteSetMgr.instance:setMainSprite(arg_2_0._imgitem, var_2_1, true)
	arg_2_0:_refreshRedDot()
end

function var_0_0.onAddEvent(arg_3_0)
	Activity136Controller.instance:registerCallback(Activity136Event.ActivityDataUpdate, arg_3_0.refreshRedDot, arg_3_0)
end

function var_0_0.onRemoveEvent(arg_4_0)
	Activity136Controller.instance:unregisterCallback(Activity136Event.ActivityDataUpdate, arg_4_0.refreshRedDot, arg_4_0)
end

function var_0_0.onClick(arg_5_0)
	Activity136Controller.instance:openActivity136View()
end

function var_0_0._refreshRedDot(arg_6_0)
	arg_6_0.redDot:refreshRedDot()
end

return var_0_0
