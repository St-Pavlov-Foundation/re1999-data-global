module("modules.logic.fight.view.FightSkillSelectOutline", package.seeall)

slot0 = class("FightSkillSelectOutline", BaseView)
slot1 = "_OutlineWidth"
slot2 = "buff/buff_outline"

function slot0.onInitView(slot0)
end

function slot0.onOpen(slot0)
	slot0._effectWrapDict = {}
	slot0._matDict = slot0:getUserDataTb_()
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStageChange, slot0._onStageChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.AutoToSelectSkillTarget, slot0._hideOutlineEffect, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SelectSkillTarget, slot0._onSelectSkillTarget, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.BeforeEntityDestroy, slot0._beforeEntityDestroy, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnCameraFocusChanged, slot0._onCameraFocusChanged, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseView, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnStageChange, slot0._onStageChange, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.AutoToSelectSkillTarget, slot0._hideOutlineEffect, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.SelectSkillTarget, slot0._onSelectSkillTarget, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.BeforeEntityDestroy, slot0._beforeEntityDestroy, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnCameraFocusChanged, slot0._onCameraFocusChanged, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.onOpenView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseView, slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0._onStageChange(slot0, slot1)
	if slot1 == FightEnum.Stage.ClothSkill then
		return
	end

	if slot1 ~= FightEnum.Stage.Card then
		slot0:_hideOutlineEffect()
	end
end

function slot0._onSkillPlayStart(slot0)
	slot0:_hideOutlineEffect()
end

function slot0._onCameraFocusChanged(slot0, slot1)
	if slot1 then
		slot0:_hideOutlineEffect()
	else
		slot0:_onSelectSkillTarget(FightCardModel.instance.curSelectEntityId)
	end
end

function slot0.onOpenView(slot0, slot1)
	if slot1 == ViewName.FightEnemyActionView then
		slot0:_hideOutlineEffect()
	end
end

function slot0.onCloseView(slot0, slot1)
	if slot1 == ViewName.FightEnemyActionView then
		slot0:_onSelectSkillTarget(FightCardModel.instance.curSelectEntityId)
	end
end

function slot0._beforeEntityDestroy(slot0, slot1)
	slot2 = slot1 and slot1.id

	if slot2 and slot0._effectWrapDict[slot2] then
		slot0._effectWrapDict[slot2] = nil
	end
end

function slot0._hideOutlineEffect(slot0)
	for slot4, slot5 in pairs(slot0._effectWrapDict) do
		if not gohelper.isNil(slot5.containerGO) then
			slot5:setActive(false)
		else
			FightRenderOrderMgr.instance:onRemoveEffectWrap(slot4, slot5)

			slot0._effectWrapDict[slot4] = nil
		end
	end
end

function slot0._onSelectSkillTarget(slot0, slot1)
	if FightModel.instance:isAuto() then
		return
	end

	if FightReplayModel.instance:isReplay() then
		return
	end

	if not slot0._effectWrapDict[slot1] and FightHelper.getEntity(slot1) and slot3.effect then
		slot4 = slot3.effect:addHangEffect(uv0, ModuleEnum.SpineHangPointRoot, nil, , , true)

		slot4:setLocalPos(0, 0, 0)

		if gohelper.isNil(slot4.effectGO) then
			slot4:setCallback(function ()
				uv0:_setOutlineWidth(uv1)
			end)
		else
			slot0:_setOutlineWidth(slot1)
		end

		slot0._effectWrapDict[slot1] = slot4

		FightRenderOrderMgr.instance:onAddEffectWrap(slot1, slot4)
	end

	for slot6, slot7 in pairs(slot0._effectWrapDict) do
		if not gohelper.isNil(slot7.containerGO) then
			slot7:setActive(slot6 == slot1)

			if slot6 == slot1 then
				slot0:_setOutlineWidth(slot6)
			end
		else
			FightRenderOrderMgr.instance:onRemoveEffectWrap(slot6, slot7)

			slot0._effectWrapDict[slot1] = nil
		end
	end
end

function slot0._setOutlineWidth(slot0, slot1)
	if not slot0._matDict[slot1] and slot0._effectWrapDict[slot1] and not gohelper.isNil(slot3.effectGO) then
		if gohelper.findChildComponent(slot3.effectGO, "diamond/root/diamond", typeof(UnityEngine.Renderer)) then
			if slot4.material then
				slot0._matDict[slot1] = slot2

				if not slot0._defaultOutlineWidth then
					slot0._defaultOutlineWidth = slot2:GetFloat(uv0)
				end
			else
				logError("outline material not found")
			end
		else
			logError("outline render not found")
		end
	end

	if slot2 then
		slot4 = FightDataHelper.entityMgr:getById(slot1) and slot3.skin and lua_monster_skin.configDict[slot3.skin]

		if slot4 and slot4.outlineWidth and slot5 > 0 then
			slot2:SetFloat(uv0, slot5)
		else
			slot2:SetFloat(uv0, slot0._defaultOutlineWidth)
		end
	end
end

return slot0
