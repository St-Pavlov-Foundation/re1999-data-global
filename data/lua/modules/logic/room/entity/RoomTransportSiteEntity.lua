module("modules.logic.room.entity.RoomTransportSiteEntity", package.seeall)

local var_0_0 = class("RoomTransportSiteEntity", RoomBaseEntity)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)
	arg_1_0:setEntityId(arg_1_1)
end

function var_0_0.setEntityId(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1
	arg_2_0.entityId = arg_2_0.id
end

function var_0_0.getTag(arg_3_0)
	return SceneTag.RoomBuilding
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0.containerGO = gohelper.create3d(arg_4_1, RoomEnum.EntityChildKey.ContainerGOKey)
	arg_4_0.staticContainerGO = arg_4_0.containerGO
	arg_4_0.containerGOTrs = arg_4_0.containerGO.transform
	arg_4_0.goTrs = arg_4_1.transform

	var_0_0.super.init(arg_4_0, arg_4_1)
end

function var_0_0.playAudio(arg_5_0, arg_5_1)
	if arg_5_1 and arg_5_1 ~= 0 then
		arg_5_0.__isHasAuidoTrigger = true

		AudioMgr.instance:trigger(arg_5_1, arg_5_0.go)
	end
end

function var_0_0.initComponents(arg_6_0)
	arg_6_0:addComp("effect", RoomEffectComp)
	arg_6_0:addComp("alphaThresholdComp", RoomAlphaThresholdComp)
	arg_6_0:addComp("collider", RoomColliderComp)
	arg_6_0:addComp("nightlight", RoomNightLightComp)
end

function var_0_0.onStart(arg_7_0)
	var_0_0.super.onStart(arg_7_0)
end

function var_0_0.refreshBuilding(arg_8_0)
	if not arg_8_0.effect:isHasEffectGOByKey(RoomEnum.EffectKey.BuildingGOKey) then
		arg_8_0.effect:addParams({
			[RoomEnum.EffectKey.BuildingGOKey] = {
				res = "scenes/m_s07_xiaowu/prefab/building/2_2_simulate/simulate_tingchezhan_1.prefab",
				pathfinding = true,
				deleteChildPath = "0"
			}
		})
		arg_8_0.effect:refreshEffect()
	end
end

function var_0_0.setLocalPos(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	ZProj.TweenHelper.KillByObj(arg_9_0.goTrs)

	if arg_9_4 then
		ZProj.TweenHelper.DOLocalMove(arg_9_0.goTrs, arg_9_1, arg_9_2, arg_9_3, 0.1)
	else
		transformhelper.setLocalPos(arg_9_0.goTrs, arg_9_1, arg_9_2, arg_9_3)
	end
end

function var_0_0.getAlphaThresholdValue(arg_10_0)
	return nil
end

function var_0_0.onEffectRebuild(arg_11_0)
	if not arg_11_0._isSmokeAnimPlaying then
		arg_11_0:_playSmokeAnim(false)
	end

	if arg_11_0:getBodyGO() then
		RoomMapController.instance:dispatchEvent(RoomEvent.RoomVieiwConfirmRefreshUI)
	end
end

function var_0_0.getBodyGO(arg_12_0)
	return arg_12_0:_findBuildingGOChild(RoomEnum.EntityChildKey.BodyGOKey)
end

function var_0_0.getHeadGO(arg_13_0)
	return arg_13_0:_findBuildingGOChild(RoomEnum.EntityChildKey.HeadGOKey)
end

function var_0_0.playAnimator(arg_14_0, arg_14_1)
	return arg_14_0.effect:playEffectAnimator(RoomEnum.EffectKey.BuildingGOKey, arg_14_1)
end

function var_0_0.playSmokeEffect(arg_15_0)
	arg_15_0:_returnSmokeEffect()
	arg_15_0:_playSmokeAnim(true)

	arg_15_0._isSmokeAnimPlaying = true

	TaskDispatcher.runDelay(arg_15_0._delayReturnSmokeEffect, arg_15_0, 3)
end

function var_0_0._delayReturnSmokeEffect(arg_16_0)
	arg_16_0._isSmokeAnimPlaying = false

	arg_16_0:_playSmokeAnim(false)
end

function var_0_0._returnSmokeEffect(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._delayReturnSmokeEffect, arg_17_0)
end

function var_0_0._playSmokeAnim(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:_findBuildingGOChild(RoomEnum.EntityChildKey.SmokeGOKey)

	if var_18_0 then
		if arg_18_1 then
			gohelper.setActive(var_18_0, false)
		end

		gohelper.setActive(var_18_0, arg_18_1)
	end
end

function var_0_0._findBuildingGOChild(arg_19_0, arg_19_1)
	return arg_19_0.effect:getGameObjectByPath(RoomEnum.EffectKey.BuildingGOKey, arg_19_1)
end

function var_0_0.beforeDestroy(arg_20_0)
	ZProj.TweenHelper.KillByObj(arg_20_0.goTrs)
	arg_20_0:_returnSmokeEffect()
	arg_20_0:removeEvent()
end

function var_0_0.removeEvent(arg_21_0)
	return
end

function var_0_0.getMO(arg_22_0)
	return nil
end

function var_0_0.getCharacterMeshRendererList(arg_23_0)
	return arg_23_0.effect:getMeshRenderersByKey(RoomEnum.EffectKey.BuildingGOKey)
end

return var_0_0
