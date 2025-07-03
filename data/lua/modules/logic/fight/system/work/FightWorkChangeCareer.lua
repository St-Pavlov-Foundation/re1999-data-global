module("modules.logic.fight.system.work.FightWorkChangeCareer", package.seeall)

local var_0_0 = class("FightWorkChangeCareer", FightEffectBase)
local var_0_1 = {
	"buff/buff_lg_yan",
	"buff/buff_lg_xing",
	"buff/buff_lg_mu",
	"buff/buff_lg_shou",
	"buff/buff_lg_ling",
	"buff/buff_lg_zhi"
}

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0:com_registWorkDoneFlowSequence()
	local var_1_1 = FightDataHelper.entityMgr:getById(arg_1_0.actEffectData.targetId)

	if var_1_1 and var_1_1.career ~= arg_1_0.actEffectData.effectNum then
		var_1_0:registWork(FightWorkFunction, arg_1_0._playCareerChange, arg_1_0)
		var_1_0:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.ChangeCareer))
	end

	var_1_0:start()
end

function var_0_0._playCareerChange(arg_2_0)
	local var_2_0 = FightDataHelper.entityMgr:getById(arg_2_0.actEffectData.targetId)

	if var_2_0 then
		FightController.instance:dispatchEvent(FightEvent.ChangeCareer, var_2_0.id)

		local var_2_1 = FightHelper.getEntity(var_2_0.id)

		if var_2_1 and var_2_1.effect then
			local var_2_2 = var_2_1.effect:addHangEffect(var_0_1[var_2_0.career], "mounttop", nil, 2)

			FightRenderOrderMgr.instance:onAddEffectWrap(var_2_1.id, var_2_2)
			var_2_2:setLocalPos(0, 0, 0)
		end
	end
end

function var_0_0._onFlowDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	return
end

return var_0_0
