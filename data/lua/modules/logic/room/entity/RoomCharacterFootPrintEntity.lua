module("modules.logic.room.entity.RoomCharacterFootPrintEntity", package.seeall)

local var_0_0 = class("RoomCharacterFootPrintEntity", RoomBaseEntity)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0.id = arg_1_1
	arg_1_0.entityId = arg_1_0.id
	arg_1_0._keyParamDict = {}
	arg_1_0._resRightPath = RoomResHelper.getCharacterEffectPath(RoomCharacterEnum.CommonEffect.RightFoot)
	arg_1_0._resRightAb = RoomResHelper.getCharacterEffectABPath(RoomCharacterEnum.CommonEffect.RightFoot)
	arg_1_0._resLeftPath = RoomResHelper.getCharacterEffectPath(RoomCharacterEnum.CommonEffect.LeftFoot)
	arg_1_0._resLeftAb = RoomResHelper.getCharacterEffectABPath(RoomCharacterEnum.CommonEffect.LeftFoot)
end

function var_0_0.getTag(arg_2_0)
	return SceneTag.Untagged
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.containerGO = gohelper.create3d(arg_3_1, RoomEnum.EntityChildKey.ContainerGOKey)
	arg_3_0.staticContainerGO = arg_3_0.containerGO
	arg_3_0.goTrs = arg_3_1.transform

	var_0_0.super.init(arg_3_0, arg_3_1)
	RoomMapController.instance:registerCallback(RoomEvent.AddCharacterFootPrint, arg_3_0._addFootPrintEffect, arg_3_0)
end

function var_0_0.initComponents(arg_4_0)
	arg_4_0:addComp("effect", RoomEffectComp)
end

function var_0_0.onStart(arg_5_0)
	var_0_0.super.onStart(arg_5_0)
end

function var_0_0.setLocalPos(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	transformhelper.setLocalPos(arg_6_0.goTrs, arg_6_1, arg_6_2, arg_6_3)
end

function var_0_0.getMO(arg_7_0)
	return nil
end

function var_0_0.beforeDestroy(arg_8_0)
	var_0_0.super.beforeDestroy(arg_8_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.AddCharacterFootPrint, arg_8_0._addFootPrintEffect, arg_8_0)
end

function var_0_0._addFootPrintEffect(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = 5
	local var_9_1 = arg_9_0:_findEffectKey()

	arg_9_0.effect:addParams({
		[var_9_1] = {
			res = arg_9_3 and arg_9_0._resLeftPath or arg_9_0._resRightPath,
			ab = arg_9_3 and arg_9_0._resLeftAb or arg_9_0._resRightAb,
			localPos = arg_9_2,
			localRotation = arg_9_1
		}
	}, var_9_0)
	arg_9_0.effect:refreshEffect()
end

function var_0_0._findEffectKey(arg_10_0)
	local var_10_0 = 1

	while arg_10_0.effect:isHasEffectGOByKey(arg_10_0:_getKeyByIndex(var_10_0)) do
		var_10_0 = var_10_0 + 1
	end

	return arg_10_0:_getKeyByIndex(var_10_0)
end

function var_0_0._getKeyByIndex(arg_11_0, arg_11_1)
	if not arg_11_0._keyParamDict[arg_11_1] then
		arg_11_0._keyParamDict[arg_11_1] = string.format("footprint_%s", arg_11_1)
	end

	return arg_11_0._keyParamDict[arg_11_1]
end

function var_0_0.onEffectRebuild(arg_12_0)
	return
end

return var_0_0
