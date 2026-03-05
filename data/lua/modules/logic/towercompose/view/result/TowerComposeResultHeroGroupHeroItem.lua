-- chunkname: @modules/logic/towercompose/view/result/TowerComposeResultHeroGroupHeroItem.lua

module("modules.logic.towercompose.view.result.TowerComposeResultHeroGroupHeroItem", package.seeall)

local TowerComposeResultHeroGroupHeroItem = class("TowerComposeResultHeroGroupHeroItem", HeroGroupHeroItem)

function TowerComposeResultHeroGroupHeroItem:onUpdateMO(mo)
	TowerComposeResultHeroGroupHeroItem.super.onUpdateMO(self, mo)
	gohelper.setActive(self._subGO, false)
	transformhelper.setLocalPosXY(self._tagTr, 36.3, 212.1)
end

function TowerComposeResultHeroGroupHeroItem:setPlaneType(planeType)
	self.planeType = planeType
end

return TowerComposeResultHeroGroupHeroItem
