module("modules.logic.guide.controller.GuideSpecialController", package.seeall)

slot0 = class("GuideSpecialController", BaseController)

function slot0.onInitFinish(slot0)
	slot0._guideJumpHandler = GuideJumpHandler.New()
end

function slot0.reInit(slot0)
	slot0._guideJumpHandler:reInit()
end

slot0.instance = slot0.New()

return slot0
