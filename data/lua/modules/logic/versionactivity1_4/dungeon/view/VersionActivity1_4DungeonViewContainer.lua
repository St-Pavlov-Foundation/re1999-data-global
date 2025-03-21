module("modules.logic.versionactivity1_4.dungeon.view.VersionActivity1_4DungeonViewContainer", package.seeall)

slot0 = class("VersionActivity1_4DungeonViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, VersionActivity1_4DungeonView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonsView
		}
	end
end

return slot0
