module("modules.logic.scene.pushbox.logic.PushBoxCellMgr", package.seeall)

local var_0_0 = class("PushBoxCellMgr", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0._game_mgr = arg_1_1
	arg_1_0._scene = arg_1_1._scene
	arg_1_0._scene_root = arg_1_1._scene_root
end

function var_0_0.getCell(arg_2_0, arg_2_1, arg_2_2)
	return arg_2_0._cell_data[arg_2_2] and arg_2_0._cell_data[arg_2_2][arg_2_1]
end

function var_0_0.getElement(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._element_logic[arg_3_1]) do
		if iter_3_1:getPosX() == arg_3_2 and iter_3_1:getPosY() == arg_3_3 then
			return iter_3_1
		end
	end
end

function var_0_0._refreshBoxRender(arg_4_0)
	arg_4_0._cur_push_box.transform:GetChild(0):GetComponent("MeshRenderer").sortingOrder = arg_4_0._box_final_render_index + 3

	arg_4_0:refreshBoxLight()
end

function var_0_0.refreshBoxLight(arg_5_0)
	local var_5_0 = arg_5_0._game_mgr:getElementLogicList(PushBoxGameMgr.ElementType.Box)

	if var_5_0 then
		for iter_5_0, iter_5_1 in ipairs(var_5_0) do
			if iter_5_1:getObj() == arg_5_0._cur_push_box then
				iter_5_1:refreshLightRenderer(arg_5_0._box_final_render_index)
			end
		end
	end
end

function var_0_0.pushBox(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0:_releaseBoxTween()

	local var_6_0 = gohelper.findChild(arg_6_0._scene_root, "Root/ElementRoot/Box" .. arg_6_2 .. "_" .. arg_6_1)
	local var_6_1 = arg_6_0:getCell(arg_6_1, arg_6_2)
	local var_6_2 = arg_6_0:getCell(arg_6_3, arg_6_4)
	local var_6_3 = var_6_2:getTransform().position
	local var_6_4 = var_6_1:getRendererIndex()
	local var_6_5 = var_6_2:getRendererIndex()

	arg_6_0._box_final_render_index = var_6_5
	arg_6_0._cur_push_box = var_6_0

	local var_6_6 = (var_6_5 <= var_6_4 and var_6_4 or var_6_5) + 3

	var_6_0.transform:GetChild(0):GetComponent("MeshRenderer").sortingOrder = var_6_6
	arg_6_0._box_tween = ZProj.TweenHelper.DOMove(var_6_0.transform, var_6_3.x, var_6_3.y, var_6_3.z, 0.2)

	TaskDispatcher.runDelay(arg_6_0._refreshBoxRender, arg_6_0, 0.2)
	var_6_2:setBox(true)
	var_6_1:setBox(false)

	var_6_0.name = "Box" .. arg_6_4 .. "_" .. arg_6_3

	arg_6_0:detectCellData()

	local var_6_7

	if arg_6_1 < arg_6_3 then
		var_6_7 = gohelper.findChild(var_6_0, "#smoke_box_right")
	elseif arg_6_3 < arg_6_1 then
		var_6_7 = gohelper.findChild(var_6_0, "#smoke_box_left")
	end

	if arg_6_2 < arg_6_4 then
		var_6_7 = gohelper.findChild(var_6_0, "#smoke_box_top")
	elseif arg_6_4 < arg_6_2 then
		var_6_7 = gohelper.findChild(var_6_0, "#smoke_box_down")
	end

	arg_6_0:_hideBoxSmoke()

	local var_6_8 = var_6_7:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem))

	for iter_6_0 = 0, var_6_8.Length - 1 do
		ZProj.ParticleSystemHelper.SetSortingOrder(var_6_8[iter_6_0], var_6_6)
	end

	gohelper.setActive(var_6_7, true)
	TaskDispatcher.cancelTask(arg_6_0._hideBoxSmoke, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._hideBoxSmoke, arg_6_0, 0.8)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_box_push)
end

function var_0_0._hideBoxSmoke(arg_7_0)
	if arg_7_0._cur_push_box then
		gohelper.setActive(gohelper.findChild(arg_7_0._cur_push_box, "#smoke_box_left"), false)
		gohelper.setActive(gohelper.findChild(arg_7_0._cur_push_box, "#smoke_box_right"), false)
		gohelper.setActive(gohelper.findChild(arg_7_0._cur_push_box, "#smoke_box_top"), false)
		gohelper.setActive(gohelper.findChild(arg_7_0._cur_push_box, "#smoke_box_down"), false)
	end
end

function var_0_0.detectCellData(arg_8_0)
	if arg_8_0._element_cell_dic and arg_8_0._element_cell_dic[PushBoxGameMgr.ElementType.Mechanics] then
		local var_8_0 = 0

		for iter_8_0, iter_8_1 in ipairs(arg_8_0._element_cell_dic[PushBoxGameMgr.ElementType.Mechanics]) do
			local var_8_1 = false

			if iter_8_1:getBox() then
				var_8_0 = var_8_0 + 1
				var_8_1 = true or var_8_1
			end

			iter_8_1:getElementLogic():refreshMechanicsState(var_8_1)
		end

		local var_8_2 = var_8_0 == #arg_8_0._element_cell_dic[PushBoxGameMgr.ElementType.Mechanics]

		for iter_8_2, iter_8_3 in ipairs(arg_8_0._cell_list) do
			if arg_8_0._game_mgr:typeIsDoor(iter_8_3:getCellType()) then
				if var_8_2 and iter_8_3.door_is_opened ~= var_8_2 then
					AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_door_open)
				end

				iter_8_3.door_is_opened = var_8_2

				iter_8_3:getElementLogic():refreshDoorState(var_8_2)
			end
		end
	end
end

function var_0_0._releaseBoxTween(arg_9_0)
	if arg_9_0._box_tween then
		ZProj.TweenHelper.KillById(arg_9_0._box_tween)
	end

	arg_9_0._box_tween = nil
end

function var_0_0.init(arg_10_0)
	arg_10_0._floor_root = gohelper.findChild(arg_10_0._scene_root, "Root/FloorRoot")

	local var_10_0 = arg_10_0._game_mgr:getConfig()
	local var_10_1 = var_10_0.wall
	local var_10_2 = GameUtil.splitString2(var_10_0.layout, true)
	local var_10_3 = GameUtil.splitString2(var_10_1)

	arg_10_0._cell_data = {}
	arg_10_0._cell_list = {}
	arg_10_0._element_cell_dic = {}
	arg_10_0._element_logic = {}

	local var_10_4 = 0

	for iter_10_0 = 1, #var_10_2 do
		for iter_10_1 = 1, #var_10_2[iter_10_0] do
			local var_10_5 = var_10_2[iter_10_0][iter_10_1]

			arg_10_0._cell_data[iter_10_0] = arg_10_0._cell_data[iter_10_0] or {}

			local var_10_6 = arg_10_0:_cloneCellObj(iter_10_1, iter_10_0)

			var_10_6.name = iter_10_0 .. "_" .. iter_10_1

			if var_10_5 == PushBoxGameMgr.ElementType.Empty then
				gohelper.setActive(var_10_6, false)
			end

			local var_10_7 = iter_10_1 - 4.5
			local var_10_8 = 2.5 - iter_10_0

			transformhelper.setLocalPos(var_10_6.transform, var_10_7 * 2.5, var_10_8 * 1.54, 0)

			var_10_6.transform:GetChild(0):GetComponent("MeshRenderer").sortingOrder = var_10_4

			local var_10_9 = PushBoxCellItem.New(arg_10_0, arg_10_0._scene:getSceneContainerGO(), var_10_6)

			arg_10_0._cell_data[iter_10_0][iter_10_1] = var_10_9

			var_10_9:initData(var_10_5, iter_10_1, iter_10_0)

			local var_10_10 = var_10_9:getCellType()
			local var_10_11 = var_10_9:initElement(var_10_5)

			arg_10_0._element_logic[var_10_10] = arg_10_0._element_logic[var_10_10] or {}

			if var_10_11 then
				table.insert(arg_10_0._element_logic[var_10_10], var_10_11)

				if var_10_9:getBox() then
					arg_10_0._element_logic[var_10_5] = arg_10_0._element_logic[var_10_5] or {}

					table.insert(arg_10_0._element_logic[var_10_5], var_10_11)
				end
			end

			arg_10_0._element_cell_dic[var_10_10] = arg_10_0._element_cell_dic[var_10_10] or {}

			table.insert(arg_10_0._element_cell_dic[var_10_10], var_10_9)
			table.insert(arg_10_0._cell_list, var_10_9)

			if var_10_5 == PushBoxGameMgr.ElementType.Character then
				arg_10_0._game_mgr:setCharacterPos(iter_10_1, iter_10_0, PushBoxGameMgr.Direction.Down)
			end

			local var_10_12 = var_10_3[iter_10_0][iter_10_1]
			local var_10_13 = string.splitToNumber(var_10_12, "_")
			local var_10_14 = var_10_5 == PushBoxGameMgr.ElementType.Goal

			for iter_10_2, iter_10_3 in ipairs(var_10_13) do
				if iter_10_3 ~= 0 then
					arg_10_0:_setWallRenderer(iter_10_3, var_10_6, var_10_4, var_10_14)
				end
			end

			var_10_4 = var_10_4 + 100
		end
	end
end

function var_0_0._cloneCellObj(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0

	if arg_11_1 % 2 ~= 0 then
		if arg_11_2 % 2 ~= 0 then
			var_11_0 = gohelper.clone(gohelper.findChild(arg_11_0._scene_root, "Root/OriginElement/" .. PushBoxGameMgr.ElementType.Road), arg_11_0._floor_root)
		else
			var_11_0 = gohelper.clone(gohelper.findChild(arg_11_0._scene_root, "Root/OriginElement/diban_b"), arg_11_0._floor_root)
		end
	elseif arg_11_2 % 2 ~= 0 then
		var_11_0 = gohelper.clone(gohelper.findChild(arg_11_0._scene_root, "Root/OriginElement/diban_c"), arg_11_0._floor_root)
	else
		var_11_0 = gohelper.clone(gohelper.findChild(arg_11_0._scene_root, "Root/OriginElement/diban_d"), arg_11_0._floor_root)
	end

	return var_11_0
end

function var_0_0._setWallRenderer(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = gohelper.clone(gohelper.findChild(arg_12_0._scene_root, "Root/OriginElement/" .. arg_12_1), arg_12_0._floor_root, "Wall")
	local var_12_1 = arg_12_2.transform.position

	transformhelper.setPos(var_12_0.transform, var_12_1.x, var_12_1.y, var_12_1.z)

	local var_12_2 = arg_12_3 + 10000
	local var_12_3 = var_12_0.transform:GetChild(0):GetComponent("MeshRenderer")
	local var_12_4 = var_12_2

	if arg_12_4 then
		var_12_4 = var_12_2 + 2
	end

	if arg_12_1 == PushBoxGameMgr.ElementType.WallLeft then
		var_12_4 = var_12_2 + 2
	elseif arg_12_1 == PushBoxGameMgr.ElementType.WallCornerTopLeft then
		var_12_4 = var_12_2 + 5 + 10000
	elseif arg_12_1 == PushBoxGameMgr.ElementType.WallCornerTopRight then
		var_12_4 = var_12_2 + 5 + 10000
	elseif arg_12_1 == PushBoxGameMgr.ElementType.WallCornerBottomLeft then
		var_12_4 = var_12_2 + 5 + 10000
	elseif arg_12_1 == PushBoxGameMgr.ElementType.WallCornerBottomRight then
		var_12_4 = var_12_2 + 5 + 10000
	end

	var_12_3.sortingOrder = var_12_4
end

function var_0_0.releaseBoxLight(arg_13_0)
	local var_13_0 = arg_13_0._game_mgr:getElementLogicList(PushBoxGameMgr.ElementType.Box)

	if var_13_0 then
		for iter_13_0, iter_13_1 in ipairs(var_13_0) do
			iter_13_1:hideLight()
		end
	end
end

function var_0_0._releaseCell(arg_14_0)
	if arg_14_0._cell_list then
		for iter_14_0, iter_14_1 in ipairs(arg_14_0._cell_list) do
			iter_14_1:releaseSelf()
		end

		arg_14_0._cell_list = nil
	end

	if arg_14_0._element_logic then
		for iter_14_2, iter_14_3 in pairs(arg_14_0._element_logic) do
			for iter_14_4, iter_14_5 in ipairs(iter_14_3) do
				iter_14_5:releaseSelf()
			end
		end

		arg_14_0._element_logic = nil
	end

	gohelper.destroyAllChildren(arg_14_0._floor_root)
	gohelper.destroyAllChildren(gohelper.findChild(arg_14_0._scene_root, "Root/ElementRoot"))
end

function var_0_0.releaseSelf(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._refreshBoxRender, arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._hideBoxSmoke, arg_15_0)
	arg_15_0:_releaseCell()
	arg_15_0:_releaseBoxTween()
	arg_15_0:__onDispose()
end

return var_0_0
