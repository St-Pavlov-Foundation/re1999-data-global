module("modules.logic.versionactivity2_0.dungeon.view.graffiti.VersionActivity2_0DungeonGraffitiViewContainer", package.seeall)

slot0 = class("VersionActivity2_0DungeonGraffitiViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, VersionActivity2_0DungeonGraffitiView.New())
	table.insert(slot1, VersionActivity2_0DungeonGraffitiRewardView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonView
		}
	end
end

function slot0._overrideCloseFunc(slot0)
end

return slot0
