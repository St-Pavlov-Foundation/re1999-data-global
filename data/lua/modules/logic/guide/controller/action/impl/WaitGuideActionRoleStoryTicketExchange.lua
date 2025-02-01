module("modules.logic.guide.controller.action.impl.WaitGuideActionRoleStoryTicketExchange", package.seeall)

slot0 = class("WaitGuideActionRoleStoryTicketExchange", BaseGuideAction)
slot1 = 1.6

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot2 = RoleStoryModel.instance.lastExchangeTime

	if CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost) <= RoleStoryModel.instance:getLeftNum() and RoleStoryModel.instance:checkTodayCanExchange() then
		RoleStoryController.instance:registerCallback(RoleStoryEvent.ExchangeTick, slot0._onExchangeTick, slot0)
	elseif slot2 and Time.time - slot2 < uv1 then
		slot0:_onExchangeTick()
	else
		slot0:onDone(true)
	end
end

function slot0._onExchangeTick(slot0)
	RoleStoryController.instance:unregisterCallback(RoleStoryEvent.ExchangeTick, slot0._onExchangeTick, slot0)
	GuideBlockMgr.instance:startBlock(uv0)
	TaskDispatcher.runDelay(slot0._onDone, slot0, uv0)
end

function slot0._onDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._onDone, true)
	RoleStoryController.instance:unregisterCallback(RoleStoryEvent.ExchangeTick, slot0._onExchangeTick, slot0)
end

return slot0
