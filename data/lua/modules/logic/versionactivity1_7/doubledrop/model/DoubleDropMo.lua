module("modules.logic.versionactivity1_7.doubledrop.model.DoubleDropMo", package.seeall)

slot0 = pureTable("DoubleDropMo")

function slot0.init(slot0, slot1)
	slot0.id = slot1.activityId
	slot0.totalCount = slot1.totalCount
	slot0.dailyCount = slot1.dailyCount

	slot0:initConfig()
end

function slot0.initConfig(slot0)
	if slot0.config then
		return
	end

	slot0.config = DoubleDropConfig.instance:getAct153Co(slot0.id)
end

function slot0.isDoubleTimesout(slot0)
	if not slot0.config then
		return true
	end

	slot1, slot2 = slot0:getDailyRemainTimes()

	return slot1 == 0, slot1, slot2
end

function slot0.getDailyRemainTimes(slot0)
	slot2 = slot0.config.dailyLimit or 0

	if slot0.config.totalLimit - slot0.totalCount < slot2 then
		slot4 = math.min(slot2 - (slot0.dailyCount or 0), slot3)
	end

	if slot4 < 0 then
		slot4 = 0
	end

	return slot4, slot2
end

return slot0
