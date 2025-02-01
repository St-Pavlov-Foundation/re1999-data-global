module("modules.logic.fight.entity.comp.skill.FightTLEventSceneMask", package.seeall)

slot0 = class("FightTLEventSceneMask")

function slot0.ctor(slot0)
	slot0._effectWrap = nil
end

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot4 = ResUrl.getEffect(slot3[1])
	slot0._colorStr = slot3[2]

	if not string.nilorempty(slot3[3]) and string.split(slot5, "#") and #slot6 > 0 then
		slot0._fadeInTime = tonumber(slot6[1]) or 0.15
		slot0._fadeOutTime = slot6[2] and tonumber(slot6[2]) or slot0._fadeInTime
	end

	slot0._color = GameUtil.parseColor(slot0._colorStr)

	if slot0._fadeInTime and slot0._fadeInTime > 0 then
		slot0._fadeInId = ZProj.TweenHelper.DOTweenFloat(0, slot0._color.a, slot0._fadeInTime, slot0._tweenFrameCb, nil, slot0)
		slot0._color = Color.New(slot0._color.r, slot0._color.g, slot0._color.b, 0)
	end

	if slot0._fadeOutTime and slot0._fadeOutTime > 0 then
		TaskDispatcher.runDelay(slot0._fadeOut, slot0, slot2 - slot0._fadeOutTime)
	end

	slot0._effectWrap = FightEffectPool.getEffect(slot4, FightEnum.EntitySide.BothSide, slot0._onEffectLoaded, slot0, gohelper.findChild(CameraMgr.instance:getMainCameraGO(), "scenemask"))

	slot0._effectWrap:setLayer(UnityLayer.Unit)
end

function slot0.handleSkillEventEnd(slot0)
	slot0:_clear()
end

function slot0._fadeOut(slot0)
	if slot0._fadeInId then
		ZProj.TweenHelper.KillById(slot0._fadeInId)
	end

	slot0._fadeOutId = ZProj.TweenHelper.DOTweenFloat(slot0._color.a, 0, slot0._fadeOutTime, slot0._tweenFrameCb, nil, slot0)
end

function slot0._tweenFrameCb(slot0, slot1)
	slot0._color.a = slot1

	slot0:_setMaskColor()
end

function slot0.reset(slot0)
	slot0:_clear()
end

function slot0.dispose(slot0)
	slot0:_clear()
end

function slot0._onEffectLoaded(slot0, slot1, slot2)
	if not slot2 then
		return
	end

	if slot1.effectGO:GetComponent("MeshRenderer") then
		slot0._material = slot3.material

		if slot0._material:HasProperty(MaterialUtil._MaskColorId) then
			slot0:_setMaskColor()
		end
	end
end

function slot0._setMaskColor(slot0)
	if slot0._material then
		slot0._material:SetColor(MaterialUtil._MaskColorId, slot0._color)
	end
end

function slot0._clear(slot0)
	TaskDispatcher.cancelTask(slot0._fadeOut, slot0)

	if slot0._fadeInId then
		ZProj.TweenHelper.KillById(slot0._fadeInId)

		slot0._fadeInId = nil
	end

	if slot0._fadeOutId then
		ZProj.TweenHelper.KillById(slot0._fadeOutId)

		slot0._fadeOutId = nil
	end

	if slot0._effectWrap then
		FightEffectPool.returnEffect(slot0._effectWrap)

		slot0._effectWrap = nil
	end

	slot0._material = nil
end

return slot0
