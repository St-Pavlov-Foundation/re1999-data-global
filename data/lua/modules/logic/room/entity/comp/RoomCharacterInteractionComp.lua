module("modules.logic.room.entity.comp.RoomCharacterInteractionComp", package.seeall)

local var_0_0 = class("RoomCharacterInteractionComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._faithFill = 0
	arg_1_0.entity = arg_1_1
	arg_1_0._effectKeyResDict = {
		[RoomEnum.EffectKey.CharacterFaithMaxKey] = RoomScenePreloader.ResCharacterFaithMax,
		[RoomEnum.EffectKey.CharacterFaithFullKey] = RoomScenePreloader.ResCharacterFaithFull,
		[RoomEnum.EffectKey.CharacterFaithNormalKey] = RoomScenePreloader.ResCharacterFaithNormal,
		[RoomEnum.EffectKey.CharacterChatKey] = RoomScenePreloader.ResCharacterChat
	}
	arg_1_0._showCameraStateDict = {
		[RoomEnum.CameraState.Normal] = true,
		[RoomEnum.CameraState.Overlook] = true
	}
	arg_1_0._offsetX = 0
	arg_1_0._offsetY = 0
	arg_1_0._offsetZ = 0
	arg_1_0._effectKeyInxDict = {}

	local var_1_0 = 0

	for iter_1_0, iter_1_1 in pairs(arg_1_0._effectKeyResDict) do
		arg_1_0._effectKeyInxDict[iter_1_0] = var_1_0
		var_1_0 = var_1_0 + 1
	end
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._goTrs = arg_2_1.transform
	arg_2_0._scene = GameSceneMgr.instance:getCurScene()

	arg_2_0:_refreshShowIcom()
end

function var_0_0.getMO(arg_3_0)
	return arg_3_0.entity:getMO()
end

function var_0_0.addEventListeners(arg_4_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterMove, arg_4_0._characterPositionChanged, arg_4_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterInteractionUI, arg_4_0.startCheckEventTask, arg_4_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshFaithShow, arg_4_0.startCheckEventTask, arg_4_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterCanConfirm, arg_4_0.startCheckEventTask, arg_4_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshSpineShow, arg_4_0.startCheckEventTask, arg_4_0)
	CharacterController.instance:registerCallback(CharacterEvent.HeroUpdatePush, arg_4_0.startCheckEventTask, arg_4_0)
	RoomMapController.instance:registerCallback(RoomEvent.CameraStateUpdate, arg_4_0.startCheckEventTask, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterMove, arg_5_0._characterPositionChanged, arg_5_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterInteractionUI, arg_5_0.startCheckEventTask, arg_5_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshFaithShow, arg_5_0.startCheckEventTask, arg_5_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterCanConfirm, arg_5_0.startCheckEventTask, arg_5_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshSpineShow, arg_5_0.startCheckEventTask, arg_5_0)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroUpdatePush, arg_5_0.startCheckEventTask, arg_5_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraStateUpdate, arg_5_0.startCheckEventTask, arg_5_0)

	arg_5_0._isHasCheckEventTask = false

	TaskDispatcher.cancelTask(arg_5_0._onRunCheckEventTask, arg_5_0)
end

function var_0_0._characterPositionChanged(arg_6_0)
	local var_6_0 = arg_6_0._scene.camera:getCameraState()

	if arg_6_0._lastCameraState ~= var_6_0 then
		arg_6_0._lastCameraState = var_6_0

		arg_6_0:startCheckEventTask()
	end

	arg_6_0:_updateParticlePosOffset()
end

function var_0_0.startCheckEventTask(arg_7_0)
	if not arg_7_0._isHasCheckEventTask then
		arg_7_0._isHasCheckEventTask = true

		TaskDispatcher.runDelay(arg_7_0._onRunCheckEventTask, arg_7_0, 0.1)
	end
end

function var_0_0._onRunCheckEventTask(arg_8_0)
	arg_8_0._isHasCheckEventTask = false

	arg_8_0:_refreshShowIcom()
end

function var_0_0._refreshShowIcom(arg_9_0)
	local var_9_0 = arg_9_0:_getShowEffectKey()

	arg_9_0:_showByKey(var_9_0)
	arg_9_0:_upateFaithFill()
end

function var_0_0._getShowEffectKey(arg_10_0)
	if not RoomController.instance:isObMode() then
		return nil
	end

	local var_10_0 = arg_10_0._scene.camera:getCameraState()

	if not arg_10_0._showCameraStateDict[var_10_0] or RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		return nil
	end

	local var_10_1 = arg_10_0:getMO()

	if not var_10_1 or var_10_1:isTrainSourceState() then
		return
	end

	local var_10_2 = RoomCharacterModel.instance:getTempCharacterMO()

	if var_10_2 and var_10_2.id == var_10_1.id then
		if RoomCharacterController.instance:isCharacterFaithFull(var_10_1.heroId) then
			return RoomEnum.EffectKey.CharacterFaithMaxKey
		end

		return
	end

	if var_10_1:getCurrentInteractionId() then
		if not RoomCharacterController.instance:getPlayingInteractionParam() then
			return RoomEnum.EffectKey.CharacterChatKey
		end
	else
		if RoomCharacterController.instance:isCharacterFaithFull(var_10_1.heroId) then
			if RoomCharacterModel.instance:isShowFaithFull(var_10_1.heroId) then
				return RoomEnum.EffectKey.CharacterFaithMaxKey
			end

			return nil
		end

		local var_10_3 = RoomCharacterHelper.getCharacterFaithFill(var_10_1)

		if var_10_3 >= 1 then
			return RoomEnum.EffectKey.CharacterFaithFullKey
		elseif var_10_3 > 0 then
			arg_10_0._faithFill = var_10_3

			return RoomEnum.EffectKey.CharacterFaithNormalKey
		end
	end
end

function var_0_0._showByKey(arg_11_0, arg_11_1)
	arg_11_0._curShowKey = arg_11_1

	local var_11_0 = arg_11_0.entity.effect

	for iter_11_0, iter_11_1 in pairs(arg_11_0._effectKeyResDict) do
		var_11_0:setActiveByKey(iter_11_0, arg_11_1 == iter_11_0)
	end

	if arg_11_0._effectKeyResDict[arg_11_1] and not var_11_0:isHasEffectGOByKey(arg_11_1) then
		var_11_0:addParams({
			[arg_11_1] = {
				res = arg_11_0._effectKeyResDict[arg_11_1]
			}
		})
		var_11_0:refreshEffect()
	end
end

function var_0_0._upateFaithFill(arg_12_0)
	if arg_12_0._isLastFaithFill == arg_12_0._faithFill then
		return
	end

	local var_12_0 = arg_12_0.entity.effect

	if var_12_0:isHasEffectGOByKey(RoomEnum.EffectKey.CharacterFaithNormalKey) then
		arg_12_0._isLastFaithFill = arg_12_0._faithFill

		local var_12_1 = var_12_0:getComponentsByPath(RoomEnum.EffectKey.CharacterFaithNormalKey, RoomEnum.ComponentName.Renderer, "mesh/faith_process")
		local var_12_2 = arg_12_0._scene.mapmgr:getPropertyBlock()

		var_12_2:Clear()

		local var_12_3 = Mathf.Lerp(-0.53, -0.7, arg_12_0._faithFill)

		var_12_2:SetVector("_UVOffset", Vector4.New(0, var_12_3, 0, 0))
		var_12_2:SetVector("_ParticlePosOffset", Vector4.New(0, arg_12_0._offsetY, 0, 0))

		for iter_12_0, iter_12_1 in ipairs(var_12_1) do
			iter_12_1:SetPropertyBlock(var_12_2)
		end

		transformhelper.setLocalPos(var_12_0:getEffectGOTrs(RoomEnum.EffectKey.CharacterFaithNormalKey), arg_12_0._offsetX, 0, arg_12_0._offsetZ)
	end
end

function var_0_0._updateParticlePosOffset(arg_13_0)
	local var_13_0 = arg_13_0.entity.effect

	if not arg_13_0._effectKeyResDict[arg_13_0._curShowKey] or not var_13_0:isHasEffectGOByKey(arg_13_0._curShowKey) then
		return
	end

	local var_13_1 = arg_13_0.entity.characterspine:getMountheadGOTrs()

	if not var_13_1 then
		return
	end

	local var_13_2, var_13_3, var_13_4 = transformhelper.getPos(var_13_1)
	local var_13_5, var_13_6, var_13_7 = transformhelper.getPos(arg_13_0.entity.containerGOTrs)
	local var_13_8 = var_13_2 - var_13_5
	local var_13_9 = var_13_3 - var_13_6 + 0.08
	local var_13_10 = var_13_4 - var_13_7
	local var_13_11 = 0.001

	if var_13_11 < math.abs(var_13_8 - arg_13_0._offsetX) or var_13_11 < math.abs(var_13_9 - arg_13_0._offsetY) or var_13_11 < math.abs(var_13_10 - arg_13_0._offsetZ) or arg_13_0._lastInx ~= arg_13_0._effectKeyInxDict[arg_13_0._curShowKey] then
		arg_13_0._offsetX = var_13_8
		arg_13_0._offsetY = var_13_9
		arg_13_0._offsetZ = var_13_10
		arg_13_0._lastInx = arg_13_0._effectKeyInxDict[arg_13_0._curShowKey]

		transformhelper.setLocalPos(var_13_0:getEffectGOTrs(arg_13_0._curShowKey), arg_13_0._offsetX, 0, arg_13_0._offsetZ)

		local var_13_12 = var_13_0:getComponentsByPath(arg_13_0._curShowKey, RoomEnum.ComponentName.Renderer, "mesh")
		local var_13_13 = arg_13_0._scene.mapmgr:getPropertyBlock()

		var_13_13:Clear()
		var_13_13:SetVector("_ParticlePosOffset", Vector4.New(0, arg_13_0._offsetY, 0, 0))

		for iter_13_0, iter_13_1 in ipairs(var_13_12) do
			iter_13_1:SetPropertyBlock(var_13_13)
		end

		if arg_13_0._curShowKey == RoomEnum.EffectKey.CharacterFaithNormalKey then
			arg_13_0._isLastFaithFill = -1

			arg_13_0:_upateFaithFill()
		end
	end
end

return var_0_0
