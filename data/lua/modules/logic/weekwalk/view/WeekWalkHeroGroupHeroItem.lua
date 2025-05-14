module("modules.logic.weekwalk.view.WeekWalkHeroGroupHeroItem", package.seeall)

local var_0_0 = class("WeekWalkHeroGroupHeroItem", HeroGroupHeroItem)

function var_0_0.checkWeekWalkCd(arg_1_0)
	if HeroGroupModel.instance:isAdventureOrWeekWalk() and arg_1_0._heroMO ~= nil and arg_1_0.monsterCO == nil then
		if WeekWalkModel.instance:getCurMapHeroCd(arg_1_0._heroMO.config.id) > 0 then
			arg_1_0._playDeathAnim = true

			arg_1_0:playAnim("herogroup_hero_deal")

			arg_1_0.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, arg_1_0.setGrayFactor, nil, arg_1_0)

			return arg_1_0._heroMO.id
		else
			arg_1_0._commonHeroCard:setGrayScale(false)
		end
	end
end

return var_0_0
