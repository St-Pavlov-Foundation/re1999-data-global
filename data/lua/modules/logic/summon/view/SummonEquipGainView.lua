module("modules.logic.summon.view.SummonEquipGainView", package.seeall)

local var_0_0 = class("SummonEquipGainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:addEventCb(SummonController.instance, SummonEvent.onSummonEquipSingleFinish, arg_4_0.onSummonSingleAnimFinish, arg_4_0)
end

function var_0_0.onSummonSingleAnimFinish(arg_5_0)
	local var_5_0 = arg_5_0.viewParam.summonResultMo
	local var_5_1 = SummonModel.getRewardList({
		var_5_0
	})

	if #var_5_1 <= 0 then
		return
	end

	table.sort(var_5_1, SummonModel.sortRewards)

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		if iter_5_1.materilType == MaterialEnum.MaterialType.Currency then
			local var_5_2, var_5_3 = ItemModel.instance:getItemConfigAndIcon(iter_5_1.materilType, iter_5_1.materilId)
			local var_5_4 = iter_5_1.quantity
			local var_5_5 = luaLang("equip_duplicate_tips")
			local var_5_6 = string.format("%s\n%sX%s", var_5_5, var_5_2.name, var_5_4)

			GameFacade.showToastWithIcon(ToastEnum.IconId, var_5_3, var_5_6)
		end
	end
end

return var_0_0
