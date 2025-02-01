module("modules.logic.dungeon.view.rolestory.RoleStoryHeroGroupFightViewContainer", package.seeall)

slot0 = class("RoleStoryHeroGroupFightViewContainer", HeroGroupFightViewContainer)

function slot0.buildViews(slot0)
	slot0._heroGroupFairyLandView = HeroGroupFairyLandView.New()
	slot0._heroGroupFightView = RoleStoryHeroGroupFightView.New()

	return {
		slot0._heroGroupFairyLandView,
		slot0._heroGroupFightView,
		HeroGroupAnimView.New(),
		HeroGroupListView.New(),
		RoleStoryHeroGroupFightViewLevel.New(),
		HeroGroupFightViewRule.New(),
		HeroGroupInfoScrollView.New(),
		CheckActivityEndView.New(),
		TabViewGroup.New(1, "#go_container/btnContain/commonBtns"),
		TabViewGroup.New(2, "#go_righttop/#go_power")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonsView = NavigateButtonsView.New({
			true,
			not slot0:_checkHideHomeBtn(),
			slot0:getHelpId() ~= nil
		}, slot2, slot0._closeCallback, nil, , slot0)

		slot0._navigateButtonsView:setCloseCheck(slot0.defaultOverrideCloseCheck, slot0)

		return {
			slot0._navigateButtonsView
		}
	elseif slot1 == 2 then
		slot3 = CurrencyView.New(slot0:getCurrencyParam())
		slot3.foreHideBtn = true

		return {
			slot3
		}
	end
end

function slot0.getCurrencyParam(slot0)
	slot2 = {}

	if not slot0:_checkHidePowerCurrencyBtn() and GameUtil.splitString2(DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId).cost, true) then
		for slot9, slot10 in ipairs(slot5) do
			if slot10[1] == MaterialEnum.MaterialType.Currency then
				table.insert(slot2, slot10[2])
			else
				table.insert(slot2, {
					isIcon = true,
					type = slot10[1],
					id = slot10[2]
				})
			end
		end
	end

	return slot2
end

return slot0
