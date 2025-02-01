module("modules.logic.versionactivity1_6.v1a6_cachot.config.V1a6_CachotCollectionConfig", package.seeall)

slot0 = class("V1a6_CachotCollectionConfig", BaseConfig)

function slot0.onInit(slot0)
	slot0._collectionConfigTable = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"rogue_collection",
		"rogue_collection_enchant",
		"rogue_collecion_unlock_task"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "rogue_collection" then
		slot0:onRogueCollectionConfigLoaded(slot2)
	elseif slot1 == "rogue_collection_enchant" then
		slot0._enchantConfigTable = slot2
	end
end

function slot0.onRogueCollectionConfigLoaded(slot0, slot1)
	slot0._collectionConfigTable = slot1
	slot0._collectionTypeMap = slot0._collectionTypeMap or {}
	slot0._collectionGroupMap = slot0._collectionGroupMap or {}

	if slot1.configDict then
		for slot5, slot6 in ipairs(slot1.configList) do
			slot0._collectionTypeMap[slot6.type] = slot0._collectionTypeMap[slot6.type] or {}
			slot0._collectionGroupMap[slot6.group] = slot0._collectionGroupMap[slot6.group] or {}

			table.insert(slot0._collectionTypeMap[slot6.type], slot6)
			table.insert(slot0._collectionGroupMap[slot6.group], slot6)
		end
	end
end

function slot0.getAllConfig(slot0)
	return slot0._collectionConfigTable.configList
end

function slot0.getCollectionConfig(slot0, slot1)
	if slot0._collectionConfigTable.configDict then
		return slot0._collectionConfigTable.configDict[slot1]
	end
end

function slot0.getCollectionConfigsByType(slot0, slot1)
	return slot0._collectionTypeMap and slot0._collectionTypeMap[slot1]
end

function slot0.getCollectionSkillsByConfig(slot0, slot1)
	if slot1 and slot1.skills then
		slot3 = {}

		if GameUtil.splitString2(slot2, true) then
			for slot8 = 1, #slot4 do
				table.insert(slot3, slot4[slot8][3])
			end
		end

		return slot3
	end
end

function slot0.getCollectionSkillsInfo(slot0, slot1)
	slot3 = {}
	slot4 = {}
	slot5 = {}

	if slot1 and slot1.skills and GameUtil.splitString2(slot2, true) then
		for slot10 = 1, #slot6 do
			table.insert(slot3, slot11)

			if HeroSkillModel.instance:getEffectTagDescIdList(lua_rule.configDict[slot6[slot10][3]] and slot12.desc) then
				for slot18, slot19 in ipairs(slot14) do
					if not slot5[slot19] then
						table.insert(slot4, slot19)

						slot5[slot19] = true
					end
				end
			end
		end
	end

	return slot3, slot4
end

function slot0.getCollectionSkillsContent(slot0, slot1, slot2, slot3, slot4)
	slot2 = slot2 or "#4e6698"
	slot6 = ""

	if slot1 and slot1.skills then
		slot7 = {}

		if GameUtil.splitString2(slot5, true) then
			for slot12 = 1, #slot8 do
				if lua_rule.configDict[slot8[slot12][3]] then
					table.insert(slot7, slot14.desc)
				end
			end
		end

		slot6 = table.concat(slot7, "\n")
	end

	if not string.nilorempty(HeroSkillModel.instance:getEffectTagDescFromDescRecursion(slot6, slot2)) then
		slot6 = slot6 .. "\n" .. slot7
	end

	return HeroSkillModel.instance:skillDesToSpot(slot6, slot3, slot4)
end

function slot0.getCollectionSpDescsByConfig(slot0, slot1)
	slot3 = {}

	if not string.nilorempty(slot1 and slot1.spdesc) then
		slot3 = string.split(slot2, "#")
	end

	return slot3
end

function slot0.getCollectionsByGroupId(slot0, slot1)
	return slot0._collectionGroupMap and slot0._collectionGroupMap[slot1]
end

slot0.instance = slot0.New()

return slot0
