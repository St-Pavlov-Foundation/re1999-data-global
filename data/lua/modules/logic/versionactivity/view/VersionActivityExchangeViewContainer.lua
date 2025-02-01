module("modules.logic.versionactivity.view.VersionActivityExchangeViewContainer", package.seeall)

slot0 = class("VersionActivityExchangeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))
	table.insert(slot1, VersionActivityExchangeView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0.navigationView
		}
	end
end

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivityEnum.ActivityId.Act112)
end

return slot0
