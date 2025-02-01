module("modules.logic.versionactivity1_4.act130.view.Activity130GameViewContainer", package.seeall)

slot0 = class("Activity130GameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._act130GameView = Activity130GameView.New()
	slot0._act130MapView = Activity130Map.New()
	slot1 = {}

	table.insert(slot1, slot0._act130GameView)
	table.insert(slot1, slot0._act130MapView)
	table.insert(slot1, TabViewGroup.New(1, "#go_topbtns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		slot0._navigateButtonView:setOverrideClose(slot0._overrideCloseFunc, slot0)

		return {
			slot0._navigateButtonView
		}
	end
end

function slot0.onContainerInit(slot0)
	StatActivity130Controller.instance:statStart()
end

function slot0._overrideCloseFunc(slot0)
	slot0._act130GameView._viewAnim:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(slot0._doClose, slot0, 0.167)
end

function slot0._doClose(slot0)
	slot0:closeThis()
	Activity130Controller.instance:dispatchEvent(Activity130Event.BackToLevelView, true)
end

function slot0.onContainerClose(slot0)
	StatActivity130Controller.instance:statAbort()
	Role37PuzzleModel.instance:clear()
	PuzzleRecordListModel.instance:clearRecord()
end

return slot0
