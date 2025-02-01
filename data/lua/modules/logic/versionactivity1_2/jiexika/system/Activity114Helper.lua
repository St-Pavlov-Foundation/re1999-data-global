module("modules.logic.versionactivity1_2.jiexika.system.Activity114Helper", package.seeall)

slot0 = pureTable("Activity114Helper")

function slot0.getEventCoByBattleId(slot0)
	if Activity114Model.instance.serverData.battleEventId > 0 and Activity114Config.instance:getEventCoById(Activity114Model.instance.id, slot1) and slot2.config.battleId == slot0 then
		return slot2
	end

	return false
end

function slot0.haveAttrOrFeatureChange(slot0)
	if Activity114Model.instance.serverData.battleEventId > 0 then
		return false
	end

	if slot0.resultBonus then
		return true
	end

	if slot0.result == nil then
		slot1 = Activity114Enum.Result.Success
	end

	if slot1 == Activity114Enum.Result.None then
		return false
	end

	if not Activity114Config.instance:getEventCoById(Activity114Model.instance.id, slot0.eventId) then
		return false
	end

	slot3 = nil
	slot3 = (slot1 ~= Activity114Enum.Result.Success and slot0.type ~= Activity114Enum.EventType.Rest or slot2.successFeatures) and (slot1 ~= Activity114Enum.Result.FightSucess or slot2.successBattleFeatures) and slot2.failureFeatures
	slot4 = nil
	slot4 = (slot1 ~= Activity114Enum.Result.Success and slot0.type ~= Activity114Enum.EventType.Rest or slot2.successVerify) and (slot1 ~= Activity114Enum.Result.FightSucess or slot2.successBattleVerify) and slot2.failureVerify
	slot4[Activity114Enum.AddAttrType.UnLockMeet] = nil
	slot4[Activity114Enum.AddAttrType.UnLockTravel] = nil
	slot3 = (not next(Activity114Model.instance.newUnLockFeature) or Activity114Model.instance.newUnLockFeature) and {}

	if next(Activity114Model.instance.newUnLockMeeting) then
		slot4[Activity114Enum.AddAttrType.UnLockMeet] = Activity114Model.instance.newUnLockMeeting
	end

	if next(Activity114Model.instance.newUnLockTravel) then
		slot4[Activity114Enum.AddAttrType.UnLockTravel] = Activity114Model.instance.newUnLockTravel
	end

	if next(slot4) or next(slot3) then
		slot0.resultBonus = {
			addAttr = slot4,
			featuresList = slot3
		}

		return true
	end

	return false
end

function slot0.getNextKeyDayDesc(slot0)
	if Activity114Config.instance:getKeyDayCo(Activity114Model.instance.id, slot0 or Activity114Model.instance.serverData.day) then
		return slot1.desc
	end

	return ""
end

function slot0.getNextKeyDayLeft(slot0)
	if Activity114Config.instance:getKeyDayCo(Activity114Model.instance.id, slot0 or Activity114Model.instance.serverData.day) then
		return slot1.day - slot0
	end

	return 0
end

function slot0.getWeekEndScore()
	for slot4 = 1, Activity114Enum.Attr.End - 1 do
		slot0 = 0 + Activity114Model.instance.attrDict[slot4] or 0
	end

	slot1 = Activity114Model.instance.serverData.middleScore
	slot2 = Activity114Model.instance.serverData.endScore

	return slot0, slot1, slot2, slot0 + slot1 + slot2
end

return slot0
