module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3BuffViewContainer", package.seeall)

slot0 = class("VersionActivity1_3BuffViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0.buffView = VersionActivity1_3BuffView.New()

	return {
		slot0.buffView,
		TabViewGroup.New(1, "#go_BackBtns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return slot0
