-- chunkname: @modules/logic/versionactivity3_8/dianjishi/view/DianJiShiGameShadowItem.lua

module("modules.logic.versionactivity3_8.dianjishi.view.DianJiShiGameShadowItem", package.seeall)

local DianJiShiGameShadowItem = class("DianJiShiGameShadowItem", LuaCompBase)

function DianJiShiGameShadowItem:init(go)
	self.go = go
	self._tran = self.go.transform
	self._imageShadow = gohelper.findChildImage(self.go, "image_Shadow")
end

function DianJiShiGameShadowItem:addEventListeners()
	return
end

function DianJiShiGameShadowItem:removeEventListeners()
	return
end

function DianJiShiGameShadowItem:onUpdateMO(shadowInfo, index)
	self._shadowInfo = shadowInfo
	self._index = index

	self:refreshUI()
end

function DianJiShiGameShadowItem:refreshUI()
	local posXIndex = self._shadowInfo and self._shadowInfo.posXIndex
	local posYIndex = self._shadowInfo and self._shadowInfo.posYIndex
	local posX, posY = DianJiShiGameController.instance:posIndex2Pos(posXIndex, posYIndex, true)

	recthelper.setAnchor(self._tran, posX, posY)

	local shadowType = self._shadowInfo and self._shadowInfo.type
	local iconName = DianJiShiGameEnum.ShadowIcon[shadowType]

	UISpriteSetMgr.instance:setV3a8DianJiShiSprite(self._imageShadow, iconName, true)
end

return DianJiShiGameShadowItem
