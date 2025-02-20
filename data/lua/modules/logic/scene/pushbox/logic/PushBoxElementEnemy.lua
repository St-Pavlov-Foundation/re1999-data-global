module("modules.logic.scene.pushbox.logic.PushBoxElementEnemy", package.seeall)

slot0 = class("PushBoxElementEnemy", UserDataDispose)

function slot0.ctor(slot0, slot1, slot2)
	slot0:__onInit()

	slot0._game_mgr = GameSceneMgr.instance:getCurScene().gameMgr
	slot0._gameObject = slot1
	slot0._transform = slot1.transform
	slot0._cell = slot2
	slot0._ani = slot0:getUserDataTb_()

	slot0:addEventCb(PushBoxController.instance, PushBoxEvent.RefreshElement, slot0._onRefreshElement, slot0)
	slot0:addEventCb(PushBoxController.instance, PushBoxEvent.StepFinished, slot0._onStepFinished, slot0)
	slot0:addEventCb(PushBoxController.instance, PushBoxEvent.RevertStep, slot0._onRevertStep, slot0)
	slot0:addEventCb(PushBoxController.instance, PushBoxEvent.StartElement, slot0._onStartElement, slot0)
end

function slot0.setRendererIndex(slot0)
	for slot5 = 0, slot0._transform.childCount - 1 do
		slot6 = slot0._transform:GetChild(slot5)
		slot6:GetChild(0):GetComponent("MeshRenderer").sortingOrder = slot0._cell:getRendererIndex()

		table.insert(slot0._ani, gohelper.findChildComponent(slot6.gameObject, "eyeglow", typeof(UnityEngine.Animator)))
	end
end

function slot0._onStartElement(slot0)
	slot2 = slot0._game_mgr:getConfig()
	slot0._act_rule = GameUtil.splitString2(string.split(slot2.enemy_act, "_")[slot0._game_mgr:getEnemyIndex(slot0)], true, "|", "#")
	slot0._alarm_value = slot2.enemy_alarm
	slot0._index = 1
	slot0._next_act_time = slot0._act_rule[slot0._index][2] + Time.realtimeSinceStartup

	slot0:_startAct()
	TaskDispatcher.runDelay(slot0._onTime, slot0, slot0._act_rule[slot0._index][2])
end

function slot0._onRevertStep(slot0, slot1)
	if slot1.enemy_direction then
		for slot5, slot6 in ipairs(slot1.enemy_direction) do
			if slot6.pos_x == slot0._cell:getPosX() and slot6.pos_y == slot0._cell:getPosY() then
				slot0._index = slot6.index

				slot0:doAct()
			end
		end
	end
end

function slot0._onTime(slot0)
	if slot0._in_area and slot0:_characterInArea() then
		return
	end

	slot0._index = slot0._index + 1

	if slot0._index > #slot0._act_rule then
		slot0._index = 1
	end

	slot0:doAct()
end

function slot0.doAct(slot0)
	slot0:_startAct()

	slot0._next_act_time = slot0._act_rule[slot0._index][2] + Time.realtimeSinceStartup

	TaskDispatcher.runDelay(slot0._onTime, slot0, slot0._act_rule[slot0._index][2])
end

function slot0._onRefreshElement(slot0)
	slot0._check_warning = true

	if slot0._in_area and not slot0:_characterInArea() then
		if slot0._next_act_time < Time.realtimeSinceStartup then
			slot0:_onTime()
		end

		slot0._check_warning = false

		return
	end
end

function slot0._onStepFinished(slot0)
	if not slot0._check_warning then
		return
	end

	if slot0._game_mgr:cellIsInvincible(slot0._act_cell_x, slot0._act_cell_y) then
		return
	end

	if slot0:_characterInArea() then
		slot0._game_mgr:changeWarning(slot0._alarm_value)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_alert)
	end
end

function slot0._startAct(slot0)
	slot0._act_cell_x = slot0._cell:getPosX()
	slot0._act_cell_y = slot0._cell:getPosY()

	if slot0._act_rule[slot0._index][1] == PushBoxGameMgr.Direction.Up then
		slot0._act_cell_y = slot0._act_cell_y - 1
	elseif slot1 == PushBoxGameMgr.Direction.Down then
		slot0._act_cell_y = slot0._act_cell_y + 1
	elseif slot1 == PushBoxGameMgr.Direction.Left then
		slot0._act_cell_x = slot0._act_cell_x - 1
	elseif slot1 == PushBoxGameMgr.Direction.Right then
		slot0._act_cell_x = slot0._act_cell_x + 1
	end

	slot6 = slot0._act_cell_y
	slot0._act_cell = slot0._game_mgr:getCell(slot0._act_cell_x, slot6)

	for slot6 = 0, 3 do
		slot7 = slot0._gameObject.transform:GetChild(slot6)

		gohelper.setActive(slot7.gameObject, tostring(slot1) == slot7.name)

		if gohelper.findChild(slot7.gameObject, "eyeglow"):GetComponentsInChildren(typeof(UnityEngine.MeshRenderer)) then
			for slot12 = 0, slot8.Length - 1 do
				slot8[slot12].sortingOrder = slot0._act_cell:getRendererIndex() + 2
			end
		end
	end

	if slot0._game_mgr:cellIsInvincible(slot0._act_cell_x, slot0._act_cell_y) then
		return
	end

	if slot0:_characterInArea() then
		slot0._game_mgr:changeWarning(slot0._alarm_value)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_alert)
		slot0._game_mgr:detectGameOver()
	end
end

function slot0._characterInArea(slot0)
	slot0._in_area = slot0._game_mgr:characterInArea(slot0._act_cell_x, slot0._act_cell_y)

	if slot0._ani then
		for slot4, slot5 in ipairs(slot0._ani) do
			slot5:Play(slot0._in_area and "click" or "loop")
		end
	end

	return slot0._in_area
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

function slot0.releaseSelf(slot0)
	TaskDispatcher.cancelTask(slot0._onTime, slot0)
	slot0:__onDispose()
end

slot0.Direction = {
	180,
	0,
	90,
	-90
}

return slot0
