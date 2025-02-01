module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotCollectionBagController", package.seeall)

slot0 = class("V1a6_CachotCollectionBagController", BaseController)
slot1 = 1

function slot0.onOpenView(slot0)
	V1a6_CachotCollectionEnchantController.instance:registerCallback(V1a6_CachotEvent.OnSelectEnchantCollection, slot0.onEnchantViewSelectCollection, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateCollectionsInfo, slot0.onCollectionDataUpdate, slot0)
	V1a6_CachotCollectionBagListModel.instance:onInitData()
	slot0:onSelectBagItemByIndex(uv0)
end

function slot0.onCloseView(slot0)
	V1a6_CachotCollectionEnchantController.instance:unregisterCallback(V1a6_CachotEvent.OnSelectEnchantCollection, slot0.onEnchantViewSelectCollection, slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateCollectionsInfo, slot0.onCollectionDataUpdate, slot0)
end

function slot0.onCollectionDataUpdate(slot0)
	V1a6_CachotCollectionBagListModel.instance:onCollectionDataUpdate()
	slot0:notifyViewUpdate()
end

function slot0.onSelectBagItemByIndex(slot0, slot1)
	V1a6_CachotCollectionBagListModel.instance:selectCell(slot1, true)
	slot0:notifyViewUpdate(V1a6_CachotCollectionBagListModel.instance:getByIndex(slot1) and slot2.id)
end

function slot0.onSelectBagItemById(slot0, slot1)
	V1a6_CachotCollectionBagListModel.instance:selectCell(V1a6_CachotCollectionBagListModel.instance:getIndex(V1a6_CachotCollectionBagListModel.instance:getById(slot1)), true)
	slot0:notifyViewUpdate(slot1)
end

function slot0.onEnchantViewSelectCollection(slot0, slot1)
	slot0:onSelectBagItemById(slot1)
end

function slot0.notifyViewUpdate(slot0, slot1)
	slot0:dispatchEvent(V1a6_CachotEvent.OnSelectBagCollection, slot1)
end

function slot0.moveCollectionWithHole2TopAndSelect(slot0)
	if V1a6_CachotCollectionBagListModel.instance:moveCollectionWithHole2Top() then
		slot0:onSelectBagItemByIndex(uv0)
	end

	return slot1
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
