module("modules.logic.scene.pushbox.logic.PushBoxElementLight", package.seeall)

local var_0_0 = class("PushBoxElementLight", UserDataDispose)

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
	arg_2_0._transform:GetChild(0):GetComponent("MeshRenderer").sortingOrder = arg_2_0._cell:getRendererIndex()

	local var_2_0 = gohelper.findChild(arg_2_0._gameObject, "vx_light/vx_light_tou/glow1")

	if var_2_0 then
		var_2_0:GetComponent("MeshRenderer").sortingOrder = arg_2_0._cell:getRendererIndex() + 1
	end

	local var_2_1 = gohelper.findChild(arg_2_0._gameObject, "vx_light/vx_light_tou/Particle System (1)")

	if var_2_1 then
		var_2_1:GetComponent("Renderer").sortingOrder = arg_2_0._cell:getRendererIndex() + 1
	end

	arg_2_0._light = gohelper.findChild(arg_2_0._gameObject, "light").transform
end

function var_0_0._onStartElement(arg_3_0)
	arg_3_0._alarm_value = arg_3_0._game_mgr:getConfig().light_alarm

	arg_3_0:refreshActArea()
end

function var_0_0._hideWallLight(arg_4_0)
	local var_4_0 = gohelper.findChild(arg_4_0._gameObject, "vx_light_qiang")

	if var_4_0 then
		gohelper.setActive(var_4_0, false)
	end
end

function var_0_0._beforeRefreshActArea(arg_5_0)
	if arg_5_0._act_list then
		arg_5_0._last_act_count = #arg_5_0._act_list
	else
		arg_5_0._last_act_count = 0
	end

	arg_5_0._act_list = {}

	arg_5_0:_hideWallLight()

	arg_5_0._play_tween = false
	arg_5_0._offset_scale = 0
	arg_5_0._box_show_light_obj = nil

	TaskDispatcher.cancelTask(arg_5_0._showBoxLight, arg_5_0)
end

function var_0_0.refreshActArea(arg_6_0)
	arg_6_0:_beforeRefreshActArea()

	local var_6_0 = gohelper.findChild(arg_6_0._gameObject, "vx_light_qiang")
	local var_6_1 = arg_6_0._cell:getCellType()
	local var_6_2, var_6_3, var_6_4, var_6_5 = arg_6_0:_getActArea(var_6_1)
	local var_6_6 = arg_6_0._cell:getRendererIndex()

	for iter_6_0 = var_6_2, var_6_3, var_6_4 do
		local var_6_7 = var_6_5 and arg_6_0._game_mgr:getCell(iter_6_0, arg_6_0._cell:getPosY()) or arg_6_0._game_mgr:getCell(arg_6_0._cell:getPosX(), iter_6_0)
		local var_6_8 = var_6_7:getCellType()

		if var_6_7:getBox() then
			arg_6_0:_tarCellBox(var_6_7, var_6_4, var_6_5)

			break
		elseif var_6_8 == PushBoxGameMgr.ElementType.Enemy then
			break
		elseif var_6_8 == PushBoxGameMgr.ElementType.LightUp then
			break
		elseif var_6_8 == PushBoxGameMgr.ElementType.LightDown then
			break
		elseif var_6_8 == PushBoxGameMgr.ElementType.LightLeft then
			break
		elseif var_6_8 == PushBoxGameMgr.ElementType.LightRight then
			break
		elseif var_6_8 == PushBoxGameMgr.ElementType.Empty then
			if not var_6_5 and var_6_4 < 0 and var_6_0 then
				arg_6_0._offset_scale = 0.6

				gohelper.setActive(var_6_0, true)

				local var_6_9, var_6_10, var_6_11 = transformhelper.getPos(arg_6_0._act_list[#arg_6_0._act_list]:getCellObj().transform)

				transformhelper.setPos(var_6_0.transform, var_6_9, var_6_10, var_6_11)
			end

			break
		end

		if var_6_6 <= var_6_7:getRendererIndex() then
			var_6_6 = var_6_7:getRendererIndex()
		end

		table.insert(arg_6_0._act_list, var_6_7)

		if #arg_6_0._act_list == math.abs(var_6_3 - var_6_2) + 1 and not var_6_5 and var_6_4 < 0 and var_6_0 then
			arg_6_0._offset_scale = 0.6

			gohelper.setActive(var_6_0, true)

			local var_6_12, var_6_13, var_6_14 = transformhelper.getPos(arg_6_0._act_list[#arg_6_0._act_list]:getCellObj().transform)

			transformhelper.setPos(var_6_0.transform, var_6_12, var_6_13, var_6_14)
		end
	end

	gohelper.findChild(arg_6_0._gameObject, "light/glow1"):GetComponent("MeshRenderer").sortingOrder = var_6_6 - 1

	if var_6_0 then
		gohelper.findChild(var_6_0, "glow1"):GetComponent("MeshRenderer").sortingOrder = var_6_6
	end

	arg_6_0:_playTween()
end

function var_0_0._tarCellBox(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = gohelper.findChild(arg_7_0._game_mgr._scene_root, "Root/ElementRoot/Box" .. arg_7_1:getPosY() .. "_" .. arg_7_1:getPosX())
	local var_7_1

	if arg_7_3 then
		if arg_7_2 > 0 then
			arg_7_0._offset_scale = 0.29
		else
			arg_7_0._offset_scale = 0.22
		end

		local var_7_2 = arg_7_0._game_mgr.character:getDirection()

		if var_7_2 == PushBoxGameMgr.Direction.Left or var_7_2 == PushBoxGameMgr.Direction.Right then
			arg_7_0._play_tween = true
		end
	else
		if arg_7_2 > 0 then
			-- block empty
		else
			var_7_1 = gohelper.findChild(var_7_0, "#vx_light_down")
		end

		local var_7_3 = arg_7_0._game_mgr.character:getDirection()

		if var_7_3 == PushBoxGameMgr.Direction.Down or var_7_3 == PushBoxGameMgr.Direction.Up then
			arg_7_0._play_tween = true
		end

		arg_7_0._offset_scale = 0.6
	end

	if var_7_1 then
		arg_7_0._box_show_light_obj = var_7_1

		if arg_7_0._play_tween then
			gohelper.setActive(var_7_1, true)
		else
			TaskDispatcher.runDelay(arg_7_0._showBoxLight, arg_7_0, 0.2)
		end

		local var_7_4 = var_7_1:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))

		if var_7_4 then
			for iter_7_0 = 0, var_7_4.Length - 1 do
				var_7_4[iter_7_0].sortingOrder = var_7_0.transform:GetChild(0):GetComponent("MeshRenderer").sortingOrder + 1
			end
		end
	end
end

function var_0_0._getActArea(arg_8_0, arg_8_1)
	local var_8_0 = 0
	local var_8_1 = 0
	local var_8_2 = 0
	local var_8_3 = false

	if arg_8_1 == PushBoxGameMgr.ElementType.LightRight then
		var_8_0 = arg_8_0._cell:getPosX() + 1
		var_8_1 = 8
		var_8_2 = 1
		var_8_3 = true
	elseif arg_8_1 == PushBoxGameMgr.ElementType.LightLeft then
		var_8_0 = arg_8_0._cell:getPosX() - 1
		var_8_1 = 1
		var_8_2 = -1
		var_8_3 = true
	elseif arg_8_1 == PushBoxGameMgr.ElementType.LightUp then
		var_8_0 = arg_8_0._cell:getPosY() - 1
		var_8_1 = 1
		var_8_2 = -1
	elseif arg_8_1 == PushBoxGameMgr.ElementType.LightDown then
		var_8_0 = arg_8_0._cell:getPosY() + 1
		var_8_1 = 6
		var_8_2 = 1
	end

	return var_8_0, var_8_1, var_8_2, var_8_3
end

function var_0_0._playTween(arg_9_0)
	if arg_9_0._play_tween then
		arg_9_0:_releaseTween()

		arg_9_0._tween = ZProj.TweenHelper.DOTweenFloat(arg_9_0._last_act_count + arg_9_0._offset_scale, #arg_9_0._act_list + arg_9_0._offset_scale, 0.2, arg_9_0._frameCallback, nil, arg_9_0)
	else
		if #arg_9_0._act_list == arg_9_0._last_act_count then
			arg_9_0:_showBoxLight()
		end

		transformhelper.setLocalScale(arg_9_0._light, #arg_9_0._act_list + arg_9_0._offset_scale, 1, 1)
	end
end

function var_0_0._showBoxLight(arg_10_0)
	if arg_10_0._box_show_light_obj then
		gohelper.setActive(arg_10_0._box_show_light_obj, true)
	end
end

function var_0_0._releaseTween(arg_11_0)
	if arg_11_0._tween then
		ZProj.TweenHelper.KillById(arg_11_0._tween)
	end

	arg_11_0._tween = nil
end

function var_0_0._frameCallback(arg_12_0, arg_12_1)
	transformhelper.setLocalScale(arg_12_0._light, arg_12_1, 1, 1)
end

function var_0_0._onRevertStep(arg_13_0)
	arg_13_0:refreshActArea()
end

function var_0_0._onRefreshElement(arg_14_0)
	arg_14_0:refreshActArea()
end

function var_0_0._onStepFinished(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0._act_list) do
		if arg_15_0._game_mgr:characterInArea(iter_15_1:getPosX(), iter_15_1:getPosY()) and not arg_15_0._game_mgr:cellIsInvincible(iter_15_1:getPosX(), iter_15_1:getPosY()) then
			arg_15_0._game_mgr:changeWarning(arg_15_0._alarm_value)
		end
	end
end

function var_0_0._characterInArea(arg_16_0)
	arg_16_0._in_area = arg_16_0._game_mgr:characterInArea(arg_16_0._act_cell_x, arg_16_0._act_cell_y)

	return arg_16_0._in_area
end

function var_0_0.getIndex(arg_17_0)
	return arg_17_0._index
end

function var_0_0.getPosX(arg_18_0)
	return arg_18_0._cell:getPosX()
end

function var_0_0.getPosY(arg_19_0)
	return arg_19_0._cell:getPosY()
end

function var_0_0.getObj(arg_20_0)
	return arg_20_0._gameObject
end

function var_0_0.getCell(arg_21_0)
	return arg_21_0._cell
end

function var_0_0.releaseSelf(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._showBoxLight, arg_22_0)
	arg_22_0:_releaseTween()
	arg_22_0:__onDispose()
end

return var_0_0
