module("modules.logic.versionactivity2_4.pinball.model.PinballTalentMo", package.seeall)

slot0 = pureTable("PinballTalentMo")

function slot0.init(slot0, slot1)
	slot0._addResPers = {}
	slot0._marblesLv = {}
	slot0._unlockMarbles = {
		[PinballEnum.UnitType.MarblesNormal] = true
	}
	slot0.co = lua_activity178_talent.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot1]

	if not slot0.co then
		logError("没有天赋配置，id：" .. tostring(slot1))

		return
	end

	if string.splitToNumber(slot0.co.effect, "#")[1] == PinballEnum.TalentEffectType.UnlockMarbles then
		slot0._unlockMarbles[slot2[2]] = true
	elseif slot3 == PinballEnum.TalentEffectType.AddResPer then
		slot0._addResPers[slot2[2]] = slot2[3] / 1000
	elseif slot3 == PinballEnum.TalentEffectType.EpisodeCostDec then
		slot0._costDec = slot2[2]
	elseif slot3 == PinballEnum.TalentEffectType.PlayDec then
		slot0._playDec = slot2[2]
	elseif slot3 == PinballEnum.TalentEffectType.MarblesLevel then
		slot0._marblesLv[slot2[2]] = slot2[3]
	end
end

function slot0.getResAdd(slot0, slot1)
	return slot0._addResPers[slot1] or 0
end

function slot0.getCostDec(slot0)
	return slot0._costDec or 0
end

function slot0.getPlayDec(slot0)
	return slot0._playDec or 0
end

function slot0.getIsUnlockMarbles(slot0, slot1)
	return slot0._unlockMarbles[slot1] or false
end

function slot0.getMarblesLv(slot0, slot1)
	return slot0._marblesLv[slot1] or 1
end

return slot0
