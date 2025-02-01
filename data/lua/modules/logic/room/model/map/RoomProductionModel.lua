module("modules.logic.room.model.map.RoomProductionModel", package.seeall)

slot0 = class("RoomProductionModel", BaseModel)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)
	TaskDispatcher.cancelTask(slot0._OnTimeNextFinish, slot0)

	slot0._unlockAnimLineIdDict = {}
	slot0._unlockDetailAnimLineIdDict = {}
end

function slot0.updateProductionLines(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if slot7.id ~= 0 then
			slot8 = slot0:getLineMO(slot7.id)

			slot8:updateInfo(slot7)
			table.insert(slot2, slot8)
		end
	end

	slot0:addList(slot2)
	RoomController.instance:dispatchEvent(RoomEvent.UpdateProduceLineData)

	slot4, slot5 = nil
	slot7 = {}

	for slot11, slot12 in ipairs(slot0:getList()) do
		if slot12.nextFinishTime > 0 and slot12.pauseTime == 0 then
			if slot4 == nil or slot12.nextFinishTime < slot4 then
				slot5 = slot12.nextFinishTime - ServerTime.now()

				table.insert({}, slot12.id)
			elseif slot12.nextFinishTime == slot4 then
				table.insert(slot7, slot12.id)
			end
		end
	end

	slot0:updateNextFinishList(slot7, slot5)
end

function slot0.updateNextFinishList(slot0, slot1, slot2)
	slot0._nextFinishList = slot1

	TaskDispatcher.cancelTask(slot0._OnTimeNextFinish, slot0)

	if slot2 then
		TaskDispatcher.runDelay(slot0._OnTimeNextFinish, slot0, math.max(1, slot2) + 0.5)
	end
end

function slot0._OnTimeNextFinish(slot0, slot1)
	RoomRpc.instance:sendProductionLineInfoRequest(slot1)
end

function slot0.updateProductionLinesLevel(slot0, slot1, slot2)
	slot0:getLineMO(slot1):updateLevel(slot2)
	RoomController.instance:dispatchEvent(RoomEvent.UpdateProduceLineData)
	RoomController.instance:dispatchEvent(RoomEvent.ProduceLineLevelUp)
end

function slot0.getLineMO(slot0, slot1)
	if slot0:getById(slot1) == nil then
		RoomProductionLineMO.New():init(slot1)
	end

	return slot2
end

function slot0.updateLineMaxLevel(slot0)
	for slot5, slot6 in ipairs(slot0:getList()) do
		slot6:updateMaxLevel()
	end
end

function slot0.checkUnlockLine(slot0, slot1)
	for slot5, slot6 in ipairs(lua_production_line.configList) do
		if not RoomProductionHelper.isLineUnlock(slot6.id, slot1 - 1) and RoomProductionHelper.isLineUnlock(slot7, slot1) then
			slot0:setPlayLineUnlock(slot7, true)
			slot0:setPlayLineUnlockDetail(slot7, true)
		end
	end
end

function slot0.shouldPlayLineUnlock(slot0, slot1)
	return slot0._unlockAnimLineIdDict[slot1]
end

function slot0.setPlayLineUnlock(slot0, slot1, slot2)
	slot0._unlockAnimLineIdDict[slot1] = slot2
end

function slot0.shouldPlayLineUnlockDetail(slot0, slot1)
	return slot0._unlockDetailAnimLineIdDict[slot1]
end

function slot0.setPlayLineUnlockDetail(slot0, slot1, slot2)
	slot0._unlockDetailAnimLineIdDict[slot1] = slot2
end

slot0.instance = slot0.New()

return slot0
