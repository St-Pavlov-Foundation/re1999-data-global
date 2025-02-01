module("modules.logic.summon.view.custompick.SummonCustomPickChoiceContainer", package.seeall)

slot0 = class("SummonCustomPickChoiceContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		SummonCustomPickChoice.New(),
		SummonCustomPickChoiceList.New()
	}
end

return slot0
