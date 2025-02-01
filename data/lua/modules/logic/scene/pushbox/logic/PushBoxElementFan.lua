module("modules.logic.scene.pushbox.logic.PushBoxElementFan", package.seeall)

slot0 = class("PushBoxElementFan", UserDataDispose)

function slot0.ctor(slot0, slot1, slot2)
	slot0:__onInit()

	slot0._game_mgr = GameSceneMgr.instance:getCurScene().gameMgr
	slot0._gameObject = slot1
	slot0._transform = slot1.transform
	slot0._cell = slot2
	slot0._ani = gohelper.findChildComponent(slot1, "fengshan", typeof(UnityEngine.Animator))

	slot0:addEventCb(PushBoxController.instance, PushBoxEvent.RefreshElement, slot0._onRefreshElement, slot0)
	slot0:addEventCb(PushBoxController.instance, PushBoxEvent.StepFinished, slot0._onStepFinished, slot0)
	slot0:addEventCb(PushBoxController.instance, PushBoxEvent.RevertStep, slot0._onRevertStep, slot0)
	slot0:addEventCb(PushBoxController.instance, PushBoxEvent.StartElement, slot0._onStartElement, slot0)
	slot0:addEventCb(PushBoxController.instance, PushBoxEvent.RefreshFanElement, slot0._onRefreshElement, slot0)
end

function slot0.setRendererIndex(slot0)
	for slot6 = 0, slot0._transform:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer)).Length - 1 do
		slot2[slot6].sortingOrder = slot0._cell:getRendererIndex()
	end

	slot0._smoke = gohelper.findChild(slot0._gameObject, "vx_smoke")

	for slot7 = 0, slot0._smoke.transform:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem)).Length - 1 do
		ZProj.ParticleSystemHelper.SetSortingOrder(slot3[slot7], 30000)
	end

	gohelper.setActive(slot0._smoke, false)
end

function slot0._onStartElement(slot0)
	slot0._duration_time = slot0._game_mgr:getConfig().fan_duration
	slot0._active = false
end

function slot0._onRevertStep(slot0, slot1)
	if slot1.fan_time then
		for slot5, slot6 in ipairs(slot1.fan_time) do
			if slot6.pos_x == slot0._cell:getPosX() and slot6.pos_y == slot0._cell:getPosY() then
				slot0._active = slot6.active

				slot0:_releaseTimer()

				if slot6.left_time and slot6.left_time > 0 then
					slot0._timer = true
					slot0._start_time = Time.realtimeSinceStartup - (slot0._duration_time - slot6.left_time)

					TaskDispatcher.runDelay(slot0._onEffectDone, slot0, slot6.left_time)

					if slot0._active then
						gohelper.setActive(slot0._smoke, true)
						slot0._ani:Play("click")
					end
				end

				if not slot0._active then
					slot0:_onEffectDone()
				end

				slot0._game_mgr:setCellInvincible(slot0._active, slot0._cell:getPosX(), slot0._cell:getPosY())
			end
		end
	end
end

function slot0._onRefreshElement(slot0)
	if slot0:_characterInArea() then
		if not slot0._active then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_exhaust)
		end

		TaskDispatcher.cancelTask(slot0._onEffectDone, slot0)

		slot0._active = true

		gohelper.setActive(slot0._smoke, true)
		slot0._ani:Play("click")

		slot0._timer = nil

		slot0._game_mgr:setCellInvincible(true, slot0._cell:getPosX(), slot0._cell:getPosY())
	elseif slot0._active and not slot0._timer then
		slot0._start_time = Time.realtimeSinceStartup
		slot0._timer = true

		TaskDispatcher.runDelay(slot0._onEffectDone, slot0, slot0._duration_time)
	end
end

function slot0._onStepFinished(slot0)
end

function slot0.getState(slot0)
	return slot0._active
end

function slot0._onEffectDone(slot0)
	slot0._start_time = nil
	slot0._active = false

	gohelper.setActive(slot0._smoke, false)
	slot0._ani:Play("loop")
	slot0._game_mgr:setCellInvincible(false, slot0._cell:getPosX(), slot0._cell:getPosY())
end

function slot0._characterInArea(slot0)
	return slot0._game_mgr:characterInArea(slot0._cell:getPosX(), slot0._cell:getPosY())
end

function slot0.getIndex(slot0)
	return slot0._index
end

function slot0.getPosX(slot0)
	return slot0._cell:getPosX()
end

function slot0.getPosY(slot0)
	return slot0._cell:getPosY()
end

function slot0.getObj(slot0)
	return slot0._gameObject
end

function slot0.getCell(slot0)
	return slot0._cell
end

function slot0._releaseTimer(slot0)
	slot0._start_time = nil

	TaskDispatcher.cancelTask(slot0._onEffectDone, slot0)

	slot0._timer = nil
end

function slot0.releaseSelf(slot0)
	slot0:_releaseTimer()
	slot0:__onDispose()
end

return slot0
