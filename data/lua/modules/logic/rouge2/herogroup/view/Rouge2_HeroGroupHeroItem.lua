-- chunkname: @modules/logic/rouge2/herogroup/view/Rouge2_HeroGroupHeroItem.lua

module("modules.logic.rouge2.herogroup.view.Rouge2_HeroGroupHeroItem", package.seeall)

local Rouge2_HeroGroupHeroItem = class("Rouge2_HeroGroupHeroItem", HeroGroupHeroItem)

function Rouge2_HeroGroupHeroItem:onUpdateMO(mo)
	Rouge2_HeroGroupHeroItem.super.onUpdateMO(self, mo)
	self:balanceHero()
end

function Rouge2_HeroGroupHeroItem:balanceHero()
	if self._heroMO then
		local replay_data

		if HeroGroupModel.instance:getCurGroupMO().isReplay then
			replay_data = HeroGroupModel.instance:getCurGroupMO().replay_hero_data[self.mo.heroUid]
		end

		local lv = replay_data and replay_data.level or self._heroMO.level
		local roleLv = Rouge2_HeroGroupBalanceHelper.getHeroBalanceLv(self._heroMO.heroId)
		local isBalanceLv

		if lv < roleLv then
			lv = roleLv
			isBalanceLv = true
		end

		local hero_level, hero_rank = HeroConfig.instance:getShowLevel(lv)

		if isBalanceLv then
			SLFramework.UGUI.GuiHelper.SetColor(self._lvnumen, Rouge2_HeroGroupBalanceHelper.BalanceColor)

			self._lvnum.text = "<color=" .. Rouge2_HeroGroupBalanceHelper.BalanceColor .. ">" .. hero_level

			for i = 1, 3 do
				SLFramework.UGUI.GuiHelper.SetColor(self._goRankList[i], Rouge2_HeroGroupBalanceHelper.BalanceIconColor)
			end
		else
			self._lvnum.text = hero_level
		end

		for i = 1, 3 do
			local rankGO = self._goRankList[i]

			gohelper.setActive(rankGO, i == hero_rank - 1)
		end

		gohelper.setActive(self._goStars, true)

		for i = 1, 6 do
			local starGO = self._goStarList[i]

			gohelper.setActive(starGO, i <= CharacterEnum.Star[self._heroMO.config.rare])
		end
	end
end

return Rouge2_HeroGroupHeroItem
