module("modules.logic.versionactivity.view.VersionActivityPushBoxTaskViewContainer", package.seeall)

slot0 = class("VersionActivityPushBoxTaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivityPushBoxTaskView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0._navigateButtonView
		}
	end
end

return slot0
