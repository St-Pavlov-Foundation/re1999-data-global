module("modules.logic.tower.view.fight.TowerHeroGroupHeroItem", package.seeall)

local var_0_0 = class("TowerHeroGroupHeroItem", HeroGroupHeroItem)

function var_0_0.checkTower(arg_1_0)
	if HeroGroupModel.instance.heroGroupType ~= ModuleEnum.HeroGroupType.General then
		return
	end

	if arg_1_0._heroMO ~= nil and arg_1_0.monsterCO == nil then
		if TowerModel.instance:isHeroLocked(arg_1_0._heroMO.config.id) then
			arg_1_0._commonHeroCard:setGrayScale(false)
		elseif TowerModel.instance:isHeroBan(arg_1_0._heroMO.config.id) then
			arg_1_0._playDeathAnim = true

			arg_1_0:playAnim("herogroup_hero_deal")

			arg_1_0.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, arg_1_0.setGrayFactor, nil, arg_1_0)

			return arg_1_0._heroMO.id
		else
			arg_1_0._commonHeroCard:setGrayScale(false)
		end
	elseif arg_1_0.trialCO ~= nil then
		if TowerModel.instance:isHeroLocked(arg_1_0.trialCO.heroId) then
			arg_1_0._commonHeroCard:setGrayScale(false)
		elseif TowerModel.instance:isHeroBan(arg_1_0.trialCO.heroId) then
			arg_1_0._playDeathAnim = true

			arg_1_0:playAnim("herogroup_hero_deal")

			arg_1_0.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, arg_1_0.setGrayFactor, nil, arg_1_0)

			return tostring(tonumber(arg_1_0.trialCO.id .. "." .. arg_1_0.trialCO.trialTemplate) - 1099511627776)
		else
			arg_1_0._commonHeroCard:setGrayScale(false)
		end
	end
end

return var_0_0
