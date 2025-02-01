module("modules.logic.summonsimulationpick.model.SummonSimulationPickModel", package.seeall)

slot0 = class("SummonSimulationPickModel", BaseModel)

function slot0.onInit(slot0)
	slot0._actInfo = {}
end

function slot0.reInit(slot0)
	slot0._actInfo = {}
end

function slot0.setActInfo(slot0, slot1, slot2, slot3)
	slot4 = slot0._actInfo[slot1] or SummonSimulationInfoMo.New()

	slot4:update(slot2, slot3)

	slot0._actInfo[slot1] = slot4
end

function slot0.getActInfo(slot0, slot1)
	return slot0._actInfo[slot1]
end

function slot0.isActivityOpen(slot0, slot1)
	slot2 = ServerTime.now() * 1000

	if not slot1 or not ActivityModel.instance:isActOnLine(slot1) then
		return false
	end

	if slot2 < ActivityModel.instance:getActStartTime(slot1) then
		return false
	end

	if ActivityModel.instance:getActEndTime(slot1) <= slot2 then
		return false
	end

	return true
end

function slot0.getActivityMaxSummonCount(slot0, slot1)
	if SummonSimulationPickConfig.instance:getSummonConfigById(slot1) and slot2.summonTimes then
		return slot2.summonTimes
	end

	return 0
end

slot0.instance = slot0.New()

return slot0
