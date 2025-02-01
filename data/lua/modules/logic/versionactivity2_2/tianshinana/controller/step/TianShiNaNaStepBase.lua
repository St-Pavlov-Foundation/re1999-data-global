module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaStepBase", package.seeall)

slot0 = class("TianShiNaNaStepBase", BaseWork)

function slot0.initData(slot0, slot1)
	slot0._data = slot1
end

function slot0.onStart(slot0, slot1)
	slot0:onDone(true)
end

return slot0
