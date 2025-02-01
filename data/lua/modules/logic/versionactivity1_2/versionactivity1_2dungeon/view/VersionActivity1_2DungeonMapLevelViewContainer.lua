module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonMapLevelViewContainer", package.seeall)

slot0 = class("VersionActivity1_2DungeonMapLevelViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0.mapLevelView = VersionActivity1_2DungeonMapLevelView.New()

	return {
		slot0.mapLevelView,
		TabViewGroup.New(1, "anim/#go_righttop"),
		TabViewGroup.New(2, "anim/#go_lefttop")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			CurrencyView.New({
				CurrencyEnum.CurrencyType.Power
			})
		}
	elseif slot1 == 2 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

function slot0.setOpenedEpisodeId(slot0, slot1)
	slot0.openedEpisodeId = slot1
end

function slot0.getOpenedEpisodeId(slot0)
	return slot0.openedEpisodeId
end

function slot0.playCloseTransition(slot0)
	UIBlockMgr.instance:endBlock(slot0.viewName .. "ViewOpenAnim")
	TaskDispatcher.cancelTask(slot0._onOpenAnimDone, slot0)

	slot0._playCloseAnim = true

	UIBlockMgr.instance:startBlock(slot0.viewName .. "ViewCloseAnim")
	SLFramework.AnimatorPlayer.Get(slot0.mapLevelView.goVersionActivity):Play("close", slot0._onCloseAnimDone, slot0)
	TaskDispatcher.runDelay(slot0._onCloseAnimDone, slot0, 2)
end

function slot0._onCloseAnimDone(slot0)
	TaskDispatcher.cancelTask(slot0._onCloseAnimDone, slot0, 2)
	SLFramework.AnimatorPlayer.Get(slot0.mapLevelView.goVersionActivity):Stop()
	slot0:onPlayCloseTransitionFinish()
end

function slot0.stopCloseViewTask(slot0)
	slot0.mapLevelView:cancelStartCloseTask()
end

return slot0
