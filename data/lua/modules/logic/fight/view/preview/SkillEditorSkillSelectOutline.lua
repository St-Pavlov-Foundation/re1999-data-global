module("modules.logic.fight.view.preview.SkillEditorSkillSelectOutline", package.seeall)

slot0 = class("SkillEditorSkillSelectOutline", BaseView)
slot1 = "buff/buff_outline"

function slot0.onInitView(slot0)
	slot0._effectWrapDict = {}
	slot0._enableOutline = false
end

function slot0.addEvents(slot0)
	slot0:addEventCb(SkillEditorMgr.instance, SkillEditorMgr.OnSelectEntity, slot0._onSelectEntity, slot0)
	slot0:addEventCb(SkillEditorMgr.instance, SkillEditorMgr.OnClickOutline, slot0._onClickOutline, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.BeforeEntityDestroy, slot0._beforeEntityDestroy, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(SkillEditorMgr.instance, SkillEditorMgr.OnSelectEntity, slot0._onSelectEntity, slot0)
	slot0:removeEventCb(SkillEditorMgr.instance, SkillEditorMgr.OnClickOutline, slot0._onClickOutline, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.BeforeEntityDestroy, slot0._beforeEntityDestroy, slot0)
end

function slot0._beforeEntityDestroy(slot0, slot1)
	slot2 = slot1 and slot1.id

	if slot2 and slot0._effectWrapDict[slot2] then
		slot0._effectWrapDict[slot2] = nil
	end
end

function slot0._onClickOutline(slot0)
	slot0._enableOutline = not slot0._enableOutline

	if slot0._enableOutline then
		slot0:_updateOutline()
	else
		for slot4, slot5 in pairs(slot0._effectWrapDict) do
			if not gohelper.isNil(slot5.containerGO) then
				slot5:setActive(false)
			else
				FightRenderOrderMgr.instance:onRemoveEffectWrap(slot4, slot5)

				slot0._effectWrapDict[slot4] = nil
			end
		end
	end
end

function slot0._onSpineLoaded(slot0, slot1, slot2)
	TaskDispatcher.cancelTask(slot0._refreshOnLoad, slot0)
	TaskDispatcher.runDelay(slot0._refreshOnLoad, slot0, 0.1)
end

function slot0._refreshOnLoad(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0._effectWrapDict) do
		if not gohelper.isNil(slot7.containerGO) and slot7.containerGO.activeSelf then
			slot7:setActive(false)
			slot7:setActive(true)
		end
	end
end

function slot0._onSelectEntity(slot0, slot1, slot2)
	if not slot0._enableOutline then
		return
	end

	if slot1 ~= FightEnum.EntitySide.EnemySide then
		return
	end

	slot0:_updateOutline()
end

function slot0._updateOutline(slot0)
	slot2 = GameSceneMgr.instance:getCurScene().entityMgr:getEntityByPosId(SceneTag.UnitMonster, SkillEditorView.selectPosId[FightEnum.EntitySide.EnemySide]).id
	slot3 = FightHelper.getEntity(slot2)

	if not slot0._effectWrapDict[slot2] and FightHelper.getEntity(slot2) and slot5.effect then
		slot6 = slot5.effect:addHangEffect(uv0, ModuleEnum.SpineHangPointRoot, nil, , , true)

		slot6:setLocalPos(0, 0, 0)

		slot0._effectWrapDict[slot2] = slot6

		FightRenderOrderMgr.instance:onAddEffectWrap(slot2, slot6)
	end

	for slot8, slot9 in pairs(slot0._effectWrapDict) do
		if not gohelper.isNil(slot9.containerGO) then
			slot9:setActive(slot8 == slot2)
		else
			FightRenderOrderMgr.instance:onRemoveEffectWrap(slot8, slot9)

			slot0._effectWrapDict[slot2] = nil
		end
	end
end

return slot0
