module("modules.logic.room.entity.comp.RoomCritterEventItemComp", package.seeall)

local var_0_0 = class("RoomCritterEventItemComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._faithFill = 0
	arg_1_0.entity = arg_1_1
	arg_1_0._eventType2ResDict = {
		[CritterEnum.CritterItemEventType.HasTrainEvent] = RoomScenePreloader.ResCritterEvent.HasTrainEvent,
		[CritterEnum.CritterItemEventType.TrainEventComplete] = RoomScenePreloader.ResCritterEvent.TrainEventComplete,
		[CritterEnum.CritterItemEventType.NoMoodWork] = RoomScenePreloader.ResCritterEvent.NoMoodWork,
		[CritterEnum.CritterItemEventType.SurpriseCollect] = RoomScenePreloader.ResCritterEvent.SurpriseCollect
	}
	arg_1_0._showCameraStateDict = {
		[RoomEnum.CameraState.Normal] = true,
		[RoomEnum.CameraState.Overlook] = true
	}
	arg_1_0._offsetX = 0
	arg_1_0._offsetY = 0
	arg_1_0._offsetZ = 0
	arg_1_0._eventType2SkowKeyDict = {}

	local var_1_0 = 0

	for iter_1_0, iter_1_1 in pairs(arg_1_0._eventType2ResDict) do
		arg_1_0._eventType2SkowKeyDict[iter_1_0] = "critter_event_" .. iter_1_0
	end
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._goTrs = arg_2_1.transform
	arg_2_0._scene = GameSceneMgr.instance:getCurScene()

	arg_2_0:startCheckTrainEventTask()
end

function var_0_0.getMO(arg_3_0)
	return arg_3_0.entity:getMO()
end

function var_0_0.addEventListeners(arg_4_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterMove, arg_4_0._characterPositionChanged, arg_4_0)
	CritterController.instance:registerCallback(CritterEvent.CritterInfoPushReply, arg_4_0.startCheckTrainEventTask, arg_4_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshSpineShow, arg_4_0.startCheckTrainEventTask, arg_4_0)
	RoomMapController.instance:registerCallback(RoomEvent.CameraStateUpdate, arg_4_0.startCheckTrainEventTask, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterMove, arg_5_0._characterPositionChanged, arg_5_0)
	CritterController.instance:unregisterCallback(CritterEvent.CritterInfoPushReply, arg_5_0.startCheckTrainEventTask, arg_5_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshSpineShow, arg_5_0.startCheckTrainEventTask, arg_5_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraStateUpdate, arg_5_0.startCheckTrainEventTask, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._onRunCheckTrainEventTask, arg_5_0)

	arg_5_0._isHasCheckTrainEventTask = false
end

function var_0_0._characterPositionChanged(arg_6_0)
	local var_6_0 = arg_6_0._scene.camera:getCameraState()

	if arg_6_0._lastCameraState ~= var_6_0 then
		arg_6_0._lastCameraState = var_6_0

		arg_6_0:startCheckTrainEventTask()
	end

	arg_6_0:_updateParticlePosOffset()
end

function var_0_0._refreshShowIcom(arg_7_0)
	local var_7_0 = arg_7_0:_getShowEventType()

	arg_7_0:_showByEventType(var_7_0)
end

function var_0_0.startCheckTrainEventTask(arg_8_0)
	if not arg_8_0._isHasCheckTrainEventTask then
		arg_8_0._isHasCheckTrainEventTask = true

		TaskDispatcher.runDelay(arg_8_0._onRunCheckTrainEventTask, arg_8_0, 0.1)
	end
end

function var_0_0._onRunCheckTrainEventTask(arg_9_0)
	arg_9_0._isHasCheckTrainEventTask = false

	arg_9_0:_refreshShowIcom()
end

function var_0_0._getShowEventType(arg_10_0)
	if not RoomController.instance:isObMode() then
		return nil
	end

	local var_10_0 = arg_10_0._scene.camera:getCameraState()

	if not arg_10_0._showCameraStateDict[var_10_0] or RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		return nil
	end

	local var_10_1 = CritterModel.instance:getCritterMOByUid(arg_10_0.entity.id)

	return CritterHelper.getEventTypeByCritterMO(var_10_1)
end

function var_0_0._showByEventType(arg_11_0, arg_11_1)
	arg_11_0._curShowEventType = arg_11_1

	local var_11_0 = arg_11_0.entity.effect

	for iter_11_0, iter_11_1 in pairs(arg_11_0._eventType2SkowKeyDict) do
		var_11_0:setActiveByKey(iter_11_1, iter_11_0 == arg_11_1)
	end

	local var_11_1 = arg_11_0._eventType2SkowKeyDict[arg_11_1]

	if arg_11_0._eventType2ResDict[arg_11_1] and not var_11_0:isHasEffectGOByKey(var_11_1) then
		var_11_0:addParams({
			[var_11_1] = {
				res = arg_11_0._eventType2ResDict[arg_11_1]
			}
		})
		var_11_0:refreshEffect()
	end
end

function var_0_0._updateParticlePosOffset(arg_12_0)
	local var_12_0 = arg_12_0.entity.effect
	local var_12_1 = arg_12_0._eventType2SkowKeyDict[arg_12_0._curShowEventType]

	if not var_12_1 or not var_12_0:isHasEffectGOByKey(var_12_1) then
		return
	end

	local var_12_2 = arg_12_0.entity.critterspine:getMountheadGOTrs()

	if not var_12_2 then
		return
	end

	local var_12_3, var_12_4, var_12_5 = transformhelper.getPos(var_12_2)
	local var_12_6, var_12_7, var_12_8 = transformhelper.getPos(arg_12_0.entity.containerGOTrs)
	local var_12_9 = var_12_3 - var_12_6
	local var_12_10 = var_12_4 - var_12_7 + 0.08
	local var_12_11 = var_12_5 - var_12_8
	local var_12_12 = 0.001

	if var_12_12 < math.abs(var_12_9 - arg_12_0._offsetX) or var_12_12 < math.abs(var_12_10 - arg_12_0._offsetY) or var_12_12 < math.abs(var_12_11 - arg_12_0._offsetZ) or arg_12_0._lastInx ~= arg_12_0._curShowEventType then
		arg_12_0._offsetX = var_12_9
		arg_12_0._offsetY = var_12_10
		arg_12_0._offsetZ = var_12_11
		arg_12_0._lastInx = arg_12_0._curShowEventType

		transformhelper.setLocalPos(var_12_0:getEffectGOTrs(var_12_1), arg_12_0._offsetX, 0, arg_12_0._offsetZ)

		local var_12_13 = var_12_0:getComponentsByKey(var_12_1, RoomEnum.ComponentName.Renderer)
		local var_12_14 = arg_12_0._scene.mapmgr:getPropertyBlock()

		var_12_14:Clear()
		var_12_14:SetVector("_ParticlePosOffset", Vector4.New(0, arg_12_0._offsetY, 0, 0))

		for iter_12_0, iter_12_1 in ipairs(var_12_13) do
			iter_12_1:SetPropertyBlock(var_12_14)
		end
	end
end

return var_0_0
