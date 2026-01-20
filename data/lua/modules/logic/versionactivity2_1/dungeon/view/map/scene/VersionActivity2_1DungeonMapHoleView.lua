-- chunkname: @modules/logic/versionactivity2_1/dungeon/view/map/scene/VersionActivity2_1DungeonMapHoleView.lua

module("modules.logic.versionactivity2_1.dungeon.view.map.scene.VersionActivity2_1DungeonMapHoleView", package.seeall)

local VersionActivity2_1DungeonMapHoleView = class("VersionActivity2_1DungeonMapHoleView", DungeonMapHoleView)

function VersionActivity2_1DungeonMapHoleView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_1DungeonMapHoleView:addEvents()
	self:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.initCameraParam, self)
	self:addEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnMapPosChanged, self.onMapPosChanged, self)
	self:addEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnAddOneElement, self.onAddOneElement, self)
	self:addEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self:addEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnRecycleAllElement, self.onRecycleAllElement, self)
end

function VersionActivity2_1DungeonMapHoleView:removeEvents()
	self:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.initCameraParam, self)
	self:removeEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnMapPosChanged, self.onMapPosChanged, self)
	self:removeEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnAddOneElement, self.onAddOneElement, self)
	self:removeEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self:removeEventCb(VersionActivity2_1DungeonController.instance, VersionActivity2_1DungeonEvent.OnRecycleAllElement, self.onRecycleAllElement, self)
end

function VersionActivity2_1DungeonMapHoleView:_editableInitView()
	return
end

function VersionActivity2_1DungeonMapHoleView:loadSceneFinish(param)
	local holeParam = {
		param.mapConfig,
		param.mapSceneGo
	}

	VersionActivity2_1DungeonMapHoleView.super.loadSceneFinish(self, holeParam)
end

function VersionActivity2_1DungeonMapHoleView:onMapPosChanged(targetPos, isTween)
	VersionActivity2_1DungeonMapHoleView.super.onMapPosChanged(self, targetPos, isTween)
end

function VersionActivity2_1DungeonMapHoleView:initCameraParam()
	VersionActivity2_1DungeonMapHoleView.super.initCameraParam(self)
end

function VersionActivity2_1DungeonMapHoleView:onAddOneElement(elementComp)
	if elementComp then
		local elementId = elementComp:getElementId()

		self:_onAddElement(elementId)
	end
end

function VersionActivity2_1DungeonMapHoleView:onRemoveElement(elementComp)
	if elementComp and elementComp._config.fragment == 0 then
		local elementId = elementComp:getElementId()

		self:_onRemoveElement(elementId)
	end
end

function VersionActivity2_1DungeonMapHoleView:onRecycleAllElement()
	self.holdCoList = {}

	self:refreshHoles()
end

return VersionActivity2_1DungeonMapHoleView
