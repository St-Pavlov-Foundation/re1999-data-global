module("modules.logic.summon.view.SummonPoolHistoryListItem", package.seeall)

local var_0_0 = class("SummonPoolHistoryListItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._name = gohelper.findChildText(arg_1_1, "main/name/#txt_name")
	arg_1_0._pooltype = gohelper.findChildText(arg_1_1, "main/type/#txt_type")
	arg_1_0._time = gohelper.findChildText(arg_1_1, "main/time/#txt_time")
	arg_1_0._imgstar = gohelper.findChildImage(arg_1_1, "main/name/#txt_name/img_star")
	arg_1_0._gomain = gohelper.findChild(arg_1_1, "main")
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1

	arg_4_0:_refreshItem()
end

function var_0_0._refreshItem(arg_5_0)
	if arg_5_0._mo then
		local var_5_0
		local var_5_1

		if not arg_5_0._mo.isLuckyBag then
			var_5_0, var_5_1 = arg_5_0:getNameAndRare(arg_5_0._mo.gainId)
		else
			var_5_0, var_5_1 = arg_5_0:getLuckyBagNameAndRare(arg_5_0._mo.gainId, arg_5_0._mo.poolId)
		end

		arg_5_0._name.text = arg_5_0:getStarName(var_5_0, var_5_1)

		local var_5_2 = arg_5_0._mo.poolId
		local var_5_3 = SummonConfig.instance:getSummonPool(var_5_2)
		local var_5_4 = var_5_3 and var_5_3.nameCn or arg_5_0._mo.poolName

		arg_5_0._pooltype.text = var_5_4
		arg_5_0._time.text = arg_5_0._mo.createTime

		gohelper.setActive(arg_5_0._imgstar.gameObject, var_5_1 >= 4)

		var_5_1 = var_5_1 or 1

		local var_5_5 = SummonEnum.HistoryColor[var_5_1] or SummonEnum.HistoryColor[1]

		if arg_5_0._colorStr ~= var_5_5 then
			arg_5_0._colorStr = var_5_5

			SLFramework.UGUI.GuiHelper.SetColor(arg_5_0._name, var_5_5)

			if var_5_1 >= 4 then
				SLFramework.UGUI.GuiHelper.SetColor(arg_5_0._imgstar, var_5_5)
			end
		end
	end

	gohelper.setActive(arg_5_0._gomain, arg_5_0._mo and true or false)
end

function var_0_0.getStarName(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = SummonEnum.HistoryNameStarFormat[arg_6_2]

	if var_6_0 then
		return string.format(var_6_0, arg_6_1)
	end

	return arg_6_1
end

function var_0_0.getNameAndRare(arg_7_0, arg_7_1)
	local var_7_0 = HeroConfig.instance:getHeroCO(arg_7_1)

	if var_7_0 then
		return var_7_0.name, var_7_0.rare
	end

	local var_7_1 = EquipConfig.instance:getEquipCo(arg_7_1)

	if var_7_1 then
		return var_7_1.name, var_7_1.rare
	end

	return arg_7_1 .. "", 1
end

function var_0_0.getLuckyBagNameAndRare(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = SummonConfig.instance:getLuckyBag(arg_8_2, arg_8_1)

	if var_8_0 then
		return var_8_0.name, SummonEnum.LuckyBagRare
	else
		return tostring(arg_8_1), SummonEnum.LuckyBagRare
	end
end

function var_0_0.onDestroy(arg_9_0)
	return
end

return var_0_0
