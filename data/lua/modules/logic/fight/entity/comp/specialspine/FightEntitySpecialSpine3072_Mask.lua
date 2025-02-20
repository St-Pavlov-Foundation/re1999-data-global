module("modules.logic.fight.entity.comp.specialspine.FightEntitySpecialSpine3072_Mask", package.seeall)

slot0 = class("FightEntitySpecialSpine3072_Mask", UserDataDispose)
slot1 = 30720101

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0._entity = slot1

	slot0:_initSpine()
	slot0:addEventCb(FightController.instance, FightEvent.SetEntityAlpha, slot0._onSetEntityAlpha, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnFightReconnectLastWork, slot0._onFightReconnectLastWork, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.TimelinePlayEntityAni, slot0._onTimelinePlayEntityAni, slot0)
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3)
	if slot1 ~= slot0._entity.id then
		return
	end

	if slot3 ~= uv0 then
		return
	end

	slot0:_detectMaskBuff()
end

function slot0._detectMaskBuff(slot0)
	slot1 = false

	if slot0._entity:getMO() then
		for slot7, slot8 in pairs(slot2:getBuffDic()) do
			if slot8.buffId == uv0 then
				slot1 = true

				break
			end
		end
	end

	slot0._showMask = slot1

	slot0:_refreshMaskVisible()
end

function slot0._refreshMaskVisible(slot0)
	if not gohelper.isNil(slot0._spineRoot) then
		slot1 = true

		if not slot0._showMask then
			slot1 = false
		end

		if slot0._entity.marked_alpha == 0 then
			slot1 = false
		end

		if slot0._playingSkill then
			slot1 = false
		end

		if slot0._playingAni then
			slot1 = false
		end

		transformhelper.setLocalPos(slot0._spineRootTransform, slot1 and 0 or 20000, 0, 0)

		if slot1 then
			slot0:_correctAniTime()
		end
	end
end

function slot0._onSetEntityAlpha(slot0, slot1)
	slot0:_refreshMaskVisible()
end

function slot0._initSpine(slot0)
	slot0._spineRoot = gohelper.create3d(slot0._entity.go, "specialSpine")
	slot0._spineRootTransform = slot0._spineRoot.transform
	slot0._spine = MonoHelper.addLuaComOnceToGo(slot0._spineRoot, UnitSpine, slot0._entity)
	slot2 = nil

	slot0._spine:setResPath(slot0._entity:getMO().skin == 307203 and "roles/v2a2_307203_zmsl_m/307203_zmsl_m_fight.prefab" or string.format("roles/v1a3_%d_zongmaoshali_m/%d_zongmaoshali_m_fight.prefab", slot1.skin, slot1.skin), slot0._onSpineLoaded, slot0)
end

function slot0._onSpineLoaded(slot0, slot1)
	if slot0._layer then
		slot0:setLayer(slot0._layer, slot0._recursive)
	end

	if slot0._order then
		slot0:setRenderOrder(slot0._order, true)
	end

	if slot0._isActive ~= nil then
		slot0:setActive(slot0._isActive)
	end

	slot0._spine._skeletonAnim.freeze = slot0._entity.spine._bFreeze
	slot0._spine._skeletonAnim.timeScale = slot0._entity.spine._timeScale

	if slot0._entity.spine._skeletonAnim.state:GetCurrent(0) and slot0._spine._skeletonAnim then
		slot0:playAnim(slot2:getAnimState(), slot2._isLoop, true)
	end

	slot0:_detectMaskBuff()
	slot0:_refreshMaskVisible()
end

function slot0._correctAniTime(slot0)
	if slot0._entity.spine._skeletonAnim.state:GetCurrent(0) and slot0._spine._skeletonAnim then
		slot0._spine._skeletonAnim:Jump2Time(slot2.TrackTime)
	end
end

function slot0.playAnim(slot0, slot1, slot2, slot3)
	if slot0._spine and slot0._spine._skeletonAnim and slot0._spine:hasAnimation(slot1) then
		slot0._spine:playAnim(slot1, slot2, slot3)
	end
end

function slot0.setFreeze(slot0, slot1)
	if slot0._spine then
		slot0._spine:setFreeze(slot1)
	end
end

function slot0.setTimeScale(slot0, slot1)
	if slot0._spine then
		slot0._spine:setTimeScale(slot1)
	end
end

function slot0.setLayer(slot0, slot1, slot2)
	slot0._layer = slot1
	slot0._recursive = slot2

	if slot0._spine and slot1 then
		slot0._spine:setLayer(slot1, slot2)
	end
end

function slot0.setRenderOrder(slot0, slot1, slot2)
	slot0._order = slot1

	if slot0._spine and slot1 then
		slot0._spine:setRenderOrder(slot1 + 1, slot2)
	end
end

function slot0.changeLookDir(slot0, slot1)
	if slot0._spine then
		slot0._spine:changeLookDir(slot1)
	end
end

function slot0._changeLookDir(slot0)
	if slot0._spine then
		slot0._spine:_changeLookDir()
	end
end

function slot0.setActive(slot0, slot1)
	slot0._isActive = slot1

	if slot0._spine then
		slot0._spine:setActive(slot1)
	end
end

function slot0.setAnimation(slot0, slot1, slot2, slot3)
	if slot0._spine then
		slot0._spine:setAnimation(slot1, slot2, slot3)
	end
end

function slot0._onSkillPlayStart(slot0, slot1, slot2)
	if slot1.id == slot0._entity.id then
		slot0._playingSkill = true

		slot0:_refreshMaskVisible()
	end
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2)
	if slot1.id == slot0._entity.id then
		slot0._playingSkill = false

		slot0:_refreshMaskVisible()
	end
end

function slot0._onTimelinePlayEntityAni(slot0, slot1, slot2)
	if slot1 == slot0._entity.id then
		slot0._playingAni = slot2

		slot0:_refreshMaskVisible()
	end
end

function slot0._onFightReconnectLastWork(slot0)
	slot0:_onBuffUpdate(slot0._entity.id, nil, uv0)
end

function slot0.releaseSelf(slot0)
	if slot0._spineRoot then
		gohelper.destroy(slot0._spineRoot)
	end

	slot0._entity = nil

	slot0:__onDispose()
end

return slot0
