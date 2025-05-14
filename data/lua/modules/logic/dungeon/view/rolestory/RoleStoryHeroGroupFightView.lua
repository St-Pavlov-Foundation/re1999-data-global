module("modules.logic.dungeon.view.rolestory.RoleStoryHeroGroupFightView", package.seeall)

local var_0_0 = class("RoleStoryHeroGroupFightView", HeroGroupFightView)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._gotarget = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain")

	gohelper.setActive(arg_1_0._gotarget, false)
end

function var_0_0._refreshCost(arg_2_0, arg_2_1)
	gohelper.setActive(arg_2_0._gocost, arg_2_1)

	local var_2_0 = arg_2_0:_getfreeCount()

	gohelper.setActive(arg_2_0._gopower, not arg_2_0._enterAfterFreeLimit)
	gohelper.setActive(arg_2_0._gocount, not arg_2_0._enterAfterFreeLimit and var_2_0 > 0)
	gohelper.setActive(arg_2_0._gonormallackpower, false)
	gohelper.setActive(arg_2_0._goreplaylackpower, false)

	if arg_2_0._enterAfterFreeLimit or var_2_0 > 0 then
		local var_2_1 = tostring(-1 * math.min(arg_2_0._multiplication, var_2_0))

		arg_2_0._txtCostNum.text = var_2_1
		arg_2_0._txtReplayCostNum.text = var_2_1
		arg_2_0._txtcostcount.text = string.format("<color=#B3AFAC>%s</color><color=#B26161>%s</color>", luaLang("p_dungeonmaplevel_costcount"), var_2_1)

		if var_2_0 >= arg_2_0._multiplication then
			arg_2_0:_refreshBtns(false)

			return
		end
	end

	local var_2_2 = GameUtil.splitString2(arg_2_0.episodeConfig.cost, true)[1]
	local var_2_3

	if var_2_2[1] == MaterialEnum.MaterialType.Currency and var_2_2[2] == CurrencyEnum.CurrencyType.Power then
		local var_2_4 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)

		var_2_3 = ResUrl.getCurrencyItemIcon(var_2_4.icon .. "_btn")
	else
		var_2_3 = ItemModel.instance:getItemSmallIcon(var_2_2[2])
	end

	arg_2_0._simagepower:LoadImage(var_2_3)
	recthelper.setSize(arg_2_0._simagepower.transform, 100, 100)
	arg_2_0:_refreshCostPower()
end

function var_0_0._onClickStart(arg_3_0)
	local var_3_0 = GameUtil.splitString2(arg_3_0.episodeConfig.cost, true)
	local var_3_1 = arg_3_0:_getfreeCount()
	local var_3_2 = (arg_3_0._multiplication or 1) - var_3_1
	local var_3_3 = {}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		table.insert(var_3_3, {
			type = iter_3_1[1],
			id = iter_3_1[2],
			quantity = iter_3_1[3] * var_3_2
		})
	end

	local var_3_4, var_3_5, var_3_6 = ItemModel.instance:hasEnoughItems(var_3_3)

	if not var_3_5 then
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_3_6, var_3_4)

		return
	end

	arg_3_0:_closemultcontent()
	arg_3_0:_enterFight()
end

function var_0_0._refreshCostPower(arg_4_0)
	local var_4_0 = GameUtil.splitString2(arg_4_0.episodeConfig.cost, true)[1]
	local var_4_1 = var_4_0[3] or 0
	local var_4_2 = var_4_1 > 0

	if arg_4_0._enterAfterFreeLimit then
		var_4_2 = false
	end

	gohelper.setActive(arg_4_0._gopower, var_4_2)
	arg_4_0:_refreshBtns(var_4_2)

	if not var_4_2 then
		return
	end

	local var_4_3 = var_4_1 * ((arg_4_0._multiplication or 1) - arg_4_0:_getfreeCount())

	arg_4_0._txtusepower.text = string.format("-%s", var_4_3)

	local var_4_4 = arg_4_0._chapterConfig.type == DungeonEnum.ChapterType.Hard

	if var_4_3 <= ItemModel.instance:getItemQuantity(var_4_0[1], var_4_0[2]) then
		local var_4_5 = var_4_4 and "#FFFFFF" or "#070706"

		SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._txtusepower, arg_4_0._replayMode and "#070706" or var_4_5)
	else
		local var_4_6 = var_4_4 and "#C44945" or "#800015"

		SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._txtusepower, arg_4_0._replayMode and "#800015" or var_4_6)
		gohelper.setActive(arg_4_0._gonormallackpower, not arg_4_0._replayMode)
		gohelper.setActive(arg_4_0._goreplaylackpower, arg_4_0._replayMode)
	end
end

return var_0_0
