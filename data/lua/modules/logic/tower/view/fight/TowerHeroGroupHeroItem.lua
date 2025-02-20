module("modules.logic.tower.view.fight.TowerHeroGroupHeroItem", package.seeall)

slot0 = class("TowerHeroGroupHeroItem", HeroGroupHeroItem)

function slot0.checkTower(slot0)
	if HeroGroupModel.instance.heroGroupType ~= ModuleEnum.HeroGroupType.General then
		return
	end

	if slot0._heroMO ~= nil and slot0.monsterCO == nil then
		if TowerModel.instance:isHeroLocked(slot0._heroMO.config.id) then
			slot0._commonHeroCard:setGrayScale(false)
		elseif TowerModel.instance:isHeroBan(slot0._heroMO.config.id) then
			slot0._playDeathAnim = true

			slot0:playAnim("herogroup_hero_deal")

			slot0.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, slot0.setGrayFactor, nil, slot0)

			return slot0._heroMO.id
		else
			slot0._commonHeroCard:setGrayScale(false)
		end
	end
end

return slot0
