module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeAccompanyViewContainer", package.seeall)

slot0 = class("VersionActivity2_4MusicFreeAccompanyViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, VersionActivity2_4MusicFreeAccompanyView.New())

	return slot1
end

return slot0
