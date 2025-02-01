module("modules.logic.explore.model.mo.unit.ExploreSpikeUnitMO", package.seeall)

slot0 = pureTable("ExploreSpikeUnitMO", ExploreBaseUnitMO)

function slot0.initTypeData(slot0)
	slot2 = string.split(slot0.specialDatas[2], "#")
	slot0.intervalTime = tonumber(slot2[1])
	slot0.keepTime = tonumber(slot2[2])
	slot0.playAudio = tonumber(slot2[3]) == 1
	slot0.enterTriggerType = true
	slot0.heroDir = tonumber(string.split(slot0.specialDatas[1], "#")[3]) or 0
	slot0.triggerEffects = tabletool.copy(slot0.triggerEffects)

	table.insert(slot0.triggerEffects, {
		ExploreEnum.TriggerEvent.Spike
	})
end

function slot0.getUnitClass(slot0)
	return ExploreSpikeUnit
end

return slot0
