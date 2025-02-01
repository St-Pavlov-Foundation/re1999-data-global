module("modules.logic.activity.model.warmup.ActivityWarmUpOrderMO", package.seeall)

slot0 = pureTable("ActivityWarmUpOrderMO")

function slot0.ctor(slot0)
	slot0.id = nil
	slot0.cfg = nil
	slot0.progress = nil
	slot0.hasGetBonus = false
	slot0.accept = false
	slot0.status = ActivityWarmUpEnum.OrderStatus.None
end

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.cfg = slot1
end

function slot0.initServerData(slot0, slot1)
	slot0.progress = slot1.process
	slot0.hasGetBonus = slot1.hasGetBonus
	slot0.accept = slot1.accept

	if slot0.hasGetBonus then
		slot0.status = ActivityWarmUpEnum.OrderStatus.Finished
	elseif not slot0.accept then
		slot0.status = ActivityWarmUpEnum.OrderStatus.WaitForAccept
	elseif slot0.accept and not slot0:isColleted() then
		slot0.status = ActivityWarmUpEnum.OrderStatus.Accepted
	elseif slot0.accept and slot0:isColleted() and not slot0.hasGetBonus then
		slot0.status = ActivityWarmUpEnum.OrderStatus.Collected
	end
end

function slot0.getStatus(slot0)
	return slot0.status
end

function slot0.isColleted(slot0)
	if slot0.progress then
		return slot0.cfg.maxProgress <= slot0.progress
	else
		return false
	end
end

function slot0.canFinish(slot0)
	return slot0.status == ActivityWarmUpEnum.OrderStatus.Collected
end

return slot0
