module("modules.logic.explore.model.mo.unit.ExploreArchiveUnitMO", package.seeall)

slot0 = class("ExploreArchiveUnitMO", ExploreBaseUnitMO)

function slot0.initTypeData(slot0)
	slot0.archiveId = tonumber(slot0.specialDatas[1])
	slot0.triggerEffects = tabletool.copy(slot0.triggerEffects)
	slot1 = {
		ExploreEnum.TriggerEvent.OpenArchiveView
	}
	slot2 = nil

	for slot6, slot7 in ipairs(slot0.triggerEffects) do
		if slot7[1] == ExploreEnum.TriggerEvent.Dialogue then
			slot2 = slot6

			break
		end
	end

	if slot2 then
		table.insert(slot0.triggerEffects, slot2 + 1, slot1)
	else
		table.insert(slot0.triggerEffects, 1, slot1)
	end
end

return slot0
