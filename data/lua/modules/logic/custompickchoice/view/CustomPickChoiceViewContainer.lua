module("modules.logic.custompickchoice.view.CustomPickChoiceViewContainer", package.seeall)

slot0 = class("CustomPickChoiceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, CustomPickChoiceView.New())

	return slot1
end

return slot0
