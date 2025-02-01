module("modules.logic.activity.controller.chessmap.step.ActivityChessStepBase", package.seeall)

slot0 = class("ActivityChessStepBase")

function slot0.init(slot0, slot1)
	slot0.originData = slot1
end

function slot0.start(slot0)
end

function slot0.finish(slot0)
	if ActivityChessGameController.instance.event then
		slot1:nextStep()
	end
end

function slot0.dispose(slot0)
	slot0.originData = nil
end

return slot0
