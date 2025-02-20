module("modules.logic.versionactivity2_4.act181.model.Activity181MO", package.seeall)

slot0 = pureTable("Activity181MO")

function slot0.setInfo(slot0, slot1)
	slot5 = slot1.activityId
	slot0.config = Activity181Config.instance:getBoxConfig(slot5)
	slot0.id = slot1.activityId
	slot0.rewardInfo = {}
	slot0.bonusIdDic = {}
	slot0.getBonusCount = 0
	slot0.allBonusCount = 0

	for slot5, slot6 in ipairs(slot1.infos) do
		slot0.rewardInfo[slot6.pos] = slot6.id
		slot0.bonusIdDic[slot6.id] = slot6.pos

		if slot6.pos ~= 0 then
			slot0.getBonusCount = slot0.getBonusCount + 1
		end
	end

	slot0.allBonusCount = #Activity181Config.instance:getBoxListByActivityId(slot0.id)
	slot0.canGetTimes = slot1.canGetTimes

	if slot0.rewardInfo[0] ~= nil then
		slot0.spBonusState = Activity181Enum.SPBonusState.HaveGet
	else
		slot0.spBonusState = slot1.canGetSpBonus
	end
end

function slot0.setBonusInfo(slot0, slot1, slot2)
	slot0.rewardInfo[slot1] = slot2
	slot0.bonusIdDic[slot2] = slot1
	slot0.getBonusCount = slot0.getBonusCount + 1

	slot0:setBonusTimes(math.max(0, slot0.canGetTimes - 1))

	if slot0.spBonusState == Activity181Enum.SPBonusState.Locked and slot0:getSPUnlockState() then
		slot0.spBonusState = Activity181Enum.SPBonusState.Unlock
	end
end

function slot0.refreshSpBonusInfo(slot0)
	if slot0.spBonusState ~= Activity181Enum.SPBonusState.HaveGet then
		slot0.spBonusState = slot0:getSPUnlockState() and Activity181Enum.SPBonusState.Unlock or Activity181Enum.SPBonusState.Locked

		Activity181Controller.instance:dispatchEvent(Activity181Event.OnGetSPBonus, slot0.id)
	end
end

function slot0.getBonusState(slot0, slot1)
	if slot0.rewardInfo[slot1] then
		return Activity181Enum.BonusState.HaveGet
	end

	return Activity181Enum.BonusState.Unlock
end

function slot0.getBonusIdByPos(slot0, slot1)
	return slot0.rewardInfo[slot1]
end

function slot0.getBonusStateById(slot0, slot1)
	return slot0:getBonusState(slot0.bonusIdDic[slot1])
end

function slot0.setSPBonusInfo(slot0)
	slot0.spBonusState = Activity181Enum.SPBonusState.HaveGet
	slot0.rewardInfo[0] = 0
	slot0.bonusIdDic[0] = 0
end

function slot0.getSPUnlockState(slot0)
	if slot0.config.obtainType == Activity181Enum.SPBonusUnlockType.Time then
		return slot0:isSpBonusTimeUnlock(slot1)
	elseif slot1.obtainType == Activity181Enum.SPBonusUnlockType.Count then
		return slot0:isSpBonusCountUnlock(slot1)
	else
		return slot0:isSpBonusTimeUnlock(slot1) or slot0:isSpBonusCountUnlock(slot1)
	end
end

function slot0.isSpBonusTimeUnlock(slot0, slot1)
	return TimeUtil.stringToTimestamp(slot1.obtainStart) <= ServerTime.now() and slot2 <= TimeUtil.stringToTimestamp(slot1.obtainEnd)
end

function slot0.isSpBonusCountUnlock(slot0, slot1)
	return slot1.obtainTimes <= slot0.getBonusCount
end

function slot0.getBonusTimes(slot0)
	return slot0.canGetTimes
end

function slot0.setBonusTimes(slot0, slot1)
	slot0.canGetTimes = slot1
end

function slot0.canGetBonus(slot0)
	return slot0.getBonusCount < slot0.allBonusCount
end

return slot0
