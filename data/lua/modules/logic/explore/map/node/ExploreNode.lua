module("modules.logic.explore.map.node.ExploreNode", package.seeall)

slot0 = class("ExploreNode")

function slot0.ctor(slot0, slot1)
	slot0.open = true
	slot0.pos = Vector3.zero
	slot0.openKeyDic = {}
	slot0.keyOpen = true
	slot0.height = slot1[3] or 0
	slot0.areaId = slot1[4] or 0
	slot0.cameraId = slot1[5] or 0
	slot0.nodeType = ExploreEnum.NodeType.Normal
	slot0.rawHeight = slot0.height
	slot0._canPassItem = true

	slot0:setWalkableKey(ExploreHelper.getKeyXY(slot1[1], slot1[2]))
end

function slot0.setNodeType(slot0, slot1)
	slot0.nodeType = slot1
end

function slot0.isWalkable(slot0, slot1, slot2)
	if not ExploreModel.instance:isAreaShow(slot0.areaId) then
		return false
	end

	if not slot2 and not slot0._canPassItem and slot0:isRoleUseItem() then
		return false
	end

	return (slot1 or slot0.height) == slot0.height and slot0.open and slot0.keyOpen
end

function slot0.isRoleUseItem(slot0)
	if ExploreController.instance:getMap():getNowStatus() == ExploreEnum.MapStatus.MoveUnit then
		return true
	end

	if ExploreBackpackModel.instance:getById(ExploreModel.instance:getUseItemUid()) and slot4.itemEffect == ExploreEnum.ItemEffect.Active then
		return true
	end

	if slot1:getUnit(tonumber(slot3), true) and slot5:getUnitType() == ExploreEnum.ItemType.PipePot then
		return true
	end

	return false
end

function slot0.setWalkableKey(slot0, slot1)
	slot0.pos.x, slot0.pos.y = ExploreHelper.getXYByKey(slot1)
	slot0.walkableKey = slot1
end

function slot0.setCanPassItem(slot0, slot1)
	slot0._canPassItem = slot1
end

function slot0.updateOpenKey(slot0, slot1, slot2)
	if slot2 then
		slot0.openKeyDic[slot1] = nil
	else
		slot0.openKeyDic[slot1] = slot2
	end

	slot0.keyOpen = true

	for slot6, slot7 in pairs(slot0.openKeyDic) do
		slot0.keyOpen = false

		break
	end
end

return slot0
