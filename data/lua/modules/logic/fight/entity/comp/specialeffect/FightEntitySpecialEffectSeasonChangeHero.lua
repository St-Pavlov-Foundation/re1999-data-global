module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffectSeasonChangeHero", package.seeall)

slot0 = class("FightEntitySpecialEffectSeasonChangeHero", FightEntitySpecialEffectBase)
slot1 = "_OutlineWidth"

function slot0.initClass(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.EnterOperateState, slot0._onEnterOperateState, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ExitOperateState, slot0._onExitOperateState, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SeasonSelectChangeHeroTarget, slot0._onSeasonSelectChangeHeroTarget, slot0)

	slot0._whiteLine = nil
	slot0._orangeLine = nil
end

function slot0._onSeasonSelectChangeHeroTarget(slot0, slot1)
	slot0:_releaseOrangeEffect()

	if slot1 == slot0._entity.id then
		slot0._orangeLine = slot0._entity.effect:addHangEffect("buff/buff_outline_orange", ModuleEnum.SpineHangPointRoot)

		slot0._orangeLine:setLocalPos(0, 0, 0)

		if gohelper.isNil(slot0._orangeLine.effectGO) then
			slot0._orangeLine:setCallback(slot0._setOrangeWidth, slot0)
		else
			slot0:_setOrangeWidth()
		end

		FightRenderOrderMgr.instance:onAddEffectWrap(slot0._entity.id, slot0._orangeLine)
		slot0._whiteLine:setActive(false)
	elseif slot0._whiteLine then
		slot0._whiteLine:setActive(true)
	end
end

function slot0._setOrangeWidth(slot0)
	slot0:_setOutlineWidth(slot0._orangeLine)
end

function slot0._onExitOperateState(slot0, slot1)
	if slot1 ~= FightStageMgr.OperateStateType.SeasonChangeHero then
		return
	end

	slot0:releaseAllEffect()
end

function slot0._onEnterOperateState(slot0, slot1)
	if not slot0._entity:isMySide() then
		return
	end

	if slot1 == FightStageMgr.OperateStateType.SeasonChangeHero then
		slot0._whiteLine = slot0._entity.effect:addHangEffect("buff/buff_outline_white", ModuleEnum.SpineHangPointRoot)

		slot0._whiteLine:setLocalPos(0, 0, 0)

		if gohelper.isNil(slot0._whiteLine.effectGO) then
			slot0._whiteLine:setCallback(slot0._setWhileWidth, slot0)
		else
			slot0:_setWhileWidth()
		end

		FightRenderOrderMgr.instance:onAddEffectWrap(slot0._entity.id, slot0._whiteLine)
	end
end

function slot0._setWhileWidth(slot0)
	slot0:_setOutlineWidth(slot0._whiteLine)
end

function slot0._setOutlineWidth(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = nil

	if slot1 and not gohelper.isNil(slot1.effectGO) then
		if gohelper.findChildComponent(slot1.effectGO, "diamond/root/diamond", typeof(UnityEngine.Renderer)) then
			if slot3.material then
				if not slot0._defaultOutlineWidth then
					slot0._defaultOutlineWidth = slot2:GetFloat(uv0)
				end
			else
				logError("找不到描边材质")
			end
		else
			logError("找不到描边render")
		end
	end

	if slot2 then
		slot4 = slot0._entity:getMO() and slot3.skin and lua_monster_skin.configDict[slot3.skin]

		if slot4 and slot4.outlineWidth and slot5 > 0 then
			slot2:SetFloat(uv0, slot5)
		else
			slot2:SetFloat(uv0, slot0._defaultOutlineWidth)
		end
	end
end

function slot0.releaseAllEffect(slot0)
	slot0:_releaseWhiteEffect()
	slot0:_releaseOrangeEffect()
end

function slot0._releaseWhiteEffect(slot0)
	if slot0._whiteLine then
		slot0._entity.effect:removeEffect(slot0._whiteLine)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0._entity.id, slot0._whiteLine)

		slot0._whiteLine = nil
	end
end

function slot0._releaseOrangeEffect(slot0)
	if slot0._orangeLine then
		slot0._entity.effect:removeEffect(slot0._orangeLine)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0._entity.id, slot0._orangeLine)

		slot0._orangeLine = nil
	end
end

function slot0.releaseSelf(slot0)
	slot0:releaseAllEffect()
end

return slot0
