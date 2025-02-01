module("modules.logic.versionactivity2_1.aergusi.view.AergusiLevelViewContainer", package.seeall)

slot0 = class("AergusiLevelViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._levelView = AergusiLevelView.New()

	return {
		slot0._levelView,
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		slot0._navigateButtonsView:setOverrideClose(slot0._overrideCloseFunc, slot0)

		return {
			slot0._navigateButtonsView
		}
	end
end

function slot0._overrideCloseFunc(slot0)
	slot0._levelView._viewAnimator:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(slot0._doClose, slot0, 0.333)
end

function slot0._doClose(slot0)
	slot0:closeThis()
end

return slot0
