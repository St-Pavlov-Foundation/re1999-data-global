module("modules.logic.scene.pushbox.logic.PushBoxElementLight", package.seeall)

slot0 = class("PushBoxElementLight", UserDataDispose)

function slot0.ctor(slot0, slot1, slot2)
	slot0:__onInit()

	slot0._game_mgr = GameSceneMgr.instance:getCurScene().gameMgr
	slot0._gameObject = slot1
	slot0._transform = slot1.transform
	slot0._cell = slot2

	slot0:addEventCb(PushBoxController.instance, PushBoxEvent.RefreshElement, slot0._onRefreshElement, slot0)
	slot0:addEventCb(PushBoxController.instance, PushBoxEvent.StepFinished, slot0._onStepFinished, slot0)
	slot0:addEventCb(PushBoxController.instance, PushBoxEvent.RevertStep, slot0._onRevertStep, slot0)
	slot0:addEventCb(PushBoxController.instance, PushBoxEvent.StartElement, slot0._onStartElement, slot0)
end

function slot0.setRendererIndex(slot0)
	slot0._transform:GetChild(0):GetComponent("MeshRenderer").sortingOrder = slot0._cell:getRendererIndex()

	if gohelper.findChild(slot0._gameObject, "vx_light/vx_light_tou/glow1") then
		slot2:GetComponent("MeshRenderer").sortingOrder = slot0._cell:getRendererIndex() + 1
	end

	if gohelper.findChild(slot0._gameObject, "vx_light/vx_light_tou/Particle System (1)") then
		slot3:GetComponent("Renderer").sortingOrder = slot0._cell:getRendererIndex() + 1
	end

	slot0._light = gohelper.findChild(slot0._gameObject, "light").transform
end

function slot0._onStartElement(slot0)
	slot0._alarm_value = slot0._game_mgr:getConfig().light_alarm

	slot0:refreshActArea()
end

function slot0._hideWallLight(slot0)
	if gohelper.findChild(slot0._gameObject, "vx_light_qiang") then
		gohelper.setActive(slot1, false)
	end
end

function slot0._beforeRefreshActArea(slot0)
	if slot0._act_list then
		slot0._last_act_count = #slot0._act_list
	else
		slot0._last_act_count = 0
	end

	slot0._act_list = {}

	slot0:_hideWallLight()

	slot0._play_tween = false
	slot0._offset_scale = 0
	slot0._box_show_light_obj = nil

	TaskDispatcher.cancelTask(slot0._showBoxLight, slot0)
end

function slot0.refreshActArea(slot0)
	slot0:_beforeRefreshActArea()

	slot1 = gohelper.findChild(slot0._gameObject, "vx_light_qiang")
	slot3, slot4, slot5, slot6 = slot0:_getActArea(slot0._cell:getCellType())
	slot7 = slot0._cell:getRendererIndex()

	for slot11 = slot3, slot4, slot5 do
		slot12 = slot6 and slot0._game_mgr:getCell(slot11, slot0._cell:getPosY()) or slot0._game_mgr:getCell(slot0._cell:getPosX(), slot11)
		slot13 = slot12:getCellType()

		if slot12:getBox() then
			slot0:_tarCellBox(slot12, slot5, slot6)

			break
		elseif slot13 == PushBoxGameMgr.ElementType.Enemy then
			break
		elseif slot13 == PushBoxGameMgr.ElementType.LightUp then
			break
		elseif slot13 == PushBoxGameMgr.ElementType.LightDown then
			break
		elseif slot13 == PushBoxGameMgr.ElementType.LightLeft then
			break
		elseif slot13 == PushBoxGameMgr.ElementType.LightRight then
			break
		elseif slot13 == PushBoxGameMgr.ElementType.Empty then
			if not slot6 and slot5 < 0 and slot1 then
				slot0._offset_scale = 0.6

				gohelper.setActive(slot1, true)

				slot14, slot15, slot16 = transformhelper.getPos(slot0._act_list[#slot0._act_list]:getCellObj().transform)

				transformhelper.setPos(slot1.transform, slot14, slot15, slot16)
			end

			break
		end

		if slot7 <= slot12:getRendererIndex() then
			slot7 = slot12:getRendererIndex()
		end

		table.insert(slot0._act_list, slot12)

		if #slot0._act_list == math.abs(slot4 - slot3) + 1 and not slot6 and slot5 < 0 and slot1 then
			slot0._offset_scale = 0.6

			gohelper.setActive(slot1, true)

			slot14, slot15, slot16 = transformhelper.getPos(slot0._act_list[#slot0._act_list]:getCellObj().transform)

			transformhelper.setPos(slot1.transform, slot14, slot15, slot16)
		end
	end

	gohelper.findChild(slot0._gameObject, "light/glow1"):GetComponent("MeshRenderer").sortingOrder = slot7 - 1

	if slot1 then
		gohelper.findChild(slot1, "glow1"):GetComponent("MeshRenderer").sortingOrder = slot7
	end

	slot0:_playTween()
end

function slot0._tarCellBox(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChild(slot0._game_mgr._scene_root, "Root/ElementRoot/Box" .. slot1:getPosY() .. "_" .. slot1:getPosX())
	slot5 = nil

	if slot3 then
		if slot2 > 0 then
			slot0._offset_scale = 0.29
		else
			slot0._offset_scale = 0.22
		end

		if slot0._game_mgr.character:getDirection() == PushBoxGameMgr.Direction.Left or slot6 == PushBoxGameMgr.Direction.Right then
			slot0._play_tween = true
		end
	else
		if slot2 <= 0 then
			slot5 = gohelper.findChild(slot4, "#vx_light_down")
		end

		if slot0._game_mgr.character:getDirection() == PushBoxGameMgr.Direction.Down or slot6 == PushBoxGameMgr.Direction.Up then
			slot0._play_tween = true
		end

		slot0._offset_scale = 0.6
	end

	if slot5 then
		slot0._box_show_light_obj = slot5

		if slot0._play_tween then
			gohelper.setActive(slot5, true)
		else
			TaskDispatcher.runDelay(slot0._showBoxLight, slot0, 0.2)
		end

		if slot5:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer)) then
			for slot10 = 0, slot6.Length - 1 do
				slot6[slot10].sortingOrder = slot4.transform:GetChild(0):GetComponent("MeshRenderer").sortingOrder + 1
			end
		end
	end
end

function slot0._getActArea(slot0, slot1)
	slot2 = 0
	slot3 = 0
	slot4 = 0
	slot5 = false

	if slot1 == PushBoxGameMgr.ElementType.LightRight then
		slot2 = slot0._cell:getPosX() + 1
		slot3 = 8
		slot4 = 1
		slot5 = true
	elseif slot1 == PushBoxGameMgr.ElementType.LightLeft then
		slot2 = slot0._cell:getPosX() - 1
		slot3 = 1
		slot4 = -1
		slot5 = true
	elseif slot1 == PushBoxGameMgr.ElementType.LightUp then
		slot2 = slot0._cell:getPosY() - 1
		slot3 = 1
		slot4 = -1
	elseif slot1 == PushBoxGameMgr.ElementType.LightDown then
		slot2 = slot0._cell:getPosY() + 1
		slot3 = 6
		slot4 = 1
	end

	return slot2, slot3, slot4, slot5
end

function slot0._playTween(slot0)
	if slot0._play_tween then
		slot0:_releaseTween()

		slot0._tween = ZProj.TweenHelper.DOTweenFloat(slot0._last_act_count + slot0._offset_scale, #slot0._act_list + slot0._offset_scale, 0.2, slot0._frameCallback, nil, slot0)
	else
		if #slot0._act_list == slot0._last_act_count then
			slot0:_showBoxLight()
		end

		transformhelper.setLocalScale(slot0._light, #slot0._act_list + slot0._offset_scale, 1, 1)
	end
end

function slot0._showBoxLight(slot0)
	if slot0._box_show_light_obj then
		gohelper.setActive(slot0._box_show_light_obj, true)
	end
end

function slot0._releaseTween(slot0)
	if slot0._tween then
		ZProj.TweenHelper.KillById(slot0._tween)
	end

	slot0._tween = nil
end

function slot0._frameCallback(slot0, slot1)
	transformhelper.setLocalScale(slot0._light, slot1, 1, 1)
end

function slot0._onRevertStep(slot0)
	slot0:refreshActArea()
end

function slot0._onRefreshElement(slot0)
	slot0:refreshActArea()
end

function slot0._onStepFinished(slot0)
	for slot4, slot5 in ipairs(slot0._act_list) do
		if slot0._game_mgr:characterInArea(slot5:getPosX(), slot5:getPosY()) and not slot0._game_mgr:cellIsInvincible(slot5:getPosX(), slot5:getPosY()) then
			slot0._game_mgr:changeWarning(slot0._alarm_value)
		end
	end
end

function slot0._characterInArea(slot0)
	slot0._in_area = slot0._game_mgr:characterInArea(slot0._act_cell_x, slot0._act_cell_y)

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
	TaskDispatcher.cancelTask(slot0._showBoxLight, slot0)
	slot0:_releaseTween()
	slot0:__onDispose()
end

return slot0
