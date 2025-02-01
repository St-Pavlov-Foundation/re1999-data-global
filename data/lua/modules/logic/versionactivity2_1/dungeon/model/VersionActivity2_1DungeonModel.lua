module("modules.logic.versionactivity2_1.dungeon.model.VersionActivity2_1DungeonModel", package.seeall)

slot0 = class("VersionActivity2_1DungeonModel", BaseModel)

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

function slot0.setMapNeedTweenState(slot0, slot1)
	slot0.isMapNeedTween = slot1
end

function slot0.getMapNeedTweenState(slot0)
	return slot0.isMapNeedTween
end

function slot0.isUnlockAct165Btn(slot0)
	if ActivityConfig.instance:getActivityCo(Activity165Model.instance:getActivityId()) then
		if OpenConfig.instance:getOpenCo(slot2.openId) then
			return OpenModel.instance:isFunctionUnlock(slot2.openId) and Activity165Model.instance:hasUnlockStory()
		else
			logError("openConfig is not exit: " .. slot2.openId)
		end
	end

	return false
end

function slot0.getElementCoList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in pairs(DungeonMapModel.instance:getAllElements()) do
		if lua_chapter_map.configDict[DungeonConfig.instance:getChapterMapElement(slot8).mapId] and slot10.chapterId == VersionActivity2_1DungeonEnum.DungeonChapterId.Story and slot1 == slot9.mapId then
			table.insert(slot2, slot9)
		end
	end

	return slot2
end

function slot0.getElementCoListWithFinish(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in pairs(slot0:getAllNormalElementCoList(slot1)) do
		slot9 = slot8.id

		if lua_chapter_map.configDict[slot8.mapId] and slot10.chapterId == VersionActivity2_1DungeonEnum.DungeonChapterId.Story then
			if slot1 == slot8.mapId and DungeonMapModel.instance:elementIsFinished(slot9) and not DungeonMapModel.instance:getElementById(slot9) then
				table.insert(slot2, slot8)
			end
		end
	end

	return slot2, slot3
end

function slot0.getAllNormalElementCoList(slot0, slot1)
	slot2 = {}
	slot3 = DungeonConfig.instance:getMapElements(slot1)

	if Activity165Model.instance:getAllElements() and slot3 then
		for slot8, slot9 in pairs(slot3) do
			if not LuaUtil.tableContains(slot4, slot9.id) then
				table.insert(slot2, slot9)
			end
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

function slot0.getUnFinishElementEpisodeId(slot0)
	slot1 = 0

	for slot6, slot7 in pairs(DungeonMapModel.instance:getAllElements()) do
		if lua_chapter_map.configDict[DungeonConfig.instance:getChapterMapElement(slot7).mapId] and slot9.chapterId == VersionActivity2_1DungeonEnum.DungeonChapterId.Story and (DungeonConfig.instance:getEpisodeIdByMapCo(slot9) < slot1 or slot1 == 0) then
			slot1 = slot10
		end
	end

	return slot1
end

function slot0.getFinishWithFragmentElementList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(DungeonConfig.instance:getMapElements(slot1.id) or {}) do
		if DungeonMapModel.instance:elementIsFinished(slot8.id) and slot8.fragment > 0 then
			table.insert(slot2, slot8)
		end
	end

	return slot2
end

function slot0.checkStoryCanUnlock(slot0, slot1)
	slot2 = nil

	for slot8, slot9 in ipairs(Activity165Config.instance:getAllStoryCoList(Activity165Model.instance:getActivityId())) do
		slot10 = Activity165Config.instance:getStoryElements(slot3, slot9.storyId)

		if slot10[#slot10] == slot1 then
			slot2 = slot9

			break
		end
	end

	return slot2
end

function slot0.getUnFinishStoryElements(slot0)
	slot1 = {}

	for slot7, slot8 in pairs(DungeonMapModel.instance:getAllElements()) do
		if LuaUtil.tableContains(Activity165Model.instance:getAllElements(), slot8) then
			table.insert(slot1, slot8)
		end
	end

	return slot1
end

function slot0.checkAndGetUnfinishStoryElementCo(slot0, slot1)
	slot2 = nil

	for slot8, slot9 in ipairs(DungeonConfig.instance:getMapElements(slot1) or {}) do
		if LuaUtil.tableContains(slot0:getUnFinishStoryElements(), slot9.id) then
			slot2 = slot9

			break
		end
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
