-- chunkname: @modules/logic/battlepass/view/BPSkinFaceViewContainer.lua

module("modules.logic.battlepass.view.BPSkinFaceViewContainer", package.seeall)

local BPSkinFaceViewContainer = class("BPSkinFaceViewContainer", BaseViewContainer)

function BPSkinFaceViewContainer:buildViews()
	return {
		BPSkinFaceView.New()
	}
end

return BPSkinFaceViewContainer
