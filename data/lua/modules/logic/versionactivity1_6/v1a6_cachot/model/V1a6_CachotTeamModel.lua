module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotTeamModel", package.seeall)

slot0 = class("V1a6_CachotTeamModel")

function slot0.setSelectLevel(slot0, slot1)
	slot0._selectLevel = slot1
	slot0._difficulty = lua_rogue_difficulty.configDict[slot0._selectLevel]
	slot0._seatLevel = string.splitToNumber(slot0._difficulty.initLevel, "#")
end

function slot0.getPrepareNum(slot0)
	return slot0._difficulty.initHeroCount - V1a6_CachotEnum.HeroCountInGroup
end

function slot0.getSelectLevel(slot0)
	return slot0._selectLevel
end

function slot0.getInitSeatLevel(slot0, slot1)
	return slot0._seatLevel[slot1]
end

function slot0.getSeatLevel(slot0, slot1)
	return V1a6_CachotModel.instance:getRogueInfo().teamInfo.groupBoxStar[slot1]
end

function slot0.clearSeatInfos(slot0)
	slot0._seatInfo = {}
end

function slot0.setSeatInfo(slot0, slot1, slot2, slot3)
	if not slot1 or not slot2 then
		return
	end

	slot0._seatInfo[slot3] = {
		slot1,
		slot2
	}
end

function slot0.getSeatInfo(slot0, slot1)
	return slot0._seatInfo and slot0._seatInfo[slot1]
end

function slot0.getHeroMaxLevel(slot0, slot1, slot2)
	if not slot2 then
		return slot1.level, slot1.talent
	end

	slot4 = lua_rogue_field.configDict[slot2]
	slot6 = slot4[CharacterEnum.Star[slot1.config.rare] > 4 and "level" .. slot3 or "level4"]
	slot7 = math.min(slot4.talentLevel, HeroResonanceConfig.instance:getHeroMaxTalentLv(slot1.heroId))

	if slot0:isNoLimitLevel() then
		return slot6, slot7
	end

	return math.min(slot1.level, slot6), math.min(slot1.talent, slot7)
end

function slot0.getEquipMaxLevel(slot0, slot1, slot2)
	if not slot2 then
		return slot1.level, slot1.breakLv
	end

	slot3 = lua_rogue_field.configDict[slot2]
	slot4 = 0
	slot4 = (not slot0:isNoLimitLevel() or slot3.equipLevel) and math.min(slot1.level, slot3.equipLevel)

	return slot4, slot1:getBreakLvByLevel(slot4)
end

function slot0.isNoLimitLevel(slot0)
	if not slot0._selectLevel then
		if not V1a6_CachotModel.instance:getRogueInfo() then
			return false
		end

		slot1 = slot2.difficulty
	end

	for slot7, slot8 in ipairs(string.split(lua_rogue_difficulty.configDict[slot1].effect2, "|")) do
		if slot8 == V1a6_CachotEnum.NoLimit then
			return true
		end
	end

	return false
end

slot0.instance = slot0.New()

return slot0
