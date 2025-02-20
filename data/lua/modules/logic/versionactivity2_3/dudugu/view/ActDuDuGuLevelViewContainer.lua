module("modules.logic.versionactivity2_3.dudugu.view.ActDuDuGuLevelViewContainer", package.seeall)

slot0 = class("ActDuDuGuLevelViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActDuDuGuLevelView.New())
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

		slot0._navigateButtonsView:setOverrideClose(slot0.overrideOnCloseClick, slot0)

		return {
			slot0._navigateButtonsView
		}
	end
end

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_3Enum.ActivityId.DuDuGu)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_3Enum.ActivityId.DuDuGu
	})
end

function slot0.overrideOnCloseClick(slot0)
	ActDuDuGuModel.instance:setCurLvIndex(0)
	slot0:closeThis()
end

return slot0
