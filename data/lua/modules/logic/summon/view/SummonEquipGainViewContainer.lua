module("modules.logic.summon.view.SummonEquipGainViewContainer", package.seeall)

slot0 = class("SummonEquipGainViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		EquipGetView.New(),
		SummonEquipGainView.New()
	}
end

return slot0
