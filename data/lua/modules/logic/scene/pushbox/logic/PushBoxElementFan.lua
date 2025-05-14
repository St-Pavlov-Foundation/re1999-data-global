module("modules.logic.scene.pushbox.logic.PushBoxElementFan", package.seeall)

local var_0_0 = class("PushBoxElementFan", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0._game_mgr = GameSceneMgr.instance:getCurScene().gameMgr
	arg_1_0._gameObject = arg_1_1
	arg_1_0._transform = arg_1_1.transform
	arg_1_0._cell = arg_1_2
	arg_1_0._ani = gohelper.findChildComponent(arg_1_1, "fengshan", typeof(UnityEngine.Animator))

	arg_1_0:addEventCb(PushBoxController.instance, PushBoxEvent.RefreshElement, arg_1_0._onRefreshElement, arg_1_0)
	arg_1_0:addEventCb(PushBoxController.instance, PushBoxEvent.StepFinished, arg_1_0._onStepFinished, arg_1_0)
	arg_1_0:addEventCb(PushBoxController.instance, PushBoxEvent.RevertStep, arg_1_0._onRevertStep, arg_1_0)
	arg_1_0:addEventCb(PushBoxController.instance, PushBoxEvent.StartElement, arg_1_0._onStartElement, arg_1_0)
	arg_1_0:addEventCb(PushBoxController.instance, PushBoxEvent.RefreshFanElement, arg_1_0._onRefreshElement, arg_1_0)
end

function var_0_0.setRendererIndex(arg_2_0)
	local var_2_0 = arg_2_0._cell:getRendererIndex()
	local var_2_1 = arg_2_0._transform:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))

	for iter_2_0 = 0, var_2_1.Length - 1 do
		var_2_1[iter_2_0].sortingOrder = var_2_0
	end

	arg_2_0._smoke = gohelper.findChild(arg_2_0._gameObject, "vx_smoke")

	local var_2_2 = arg_2_0._smoke.transform:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem))

	for iter_2_1 = 0, var_2_2.Length - 1 do
		ZProj.ParticleSystemHelper.SetSortingOrder(var_2_2[iter_2_1], 30000)
	end

	gohelper.setActive(arg_2_0._smoke, false)
end

function var_0_0._onStartElement(arg_3_0)
	arg_3_0._duration_time = arg_3_0._game_mgr:getConfig().fan_duration
	arg_3_0._active = false
end

function var_0_0._onRevertStep(arg_4_0, arg_4_1)
	if arg_4_1.fan_time then
		for iter_4_0, iter_4_1 in ipairs(arg_4_1.fan_time) do
			if iter_4_1.pos_x == arg_4_0._cell:getPosX() and iter_4_1.pos_y == arg_4_0._cell:getPosY() then
				arg_4_0._active = iter_4_1.active

				arg_4_0:_releaseTimer()

				if iter_4_1.left_time and iter_4_1.left_time > 0 then
					arg_4_0._timer = true
					arg_4_0._start_time = Time.realtimeSinceStartup - (arg_4_0._duration_time - iter_4_1.left_time)

					TaskDispatcher.runDelay(arg_4_0._onEffectDone, arg_4_0, iter_4_1.left_time)

					if arg_4_0._active then
						gohelper.setActive(arg_4_0._smoke, true)
						arg_4_0._ani:Play("click")
					end
				end

				if not arg_4_0._active then
					arg_4_0:_onEffectDone()
				end

				arg_4_0._game_mgr:setCellInvincible(arg_4_0._active, arg_4_0._cell:getPosX(), arg_4_0._cell:getPosY())
			end
		end
	end
end

function var_0_0._onRefreshElement(arg_5_0)
	if arg_5_0:_characterInArea() then
		if not arg_5_0._active then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_exhaust)
		end

		TaskDispatcher.cancelTask(arg_5_0._onEffectDone, arg_5_0)

		arg_5_0._active = true

		gohelper.setActive(arg_5_0._smoke, true)
		arg_5_0._ani:Play("click")

		arg_5_0._timer = nil

		arg_5_0._game_mgr:setCellInvincible(true, arg_5_0._cell:getPosX(), arg_5_0._cell:getPosY())
	elseif arg_5_0._active and not arg_5_0._timer then
		arg_5_0._start_time = Time.realtimeSinceStartup
		arg_5_0._timer = true

		TaskDispatcher.runDelay(arg_5_0._onEffectDone, arg_5_0, arg_5_0._duration_time)
	end
end

function var_0_0._onStepFinished(arg_6_0)
	return
end

function var_0_0.getState(arg_7_0)
	return arg_7_0._active
end

function var_0_0._onEffectDone(arg_8_0)
	arg_8_0._start_time = nil
	arg_8_0._active = false

	gohelper.setActive(arg_8_0._smoke, false)
	arg_8_0._ani:Play("loop")
	arg_8_0._game_mgr:setCellInvincible(false, arg_8_0._cell:getPosX(), arg_8_0._cell:getPosY())
end

function var_0_0._characterInArea(arg_9_0)
	return arg_9_0._game_mgr:characterInArea(arg_9_0._cell:getPosX(), arg_9_0._cell:getPosY())
end

function var_0_0.getIndex(arg_10_0)
	return arg_10_0._index
end

function var_0_0.getPosX(arg_11_0)
	return arg_11_0._cell:getPosX()
end

function var_0_0.getPosY(arg_12_0)
	return arg_12_0._cell:getPosY()
end

function var_0_0.getObj(arg_13_0)
	return arg_13_0._gameObject
end

function var_0_0.getCell(arg_14_0)
	return arg_14_0._cell
end

function var_0_0._releaseTimer(arg_15_0)
	arg_15_0._start_time = nil

	TaskDispatcher.cancelTask(arg_15_0._onEffectDone, arg_15_0)

	arg_15_0._timer = nil
end

function var_0_0.releaseSelf(arg_16_0)
	arg_16_0:_releaseTimer()
	arg_16_0:__onDispose()
end

return var_0_0
