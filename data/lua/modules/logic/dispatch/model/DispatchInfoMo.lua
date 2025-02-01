module("modules.logic.dispatch.model.DispatchInfoMo", package.seeall)

slot0 = pureTable("DispatchInfoMo")

function slot0.init(slot0, slot1)
	slot0.id = slot1.elementId

	slot0:updateMO(slot1)
end

function slot0.updateMO(slot0, slot1)
	slot0.dispatchId = slot1.dispatchId
	slot0.endTime = Mathf.Floor(tonumber(slot1.endTime) / 1000)
	slot0.heroIdList = slot1.heroIdList
end

function slot0.getDispatchId(slot0)
	return slot0.dispatchId
end

function slot0.getHeroIdList(slot0)
	return slot0.heroIdList
end

function slot0.getRemainTime(slot0)
	return Mathf.Max(slot0.endTime - ServerTime.now(), 0)
end

function slot0.getRemainTimeStr(slot0)
	slot1 = slot0:getRemainTime()

	return string.format("%02d : %02d : %02d", math.floor(slot1 / TimeUtil.OneHourSecond), math.floor(slot1 % TimeUtil.OneHourSecond / TimeUtil.OneMinuteSecond), slot1 % TimeUtil.OneMinuteSecond)
end

function slot0.isRunning(slot0)
	return ServerTime.now() < slot0.endTime
end

function slot0.isFinish(slot0)
	return slot0.endTime <= ServerTime.now()
end

return slot0
