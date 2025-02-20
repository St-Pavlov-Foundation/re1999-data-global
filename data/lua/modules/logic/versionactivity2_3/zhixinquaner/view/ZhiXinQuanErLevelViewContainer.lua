module("modules.logic.versionactivity2_3.zhixinquaner.view.ZhiXinQuanErLevelViewContainer", package.seeall)

slot0 = class("ZhiXinQuanErLevelViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ZhiXinQuanErLevelView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonsView
		}
	end
end

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr
	})
end

return slot0
