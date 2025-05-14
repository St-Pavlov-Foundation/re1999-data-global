module("modules.logic.guide.controller.action.impl.WaitGuideActionHasEnoughMaterial", package.seeall)

local var_0_0 = class("WaitGuideActionHasEnoughMaterial", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, arg_1_0._checkMaterials, arg_1_0)

	arg_1_0._materials = GameUtil.splitString2(arg_1_0.actionParam, true, "|", "#")

	arg_1_0:_checkMaterials()
end

function var_0_0._checkMaterials(arg_2_0)
	local var_2_0 = true

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._materials) do
		local var_2_1 = iter_2_1[1]
		local var_2_2 = iter_2_1[2]

		if iter_2_1[3] > ItemModel.instance:getItemQuantity(var_2_1, var_2_2) then
			var_2_0 = false

			break
		end
	end

	if var_2_0 then
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, arg_3_0._checkMaterials, arg_3_0)
end

return var_0_0
