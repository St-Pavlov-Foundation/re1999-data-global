module("modules.logic.rouge.controller.RougeCollectionChessController", package.seeall)

slot0 = class("RougeCollectionChessController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.onOpen(slot0)
	RougeCollectionBagListModel.instance:onInitData()
end

function slot0.placeCollection2SlotArea(slot0, slot1, slot2, slot3)
	if not RougeCollectionModel.instance:getCollectionByUid(slot1) then
		return
	end

	if slot4:getLeftTopPos().x ~= slot2.x or slot5.y ~= slot2.y then
		RougeController.instance:dispatchEvent(RougeEvent.AdjustBackPack)
	elseif slot3 and slot3 ~= slot4:getRotation() then
		RougeController.instance:dispatchEvent(RougeEvent.AdjustBackPack)
	end

	RougeRpc.instance:sendRougeAddToBarRequest(slot1, slot2, slot3)
end

function slot0.removeCollectionFromSlotArea(slot0, slot1)
	if RougeCollectionModel.instance:isCollectionPlaceInBag(slot1) then
		return
	end

	RougeRpc.instance:sendRougeRemoveFromBarRequest(slot1)
end

function slot0.rotateCollection(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	RougeRpc.instance:sendRougeAddToBarRequest(slot1.id, RougeCollectionHelper.getCollectionTopLeftSlotPos(slot1.cfgId, slot1:getCenterSlotPos(), slot2), slot2)
end

function slot0.onKeyPlaceCollection2SlotArea(slot0)
	if RougeModel.instance:getSeason() and RougeCollectionModel.instance:getBagAreaCollectionCount() > 0 then
		RougeRpc.instance:sendRougeOneKeyAddToBarRequest(slot1)
	end
end

function slot0.onKeyClearCollectionSlotArea(slot0)
	slot2 = RougeCollectionModel.instance:getSlotAreaCollectionCount()

	if RougeModel.instance:getSeason() and slot2 > 0 then
		slot4 = {}
		slot5 = {}

		for slot9 = #RougeCollectionModel.instance:getSlotAreaCollection(), 1, -1 do
			if RougeCollectionConfig.instance:getCollectionCfg(slot3[slot9] and slot10.cfgId) and not slot12.unremovable then
				table.insert(slot4, slot10.id)
			else
				table.insert(slot5, slot10.cfgId)
			end
		end

		if slot2 > #slot4 then
			for slot9 = #slot4, 1, -1 do
				uv0.instance:removeCollectionFromSlotArea(slot4[slot9])
			end

			for slot9, slot10 in ipairs(slot5) do
				GameFacade.showToast(ToastEnum.RougeUnRemovableCollection, RougeCollectionConfig.instance:getCollectionName(slot10))
			end
		else
			RougeRpc.instance:sendRougeOneKeyRemoveFromBarRequest(slot1)
		end
	end
end

function slot0.autoPlaceCollection2SlotArea(slot0, slot1)
	if not RougeCollectionModel.instance:getCollectionByUid(slot1) then
		return
	end

	RougeRpc.instance:sendRougeAddToBarRequest(slot1, Vector2(-1, -1), 0)
end

function slot0.try2OpenCollectionTipView(slot0, slot1, slot2)
	if not slot1 or slot1 <= 0 then
		return
	end

	RougeController.instance:openRougeCollectionTipView(slot2)
end

function slot0.closeCollectionTipView(slot0)
	ViewMgr.instance:closeView(ViewName.RougeCollectionTipView)
end

function slot0.selectCollection(slot0, slot1)
	RougeCollectionBagListModel.instance:markCurSelectCollectionId(slot1)
	uv0.instance:dispatchEvent(RougeEvent.SelectCollection)

	if not slot1 or slot1 <= 0 then
		slot0:closeCollectionTipView()
	end
end

function slot0.deselectCollection(slot0)
	slot0:selectCollection(nil)
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
