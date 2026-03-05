-- chunkname: @modules/logic/towercompose/view/result/TowerComposeResultSlotWordModItem.lua

module("modules.logic.towercompose.view.result.TowerComposeResultSlotWordModItem", package.seeall)

local TowerComposeResultSlotWordModItem = class("TowerComposeResultSlotWordModItem", LuaCompBase)

function TowerComposeResultSlotWordModItem:ctor()
	return
end

function TowerComposeResultSlotWordModItem:init(go)
	self.go = go
	self._imageskillbg = gohelper.findChildImage(self.go, "#image_skillbg")
	self._imageskillicon = gohelper.findChildImage(self.go, "#image_skillicon")

	self:_addEvents()
end

function TowerComposeResultSlotWordModItem:_addEvents()
	return
end

function TowerComposeResultSlotWordModItem:_removeEvents()
	return
end

function TowerComposeResultSlotWordModItem:refresh(modId)
	self._modId = modId

	gohelper.setActive(self.go, true)
	gohelper.setActive(self._imageskillicon.gameObject, self._modId > 0)

	if self._modId > 0 then
		local modconfig = TowerComposeConfig.instance:getComposeModConfig(self._modId)

		UISpriteSetMgr.instance:setTower2Sprite(self._imageskillicon, modconfig.icon)
	end
end

function TowerComposeResultSlotWordModItem:destroy()
	self:_removeEvents()
end

return TowerComposeResultSlotWordModItem
