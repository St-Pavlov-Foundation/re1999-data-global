module("modules.logic.versionactivity2_2.tianshinana.entity.TianShiNaNaPlayerEntity", package.seeall)

slot0 = class("TianShiNaNaPlayerEntity", TianShiNaNaUnitEntityBase)

function slot0.onMoving(slot0)
	if not slot0.trans then
		return
	end

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.PlayerMove, slot0:getLocalPos())
end

function slot0.updatePosAndDir(slot0)
	uv0.super.updatePosAndDir(slot0)
	slot0:onMoving()
end

function slot0.onResLoaded(slot0)
	slot0._anim = slot0._resGo:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.reAdd(slot0)
	if slot0._anim then
		slot0._anim:Play("open", 0, 1)
	end
end

function slot0.playCloseAnim(slot0)
	if slot0._anim then
		slot0._anim:Play("close", 0, 0)
	end
end

return slot0
