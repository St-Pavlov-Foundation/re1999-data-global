-- chunkname: @modules/logic/towercompose/view/result/TowerComposeResultSlotBodyModItem.lua

module("modules.logic.towercompose.view.result.TowerComposeResultSlotBodyModItem", package.seeall)

local TowerComposeResultSlotBodyModItem = class("TowerComposeResultSlotBodyModItem", LuaCompBase)

function TowerComposeResultSlotBodyModItem:ctor()
	return
end

function TowerComposeResultSlotBodyModItem:init(go)
	self.go = go
	self._imageskillbg = gohelper.findChildImage(self.go, "#image_skillbg")
	self._imageskillicon = gohelper.findChildImage(self.go, "#image_skillicon")

	self:_addEvents()
end

function TowerComposeResultSlotBodyModItem:_addEvents()
	return
end

function TowerComposeResultSlotBodyModItem:_removeEvents()
	return
end

function TowerComposeResultSlotBodyModItem:refresh(modId)
	self._modId = modId

	gohelper.setActive(self.go, true)
	gohelper.setActive(self._imageskillicon.gameObject, self._modId > 0)

	if self._modId > 0 then
		local modconfig = TowerComposeConfig.instance:getComposeModConfig(self._modId)

		UISpriteSetMgr.instance:setTower2Sprite(self._imageskillicon, modconfig.icon)
	end
end

function TowerComposeResultSlotBodyModItem:destroy()
	self:_removeEvents()
end

return TowerComposeResultSlotBodyModItem
