module("modules.logic.room.view.RoomInitBuildingViewDebug", package.seeall)

local var_0_0 = class("RoomInitBuildingViewDebug", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._scene = GameSceneMgr.instance:getCurScene()
	arg_4_0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(arg_4_0.viewGO)

	arg_4_0._touchEventMgr:SetIgnoreUI(true)
	arg_4_0._touchEventMgr:SetOnlyTouch(true)
	arg_4_0._touchEventMgr:SetOnDragBeginCb(arg_4_0._onDragBegin, arg_4_0)
	arg_4_0._touchEventMgr:SetOnDragCb(arg_4_0._onDrag, arg_4_0)
	arg_4_0._touchEventMgr:SetOnDragEndCb(arg_4_0._onDragEnd, arg_4_0)
	arg_4_0._touchEventMgr:SetScrollWheelCb(arg_4_0._onScrollWheel, arg_4_0)
	logNormal("鼠标左键点击滑动旋转角度")
	logNormal("鼠标滑轮调整距离")
	logNormal("Shift+鼠标左键点击滑动调整高度")
	logNormal("Shift+G输出参数")
	TaskDispatcher.runRepeat(arg_4_0._onFrame, arg_4_0, 0.01)
end

function var_0_0._onFrame(arg_5_0)
	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.G) then
		local var_5_0 = arg_5_0._scene.camera:getRealCameraParam()

		logNormal("部件初始镜头参数:")

		local var_5_1 = {
			string.format("%.3f", var_5_0.rotate),
			string.format("%.3f", var_5_0.angle),
			string.format("%.3f", var_5_0.distance),
			string.format("%.3f", var_5_0.height)
		}
		local var_5_2 = table.concat(var_5_1, "#")

		logNormal(var_5_2)
	end
end

function var_0_0._onDragBegin(arg_6_0, arg_6_1)
	arg_6_0._curPos = arg_6_1
end

function var_0_0._onDrag(arg_7_0, arg_7_1)
	if arg_7_0._curPos then
		local var_7_0 = arg_7_0:_getNormalizedDrag(arg_7_1 - arg_7_0._curPos)

		if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) then
			arg_7_0:_raiseCamera(var_7_0)
		else
			arg_7_0:_rotateCamera(var_7_0)
		end
	end

	arg_7_0._curPos = arg_7_1
end

function var_0_0._onDragEnd(arg_8_0, arg_8_1)
	arg_8_0._curPos = nil
end

function var_0_0._onScrollWheel(arg_9_0, arg_9_1)
	arg_9_0:_zoomCamera(arg_9_1)
end

function var_0_0._rotateCamera(arg_10_0, arg_10_1)
	local var_10_0 = LuaUtil.deepCopy(arg_10_0._scene.camera:getRealCameraParam())

	var_10_0.rotate = var_10_0.rotate + arg_10_1.x * 0.005
	var_10_0.angle = var_10_0.angle - arg_10_1.y * 0.005
	var_10_0.rotate = RoomRotateHelper.getMod(var_10_0.rotate, Mathf.PI * 2)
	var_10_0.angle = RoomRotateHelper.getMod(var_10_0.angle, Mathf.PI * 2)
	var_10_0.angle = Mathf.Clamp(var_10_0.angle, 10 * Mathf.Deg2Rad, 80 * Mathf.Deg2Rad)

	arg_10_0._scene.camera:tweenRealCamera(var_10_0, nil, nil, nil, true)
end

function var_0_0._raiseCamera(arg_11_0, arg_11_1)
	local var_11_0 = LuaUtil.deepCopy(arg_11_0._scene.camera:getRealCameraParam())

	var_11_0.height = var_11_0.height - arg_11_1.y * 0.005
	var_11_0.height = Mathf.Clamp(var_11_0.height, -0.2, 1)

	arg_11_0._scene.camera:tweenRealCamera(var_11_0, nil, nil, nil, true)
end

function var_0_0._zoomCamera(arg_12_0, arg_12_1)
	local var_12_0 = LuaUtil.deepCopy(arg_12_0._scene.camera:getRealCameraParam())

	var_12_0.distance = var_12_0.distance - arg_12_1 * 0.2
	var_12_0.distance = Mathf.Clamp(var_12_0.distance, 0.5, 3)

	arg_12_0._scene.camera:tweenRealCamera(var_12_0, nil, nil, nil, true)
end

function var_0_0._refeshUI(arg_13_0)
	return
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:_refeshUI()
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._onFrame, arg_16_0)

	if arg_16_0._touchEventMgr then
		TouchEventMgrHepler.remove(arg_16_0._touchEventMgr)

		arg_16_0._touchEventMgr = nil
	end
end

function var_0_0._getNormalizedDrag(arg_17_0, arg_17_1)
	local var_17_0 = 1920 / UnityEngine.Screen.width
	local var_17_1 = 1920 / UnityEngine.Screen.height

	return Vector2(arg_17_1.x * var_17_0, arg_17_1.y * var_17_1)
end

return var_0_0
