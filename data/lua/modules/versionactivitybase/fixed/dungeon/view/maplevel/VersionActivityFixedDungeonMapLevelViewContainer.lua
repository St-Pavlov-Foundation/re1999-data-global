-- chunkname: @modules/versionactivitybase/fixed/dungeon/view/maplevel/VersionActivityFixedDungeonMapLevelViewContainer.lua

module("modules.versionactivitybase.fixed.dungeon.view.maplevel.VersionActivityFixedDungeonMapLevelViewContainer", package.seeall)

local VersionActivityFixedDungeonMapLevelViewContainer = class("VersionActivityFixedDungeonMapLevelViewContainer", BaseViewContainer)
local TIME_OUT = 2

function VersionActivityFixedDungeonMapLevelViewContainer:buildViews()
	self._bigVersion, self._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	self.mapLevelView = VersionActivityFixedHelper.getVersionActivityDungeonMapLevelView(self._bigVersion, self._smallVersion).New()

	return {
		self.mapLevelView,
		TabViewGroup.New(1, "anim/#go_righttop"),
		TabViewGroup.New(2, "anim/#go_lefttop")
	}
end

function VersionActivityFixedDungeonMapLevelViewContainer:buildTabViews(tabContainerId)
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

function VersionActivityFixedDungeonMapLevelViewContainer:setOpenedEpisodeId(episodeId)
	self.openedEpisodeId = episodeId
end

function VersionActivityFixedDungeonMapLevelViewContainer:getOpenedEpisodeId()
	return self.openedEpisodeId
end

function VersionActivityFixedDungeonMapLevelViewContainer:playCloseTransition()
	self:startViewOpenBlock()

	local player = self.mapLevelView.animatorPlayer

	if player then
		player:Play(UIAnimationName.Close, self.onPlayCloseTransitionFinish, self)
	end

	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, TIME_OUT)
end

function VersionActivityFixedDungeonMapLevelViewContainer:onPlayCloseTransitionFinish()
	SLFramework.AnimatorPlayer.Get(self.mapLevelView.goVersionActivity):Stop()
	VersionActivityFixedDungeonMapLevelViewContainer.super.onPlayCloseTransitionFinish(self)
end

function VersionActivityFixedDungeonMapLevelViewContainer:stopCloseViewTask()
	return
end

return VersionActivityFixedDungeonMapLevelViewContainer
