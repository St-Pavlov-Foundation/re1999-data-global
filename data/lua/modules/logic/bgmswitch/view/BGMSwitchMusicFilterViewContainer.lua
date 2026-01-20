-- chunkname: @modules/logic/bgmswitch/view/BGMSwitchMusicFilterViewContainer.lua

module("modules.logic.bgmswitch.view.BGMSwitchMusicFilterViewContainer", package.seeall)

local BGMSwitchMusicFilterViewContainer = class("BGMSwitchMusicFilterViewContainer", BaseViewContainer)

function BGMSwitchMusicFilterViewContainer:buildViews()
	local views = {
		BGMSwitchMusicFilterView.New()
	}

	return views
end

return BGMSwitchMusicFilterViewContainer
