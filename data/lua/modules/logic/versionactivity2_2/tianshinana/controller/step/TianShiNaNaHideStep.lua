module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaHideStep", package.seeall)

slot0 = class("TianShiNaNaHideStep", TianShiNaNaStepBase)

function slot0.onStart(slot0, slot1)
	TianShiNaNaModel.instance:removeUnit(slot0._data.id)
	slot0:onDone(true)
end

return slot0
