module("modules.logic.scene.pushbox.logic.PushBoxElementMechanics", package.seeall)

local var_0_0 = class("PushBoxElementMechanics", UserDataDispose)

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

function var_0_0.setRendererIndex(arg_2_0)
	local var_2_0 = arg_2_0._cell:getRendererIndex()

	for iter_2_0 = 0, arg_2_0._transform.childCount - 1 do
		local var_2_1 = arg_2_0._transform:GetChild(iter_2_0):GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))

		for iter_2_1 = 0, var_2_1.Length - 1 do
			var_2_1[iter_2_1].sortingOrder = var_2_0
		end
	end
end

function var_0_0.refreshMechanicsState(arg_3_0, arg_3_1)
	local var_3_0 = gohelper.findChild(arg_3_0._gameObject, "Normal")
	local var_3_1 = gohelper.findChild(arg_3_0._gameObject, "Enabled")

	gohelper.setActive(var_3_1, arg_3_1)
	gohelper.setActive(var_3_0, not arg_3_1)

	if arg_3_1 and arg_3_1 ~= arg_3_0._last_has_box then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_organ_open)
	end

	arg_3_0._last_has_box = arg_3_1
end

function var_0_0._onStartElement(arg_4_0)
	return
end

function var_0_0._onRevertStep(arg_5_0)
	return
end

function var_0_0._onRefreshElement(arg_6_0)
	return
end

function var_0_0._onStepFinished(arg_7_0)
	return
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
