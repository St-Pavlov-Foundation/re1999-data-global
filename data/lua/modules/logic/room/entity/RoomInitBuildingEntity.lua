module("modules.logic.room.entity.RoomInitBuildingEntity", package.seeall)

local var_0_0 = class("RoomInitBuildingEntity", RoomBaseEntity)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0.id = arg_1_1
	arg_1_0.entityId = arg_1_0.id
end

function var_0_0.getTag(arg_2_0)
	return SceneTag.RoomInitBuilding
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.containerGO = gohelper.create3d(arg_3_1, RoomEnum.EntityChildKey.ContainerGOKey)
	arg_3_0.staticContainerGO = gohelper.create3d(arg_3_1, RoomEnum.EntityChildKey.StaticContainerGOKey)

	var_0_0.super.init(arg_3_0, arg_3_1)

	arg_3_0._scene = GameSceneMgr.instance:getCurScene()
end

function var_0_0.initComponents(arg_4_0)
	arg_4_0:addComp("effect", RoomEffectComp)

	if RoomController.instance:isObMode() then
		arg_4_0:addComp("collider", RoomColliderComp)
		arg_4_0:addComp("atmosphere", RoomAtmosphereComp)
		arg_4_0:addComp("roomGift", RoomGiftActComp)
	end

	arg_4_0:addComp("nightlight", RoomNightLightComp)
	arg_4_0:addComp("skin", RoomInitBuildingSkinComp)
	arg_4_0:addComp("alphaThresholdComp", RoomAlphaThresholdComp)
end

function var_0_0.onStart(arg_5_0)
	var_0_0.super.onStart(arg_5_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterListShowChanged, arg_5_0._characterListShowChanged, arg_5_0)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, arg_5_0._onSwithMode, arg_5_0)
end

function var_0_0.refreshBuilding(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:_getInitBuildingRes()

	if string.nilorempty(var_6_0) then
		arg_6_0.effect:removeParams({
			RoomEnum.EffectKey.BuildingGOKey
		})
	else
		arg_6_0.effect:addParams({
			[RoomEnum.EffectKey.BuildingGOKey] = {
				pathfinding = true,
				res = var_6_0,
				alphaThreshold = arg_6_1,
				alphaThresholdValue = arg_6_2
			}
		})
	end

	arg_6_0.effect:refreshEffect()
end

function var_0_0._characterListShowChanged(arg_7_0, arg_7_1)
	arg_7_0:setEnable(not RoomController.instance:isEditMode() and not arg_7_1)
end

function var_0_0._onSwithMode(arg_8_0)
	arg_8_0:setEnable(not RoomController.instance:isEditMode())
end

function var_0_0.setEnable(arg_9_0, arg_9_1)
	if arg_9_0.collider then
		arg_9_0.collider:setEnable(arg_9_1 and true or false)
	end
end

function var_0_0._getInitBuildingRes(arg_10_0)
	local var_10_0 = RoomSkinModel.instance:getShowSkin(arg_10_0.id)

	return RoomConfig.instance:getRoomSkinModelPath(var_10_0) or RoomScenePreloader.ResInitBuilding
end

function var_0_0.tweenAlphaThreshold(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	if not arg_11_0.alphaThresholdComp then
		return
	end

	arg_11_0.alphaThresholdComp:tweenAlphaThreshold(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
end

function var_0_0.beforeDestroy(arg_12_0)
	var_0_0.super.beforeDestroy(arg_12_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterListShowChanged, arg_12_0._characterListShowChanged, arg_12_0)
	RoomController.instance:unregisterCallback(arg_12_0._onSwithMode, arg_12_0)
end

function var_0_0.getCharacterMeshRendererList(arg_13_0)
	return arg_13_0.effect:getMeshRenderersByKey(RoomEnum.EffectKey.BuildingGOKey)
end

return var_0_0
