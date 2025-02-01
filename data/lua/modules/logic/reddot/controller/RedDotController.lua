module("modules.logic.reddot.controller.RedDotController", package.seeall)

slot0 = class("RedDotController", BaseController)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	TaskDispatcher.cancelTask(slot0._checkExpire, slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.addNotEventRedDot(slot0, slot1, slot2, slot3, slot4)
	slot5 = MonoHelper.addNoUpdateLuaComOnceToGo(slot1, CommonRedDotIconNoEvent)

	slot5:setShowType(slot4)
	slot5:setCheckShowRedDotFunc(slot2, slot3)

	return slot5
end

function slot0.addRedDotTag(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = MonoHelper.addNoUpdateLuaComOnceToGo(slot1, CommonRedDotTag)

	slot6:setId(slot2, slot3)
	slot6:overrideRefreshDotFunc(slot4, slot5)
	slot6:refreshDot()

	return slot6
end

function slot0.addRedDot(slot0, slot1, slot2, slot3, slot4, slot5)
	return slot0:addMultiRedDot(slot1, {
		{
			id = slot2,
			uid = slot3
		}
	}, slot4, slot5)
end

function slot0.addMultiRedDot(slot0, slot1, slot2, slot3, slot4)
	slot5 = MonoHelper.getLuaComFromGo(slot1, CommonRedDotIcon) or MonoHelper.addNoUpdateLuaComOnceToGo(slot1, CommonRedDotIcon)

	slot5:setMultiId(slot2)
	slot5:overrideRefreshDotFunc(slot3, slot4)
	slot5:refreshDot()

	return slot5
end

function slot0.getRedDotComp(slot0, slot1)
	return MonoHelper.getLuaComFromGo(slot1, CommonRedDotIcon)
end

function slot0.CheckExpireDot(slot0)
	TaskDispatcher.cancelTask(slot0._checkExpire, slot0)
	TaskDispatcher.runRepeat(slot0._checkExpire, slot0, 1)
end

function slot0._checkExpire(slot0)
	if RedDotModel.instance:getLatestExpireTime() == 0 then
		TaskDispatcher.cancelTask(slot0._checkExpire, slot0)

		return
	end

	if slot1 <= ServerTime.now() then
		TaskDispatcher.cancelTask(slot0._checkExpire, slot0)
		RedDotRpc.instance:sendGetRedDotInfosRequest()
	end
end

slot0.instance = slot0.New()

return slot0
