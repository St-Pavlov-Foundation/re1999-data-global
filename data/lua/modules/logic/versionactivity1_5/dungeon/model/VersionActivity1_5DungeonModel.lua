module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5DungeonModel", package.seeall)

slot0 = class("VersionActivity1_5DungeonModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.init(slot0)
	slot0.dispatchInfoDict = {}
	slot0.elementId2DispatchMoDict = {}
	slot0.dispatchedHeroDict = {}
	slot0.needCheckDispatchInfoList = {}
end

function slot0.checkDispatchFinish(slot0)
	if #slot0.needCheckDispatchInfoList <= 0 then
		return
	end

	slot2 = false

	for slot6 = slot1, 1, -1 do
		if slot0.needCheckDispatchInfoList[slot6]:isFinish() then
			slot2 = true

			for slot11, slot12 in ipairs(slot7.heroIdList) do
				slot0.dispatchedHeroDict[slot12] = nil
			end

			table.remove(slot0.needCheckDispatchInfoList, slot6)
		end
	end

	if slot2 then
		VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnDispatchFinish)
		RedDotRpc.instance:sendGetRedDotInfosRequest({
			RedDotEnum.DotNode.V1a5DungeonExploreTask
		})
	end
end

function slot0.addDispatchInfos(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if not slot0.dispatchInfoDict[slot6.id] then
			slot7 = VersionActivity1_5DispatchMo.New()

			slot7:init(slot6)

			slot0.dispatchInfoDict[slot6.id] = slot7
		else
			slot7:update(slot6)
		end

		if slot7:isRunning() then
			for slot11, slot12 in ipairs(slot6.heroIds) do
				slot0.dispatchedHeroDict[slot12] = true
			end

			table.insert(slot0.needCheckDispatchInfoList, slot7)
		end
	end
end

function slot0.addOneDispatchInfo(slot0, slot1, slot2, slot3)
	slot4 = VersionActivity1_5DispatchMo.New()

	slot4:init({
		id = slot1,
		endTime = slot2,
		heroIds = slot3
	})

	slot0.dispatchInfoDict[slot1] = slot4

	if slot4:isRunning() then
		for slot8, slot9 in ipairs(slot3) do
			slot0.dispatchedHeroDict[slot9] = true
		end

		table.insert(slot0.needCheckDispatchInfoList, slot4)
	end

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.AddDispatchInfo, slot1)
end

function slot0.removeOneDispatchInfo(slot0, slot1)
	slot0.dispatchInfoDict[slot1] = nil

	for slot6, slot7 in ipairs(slot0.dispatchInfoDict[slot1].heroIdList) do
		slot0.dispatchedHeroDict[slot7] = nil
	end

	slot6 = slot2

	tabletool.removeValue(slot0.needCheckDispatchInfoList, slot6)

	for slot6, slot7 in pairs(slot0.elementId2DispatchMoDict) do
		if slot7.id == slot1 then
			slot0.elementId2DispatchMoDict[slot6] = nil

			break
		end
	end

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.RemoveDispatchInfo, slot1)
end

function slot0.getDispatchMo(slot0, slot1)
	return slot0.dispatchInfoDict[slot1]
end

function slot0.getDispatchStatus(slot0, slot1)
	if not slot0.dispatchInfoDict[slot1] then
		return VersionActivity1_5DungeonEnum.DispatchStatus.NotDispatch
	elseif slot2:isFinish() then
		return VersionActivity1_5DungeonEnum.DispatchStatus.Finished
	else
		return VersionActivity1_5DungeonEnum.DispatchStatus.Dispatching
	end
end

function slot0.isDispatched(slot0, slot1)
	return slot0.dispatchedHeroDict[slot1]
end

function slot0.getElementCoList(slot0, slot1)
	slot2 = {}
	slot3 = {}

	for slot8, slot9 in pairs(DungeonMapModel.instance:getAllElements()) do
		if lua_chapter_map.configDict[DungeonConfig.instance:getChapterMapElement(slot9).mapId] and slot11.chapterId == VersionActivity1_5DungeonEnum.DungeonChapterId.Story then
			if lua_activity11502_episode_element.configDict[slot10.id] and not string.nilorempty(slot12.mapIds) then
				if tabletool.indexOf(string.splitToNumber(slot12.mapIds, "#"), slot1) then
					table.insert(slot3, slot10)
				end
			elseif slot1 == slot10.mapId then
				table.insert(slot2, slot10)
			end
		end
	end

	return slot2, slot3
end

function slot0.getDispatchMoByElementId(slot0, slot1)
	if slot0.elementId2DispatchMoDict[slot1] then
		return slot2
	end

	for slot6, slot7 in pairs(slot0.dispatchInfoDict) do
		if slot7.config.elementId == slot1 then
			slot0.elementId2DispatchMoDict[slot1] = slot7

			return slot7
		end
	end
end

function slot0.setShowInteractView(slot0, slot1)
	slot0.isShowInteractView = slot1
end

function slot0.checkIsShowInteractView(slot0)
	return slot0.isShowInteractView
end

slot0.instance = slot0.New()

return slot0
