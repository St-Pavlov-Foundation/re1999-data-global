module("modules.logic.fight.entity.comp.specialskineffect.FightEntitySpecialSkinEffect307301_buff4150002", package.seeall)

local var_0_0 = class("FightEntitySpecialSkinEffect307301_buff4150002", FightEntitySpecialEffectBase)

function var_0_0.initClass(arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.SetEntityAlpha, arg_1_0._onSetEntityAlpha, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.SetBuffEffectVisible, arg_1_0._onSetBuffEffectVisible, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_1_0._onBuffUpdate, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.BeforeEnterStepBehaviour, arg_1_0._onBeforeEnterStepBehaviour, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.BeforeDeadEffect, arg_1_0._onBeforeDeadEffect, arg_1_0)
end

function var_0_0._releaseEffect(arg_2_0)
	if arg_2_0._effectWrap then
		arg_2_0._entity.effect:removeEffect(arg_2_0._effectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_2_0._entity.id, arg_2_0._effectWrap)

		arg_2_0._effectWrap = nil
	end
end

local var_0_1 = "v1a5_kerandian/kerandian_innate_1"

function var_0_0._createEffect(arg_3_0)
	arg_3_0._effectWrap = arg_3_0._effectWrap or arg_3_0._entity.effect:addHangEffect(var_0_1, ModuleEnum.SpineHangPoint.mountweapon)

	FightRenderOrderMgr.instance:onAddEffectWrap(arg_3_0._entity.id, arg_3_0._effectWrap)
	arg_3_0._effectWrap:setLocalPos(0, 0, 0)
end

function var_0_0._onBuffUpdate(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_1 ~= arg_4_0._entity.id then
		return
	end

	if arg_4_3 == 4150002 then
		if arg_4_0._entity.buff and arg_4_0._entity.buff:haveBuffId(arg_4_3) then
			arg_4_0:_createEffect()
		else
			arg_4_0:_releaseEffect()
		end
	end
end

function var_0_0._onBeforeEnterStepBehaviour(arg_5_0)
	local var_5_0 = arg_5_0._entity:getMO()

	if var_5_0 then
		local var_5_1 = var_5_0:getBuffDic()

		for iter_5_0, iter_5_1 in pairs(var_5_1) do
			arg_5_0:_onBuffUpdate(arg_5_0._entity.id, FightEnum.EffectType.BUFFADD, iter_5_1.buffId, iter_5_1.uid)
		end
	end
end

function var_0_0._onSetEntityAlpha(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:_onSetBuffEffectVisible(arg_6_1, arg_6_2, "_onSetEntityAlpha")
end

function var_0_0._onSetBuffEffectVisible(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_0._entity.id == arg_7_1 and arg_7_0._effectWrap then
		arg_7_0._effectWrap:setActive(arg_7_2, arg_7_3 or "FightEntitySpecialSkinEffect307301_buff4150002")
	end
end

function var_0_0._onBeforeDeadEffect(arg_8_0, arg_8_1)
	if arg_8_1 == arg_8_0._entity.id then
		arg_8_0:_releaseEffect()
	end
end

function var_0_0.releaseSelf(arg_9_0)
	arg_9_0:_releaseEffect()
end

return var_0_0
