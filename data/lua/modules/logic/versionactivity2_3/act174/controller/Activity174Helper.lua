module("modules.logic.versionactivity2_3.act174.controller.Activity174Helper", package.seeall)

slot0 = class("Activity174Helper")

function slot0.MatchKeyInArray(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0) do
		if slot7[slot2] == slot1 then
			return slot7
		end
	end
end

function slot0.CalculateRowColumn(slot0)
	return math.ceil(slot0 / 4), slot0 % 4 ~= 0 and slot2 or 4
end

function slot0.sortActivity174RoleCo(slot0, slot1)
	if slot0.type == Activity174Enum.CharacterType.Hero ~= (slot1.type == Activity174Enum.CharacterType.Hero) then
		return slot2
	end

	if slot0.rare ~= slot1.rare then
		return slot1.rare < slot0.rare
	end

	return slot0.heroId < slot1.heroId
end

function slot0.getEmptyFightEntityMO(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = FightEntityMO.New()
	slot2.id = tostring(slot0)
	slot2.uid = slot2.id
	slot2.modelId = slot1.heroId or 0
	slot2.entityType = 1
	slot2.exPoint = 0
	slot2.side = FightEnum.EntitySide.MySide
	slot2.currentHp = 0
	slot2.attrMO = FightHelper._buildAttr(slot1)
	slot2.skillIds = uv0.buildRoleSkills(slot1)
	slot2.shieldValue = 0
	slot2.level = 1
	slot2.skin = slot1.skinId

	return slot2
end

function slot0.buildRoleSkills(slot0)
	slot1 = {}

	if slot0 then
		for slot6, slot7 in ipairs(string.splitToNumber(slot0.passiveSkill, "|")) do
			slot1[#slot1 + 1] = slot7
		end

		for slot7, slot8 in ipairs(string.splitToNumber(slot0.activeSkill1, "#")) do
			slot1[#slot1 + 1] = slot8
		end

		for slot8, slot9 in ipairs(string.splitToNumber(slot0.activeSkill2, "#")) do
			slot1[#slot1 + 1] = slot9
		end

		slot1[#slot1 + 1] = slot0.uniqueSkill
	end

	return slot1
end

return slot0
