module("modules.logic.scene.pushbox.logic.PushBoxElementBox", package.seeall)

local var_0_0 = class("PushBoxElementBox", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0._game_mgr = GameSceneMgr.instance:getCurScene().gameMgr
	arg_1_0._gameObject = arg_1_1
	arg_1_0._transform = arg_1_1.transform
	arg_1_0._cell = arg_1_2

	arg_1_0:addEventCb(PushBoxController.instance, PushBoxEvent.RefreshElement, arg_1_0._onRefreshElement, arg_1_0)
	arg_1_0:addEventCb(PushBoxController.instance, PushBoxEvent.StepFinished, arg_1_0._onStepFinished, arg_1_0)
	arg_1_0:addEventCb(PushBoxController.instance, PushBoxEvent.RevertStep, arg_1_0._onRevertStep, arg_1_0)
	arg_1_0:addEventCb(PushBoxController.instance, PushBoxEvent.StartElement, arg_1_0._onStartElement, arg_1_0)
end

function var_0_0._onStartElement(arg_2_0)
	return
end

function var_0_0._onRevertStep(arg_3_0)
	return
end

function var_0_0._onRefreshElement(arg_4_0)
	return
end

function var_0_0._onStepFinished(arg_5_0)
	return
end

function var_0_0.hideLight(arg_6_0)
	gohelper.setActive(gohelper.findChild(arg_6_0._gameObject, "#vx_light_left"), false)
	gohelper.setActive(gohelper.findChild(arg_6_0._gameObject, "#vx_light_right"), false)
	gohelper.setActive(gohelper.findChild(arg_6_0._gameObject, "#vx_light_down"), false)
end

function var_0_0.refreshLightRenderer(arg_7_0, arg_7_1)
	local var_7_0 = gohelper.findChild(arg_7_0._gameObject, "#vx_light_left"):GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))

	if var_7_0 then
		for iter_7_0 = 0, var_7_0.Length - 1 do
			var_7_0[iter_7_0].sortingOrder = arg_7_1 + 7
		end
	end

	local var_7_1 = gohelper.findChild(arg_7_0._gameObject, "#vx_light_right"):GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))

	if var_7_1 then
		for iter_7_1 = 0, var_7_1.Length - 1 do
			var_7_1[iter_7_1].sortingOrder = arg_7_1 + 7
		end
	end

	local var_7_2 = gohelper.findChild(arg_7_0._gameObject, "#vx_light_down"):GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))

	if var_7_2 then
		for iter_7_2 = 0, var_7_2.Length - 1 do
			var_7_2[iter_7_2].sortingOrder = arg_7_1 + 7
		end
	end
end

function var_0_0.getPosX(arg_8_0)
	return arg_8_0._cell:getPosX()
end

function var_0_0.getPosY(arg_9_0)
	return arg_9_0._cell:getPosY()
end

function var_0_0.getObj(arg_10_0)
	return arg_10_0._gameObject
end

function var_0_0.getCell(arg_11_0)
	return arg_11_0._cell
end

function var_0_0.releaseSelf(arg_12_0)
	arg_12_0:__onDispose()
end

return var_0_0
