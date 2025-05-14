module("modules.logic.seasonver.act123.view.Season123CheckCloseView", package.seeall)

local var_0_0 = class("Season123CheckCloseView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = arg_4_0.viewParam.actId

	if arg_4_0:checkActNotOpen() then
		return
	end

	arg_4_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_4_0.handleReceiveActChanged, arg_4_0)
end

function var_0_0.onClose(arg_5_0)
	return
end

function var_0_0.handleReceiveActChanged(arg_6_0)
	arg_6_0:checkActNotOpen()
end

function var_0_0.checkActNotOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam.actId
	local var_7_1 = ActivityModel.instance:getActMO(var_7_0)

	if not var_7_1 or not var_7_1:isOpen() or var_7_1:isExpired() then
		TaskDispatcher.runDelay(arg_7_0.handleNoActDelayClose, arg_7_0, 0.1)

		return true
	end

	return false
end

function var_0_0.handleNoActDelayClose(arg_8_0)
	arg_8_0:closeThis()
end

return var_0_0
