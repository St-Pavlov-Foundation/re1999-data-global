module("modules.logic.guide.controller.action.impl.WaitGuideActionRoleStoryTicketExchange", package.seeall)

local var_0_0 = class("WaitGuideActionRoleStoryTicketExchange", BaseGuideAction)
local var_0_1 = 1.6

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = RoleStoryModel.instance.lastExchangeTime

	if CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost) <= RoleStoryModel.instance:getLeftNum() and RoleStoryModel.instance:checkTodayCanExchange() then
		RoleStoryController.instance:registerCallback(RoleStoryEvent.ExchangeTick, arg_1_0._onExchangeTick, arg_1_0)
	elseif var_1_0 and Time.time - var_1_0 < var_0_1 then
		arg_1_0:_onExchangeTick()
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._onExchangeTick(arg_2_0)
	RoleStoryController.instance:unregisterCallback(RoleStoryEvent.ExchangeTick, arg_2_0._onExchangeTick, arg_2_0)
	GuideBlockMgr.instance:startBlock(var_0_1)
	TaskDispatcher.runDelay(arg_2_0._onDone, arg_2_0, var_0_1)
end

function var_0_0._onDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._onDone, true)
	RoleStoryController.instance:unregisterCallback(RoleStoryEvent.ExchangeTick, arg_4_0._onExchangeTick, arg_4_0)
end

return var_0_0
