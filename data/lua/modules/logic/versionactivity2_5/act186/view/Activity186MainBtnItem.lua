module("modules.logic.versionactivity2_5.act186.view.Activity186MainBtnItem", package.seeall)

local var_0_0 = class("Activity186MainBtnItem", ActCenterItemBase)

function var_0_0.onAddEvent(arg_1_0)
	gohelper.addUIClickAudio(arg_1_0._btnitem)
	Activity186Controller.instance:registerCallback(Activity186Event.RefreshRed, arg_1_0.refreshDot, arg_1_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateFriendInfoDot, arg_1_0.refreshDot, arg_1_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, arg_1_0.refreshDot, arg_1_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, arg_1_0.refreshDot, arg_1_0)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, arg_1_0.refreshDot, arg_1_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_1_0.refreshDot, arg_1_0)
end

function var_0_0.onRemoveEvent(arg_2_0)
	Activity186Controller.instance:unregisterCallback(Activity186Event.RefreshRed, arg_2_0.refreshDot, arg_2_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, arg_2_0.refreshDot, arg_2_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateFriendInfoDot, arg_2_0.refreshDot, arg_2_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, arg_2_0.refreshDot, arg_2_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, arg_2_0.refreshDot, arg_2_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_2_0.refreshDot, arg_2_0)
end

function var_0_0.onClick(arg_3_0)
	local var_3_0 = arg_3_0:onGetActId()

	Activity186Rpc.instance:sendGetAct186InfoRequest(var_3_0, arg_3_0._onReceiveGetInfosReply, arg_3_0)
end

function var_0_0._onReceiveGetInfosReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 == 0 then
		local var_4_0, var_4_1 = arg_4_0:onGetViewNameAndParam()

		ViewMgr.instance:openView(var_4_0, var_4_1)
	end
end

function var_0_0.refreshData(arg_5_0)
	local var_5_0 = Activity186Model.instance:getActId()
	local var_5_1 = {
		viewName = "Activity186View",
		viewParam = {
			actId = var_5_0
		}
	}

	arg_5_0:setCustomData(var_5_1)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:refreshData()
	arg_6_0:_addNotEventRedDot(arg_6_0._checkRed, arg_6_0)
end

function var_0_0._checkRed(arg_7_0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a5_Act186, 0) then
		return true
	end

	if Activity186Model.instance:isShowSignRed() then
		return true
	end

	local var_7_0 = Activity186Model.instance:getActId()
	local var_7_1 = Activity186Model.instance:getById(var_7_0)

	if var_7_1 and var_7_1:isCanShowAvgBtn() then
		return true
	end

	return false
end

function var_0_0.onRefresh(arg_8_0)
	arg_8_0:refreshData()

	local var_8_0 = ActivityModel.showActivityEffect()
	local var_8_1 = ActivityConfig.instance:getMainActAtmosphereConfig()
	local var_8_2 = var_8_0 and var_8_1.mainViewActBtnPrefix .. "icon_6" or "icon_6"

	if not var_8_0 then
		local var_8_3 = ActivityConfig.instance:getMainActAtmosphereConfig()

		if var_8_3 then
			for iter_8_0, iter_8_1 in ipairs(var_8_3.mainViewActBtn) do
				local var_8_4 = gohelper.findChild(arg_8_0.go, iter_8_1)

				if var_8_4 then
					gohelper.setActive(var_8_4, var_8_0)
				end
			end
		end
	end

	arg_8_0:_setMainSprite(var_8_2)
end

function var_0_0.onGetViewNameAndParam(arg_9_0)
	local var_9_0 = arg_9_0:getCustomData()
	local var_9_1 = var_9_0.viewParam

	return var_9_0.viewName, var_9_1
end

function var_0_0.onGetActId(arg_10_0)
	return arg_10_0:getCustomData().viewParam.actId
end

function var_0_0.refreshDot(arg_11_0)
	arg_11_0:_refreshRedDot()
end

return var_0_0
