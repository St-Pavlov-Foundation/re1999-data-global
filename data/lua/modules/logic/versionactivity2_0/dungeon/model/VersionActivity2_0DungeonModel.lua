module("modules.logic.versionactivity2_0.dungeon.model.VersionActivity2_0DungeonModel", package.seeall)

slot0 = class("VersionActivity2_0DungeonModel", BaseModel)

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

function slot0.getLastEpisodeId(slot0)
	return slot0.lastEpisodeId
end

function slot0.setShowInteractView(slot0, slot1)
	slot0.isShowInteractView = slot1
end

function slot0.checkIsShowInteractView(slot0)
	return slot0.isShowInteractView
end

function slot0.setIsNotShowNewElement(slot0, slot1)
	slot0.notShowNewElement = slot1
end

function slot0.isNotShowNewElement(slot0)
	return slot0.notShowNewElement
end

function slot0.setOpenGraffitiEntrance(slot0, slot1)
	slot0.isOpenGraffitiEntrance = slot1
end

function slot0.getOpenGraffitiEntranceState(slot0)
	return slot0.isOpenGraffitiEntrance
end

function slot0.setMapNeedTweenState(slot0, slot1)
	slot0.isMapNeedTween = slot1
end

function slot0.getMapNeedTweenState(slot0)
	return slot0.isMapNeedTween
end

function slot0.setOpeningGraffitiEntrance(slot0, slot1)
	slot0.isOpeningGraffitiEntrance = slot1
end

function slot0.getOpeningGraffitiEntranceState(slot0)
	return slot0.isOpeningGraffitiEntrance
end

function slot0.setDraggingMapState(slot0, slot1)
	slot0.isDragginMap = slot1
end

function slot0.isDraggingMapState(slot0)
	return slot0.isDragginMap
end

function slot0.getGraffitiEntranceUnlockState(slot0)
	if ActivityConfig.instance:getActivityCo(Activity161Model.instance:getActId()) then
		if OpenConfig.instance:getOpenCo(slot2.openId) then
			return OpenModel.instance:isFunctionUnlock(slot2.openId)
		else
			logError("openConfig is not exit: " .. slot2.openId)
		end
	end

	return false
end

function slot0.getElementCoList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in pairs(DungeonMapModel.instance:getAllElements()) do
		if lua_chapter_map.configDict[DungeonConfig.instance:getChapterMapElement(slot8).mapId] and slot10.chapterId == VersionActivity2_0DungeonEnum.DungeonChapterId.Story and slot1 == slot9.mapId then
			table.insert(slot2, slot9)
		end
	end

	return slot2
end

function slot0.getElementCoListWithFinish(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in pairs(slot0:getAllNormalElementCoList(slot1)) do
		slot9 = slot8.id

		if lua_chapter_map.configDict[slot8.mapId] and slot10.chapterId == VersionActivity2_0DungeonEnum.DungeonChapterId.Story then
			if slot1 == slot8.mapId and DungeonMapModel.instance:elementIsFinished(slot9) and not DungeonMapModel.instance:getElementById(slot9) then
				table.insert(slot2, slot8)
			end
		end
	end

	return slot2, slot3
end

function slot0.getAllNormalElementCoList(slot0, slot1)
	if not DungeonConfig.instance:getMapElements(slot1) or #slot3 < 0 then
		return {}
	end

	slot4 = Activity161Model.instance:getActId()

	for slot8, slot9 in pairs(slot3) do
		slot11, slot12 = Activity161Config.instance:getGraffitiRelevantElementMap(slot4)

		if not Activity161Config.instance:getGraffitiCo(slot4, slot9.id) and slot9.type ~= DungeonEnum.ElementType.Graffiti and not slot11[slot9.id] and not slot12[slot9.id] then
			table.insert(slot2, slot9)
		end
	end

	return slot2
end

function slot0.setDungeonBaseMo(slot0, slot1)
	slot0.actDungeonBaseMo = slot1
end

function slot0.getDungeonBaseMo(slot0)
	return slot0.actDungeonBaseMo
end

function slot0.getCurNeedUnlockGraffitiElement(slot0)
	for slot6, slot7 in pairs(Activity161Config.instance:getAllGraffitiCo(Activity161Model.instance:getActId())) do
		slot10 = Activity161Config.instance:getGraffitiRelevantElement(slot1, slot7.elementId)

		if Activity161Config.instance:isPreMainElementFinish(slot7) and DungeonMapModel.instance:getElementById(slot7.mainElementId) and not DungeonMapModel.instance:elementIsFinished(slot7.mainElementId) then
			return slot7.mainElementId
		elseif slot8 and #slot10 > 0 then
			for slot15, slot16 in pairs(slot10) do
				if not DungeonMapModel.instance:elementIsFinished(slot16) and DungeonMapModel.instance:getElementById(slot16) then
					return slot16
				end
			end
		end
	end

	return nil
end

slot0.instance = slot0.New()

return slot0
