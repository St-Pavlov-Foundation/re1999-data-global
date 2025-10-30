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

function var_0_0.beforePlayEffectData(arg_1_0)
	local var_1_0 = FightDataHelper.entityMgr:getById(arg_1_0.actEffectData.targetId)

	if var_1_0 then
		arg_1_0.oldCareer = var_1_0.career
	end
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = arg_2_0:com_registWorkDoneFlowSequence()

	if FightDataHelper.entityMgr:getById(arg_2_0.actEffectData.targetId) and arg_2_0.oldCareer ~= arg_2_0.actEffectData.effectNum then
		var_2_0:registWork(FightWorkFunction, arg_2_0._playCareerChange, arg_2_0)
		var_2_0:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.ChangeCareer))
	end

	var_2_0:start()
end

function var_0_0._playCareerChange(arg_3_0)
	local var_3_0 = FightDataHelper.entityMgr:getById(arg_3_0.actEffectData.targetId)

	if var_3_0 then
		FightController.instance:dispatchEvent(FightEvent.ChangeCareer, var_3_0.id)

		local var_3_1 = FightHelper.getEntity(var_3_0.id)

		if var_3_1 and var_3_1.effect then
			local var_3_2 = var_3_1.effect:addHangEffect(var_0_1[var_3_0.career], "mounttop", nil, 2)

			FightRenderOrderMgr.instance:onAddEffectWrap(var_3_1.id, var_3_2)
			var_3_2:setLocalPos(0, 0, 0)
		end
	end
end

function var_0_0._onFlowDone(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	return
end

return var_0_0
