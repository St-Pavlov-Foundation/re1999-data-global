module("modules.logic.room.entity.comp.placeeff.RoomPlaceBlockEffectComp", package.seeall)

slot0 = class("RoomPlaceBlockEffectComp", RoomBaseBlockEffectComp)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)

	slot0._hexPointList = {}

	tabletool.addValues(slot0._hexPointList, RoomMapHexPointModel.instance:getHexPointList())
end

function slot0.addEventListeners(slot0)
	RoomMapController.instance:registerCallback(RoomEvent.SelectBlock, slot0._refreshCanPlaceEffect, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.TransportPathViewShowChanged, slot0._refreshCanPlaceEffect, slot0)
	RoomWaterReformController.instance:registerCallback(RoomEvent.WaterReformShowChanged, slot0._refreshCanPlaceEffect, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.SelectBlock, slot0._refreshCanPlaceEffect, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportPathViewShowChanged, slot0._refreshCanPlaceEffect, slot0)
	RoomWaterReformController.instance:unregisterCallback(RoomEvent.WaterReformShowChanged, slot0._refreshCanPlaceEffect, slot0)
end

function slot0._refreshCanPlaceEffect(slot0)
	for slot9, slot10 in ipairs(slot0._hexPointList) do
		slot11 = slot0:getEffectKeyById(slot9)

		if slot0:_isCanShowPlaceEffect() and slot0:_checkByXY(slot10.x, slot10.y, RoomMapBlockModel.instance) then
			if not slot0.entity.effect:isHasKey(slot11) then
				if nil == nil then
					slot3 = {}
				end

				slot12 = HexMath.hexToPosition(slot10, RoomBlockEnum.BlockSize)
				slot3[slot11] = {
					res = RoomScenePreloader.ResEffectD03,
					localPos = Vector3(slot12.x, -0.12, slot12.y)
				}
			end
		elseif slot5:getEffectRes(slot11) then
			if slot4 == nil then
				slot4 = {}
			end

			table.insert(slot4, slot11)
		end
	end

	if slot3 then
		slot5:addParams(slot3)
		slot5:refreshEffect()
	end

	if slot4 then
		slot0:removeParamsAndPlayAnimator(slot4, "close", RoomBlockEnum.PlaceEffectAnimatorCloseTime)
	end
end

function slot0._checkByBlockMO(slot0, slot1)
	if RoomEnum.IsBlockNeedConnInit then
		if slot1 and slot1:canPlace() then
			return true
		end
	elseif not slot1 or slot1:canPlace() then
		return true
	end

	return false
end

function slot0._checkByXY(slot0, slot1, slot2, slot3)
	if slot3:getBlockMO(slot1, slot2) and slot4.blockState == RoomBlockEnum.BlockState.Map then
		return false
	end

	for slot8 = 1, 6 do
		slot9 = HexPoint.directions[slot8]

		if slot3:getBlockMO(slot1 + slot9.x, slot2 + slot9.y) and slot10.blockState == RoomBlockEnum.BlockState.Map then
			return true
		end
	end

	return false
end

function slot0._isCanShowPlaceEffect(slot0)
	if RoomBlockHelper.isCanPlaceBlock() and RoomInventoryBlockModel.instance:getSelectInventoryBlockId() and slot1 > 0 then
		return true
	end

	return false
end

function slot0.formatEffectKey(slot0, slot1)
	return slot1
end

return slot0
