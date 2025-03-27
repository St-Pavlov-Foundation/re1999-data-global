module("modules.logic.seasonver.act166.utils.Season166HeroGroupUtils", package.seeall)

slot0 = class("Season166HeroGroupUtils")

function slot0.buildSnapshotHeroGroups(slot0)
	slot1 = {
		[slot8.groupId] = slot8
	}

	for slot6, slot7 in ipairs(#slot0 == 0 and {
		slot0
	} or slot0) do
		slot8 = Season166HeroGroupMO.New()

		if slot7.heroList == nil or #slot7.heroList <= 0 then
			if not uv0.checkFirstCopyHeroGroup(slot7, slot8) then
				uv0.createEmptyGroup(slot7, slot8)
			end
		else
			slot8:init(slot7)

			slot1[slot7.groupId] = slot8
		end
	end

	table.sort(slot1, function (slot0, slot1)
		return slot0.groupId < slot1.groupId
	end)

	return slot1
end

function slot0.checkFirstCopyHeroGroup(slot0, slot1)
	if slot0.groupId == 1 and Season166HeroGroupModel.instance:getById(1) then
		slot1.id = slot0.groupId
		slot1.groupId = slot0.groupId
		slot1.name = slot2.name
		slot1.heroList = {}

		for slot6 = 1, Season166Enum.MaxHeroCount do
			table.insert(slot1.heroList, Season166Enum.EmptyUid)
		end

		slot1.aidDict = LuaUtil.deepCopy(slot2.aidDict)
		slot1.clothId = slot2.clothId
		slot1.equips = LuaUtil.deepCopy(slot2.equips)

		return true
	end

	return false
end

function slot0.createEmptyGroup(slot0, slot1)
	slot2 = Season166HeroGroupModel.instance:getById(1)
	slot1.id = slot0.groupId or 1
	slot1.groupId = slot0.groupId or 1
	slot1.name = ""
	slot1.heroList = {}

	for slot6 = 1, Season166Enum.MaxHeroCount do
		table.insert(slot1.heroList, Season166Enum.EmptyUid)
	end

	if slot2 then
		slot1.clothId = slot2.clothId
	end

	slot1.equips = {}

	for slot7 = 0, Season166Enum.MaxHeroCount - 1 do
		slot8 = HeroGroupEquipMO.New()

		slot8:init({
			index = slot7,
			equipUid = {
				Season166Enum.EmptyUid
			}
		})

		slot1.equips[slot7] = slot8
	end
end

function slot0.buildFightGroupAssistHero(slot0, slot1)
	if slot0 == ModuleEnum.HeroGroupType.Season166Train and Season166HeroSingleGroupModel.instance.assistMO and tonumber(slot2.pickAssistHeroMO.heroUid) ~= 0 then
		slot1.assistUserId = slot2.userId
		slot1.assistHeroUid = slot2.pickAssistHeroMO.heroUid
	end
end

return slot0
