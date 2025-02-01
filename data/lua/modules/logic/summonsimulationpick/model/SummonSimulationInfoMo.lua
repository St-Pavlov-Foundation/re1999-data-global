module("modules.logic.summonsimulationpick.model.SummonSimulationInfoMo", package.seeall)

slot0 = pureTable("SummonSimulationInfoMo")

function slot0.ctor(slot0)
	slot0.activityId = 0
	slot0.leftTimes = 0
	slot0.saveHeroIds = {}
	slot0.currentHeroIds = {}
	slot0.isSelect = false
	slot0.saveIndex = 0
end

function slot0.update(slot0, slot1, slot2)
	slot0.activityId = slot1.activityId
	slot0.leftTimes = slot1.leftTimes
	slot0.saveHeroIds = slot1.savedHeroIds
	slot0.currentHeroIds = slot1.currHeroIds
	slot0.isSelect = slot1.isSelect
	slot0.maxCount = SummonSimulationPickModel.instance:getActivityMaxSummonCount(slot0.activityId)
	slot0.saveIndex = math.max(0, slot3 - slot1.leftTimes - (slot2 and 0 or 1))

	SummonModel.sortResultByHeroIds(slot0.currentHeroIds)
	SummonModel.sortResultByHeroIds(slot0.saveHeroIds)
end

function slot0.haveSaveCurrent(slot0)
	return slot0.saveIndex == slot0.maxCount - slot0.leftTimes or slot0.saveIndex == 0 or #slot0.currentHeroIds <= 0
end

function slot0.haveSelect(slot0)
	if slot0.leftTimes == slot0.maxCount - 1 then
		return true
	elseif slot0.leftTimes == 0 then
		return false
	else
		return slot0:haveSaveCurrent()
	end
end

return slot0
