module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickChoiceViewContainer", package.seeall)

slot0 = class("SummonNewCustomPickChoiceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, SummonNewCustomPickChoiceView.New())
	table.insert(slot1, SummonNewCustomPickChoiceViewList.New())

	return slot1
end

return slot0
