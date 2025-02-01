module("modules.logic.versionactivity1_4.act131.view.Activity131GameViewContainer", package.seeall)

slot0 = class("Activity131GameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._act131GameView = Activity131GameView.New()

	return {
		slot0._act131GameView,
		Activity131Map.New(),
		TabViewGroup.New(1, "#go_topbtns")
	}
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

function slot0._overrideCloseFunc(slot0)
	slot0._act131GameView._viewAnim:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(slot0._doClose, slot0, 0.167)
end

function slot0._doClose(slot0)
	slot0:closeThis()
	Activity131Controller.instance:dispatchEvent(Activity131Event.BackToLevelView, true)
end

return slot0
