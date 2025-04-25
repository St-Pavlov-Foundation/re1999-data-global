module("modules.logic.lifecircle.view.LifeCirclePickChoiceContainer", package.seeall)

slot0 = class("LifeCirclePickChoiceContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		LifeCirclePickChoice.New()
	}
end

return slot0
