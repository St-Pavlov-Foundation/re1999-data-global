module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepBase", package.seeall)

slot0 = class("YaXianStepBase")

function slot0.init(slot0, slot1, slot2)
	slot0.originData = slot1
	slot0.index = slot2
	slot0.originData.index = slot2
	slot0.stepType = slot0.originData.stepType
end

function slot0.start(slot0)
end

function slot0.finish(slot0)
	if YaXianGameController.instance.stepMgr then
		slot1:nextStep()
	end
end

function slot0.dispose(slot0)
end

return slot0
