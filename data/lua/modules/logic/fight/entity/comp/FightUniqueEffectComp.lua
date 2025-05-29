module("modules.logic.fight.entity.comp.FightUniqueEffectComp", package.seeall)

local var_0_0 = class("FightUniqueEffectComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0.entityId = arg_1_0.entity.id
	arg_1_0.existEffectWrapDict = {}
	arg_1_0.releaseEffectDict = {}
	arg_1_0.updateHandle = UpdateBeat:CreateListener(arg_1_0.update, arg_1_0)

	UpdateBeat:AddListener(arg_1_0.updateHandle)
end

function var_0_0.onDestroy(arg_2_0)
	if arg_2_0.updateHandle then
		UpdateBeat:RemoveListener(arg_2_0.updateHandle)
	end
end

function var_0_0.addHangEffect(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = arg_3_0.existEffectWrapDict[arg_3_1]

	if var_3_0 then
		return var_3_0
	end

	local var_3_1 = arg_3_0.entity.effect:addHangEffect(arg_3_1, arg_3_2, arg_3_3)

	FightRenderOrderMgr.instance:onAddEffectWrap(arg_3_0.entityId, var_3_1)

	arg_3_0.existEffectWrapDict[arg_3_1] = var_3_1

	if arg_3_4 then
		arg_3_0:releaseEffectAfterTime(arg_3_1, arg_3_4)
	end

	return var_3_1
end

function var_0_0.addGlobalEffect(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0.existEffectWrapDict[arg_4_1] then
		return
	end

	local var_4_0 = arg_4_0.entity.effect:addGlobalEffect(arg_4_1, arg_4_2)

	FightRenderOrderMgr.instance:onAddEffectWrap(arg_4_0.entityId, var_4_0)

	arg_4_0.existEffectWrapDict[arg_4_1] = var_4_0

	if arg_4_3 then
		arg_4_0:releaseEffectAfterTime(arg_4_1, arg_4_3)
	end

	return var_4_0
end

function var_0_0.releaseEffectAfterTime(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.releaseEffectDict[arg_5_1] = Time.realtimeSinceStartup + arg_5_2
end

function var_0_0.update(arg_6_0)
	local var_6_0 = Time.realtimeSinceStartup

	for iter_6_0, iter_6_1 in pairs(arg_6_0.releaseEffectDict) do
		if iter_6_1 <= var_6_0 then
			arg_6_0:removeEffect(iter_6_0)
		end
	end
end

function var_0_0.removeEffect(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.existEffectWrapDict[arg_7_1]

	if not var_7_0 then
		return
	end

	arg_7_0.existEffectWrapDict[arg_7_1] = nil
	arg_7_0.releaseEffectDict[arg_7_1] = nil

	FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_7_0.entityId, var_7_0)
	arg_7_0.entity.effect:removeEffect(var_7_0)
end

return var_0_0
