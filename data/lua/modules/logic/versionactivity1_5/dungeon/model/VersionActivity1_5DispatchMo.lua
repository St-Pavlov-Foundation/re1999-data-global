module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5DispatchMo", package.seeall)

slot0 = pureTable("DispatchMo")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.config = VersionActivity1_5DungeonConfig.instance:getDispatchCo(slot0.id)

	slot0:update(slot1)
end

function slot0.update(slot0, slot1)
	slot6 = slot1.endTime
	slot0.endTime = Mathf.Floor(tonumber(slot6) / 1000)
	slot0.heroIdList = {}

	for slot5, slot6 in ipairs(slot1.heroIds) do
		table.insert(slot0.heroIdList, slot6)
	end
end

function slot0.isFinish(slot0)
	return slot0.endTime <= ServerTime.now()
end

function slot0.isRunning(slot0)
	return ServerTime.now() < slot0.endTime
end

function slot0.getRemainTime(slot0)
	return Mathf.Max(slot0.endTime - ServerTime.now(), 0)
end

function slot0.getRemainTimeStr(slot0, slot1)
	slot2 = slot0:getRemainTime()

	return string.format("%02d : %02d : %02d", math.floor(slot2 / TimeUtil.OneHourSecond), math.floor(slot2 % TimeUtil.OneHourSecond / 60), slot2 % 60)
end

return slot0
