module("modules.logic.dispatch.model.DispatchModel", package.seeall)

slot0 = class("DispatchModel", BaseModel)

function slot1(slot0)
	slot0 = slot0 or {}
	slot1 = {
		elementId = slot0.elementId,
		dispatchId = slot0.dispatchId,
		endTime = slot0.endTime
	}
	slot2 = {}

	if slot0.heroIds then
		for slot6, slot7 in ipairs(slot0.heroIds) do
			slot2[#slot2 + 1] = slot7
		end
	end

	slot1.heroIdList = slot2

	return slot1
end

function slot0.onInit(slot0)
	slot0.dispatchedHeroDict = {}
	slot0.needCheckDispatchInfoList = {}
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.initDispatchInfos(slot0, slot1)
	slot0:clear()

	if not slot1 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		slot7 = DispatchInfoMo.New()

		slot7:init(uv0(slot6))
		slot0:addAtLast(slot7)

		if slot7:isRunning() then
			for slot13, slot14 in ipairs(slot7.heroIdList) do
				slot0.dispatchedHeroDict[slot14] = true
			end

			table.insert(slot0.needCheckDispatchInfoList, slot7)
		end
	end
end

function slot0.addDispatch(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0:getDispatchMo(uv0(slot1).elementId) then
		slot4:updateMO(slot2)
	else
		slot4 = DispatchInfoMo.New()

		slot4:init(slot2)
		slot0:addAtLast(slot4)
	end

	if slot4:isRunning() then
		for slot9, slot10 in ipairs(slot2.heroIdList) do
			slot0.dispatchedHeroDict[slot10] = true
		end

		table.insert(slot0.needCheckDispatchInfoList, slot4)
	end

	DispatchController.instance:dispatchEvent(DispatchEvent.AddDispatchInfo, slot2.dispatchId)
end

function slot0.removeDispatch(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0:getDispatchMo(slot1.elementId) then
		for slot7, slot8 in ipairs(slot3.heroIdList) do
			slot0.dispatchedHeroDict[slot8] = nil
		end

		tabletool.removeValue(slot0.needCheckDispatchInfoList, slot3)
		slot0:remove(slot3)
	end

	DispatchController.instance:dispatchEvent(DispatchEvent.RemoveDispatchInfo, slot3.dispatchId)
end

function slot0.getDispatchMo(slot0, slot1, slot2)
	if not slot1 then
		return nil
	end

	if slot0:getById(slot1) then
		if not slot2 or slot2 == slot4:getDispatchId() then
			slot3 = slot4
		else
			logError(string.format("DispatchModel.getDispatchMo error, dispatchId not equal,%s %s", slot2, slot5))
		end
	end

	return slot3
end

function slot0.getDispatchMoByDispatchId(slot0, slot1)
end

function slot0.getDispatchStatus(slot0, slot1, slot2)
	slot4 = DispatchEnum.DispatchStatus.NotDispatch

	if slot0:getDispatchMo(slot1, slot2) then
		slot4 = slot3:isFinish() and DispatchEnum.DispatchStatus.Finished or DispatchEnum.DispatchStatus.Dispatching
	end

	return slot4
end

function slot0.getDispatchTime(slot0, slot1)
	slot2 = string.format("%02d : %02d : %02d", 0, 0, 0)
	slot3 = DungeonConfig.instance:getElementDispatchId(slot1)

	if slot1 and slot3 and slot0:getDispatchMo(slot1, slot3) then
		slot2 = slot4:getRemainTimeStr()
	end

	return slot2
end

function slot0.isDispatched(slot0, slot1)
	return slot0.dispatchedHeroDict and slot0.dispatchedHeroDict[slot1]
end

function slot0.checkDispatchFinish(slot0)
	if (slot0.needCheckDispatchInfoList and #slot0.needCheckDispatchInfoList or 0) <= 0 then
		return
	end

	slot2 = false

	for slot6 = slot1, 1, -1 do
		if slot0.needCheckDispatchInfoList[slot6]:isFinish() then
			slot2 = true

			for slot12, slot13 in ipairs(slot7.heroIdList) do
				slot0.dispatchedHeroDict[slot13] = nil
			end

			table.remove(slot0.needCheckDispatchInfoList, slot6)
		end
	end

	if slot2 then
		DispatchController.instance:dispatchEvent(DispatchEvent.OnDispatchFinish)
		RedDotRpc.instance:sendGetRedDotInfosRequest({
			RedDotEnum.DotNode.V1a8FactoryMapDispatchFinish
		})
	end
end

slot0.instance = slot0.New()

return slot0
