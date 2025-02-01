module("modules.logic.explore.model.mo.unit.ExploreBonusSceneUnitMO", package.seeall)

slot0 = class("ExploreBonusSceneUnitMO", ExploreBaseUnitMO)

function slot0.initTypeData(slot0)
	slot0.triggerEffects = tabletool.copy(slot0.triggerEffects)

	if slot0.triggerEffects[1] and slot0.triggerEffects[1][1] == ExploreEnum.TriggerEvent.Dialogue then
		table.insert(slot0.triggerEffects, 2, {
			ExploreEnum.TriggerEvent.OpenBonusView
		})
	else
		table.insert(slot0.triggerEffects, 1, slot1)
	end
end

return slot0
