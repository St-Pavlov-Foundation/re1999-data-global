module("modules.logic.handbook.model.HandbookModel", package.seeall)

slot0 = class("HandbookModel", BaseModel)

function slot0.onInit(slot0)
	slot0._cgReadDict = {}
	slot0._fragmentDict = {}
	slot0._characterReadDict = {}
	slot0._equipDict = {}
end

function slot0.reInit(slot0)
	slot0._cgReadDict = {}
	slot0._fragmentDict = {}
	slot0._characterReadDict = {}
	slot0._equipDict = {}
end

function slot0.setReadInfos(slot0, slot1)
	slot0._cgReadDict = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0:setReadInfo(slot6)
	end
end

function slot0.setReadInfo(slot0, slot1)
	if slot1.type == HandbookEnum.Type.CG then
		if slot1.isRead then
			slot0._cgReadDict[slot1.id] = true
		elseif slot0._cgReadDict[slot1.id] then
			slot0._cgReadDict[slot1.id] = nil
		end
	elseif slot1.type == HandbookEnum.Type.Character then
		if slot1.isRead then
			slot0._characterReadDict[slot1.id] = true
		end
	elseif slot1.type == HandbookEnum.Type.Equip then
		if not lua_handbook_equip.configDict[slot1.id] then
			logError(string.format("handbook equip not found id : %s config", slot1.id))

			return
		end

		slot0._equipDict[slot2.equipId] = true
	end
end

function slot0.setFragmentInfo(slot0, slot1)
	slot0._fragmentDict = {}

	for slot5, slot6 in ipairs(slot1) do
		if lua_chapter_map_element.configDict[slot6.element] and slot7.fragment ~= 0 then
			slot8 = {}

			for slot12, slot13 in ipairs(slot6.dialogIds) do
				table.insert(slot8, slot13)
			end

			slot0._fragmentDict[slot7.fragment] = slot8
		end
	end
end

function slot0.isRead(slot0, slot1, slot2)
	if slot1 == HandbookEnum.Type.CG then
		return slot0._cgReadDict[slot2]
	elseif slot1 == HandbookEnum.Type.Character then
		return slot0._characterReadDict[slot2]
	end

	return false
end

function slot0.isCGUnlock(slot0, slot1)
	return HandbookConfig.instance:getCGConfig(slot1).episodeId == 0 or DungeonModel.instance:hasPassLevelAndStory(slot3)
end

function slot0.getCGUnlockCount(slot0, slot1, slot2)
	for slot8, slot9 in ipairs(HandbookConfig.instance:getCGList(slot2)) do
		if (not slot1 or slot9.storyChapterId == slot1) and uv0.instance:isCGUnlock(slot9.id) then
			slot3 = 0 + 1
		end
	end

	return slot3
end

function slot0.getCGUnlockIndex(slot0, slot1, slot2)
	for slot8, slot9 in ipairs(HandbookConfig.instance:getCGList(slot2)) do
		if slot9.id == slot1 then
			return 1
		end

		if uv0.instance:isCGUnlock(slot9.id) then
			slot3 = slot3 + 1
		end
	end
end

function slot0.getNextCG(slot0, slot1, slot2)
	for slot8 = HandbookConfig.instance:getCGIndex(slot1, slot2) + 1, #HandbookConfig.instance:getCGList(slot2) do
		if slot0:isCGUnlock(slot4[slot8].id) then
			return slot9
		end
	end

	for slot8 = 1, slot3 - 1 do
		if slot0:isCGUnlock(slot4[slot8].id) then
			return slot9
		end
	end

	return nil
end

function slot0.getPrevCG(slot0, slot1, slot2)
	slot4 = HandbookConfig.instance:getCGList(slot2)

	for slot8 = HandbookConfig.instance:getCGIndex(slot1, slot2) - 1, 1, -1 do
		if slot0:isCGUnlock(slot4[slot8].id) then
			return slot9
		end
	end

	for slot8 = #slot4, slot3 + 1, -1 do
		if slot0:isCGUnlock(slot4[slot8].id) then
			return slot9
		end
	end

	return nil
end

function slot0.isStoryGroupUnlock(slot0, slot1)
	return HandbookConfig.instance:getStoryGroupConfig(slot1).episodeId == 0 or DungeonModel.instance:hasPassLevelAndStory(slot3)
end

function slot0.getStoryGroupUnlockCount(slot0, slot1)
	for slot7, slot8 in ipairs(HandbookConfig.instance:getStoryGroupList()) do
		if (not slot1 or slot8.storyChapterId == slot1) and uv0.instance:isStoryGroupUnlock(slot8.id) then
			slot2 = 0 + 1
		end
	end

	return slot2
end

function slot0.getFragmentDialogIdList(slot0, slot1)
	return slot0._fragmentDict[slot1]
end

function slot0.haveEquip(slot0, slot1)
	return slot0._equipDict[slot1]
end

slot0.instance = slot0.New()

return slot0
