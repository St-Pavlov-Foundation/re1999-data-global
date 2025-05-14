module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffectBase", package.seeall)

local var_0_0 = class("FightEntitySpecialEffectBase", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0._entity = arg_1_1
	arg_1_0._internalEffects = {}
	arg_1_0._internalClass = {}

	arg_1_0:initClass()
end

function var_0_0.initClass(arg_2_0)
	return
end

function var_0_0.newClass(arg_3_0, arg_3_1)
	table.insert(arg_3_0._internalClass, arg_3_1.New(arg_3_0._entity))
end

function var_0_0.addHangEffect(arg_4_0, ...)
	local var_4_0 = arg_4_0._entity:addHangEffect(...)

	arg_4_0._internalEffects[var_4_0.uniqueId] = var_4_0

	return var_4_0
end

function var_0_0.addGlobalEffect(arg_5_0, ...)
	local var_5_0 = arg_5_0._entity:addGlobalEffect(...)

	arg_5_0._internalEffects[var_5_0.uniqueId] = var_5_0

	return var_5_0
end

function var_0_0.removeEffect(arg_6_0, arg_6_1)
	arg_6_0._internalEffects[arg_6_1.uniqueId] = nil

	arg_6_0._entity.effect:removeEffect(arg_6_1)
	FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_6_0._entity.id, arg_6_1)
end

function var_0_0.setEffectActive(arg_7_0, arg_7_1)
	if arg_7_0._internalClass then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._internalClass) do
			if iter_7_1.setEffectActive then
				iter_7_1:setEffectActive(arg_7_1)
			end
		end
	end

	if arg_7_0._internalEffects then
		for iter_7_2, iter_7_3 in pairs(arg_7_0._internalEffects) do
			iter_7_3:setActive(arg_7_1, "FightEntitySpecialEffectBase")
		end
	end
end

function var_0_0.releaseSelf(arg_8_0)
	return
end

function var_0_0.disposeSelf(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._internalClass) do
		iter_9_1:disposeSelf()
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_0._internalEffects) do
		arg_9_0:removeEffect(iter_9_3)
	end

	arg_9_0:releaseSelf()

	arg_9_0._internalClass = nil
	arg_9_0._internalEffects = nil
	arg_9_0._entity = nil

	arg_9_0:__onDispose()
end

return var_0_0
