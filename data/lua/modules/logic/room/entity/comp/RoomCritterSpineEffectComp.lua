module("modules.logic.room.entity.comp.RoomCritterSpineEffectComp", package.seeall)

local var_0_0 = class("RoomCritterSpineEffectComp", RoomBaseSpineEffectComp)

function var_0_0.onInit(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.entity:getMO()

	arg_1_0._critterId = var_1_0.critterId
	arg_1_0._skinId = var_1_0:getSkinId()
end

function var_0_0._logNotPoint(arg_2_0, arg_2_1)
	logNormal(string.format("[export_魔精交互特效] 魔精挂点找不到, critterId:%s skinId:%s  id:%s  animName:%s point:%s", arg_2_0._critterId, arg_2_1.skinId, arg_2_1.id, arg_2_1.animName, arg_2_1.point))
end

function var_0_0._logResError(arg_3_0, arg_3_1)
	logError(string.format("RoomCritterSpineEffectComp 加载失败, critterId:%s skinId:%s  id:%s  animName:%s  effectRes:%s", arg_3_0._critterId, arg_3_1.skinId, arg_3_1.id, arg_3_1.animName, arg_3_1.effectRes))
end

function var_0_0.getEffectCfgList(arg_4_0)
	local var_4_0 = arg_4_0.entity:getMO()

	if var_4_0 then
		return CritterConfig.instance:getCritterEffectList(var_4_0:getSkinId())
	end
end

function var_0_0.play(arg_5_0, arg_5_1)
	var_0_0.super.play(arg_5_0, arg_5_1)

	local var_5_0 = arg_5_0.entity:getMO()
	local var_5_1 = var_5_0 and var_5_0.critterId
	local var_5_2 = CritterConfig.instance:getCritterInteractionAudioList(var_5_1, arg_5_1)

	if var_5_2 then
		for iter_5_0, iter_5_1 in ipairs(var_5_2) do
			AudioMgr.instance:trigger(iter_5_1, arg_5_0.go)
		end
	end
end

function var_0_0.getSpineComp(arg_6_0)
	return arg_6_0.entity.critterspine
end

return var_0_0
