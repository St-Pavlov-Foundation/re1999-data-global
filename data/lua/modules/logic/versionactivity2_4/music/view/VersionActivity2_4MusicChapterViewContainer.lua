module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicChapterViewContainer", package.seeall)

slot0 = class("VersionActivity2_4MusicChapterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, VersionActivity2_4MusicChapterView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_left"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0.navigateView
		}
	end
end

return slot0
