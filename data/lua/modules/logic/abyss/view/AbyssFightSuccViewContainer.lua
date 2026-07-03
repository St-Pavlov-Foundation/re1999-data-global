-- chunkname: @modules/logic/abyss/view/AbyssFightSuccViewContainer.lua

module("modules.logic.abyss.view.AbyssFightSuccViewContainer", package.seeall)

local AbyssFightSuccViewContainer = class("AbyssFightSuccViewContainer", BaseViewContainer)

function AbyssFightSuccViewContainer:buildViews()
	local views = {
		AbyssFightSuccView.New()
	}

	return views
end

return AbyssFightSuccViewContainer
