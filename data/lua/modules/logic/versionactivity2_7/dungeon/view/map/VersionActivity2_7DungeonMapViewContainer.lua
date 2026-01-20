-- chunkname: @modules/logic/versionactivity2_7/dungeon/view/map/VersionActivity2_7DungeonMapViewContainer.lua

module("modules.logic.versionactivity2_7.dungeon.view.map.VersionActivity2_7DungeonMapViewContainer", package.seeall)

local VersionActivity2_7DungeonMapViewContainer = class("VersionActivity2_7DungeonMapViewContainer", VersionActivityFixedDungeonMapViewContainer)

function VersionActivity2_7DungeonMapViewContainer:buildViews()
	self.mapScene = VersionActivity2_7DungeonMapScene.New()
	self.mapSceneElements = VersionActivityFixedHelper.getVersionActivityDungeonMapSceneElements().New()
	self.mapView = VersionActivityFixedHelper.getVersionActivityDungeonMapView().New()
	self.mapEpisodeView = VersionActivityFixedHelper.getVersionActivityDungeonMapEpisodeView().New()
	self.interactView = VersionActivityFixedHelper.getVersionActivityDungeonMapInteractView().New()
	self.mapElementReward = DungeonMapElementReward.New()

	local views = {
		VersionActivityFixedHelper.getVersionActivityDungeonMapHoleView().New(),
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

return VersionActivity2_7DungeonMapViewContainer
