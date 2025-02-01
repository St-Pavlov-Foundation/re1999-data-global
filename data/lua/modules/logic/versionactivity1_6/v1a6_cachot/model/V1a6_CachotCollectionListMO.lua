module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotCollectionListMO", package.seeall)

slot0 = pureTable("V1a6_CachotCollectionListMO")

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.collectionType = slot1
	slot0.collectionList = {}
	slot0.collectionDic = {}
	slot0._curCollectionCount = 0
	slot0._isTop = slot2 or false
	slot0._maxCollectionNumSingleLine = slot3
end

function slot0.addCollection(slot0, slot1)
	if not slot0.collectionDic[slot1.id] then
		slot0.collectionDic[slot1.id] = true

		table.insert(slot0.collectionList, slot1)

		slot0._curCollectionCount = slot0._curCollectionCount + 1
	end
end

function slot0.isFull(slot0)
	return slot0._maxCollectionNumSingleLine <= slot0._curCollectionCount
end

function slot0.getLineHeight(slot0)
	return slot0._isTop and 330 or 230
end

return slot0
