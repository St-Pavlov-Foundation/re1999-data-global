module("modules.logic.herogroup.view.HeroGroupFightRuleDescViewContainer", package.seeall)

slot0 = class("HeroGroupFightRuleDescViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, HeroGroupFightRuleDescView.New())

	return slot1
end

return slot0
