-- chunkname: @modules/logic/towercompose/view/herogroup/TowerComposeHeroGroupHeroItem.lua

module("modules.logic.towercompose.view.herogroup.TowerComposeHeroGroupHeroItem", package.seeall)

local TowerComposeHeroGroupHeroItem = class("TowerComposeHeroGroupHeroItem", HeroGroupHeroItem)

function TowerComposeHeroGroupHeroItem:init(go)
	TowerComposeHeroGroupHeroItem.super.init(self, go)

	self._goaddNum = gohelper.findChild(go, "heroitemani/#go_addnum")
	self._txtaddNum = gohelper.findChildText(go, "heroitemani/#go_addnum/#txt_addnum")
end

function TowerComposeHeroGroupHeroItem:onUpdateMO(mo)
	TowerComposeHeroGroupHeroItem.super.onUpdateMO(self, mo)
	gohelper.setActive(self._subGO, false)
	transformhelper.setLocalPosXY(self._tagTr, 36.3, 212.1)
	self:refreshExtraAddTag()
end

function TowerComposeHeroGroupHeroItem:refreshExtraAddTag()
	local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	local themeId = recordFightParam.themeId
	local layerId = recordFightParam.layerId
	local towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(themeId, layerId)
	local heroId = TowerComposeHeroGroupModel.instance:getHeroIdByHeroSingleGroupMO(self.mo)

	if not heroId or tonumber(heroId) == 0 or towerEpisodeConfig.plane == 0 then
		gohelper.setActive(self._goaddNum, false)

		return
	end

	local isExtraHero, extraCo = TowerComposeConfig.instance:checkIsExtraHero(themeId, heroId)

	if isExtraHero then
		self._txtaddNum.text = string.format("+%s", extraCo.bossPointBase)
	end

	local curInPlaneId = Mathf.Ceil(self._index / 4) or 0
	local realExtraHeroCoList = TowerComposeHeroGroupModel.instance:getPlaneRealExtraCoList(themeId, curInPlaneId)
	local isRealExtraHero = false

	for _, extraCo in ipairs(realExtraHeroCoList) do
		if heroId == extraCo.id then
			isRealExtraHero = true

			break
		end
	end

	gohelper.setActive(self._goaddNum, isExtraHero and towerEpisodeConfig.plane > 0 and isRealExtraHero)
end

function TowerComposeHeroGroupHeroItem:setPlaneType(planeType)
	self.planeType = planeType
end

return TowerComposeHeroGroupHeroItem
