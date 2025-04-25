module("modules.logic.versionactivity2_5.liangyue.view.LiangYueGameViewContainer", package.seeall)

slot0 = class("LiangYueGameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, LiangYueGameView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_lefttop"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0.navigateView
		}
	end
end

function slot0.onContainerClose(slot0)
	if slot0._views[1]._isDrag then
		return
	end

	if slot1._isFinish == false then
		slot1:statData(LiangYueEnum.StatGameState.Exit)
	end
end

return slot0
