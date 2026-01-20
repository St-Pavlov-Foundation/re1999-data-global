-- chunkname: @modules/logic/versionactivity2_1/dungeon/view/map/VersionActivity2_1DungeonMapViewContainer.lua

module("modules.logic.versionactivity2_1.dungeon.view.map.VersionActivity2_1DungeonMapViewContainer", package.seeall)

local VersionActivity2_1DungeonMapViewContainer = class("VersionActivity2_1DungeonMapViewContainer", BaseViewContainer)

function VersionActivity2_1DungeonMapViewContainer:buildViews()
	self.mapScene = VersionActivity2_1DungeonMapScene.New()
	self.mapSceneElements = VersionActivity2_1DungeonMapSceneElements.New()
	self.mapView = VersionActivity2_1DungeonMapView.New()
	self.mapEpisodeView = VersionActivity2_1DungeonMapEpisodeView.New()
	self.interactView = VersionActivity2_1DungeonMapInteractView.New()
	self.mapElementReward = DungeonMapElementReward.New()

	local views = {
		VersionActivity2_1DungeonMapHoleView.New(),
		self.mapScene,
		self.mapSceneElements,
		self.mapView,
		self.mapEpisodeView,
		self.interactView,
		self.mapElementReward,
		TabViewGroup.New(1, "#go_topleft")
	}

	return views
end

function VersionActivity2_1DungeonMapViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	self.navigateView:setOverrideClose(self.onClickClose, self)
	self.navigateView:setOverrideHome(self.onClickHome, self)

	return {
		self.navigateView
	}
end

function VersionActivity2_1DungeonMapViewContainer:onClickClose()
	local isShowInteractView = VersionActivity2_1DungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		return
	end

	self:closeThis()
end

function VersionActivity2_1DungeonMapViewContainer:onClickHome()
	local isShowInteractView = VersionActivity2_1DungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		return
	end

	NavigateButtonsView.homeClick()
end

function VersionActivity2_1DungeonMapViewContainer:onContainerInit()
	self.versionActivityDungeonBaseMo = VersionActivity2_1DungeonMo.New()

	self.versionActivityDungeonBaseMo:init(VersionActivity2_1Enum.ActivityId.Dungeon, self.viewParam.chapterId, self.viewParam.episodeId)
	self.versionActivityDungeonBaseMo:setLayoutClass(VersionActivity2_1DungeonMapChapterLayout)
	self.versionActivityDungeonBaseMo:setMapEpisodeItemClass(VersionActivity2_1DungeonMapEpisodeItem)

	for _, view in ipairs(self._views) do
		view.activityDungeonMo = self.versionActivityDungeonBaseMo
	end

	VersionActivity2_1DungeonModel.instance:setDungeonBaseMo(self.versionActivityDungeonBaseMo)
	self.mapElementReward:setShowToastState(true)
end

function VersionActivity2_1DungeonMapViewContainer:onUpdateParamInternal(viewParam)
	self.viewParam = viewParam

	self:onContainerUpdateParam()
	self:_setVisible(true)

	if self._views then
		for _, item in ipairs(self._views) do
			item.viewParam = viewParam

			item:onUpdateParamInternal()
		end
	end
end

function VersionActivity2_1DungeonMapViewContainer:onContainerUpdateParam()
	self.versionActivityDungeonBaseMo:update(self.viewParam.chapterId, self.viewParam.episodeId)
	self:setVisibleInternal(true)
end

function VersionActivity2_1DungeonMapViewContainer:setVisibleInternal(isVisible)
	VersionActivity2_1DungeonMapViewContainer.super.setVisibleInternal(self, isVisible)

	if self.mapScene then
		self.mapScene:setVisible(isVisible)
	end
end

function VersionActivity2_1DungeonMapViewContainer:onContainerClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

function VersionActivity2_1DungeonMapViewContainer:getMapScene()
	return self.mapScene
end

return VersionActivity2_1DungeonMapViewContainer
