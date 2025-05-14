module("modules.logic.rouge.view.RougePickAssistItem", package.seeall)

local var_0_0 = class("RougePickAssistItem", PickAssistItem)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)
	arg_1_0:_initCapacity()
end

function var_0_0._initCapacity(arg_2_0)
	local var_2_0 = gohelper.findChild(arg_2_0.viewGO, "volume")

	arg_2_0._capacityComp = RougeCapacityComp.Add(var_2_0, nil, nil, true)

	arg_2_0._capacityComp:setSpriteType(RougeCapacityComp.SpriteType3, RougeCapacityComp.SpriteType3)
end

function var_0_0.onUpdateMO(arg_3_0, arg_3_1)
	var_0_0.super.onUpdateMO(arg_3_0, arg_3_1)

	local var_3_0 = arg_3_0._mo.heroMO
	local var_3_1 = RougeHeroGroupBalanceHelper.getHeroBalanceLv(var_3_0.heroId)

	if var_3_1 > var_3_0.level then
		arg_3_0._heroItem:setBalanceLv(var_3_1)
	end

	local var_3_2 = RougeConfig1.instance:getRoleCapacity(arg_3_1.heroMO.config.rare)

	arg_3_0._capacity = var_3_2

	arg_3_0._capacityComp:updateMaxNum(var_3_2)
end

function var_0_0._checkClick(arg_4_0)
	local var_4_0 = RougeController.instance.pickAssistViewParams

	if var_4_0.curCapacity + arg_4_0._capacity > var_4_0.totalCapacity then
		GameFacade.showToast(ToastEnum.RougeTeamSelectHeroCapacityFull)

		return false
	end

	return true
end

return var_0_0
