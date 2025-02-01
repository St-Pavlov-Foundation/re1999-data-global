module("modules.logic.bgmswitch.view.BGMSwitchMusicFilterViewContainer", package.seeall)

slot0 = class("BGMSwitchMusicFilterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		BGMSwitchMusicFilterView.New()
	}
end

return slot0
