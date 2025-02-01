module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotCollectionUnlockController", package.seeall)

slot0 = class("V1a6_CachotCollectionUnlockController", BaseController)

function slot0.onReceiveUnlockCollections(slot0, slot1)
	V1a6_CachotCollectionUnLockListModel.instance:saveUnlockCollectionList(slot1)

	if slot0:checkIsCurrentInCachotMainView() then
		slot0:checkOpenUnlockedView()
	elseif not slot0._registerEvent then
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0.checkOpenView, slot0)
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0.checkCloseView, slot0)

		slot0._registerEvent = true
	end
end

function slot0.checkIsCurrentInCachotMainView(slot0)
	return ViewMgr.instance:isOpen(ViewName.V1a6_CachotMainView)
end

function slot0.checkOpenView(slot0, slot1)
	if slot1 == ViewName.V1a6_CachotMainView then
		slot0:checkOpenUnlockedView()
	end
end

function slot0.checkCloseView(slot0)
	if slot0:checkIsCurrentInCachotMainView() then
		slot0:checkOpenUnlockedView()
	end
end

function slot0.checkOpenUnlockedView(slot0)
	if V1a6_CachotCollectionUnLockListModel.instance:getNewUnlockCollectionsCount() > 0 then
		V1a6_CachotController.instance:openV1a6_CachotCollectionUnlockedView()
	end
end

function slot0.onOpenView(slot0)
	V1a6_CachotCollectionUnLockListModel.instance:onInitData()
end

function slot0.onCloseView(slot0)
	V1a6_CachotCollectionUnLockListModel.instance:release()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, slot0.checkOpenView, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0.checkCloseView, slot0)

	slot0._registerEvent = false
end

slot0.instance = slot0.New()

return slot0
