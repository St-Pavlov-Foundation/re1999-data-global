module("modules.logic.fight.view.work.FightReadyAttackWork", package.seeall)

slot0 = class("FightReadyAttackWork", BaseWork)
slot1 = 0.5
slot2 = 1
slot3 = Color.New(2.119, 1.353, 0.821, 1)
slot4 = Color.white

function slot0.onStart(slot0, slot1)
	slot0._count = 3
	slot0._hasAddEvent = false
	slot0._entity = slot1

	if FightDataHelper.entityMgr:getById(slot0._entity.id) and slot0._entity and slot0._entity.spine and not slot0._entity.spine:hasAnimation(SpineAnimState.posture) then
		slot0:onDone(true)

		return
	end

	slot0._oldColor = MaterialUtil.GetMainColor(slot0._entity.spineRenderer:getReplaceMat())

	if not slot0._oldColor then
		slot0:onDone(true)

		return
	end

	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 2, uv0 / FightModel.instance:getSpeed(), slot0._onFrameSetColor, slot0._checkDone, slot0)

	if string.nilorempty(slot1.buff:getBuffAnim()) then
		if slot0._entity.spine:hasAnimation(SpineAnimState.change) then
			slot0._changeActName = FightHelper.processEntityActionName(slot0._entity, SpineAnimState.change)

			slot0._entity.spine:addAnimEventCallback(slot0._onChangeAnimEvent, slot0)
			slot0._entity.spine:play(slot0._changeActName, false, true, true)

			slot0._hasAddEvent = true
		else
			slot0:_playPostureAnim()
		end
	else
		slot0:_checkDone()
	end

	slot0._effectWrap = slot0._entity.effect:addHangEffect(FightPreloadEffectWork.buff_zhunbeigongji, ModuleEnum.SpineHangPoint.mountbottom)

	slot0._effectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(slot0._entity.id, slot0._effectWrap)
	TaskDispatcher.runDelay(slot0._checkDone, slot0, uv1 / FightModel.instance:getSpeed())
end

function slot0._onFrameSetColor(slot0, slot1)
	slot2 = slot1 < 1 and slot1 or 2 - slot1
	uv0.r = Mathf.Lerp(slot0._oldColor.r, uv1.r, slot2)
	uv0.g = Mathf.Lerp(slot0._oldColor.g, uv1.g, slot2)
	uv0.b = Mathf.Lerp(slot0._oldColor.b, uv1.b, slot2)

	slot0:_setMainColor(uv0)
end

function slot0._setMainColor(slot0, slot1)
	if (FightModel.instance:getCurStage() == FightEnum.Stage.Card or slot2 == FightEnum.Stage.AutoCard) and not gohelper.isNil(slot0._entity.spineRenderer:getReplaceMat()) then
		MaterialUtil.setMainColor(slot3, slot1)
	end
end

function slot0._onChangeAnimEvent(slot0, slot1, slot2, slot3)
	if slot1 == slot0._changeActName and slot2 == SpineAnimEvent.ActionComplete then
		slot0:_playPostureAnim()
	end
end

function slot0._playPostureAnim(slot0)
	if slot0._hasAddEvent then
		slot0._entity.spine:removeAnimEventCallback(slot0._onChangeAnimEvent, slot0)

		slot0._hasAddEvent = false
	end

	slot0._entity.spine:play(SpineAnimState.posture, true, true)
	slot0:_checkDone()
end

function slot0._checkDone(slot0)
	slot0._count = slot0._count - 1

	if slot0._count <= 0 then
		slot0:_setMainColor(slot0._oldColor)

		slot0._tweenId = nil

		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	if slot0._effectWrap then
		FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0._entity.id, slot0._effectWrap)
		slot0._entity.effect:removeEffect(slot0._effectWrap)

		slot0._effectWrap = nil
	end

	if slot0._hasAddEvent then
		slot0._entity.spine:removeAnimEventCallback(slot0._onChangeAnimEvent, slot0)

		slot0._hasAddEvent = false
	end

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil

		if slot0._oldColor then
			slot0:_setMainColor(slot0._oldColor)
		end
	end

	slot0._entity = nil

	TaskDispatcher.cancelTask(slot0._checkDone, slot0)
end

return slot0
