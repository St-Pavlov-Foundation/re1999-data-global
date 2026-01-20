-- chunkname: @modules/logic/versionactivity2_0/dungeon/view/map/VersionActivity2_0DungeonMapViewContainer.lua

module("modules.logic.versionactivity2_0.dungeon.view.map.VersionActivity2_0DungeonMapViewContainer", package.seeall)

local VersionActivity2_0DungeonMapViewContainer = class("VersionActivity2_0DungeonMapViewContainer", BaseViewContainer)

function VersionActivity2_0DungeonMapViewContainer:buildViews()
	self.mapScene = VersionActivity2_0DungeonMapScene.New()
	self.mapSceneElements = VersionActivity2_0DungeonMapSceneElements.New()
	self.mapView = VersionActivity2_0DungeonMapView.New()
	self.mapEpisodeView = VersionActivity2_0DungeonMapEpisodeView.New()
	self.interactView = VersionActivity2_0DungeonMapInteractView.New()
	self.mapElementReward = DungeonMapElementReward.New()

	local views = {
		VersionActivity2_0DungeonMapHoleView.New(),
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

function VersionActivity2_0DungeonMapViewContainer:buildTabViews(tabContainerId)
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

function VersionActivity2_0DungeonMapViewContainer:onClickClose()
	local isShowInteractView = VersionActivity2_0DungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		return
	end

	local isOpenGraffitiEntrance = VersionActivity2_0DungeonModel.instance:getOpenGraffitiEntranceState()

	if isOpenGraffitiEntrance then
		Activity161Controller.instance:dispatchEvent(Activity161Event.CloseRestaurantWithEffect)

		return
	end

	self:closeThis()
end

function VersionActivity2_0DungeonMapViewContainer:onClickHome()
	local isShowInteractView = VersionActivity2_0DungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		return
	end

	NavigateButtonsView.homeClick()
end

function VersionActivity2_0DungeonMapViewContainer:onContainerInit()
	self.versionActivityDungeonBaseMo = VersionActivity2_0DungeonMo.New()

	self.versionActivityDungeonBaseMo:init(VersionActivity2_0Enum.ActivityId.Dungeon, self.viewParam.chapterId, self.viewParam.episodeId)
	self.versionActivityDungeonBaseMo:setLayoutClass(VersionActivity2_0DungeonMapChapterLayout)
	self.versionActivityDungeonBaseMo:setMapEpisodeItemClass(VersionActivity2_0DungeonMapEpisodeItem)

	for _, view in ipairs(self._views) do
		view.activityDungeonMo = self.versionActivityDungeonBaseMo
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	VersionActivity2_0DungeonModel.instance:setDungeonBaseMo(self.versionActivityDungeonBaseMo)
	self.mapElementReward:setShowToastState(true)
end

function VersionActivity2_0DungeonMapViewContainer:onUpdateParamInternal(viewParam)
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

function VersionActivity2_0DungeonMapViewContainer:onContainerUpdateParam()
	self.versionActivityDungeonBaseMo:update(self.viewParam.chapterId, self.viewParam.episodeId)
	self:setVisibleInternal(true)
end

function VersionActivity2_0DungeonMapViewContainer:setVisibleInternal(isVisible)
	VersionActivity2_0DungeonMapViewContainer.super.setVisibleInternal(self, isVisible)

	if self.mapScene then
		self.mapScene:setVisible(isVisible)
	end
end

function VersionActivity2_0DungeonMapViewContainer:onContainerClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

function VersionActivity2_0DungeonMapViewContainer:getMapScene()
	return self.mapScene
end

return VersionActivity2_0DungeonMapViewContainer
