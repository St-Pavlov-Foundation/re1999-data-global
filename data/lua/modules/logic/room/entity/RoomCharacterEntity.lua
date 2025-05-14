module("modules.logic.room.entity.RoomCharacterEntity", package.seeall)

local var_0_0 = class("RoomCharacterEntity", RoomBaseEntity)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0.id = arg_1_1
	arg_1_0.entityId = arg_1_0.id
end

function var_0_0.getTag(arg_2_0)
	return SceneTag.RoomCharacter
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.containerGO = gohelper.create3d(arg_3_1, RoomEnum.EntityChildKey.ContainerGOKey)
	arg_3_0.staticContainerGO = arg_3_0.containerGO
	arg_3_0.containerGOTrs = arg_3_0.containerGO.transform
	arg_3_0.goTrs = arg_3_1.transform

	var_0_0.super.init(arg_3_0, arg_3_1)

	arg_3_0._scene = GameSceneMgr.instance:getCurScene()

	if RoomController.instance:isObMode() then
		arg_3_0.effect:addParams({
			[RoomEnum.EffectKey.BuildingGOKey] = {
				res = RoomScenePreloader.ResCharacterClickHelper
			}
		})
		arg_3_0.effect:refreshEffect()
	end

	arg_3_0.isPressing = false
end

function var_0_0.initComponents(arg_4_0)
	arg_4_0:addComp("characterspineeffect", RoomCharacterSpineEffectComp)
	arg_4_0:addComp("characterspine", RoomCharacterSpineComp)
	arg_4_0:addComp("followPathComp", RoomCharacterFollowPathComp)
	arg_4_0:addComp("charactermove", RoomCharacterMoveComp)
	arg_4_0:addComp("effect", RoomEffectComp)
	arg_4_0:addComp("birthday", RoomCharacterBirthdayComp)

	if RoomController.instance:isObMode() then
		arg_4_0:addComp("collider", RoomColliderComp)
	end

	if not RoomEnum.IsShowUICharacterInteraction then
		arg_4_0:addComp("characterinterac", RoomCharacterInteractionComp)
	end

	local var_4_0 = arg_4_0:getMO()

	if var_4_0 and not var_4_0:getCanWade() then
		arg_4_0:addComp("characterfootprint", RoomCharacterFootPrintComp)
	end

	arg_4_0:addComp("cameraFollowTargetComp", RoomCameraFollowTargetComp)
	arg_4_0:addComp("interactActionComp", RoomCharacterInteractActionComp)
end

function var_0_0.onStart(arg_5_0)
	var_0_0.super.onStart(arg_5_0)
end

function var_0_0.setLocalPos(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_0._tweenId then
		arg_6_0._scene.tween:killById(arg_6_0._tweenId)

		arg_6_0._tweenId = nil
	end

	if arg_6_4 then
		local var_6_0, var_6_1, var_6_2 = transformhelper.getLocalPos(arg_6_0.goTrs)

		arg_6_0._tweenId = arg_6_0._scene.tween:tweenFloat(0, 1, 0.05, arg_6_0._frameCallback, arg_6_0._finishCallback, arg_6_0, {
			originalX = var_6_0,
			originalY = var_6_1,
			originalZ = var_6_2,
			x = arg_6_1,
			y = arg_6_2,
			z = arg_6_3
		})
	else
		transformhelper.setLocalPos(arg_6_0.goTrs, arg_6_1, arg_6_2, arg_6_3)
	end

	local var_6_3 = arg_6_0:getMO()

	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterPositionChanged, var_6_3.id)

	if arg_6_0.characterspine then
		arg_6_0.characterspine:characterPosChanged()
	end
end

function var_0_0.getLocalPosXYZ(arg_7_0)
	return transformhelper.getLocalPos(arg_7_0.goTrs)
end

function var_0_0._frameCallback(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_2.originalX + (arg_8_2.x - arg_8_2.originalX) * arg_8_1
	local var_8_1 = arg_8_2.originalY + (arg_8_2.y - arg_8_2.originalY) * arg_8_1
	local var_8_2 = arg_8_2.originalZ + (arg_8_2.z - arg_8_2.originalZ) * arg_8_1

	transformhelper.setLocalPos(arg_8_0.goTrs, var_8_0, var_8_1, var_8_2)
end

function var_0_0._finishCallback(arg_9_0, arg_9_1)
	transformhelper.setLocalPos(arg_9_0.goTrs, arg_9_1.x, arg_9_1.y, arg_9_1.z)
end

function var_0_0._getCharacterRes(arg_10_0)
	local var_10_0 = arg_10_0:getMO()

	return (RoomResHelper.getCharacterPath(var_10_0.skinId))
end

function var_0_0.beforeDestroy(arg_11_0)
	if arg_11_0._tweenId then
		arg_11_0._scene.tween:killById(arg_11_0._tweenId)

		arg_11_0._tweenId = nil
	end

	TaskDispatcher.cancelTask(arg_11_0._pressingEffectDelayDestroy, arg_11_0)
	var_0_0.super.beforeDestroy(arg_11_0)
end

function var_0_0.playConfirmEffect(arg_12_0)
	arg_12_0.effect:addParams({
		[RoomEnum.EffectKey.ConfirmCharacterEffectKey] = {
			res = RoomScenePreloader.ResEffectConfirmCharacter,
			containerGO = arg_12_0.staticContainerGO
		}
	}, 2)
	arg_12_0.effect:refreshEffect()
end

function var_0_0.playClickEffect(arg_13_0)
	arg_13_0.effect:addParams({
		[RoomEnum.EffectKey.ConfirmCharacterEffectKey] = {
			res = RoomScenePreloader.ResCharacterClickEffect,
			containerGO = arg_13_0.staticContainerGO
		}
	}, 1)
	arg_13_0.effect:refreshEffect()
end

function var_0_0.tweenUp(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._pressingEffectDelayDestroy, arg_14_0)

	arg_14_0.isPressing = true

	arg_14_0.characterspine:updateAlpha()
	arg_14_0.effect:addParams({
		[RoomEnum.EffectKey.PressingEffectKey] = {
			res = RoomScenePreloader.ResEffectPressingCharacter,
			containerGO = arg_14_0.staticContainerGO
		}
	})
	arg_14_0.effect:refreshEffect()

	local var_14_0 = arg_14_0.effect:getEffectGO(RoomEnum.EffectKey.PressingEffectKey)

	if var_14_0 then
		local var_14_1 = var_14_0:GetComponent(typeof(UnityEngine.Animator))

		if var_14_1 then
			var_14_1:Play("open", 0, 0)
		end
	end

	if arg_14_0.characterspine then
		arg_14_0.characterspine:playAnim(RoomScenePreloader.ResAnim.PressingCharacter, "up")
	end

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_role_drag)
end

function var_0_0.tweenDown(arg_15_0)
	arg_15_0.isPressing = false

	arg_15_0.characterspine:updateAlpha()

	local var_15_0 = arg_15_0.effect:getEffectGO(RoomEnum.EffectKey.PressingEffectKey)

	if var_15_0 then
		local var_15_1 = var_15_0:GetComponent(typeof(UnityEngine.Animator))

		if var_15_1 then
			var_15_1:Play("close", 0, 0)
		end
	end

	if arg_15_0.characterspine then
		arg_15_0.characterspine:playAnim(RoomScenePreloader.ResAnim.PressingCharacter, "down", 0, arg_15_0._downDone, arg_15_0)
	end

	TaskDispatcher.runDelay(arg_15_0._pressingEffectDelayDestroy, arg_15_0, 2)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_role_put)
end

function var_0_0._downDone(arg_16_0)
	if arg_16_0.characterspine then
		arg_16_0.characterspine:clearAnim()
	end
end

function var_0_0._pressingEffectDelayDestroy(arg_17_0)
	arg_17_0.effect:removeParams({
		RoomEnum.EffectKey.PressingEffectKey
	})
	arg_17_0.effect:refreshEffect()
end

function var_0_0.playFaithEffect(arg_18_0)
	if not arg_18_0.characterspine:getCharacterGO() then
		return
	end

	arg_18_0.effect:addParams({
		[RoomEnum.EffectKey.FaithEffectKey] = {
			res = RoomScenePreloader.ResCharacterFaithEffect,
			containerGO = arg_18_0.staticContainerGO
		}
	}, 1.8)
	arg_18_0.effect:refreshEffect()
end

function var_0_0.getMO(arg_19_0)
	arg_19_0._mo = RoomCharacterModel.instance:getCharacterMOById(arg_19_0.id) or arg_19_0._mo

	return arg_19_0._mo
end

return var_0_0
