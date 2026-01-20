-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeon/view/VersionActivity1_3DungeonMapLevelViewContainer.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonMapLevelViewContainer", package.seeall)

local VersionActivity1_3DungeonMapLevelViewContainer = class("VersionActivity1_3DungeonMapLevelViewContainer", BaseViewContainer)

function VersionActivity1_3DungeonMapLevelViewContainer:buildViews()
	self.mapLevelView = VersionActivity1_3DungeonMapLevelView.New()

	return {
		self.mapLevelView,
		TabViewGroup.New(1, "anim/#go_righttop"),
		TabViewGroup.New(2, "anim/#go_lefttop")
	}
end

function VersionActivity1_3DungeonMapLevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			CurrencyView.New({
				CurrencyEnum.CurrencyType.Power
			})
		}
	elseif tabContainerId == 2 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

function VersionActivity1_3DungeonMapLevelViewContainer:setOpenedEpisodeId(episodeId)
	self.openedEpisodeId = episodeId
end

function VersionActivity1_3DungeonMapLevelViewContainer:getOpenedEpisodeId()
	return self.openedEpisodeId
end

function VersionActivity1_3DungeonMapLevelViewContainer:playCloseTransition()
	self:startViewOpenBlock()

	local player = SLFramework.AnimatorPlayer.Get(self.mapLevelView.goVersionActivity)

	player:Play(UIAnimationName.Close, self.onPlayCloseTransitionFinish, self)
	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, 2)
end

function VersionActivity1_3DungeonMapLevelViewContainer:onPlayCloseTransitionFinish()
	SLFramework.AnimatorPlayer.Get(self.mapLevelView.goVersionActivity):Stop()
	VersionActivity1_3DungeonMapLevelViewContainer.super.onPlayCloseTransitionFinish(self)
end

function VersionActivity1_3DungeonMapLevelViewContainer:stopCloseViewTask()
	self.mapLevelView:cancelStartCloseTask()
end

return VersionActivity1_3DungeonMapLevelViewContainer
