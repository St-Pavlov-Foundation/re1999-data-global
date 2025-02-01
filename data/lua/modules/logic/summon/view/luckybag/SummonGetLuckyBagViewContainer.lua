module("modules.logic.summon.view.luckybag.SummonGetLuckyBagViewContainer", package.seeall)

slot0 = class("SummonGetLuckyBagViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, SummonGetLuckyBagView.New())

	return slot1
end

return slot0
