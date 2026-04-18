-- chunkname: @modules/logic/battlepass/view/BPFaceFestivalViewContainer.lua

module("modules.logic.battlepass.view.BPFaceFestivalViewContainer", package.seeall)

local BPFaceFestivalViewContainer = class("BPFaceFestivalViewContainer", BaseViewContainer)

function BPFaceFestivalViewContainer:buildViews()
	local views = {
		BPFaceFestivalView.New()
	}

	return views
end

return BPFaceFestivalViewContainer
