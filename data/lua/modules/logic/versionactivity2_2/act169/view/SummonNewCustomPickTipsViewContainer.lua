module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickTipsViewContainer", package.seeall)

slot0 = class("SummonNewCustomPickTipsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, SummonNewCustomPickTipsView.New())

	return slot1
end

return slot0
