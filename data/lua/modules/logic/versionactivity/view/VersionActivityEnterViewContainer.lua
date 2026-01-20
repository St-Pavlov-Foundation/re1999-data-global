-- chunkname: @modules/logic/versionactivity/view/VersionActivityEnterViewContainer.lua

module("modules.logic.versionactivity.view.VersionActivityEnterViewContainer", package.seeall)

local VersionActivityEnterViewContainer = class("VersionActivityEnterViewContainer", BaseViewContainer)

function VersionActivityEnterViewContainer:buildViews()
	return {
		VersionActivityEnterView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function VersionActivityEnterViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function VersionActivityEnterViewContainer:onContainerInit()
	ActivityStageHelper.recordActivityStage(self.viewParam.activityIdList)
end

function VersionActivityEnterViewContainer:onContainerClose()
	if self:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) and not ViewMgr.instance:hasOpenFullView() then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

VersionActivityEnterViewContainer.kIconResPath = {
	"singlebg_lang/txt_versionactivity/rk1.png",
	"singlebg_lang/txt_versionactivity/rk2.png",
	"singlebg_lang/txt_versionactivity/btn_ls2.png",
	"singlebg_lang/txt_versionactivity/btn_2.png",
	"singlebg_lang/txt_versionactivity/btn_ls1.png",
	"singlebg_lang/txt_versionactivity/btn_1.png"
}

function VersionActivityEnterViewContainer:getPreLoaderResPathList()
	return VersionActivityEnterViewContainer.kIconResPath
end

return VersionActivityEnterViewContainer
