module("modules.logic.versionactivity1_8.dungeon.model.VersionActivity1_8DungeonModel", package.seeall)

slot0 = class("VersionActivity1_8DungeonModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	slot0:init()
end

function slot0.init(slot0)
	slot0:setLastEpisodeId()
	slot0:setShowInteractView()
end

function slot0.setLastEpisodeId(slot0, slot1)
	slot0.lastEpisodeId = slot1
end

function slot0.setShowInteractView(slot0, slot1)
	slot0.isShowInteractView = slot1
end

function slot0.setIsNotShowNewElement(slot0, slot1)
	slot0.notShowNewElement = slot1
end

function slot0.isNotShowNewElement(slot0)
	return slot0.notShowNewElement
end

function slot0.getLastEpisodeId(slot0)
	return slot0.lastEpisodeId
end

function slot0.checkIsShowInteractView(slot0)
	return slot0.isShowInteractView
end

function slot0.getElementCoList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in pairs(DungeonMapModel.instance:getAllElements()) do
		if lua_chapter_map.configDict[DungeonConfig.instance:getChapterMapElement(slot8).mapId] and slot10.chapterId == VersionActivity1_8DungeonEnum.DungeonChapterId.Story and slot1 == slot9.mapId then
			table.insert(slot2, slot9)
		end
	end

	return slot2
end

function slot0.getElementCoListWithFinish(slot0, slot1, slot2)
	if not DungeonConfig.instance:getMapElements(slot1) or #slot4 < 0 then
		return {}
	end

	for slot8, slot9 in pairs(slot4) do
		slot10 = slot9.id

		if lua_chapter_map.configDict[slot9.mapId] and slot11.chapterId == VersionActivity1_8DungeonEnum.DungeonChapterId.Story then
			slot12 = DungeonMapModel.instance:elementIsFinished(slot10)
			slot13 = DungeonMapModel.instance:getElementById(slot10)
			slot14 = true
			slot17 = false

			if Activity157Config.instance:getMissionIdByElementId(Activity157Model.instance:getActId(), slot10) then
				slot17 = Activity157Config.instance:isSideMission(slot15, slot16)
			end

			if slot17 and slot2 then
				slot14 = not Activity157Model.instance:isInProgressOtherMissionGroupByElementId(slot10)
			end

			if slot1 == slot9.mapId and slot14 and (slot12 or slot13) then
				table.insert(slot3, slot9)
			end
		end
	end

	return slot3
end

slot0.instance = slot0.New()

return slot0
