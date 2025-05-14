module("modules.logic.room.entity.RoomCritterEntity", package.seeall)

local var_0_0 = class("RoomCritterEntity", RoomBaseEntity)

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
	arg_3_0.__willDestroy = false
end

function var_0_0.initComponents(arg_4_0)
	arg_4_0:addComp("effect", RoomEffectComp)
	arg_4_0:addComp("critterspineeffect", RoomCritterSpineEffectComp)
	arg_4_0:addComp("critterspine", RoomCritterSpineComp)
	arg_4_0:addComp("critterfollower", RoomCritterFollowerComp)

	if RoomController.instance:isObMode() then
		arg_4_0:addComp("collider", RoomColliderComp)
	end

	arg_4_0:addComp("eventiconComp", RoomCritterEventItemComp)
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
		local var_6_0 = arg_6_0.go.transform.localPosition

		arg_6_0._tweenId = arg_6_0._scene.tween:tweenFloat(0, 1, 0.05, arg_6_0._frameCallback, arg_6_0._finishCallback, arg_6_0, {
			originalX = var_6_0.x,
			originalY = var_6_0.y,
			originalZ = var_6_0.z,
			x = arg_6_1,
			y = arg_6_2,
			z = arg_6_3
		})
	else
		transformhelper.setLocalPos(arg_6_0.go.transform, arg_6_1, arg_6_2, arg_6_3)
	end

	if arg_6_0.critterspine then
		arg_6_0.critterspine:characterPosChanged()
	end
end

function var_0_0._frameCallback(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2.originalX + (arg_7_2.x - arg_7_2.originalX) * arg_7_1
	local var_7_1 = arg_7_2.originalY + (arg_7_2.y - arg_7_2.originalY) * arg_7_1
	local var_7_2 = arg_7_2.originalZ + (arg_7_2.z - arg_7_2.originalZ) * arg_7_1

	transformhelper.setLocalPos(arg_7_0.go.transform, var_7_0, var_7_1, var_7_2)
end

function var_0_0._finishCallback(arg_8_0, arg_8_1)
	transformhelper.setLocalPos(arg_8_0.go.transform, arg_8_1.x, arg_8_1.y, arg_8_1.z)
end

function var_0_0.beforeDestroy(arg_9_0)
	arg_9_0.__willDestroy = true

	if arg_9_0._tweenId then
		arg_9_0._scene.tween:killById(arg_9_0._tweenId)

		arg_9_0._tweenId = nil
	end

	TaskDispatcher.cancelTask(arg_9_0._pressingEffectDelayDestroy, arg_9_0)
	var_0_0.super.beforeDestroy(arg_9_0)
end

function var_0_0.playConfirmEffect(arg_10_0)
	arg_10_0.effect:addParams({
		[RoomEnum.EffectKey.ConfirmCharacterEffectKey] = {
			res = RoomScenePreloader.ResEffectConfirmCharacter,
			containerGO = arg_10_0.staticContainerGO
		}
	}, 2)
	arg_10_0.effect:refreshEffect()
end

function var_0_0.playClickEffect(arg_11_0)
	arg_11_0.effect:addParams({
		[RoomEnum.EffectKey.ConfirmCharacterEffectKey] = {
			res = RoomScenePreloader.ResCharacterClickEffect,
			containerGO = arg_11_0.staticContainerGO
		}
	}, 1)
	arg_11_0.effect:refreshEffect()
end

function var_0_0.playCommonInteractionEff(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.__willDestroy then
		return
	end

	local var_12_0 = CritterConfig.instance:getCritterCommonInteractionEffCfg(arg_12_1)

	if not var_12_0 then
		return
	end

	local var_12_1 = var_12_0.effectKey
	local var_12_2 = RoomResHelper.getCharacterEffectABPath(var_12_0.effectRes)
	local var_12_3 = arg_12_0.critterspine and arg_12_0.critterspine:getSpineGO()

	if gohelper.isNil(var_12_3) then
		return
	end

	local var_12_4 = RoomCharacterHelper.getSpinePointPath(var_12_0.point)
	local var_12_5 = gohelper.findChild(var_12_3, var_12_4)

	if gohelper.isNil(var_12_5) then
		var_12_5 = arg_12_0.containerGO

		logError(string.format(" RoomCritterEntity:playCommonInteractionEff error, no point, critterUid:%s, pointPath:%s", arg_12_0.entityId, var_12_4))
	end

	arg_12_0.effect:addParams({
		[var_12_1] = {
			res = var_12_2,
			containerGO = var_12_5
		}
	}, arg_12_2)
	arg_12_0.effect:refreshEffect()
end

function var_0_0.stopCommonInteractionEff(arg_13_0, arg_13_1)
	if arg_13_0.__willDestroy then
		return
	end

	local var_13_0 = CritterConfig.instance:getCritterCommonInteractionEffCfg(arg_13_1)

	if not var_13_0 then
		return
	end

	local var_13_1 = var_13_0.effectKey

	arg_13_0.effect:removeParams({
		var_13_1
	})
	arg_13_0.effect:refreshEffect()
end

function var_0_0.stopAllCommonInteractionEff(arg_14_0)
	if arg_14_0.__willDestroy then
		return
	end

	local var_14_0 = CritterConfig.instance:getAllCritterCommonInteractionEffKeyList()

	arg_14_0.effect:removeParams(var_14_0)
	arg_14_0.effect:refreshEffect()
end

function var_0_0.tweenUp(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._pressingEffectDelayDestroy, arg_15_0)

	arg_15_0.isPressing = true

	arg_15_0.critterspine:updateAlpha()

	local var_15_0
	local var_15_1 = arg_15_0:getMO()

	if var_15_1 and var_15_1:isRestingCritter() then
		var_15_0 = Vector3.one * CritterEnum.CritterPressingEffectScaleInSeatSlot
	end

	arg_15_0.effect:addParams({
		[RoomEnum.EffectKey.PressingEffectKey] = {
			res = RoomScenePreloader.ResEffectPressingCharacter,
			containerGO = arg_15_0.staticContainerGO,
			localScale = var_15_0
		}
	})
	arg_15_0.effect:refreshEffect()

	local var_15_2 = arg_15_0.effect:getEffectGO(RoomEnum.EffectKey.PressingEffectKey)

	if var_15_2 then
		local var_15_3 = var_15_2:GetComponent(typeof(UnityEngine.Animator))

		if var_15_3 then
			var_15_3:Play("open", 0, 0)
		end
	end

	if arg_15_0.critterspine then
		arg_15_0.critterspine:playAnim(RoomScenePreloader.ResAnim.PressingCharacter, "up")
	end

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_role_drag)
end

function var_0_0.tweenDown(arg_16_0)
	arg_16_0.isPressing = false

	arg_16_0.critterspine:updateAlpha()

	local var_16_0 = arg_16_0.effect:getEffectGO(RoomEnum.EffectKey.PressingEffectKey)

	if var_16_0 then
		local var_16_1 = var_16_0:GetComponent(typeof(UnityEngine.Animator))

		if var_16_1 then
			var_16_1:Play("close", 0, 0)
		end
	end

	if arg_16_0.critterspine then
		arg_16_0.critterspine:playAnim(RoomScenePreloader.ResAnim.PressingCharacter, "down", 0, arg_16_0._downDone, arg_16_0)
	end

	TaskDispatcher.runDelay(arg_16_0._pressingEffectDelayDestroy, arg_16_0, 2)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_role_put)
end

function var_0_0._downDone(arg_17_0)
	if arg_17_0.critterspine then
		arg_17_0.critterspine:clearAnim()
	end
end

function var_0_0._pressingEffectDelayDestroy(arg_18_0)
	arg_18_0.effect:removeParams({
		RoomEnum.EffectKey.PressingEffectKey
	})
	arg_18_0.effect:refreshEffect()
end

function var_0_0.getMO(arg_19_0)
	arg_19_0._mo = RoomCritterModel.instance:getCritterMOById(arg_19_0.id) or arg_19_0._mo

	return arg_19_0._mo
end

return var_0_0
