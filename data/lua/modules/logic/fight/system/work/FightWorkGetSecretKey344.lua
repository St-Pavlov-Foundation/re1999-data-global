module("modules.logic.fight.system.work.FightWorkGetSecretKey344", package.seeall)

local var_0_0 = class("FightWorkGetSecretKey344", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightDataHelper.entityMgr:getById(arg_1_0.actEffectData.targetId)

	if not var_1_0 then
		return arg_1_0:onDone(true)
	end

	FightFloatMgr.instance:float(arg_1_0.actEffectData.targetId, FightEnum.FloatType.secret_key, luaLang("fight_get_secret_key"))

	local var_1_1 = var_1_0.skin
	local var_1_2 = lua_fight_sp_effect_wuerlixi_float.configDict[var_1_1]

	if not var_1_2 then
		return arg_1_0:onDone(true)
	end

	local var_1_3 = FightHelper.getEntity(arg_1_0.actEffectData.targetId)

	if not var_1_3 then
		return arg_1_0:onDone(true)
	end

	local var_1_4 = var_1_2.duration
	local var_1_5 = var_1_2.audioId

	var_1_3.uniqueEffect:addHangEffect(var_1_2.effect, var_1_2.hangPoint, nil, var_1_2.duration):setLocalPos(0, 0, 0)

	if var_1_5 ~= 0 then
		AudioMgr.instance:trigger(var_1_5)
	end

	arg_1_0:com_registTimer(arg_1_0._delayDone, var_1_4)
end

return var_0_0
