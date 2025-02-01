module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotCollectionListModel", package.seeall)

slot0 = class("V1a6_CachotCollectionListModel", MixScrollModel)
slot0.instance = slot0.New()

function slot0.release(slot0)
	slot0._curCategory = nil
	slot0._newCollectionAndClickList = nil
	slot0._unlockCollectionsNew = nil
	slot0._curPlayAnimCellIndex = nil
end

function slot0.onInitData(slot0, slot1, slot2)
	slot0._curCategory = slot1 or V1a6_CachotEnum.CollectionCategoryType.All
	slot0._maxCollectionNumSingleLine = slot2

	slot0:buildUnLockCollectionsNew()
	slot0:buildAllConfigData()
	slot0:switchCategory(slot0._curCategory)
end

function slot0.buildUnLockCollectionsNew(slot0)
	if V1a6_CachotModel.instance:getRogueStateInfo() then
		slot0._unlockCollectionsNew = slot1.unlockCollectionsNew
	end
end

function slot0.buildAllConfigData(slot0)
	slot0:intCategoryDataTab()
	slot0:initCollectionStateMap()

	if V1a6_CachotCollectionConfig.instance:getAllConfig() then
		table.sort(slot1, slot0.configSortFunc)

		for slot8, slot9 in ipairs(slot1) do
			if slot9.inHandBook == V1a6_CachotEnum.CollectionInHandBook then
				slot0:buildCollectionListMO(slot9, slot0._collectionDic[V1a6_CachotEnum.CollectionCategoryType.All])
				slot0:buildCollectionListMO(slot9, slot0._collectionDic[V1a6_CachotEnum.CollectionCategoryType.HasGet], {
					V1a6_CachotEnum.CollectionState.HasGet
				})
				slot0:buildCollectionListMO(slot9, slot0._collectionDic[V1a6_CachotEnum.CollectionCategoryType.UnGet], {
					V1a6_CachotEnum.CollectionState.UnLocked,
					V1a6_CachotEnum.CollectionState.Locked
				})
			end
		end
	end
end

slot1 = {
	ListFull = 2,
	MisMatchState = 1,
	Success = 3
}

function slot0.buildCollectionListMO(slot0, slot1, slot2, slot3)
	slot5 = slot2 and slot2[#slot2]

	if slot0:collectionCheckFunc(slot1, slot2, slot3) == uv0.MisMatchState then
		return
	elseif slot4 == uv0.ListFull then
		slot6 = V1a6_CachotCollectionListMO.New()

		slot6:init(slot1.type, not slot5 or slot5.collectionType ~= slot1.type, slot0._maxCollectionNumSingleLine)
		slot6:addCollection(slot1)
		table.insert(slot2, slot6)
	elseif slot4 == uv0.Success then
		slot2[#slot2]:addCollection(slot1)
	end
end

function slot0.collectionCheckFunc(slot0, slot1, slot2, slot3)
	slot4 = slot2 and slot2[#slot2]

	if slot3 and not tabletool.indexOf(slot3, slot0:getCollectionState(slot1.id)) then
		return uv0.MisMatchState
	elseif not slot4 or slot4:isFull() or slot4.collectionType ~= slot1.type then
		return uv0.ListFull
	else
		return uv0.Success
	end
end

function slot0.configSortFunc(slot0, slot1)
	if slot0.type ~= slot1.type then
		return slot0.type < slot1.type
	end

	return slot0.id < slot1.id
end

slot2 = {
	Top = 1,
	Others = 2
}

function slot0.getInfoList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(slot0:getList()) do
		table.insert(slot2, SLFramework.UGUI.MixCellInfo.New(slot8._isTop and uv0.Top or uv0.Others, slot8:getLineHeight(), slot7))
	end

	return slot2
end

function slot0.intCategoryDataTab(slot0)
	slot0._collectionDic = {}

	for slot4, slot5 in pairs(V1a6_CachotEnum.CollectionCategoryType) do
		slot0._collectionDic[slot5] = {}
	end
end

function slot0.initCollectionStateMap(slot0)
	slot0._collectionStateMap = {}

	if V1a6_CachotModel.instance:getRogueStateInfo() then
		slot0:buildCollectionMap(slot0._collectionStateMap, slot1.unlockCollections, V1a6_CachotEnum.CollectionState.UnLocked)
		slot0:buildCollectionMap(slot0._collectionStateMap, slot1.hasCollections, V1a6_CachotEnum.CollectionState.HasGet)
	end
end

function slot0.buildCollectionMap(slot0, slot1, slot2, slot3)
	if slot2 and slot1 and slot3 then
		for slot7, slot8 in ipairs(slot2) do
			slot1[slot8] = slot3
		end
	end
end

function slot0.getCollectionState(slot0, slot1)
	if slot0._collectionStateMap then
		return slot0._collectionStateMap[slot1] or V1a6_CachotEnum.CollectionState.Locked
	end
end

function slot0.switchCategory(slot0, slot1)
	if slot0._collectionDic and slot0._collectionDic[slot1] then
		slot0:setList(slot2)

		slot0._curCategory = slot1
	end
end

function slot0.getCurCategory(slot0)
	return slot0._curCategory
end

function slot0.getCurCategoryFirstCollection(slot0)
	if slot0:getByIndex(1) and slot1.collectionList and slot1.collectionList[1] then
		return slot1.collectionList[1].id
	end
end

function slot0.markSelectCollecionId(slot0, slot1)
	slot0._curSelectCollectionId = slot1

	if slot0:isCollectionNew(slot1) then
		slot0._newCollectionAndClickList = slot0._newCollectionAndClickList or {}

		table.insert(slot0._newCollectionAndClickList, slot1)

		slot0._unlockCollectionsNew[slot1] = nil
	end
end

function slot0.isCollectionNew(slot0, slot1)
	return slot0._unlockCollectionsNew and slot0._unlockCollectionsNew[slot1]
end

function slot0.getNewCollectionAndClickList(slot0)
	return slot0._newCollectionAndClickList
end

function slot0.getCurSelectCollectionId(slot0)
	return slot0._curSelectCollectionId
end

function slot0.markCurPlayAnimCellIndex(slot0, slot1)
	slot0._curPlayAnimCellIndex = slot1
end

function slot0.getCurPlayAnimCellIndex(slot0)
	return slot0._curPlayAnimCellIndex
end

function slot0.resetCurPlayAnimCellIndex(slot0)
	slot0._curPlayAnimCellIndex = nil
end

return slot0
