module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotCollectionEnchantController", package.seeall)

slot0 = class("V1a6_CachotCollectionEnchantController", BaseController)
slot1 = 1

function slot0.onOpenView(slot0, slot1)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateCollectionsInfo, slot0.onUpdateBagCollectionInfo, slot0)
	slot0:onInit(slot1, V1a6_CachotEnum.CollectionHole.Left, true)
end

function slot0.onCloseView(slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateCollectionsInfo, slot0.onUpdateBagCollectionInfo, slot0)
	V1a6_CachotEnchantBagListModel.instance:reInit()
	V1a6_CachotCollectionEnchantListModel.instance:reInit()
end

function slot0.onInit(slot0, slot1, slot2, slot3)
	V1a6_CachotEnchantBagListModel.instance:onInitData()
	V1a6_CachotCollectionEnchantListModel.instance:onInitData(slot3)
	slot0:onSelectBagItem(V1a6_CachotEnchantBagListModel.instance:getById(slot1) and V1a6_CachotEnchantBagListModel.instance:getIndex(slot4), slot2)
end

function slot0.onUpdateBagCollectionInfo(slot0)
	slot0:onInit(V1a6_CachotEnchantBagListModel.instance:getCurSelectCollectionId(), V1a6_CachotEnchantBagListModel.instance:getCurSelectHoleIndex(), false)
end

function slot0.onSelectBagItem(slot0, slot1, slot2)
	slot3 = nil

	if V1a6_CachotEnchantBagListModel.instance:getByIndex(slot1) then
		if not V1a6_CachotCollectionConfig.instance:getCollectionConfig(slot4.cfgId) or slot5.type == V1a6_CachotEnum.CollectionType.Enchant or slot5.holeNum <= 0 then
			ToastController.instance:showToast(ToastEnum.V1a6Cachot_Unable2Enchant)

			return
		end
	else
		return
	end

	slot2 = slot2 or V1a6_CachotEnum.CollectionHole.Left

	V1a6_CachotEnchantBagListModel.instance:selectCell(slot4.id, true)
	V1a6_CachotEnchantBagListModel.instance:markCurSelectHoleIndex(slot2)
	slot0:onSelectEnchantItem(slot4:getEnchantId(slot2))
	slot0:notifyViewUpdate()
end

function slot0.onSelectEnchantItem(slot0, slot1, slot2)
	V1a6_CachotCollectionEnchantListModel.instance:selectCell(slot1, true)

	if slot2 then
		slot4 = V1a6_CachotEnchantBagListModel.instance:getCurSelectHoleIndex()

		slot0:trySendRogueCollectionEnchantRequest(slot3, (V1a6_CachotEnchantBagListModel.instance:getById(V1a6_CachotEnchantBagListModel.instance:getCurSelectCollectionId()) and slot5:getEnchantId(slot4)) ~= slot1 and slot1 or V1a6_CachotEnum.EmptyEnchantId, slot4)
	end
end

function slot0.trySendRogueCollectionEnchantRequest(slot0, slot1, slot2, slot3)
	if slot1 == nil then
		return
	end

	slot2 = slot2 or V1a6_CachotEnum.EmptyEnchantId
	slot4 = slot0:tryRemoveEnchant(slot2)

	if slot0:tryEnchant2EmptyHole(slot1, slot2, slot3) and slot4 and slot4 ~= slot1 then
		ToastController.instance:showToast(ToastEnum.V1a6Cachot_HasEnchant)
	end
end

function slot0.tryRemoveEnchant(slot0, slot1)
	if V1a6_CachotEnchantBagListModel.instance:getById(V1a6_CachotCollectionEnchantListModel.instance:getById(slot1) and slot2.enchantUid) then
		slot6 = slot4:getEnchantId(V1a6_CachotEnum.CollectionHole.Right)

		RogueRpc.instance:sendRogueCollectionEnchantRequest(V1a6_CachotEnum.ActivityId, slot3, slot1 == slot4:getEnchantId(V1a6_CachotEnum.CollectionHole.Left) and V1a6_CachotEnum.EmptyEnchantId or slot5, slot1 == slot6 and V1a6_CachotEnum.EmptyEnchantId or slot6)

		return slot3
	end
end

function slot0.tryEnchant2EmptyHole(slot0, slot1, slot2, slot3)
	if V1a6_CachotEnchantBagListModel.instance:getById(slot1) then
		if (slot3 == V1a6_CachotEnum.CollectionHole.Left and slot2 or slot4:getEnchantId(V1a6_CachotEnum.CollectionHole.Left)) == (slot3 == V1a6_CachotEnum.CollectionHole.Right and slot2 or slot4:getEnchantId(V1a6_CachotEnum.CollectionHole.Right)) then
			slot7 = slot3 == V1a6_CachotEnum.CollectionHole.Left and slot7 or V1a6_CachotEnum.EmptyEnchantId
			slot8 = slot3 == V1a6_CachotEnum.CollectionHole.Right and slot8 or V1a6_CachotEnum.EmptyEnchantId
		end

		RogueRpc.instance:sendRogueCollectionEnchantRequest(V1a6_CachotEnum.ActivityId, slot1, slot7, slot8)

		return true
	end
end

function slot0.onSelectHoleGrid(slot0, slot1, slot2)
	V1a6_CachotEnchantBagListModel.instance:markCurSelectHoleIndex(slot1)

	if not slot2 then
		return
	end

	if V1a6_CachotEnchantBagListModel.instance:getById(V1a6_CachotEnchantBagListModel.instance:getCurSelectCollectionId()) and slot4:getEnchantId(slot1) and slot5 ~= V1a6_CachotEnum.EmptyEnchantId then
		slot0:trySendRogueCollectionEnchantRequest(slot3, V1a6_CachotEnum.EmptyEnchantId, slot1)
	end
end

function slot0.switchCategory(slot0, slot1)
	if slot1 ~= V1a6_CachotEnchantBagListModel.instance:getCurSelectCategory() then
		V1a6_CachotEnchantBagListModel.instance:switchCategory(slot1)
		slot0:onSelectBagItem(uv0)
	end
end

function slot0.notifyViewUpdate(slot0)
	uv0.instance:dispatchEvent(V1a6_CachotEvent.OnSelectEnchantCollection, V1a6_CachotEnchantBagListModel.instance:getCurSelectCollectionId())
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
