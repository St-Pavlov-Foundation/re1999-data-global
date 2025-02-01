module("modules.logic.room.controller.RoomWaterReformController", package.seeall)

slot0 = class("RoomWaterReformController", BaseController)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
end

function slot0.selectWater(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return
	end

	if slot1:isInMapBlock() and slot1:hasRiver() then
		slot5 = nil

		for slot9 = 0, 6 do
			if slot1:getResourceId(slot9) == RoomResourceEnum.ResourceId.River then
				slot5 = slot9

				break
			end
		end

		RoomResourceModel.instance:clearLightResourcePoint()

		if RoomWaterReformModel.instance:getWaterAreaId(slot2.x, slot2.y, slot5) ~= RoomWaterReformModel.instance:getSelectAreaId() then
			RoomWaterReformModel.instance:setSelectWaterArea(slot6)
			RoomBlockHelper.refreshBlockEntity(slot0:getSelectWaterBlockEntityList(), "refreshBlock")
			slot0:refreshSelectWaterBlockEntity()
			slot0:dispatchEvent(RoomEvent.WaterReformSelectWaterChange)
		else
			slot0:clearSelectWater()
		end
	end
end

function slot0.clearSelectWater(slot0)
	RoomWaterReformModel.instance:setSelectWaterArea()
	RoomBlockHelper.refreshBlockEntity(slot0:getSelectWaterBlockEntityList(), "refreshBlock")
	slot0:dispatchEvent(RoomEvent.WaterReformSelectWaterChange)
end

function slot0.selectWaterType(slot0, slot1)
	if not RoomConfig.instance:getWaterReformTypeBlockId(slot1) then
		return
	end

	for slot7, slot8 in ipairs(slot0:getSelectWaterBlockEntityList()) do
		if slot8:getMO() then
			if slot1 ~= slot9:getTempWaterType() then
				slot9:setTempWaterType(slot1)
				RoomWaterReformModel.instance:recordChangeWaterType(slot9.id, slot1)
			end

			if (slot8:isHasWaterGradient() and slot9:getWaterType() or slot9:getOriginalWaterType()) == slot1 then
				RoomWaterReformModel.instance:clearChangeWaterRecord(slot9.id)
			end
		end
	end

	RoomWaterReformListModel.instance:setSelectWaterType(slot1)
	slot0:refreshSelectWaterBlockEntity()
	slot0:dispatchEvent(RoomEvent.WaterReformChangeWaterType)
end

function slot0.saveReform(slot0)
	if RoomWaterReformModel.instance:hasChangedWaterType() then
		if not RoomWaterReformModel.instance:getRecordChangeWaterType() then
			return
		end

		slot3 = {}

		for slot7, slot8 in pairs(slot2) do
			if not slot3[slot8] then
				if not RoomWaterReformModel.instance:isUnlockWaterReform(slot8) then
					GameFacade.showMessageBox(MessageBoxIdDefine.UsedLockedWaterReform, MsgBoxEnum.BoxType.Yes_No, slot0._usedLockWaterReformConfirmReset, nil, , slot0)

					return
				end

				slot3[slot8] = true
			end
		end

		RoomRpc.instance:sendSetWaterTypeRequest(slot2)
	end

	RoomMapController.instance:switchWaterReform(false)
end

function slot0._usedLockWaterReformConfirmReset(slot0)
	slot0:resetReform()
	RoomMapController.instance:switchWaterReform(false)
end

function slot0.resetReform(slot0)
	if not RoomWaterReformModel.instance:isWaterReform() then
		return
	end

	RoomWaterReformModel.instance:resetChangeWaterType()
	RoomWaterReformListModel.instance:setSelectWaterType(RoomWaterReformListModel.instance:getDefaultSelectWaterType())
	RoomBlockHelper.refreshBlockEntity(slot0:getAllWaterBlockEntityList(), "refreshBlock")
	slot0:dispatchEvent(RoomEvent.WaterReformChangeWaterType)
end

function slot0.refreshHighlightWaterBlock(slot0)
	RoomResourceModel.instance:clearLightResourcePoint()
	RoomMapController.instance:dispatchEvent(RoomEvent.ResourceLight)
end

function slot0.refreshSelectWaterBlockEntity(slot0)
	if not RoomWaterReformModel.instance:isWaterReform() then
		return
	end

	RoomBlockHelper.refreshBlockEntity(slot0:getSelectWaterBlockEntityList(), "refreshBlock")
end

function slot0.getSelectWaterBlockEntityList(slot0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room then
		return {}
	end

	if not RoomWaterReformModel.instance:hasSelectWaterArea() then
		return slot1
	end

	if not RoomWaterReformModel.instance:getSelectWaterResourcePointList() or not GameSceneMgr.instance:getCurScene() then
		return slot1
	end

	slot6 = {}

	for slot10, slot11 in ipairs(slot5) do
		slot13 = slot11.y

		if not slot6[slot11.x] or not slot6[slot12][slot13] then
			slot6[slot12] = slot6[slot12] or {}
			slot6[slot12][slot13] = true
			slot1[#slot1 + 1] = RoomMapBlockModel.instance:getBlockMO(slot12, slot13) and slot4.mapmgr:getBlockEntity(slot14.id, SceneTag.RoomMapBlock)
		end
	end

	return slot1
end

function slot0.getAllWaterBlockEntityList(slot0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room then
		return {}
	end

	if not GameSceneMgr.instance:getCurScene() then
		return slot1
	end

	slot4 = {}

	for slot9, slot10 in ipairs(RoomWaterReformModel.instance:getWaterAreaList()) do
		for slot14, slot15 in ipairs(slot10) do
			slot17 = slot15.y

			if not slot4[slot15.x] or not slot4[slot16][slot17] then
				slot4[slot16] = slot4[slot16] or {}
				slot4[slot16][slot17] = true
				slot1[#slot1 + 1] = RoomMapBlockModel.instance:getBlockMO(slot16, slot17) and slot3.mapmgr:getBlockEntity(slot18.id, SceneTag.RoomMapBlock)
			end
		end
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
