-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/guessgame/GuessGamePlayRoundTipsViewContainer.lua

module("modules.logic.versionactivity3_7.anniversary3.view.guessgame.GuessGamePlayRoundTipsViewContainer", package.seeall)

local GuessGamePlayRoundTipsViewContainer = class("GuessGamePlayRoundTipsViewContainer", BaseViewContainer)

function GuessGamePlayRoundTipsViewContainer:buildViews()
	local views = {
		GuessGamePlayRoundTipsView.New()
	}

	return views
end

return GuessGamePlayRoundTipsViewContainer
