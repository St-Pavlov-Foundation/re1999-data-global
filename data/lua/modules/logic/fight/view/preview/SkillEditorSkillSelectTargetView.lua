module("modules.logic.fight.view.preview.SkillEditorSkillSelectTargetView", package.seeall)

slot0 = class("SkillEditorSkillSelectTargetView", BaseView)

function slot0.ctor(slot0, slot1)
	slot0._side = slot1
end

function slot0.onInitView(slot0)
	slot1 = slot0._side == FightEnum.EntitySide.MySide and "right" or "left"
	slot2 = gohelper.findChild(slot0.viewGO, slot1)
	slot0._containerGO = gohelper.findChild(slot2, "skillSelect")
	slot0._containerTr = slot0._containerGO.transform
	slot0._imgSelectGO = gohelper.findChild(slot2, "skillSelect/imgSkillSelect")
	slot0._imgSelectTr = slot0._imgSelectGO.transform
	slot0._clickGOArr = {
		gohelper.findChild(slot2, "skillSelect/click")
	}

	gohelper.setActive(slot0._imgSelectGO, false)
	slot0:_updateClickPos()
	slot0:_updateSelectUI()
	gohelper.addChild(ViewMgr.instance:getUILayer(UILayerName.Hud), slot0._containerGO)
	gohelper.setAsFirstSibling(slot0._containerGO)

	slot0._containerGO.name = "skillSelect" .. slot1
end

function slot0.onDestroyView(slot0)
	gohelper.destroy(slot0._containerGO)
end

function slot0.addEvents(slot0)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	TaskDispatcher.runRepeat(slot0._onSecond, slot0, 3)
end

function slot0.removeEvents(slot0)
	for slot4, slot5 in ipairs(slot0._clickGOArr) do
		SLFramework.UGUI.UIClickListener.Get(slot5):RemoveClickListener()
		SLFramework.UGUI.UILongPressListener.Get(slot5):RemoveLongPressListener()
	end

	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	TaskDispatcher.cancelTask(slot0._onSecond, slot0)
	TaskDispatcher.cancelTask(slot0._hideSelectGO, slot0)
end

function slot0._onSkillPlayStart(slot0)
	gohelper.setActive(slot0._containerGO, false)
end

function slot0._onSkillPlayFinish(slot0)
	gohelper.setActive(slot0._containerGO, true)
end

function slot0._onSecond(slot0)
	slot0:_updateClickPos()
end

function slot0._onSpineLoaded(slot0)
	slot0:_updateClickPos()
end

function slot0._updateSelectUI(slot0)
	gohelper.setActive(slot0._imgSelectGO, FightHelper.getEntity(FightDataHelper.entityMgr:getByPosId(slot0._side, SkillEditorView.selectPosId[slot0._side]) and slot2.id or 0) ~= nil)

	if slot3 then
		slot4, slot5 = slot0:_getEntityMiddlePos(slot3)

		recthelper.setAnchor(slot0._imgSelectTr, slot4, slot5)
	else
		SkillEditorView.selectPosId[slot0._side] = 1

		gohelper.setActive(slot0._imgSelectGO, FightHelper.getEntity(FightDataHelper.entityMgr:getByPosId(slot0._side, 1) and slot2.id or 0) ~= nil)

		if slot3 then
			slot4, slot5 = slot0:_getEntityMiddlePos(slot3)

			recthelper.setAnchor(slot0._imgSelectTr, slot4, slot5)
		end
	end

	TaskDispatcher.cancelTask(slot0._hideSelectGO, slot0)
	TaskDispatcher.runDelay(slot0._hideSelectGO, slot0, 0.5)
end

function slot0._getEntityMiddlePos(slot0, slot1)
	if FightHelper.isAssembledMonster(slot1) then
		slot3 = lua_fight_assembled_monster.configDict[slot1:getMO().skin]
		slot4 = slot1.go.transform.position
		slot5 = recthelper.worldPosToAnchorPos(Vector3.New(slot4.x + slot3.selectPos[1], slot4.y + slot3.selectPos[2], slot4.z), slot0._containerTr)

		return slot5.x, slot5.y
	end

	if slot0:_getHangPointObj(slot1, ModuleEnum.SpineHangPoint.mountmiddle) and slot2.name == ModuleEnum.SpineHangPoint.mountmiddle then
		slot4 = recthelper.worldPosToAnchorPos(Vector3.New(transformhelper.getPos(slot2.transform)), slot0._containerTr)

		return slot4.x, slot4.y
	else
		slot3, slot4 = slot0:_calcRect(slot1)

		return (slot3.x + slot4.x) / 2, (slot3.y + slot4.y) / 2
	end
end

function slot0._hideSelectGO(slot0)
	gohelper.setActive(slot0._imgSelectGO, false)
end

function slot0._updateClickPos(slot0)
	slot1 = {}

	FightDataHelper.entityMgr:getNormalList(slot0._side, slot1)
	FightDataHelper.entityMgr:getSubList(slot0._side, slot1)

	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if not slot0._clickGOArr[slot6] then
			table.insert(slot0._clickGOArr, gohelper.clone(slot0._clickGOArr[1], slot0._containerGO, "click" .. slot6))
		end

		gohelper.setActive(slot8, true)

		if FightHelper.getEntity(slot7.id) then
			slot10, slot11 = slot0:_calcRect(slot9)
			slot12 = slot8.transform

			recthelper.setAnchor(slot12, (slot10.x + slot11.x) / 2, (slot10.y + slot11.y) / 2)
			recthelper.setSize(slot12, math.abs(slot10.x - slot11.x), math.abs(slot10.y - slot11.y))
			SLFramework.UGUI.UIClickListener.Get(slot8):AddClickListener(slot0._onClick, slot0, slot7.id)

			if isTypeOf(FightHelper.getEntity(slot7.id), FightEntityAssembledMonsterMain) or isTypeOf(slot13, FightEntityAssembledMonsterSub) then
				table.insert(slot2, {
					entity = slot13,
					clickTr = slot12,
					clickGO = slot8
				})
			end

			slot14 = SLFramework.UGUI.UILongPressListener.Get(slot8)

			slot14:AddLongPressListener(slot0._onLongPress, slot0, slot7.id)
			slot14:SetLongPressTime({
				0.5,
				99999
			})
		end
	end

	for slot6 = #slot1 + 1, #slot0._clickGOArr do
		gohelper.setActive(slot0._clickGOArr[slot6], false)
	end

	if #slot2 > 0 then
		slot0:_dealAssembledMonsterClick(slot2)
	end
end

function slot0.sortAssembledMonster(slot0, slot1)
	return lua_fight_assembled_monster.configDict[slot0.entity:getMO().skin].clickIndex < lua_fight_assembled_monster.configDict[slot1.entity:getMO().skin].clickIndex
end

function slot0._dealAssembledMonsterClick(slot0, slot1)
	table.sort(slot1, uv0.sortAssembledMonster)

	for slot5, slot6 in ipairs(slot1) do
		gohelper.setAsLastSibling(slot6.clickGO)

		slot8 = lua_fight_assembled_monster.configDict[slot6.entity:getMO().skin]
		slot9 = slot6.entity.go.transform.position
		slot9 = Vector3.New(slot9.x + slot8.virtualSpinePos[1], slot9.y + slot8.virtualSpinePos[2], slot9.z + slot8.virtualSpinePos[3])
		slot10 = recthelper.worldPosToAnchorPos(slot9, slot0._containerTr)

		recthelper.setAnchor(slot6.clickTr, slot10.x, slot10.y)

		slot11 = slot8.virtualSpineSize[1] * 0.5
		slot12 = slot8.virtualSpineSize[2] * 0.5
		slot15 = recthelper.worldPosToAnchorPos(Vector3.New(slot9.x - slot11, slot9.y - slot12, slot9.z), slot0._containerTr)
		slot16 = recthelper.worldPosToAnchorPos(Vector3.New(slot9.x + slot11, slot9.y + slot12, slot9.z), slot0._containerTr)

		recthelper.setSize(slot6.clickTr, slot16.x - slot15.x, slot16.y - slot15.y)
	end
end

function slot0._calcRect(slot0, slot1)
	slot3 = slot0:_getHangPointObj(slot1, ModuleEnum.SpineHangPoint.BodyStatic).transform.position
	slot4, slot5 = FightHelper.getEntityBoxSizeOffsetV2(slot1)
	slot6 = slot1:isMySide() and 1 or -1

	return recthelper.worldPosToAnchorPos(Vector3.New(slot3.x - slot4.x * 0.5, slot3.y - slot4.y * 0.5 * slot6, slot3.z), slot0._containerTr), recthelper.worldPosToAnchorPos(Vector3.New(slot3.x + slot4.x * 0.5, slot3.y + slot4.y * 0.5 * slot6, slot3.z), slot0._containerTr)
end

function slot0._getHangPointObj(slot0, slot1, slot2)
	return FightDataHelper.entityMgr:isSub(slot1:getMO().uid) and slot1.go or slot1:getHangPoint(slot2)
end

function slot0._onClick(slot0, slot1)
	slot3 = FightDataHelper.entityMgr:getById(slot1)

	SkillEditorView.setSelectPosId(slot0._side, slot3.position)

	SkillEditorMgr.instance.cur_select_entity_id = slot1
	SkillEditorMgr.instance.cur_select_side = GameSceneMgr.instance:getCurScene().entityMgr:getEntity(SkillEditorMgr.instance.cur_select_entity_id):getSide()

	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnSelectEntity, SkillEditorMgr.instance.cur_select_side, slot1)
	slot0:_updateSelectUI()

	if slot3.position == SkillEditorView.selectPosId[slot0._side] and slot0._lastClickTime and Time.time - slot0._lastClickTime < 0.5 then
		SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.ShowHeroSelectView, slot0._side, slot3.position)
	end

	slot0._lastClickTime = Time.time
end

function slot0._onLongPress(slot0, slot1)
	if FightDataHelper.entityMgr:getById(slot1) then
		ViewMgr.instance:openView(ViewName.FightFocusView, {
			entityId = slot2.id
		})
	end
end

return slot0
