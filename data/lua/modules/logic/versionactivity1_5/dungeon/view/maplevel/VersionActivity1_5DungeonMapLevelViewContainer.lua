module("modules.logic.versionactivity1_5.dungeon.view.maplevel.VersionActivity1_5DungeonMapLevelViewContainer", package.seeall)

slot0 = class("VersionActivity1_5DungeonMapLevelViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0.mapLevelView = VersionActivity1_5DungeonMapLevelView.New()

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
	slot0:startViewOpenBlock()
	SLFramework.AnimatorPlayer.Get(slot0.mapLevelView.goVersionActivity):Play(UIAnimationName.Close, slot0.onPlayCloseTransitionFinish, slot0)
	TaskDispatcher.runDelay(slot0.onPlayCloseTransitionFinish, slot0, 2)
end

function slot0.onPlayCloseTransitionFinish(slot0)
	SLFramework.AnimatorPlayer.Get(slot0.mapLevelView.goVersionActivity):Stop()
	uv0.super.onPlayCloseTransitionFinish(slot0)
end

function slot0.stopCloseViewTask(slot0)
	slot0.mapLevelView:cancelStartCloseTask()
end

return slot0
