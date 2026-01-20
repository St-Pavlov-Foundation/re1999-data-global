-- chunkname: @modules/logic/versionactivity2_3/dungeon/view/maplevel/VersionActivity2_3DungeonMapLevelViewContainer.lua

module("modules.logic.versionactivity2_3.dungeon.view.maplevel.VersionActivity2_3DungeonMapLevelViewContainer", package.seeall)

local VersionActivity2_3DungeonMapLevelViewContainer = class("VersionActivity2_3DungeonMapLevelViewContainer", BaseViewContainer)
local TIME_OUT = 2

function VersionActivity2_3DungeonMapLevelViewContainer:buildViews()
	self.mapLevelView = VersionActivity2_3DungeonMapLevelView.New()

	return {
		self.mapLevelView,
		TabViewGroup.New(1, "anim/#go_righttop"),
		TabViewGroup.New(2, "anim/#go_lefttop")
	}
end

function VersionActivity2_3DungeonMapLevelViewContainer:buildTabViews(tabContainerId)
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

function VersionActivity2_3DungeonMapLevelViewContainer:setOpenedEpisodeId(episodeId)
	self.openedEpisodeId = episodeId
end

function VersionActivity2_3DungeonMapLevelViewContainer:getOpenedEpisodeId()
	return self.openedEpisodeId
end

function VersionActivity2_3DungeonMapLevelViewContainer:playCloseTransition()
	self:startViewOpenBlock()

	local player = self.mapLevelView.animatorPlayer

	if player then
		player:Play(UIAnimationName.Close, self.onPlayCloseTransitionFinish, self)
	end

	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, TIME_OUT)
end

function VersionActivity2_3DungeonMapLevelViewContainer:onPlayCloseTransitionFinish()
	SLFramework.AnimatorPlayer.Get(self.mapLevelView.goVersionActivity):Stop()
	VersionActivity2_3DungeonMapLevelViewContainer.super.onPlayCloseTransitionFinish(self)
end

function VersionActivity2_3DungeonMapLevelViewContainer:stopCloseViewTask()
	return
end

return VersionActivity2_3DungeonMapLevelViewContainer
