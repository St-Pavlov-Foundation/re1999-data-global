module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaUpdateRoundStep", package.seeall)

slot0 = class("TianShiNaNaUpdateRoundStep", TianShiNaNaStepBase)

function slot0.onStart(slot0)
	TianShiNaNaModel.instance.nowRound = slot0._data.currRound
	TianShiNaNaModel.instance.stepCount = slot0._data.stepCount
	TianShiNaNaModel.instance.waitClickJump = slot0._data.reason == 1

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.RoundUpdate, tostring(slot0._data.currRound + 1))

	if TianShiNaNaModel.instance.waitClickJump then
		TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.WaitClickJumpRound, slot0._onClick, slot0)
	else
		slot0:onDone(true)
	end
end

function slot0._onClick(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.WaitClickJumpRound, slot0._onClick, slot0)
end

return slot0
