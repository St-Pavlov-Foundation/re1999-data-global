module("modules.logic.versionactivity2_8.activity2nd.view.Activity2ndBtnItem", package.seeall)

local var_0_0 = class("Activity2ndBtnItem", ActCenterItemBase)

function var_0_0.onOpen(arg_1_0)
	arg_1_0:_addNotEventRedDot(arg_1_0._checkRed, arg_1_0)
end

function var_0_0.onInit(arg_2_0)
	arg_2_0:refresh()
end

function var_0_0.onRefresh(arg_3_0)
	local var_3_0 = ActivityModel.showActivityEffect()
	local var_3_1 = ActivityConfig.instance:getMainActAtmosphereConfig()
	local var_3_2 = var_3_0 and var_3_1.mainViewActBtnPrefix .. "icon_7" or "act_icon_7"

	if not var_3_0 then
		local var_3_3 = ActivityConfig.instance:getMainActAtmosphereConfig()

		if var_3_3 then
			for iter_3_0, iter_3_1 in ipairs(var_3_3.mainViewActBtn) do
				local var_3_4 = gohelper.findChild(arg_3_0.go, iter_3_1)

				if var_3_4 then
					gohelper.setActive(var_3_4, var_3_0)
				end
			end
		end
	end

	arg_3_0:_setMainSprite(var_3_2)
end

function var_0_0.onAddEvent(arg_4_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateFriendInfoDot, arg_4_0.refreshDot, arg_4_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, arg_4_0.refreshDot, arg_4_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, arg_4_0.refreshDot, arg_4_0)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, arg_4_0.refreshDot, arg_4_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_4_0.refreshDot, arg_4_0)
end

function var_0_0.onRemoveEvent(arg_5_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateFriendInfoDot, arg_5_0.refreshDot, arg_5_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, arg_5_0.refreshDot, arg_5_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, arg_5_0.refreshDot, arg_5_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, arg_5_0.refreshDot, arg_5_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_5_0.refreshDot, arg_5_0)
end

function var_0_0.onClick(arg_6_0)
	Activity2ndController.instance:enterActivity2ndMainView()
end

function var_0_0._checkRed(arg_7_0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Activity2ndEnter, 0) then
		return true
	end

	if Activity2ndModel.instance:checkAnnualReviewShowRed() then
		return true
	end

	return false
end

function var_0_0.refreshDot(arg_8_0)
	arg_8_0:_refreshRedDot()
end

return var_0_0
