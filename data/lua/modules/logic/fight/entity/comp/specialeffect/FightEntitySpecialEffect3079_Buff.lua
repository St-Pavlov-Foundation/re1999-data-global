module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffect3079_Buff", package.seeall)

local var_0_0 = class("FightEntitySpecialEffect3079_Buff", FightEntitySpecialEffectBase)

function var_0_0.initClass(arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_1_0._onBuffUpdate, arg_1_0)

	arg_1_0._showBuffIdList = {}
end

local var_0_1 = 1.5
local var_0_2 = 0.9

function var_0_0._onBuffUpdate(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	if arg_2_1 ~= arg_2_0._entity.id then
		return
	end

	if not arg_2_6 then
		return
	end

	local var_2_0 = FightDataHelper.entityMgr:getById(arg_2_6.fromUid)

	if not var_2_0 then
		return
	end

	local var_2_1 = lua_fight_6_buff_effect.configDict[var_2_0.skin] or lua_fight_6_buff_effect.configDict[0]

	var_2_1 = var_2_1 and var_2_1[arg_2_3]

	if var_2_1 and arg_2_2 == FightEnum.EffectType.BUFFADD then
		table.insert(arg_2_0._showBuffIdList, {
			buffId = arg_2_3,
			config = var_2_1
		})

		if not arg_2_0._playing then
			arg_2_0:_showBuffEffect()
		end
	end
end

function var_0_0._showBuffEffect(arg_3_0)
	local var_3_0 = table.remove(arg_3_0._showBuffIdList, 1)

	if var_3_0 then
		arg_3_0._playing = true

		local var_3_1 = var_3_0.config
		local var_3_2 = string.nilorempty(var_3_1.effectHang) and ModuleEnum.SpineHangPointRoot or var_3_1.effectHang
		local var_3_3 = arg_3_0._entity.effect:addHangEffect(var_3_1.effect, var_3_2, nil, var_0_1)

		FightRenderOrderMgr.instance:onAddEffectWrap(arg_3_0._entity.id, var_3_3)
		var_3_3:setLocalPos(0, 0, 0)
		TaskDispatcher.runDelay(arg_3_0._showBuffEffect, arg_3_0, var_0_2)

		if var_3_1.audioId ~= 0 then
			AudioMgr.instance:trigger(var_3_1.audioId)
		end
	else
		arg_3_0._playing = false
	end
end

function var_0_0.releaseSelf(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._showBuffEffect, arg_4_0)
end

return var_0_0
