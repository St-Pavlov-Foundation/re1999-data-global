module("modules.logic.survival.view.shelter.SurvivalSceneUIItemBase", package.seeall)

local var_0_0 = class("SurvivalSceneUIItemBase", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.goTrs = arg_1_1.transform
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.go, "go_container")
	arg_1_0._gocontainerTrs = arg_1_0._gocontainer.transform
	arg_1_0._scene = GameSceneMgr.instance:getCurScene()
	arg_1_0._canvasGroup = arg_1_0.go:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._baseAnimator = arg_1_0.go:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._containerCanvasGroup = arg_1_0._gocontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._click = gohelper.findChildClick(arg_1_0.go, "go_click")
	arg_1_0._isShow = true

	if arg_1_0._customOnInit then
		arg_1_0:_customOnInit()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	if not gohelper.isNil(arg_2_0._click) then
		arg_2_0._click:AddClickListener(arg_2_0._onTouchClick, arg_2_0)
	end

	if arg_2_0._customAddEventListeners then
		arg_2_0:_customAddEventListeners()
	end
end

function var_0_0.removeEventListeners(arg_3_0)
	if not gohelper.isNil(arg_3_0._click) then
		arg_3_0._click:RemoveClickListener()
	end

	if arg_3_0._customRemoveEventListeners then
		arg_3_0:_customRemoveEventListeners()
	end
end

function var_0_0.refreshFollower(arg_4_0, arg_4_1)
	local var_4_0 = CameraMgr.instance:getMainCamera()
	local var_4_1 = CameraMgr.instance:getUICamera()
	local var_4_2 = ViewMgr.instance:getUIRoot().transform

	arg_4_0._uiFollower = gohelper.onceAddComponent(arg_4_0.go, typeof(ZProj.UIFollower))

	arg_4_0._uiFollower:Set(var_4_0, var_4_1, var_4_2, arg_4_1, 0, 0, 0, 0, 0)
end

function var_0_0._setShow(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 then
		if not arg_5_0._isShow then
			arg_5_0._baseAnimator:Play("room_task_in", 0, arg_5_2 and 1 or 0)
		end

		arg_5_0._containerCanvasGroup.blocksRaycasts = true
	else
		if arg_5_0._isShow then
			arg_5_0._baseAnimator:Play("room_task_out", 0, arg_5_2 and 1 or 0)
		end

		arg_5_0._containerCanvasGroup.blocksRaycasts = false
	end

	arg_5_0._isShow = arg_5_1

	arg_5_0._uiFollower:SetEnable(arg_5_1)
end

function var_0_0._onTouchClick(arg_6_0)
	arg_6_0:_onClick()
end

function var_0_0._onClick(arg_7_0)
	return
end

function var_0_0.onDestroy(arg_8_0)
	if arg_8_0._customOnDestory then
		arg_8_0:_customOnDestory()
	end
end

return var_0_0
