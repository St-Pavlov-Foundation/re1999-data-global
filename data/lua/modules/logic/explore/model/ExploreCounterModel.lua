module("modules.logic.explore.model.ExploreCounterModel", package.seeall)

slot0 = class("ExploreCounterModel", BaseModel)

function slot0.onInit(slot0)
	slot0:clearData()
end

function slot0.reInit(slot0)
	slot0:clearData()
end

function slot0.clearData(slot0)
	slot0._countDic = {}
end

function slot0.reCalcCount(slot0)
	for slot4, slot5 in pairs(slot0._countDic) do
		slot5:reCalcCount()
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.CounterInitDone)
end

function slot0.addCountSource(slot0, slot1, slot2)
	if slot0._countDic[slot1] == nil then
		slot3 = ExploreCounterMO.New()

		slot3:init(slot1)

		slot0._countDic[slot1] = slot3
	end

	slot3:addCountSource(slot2)
end

function slot0.add(slot0, slot1, slot2)
	if slot0._countDic[slot1] then
		slot5 = slot3:add(slot2)

		if slot3.nowCount ~= slot3.nowCount then
			ExploreController.instance:dispatchEvent(ExploreEvent.CounterChange, slot3.tarUnitId, slot3.nowCount)
		end

		if slot5 then
			ExploreController.instance:dispatchEvent(ExploreEvent.TryTriggerUnit, slot3.tarUnitId, true)
		end
	end
end

function slot0.reduce(slot0, slot1, slot2)
	if slot0._countDic[slot1] then
		slot5 = slot3:reduce(slot2)

		if slot3.nowCount ~= slot3.nowCount then
			ExploreController.instance:dispatchEvent(ExploreEvent.CounterChange, slot3.tarUnitId, slot3.nowCount)
		end

		if slot5 then
			ExploreController.instance:dispatchEvent(ExploreEvent.TryCancelTriggerUnit, slot3.tarUnitId)
		end
	end
end

function slot0.getCount(slot0, slot1)
	if slot0._countDic[slot1] then
		return slot2.nowCount
	else
		return 0
	end
end

function slot0.getTotalCount(slot0, slot1)
	if slot0._countDic[slot1] then
		return slot2.tarCount
	else
		return 0
	end
end

slot0.instance = slot0.New()

return slot0
