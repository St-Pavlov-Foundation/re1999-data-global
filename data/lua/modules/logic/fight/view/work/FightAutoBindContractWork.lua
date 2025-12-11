module("modules.logic.fight.view.work.FightAutoBindContractWork", package.seeall)

local var_0_0 = class("FightAutoBindContractWork", FightWorkItem)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.SAFETIME = 10
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = FightModel.instance.notifyEntityId

	if string.nilorempty(var_2_0) then
		return arg_2_0:onDone(true)
	end

	if not FightHelper.getEntity(var_2_0) then
		return arg_2_0:onDone(true)
	end

	local var_2_1 = FightModel.instance.canContractList

	if not var_2_1 or #var_2_1 < 1 then
		return arg_2_0:onDone(true)
	end

	return arg_2_0:autoContract(var_2_1, var_2_0)
end

function var_0_0.autoContract(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0
	local var_3_1 = 0

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if iter_3_1 ~= arg_3_2 then
			local var_3_2 = FightDataHelper.entityMgr:getById(iter_3_1)
			local var_3_3 = var_3_2 and var_3_2.attrMO
			local var_3_4 = var_3_3 and var_3_3.attack

			if var_3_4 and var_3_1 < var_3_4 then
				var_3_0 = iter_3_1
				var_3_1 = var_3_4
			end
		end
	end

	if not var_3_0 then
		return arg_3_0:onDone(true)
	end

	FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, arg_3_0._onRespUseClothSkillFail, arg_3_0)
	FightRpc.instance:sendUseClothSkillRequest(0, arg_3_2, var_3_0, FightEnum.ClothSkillType.Contract)
end

function var_0_0._onRespUseClothSkillFail(arg_4_0)
	arg_4_0:onDone(false)
end

function var_0_0.clearWork(arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.RespUseClothSkillFail, arg_5_0._onRespUseClothSkillFail, arg_5_0)
end

return var_0_0
