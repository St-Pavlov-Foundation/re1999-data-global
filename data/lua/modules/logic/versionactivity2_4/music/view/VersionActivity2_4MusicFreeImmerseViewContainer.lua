module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeImmerseViewContainer", package.seeall)

slot0 = class("VersionActivity2_4MusicFreeImmerseViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, VersionActivity2_4MusicFreeImmerseView.New())

	return slot1
end

return slot0
