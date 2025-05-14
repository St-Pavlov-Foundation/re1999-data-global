module("modules.logic.scene.pushbox.logic.PushBoxCellItem", package.seeall)

local var_0_0 = class("PushBoxCellItem", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0:__onInit()

	arg_1_0._cell_mgr = arg_1_1
	arg_1_0._scene_root = arg_1_2
	arg_1_0._cell_obj = arg_1_3
	arg_1_0._cell_transform = arg_1_3.transform
	arg_1_0._element_root = gohelper.findChild(arg_1_2, "Root/ElementRoot")
end

function var_0_0.getCellObj(arg_2_0)
	return arg_2_0._cell_obj
end

function var_0_0.getRendererIndex(arg_3_0)
	return arg_3_0._cell_obj.transform:GetChild(0):GetComponent("MeshRenderer").sortingOrder + 2 + 20000
end

function var_0_0.characterInArea(arg_4_0)
	arg_4_0._cell_mgr._game_mgr:characterInArea(arg_4_0:getPosX(), arg_4_0:getPosY())
end

function var_0_0.doorIsOpend(arg_5_0)
	return arg_5_0.door_is_opened
end

function var_0_0.getTransform(arg_6_0)
	return arg_6_0._cell_transform
end

function var_0_0.getPosX(arg_7_0)
	return arg_7_0._pos_x
end

function var_0_0.getPosY(arg_8_0)
	return arg_8_0._pos_y
end

function var_0_0.getCellType(arg_9_0)
	return arg_9_0._cell_type
end

function var_0_0.setBox(arg_10_0, arg_10_1)
	arg_10_0._box = arg_10_1
end

function var_0_0.getBox(arg_11_0)
	return arg_11_0._box
end

function var_0_0.initData(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0._pos_x = arg_12_2
	arg_12_0._pos_y = arg_12_3
	arg_12_0._cell_type = arg_12_1

	if arg_12_1 == PushBoxGameMgr.ElementType.Box then
		arg_12_0._box = true
		arg_12_0._cell_type = PushBoxGameMgr.ElementType.Road
	end
end

function var_0_0.initElement(arg_13_0, arg_13_1)
	local var_13_0
	local var_13_1

	if arg_13_1 == PushBoxGameMgr.ElementType.Goal then
		var_13_0 = gohelper.create3d(arg_13_0._element_root, "Door" .. arg_13_0._pos_y .. "_" .. arg_13_0._pos_x)

		gohelper.clone(gohelper.findChild(arg_13_0._scene_root, "Root/OriginElement/" .. PushBoxGameMgr.ElementType.Goal), var_13_0, "Close")

		local var_13_2 = gohelper.clone(gohelper.findChild(arg_13_0._scene_root, "Root/OriginElement/DoorOpen"), var_13_0, "Open")

		gohelper.setActive(var_13_2, false)

		var_13_1 = PushBoxElementDoor.New(var_13_0, arg_13_0)

		var_13_1:setRendererIndex()
	elseif arg_13_1 == PushBoxGameMgr.ElementType.Box then
		var_13_0 = gohelper.clone(gohelper.findChild(arg_13_0._scene_root, "Root/OriginElement/" .. arg_13_1), arg_13_0._element_root, "Box" .. arg_13_0._pos_y .. "_" .. arg_13_0._pos_x)
		var_13_0.transform:GetChild(0):GetComponent("MeshRenderer").sortingOrder = arg_13_0:getRendererIndex() + 3
		var_13_1 = PushBoxElementBox.New(var_13_0, arg_13_0)
	elseif arg_13_0._cell_mgr._game_mgr:typeIsEnemy(arg_13_1) then
		var_13_0 = gohelper.create3d(arg_13_0._element_root, "Enemy")

		gohelper.clone(gohelper.findChild(arg_13_0._scene_root, "Root/OriginElement/EnemyUp"), var_13_0, PushBoxGameMgr.Direction.Up)
		gohelper.clone(gohelper.findChild(arg_13_0._scene_root, "Root/OriginElement/EnemyDown"), var_13_0, PushBoxGameMgr.Direction.Down)
		gohelper.clone(gohelper.findChild(arg_13_0._scene_root, "Root/OriginElement/EnemyLeft"), var_13_0, PushBoxGameMgr.Direction.Left)
		gohelper.clone(gohelper.findChild(arg_13_0._scene_root, "Root/OriginElement/EnemyRight"), var_13_0, PushBoxGameMgr.Direction.Right)

		var_13_1 = PushBoxElementEnemy.New(var_13_0, arg_13_0)

		var_13_1:setRendererIndex()
	elseif arg_13_1 == PushBoxGameMgr.ElementType.Mechanics then
		var_13_0 = gohelper.create3d(arg_13_0._element_root, "Mechanics" .. arg_13_0._pos_y .. "_" .. arg_13_0._pos_x)

		gohelper.clone(gohelper.findChild(arg_13_0._scene_root, "Root/OriginElement/" .. PushBoxGameMgr.ElementType.Mechanics), var_13_0, "Normal")

		local var_13_3 = gohelper.clone(gohelper.findChild(arg_13_0._scene_root, "Root/OriginElement/EnabledMechanics"), var_13_0, "Enabled")

		gohelper.setActive(var_13_3, false)

		var_13_1 = PushBoxElementMechanics.New(var_13_0, arg_13_0)

		var_13_1:setRendererIndex()
	elseif arg_13_1 == PushBoxGameMgr.ElementType.Fan then
		var_13_0 = gohelper.clone(gohelper.findChild(arg_13_0._scene_root, "Root/OriginElement/" .. arg_13_1), arg_13_0._element_root, "Fan")
		var_13_1 = PushBoxElementFan.New(var_13_0, arg_13_0)

		var_13_1:setRendererIndex()
	elseif arg_13_0._cell_mgr._game_mgr:typeIsLight(arg_13_1) then
		var_13_0 = gohelper.clone(gohelper.findChild(arg_13_0._scene_root, "Root/OriginElement/" .. arg_13_1), arg_13_0._element_root, "Light" .. arg_13_1)
		var_13_1 = PushBoxElementLight.New(var_13_0, arg_13_0)

		var_13_1:setRendererIndex()
	end

	if var_13_0 then
		gohelper.setActive(var_13_0, true)

		local var_13_4 = arg_13_0:getTransform().position

		transformhelper.setPos(var_13_0.transform, var_13_4.x, var_13_4.y, var_13_4.z)

		arg_13_0._element_obj = var_13_0
	end

	arg_13_0._element_logic = var_13_1

	return var_13_1
end

function var_0_0.getElementLogic(arg_14_0)
	return arg_14_0._element_logic
end

function var_0_0.setCellInvincible(arg_15_0, arg_15_1)
	arg_15_0._invincible = arg_15_1
end

function var_0_0.getInvincible(arg_16_0)
	return arg_16_0._invincible
end

function var_0_0.releaseSelf(arg_17_0)
	arg_17_0:__onDispose()

	arg_17_0._element_logic = nil
end

return var_0_0
