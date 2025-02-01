module("modules.logic.room.entity.comp.placeeff.RoomTransportPathLinkEffectComp", package.seeall)

slot0 = class("RoomTransportPathLinkEffectComp", RoomBaseBlockEffectComp)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)

	slot0.entity = slot1
	slot0._effectPrefixKey = "transport_path_line"
	slot0._lineParamPools = {}
end

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._tRoomResourceModel = RoomResourceModel.instance

	slot0:startWaitRunDelayTask()
end

function slot0.addEventListeners(slot0)
	RoomMapController.instance:registerCallback(RoomEvent.TransportPathLineChanged, slot0._refreshLineEffect, slot0)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, slot0.startWaitRunDelayTask, slot0)
	RoomController.instance:registerCallback(RoomEvent.OnLateInitDone, slot0.startWaitRunDelayTask, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.TransportPathViewShowChanged, slot0.startWaitRunDelayTask, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportPathLineChanged, slot0._refreshLineEffect, slot0)
	RoomController.instance:unregisterCallback(RoomEvent.OnSwitchModeDone, slot0.startWaitRunDelayTask, slot0)
	RoomController.instance:unregisterCallback(RoomEvent.OnLateInitDone, slot0.startWaitRunDelayTask, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportPathViewShowChanged, slot0.startWaitRunDelayTask, slot0)
end

function slot0.onRunDelayTask(slot0)
	slot0:_refreshLineEffect()
end

function slot0._refreshLineEffect(slot0)
	slot1 = slot0:_getLineTypeIndexDict()
	slot4 = slot0.entity.effect
	slot5 = slot0._lastIndexDict
	slot0._lastIndexDict = slot1

	for slot9, slot10 in pairs(slot1) do
		if slot10 and not slot0:_checkParamsSame(slot10, slot5 and slot5[slot9]) then
			slot12 = slot0:getEffectKeyById(slot9)

			if nil == nil then
				slot2 = {}
			end

			slot13 = HexMath.hexToPosition(slot10.hexPoint, RoomBlockEnum.BlockSize)
			slot2[slot12] = {
				res = RoomResHelper.getTransportPathPath(slot10.lineType, slot10.styleId),
				localPos = Vector3(slot13.x, 0.111, slot13.y),
				localRotation = Vector3(0, slot10.rotate * 60, 0)
			}
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

			slot0:_pushLineParam(slot10)
		end
	end

	if slot2 then
		slot4:addParams(slot2)
		slot4:refreshEffect()
	end

	if slot3 then
		slot4:removeParams(slot3)
		slot4:refreshEffect()
	end
end

function slot0._getResPath(slot0, slot1, slot2)
	if slot1 and slot1:checkHexPoint(slot2) then
		-- Nothing
	end
end

function slot0._checkParamsSame(slot0, slot1, slot2)
	if slot1 == nil or slot2 == nil then
		return false
	end

	if slot1.rotate ~= slot2.rotate or slot1.hexPoint ~= slot2.hexPoint or slot1.lineType ~= slot2.lineType or slot1.styleId ~= slot2.styleId then
		return false
	end

	return true
end

function slot0._getSelectPathMO(slot0)
	if RoomMapTransportPathModel.instance:getTempTransportPathMO() then
		return slot1
	end

	if RoomMapTransportPathModel.instance:getSelectBuildingType() then
		slot3, slot4 = RoomTransportHelper.getSiteFromToByType(slot2)
		slot1 = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(slot3, slot4)
	end

	return slot1
end

function slot0._getLineTypeIndexDict(slot0)
	slot1 = {}
	slot2 = slot0:_getSelectPathMO()
	slot3 = RoomMapTransportPathModel.instance:getList()
	slot4 = nil
	slot5 = false
	slot6 = nil

	if RoomController.instance:isObMode() then
		slot6 = {}
		slot5 = true
		slot4 = RoomTransportPathEnum.StyleId.ObWater
	end

	for slot10, slot11 in ipairs(slot3) do
		slot12 = RoomTransportPathEnum.StyleId.NoLink

		if slot11:isLinkFinish() then
			slot12 = RoomTransportPathEnum.StyleId.EditLink

			if slot2 == slot11 then
				slot12 = RoomTransportPathEnum.StyleId.Normal
			end
		end

		if slot5 then
			slot12 = RoomTransportPathEnum.StyleId.ObLink

			slot0:_addSlotHexPointDict(slot6, slot11)
		end

		slot0:_addLineParamDict(slot1, slot11:getHexPointList(), slot12, slot4, slot5)
	end

	if slot6 then
		for slot10, slot11 in pairs(slot6) do
			slot12 = RoomTransportPathEnum.StyleId.ObLink

			if slot4 and slot0:_isWaterBlock(slot11.hexPoint) then
				slot12 = slot4
			end

			slot0:_addHexPintLineParamDict(slot1, slot12, slot11.hexPoint, slot11.prevHexPoint, slot11.nextHexPoint)
		end
	end

	return slot1
end

function slot0._addSlotHexPointDict(slot0, slot1, slot2)
	slot3 = slot2:getHexPointList()

	slot0:_addLinkHexPointDict(slot1, slot3[1], slot3[2])
	slot0:_addLinkHexPointDict(slot1, slot3[#slot3], slot3[#slot3 - 1])
end

function slot0._addLinkHexPointDict(slot0, slot1, slot2, slot3)
	if slot1[slot0._tRoomResourceModel:getIndexByXY(slot2.x, slot2.y)] then
		slot1[slot4].nextHexPoint = slot3
	else
		slot1[slot4] = {
			hexPoint = slot2,
			prevHexPoint = slot3
		}
	end
end

function slot0._addLineParamDict(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot2 and #slot2 > 0 then
		slot3 = slot3 or RoomTransportPathEnum.StyleId.Normal

		if slot5 == true then
			slot6 = 1 + 1
			slot7 = #(slot2 or {}) - 1
		end

		for slot11 = slot6, slot7 do
			slot12 = slot2[slot11]

			if slot4 and slot0:_isWaterBlock(slot12) then
				slot0:_addHexPintLineParamDict(slot1, slot4, slot12, slot2[slot11 - 1], slot2[slot11 + 1])
			else
				slot0:_addHexPintLineParamDict(slot1, slot3, slot12, slot13, slot14)
			end
		end
	end
end

function slot0._addHexPintLineParamDict(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6, slot7 = RoomTransportPathLinkHelper.getPtahLineType(slot3, slot4, slot5)

	if slot6 and slot7 then
		if slot1[slot0._tRoomResourceModel:getIndexByXY(slot3.x, slot3.y) * 10] then
			while slot1[slot8] do
				slot8 = slot8 + 1
			end
		end

		slot0:_popLineParam().lineType = slot6
		slot9.rotate = slot7 or 0
		slot9.hexPoint = slot3
		slot9.styleId = slot2
		slot1[slot8] = slot9
	end
end

function slot0._isWaterBlock(slot0, slot1)
	if RoomMapBlockModel.instance:getBlockMO(slot1.x, slot1.y) and slot2:hasRiver() then
		return true
	end

	return false
end

function slot0._popLineParam(slot0)
	slot1 = nil

	if #slot0._lineParamPools > 0 then
		slot1 = slot0._lineParamPools[slot2]

		table.remove(slot0._lineParamPools, slot2)
	else
		slot1 = {}
	end

	return slot1
end

function slot0._pushLineParam(slot0, slot1)
	if slot1 then
		table.insert(slot0._lineParamPools, slot1)
	end
end

return slot0
