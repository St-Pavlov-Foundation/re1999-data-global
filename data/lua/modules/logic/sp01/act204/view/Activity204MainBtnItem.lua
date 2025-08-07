module("modules.logic.sp01.act204.view.Activity204MainBtnItem", package.seeall)

local var_0_0 = class("Activity204MainBtnItem", ActCenterItemBase)

function var_0_0.onAddEvent(arg_1_0)
	gohelper.addUIClickAudio(arg_1_0._btnitem)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateFriendInfoDot, arg_1_0.refreshDot, arg_1_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, arg_1_0.refreshDot, arg_1_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, arg_1_0.refreshDot, arg_1_0)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, arg_1_0.refreshDot, arg_1_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_1_0.refreshDot, arg_1_0)
	Activity204Controller.instance:registerCallback(Activity204Event.UpdateTask, arg_1_0.refreshDot, arg_1_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_1_0.onDailyRefresh, arg_1_0)
end

function var_0_0.onRemoveEvent(arg_2_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, arg_2_0.refreshDot, arg_2_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateFriendInfoDot, arg_2_0.refreshDot, arg_2_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, arg_2_0.refreshDot, arg_2_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, arg_2_0.refreshDot, arg_2_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_2_0.refreshDot, arg_2_0)
	Activity204Controller.instance:unregisterCallback(Activity204Event.UpdateTask, arg_2_0.refreshDot, arg_2_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_2_0.onDailyRefresh, arg_2_0)
end

function var_0_0.onClick(arg_3_0)
	local var_3_0 = arg_3_0:onGetActId()
	local var_3_1, var_3_2 = arg_3_0:onGetViewNameAndParam()

	Activity204Controller.instance:jumpToActivity(var_3_0, var_3_2)
end

function var_0_0.refreshData(arg_4_0)
	local var_4_0 = ActivityEnum.Activity.V2a9_ActCollection
	local var_4_1 = {
		viewName = ViewName.Act130517View,
		viewParam = {
			actId = var_4_0,
			entranceIds = Activity204Enum.EntranceIdList
		}
	}

	arg_4_0:setCustomData(var_4_1)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:refreshData()
	arg_5_0:_initOceanRedDot()
	arg_5_0:_addNotEventRedDot(arg_5_0._checkRed, arg_5_0)
end

function var_0_0._checkRed(arg_6_0)
	local var_6_0 = arg_6_0:onGetActId()
	local var_6_1 = ActivityConfig.instance:getActivityRedDotId(var_6_0)

	return RedDotModel.instance:isDotShow(var_6_1, 0) or Activity204Model.instance:hasNewTask()
end

function var_0_0.onRefresh(arg_7_0)
	arg_7_0:refreshData()

	local var_7_0 = ActivityModel.showActivityEffect()
	local var_7_1 = ActivityConfig.instance:getMainActAtmosphereConfig()
	local var_7_2 = var_7_0 and var_7_1.mainViewActBtnPrefix .. "icon_6" or "icon_6"

	if not var_7_0 then
		local var_7_3 = ActivityConfig.instance:getMainActAtmosphereConfig()

		if var_7_3 then
			for iter_7_0, iter_7_1 in ipairs(var_7_3.mainViewActBtn) do
				local var_7_4 = gohelper.findChild(arg_7_0.go, iter_7_1)

				if var_7_4 then
					gohelper.setActive(var_7_4, var_7_0)
				end
			end
		end
	end

	arg_7_0:_setMainSprite(var_7_2)
end

function var_0_0.onGetViewNameAndParam(arg_8_0)
	local var_8_0 = arg_8_0:getCustomData()
	local var_8_1 = var_8_0.viewParam

	return var_8_0.viewName, var_8_1
end

function var_0_0.onGetActId(arg_9_0)
	return arg_9_0:getCustomData().viewParam.actId
end

function var_0_0.refreshDot(arg_10_0)
	arg_10_0:_refreshRedDot()
end

function var_0_0._initOceanRedDot(arg_11_0)
	Activity204Controller.instance:checkOceanNewOpenRedDot()
end

function var_0_0.onDailyRefresh(arg_12_0)
	arg_12_0:_initOceanRedDot()
	arg_12_0:refreshDot()
end

return var_0_0
