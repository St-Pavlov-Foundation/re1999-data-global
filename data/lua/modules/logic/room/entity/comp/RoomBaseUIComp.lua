module("modules.logic.room.entity.comp.RoomBaseUIComp", package.seeall)

local var_0_0 = class("RoomBaseUIComp", LuaCompBase)

var_0_0.fadeMin = 5
var_0_0.fadeMax = 7
var_0_0.alphaChangeMinimum = 0.02

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._uiGO = nil
	arg_2_0._uiGOTrs = nil
	arg_2_0._scene = GameSceneMgr.instance:getCurScene()
end

function var_0_0.addEventListeners(arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.BendingAmountUpdate, arg_3_0.refreshPosition, arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, arg_3_0.refreshPosition, arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.TouchClickUI3D, arg_3_0._onTouchClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.BendingAmountUpdate, arg_4_0.refreshPosition, arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, arg_4_0.refreshPosition, arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.TouchClickUI3D, arg_4_0._onTouchClick, arg_4_0)
end

function var_0_0.beforeDestroy(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayReturnUI, arg_5_0)
	arg_5_0:_delayReturnUI()
	arg_5_0:removeEventListeners()
end

function var_0_0.refreshPosition(arg_6_0)
	if not arg_6_0._uiGOTrs then
		return
	end

	local var_6_0 = arg_6_0:getUIWorldPos()
	local var_6_1, var_6_2, var_6_3 = RoomBendingHelper.worldToBending(var_6_0)

	transformhelper.setPos(arg_6_0._uiGOTrs, var_6_1.x, var_6_1.y, var_6_1.z)

	arg_6_0._uiGOTrs.rotation = var_6_2

	if arg_6_0._gocontainerTrs then
		transformhelper.setLocalRotation(arg_6_0._gocontainerTrs, var_6_3.x, var_6_3.y, var_6_3.z)
	end

	arg_6_0:refreshCanvasGroup()
end

function var_0_0.refreshCanvasGroup(arg_7_0)
	if not arg_7_0._uiGO or not arg_7_0._canvasGroup then
		return
	end

	local var_7_0, var_7_1, var_7_2 = transformhelper.getPos(arg_7_0._uiGOTrs)
	local var_7_3 = arg_7_0._scene.camera:getCameraPosition()
	local var_7_4 = Vector2(var_7_0, var_7_2)
	local var_7_5 = Vector2(var_7_3.x, var_7_3.z)
	local var_7_6 = Vector2.Distance(var_7_4, var_7_5)
	local var_7_7 = 1

	if var_7_6 >= var_0_0.fadeMax then
		var_7_7 = 0
	elseif var_7_6 <= var_0_0.fadeMin then
		var_7_7 = 1
	else
		var_7_7 = 1 - (var_7_6 - var_0_0.fadeMin) / (var_0_0.fadeMax - var_0_0.fadeMin)

		if arg_7_0._lastAlpha and math.abs(arg_7_0._lastAlpha - var_7_7) < var_0_0.alphaChangeMinimum then
			var_7_7 = arg_7_0._lastAlpha
		end
	end

	local var_7_8 = var_7_7 > 0.25

	if arg_7_0._lastAlpha ~= var_7_7 then
		arg_7_0._lastAlpha = var_7_7
		arg_7_0._canvasGroup.alpha = var_7_7

		if arg_7_0._arrowRenderer then
			arg_7_0._arrowRenderer:SetAlpha(var_7_7)
		end
	end

	if arg_7_0._lastBlocksRaycasts ~= var_7_8 then
		arg_7_0._lastBlocksRaycasts = var_7_8
		arg_7_0._canvasGroup.blocksRaycasts = var_7_8
	end
end

function var_0_0._onTouchClick(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0._uiGO and arg_8_1 and arg_8_1.transform:IsChildOf(arg_8_0._uiGOTrs) and not arg_8_0._isReturning then
		arg_8_0:onClick(arg_8_1, arg_8_2)
	end
end

function var_0_0.getUI(arg_9_0)
	if arg_9_0._isReturning then
		arg_9_0._isReturning = false

		TaskDispatcher.cancelTask(arg_9_0._delayReturnUI, arg_9_0)
		arg_9_0._baseAnimator:Play("room_task_in", 0, 1)

		return
	end

	if string.nilorempty(arg_9_0._res) then
		return
	end

	if not arg_9_0._uiGO then
		arg_9_0._uiGO = RoomUIPool.getInstance(arg_9_0._res, arg_9_0._name)
		arg_9_0._uiGOTrs = arg_9_0._uiGO.transform
		arg_9_0._gocontainer = gohelper.findChild(arg_9_0._uiGO, "go_container")
		arg_9_0._gocontainerTrs = arg_9_0._gocontainer.transform
		arg_9_0._canvasGroup = arg_9_0._uiGO:GetComponent(typeof(UnityEngine.CanvasGroup))
		arg_9_0._baseAnimator = arg_9_0._uiGO:GetComponent(typeof(UnityEngine.Animator))

		arg_9_0._baseAnimator:Play("room_task_in", 0, 0)

		local var_9_0 = gohelper.findChild(arg_9_0._uiGO, "tubiao")

		if var_9_0 then
			arg_9_0._arrowRenderer = var_9_0:GetComponent(typeof(UnityEngine.CanvasRenderer))

			if arg_9_0._lastAlpha then
				arg_9_0._arrowRenderer:SetAlpha(arg_9_0._lastAlpha)
			end
		end

		arg_9_0:initUI()
	end

	return arg_9_0._uiGO
end

function var_0_0.returnUI(arg_10_0)
	if arg_10_0._isReturning then
		return
	end

	arg_10_0._isReturning = false

	TaskDispatcher.cancelTask(arg_10_0._delayReturnUI, arg_10_0)

	if string.nilorempty(arg_10_0._res) then
		return
	end

	if arg_10_0._uiGO then
		arg_10_0._isReturning = true

		arg_10_0._baseAnimator:Play("room_task_out", 0, 0)
		TaskDispatcher.runDelay(arg_10_0._delayReturnUI, arg_10_0, 0.3)
	end
end

function var_0_0._delayReturnUI(arg_11_0)
	arg_11_0._isReturning = false

	if arg_11_0._uiGO then
		arg_11_0:destoryUI()
		RoomUIPool.returnInstance(arg_11_0._res, arg_11_0._uiGO)

		arg_11_0._uiGO = nil
		arg_11_0._uiGOTrs = nil
		arg_11_0._gocontainer = nil
		arg_11_0._gocontainerTrs = nil
		arg_11_0._canvasGroup = nil
		arg_11_0._arrowRenderer = nil
		arg_11_0._baseAnimator = nil
	end
end

function var_0_0.initUI(arg_12_0)
	return
end

function var_0_0.getUIWorldPos(arg_13_0)
	return
end

function var_0_0.onClick(arg_14_0)
	return
end

return var_0_0
