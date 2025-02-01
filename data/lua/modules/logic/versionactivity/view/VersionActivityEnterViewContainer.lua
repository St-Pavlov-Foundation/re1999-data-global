module("modules.logic.versionactivity.view.VersionActivityEnterViewContainer", package.seeall)

slot0 = class("VersionActivityEnterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivityEnterView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function slot0.onContainerInit(slot0)
	ActivityStageHelper.recordActivityStage(slot0.viewParam.activityIdList)
end

function slot0.onContainerClose(slot0)
	if slot0:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) and not ViewMgr.instance:hasOpenFullView() then
		ViewMgr.instance:openView(ViewName.MainView)
	end
end

slot0.kIconResPath = {
	"singlebg_lang/txt_versionactivity/rk1.png",
	"singlebg_lang/txt_versionactivity/rk2.png",
	"singlebg_lang/txt_versionactivity/btn_ls2.png",
	"singlebg_lang/txt_versionactivity/btn_2.png",
	"singlebg_lang/txt_versionactivity/btn_ls1.png",
	"singlebg_lang/txt_versionactivity/btn_1.png"
}

function slot0.getPreLoaderResPathList(slot0)
	return uv0.kIconResPath
end

return slot0
