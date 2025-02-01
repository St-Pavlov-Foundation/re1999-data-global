module("modules.logic.scene.pushbox.logic.PushBoxCellItem", package.seeall)

slot0 = class("PushBoxCellItem", UserDataDispose)

function slot0.ctor(slot0, slot1, slot2, slot3)
	slot0:__onInit()

	slot0._cell_mgr = slot1
	slot0._scene_root = slot2
	slot0._cell_obj = slot3
	slot0._cell_transform = slot3.transform
	slot0._element_root = gohelper.findChild(slot2, "Root/ElementRoot")
end

function slot0.getCellObj(slot0)
	return slot0._cell_obj
end

function slot0.getRendererIndex(slot0)
	return slot0._cell_obj.transform:GetChild(0):GetComponent("MeshRenderer").sortingOrder + 2 + 20000
end

function slot0.characterInArea(slot0)
	slot0._cell_mgr._game_mgr:characterInArea(slot0:getPosX(), slot0:getPosY())
end

function slot0.doorIsOpend(slot0)
	return slot0.door_is_opened
end

function slot0.getTransform(slot0)
	return slot0._cell_transform
end

function slot0.getPosX(slot0)
	return slot0._pos_x
end

function slot0.getPosY(slot0)
	return slot0._pos_y
end

function slot0.getCellType(slot0)
	return slot0._cell_type
end

function slot0.setBox(slot0, slot1)
	slot0._box = slot1
end

function slot0.getBox(slot0)
	return slot0._box
end

function slot0.initData(slot0, slot1, slot2, slot3)
	slot0._pos_x = slot2
	slot0._pos_y = slot3
	slot0._cell_type = slot1

	if slot1 == PushBoxGameMgr.ElementType.Box then
		slot0._box = true
		slot0._cell_type = PushBoxGameMgr.ElementType.Road
	end
end

function slot0.initElement(slot0, slot1)
	slot2, slot3 = nil

	if slot1 == PushBoxGameMgr.ElementType.Goal then
		slot2 = gohelper.create3d(slot0._element_root, "Door" .. slot0._pos_y .. "_" .. slot0._pos_x)

		gohelper.clone(gohelper.findChild(slot0._scene_root, "Root/OriginElement/" .. PushBoxGameMgr.ElementType.Goal), slot2, "Close")
		gohelper.setActive(gohelper.clone(gohelper.findChild(slot0._scene_root, "Root/OriginElement/DoorOpen"), slot2, "Open"), false)
		PushBoxElementDoor.New(slot2, slot0):setRendererIndex()
	elseif slot1 == PushBoxGameMgr.ElementType.Box then
		slot2 = gohelper.clone(gohelper.findChild(slot0._scene_root, "Root/OriginElement/" .. slot1), slot0._element_root, "Box" .. slot0._pos_y .. "_" .. slot0._pos_x)
		slot2.transform:GetChild(0):GetComponent("MeshRenderer").sortingOrder = slot0:getRendererIndex() + 3
		slot3 = PushBoxElementBox.New(slot2, slot0)
	elseif slot0._cell_mgr._game_mgr:typeIsEnemy(slot1) then
		slot2 = gohelper.create3d(slot0._element_root, "Enemy")

		gohelper.clone(gohelper.findChild(slot0._scene_root, "Root/OriginElement/EnemyUp"), slot2, PushBoxGameMgr.Direction.Up)
		gohelper.clone(gohelper.findChild(slot0._scene_root, "Root/OriginElement/EnemyDown"), slot2, PushBoxGameMgr.Direction.Down)
		gohelper.clone(gohelper.findChild(slot0._scene_root, "Root/OriginElement/EnemyLeft"), slot2, PushBoxGameMgr.Direction.Left)
		gohelper.clone(gohelper.findChild(slot0._scene_root, "Root/OriginElement/EnemyRight"), slot2, PushBoxGameMgr.Direction.Right)
		PushBoxElementEnemy.New(slot2, slot0):setRendererIndex()
	elseif slot1 == PushBoxGameMgr.ElementType.Mechanics then
		slot2 = gohelper.create3d(slot0._element_root, "Mechanics" .. slot0._pos_y .. "_" .. slot0._pos_x)

		gohelper.clone(gohelper.findChild(slot0._scene_root, "Root/OriginElement/" .. PushBoxGameMgr.ElementType.Mechanics), slot2, "Normal")
		gohelper.setActive(gohelper.clone(gohelper.findChild(slot0._scene_root, "Root/OriginElement/EnabledMechanics"), slot2, "Enabled"), false)
		PushBoxElementMechanics.New(slot2, slot0):setRendererIndex()
	elseif slot1 == PushBoxGameMgr.ElementType.Fan then
		PushBoxElementFan.New(gohelper.clone(gohelper.findChild(slot0._scene_root, "Root/OriginElement/" .. slot1), slot0._element_root, "Fan"), slot0):setRendererIndex()
	elseif slot0._cell_mgr._game_mgr:typeIsLight(slot1) then
		PushBoxElementLight.New(gohelper.clone(gohelper.findChild(slot0._scene_root, "Root/OriginElement/" .. slot1), slot0._element_root, "Light" .. slot1), slot0):setRendererIndex()
	end

	if slot2 then
		gohelper.setActive(slot2, true)

		slot4 = slot0:getTransform().position

		transformhelper.setPos(slot2.transform, slot4.x, slot4.y, slot4.z)

		slot0._element_obj = slot2
	end

	slot0._element_logic = slot3

	return slot3
end

function slot0.getElementLogic(slot0)
	return slot0._element_logic
end

function slot0.setCellInvincible(slot0, slot1)
	slot0._invincible = slot1
end

function slot0.getInvincible(slot0)
	return slot0._invincible
end

function slot0.releaseSelf(slot0)
	slot0:__onDispose()

	slot0._element_logic = nil
end

return slot0
