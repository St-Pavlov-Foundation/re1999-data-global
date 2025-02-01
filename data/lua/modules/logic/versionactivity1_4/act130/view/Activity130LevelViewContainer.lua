module("modules.logic.versionactivity1_4.act130.view.Activity130LevelViewContainer", package.seeall)

slot0 = class("Activity130LevelViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._mapViewScene = Activity130LevelScene.New()
	slot0._levelView = Activity130LevelView.New()
	slot0._sceneChangeView = Activity130DungeonChange.New()

	table.insert(slot1, slot0._mapViewScene)
	table.insert(slot1, slot0._levelView)
	table.insert(slot1, slot0._sceneChangeView)
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
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

function slot0.changeLvScene(slot0, slot1)
	slot0._mapViewScene:changeLvScene(slot1)
end

return slot0
