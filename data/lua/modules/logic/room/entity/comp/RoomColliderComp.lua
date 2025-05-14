module("modules.logic.room.entity.comp.RoomColliderComp", package.seeall)

local var_0_0 = class("RoomColliderComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._colliderEffectKey = RoomEnum.EffectKey.BuildingGOKey
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._colliderGO = nil
	arg_2_0._scene = GameSceneMgr.instance:getCurScene()
	arg_2_0._colliderParamList = nil
	arg_2_0._isEnabled = true

	arg_2_0:refreshPosition()
end

function var_0_0.addEventListeners(arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.CameraUpdateFinish, arg_3_0._cameraUpdateFinish, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraUpdateFinish, arg_4_0._cameraUpdateFinish, arg_4_0)
end

function var_0_0._cameraUpdateFinish(arg_5_0)
	arg_5_0:refreshPosition()
end

function var_0_0.setEnable(arg_6_0, arg_6_1)
	arg_6_0._isEnabled = arg_6_1

	arg_6_0:_updateEnable()
	arg_6_0:refreshPosition()
end

function var_0_0._updateEnable(arg_7_0)
	if not arg_7_0._colliderParamList then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._colliderParamList) do
		iter_7_1.collider.enabled = arg_7_0._isEnabled
	end
end

function var_0_0.refreshPosition(arg_8_0)
	if not arg_8_0.entity.effect:isHasEffectGOByKey(arg_8_0._colliderEffectKey) then
		return
	end

	if not arg_8_0._colliderParamList then
		arg_8_0._colliderParamList = arg_8_0:getUserDataTb_()

		local var_8_0 = arg_8_0.entity.effect:getComponentsByKey(arg_8_0._colliderEffectKey, RoomEnum.ComponentName.BoxCollider)

		if var_8_0 then
			for iter_8_0 = 1, #var_8_0 do
				local var_8_1 = var_8_0[iter_8_0]

				if var_8_1.gameObject.layer == UnityLayer.SceneOpaque then
					table.insert(arg_8_0._colliderParamList, {
						collider = var_8_1,
						trans = var_8_1.transform,
						center = var_8_1.center
					})
				end
			end
		end

		arg_8_0:_updateEnable()
	end

	for iter_8_1, iter_8_2 in ipairs(arg_8_0._colliderParamList) do
		local var_8_2 = iter_8_2.trans
		local var_8_3 = var_8_2.position
		local var_8_4 = RoomBendingHelper.worldToBendingSimple(var_8_3):Sub(var_8_3)
		local var_8_5 = var_8_2.lossyScale

		var_8_4.x = var_8_5.x ~= 0 and var_8_4.x / var_8_5.x or 0
		var_8_4.y = var_8_5.y ~= 0 and var_8_4.y / var_8_5.y or 0
		var_8_4.z = var_8_5.z ~= 0 and var_8_4.z / var_8_5.z or 0
		iter_8_2.collider.center = var_8_4:Add(iter_8_2.center)
	end
end

function var_0_0.clearColliderGOList(arg_9_0)
	if not arg_9_0._colliderParamList then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._colliderParamList) do
		iter_9_1.collider.center = iter_9_1.center
	end

	arg_9_0._colliderParamList = nil
end

function var_0_0.beforeDestroy(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._onUpdate, arg_10_0)
	arg_10_0:clearColliderGOList()
	arg_10_0:removeEventListeners()
end

return var_0_0
