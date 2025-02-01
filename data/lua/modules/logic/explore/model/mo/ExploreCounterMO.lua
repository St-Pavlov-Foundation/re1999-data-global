module("modules.logic.explore.model.mo.ExploreCounterMO", package.seeall)

slot0 = pureTable("ExploreCounterMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1
	slot0.tarUnitId = slot1
	slot0.dic = {}
	slot0.tarCount = 0
	slot0.nowCount = 0
end

function slot0.addTarCount(slot0)
	slot0.tarCount = slot0.tarCount + 1
end

function slot0.addCountSource(slot0, slot1)
	slot0.dic[slot1] = false
	slot0.tarCount = tabletool.len(slot0.dic)
end

function slot0.reCalcCount(slot0)
	for slot5 in pairs(slot0.dic) do
		slot0.dic[slot5] = ExploreMapModel.instance:getUnitDic()[slot5]:getInteractInfoMO():getBitByIndex(ExploreEnum.InteractIndex.ActiveState) == 1
	end

	slot0:updateNowCount()
end

function slot0.add(slot0, slot1)
	slot0.dic[slot1] = true

	slot0:updateNowCount()

	return slot0.nowCount < slot0.tarCount and slot0.tarCount <= slot0.nowCount
end

function slot0.reduce(slot0, slot1)
	slot0.dic[slot1] = false

	slot0:updateNowCount()

	return slot0.tarCount <= slot0.nowCount and slot0.nowCount < slot0.tarCount
end

function slot0.updateNowCount(slot0)
	slot0.nowCount = 0

	for slot4, slot5 in pairs(slot0.dic) do
		if slot5 then
			slot0.nowCount = slot0.nowCount + 1
		end
	end
end

return slot0
