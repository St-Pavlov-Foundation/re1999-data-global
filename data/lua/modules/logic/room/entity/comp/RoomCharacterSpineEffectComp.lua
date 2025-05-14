module("modules.logic.room.entity.comp.RoomCharacterSpineEffectComp", package.seeall)

local var_0_0 = class("RoomCharacterSpineEffectComp", RoomBaseSpineEffectComp)

function var_0_0.onInit(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.entity:getMO()

	arg_1_0._skinId = var_1_0.skinId
	arg_1_0._heroId = var_1_0.heroId
end

function var_0_0._logNotPoint(arg_2_0, arg_2_1)
	logNormal(string.format("[export_角色交互特效] 角色挂点找不到, heroId:%s skinId:%s  id:%s  animName:%s point:%s", arg_2_0._heroId, arg_2_0._skinId, arg_2_1.id, arg_2_1.animName, arg_2_1.point))
end

function var_0_0._logResError(arg_3_0, arg_3_1)
	logError(string.format("RoomCharacterSpineEffectComp 加载失败, heroId:%s skinId:%s  id:%s  animName:%s  effectRes:%s", arg_3_0._heroId, arg_3_0._skinId, arg_3_1.id, arg_3_1.animName, arg_3_1.effectRes))
end

function var_0_0.getEffectCfgList(arg_4_0)
	local var_4_0 = arg_4_0.entity:getMO()
	local var_4_1 = {}
	local var_4_2 = RoomConfig.instance:getCharacterEffectList(var_4_0 and var_4_0.skinId)

	if var_4_2 then
		for iter_4_0, iter_4_1 in ipairs(var_4_2) do
			if not RoomCharacterEnum.maskInteractAnim[iter_4_1.animName] then
				table.insert(var_4_1, iter_4_1)
			end
		end
	end

	return var_4_1
end

function var_0_0.getSpineComp(arg_5_0)
	return arg_5_0.entity.characterspine
end

function var_0_0.onPlayShowEffect(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0:_specialIdleEffect(arg_6_1, arg_6_2, arg_6_3)
end

function var_0_0._specialIdleEffect(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if RoomCharacterEnum.CharacterAnimStateName.SpecialIdle == arg_7_1 and arg_7_0._prefabNameDict then
		local var_7_0 = arg_7_0._prefabNameDict[arg_7_3]
		local var_7_1 = arg_7_0.entity.characterspine:getLookDir()
		local var_7_2 = gohelper.findChild(arg_7_2, var_7_0 .. "_r")
		local var_7_3 = gohelper.findChild(arg_7_2, var_7_0 .. "_l")

		gohelper.setActive(var_7_2, var_7_1 == SpineLookDir.Left)
		gohelper.setActive(var_7_3, var_7_1 == SpineLookDir.Right)
	end
end

return var_0_0
