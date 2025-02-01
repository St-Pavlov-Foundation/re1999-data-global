module("modules.logic.explore.model.mo.ExploreInteractOptionMO", package.seeall)

slot0 = class("ExploreInteractOptionMO")

function slot0.ctor(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.optionTxt = slot1
	slot0.optionCallBack = slot2
	slot0.optionCallObj = slot3
	slot0.unit = slot4
	slot0.isClient = slot5
end

return slot0
