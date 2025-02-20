module("modules.logic.fight.entity.comp.buffspecialprecessitem.FightBuffJuDaBenYePuDormancyTail", package.seeall)

slot0 = class("FightBuffJuDaBenYePuDormancyTail", FightBaseClass)

function slot0.onAwake(slot0, slot1, slot2, slot3)
	slot0._entity = slot1
	slot0._buffUid = slot3
	slot0._entityMat = slot0._entity.spineRenderer:getCloneOriginMat()

	if not slot0._entityMat then
		slot0._entityMat = slot0._entity.spineRenderer:getSpineRenderMat()
	end

	if not slot0._entityMat then
		return
	end

	slot0._entityMat:EnableKeyword("_STONE_ON")

	slot0._path = ResUrl.getRoleSpineMatTex("textures/stone_manual")

	slot0:com_loadAsset(slot0._path, slot0._onLoaded)
	slot0:com_registFightEvent(FightEvent.RemoveEntityBuff, slot0._onRemoveEntityBuff)
end

function slot0._onRemoveEntityBuff(slot0, slot1, slot2)
	if slot1 ~= slot0._entity.id then
		return
	end

	if slot2.uid ~= slot0._buffUid then
		return
	end

	slot0:onBuffEnd()
end

function slot0._onLoaded(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot0._entityMat:SetTexture("_NoiseMap4", slot2:GetResource(slot0._path))
	slot0:_playOpenTween()
end

function slot0._playOpenTween(slot0)
	slot0:_releaseTween()

	slot1 = nil
	slot2 = UnityEngine.Shader.PropertyToID("_TempOffset3")
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, function (slot0)
		slot1, slot2 = uv0:getPlayValue()
		uv1 = MaterialUtil.getLerpValue("Vector4", slot1, slot2, slot0, uv1)

		MaterialUtil.setPropValue(uv0._entityMat, uv2, "Vector4", uv1)
	end)
end

function slot0._playCloseTween(slot0)
	slot0:_releaseTween()

	slot1 = nil
	slot2 = UnityEngine.Shader.PropertyToID("_TempOffset3")
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, function (slot0)
		slot1, slot2 = uv0:getCloseValue()
		uv1 = MaterialUtil.getLerpValue("Vector4", slot1, slot2, slot0, uv1)

		MaterialUtil.setPropValue(uv0._entityMat, uv2, "Vector4", uv1)
	end)
end

function slot0.getPlayValue(slot0)
	slot1 = MaterialUtil.getPropValueFromMat(slot0._entityMat, "_TempOffset3", "Vector4")

	return MaterialUtil.getPropValueFromStr("Vector4", string.format("3,%f,0,0", slot1.y)), MaterialUtil.getPropValueFromStr("Vector4", string.format("3,%f,1,0", slot1.y))
end

function slot0.getCloseValue(slot0)
	slot1 = MaterialUtil.getPropValueFromMat(slot0._entityMat, "_TempOffset3", "Vector4")

	return MaterialUtil.getPropValueFromStr("Vector4", string.format("3,%f,1,0", slot1.y)), MaterialUtil.getPropValueFromStr("Vector4", string.format("3,%f,0,0", slot1.y))
end

function slot0.onBuffEnd(slot0)
	if not slot0._entityMat then
		return
	end

	slot0:_playCloseTween()
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.6)
end

function slot0._delayDone(slot0)
	if slot0._entity:getMO() and slot0._entity.spineRenderer then
		slot3 = false

		for slot7, slot8 in pairs(slot1:getBuffDic()) do
			if slot8.buffId == 4150022 or slot8.buffId == 4150023 then
				slot3 = true
			end
		end

		if not slot3 and slot0._entityMat then
			slot0._entityMat:DisableKeyword("_STONE_ON")
		end
	end

	slot0:disposeSelf()
end

function slot0.releaseSelf(slot0)
	slot0:_releaseTween()
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

function slot0._releaseTween(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

return slot0
