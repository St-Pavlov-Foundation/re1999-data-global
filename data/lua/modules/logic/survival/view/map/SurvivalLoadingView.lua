-- chunkname: @modules/logic/survival/view/map/SurvivalLoadingView.lua

module("modules.logic.survival.view.map.SurvivalLoadingView", package.seeall)

local SurvivalLoadingView = class("SurvivalLoadingView", BaseView)

function SurvivalLoadingView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_loading)
end

function SurvivalLoadingView:_onOpenView(viewName)
	return
end

function SurvivalLoadingView:onClose()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.stop_ui_fuleyuan_tansuo_loading)
end

return SurvivalLoadingView
