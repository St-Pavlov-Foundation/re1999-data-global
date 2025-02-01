module("modules.logic.room.model.map.RoomWaterReformListModel", package.seeall)

slot0 = class("RoomWaterReformListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0:_clearData()
end

function slot0.reInit(slot0)
	slot0:_clearData()
end

function slot0.clear(slot0)
	slot0:_clearData()
	uv0.super.clear(slot0)
end

function slot0._clearData(slot0)
	if slot0._scrollViews then
		for slot4, slot5 in ipairs(slot0._scrollViews) do
			if slot5.setSelectList then
				slot5:setSelectList()
			end
		end
	end
end

function slot0.initShowBlock(slot0)
	slot0:setShowBlockList()
end

function slot0.setShowBlockList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(RoomConfig.instance:getWaterReformTypeList()) do
		slot1[#slot1 + 1] = {
			waterType = slot7,
			blockId = RoomConfig.instance:getWaterReformTypeBlockId(slot7),
			blockCfg = RoomConfig.instance:getWaterReformTypeBlockCfg(slot7)
		}
	end

	slot0:setList(slot1)
end

function slot0.setSelectWaterType(slot0, slot1)
	slot2 = nil

	for slot7, slot8 in ipairs(slot0:getList()) do
		if slot8.waterType and slot8.waterType == slot1 then
			slot2 = slot8

			break
		end
	end

	for slot7, slot8 in ipairs(slot0._scrollViews) do
		slot8:setSelect(slot2)
	end
end

function slot0.getDefaultSelectWaterType(slot0)
	if not RoomWaterReformModel.instance:hasSelectWaterArea() then
		return
	end

	slot2 = nil

	for slot7, slot8 in ipairs(RoomWaterReformModel.instance:getSelectWaterBlockMoList()) do
		slot9 = slot8:getDefineWaterType()

		if slot2 and slot2 ~= slot9 then
			slot2 = nil

			break
		end

		slot2 = slot9
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
