module("modules.logic.scene.pushbox.logic.PushBoxCharacter", package.seeall)

local var_0_0 = class("PushBoxCharacter", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0._game_mgr = arg_1_1
	arg_1_0._scene = arg_1_1._scene
	arg_1_0._scene_root = arg_1_1._scene_root
end

function var_0_0.revertMove(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:_moveCharacter(arg_2_1, arg_2_2, true)
end

function var_0_0.revertDirection(arg_3_0, arg_3_1)
	arg_3_0._cur_direction = arg_3_1
end

function var_0_0.move(arg_4_0, arg_4_1)
	if not arg_4_0._last_time then
		arg_4_0._last_time = Time.time
	elseif Time.time - arg_4_0._last_time < 0.2 then
		return
	end

	local var_4_0
	local var_4_1

	if arg_4_1 == PushBoxGameMgr.Direction.Up then
		var_4_0 = arg_4_0._pos_x
		var_4_1 = arg_4_0._pos_y - 1
	elseif arg_4_1 == PushBoxGameMgr.Direction.Down then
		var_4_0 = arg_4_0._pos_x
		var_4_1 = arg_4_0._pos_y + 1
	elseif arg_4_1 == PushBoxGameMgr.Direction.Left then
		var_4_0 = arg_4_0._pos_x - 1
		var_4_1 = arg_4_0._pos_y
	elseif arg_4_1 == PushBoxGameMgr.Direction.Right then
		var_4_0 = arg_4_0._pos_x + 1
		var_4_1 = arg_4_0._pos_y
	end

	if arg_4_0._game_mgr:outOfBounds(var_4_0, var_4_1) then
		return
	end

	arg_4_0._cur_direction = arg_4_1

	if not arg_4_0:_canMove(var_4_0, var_4_1) then
		return
	end

	arg_4_0._last_time = Time.time

	arg_4_0._game_mgr.step_data:moveCharacter(arg_4_0._pos_x, arg_4_0._pos_y)
	arg_4_0:_moveCharacter(var_4_0, var_4_1)
end

function var_0_0._moveCharacter(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0._game_mgr:getCell(arg_5_0._pos_x, arg_5_0._pos_y)

	arg_5_0._pos_x = arg_5_1
	arg_5_0._pos_y = arg_5_2

	arg_5_0:_releaseWalkTween()

	local var_5_1 = arg_5_0._game_mgr:getCell(arg_5_1, arg_5_2)
	local var_5_2 = var_5_1:getTransform().position

	arg_5_0._character_final_renderer_index = var_5_1:getRendererIndex()

	arg_5_0:_setRendererIndex(var_5_0:getRendererIndex() >= var_5_1:getRendererIndex() and var_5_0:getRendererIndex() or var_5_1:getRendererIndex())

	arg_5_0._walk_tween = ZProj.TweenHelper.DOMove(arg_5_0._transform, var_5_2.x, var_5_2.y, var_5_2.z, 0.2)

	TaskDispatcher.runDelay(arg_5_0._refreshCharacterRendererIndex, arg_5_0, 0.2)
	arg_5_0._game_mgr:detectCellData()
	arg_5_0._game_mgr.cell_mgr:releaseBoxLight()

	if not arg_5_3 then
		PushBoxController.instance:dispatchEvent(PushBoxEvent.RefreshElement)
		PushBoxController.instance:dispatchEvent(PushBoxEvent.StepFinished)
		arg_5_0._game_mgr:stepOver()
	end

	if arg_5_0._ani then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0._ani) do
			iter_5_1:Play("downm", 0, 0)
		end
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_role_move)
end

function var_0_0._refreshCharacterRendererIndex(arg_6_0)
	arg_6_0:_setRendererIndex(arg_6_0._character_final_renderer_index)
end

function var_0_0._canMove(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._game_mgr:getCell(arg_7_1, arg_7_2)

	if var_7_0:getBox() then
		local var_7_1 = arg_7_1
		local var_7_2 = arg_7_2

		if arg_7_0._cur_direction == PushBoxGameMgr.Direction.Up then
			var_7_1 = arg_7_1
			var_7_2 = arg_7_2 - 1
		elseif arg_7_0._cur_direction == PushBoxGameMgr.Direction.Down then
			var_7_1 = arg_7_1
			var_7_2 = arg_7_2 + 1
		elseif arg_7_0._cur_direction == PushBoxGameMgr.Direction.Left then
			var_7_1 = arg_7_1 - 1
			var_7_2 = arg_7_2
		elseif arg_7_0._cur_direction == PushBoxGameMgr.Direction.Right then
			var_7_1 = arg_7_1 + 1
			var_7_2 = arg_7_2
		end

		local var_7_3 = arg_7_0._game_mgr:getCell(var_7_1, var_7_2)

		if var_7_3 then
			local var_7_4 = true

			if var_7_3:getBox() then
				var_7_4 = false
			else
				local var_7_5 = var_7_3:getCellType()

				if arg_7_0._game_mgr:typeIsEnemy(var_7_5) then
					var_7_4 = false
				elseif arg_7_0._game_mgr:typeIsLight(var_7_5) then
					var_7_4 = false
				elseif var_7_5 == PushBoxGameMgr.ElementType.Empty then
					var_7_4 = false
				end
			end

			if var_7_4 then
				arg_7_0._game_mgr.step_data:pushBox(arg_7_1, arg_7_2, var_7_1, var_7_2)
				arg_7_0._game_mgr.cell_mgr:pushBox(arg_7_1, arg_7_2, var_7_1, var_7_2)
				arg_7_0:_moveCharacter(arg_7_1, arg_7_2)
			end
		end

		return false
	end

	if arg_7_0._game_mgr:typeIsEnemy(var_7_0:getCellType()) then
		return false
	end

	if arg_7_0._game_mgr:typeIsLight(var_7_0:getCellType()) then
		return false
	end

	arg_7_0._chechCanMove = arg_7_0._chechCanMove or {
		[PushBoxGameMgr.ElementType.Empty] = false,
		[PushBoxGameMgr.ElementType.Mechanics] = true,
		[PushBoxGameMgr.ElementType.Fan] = true,
		[PushBoxGameMgr.ElementType.Road] = true,
		[PushBoxGameMgr.ElementType.Goal] = true
	}

	if arg_7_0._chechCanMove[var_7_0:getCellType()] then
		return arg_7_0._chechCanMove[var_7_0:getCellType()]
	end

	if arg_7_0._game_mgr:typeIsCharacter(var_7_0:getCellType()) then
		return true
	end

	if arg_7_0._game_mgr:typeIsDoor(var_7_0:getCellType()) then
		if not var_7_0.door_is_opened then
			return false
		end

		return true
	end
end

function var_0_0.getCharacterObj(arg_8_0)
	return arg_8_0._gameObject
end

function var_0_0.getCharacterTran(arg_9_0)
	return arg_9_0._transform
end

function var_0_0.getPosX(arg_10_0)
	return arg_10_0._pos_x
end

function var_0_0.getPosY(arg_11_0)
	return arg_11_0._pos_y
end

function var_0_0.init(arg_12_0)
	arg_12_0._gameObject = gohelper.create3d(gohelper.findChild(arg_12_0._scene:getSceneContainerGO(), "Root"), "character")

	gohelper.clone(gohelper.findChild(arg_12_0._scene_root, "Root/OriginElement/CharacterUp"), arg_12_0._gameObject, PushBoxGameMgr.Direction.Up)
	gohelper.clone(gohelper.findChild(arg_12_0._scene_root, "Root/OriginElement/CharacterDown"), arg_12_0._gameObject, PushBoxGameMgr.Direction.Down)
	gohelper.clone(gohelper.findChild(arg_12_0._scene_root, "Root/OriginElement/CharacterLeft"), arg_12_0._gameObject, PushBoxGameMgr.Direction.Left)
	gohelper.clone(gohelper.findChild(arg_12_0._scene_root, "Root/OriginElement/CharacterRight"), arg_12_0._gameObject, PushBoxGameMgr.Direction.Right)

	arg_12_0._transform = arg_12_0._gameObject.transform

	arg_12_0:_refreshPos()

	arg_12_0._ani = arg_12_0:getUserDataTb_()

	for iter_12_0 = 0, 3 do
		local var_12_0 = arg_12_0._gameObject.transform:GetChild(iter_12_0)

		table.insert(arg_12_0._ani, gohelper.onceAddComponent(var_12_0.gameObject, typeof(UnityEngine.Animator)))
	end
end

function var_0_0.setPos(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0._game_mgr:getCell(arg_13_1, arg_13_2)

	arg_13_0._cur_direction = arg_13_3
	arg_13_0._pos_x = var_13_0:getPosX()
	arg_13_0._pos_y = var_13_0:getPosY()

	arg_13_0:_refreshPos()
end

function var_0_0.getDirection(arg_14_0)
	return arg_14_0._cur_direction
end

function var_0_0._refreshPos(arg_15_0)
	if not arg_15_0._transform then
		return
	end

	local var_15_0 = arg_15_0._game_mgr:getCell(arg_15_0._pos_x, arg_15_0._pos_y)

	if var_15_0 then
		local var_15_1 = var_15_0:getCellObj().transform.position

		transformhelper.setPos(arg_15_0._transform, var_15_1.x, var_15_1.y, var_15_1.z)
		arg_15_0:_setRendererIndex(var_15_0:getRendererIndex())
	end
end

function var_0_0._setRendererIndex(arg_16_0, arg_16_1)
	local var_16_0 = tostring(arg_16_0._cur_direction)

	for iter_16_0 = 0, 3 do
		local var_16_1 = arg_16_0._gameObject.transform:GetChild(iter_16_0)

		var_16_1:GetChild(0):GetComponent("MeshRenderer").sortingOrder = arg_16_1 + 8

		gohelper.setActive(var_16_1.gameObject, var_16_1.name == var_16_0)
	end
end

function var_0_0._releaseWalkTween(arg_17_0)
	if arg_17_0._walk_tween then
		ZProj.TweenHelper.KillById(arg_17_0._walk_tween)
	end

	arg_17_0._walk_tween = nil
end

function var_0_0.releaseSelf(arg_18_0)
	gohelper.destroy(arg_18_0._gameObject)
	TaskDispatcher.cancelTask(arg_18_0._refreshCharacterRendererIndex, arg_18_0)
	arg_18_0:_releaseWalkTween()
	arg_18_0:__onDispose()
end

return var_0_0
