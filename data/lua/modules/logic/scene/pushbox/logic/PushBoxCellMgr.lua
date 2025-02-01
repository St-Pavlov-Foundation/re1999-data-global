module("modules.logic.scene.pushbox.logic.PushBoxCellMgr", package.seeall)

slot0 = class("PushBoxCellMgr", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0._game_mgr = slot1
	slot0._scene = slot1._scene
	slot0._scene_root = slot1._scene_root
end

function slot0.getCell(slot0, slot1, slot2)
	return slot0._cell_data[slot2] and slot0._cell_data[slot2][slot1]
end

function slot0.getElement(slot0, slot1, slot2, slot3)
	for slot7, slot8 in ipairs(slot0._element_logic[slot1]) do
		if slot8:getPosX() == slot2 and slot8:getPosY() == slot3 then
			return slot8
		end
	end
end

function slot0._refreshBoxRender(slot0)
	slot0._cur_push_box.transform:GetChild(0):GetComponent("MeshRenderer").sortingOrder = slot0._box_final_render_index + 3

	slot0:refreshBoxLight()
end

function slot0.refreshBoxLight(slot0)
	if slot0._game_mgr:getElementLogicList(PushBoxGameMgr.ElementType.Box) then
		for slot5, slot6 in ipairs(slot1) do
			if slot6:getObj() == slot0._cur_push_box then
				slot6:refreshLightRenderer(slot0._box_final_render_index)
			end
		end
	end
end

function slot0.pushBox(slot0, slot1, slot2, slot3, slot4)
	slot0:_releaseBoxTween()

	slot7 = slot0:getCell(slot3, slot4)
	slot8 = slot7:getTransform().position
	slot10 = slot7:getRendererIndex()
	slot0._box_final_render_index = slot10
	slot0._cur_push_box = gohelper.findChild(slot0._scene_root, "Root/ElementRoot/Box" .. slot2 .. "_" .. slot1)
	slot5.transform:GetChild(0):GetComponent("MeshRenderer").sortingOrder = (slot10 <= slot0:getCell(slot1, slot2):getRendererIndex() and slot9 or slot10) + 3
	slot0._box_tween = ZProj.TweenHelper.DOMove(slot5.transform, slot8.x, slot8.y, slot8.z, 0.2)

	TaskDispatcher.runDelay(slot0._refreshBoxRender, slot0, 0.2)
	slot7:setBox(true)
	slot6:setBox(false)

	slot5.name = "Box" .. slot4 .. "_" .. slot3

	slot0:detectCellData()

	slot12 = nil

	if slot1 < slot3 then
		slot12 = gohelper.findChild(slot5, "#smoke_box_right")
	elseif slot3 < slot1 then
		slot12 = gohelper.findChild(slot5, "#smoke_box_left")
	end

	if slot2 < slot4 then
		slot12 = gohelper.findChild(slot5, "#smoke_box_top")
	elseif slot4 < slot2 then
		slot12 = gohelper.findChild(slot5, "#smoke_box_down")
	end

	slot0:_hideBoxSmoke()

	for slot17 = 0, slot12:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem)).Length - 1 do
		ZProj.ParticleSystemHelper.SetSortingOrder(slot13[slot17], slot11)
	end

	gohelper.setActive(slot12, true)
	TaskDispatcher.cancelTask(slot0._hideBoxSmoke, slot0)
	TaskDispatcher.runDelay(slot0._hideBoxSmoke, slot0, 0.8)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_box_push)
end

function slot0._hideBoxSmoke(slot0)
	if slot0._cur_push_box then
		gohelper.setActive(gohelper.findChild(slot0._cur_push_box, "#smoke_box_left"), false)
		gohelper.setActive(gohelper.findChild(slot0._cur_push_box, "#smoke_box_right"), false)
		gohelper.setActive(gohelper.findChild(slot0._cur_push_box, "#smoke_box_top"), false)
		gohelper.setActive(gohelper.findChild(slot0._cur_push_box, "#smoke_box_down"), false)
	end
end

function slot0.detectCellData(slot0)
	if slot0._element_cell_dic and slot0._element_cell_dic[PushBoxGameMgr.ElementType.Mechanics] then
		for slot5, slot6 in ipairs(slot0._element_cell_dic[PushBoxGameMgr.ElementType.Mechanics]) do
			slot7 = false

			if slot6:getBox() then
				slot1 = 0 + 1
				slot7 = true
			end

			slot6:getElementLogic():refreshMechanicsState(slot7)
		end

		slot2 = slot1 == #slot0._element_cell_dic[PushBoxGameMgr.ElementType.Mechanics]

		for slot6, slot7 in ipairs(slot0._cell_list) do
			if slot0._game_mgr:typeIsDoor(slot7:getCellType()) then
				if slot2 and slot7.door_is_opened ~= slot2 then
					AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_door_open)
				end

				slot7.door_is_opened = slot2

				slot7:getElementLogic():refreshDoorState(slot2)
			end
		end
	end
end

function slot0._releaseBoxTween(slot0)
	if slot0._box_tween then
		ZProj.TweenHelper.KillById(slot0._box_tween)
	end

	slot0._box_tween = nil
end

function slot0.init(slot0)
	slot0._floor_root = gohelper.findChild(slot0._scene_root, "Root/FloorRoot")
	slot1 = slot0._game_mgr:getConfig()
	slot4 = GameUtil.splitString2(slot1.wall)
	slot0._cell_data = {}
	slot0._cell_list = {}
	slot0._element_cell_dic = {}
	slot0._element_logic = {}
	slot5 = 0

	for slot9 = 1, #GameUtil.splitString2(slot1.layout, true) do
		for slot13 = 1, #slot3[slot9] do
			slot0._cell_data[slot9] = slot0._cell_data[slot9] or {}
			slot0:_cloneCellObj(slot13, slot9).name = slot9 .. "_" .. slot13

			if slot3[slot9][slot13] == PushBoxGameMgr.ElementType.Empty then
				gohelper.setActive(slot15, false)
			end

			transformhelper.setLocalPos(slot15.transform, (slot13 - 4.5) * 2.5, (2.5 - slot9) * 1.54, 0)

			slot15.transform:GetChild(0):GetComponent("MeshRenderer").sortingOrder = slot5
			slot19 = PushBoxCellItem.New(slot0, slot0._scene:getSceneContainerGO(), slot15)
			slot0._cell_data[slot9][slot13] = slot19

			slot19:initData(slot14, slot13, slot9)

			slot0._element_logic[slot20] = slot0._element_logic[slot19:getCellType()] or {}

			if slot19:initElement(slot14) then
				table.insert(slot0._element_logic[slot20], slot21)

				if slot19:getBox() then
					slot0._element_logic[slot14] = slot0._element_logic[slot14] or {}

					table.insert(slot0._element_logic[slot14], slot21)
				end
			end

			slot0._element_cell_dic[slot20] = slot0._element_cell_dic[slot20] or {}

			table.insert(slot0._element_cell_dic[slot20], slot19)
			table.insert(slot0._cell_list, slot19)

			if slot14 == PushBoxGameMgr.ElementType.Character then
				slot0._game_mgr:setCharacterPos(slot13, slot9, PushBoxGameMgr.Direction.Down)
			end

			for slot28, slot29 in ipairs(string.splitToNumber(slot4[slot9][slot13], "_")) do
				if slot29 ~= 0 then
					slot0:_setWallRenderer(slot29, slot15, slot5, slot14 == PushBoxGameMgr.ElementType.Goal)
				end
			end

			slot5 = slot5 + 100
		end
	end
end

function slot0._cloneCellObj(slot0, slot1, slot2)
	slot3 = nil

	return (slot1 % 2 == 0 or (slot2 % 2 == 0 or gohelper.clone(gohelper.findChild(slot0._scene_root, "Root/OriginElement/" .. PushBoxGameMgr.ElementType.Road), slot0._floor_root)) and gohelper.clone(gohelper.findChild(slot0._scene_root, "Root/OriginElement/diban_b"), slot0._floor_root)) and (slot2 % 2 == 0 or gohelper.clone(gohelper.findChild(slot0._scene_root, "Root/OriginElement/diban_c"), slot0._floor_root)) and gohelper.clone(gohelper.findChild(slot0._scene_root, "Root/OriginElement/diban_d"), slot0._floor_root)
end

function slot0._setWallRenderer(slot0, slot1, slot2, slot3, slot4)
	slot5 = gohelper.clone(gohelper.findChild(slot0._scene_root, "Root/OriginElement/" .. slot1), slot0._floor_root, "Wall")
	slot6 = slot2.transform.position

	transformhelper.setPos(slot5.transform, slot6.x, slot6.y, slot6.z)

	slot8 = slot5.transform:GetChild(0):GetComponent("MeshRenderer")
	slot9 = slot3 + 10000

	if slot4 then
		slot9 = slot7 + 2
	end

	if slot1 == PushBoxGameMgr.ElementType.WallLeft then
		slot9 = slot7 + 2
	elseif slot1 == PushBoxGameMgr.ElementType.WallCornerTopLeft then
		slot9 = slot7 + 5 + 10000
	elseif slot1 == PushBoxGameMgr.ElementType.WallCornerTopRight then
		slot9 = slot7 + 5 + 10000
	elseif slot1 == PushBoxGameMgr.ElementType.WallCornerBottomLeft then
		slot9 = slot7 + 5 + 10000
	elseif slot1 == PushBoxGameMgr.ElementType.WallCornerBottomRight then
		slot9 = slot7 + 5 + 10000
	end

	slot8.sortingOrder = slot9
end

function slot0.releaseBoxLight(slot0)
	if slot0._game_mgr:getElementLogicList(PushBoxGameMgr.ElementType.Box) then
		for slot5, slot6 in ipairs(slot1) do
			slot6:hideLight()
		end
	end
end

function slot0._releaseCell(slot0)
	if slot0._cell_list then
		for slot4, slot5 in ipairs(slot0._cell_list) do
			slot5:releaseSelf()
		end

		slot0._cell_list = nil
	end

	if slot0._element_logic then
		for slot4, slot5 in pairs(slot0._element_logic) do
			for slot9, slot10 in ipairs(slot5) do
				slot10:releaseSelf()
			end
		end

		slot0._element_logic = nil
	end

	gohelper.destroyAllChildren(slot0._floor_root)
	gohelper.destroyAllChildren(gohelper.findChild(slot0._scene_root, "Root/ElementRoot"))
end

function slot0.releaseSelf(slot0)
	TaskDispatcher.cancelTask(slot0._refreshBoxRender, slot0)
	TaskDispatcher.cancelTask(slot0._hideBoxSmoke, slot0)
	slot0:_releaseCell()
	slot0:_releaseBoxTween()
	slot0:__onDispose()
end

return slot0
