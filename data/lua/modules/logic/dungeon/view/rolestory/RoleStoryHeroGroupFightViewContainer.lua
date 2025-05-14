module("modules.logic.dungeon.view.rolestory.RoleStoryHeroGroupFightViewContainer", package.seeall)

local var_0_0 = class("RoleStoryHeroGroupFightViewContainer", HeroGroupFightViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._heroGroupFairyLandView = HeroGroupFairyLandView.New()
	arg_1_0._heroGroupFightView = RoleStoryHeroGroupFightView.New()

	return {
		arg_1_0._heroGroupFairyLandView,
		arg_1_0._heroGroupFightView,
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

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = arg_2_0:getHelpId()
		local var_2_1 = not arg_2_0:_checkHideHomeBtn()

		arg_2_0._navigateButtonsView = NavigateButtonsView.New({
			true,
			var_2_1,
			var_2_0 ~= nil
		}, var_2_0, arg_2_0._closeCallback, nil, nil, arg_2_0)

		arg_2_0._navigateButtonsView:setCloseCheck(arg_2_0.defaultOverrideCloseCheck, arg_2_0)

		return {
			arg_2_0._navigateButtonsView
		}
	elseif arg_2_1 == 2 then
		local var_2_2 = arg_2_0:getCurrencyParam()
		local var_2_3 = CurrencyView.New(var_2_2)

		var_2_3.foreHideBtn = true

		return {
			var_2_3
		}
	end
end

function var_0_0.getCurrencyParam(arg_3_0)
	local var_3_0 = arg_3_0:_checkHidePowerCurrencyBtn()
	local var_3_1 = {}

	if not var_3_0 then
		local var_3_2 = HeroGroupModel.instance.episodeId
		local var_3_3 = DungeonConfig.instance:getEpisodeCO(var_3_2)
		local var_3_4 = GameUtil.splitString2(var_3_3.cost, true)

		if var_3_4 then
			for iter_3_0, iter_3_1 in ipairs(var_3_4) do
				if iter_3_1[1] == MaterialEnum.MaterialType.Currency then
					table.insert(var_3_1, iter_3_1[2])
				else
					table.insert(var_3_1, {
						isIcon = true,
						type = iter_3_1[1],
						id = iter_3_1[2]
					})
				end
			end
		end
	end

	return var_3_1
end

return var_0_0
