-- chunkname: @modules/logic/versionactivity3_8/dianjishi/view/DianJiShiGamePlaceBlockItem.lua

module("modules.logic.versionactivity3_8.dianjishi.view.DianJiShiGamePlaceBlockItem", package.seeall)

local DianJiShiGamePlaceBlockItem = class("DianJiShiGamePlaceBlockItem", LuaCompBase)

function DianJiShiGamePlaceBlockItem:init(go)
	self.go = go
	self._goArea = gohelper.findChild(self.go, "go_Area")
end

function DianJiShiGamePlaceBlockItem:addEventListeners()
	return
end

function DianJiShiGamePlaceBlockItem:removeEventListeners()
	return
end

function DianJiShiGamePlaceBlockItem:onUpdateMO(blockInfo, index, blockComp)
	self._blockInfo = blockInfo
	self._index = index
	self._blockComp = blockComp

	self:refreshUI()
end

function DianJiShiGamePlaceBlockItem:refreshUI()
	local cubeList = self._blockInfo and self._blockInfo.cubeList or {}

	gohelper.CreateObjList(self, self._refreshCubeItem, cubeList, self._goArea, self._goCubeItem, DianJiShiGamePlaceCubeItem)
end

function DianJiShiGamePlaceBlockItem:_refreshCubeItem(cubeItem, cubeInfo, index)
	cubeItem:onUpdateMO(cubeInfo, index)
end

return DianJiShiGamePlaceBlockItem
