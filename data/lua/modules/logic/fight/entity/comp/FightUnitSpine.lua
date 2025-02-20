module("modules.logic.fight.entity.comp.FightUnitSpine", package.seeall)

slot0 = class("FightUnitSpine", UnitSpine)

function slot0._onResLoaded(slot0, slot1)
	if gohelper.isNil(slot0._gameObj) then
		return
	end

	uv0.super._onResLoaded(slot0, slot1)
end

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)
	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	FightController.instance:registerCallback(FightEvent.SkillEditorRefreshBuff, slot0.detectRefreshAct, slot0)
end

function slot0.play(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0.lockAct then
		return
	end

	if not slot4 then
		slot1 = FightHelper.processEntityActionName(slot0.unitSpawn, slot1, slot5)
	end

	if slot0:_cannotPlay(slot1) then
		slot0:_onAnimCallback(slot1, SpineAnimEvent.ActionComplete)

		return
	end

	if slot0._tran_to_ani == slot1 then
		return
	else
		slot0._tran_to_ani = nil
	end

	slot6, slot7 = FightHelper.needPlayTransitionAni(slot0.unitSpawn, slot1)

	if slot6 then
		if slot7 == "0" then
			slot0:setAnimation(slot1, slot2)

			return
		elseif slot7 == "-1" then
			slot0:_onAnimCallback(slot1, SpineAnimEvent.ActionComplete)

			return
		else
			slot0._tran_to_ani = slot1
			slot0._tran_loop = slot2
			slot0._tran_reStart = slot3
			slot0._tran_ani = slot7

			slot0:addAnimEventCallback(slot0._onTransitionAnimEvent, slot0)
			uv0.super.play(slot0, slot0._tran_ani, false, true)

			return
		end
	end

	slot0._tran_ani = nil

	uv0.super.play(slot0, slot1, slot2, slot3)
end

function slot0._onTransitionAnimEvent(slot0, slot1, slot2, slot3)
	if slot1 == slot0._tran_ani and slot2 == SpineAnimEvent.ActionComplete then
		slot0:removeAnimEventCallback(slot0._onTransitionAnimEvent, slot0)
		uv0.super.play(slot0, slot0._tran_to_ani, slot0._tran_loop, slot0._tran_reStart)

		slot0._tran_to_ani = nil
	end
end

function slot0.tryPlay(slot0, slot1, slot2, slot3)
	if not slot0:hasAnimation(slot1) then
		return false
	end

	for slot8, slot9 in pairs(slot0.unitSpawn:getMO():getBuffDic()) do
		if FightBuffHelper.isStoneBuff(slot9.buffId) then
			return
		end

		if FightBuffHelper.isDizzyBuff(slot10) then
			return
		end

		if FightBuffHelper.isSleepBuff(slot10) then
			return
		end

		if FightBuffHelper.isFrozenBuff(slot10) then
			return
		end
	end

	slot0:play(slot1, slot2, slot3)

	return true
end

function slot0._cannotPlay(slot0, slot1)
	if slot0.unitSpawn.buff and FightConfig.instance:getRejectActBuffTypeList(slot1) then
		for slot6, slot7 in ipairs(slot2) do
			if slot0.unitSpawn.buff:haveBuffTypeId(slot7) then
				return true
			end
		end
	end

	if slot0.unitSpawn.buff and slot0.unitSpawn.buff:haveBuffId(2112031) and slot1 ~= "innate3" then
		return true
	end
end

function slot0.playAnim(slot0, slot1, slot2, slot3)
	uv0.super.playAnim(slot0, slot1, slot2, slot3)

	if slot0._specialSpine then
		slot0._specialSpine:playAnim(slot1, slot2, slot3)
	end
end

function slot0.setFreeze(slot0, slot1)
	uv0.super.setFreeze(slot0, slot1)

	if slot0._specialSpine then
		slot0._specialSpine:setFreeze(slot1)
	end
end

function slot0.setTimeScale(slot0, slot1)
	uv0.super.setTimeScale(slot0, slot1)

	if slot0._specialSpine then
		slot0._specialSpine:setTimeScale(slot1)
	end
end

function slot0.setLayer(slot0, slot1, slot2)
	uv0.super.setLayer(slot0, slot1, slot2)

	if slot0._specialSpine then
		slot0._specialSpine:setLayer(slot1, slot2)
	end
end

function slot0.setRenderOrder(slot0, slot1, slot2)
	uv0.super.setRenderOrder(slot0, slot1, slot2)

	if slot0._specialSpine then
		slot0._specialSpine:setRenderOrder(slot1, slot2)
	end
end

function slot0.changeLookDir(slot0, slot1)
	uv0.super.changeLookDir(slot0, slot1)

	if slot0._specialSpine then
		slot0._specialSpine:changeLookDir(slot1)
	end
end

function slot0._changeLookDir(slot0)
	uv0.super._changeLookDir(slot0)

	if slot0._specialSpine then
		slot0._specialSpine:_changeLookDir()
	end
end

function slot0.setActive(slot0, slot1)
	uv0.super.setActive(slot0, slot1)

	if slot0._specialSpine then
		slot0._specialSpine:setActive(slot1)
	end
end

function slot0.setAnimation(slot0, slot1, slot2, slot3)
	if slot0._skeletonAnim then
		slot0._skeletonAnim.loop = slot2
		slot0._skeletonAnim.CurAnimName = slot1
	end

	uv0.super.setAnimation(slot0, slot1, slot2, slot3)

	if slot0._specialSpine then
		slot0._specialSpine:setAnimation(slot1, slot2, slot3)
	end
end

function slot0._initSpine(slot0, slot1)
	uv0.super._initSpine(slot0, slot1)
	slot0:_initSpecialSpine()
	slot0:detectDisplayInScreen()
end

function slot0._initSpecialSpine(slot0)
	if slot0.unitSpawn:getMO() then
		if slot0.LOCK_SPECIALSPINE then
			return
		end

		if _G["FightEntitySpecialSpine" .. slot0.unitSpawn:getMO().modelId] then
			slot0._specialSpine = _G[slot1].New(slot0.unitSpawn)
		end
	end
end

function slot0.detectDisplayInScreen(slot0)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return true
	end

	if slot0:getSpineTr() and FightDataHelper.entityMgr:getById(slot0.unitSpawn.id) and lua_fight_monster_display_condition.configDict[slot2.modelId] then
		slot5 = false

		for slot10, slot11 in pairs(slot2:getBuffDic()) do
			if slot11.buffId == slot4.buffId then
				slot5 = true

				break
			end
		end

		if slot5 then
			transformhelper.setLocalPos(slot1, 0, 0, 0)
		else
			transformhelper.setLocalPos(slot1, 20000, 0, 0)

			return false
		end
	end

	return true
end

function slot0.detectRefreshAct(slot0, slot1)
	if slot0.unitSpawn:getMO() and lua_fight_buff_replace_spine_act.configDict[slot2.skin] and slot3[slot1] then
		slot0.unitSpawn:resetAnimState()
	end
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3)
	if slot1 == slot0.unitSpawn.id then
		slot0:detectDisplayInScreen()
		slot0:detectRefreshAct(slot3)
	end
end

function slot0.releaseSpecialSpine(slot0)
	if slot0._specialSpine then
		slot0._specialSpine:releaseSelf()

		slot0._specialSpine = nil
	end
end

function slot0._clear(slot0)
	slot0:releaseSpecialSpine()
	slot0:removeAnimEventCallback(slot0._onTransitionAnimEvent, slot0)
	uv0.super._clear(slot0)
end

function slot0.beforeDestroy(slot0)
	if uv0.super.beforeDestroy then
		uv0.super.beforeDestroy(slot0)
	end

	FightController.instance:unregisterCallback(FightEvent.SkillEditorRefreshBuff, slot0.detectRefreshAct, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
end

return slot0
