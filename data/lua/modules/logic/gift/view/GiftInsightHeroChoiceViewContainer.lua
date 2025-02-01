module("modules.logic.gift.view.GiftInsightHeroChoiceViewContainer", package.seeall)

slot0 = class("GiftInsightHeroChoiceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, GiftInsightHeroChoiceView.New())

	return slot1
end

return slot0
