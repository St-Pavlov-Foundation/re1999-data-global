module("modules.logic.scene.pushbox.logic.PushBoxCharacter", package.seeall)

slot0 = class("PushBoxCharacter", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0._game_mgr = slot1
	slot0._scene = slot1._scene
	slot0._scene_root = slot1._scene_root
end

function slot0.revertMove(slot0, slot1, slot2)
	slot0:_moveCharacter(slot1, slot2, true)
end

function slot0.revertDirection(slot0, slot1)
	slot0._cur_direction = slot1
end

function slot0.move(slot0, slot1)
	if not slot0._last_time then
		slot0._last_time = Time.time
	elseif Time.time - slot0._last_time < 0.2 then
		return
	end

	slot2, slot3 = nil

	if slot1 == PushBoxGameMgr.Direction.Up then
		slot2 = slot0._pos_x
		slot3 = slot0._pos_y - 1
	elseif slot1 == PushBoxGameMgr.Direction.Down then
		slot2 = slot0._pos_x
		slot3 = slot0._pos_y + 1
	elseif slot1 == PushBoxGameMgr.Direction.Left then
		slot2 = slot0._pos_x - 1
		slot3 = slot0._pos_y
	elseif slot1 == PushBoxGameMgr.Direction.Right then
		slot2 = slot0._pos_x + 1
		slot3 = slot0._pos_y
	end

	if slot0._game_mgr:outOfBounds(slot2, slot3) then
		return
	end

	slot0._cur_direction = slot1

	if not slot0:_canMove(slot2, slot3) then
		return
	end

	slot0._last_time = Time.time

	slot0._game_mgr.step_data:moveCharacter(slot0._pos_x, slot0._pos_y)
	slot0:_moveCharacter(slot2, slot3)
end

function slot0._moveCharacter(slot0, slot1, slot2, slot3)
	slot0._pos_x = slot1
	slot0._pos_y = slot2

	slot0:_releaseWalkTween()

	slot5 = slot0._game_mgr:getCell(slot1, slot2)
	slot6 = slot5:getTransform().position
	slot0._character_final_renderer_index = slot5:getRendererIndex()

	slot0:_setRendererIndex(slot5:getRendererIndex() <= slot0._game_mgr:getCell(slot0._pos_x, slot0._pos_y):getRendererIndex() and slot4:getRendererIndex() or slot5:getRendererIndex())

	slot0._walk_tween = ZProj.TweenHelper.DOMove(slot0._transform, slot6.x, slot6.y, slot6.z, 0.2)

	TaskDispatcher.runDelay(slot0._refreshCharacterRendererIndex, slot0, 0.2)
	slot0._game_mgr:detectCellData()
	slot0._game_mgr.cell_mgr:releaseBoxLight()

	if not slot3 then
		PushBoxController.instance:dispatchEvent(PushBoxEvent.RefreshElement)
		PushBoxController.instance:dispatchEvent(PushBoxEvent.StepFinished)
		slot0._game_mgr:stepOver()
	end

	if slot0._ani then
		for slot10, slot11 in ipairs(slot0._ani) do
			slot11:Play("downm", 0, 0)
		end
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_role_move)
end

function slot0._refreshCharacterRendererIndex(slot0)
	slot0:_setRendererIndex(slot0._character_final_renderer_index)
end

function slot0._canMove(slot0, slot1, slot2)
	if slot0._game_mgr:getCell(slot1, slot2):getBox() then
		slot4 = slot1
		slot5 = slot2

		if slot0._cur_direction == PushBoxGameMgr.Direction.Up then
			slot4 = slot1
			slot5 = slot2 - 1
		elseif slot0._cur_direction == PushBoxGameMgr.Direction.Down then
			slot4 = slot1
			slot5 = slot2 + 1
		elseif slot0._cur_direction == PushBoxGameMgr.Direction.Left then
			slot4 = slot1 - 1
			slot5 = slot2
		elseif slot0._cur_direction == PushBoxGameMgr.Direction.Right then
			slot4 = slot1 + 1
			slot5 = slot2
		end

		if slot0._game_mgr:getCell(slot4, slot5) then
			slot7 = true

			if slot6:getBox() then
				slot7 = false
			elseif slot0._game_mgr:typeIsEnemy(slot6:getCellType()) then
				slot7 = false
			elseif slot0._game_mgr:typeIsLight(slot8) then
				slot7 = false
			elseif slot8 == PushBoxGameMgr.ElementType.Empty then
				slot7 = false
			end

			if slot7 then
				slot0._game_mgr.step_data:pushBox(slot1, slot2, slot4, slot5)
				slot0._game_mgr.cell_mgr:pushBox(slot1, slot2, slot4, slot5)
				slot0:_moveCharacter(slot1, slot2)
			end
		end

		return false
	end

	if slot0._game_mgr:typeIsEnemy(slot3:getCellType()) then
		return false
	end

	if slot0._game_mgr:typeIsLight(slot3:getCellType()) then
		return false
	end

	slot0._chechCanMove = slot0._chechCanMove or {
		[PushBoxGameMgr.ElementType.Empty] = false,
		[PushBoxGameMgr.ElementType.Mechanics] = true,
		[PushBoxGameMgr.ElementType.Fan] = true,
		[PushBoxGameMgr.ElementType.Road] = true,
		[PushBoxGameMgr.ElementType.Goal] = true
	}

	if slot0._chechCanMove[slot3:getCellType()] then
		return slot0._chechCanMove[slot3:getCellType()]
	end

	if slot0._game_mgr:typeIsCharacter(slot3:getCellType()) then
		return true
	end

	if slot0._game_mgr:typeIsDoor(slot3:getCellType()) then
		if not slot3.door_is_opened then
			return false
		end

		return true
	end
end

function slot0.getCharacterObj(slot0)
	return slot0._gameObject
end

function slot0.getCharacterTran(slot0)
	return slot0._transform
end

function slot0.getPosX(slot0)
	return slot0._pos_x
end

function slot0.getPosY(slot0)
	return slot0._pos_y
end

function slot0.init(slot0)
	slot0._gameObject = gohelper.create3d(gohelper.findChild(slot0._scene:getSceneContainerGO(), "Root"), "character")

	gohelper.clone(gohelper.findChild(slot0._scene_root, "Root/OriginElement/CharacterUp"), slot0._gameObject, PushBoxGameMgr.Direction.Up)
	gohelper.clone(gohelper.findChild(slot0._scene_root, "Root/OriginElement/CharacterDown"), slot0._gameObject, PushBoxGameMgr.Direction.Down)
	gohelper.clone(gohelper.findChild(slot0._scene_root, "Root/OriginElement/CharacterLeft"), slot0._gameObject, PushBoxGameMgr.Direction.Left)

	slot4 = PushBoxGameMgr.Direction.Right

	gohelper.clone(gohelper.findChild(slot0._scene_root, "Root/OriginElement/CharacterRight"), slot0._gameObject, slot4)

	slot0._transform = slot0._gameObject.transform

	slot0:_refreshPos()

	slot0._ani = slot0:getUserDataTb_()

	for slot4 = 0, 3 do
		table.insert(slot0._ani, gohelper.onceAddComponent(slot0._gameObject.transform:GetChild(slot4).gameObject, typeof(UnityEngine.Animator)))
	end
end

function slot0.setPos(slot0, slot1, slot2, slot3)
	slot4 = slot0._game_mgr:getCell(slot1, slot2)
	slot0._cur_direction = slot3
	slot0._pos_x = slot4:getPosX()
	slot0._pos_y = slot4:getPosY()

	slot0:_refreshPos()
end

function slot0.getDirection(slot0)
	return slot0._cur_direction
end

function slot0._refreshPos(slot0)
	if not slot0._transform then
		return
	end

	if slot0._game_mgr:getCell(slot0._pos_x, slot0._pos_y) then
		slot2 = slot1:getCellObj().transform.position

		transformhelper.setPos(slot0._transform, slot2.x, slot2.y, slot2.z)
		slot0:_setRendererIndex(slot1:getRendererIndex())
	end
end

function slot0._setRendererIndex(slot0, slot1)
	for slot6 = 0, 3 do
		slot7 = slot0._gameObject.transform:GetChild(slot6)
		slot7:GetChild(0):GetComponent("MeshRenderer").sortingOrder = slot1 + 8

		gohelper.setActive(slot7.gameObject, slot7.name == tostring(slot0._cur_direction))
	end
end

function slot0._releaseWalkTween(slot0)
	if slot0._walk_tween then
		ZProj.TweenHelper.KillById(slot0._walk_tween)
	end

	slot0._walk_tween = nil
end

function slot0.releaseSelf(slot0)
	gohelper.destroy(slot0._gameObject)
	TaskDispatcher.cancelTask(slot0._refreshCharacterRendererIndex, slot0)
	slot0:_releaseWalkTween()
	slot0:__onDispose()
end

return slot0
