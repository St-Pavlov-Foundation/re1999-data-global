-- chunkname: @modules/logic/help/view/LawDescriptionViewContainer.lua

module("modules.logic.help.view.LawDescriptionViewContainer", package.seeall)

local LawDescriptionViewContainer = class("LawDescriptionViewContainer", BaseViewContainer)

function LawDescriptionViewContainer:buildViews()
	local views = {
		(LawDescriptionView.New())
	}

	return views
end

return LawDescriptionViewContainer
