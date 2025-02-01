module("modules.logic.summon.view.luckybag.SummonLuckyBagChoiceContainer", package.seeall)

slot0 = class("SummonLuckyBagChoiceContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		SummonLuckyBagChoice.New()
	}
end

return slot0
