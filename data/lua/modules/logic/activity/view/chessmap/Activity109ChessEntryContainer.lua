module("modules.logic.activity.view.chessmap.Activity109ChessEntryContainer", package.seeall)

slot0 = class("Activity109ChessEntryContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Activity109ChessEntry.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonView
		}
	end
end

function slot0.onContainerOpen(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivityEnum.ActivityId.Act109)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivityEnum.ActivityId.Act109
	})
end

return slot0
