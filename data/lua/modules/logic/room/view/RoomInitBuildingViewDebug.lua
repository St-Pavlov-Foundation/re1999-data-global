module("modules.logic.room.view.RoomInitBuildingViewDebug", package.seeall)

slot0 = class("RoomInitBuildingViewDebug", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(slot0.viewGO)

	slot0._touchEventMgr:SetIgnoreUI(true)
	slot0._touchEventMgr:SetOnlyTouch(true)
	slot0._touchEventMgr:SetOnDragBeginCb(slot0._onDragBegin, slot0)
	slot0._touchEventMgr:SetOnDragCb(slot0._onDrag, slot0)
	slot0._touchEventMgr:SetOnDragEndCb(slot0._onDragEnd, slot0)
	slot0._touchEventMgr:SetScrollWheelCb(slot0._onScrollWheel, slot0)
	logNormal("鼠标左键点击滑动旋转角度")
	logNormal("鼠标滑轮调整距离")
	logNormal("Shift+鼠标左键点击滑动调整高度")
	logNormal("Shift+G输出参数")
	TaskDispatcher.runRepeat(slot0._onFrame, slot0, 0.01)
end

function slot0._onFrame(slot0)
	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.G) then
		slot1 = slot0._scene.camera:getRealCameraParam()

		logNormal("部件初始镜头参数:")
		logNormal(table.concat({
			string.format("%.3f", slot1.rotate),
			string.format("%.3f", slot1.angle),
			string.format("%.3f", slot1.distance),
			string.format("%.3f", slot1.height)
		}, "#"))
	end
end

function slot0._onDragBegin(slot0, slot1)
	slot0._curPos = slot1
end

function slot0._onDrag(slot0, slot1)
	if slot0._curPos then
		if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) then
			slot0:_raiseCamera(slot0:_getNormalizedDrag(slot1 - slot0._curPos))
		else
			slot0:_rotateCamera(slot2)
		end
	end

	slot0._curPos = slot1
end

function slot0._onDragEnd(slot0, slot1)
	slot0._curPos = nil
end

function slot0._onScrollWheel(slot0, slot1)
	slot0:_zoomCamera(slot1)
end

function slot0._rotateCamera(slot0, slot1)
	slot2 = LuaUtil.deepCopy(slot0._scene.camera:getRealCameraParam())
	slot2.rotate = slot2.rotate + slot1.x * 0.005
	slot2.angle = slot2.angle - slot1.y * 0.005
	slot2.rotate = RoomRotateHelper.getMod(slot2.rotate, Mathf.PI * 2)
	slot2.angle = RoomRotateHelper.getMod(slot2.angle, Mathf.PI * 2)
	slot2.angle = Mathf.Clamp(slot2.angle, 10 * Mathf.Deg2Rad, 80 * Mathf.Deg2Rad)

	slot0._scene.camera:tweenRealCamera(slot2, nil, , , true)
end

function slot0._raiseCamera(slot0, slot1)
	slot2 = LuaUtil.deepCopy(slot0._scene.camera:getRealCameraParam())
	slot2.height = slot2.height - slot1.y * 0.005
	slot2.height = Mathf.Clamp(slot2.height, -0.2, 1)

	slot0._scene.camera:tweenRealCamera(slot2, nil, , , true)
end

function slot0._zoomCamera(slot0, slot1)
	slot2 = LuaUtil.deepCopy(slot0._scene.camera:getRealCameraParam())
	slot2.distance = slot2.distance - slot1 * 0.2
	slot2.distance = Mathf.Clamp(slot2.distance, 0.5, 3)

	slot0._scene.camera:tweenRealCamera(slot2, nil, , , true)
end

function slot0._refeshUI(slot0)
end

function slot0.onOpen(slot0)
	slot0:_refeshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onFrame, slot0)

	if slot0._touchEventMgr then
		TouchEventMgrHepler.remove(slot0._touchEventMgr)

		slot0._touchEventMgr = nil
	end
end

function slot0._getNormalizedDrag(slot0, slot1)
	return Vector2(slot1.x * 1920 / UnityEngine.Screen.width, slot1.y * 1920 / UnityEngine.Screen.height)
end

return slot0
