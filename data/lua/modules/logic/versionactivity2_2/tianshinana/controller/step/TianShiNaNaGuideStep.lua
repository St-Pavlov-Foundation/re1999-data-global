module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaGuideStep", package.seeall)

slot0 = class("TianShiNaNaGuideStep", TianShiNaNaStepBase)

function slot0.onStart(slot0, slot1)
	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.OnGuideTrigger, tostring(slot0._data.guideId))
	slot0:onDone(true)
end

return slot0
