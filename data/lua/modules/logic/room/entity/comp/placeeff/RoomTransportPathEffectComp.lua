module("modules.logic.room.entity.comp.placeeff.RoomTransportPathEffectComp", package.seeall)

slot0 = class("RoomTransportPathEffectComp", RoomBaseBlockEffectComp)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)

	slot0.entity = slot1
	slot0._effectPrefixKey = "transport_path"
	slot0._blockParamPools = {}
	slot0.delayTaskTime = 0.05
	slot0._effectId = {
		SiteCollect = 4,
		SiteProcess = 5,
		BlockManufacture = 3,
		BlockCollect = 1,
		BlockNotCan = 8,
		BlockProcess = 2,
		SiteManufacture = 6
	}
	slot0._effectResMap = {
		[slot0._effectId.BlockCollect] = RoomScenePreloader.ResEffectBlue01,
		[slot0._effectId.BlockProcess] = RoomScenePreloader.ResEffectYellow01,
		[slot0._effectId.BlockManufacture] = RoomScenePreloader.ResEffectGreen01,
		[slot0._effectId.SiteCollect] = RoomScenePreloader.ResEffectBlue02,
		[slot0._effectId.SiteProcess] = RoomScenePreloader.ResEffectYellow02,
		[slot0._effectId.SiteManufacture] = RoomScenePreloader.ResEffectGreen02,
		[slot0._effectId.BlockNotCan] = RoomScenePreloader.ResEffectRed01
	}
	slot0._stieType2IdMap = {
		[RoomBuildingEnum.BuildingType.Collect] = slot0._effectId.SiteCollect,
		[RoomBuildingEnum.BuildingType.Process] = slot0._effectId.SiteProcess,
		[RoomBuildingEnum.BuildingType.Manufacture] = slot0._effectId.SiteManufacture
	}
	slot0._buildingType2IdMap = {
		[RoomBuildingEnum.BuildingType.Collect] = slot0._effectId.BlockCollect,
		[RoomBuildingEnum.BuildingType.Process] = slot0._effectId.BlockProcess,
		[RoomBuildingEnum.BuildingType.Manufacture] = slot0._effectId.BlockManufacture
	}
end

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._tRoomResourceModel = RoomResourceModel.instance
end

function slot0.addEventListeners(slot0)
	RoomMapController.instance:registerCallback(RoomEvent.TransportPathConfirmChange, slot0._refreshConfirmEffect, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.TransportPathLineChanged, slot0.startWaitRunDelayTask, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.TransportPathViewShowChanged, slot0.startWaitRunDelayTask, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportPathConfirmChange, slot0._refreshConfirmEffect, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportPathLineChanged, slot0.startWaitRunDelayTask, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportPathViewShowChanged, slot0.startWaitRunDelayTask, slot0)
end

function slot0.onRunDelayTask(slot0)
	slot0:_refreshConfirmEffect()
end

function slot0._refreshConfirmEffect(slot0)
	slot1 = slot0:_getBlackIndexDict()
	slot2, slot3 = nil
	slot4 = slot0.entity.effect
	slot5 = slot0._lastIndexDict
	slot0._lastIndexDict = slot1
	slot0._tRoomResourceModel = RoomResourceModel.instance

	if slot1 then
		for slot9, slot10 in pairs(slot1) do
			if slot10 and not slot0:_checkParamsSame(slot10, slot5 and slot5[slot9]) then
				slot12 = slot0:getEffectKeyById(slot9)

				if slot2 == nil then
					slot2 = {}
				end

				slot13, slot14 = HexMath.hexXYToPosXY(slot10.hexPoint.x, slot10.hexPoint.y, RoomBlockEnum.BlockSize)
				slot2[slot12] = {
					res = slot0._effectResMap[slot10.effectId],
					localPos = Vector3(slot13, 0, slot14)
				}
			end
		end
	end

	if slot5 then
		for slot9, slot10 in pairs(slot5) do
			if (not slot1 or not slot1[slot9]) and slot4:isHasKey(slot0:getEffectKeyById(slot9)) then
				if slot3 == nil then
					slot3 = {}
				end

				table.insert(slot3, slot11)
			end

			slot0:_pushParam(slot10)
		end
	end

	if slot2 then
		slot4:addParams(slot2)
		slot4:refreshEffect()
	end

	if slot3 then
		slot0:removeParamsAndPlayAnimator(slot3, "close", RoomBlockEnum.PlaceEffectAnimatorCloseTime)
	end
end

function slot0._getBlackIndexDict(slot0)
	if not RoomTransportController.instance:isTransportPathShow() then
		return nil
	end

	if not RoomTransportHelper.getPathBuildingTypes(RoomMapTransportPathModel.instance:getSelectBuildingType()) or #slot2 < 1 then
		return nil
	end

	slot4 = RoomMapBuildingAreaModel.instance
	slot5 = RoomMapHexPointModel.instance

	for slot9 = 1, #slot2 do
		if slot1:getSiteHexPointByType(slot2[slot9]) then
			slot0:_addParamDict({}, slot11, slot0._buildingType2IdMap[slot10], true)
		end
	end

	for slot9 = 1, #slot2 do
		if slot4:getAreaMOByBType(slot2[slot9]) and slot11.mainBuildingMO then
			slot12 = slot11.mainBuildingMO.hexPoint

			for slot17, slot18 in ipairs(RoomMapModel.instance:getBuildingPointList(slot11.mainBuildingMO.buildingId, slot11.mainBuildingMO.rotate)) do
				slot0:_addParamDict(slot3, slot5:getHexPoint(slot18.x + slot12.x, slot18.y + slot12.y), slot0._buildingType2IdMap[slot10], true)
			end
		end
	end

	for slot12, slot13 in ipairs(RoomMapBlockModel.instance:getFullBlockMOList()) do
		if not RoomTransportHelper.canPathByBlockMO(slot13, RoomMapTransportPathModel.instance:getIsRemoveBuilding()) then
			slot0:_addParamDict(slot3, slot13.hexPoint, slot0._effectId.BlockNotCan, true)
		end
	end

	slot9 = slot0._stieType2IdMap

	if (slot1.instance:getTempTransportPathMO() or slot1:getTransportPathMOBy2Type(slot2[1], slot2[2])) and slot10:isLinkFinish() then
		slot9 = slot0._buildingType2IdMap
	end

	for slot14 = 1, #slot2 do
		if slot4:getAreaMOByBType(slot2[slot14]) and slot16:getRangesHexPointList() then
			for slot21, slot22 in ipairs(slot17) do
				if slot6:getBlockMO(slot22.x, slot22.y) and slot23:isInMapBlock() then
					slot0:_addParamDict(slot3, slot22, slot9[slot15], false)
				end
			end
		end
	end

	return slot3
end

function slot0._checkParamsSame(slot0, slot1, slot2)
	if slot1 == nil or slot2 == nil then
		return false
	end

	if slot1.effectId ~= slot2.effectId or slot1.hexPoint ~= slot2.hexPoint then
		return false
	end

	return true
end

function slot0._addParamDict(slot0, slot1, slot2, slot3, slot4)
	if slot1[slot0._tRoomResourceModel:getIndexByXY(slot2.x, slot2.y) * 10] and (slot6.isOnly or slot4 or slot6.effectId == slot3) then
		return
	end

	if slot6 then
		while slot1[slot5] do
			slot5 = slot5 + 1
		end
	end

	slot7 = slot0:_popParam()
	slot7.effectId = slot3
	slot7.isOnly = slot4
	slot7.index = slot5
	slot7.hexPoint = slot2
	slot1[slot5] = slot7
end

function slot0._popParam(slot0)
	slot1 = nil

	if #slot0._blockParamPools > 0 then
		slot1 = slot0._blockParamPools[slot2]

		table.remove(slot0._blockParamPools, slot2)
	else
		slot1 = {}
	end

	return slot1
end

function slot0._pushParam(slot0, slot1)
	if slot1 then
		table.insert(slot0._blockParamPools, slot1)
	end
end

return slot0
