module("modules.logic.rouge.dlc.101.view.RougeLimiterOverViewContainer", package.seeall)

slot0 = class("RougeLimiterOverViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeLimiterOverView.New())
	table.insert(slot1, TabViewGroup.New(1, "root/#go_container"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			RougeLimiterDebuffOverView.New(),
			RougeLimiterBuffOverView.New()
		}
	end
end

function slot0.switchTab(slot0, slot1)
	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 1, slot1)
end

return slot0
