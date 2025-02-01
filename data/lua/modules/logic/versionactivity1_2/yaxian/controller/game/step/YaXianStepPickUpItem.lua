module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepPickUpItem", package.seeall)

slot0 = class("YaXianStepPickUpItem", YaXianStepBase)

function slot0.start(slot0)
	slot0:finish()
	logError("un handle Pick Up type")
end

function slot0.dispose(slot0)
end

return slot0
