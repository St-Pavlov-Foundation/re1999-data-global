module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaMapCollapseStep", package.seeall)

slot0 = class("TianShiNaNaMapCollapseStep", BaseWork)

function slot0.onStart(slot0, slot1)
	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.CheckMapCollapse)
	slot0:onDone(true)
end

return slot0
