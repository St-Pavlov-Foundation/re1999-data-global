-- chunkname: @modules/logic/versionactivity3_2/cruise/view/cruisegoldgame/game/CruiseGameResultViewContainer.lua

module("modules.logic.versionactivity3_2.cruise.view.cruisegoldgame.game.CruiseGameResultViewContainer", package.seeall)

local CruiseGameResultViewContainer = class("CruiseGameResultViewContainer", BaseViewContainer)

function CruiseGameResultViewContainer:buildViews()
	local views = {
		CruiseGameResultView.New()
	}

	return views
end

return CruiseGameResultViewContainer
