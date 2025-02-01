module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotCollectionUnLockListModel", package.seeall)

slot0 = class("V1a6_CachotCollectionUnLockListModel", ListScrollModel)

function slot0.release(slot0)
	slot0.unlockCollections = nil
end

function slot0.saveUnlockCollectionList(slot0, slot1)
	slot0.unlockCollections = slot0.unlockCollections or {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			table.insert(slot0.unlockCollections, {
				id = slot6
			})
		end
	end
end

function slot0.onInitData(slot0)
	if not slot0.unlockCollections then
		return
	end

	table.sort(slot0.unlockCollections, slot0.sortFunc)
	slot0:setList(slot0.unlockCollections)
end

function slot0.sortFunc(slot0, slot1)
	return slot0.id < slot1.id
end

function slot0.getNewUnlockCollectionsCount(slot0)
	return slot0.unlockCollections and #slot0.unlockCollections or 0
end

slot0.instance = slot0.New()

return slot0
