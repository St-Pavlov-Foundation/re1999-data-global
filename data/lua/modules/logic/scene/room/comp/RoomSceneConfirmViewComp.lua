module("modules.logic.scene.room.comp.RoomSceneConfirmViewComp", package.seeall)

local var_0_0 = class("RoomSceneConfirmViewComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_0._confirmView then
		local var_2_0 = RoomUIPool.getInstance(RoomViewConfirm.prefabPath, "roomViewConfirm")
		local var_2_1 = RoomViewConfirm.New()

		arg_2_0._confirmView = var_2_1

		function var_2_1._setUIPos(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
			local var_3_0 = RoomBendingHelper.worldToBendingSimple(arg_3_1)

			arg_3_2 = arg_3_2 or 0

			local var_3_1 = arg_3_3 or 1

			transformhelper.setLocalScale(arg_3_0._gocontainer.transform, var_3_1, var_3_1, var_3_1)
			transformhelper.setPos(arg_3_0._gocontainer.transform, var_3_0.x, var_3_0.y + arg_3_2, var_3_0.z)
		end

		var_2_1:__onInit()

		var_2_1.viewGO = var_2_0
		var_2_1.viewName = "RoomViewConfirm"

		var_2_1:onInitViewInternal()
		var_2_1:addEventsInternal()
		var_2_1:onOpenInternal()
		var_2_1:onOpenFinishInternal()

		local var_2_2 = 0.017499999999999998

		transformhelper.setLocalScale(var_2_0.transform, var_2_2, var_2_2, var_2_2)
		transformhelper.setLocalRotation(var_2_1._gocontainer.transform, 90, 0, 0)
		RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, arg_2_0._cameraTransformUpdate, arg_2_0)
	end
end

function var_0_0._cameraTransformUpdate(arg_4_0)
	if arg_4_0._confirmView then
		local var_4_0 = CameraMgr.instance:getMainCameraTrs()

		if var_4_0 then
			local var_4_1, var_4_2, var_4_3 = transformhelper.getLocalRotation(var_4_0)

			transformhelper.setLocalRotation(arg_4_0._confirmView._gocontainer.transform, 90, var_4_2, 0)
		end
	end
end

function var_0_0.getViewGO(arg_5_0)
	return arg_5_0._confirmView and arg_5_0._confirmView.viewGO
end

function var_0_0.onSceneClose(arg_6_0)
	if arg_6_0._confirmView then
		local var_6_0 = arg_6_0._confirmView

		arg_6_0._confirmView = nil

		var_6_0:onCloseInternal()
		var_6_0:onCloseFinishInternal()
		var_6_0:removeEventsInternal()
		var_6_0:onDestroyViewInternal()
		var_6_0:__onDispose()

		if var_6_0.viewGO then
			gohelper.destroy(var_6_0.viewGO)

			var_6_0.viewGO = nil
		end

		RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, arg_6_0._cameraTransformUpdate, arg_6_0)
	end

	arg_6_0._touchComp = nil
end

return var_0_0
