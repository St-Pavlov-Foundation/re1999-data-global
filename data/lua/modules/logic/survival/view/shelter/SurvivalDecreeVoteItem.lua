module("modules.logic.survival.view.shelter.SurvivalDecreeVoteItem", package.seeall)

local var_0_0 = class("SurvivalDecreeVoteItem", SurvivalDecreeItem)

function var_0_0.onUpdateMO(arg_1_0, arg_1_1)
	arg_1_0.mo = arg_1_1

	local var_1_0 = false
	local var_1_1 = arg_1_1 == nil or arg_1_1:isCurPolicyEmpty()
	local var_1_2 = not var_1_0 and not var_1_1
	local var_1_3 = not var_1_0 and var_1_1

	gohelper.setActive(arg_1_0.goHas, var_1_2)
	gohelper.setActive(arg_1_0.goAdd, var_1_3)
	gohelper.setActive(arg_1_0.goLocked, var_1_0)
	gohelper.setActive(arg_1_0.goAnnouncement, false)

	if var_1_2 then
		arg_1_0:refreshHas(true)
	end
end

function var_0_0.refreshHas(arg_2_0, arg_2_1)
	gohelper.setActive(arg_2_0.btnVote, false)
	gohelper.setActive(arg_2_0.goFinished, false)
	gohelper.setActive(arg_2_0.goAnnouncement, true)

	local var_2_0 = arg_2_0.mo:getCurPolicyGroup():getPolicyList()

	for iter_2_0 = 1, math.max(#var_2_0, #arg_2_0.itemList) do
		local var_2_1 = arg_2_0:getItem(iter_2_0)

		arg_2_0:updateDescItem(var_2_1, var_2_0[iter_2_0], arg_2_1)
	end

	recthelper.setHeight(arg_2_0.goDescer.transform, 381)
end

return var_0_0
