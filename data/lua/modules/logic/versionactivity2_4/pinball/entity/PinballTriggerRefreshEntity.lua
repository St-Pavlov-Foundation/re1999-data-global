module("modules.logic.versionactivity2_4.pinball.entity.PinballTriggerRefreshEntity", package.seeall)

slot0 = class("PinballTriggerRefreshEntity", PinballTriggerEntity)

function slot0.onInit(slot0)
	uv0.super.onInit(slot0)

	slot0.curHitCount = 0
	slot0.totalRefresh = 0
end

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._effectAnim = gohelper.findChildAnim(slot1, "vx_stonestatue")
end

function slot0.onHitEnter(slot0, slot1, slot2, slot3, slot4)
	if not PinballEntityMgr.instance:getEntity(slot1) then
		return
	end

	if slot5:isMarblesType() then
		slot0:incHit()
	end
end

function slot0.onCreateLinkEntity(slot0, slot1)
	slot1.curHitCount = slot0.curHitCount
	slot1.totalRefresh = slot0.totalRefresh

	slot1:playEffectAnim(true)
end

function slot0.incHit(slot0)
	if slot0.isDead then
		return
	end

	slot0.curHitCount = slot0.curHitCount + 1

	if slot0.linkEntity then
		slot0.linkEntity.curHitCount = slot0.linkEntity.curHitCount + 1

		slot0.linkEntity:playEffectAnim()
	end

	slot0:playEffectAnim()

	if slot0.hitCount <= slot0.curHitCount then
		slot0.totalRefresh = slot0.totalRefresh + 1

		slot0:doRefresh()

		if slot0.limitNum <= slot0.totalRefresh then
			slot0._waitAnim = true

			TaskDispatcher.runDelay(slot0._delayDestory, slot0, 1.5)
			slot0:playAnim("disapper")
			slot0:markDead()
		end
	end
end

function slot0.playEffectAnim(slot0, slot1)
	if not slot0._effectAnim then
		return
	end

	if slot0.curHitCount == 0 then
		gohelper.setActive(slot0._effectAnim, false)
	else
		gohelper.setActive(slot0._effectAnim, true)
		slot0._effectAnim:Play(string.format("stonestatue_open_%02d", slot0.curHitCount), 0, slot1 and 1 or 0)
	end
end

function slot0.doRefresh(slot0)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio19)
	PinballController.instance:dispatchEvent(PinballEvent.GameResRefresh)
end

function slot0.onInitByCo(slot0)
	slot1 = string.splitToNumber(slot0.spData, "#") or {}
	slot0.hitCount = slot1[1] or 1
	slot0.limitNum = slot1[2] or 1
end

function slot0._delayDestory(slot0)
	gohelper.destroy(slot0.go)
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._delayDestory, slot0)
end

function slot0.dispose(slot0)
	if not slot0._waitAnim then
		gohelper.destroy(slot0.go)
	end
end

return slot0
