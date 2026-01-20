-- chunkname: @modules/logic/versionactivity2_4/dungeon/view/map/scene/VersionActivity2_4DungeonMapHoleView.lua

module("modules.logic.versionactivity2_4.dungeon.view.map.scene.VersionActivity2_4DungeonMapHoleView", package.seeall)

local VersionActivity2_4DungeonMapHoleView = class("VersionActivity2_4DungeonMapHoleView", DungeonMapHoleView)

function VersionActivity2_4DungeonMapHoleView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4DungeonMapHoleView:addEvents()
	self:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.initCameraParam, self)
	self:addEventCb(VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.OnMapPosChanged, self.onMapPosChanged, self)
	self:addEventCb(VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.OnAddOneElement, self.onAddOneElement, self)
	self:addEventCb(VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self:addEventCb(VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.OnRecycleAllElement, self.onRecycleAllElement, self)
end

function VersionActivity2_4DungeonMapHoleView:removeEvents()
	self:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.initCameraParam, self)
	self:removeEventCb(VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.OnMapPosChanged, self.onMapPosChanged, self)
	self:removeEventCb(VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.OnAddOneElement, self.onAddOneElement, self)
	self:removeEventCb(VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self:removeEventCb(VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.OnRecycleAllElement, self.onRecycleAllElement, self)
end

function VersionActivity2_4DungeonMapHoleView:_editableInitView()
	return
end

function VersionActivity2_4DungeonMapHoleView:loadSceneFinish(param)
	local holeParam = {
		param.mapConfig,
		param.mapSceneGo
	}

	VersionActivity2_4DungeonMapHoleView.super.loadSceneFinish(self, holeParam)
end

function VersionActivity2_4DungeonMapHoleView:onMapPosChanged(targetPos, isTween)
	VersionActivity2_4DungeonMapHoleView.super.onMapPosChanged(self, targetPos, isTween)
end

function VersionActivity2_4DungeonMapHoleView:initCameraParam()
	VersionActivity2_4DungeonMapHoleView.super.initCameraParam(self)
end

function VersionActivity2_4DungeonMapHoleView:onAddOneElement(elementComp)
	if elementComp then
		local elementId = elementComp:getElementId()

		self:_onAddElement(elementId)
	end
end

function VersionActivity2_4DungeonMapHoleView:onRemoveElement(elementComp)
	if elementComp and elementComp._config.fragment == 0 then
		local elementId = elementComp:getElementId()

		self:_onRemoveElement(elementId)
	end
end

function VersionActivity2_4DungeonMapHoleView:onRecycleAllElement()
	self.holdCoList = {}

	self:refreshHoles()
end

return VersionActivity2_4DungeonMapHoleView
