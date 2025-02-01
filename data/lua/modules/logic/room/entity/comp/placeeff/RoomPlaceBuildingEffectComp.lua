module("modules.logic.room.entity.comp.placeeff.RoomPlaceBuildingEffectComp", package.seeall)

slot0 = class("RoomPlaceBuildingEffectComp", RoomBaseBlockEffectComp)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)

	slot0.entity = slot1
	slot0._effectPrefixKey = RoomEnum.EffectKey.BuilidCanPlaceKey
end

function slot0.addEventListeners(slot0)
	RoomMapController.instance:registerCallback(RoomEvent.BuildingCanConfirm, slot0._refreshBuildingConfirmEffect, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.BuildingCanConfirm, slot0._refreshBuildingConfirmEffect, slot0)
end

function slot0._refreshBuildingConfirmEffect(slot0)
	slot2 = nil
	slot3 = false

	if RoomMapBuildingModel.instance:getTempBuildingMO() and RoomBuildingController.instance:isBuildingListShow() then
		slot3 = true
		slot2 = slot1.uid
	end

	if slot0._lastBuildingUid == slot2 then
		return
	end

	slot0._lastBuildingUid = slot2
	slot5 = RoomResourceModel.instance
	slot6, slot7 = nil
	slot8 = RoomMapBlockModel.instance:getFullBlockMOList()
	slot9 = false
	slot10 = nil

	if slot1 and slot1:isBuildingArea() and not slot1:isAreaMainBuilding() then
		slot9 = true
		slot10 = slot0:_getRangesHexPointList(slot1)
	end

	for slot15, slot16 in ipairs(slot8) do
		slot17 = slot16.hexPoint
		slot19 = true
		slot20 = slot0:getEffectKeyById(slot5:getIndexByXY(slot17.x, slot17.y))

		if slot3 and slot0:_checkBuildingAreaShow(slot9, slot17, slot10) then
			slot21 = slot0:_isCanNotConfirm(slot16, slot1)

			if not slot0.entity.effect:isHasKey(slot20) then
				if slot6 == nil then
					slot6 = {}
				end

				slot22, slot23 = HexMath.hexXYToPosXY(slot17.x, slot17.y, RoomBlockEnum.BlockSize)
				slot6[slot20] = {
					res = slot21 and RoomScenePreloader.ResEffectD04 or RoomScenePreloader.ResEffectD03,
					localPos = Vector3(slot22, 0, slot23)
				}
			end
		elseif slot11:getEffectRes(slot20) then
			if slot7 == nil then
				slot7 = {}
			end

			table.insert(slot7, slot20)
		end
	end

	if slot6 then
		slot11:addParams(slot6)
		slot11:refreshEffect()
	end

	if slot7 then
		slot0:removeParamsAndPlayAnimator(slot7, "close", RoomBlockEnum.PlaceEffectAnimatorCloseTime)
	end
end

function slot0._getRangesHexPointList(slot0, slot1)
	if slot1 and slot1:isBuildingArea() and not slot1:isAreaMainBuilding() and RoomMapBuildingAreaModel.instance:getAreaMOByBId(slot1.buildingId) then
		return slot2:getRangesHexPointList()
	end

	return nil
end

function slot0._checkBuildingAreaShow(slot0, slot1, slot2, slot3)
	if slot1 and not RoomBuildingHelper.isInInitBlock(slot2) and (not slot3 or not tabletool.indexOf(slot3, slot2)) and not RoomMapBuildingModel.instance:getBuildingParam(slot2.x, slot2.y) then
		return false
	end

	return true
end

function slot0._isCanNotConfirm(slot0, slot1, slot2)
	if RoomBuildingHelper.isInInitBlock(slot1.hexPoint) then
		return true
	end

	if not slot2 then
		if RoomMapBuildingModel.instance:getBuildingParam(slot3.x, slot3.y) then
			return true
		end
	else
		if slot4 and slot4.buildingUid ~= slot2.uid then
			return true
		end

		if RoomTransportHelper.checkInLoadHexXY(slot3.x, slot3.y) then
			return true
		end

		return RoomBuildingHelper.checkBuildResId(slot2.buildingId, slot1:getResourceList(true)) == false
	end

	return false
end

return slot0
