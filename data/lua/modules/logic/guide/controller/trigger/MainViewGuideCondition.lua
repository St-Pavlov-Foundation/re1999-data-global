module("modules.logic.guide.controller.trigger.MainViewGuideCondition", package.seeall)

slot0 = class("MainViewGuideCondition")

function slot0.getCondition(slot0)
	return uv0.guideConditions[slot0]
end

function slot0._checkRougeOpen()
	return RougeOutsideModel.instance:isUnlock() and not GuideModel.instance:isDoingClickGuide()
end

slot0.guideConditions = {
	[19701] = slot0._checkRougeOpen
}

return slot0
