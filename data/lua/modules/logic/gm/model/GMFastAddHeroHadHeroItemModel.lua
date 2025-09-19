module("modules.logic.gm.model.GMFastAddHeroHadHeroItemModel", package.seeall)

local var_0_0 = class("GMFastAddHeroHadHeroItemModel", ListScrollModel)

var_0_0.ShowType = {
	Equip = 2,
	Hero = 1
}

function var_0_0.refreshList(arg_1_0, arg_1_1)
	table.sort(arg_1_1, arg_1_0._sortMo)
	arg_1_0:setList(arg_1_1)
end

function var_0_0._sortMo(arg_2_0, arg_2_1)
	if arg_2_0.config.id ~= arg_2_1.config.id then
		return arg_2_0.config.id > arg_2_1.config.id
	end

	return arg_2_0.uid > arg_2_1.uid
end

function var_0_0.setShowType(arg_3_0, arg_3_1)
	arg_3_0.showType = arg_3_1
end

function var_0_0.getShowType(arg_4_0)
	return arg_4_0.showType
end

function var_0_0.changeShowType(arg_5_0)
	if arg_5_0.showType == var_0_0.ShowType.Hero then
		arg_5_0.showType = var_0_0.ShowType.Equip
	else
		arg_5_0.showType = var_0_0.ShowType.Hero
	end
end

function var_0_0.setFastAddHeroView(arg_6_0, arg_6_1)
	arg_6_0.fastAddHeroView = arg_6_1
end

function var_0_0.changeSelectHeroItem(arg_7_0, arg_7_1)
	if arg_7_0.fastAddHeroView then
		arg_7_0.fastAddHeroView:changeSelectHeroItemMo(arg_7_1)
	end
end

function var_0_0.setSelectMo(arg_8_0, arg_8_1)
	arg_8_0.selectMo = arg_8_1

	GMController.instance:dispatchEvent(GMController.Event.ChangeSelectHeroItem)
end

function var_0_0.getSelectMo(arg_9_0)
	return arg_9_0.selectMo
end

var_0_0.instance = var_0_0.New()

return var_0_0
