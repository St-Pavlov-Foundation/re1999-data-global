module("modules.logic.explore.map.scene.ExploreMapClipObj", package.seeall)

slot0 = class("ExploreMapClipObj", UserDataDispose)
slot1 = UnityEngine.Shader.PropertyToID("_OcclusionThreshold")
slot2 = 0.7
slot3 = 0.6

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0._trans = slot1
	slot0._renderers = slot1:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true)
	slot0._isClip = false
	slot0._isNowClip = false
	slot0._nowClipValue = nil
end

function slot0.markClip(slot0, slot1)
	slot0._isClip = slot1
end

function slot0.checkNow(slot0)
	if slot0._isClip ~= slot0._isNowClip then
		slot0._isNowClip = slot0._isClip

		if slot0._isClip then
			slot0:beginClip()
		else
			slot0:endClip()
		end
	end
end

function slot0.beginClip(slot0)
	if not slot0._shareMats then
		slot0._shareMats = slot0:getUserDataTb_()
		slot0._matInsts = slot0:getUserDataTb_()

		for slot4 = 0, slot0._renderers.Length - 1 do
			slot0._shareMats[slot4] = slot0._renderers[slot4].sharedMaterial
			slot0._matInsts[slot4] = slot0._renderers[slot4].material

			slot0._matInsts[slot4]:EnableKeyword("_OCCLUSION_CLIP")
			slot0._matInsts[slot4]:SetFloat(uv0, 0)
		end
	end

	for slot4 = 0, slot0._renderers.Length - 1 do
		if not tolua.isnull(slot0._renderers[slot4]) then
			slot5.material = slot0._matInsts[slot4]
		end
	end

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)
	end

	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot0._nowClipValue or 0, uv1, uv2, slot0.onTween, slot0.onTweenEnd, slot0, nil, EaseType.Linear)
end

function slot0.onTween(slot0, slot1)
	slot0._nowClipValue = slot1

	for slot5 = 0, #slot0._matInsts do
		slot0._matInsts[slot5]:SetFloat(uv0, slot1)
	end
end

function slot0.onTweenEnd(slot0)
	slot0._tweenId = nil

	if not slot0._isNowClip then
		for slot4 = 0, slot0._renderers.Length - 1 do
			if not tolua.isnull(slot0._renderers[slot4]) then
				slot5.material = slot0._shareMats[slot4]
			end
		end
	end
end

function slot0.endClip(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)
	end

	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot0._nowClipValue or uv0, 0, uv1, slot0.onTween, slot0.onTweenEnd, slot0, nil, EaseType.Linear)
end

function slot0.clear(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot0._trans = nil
	slot0._renderers = nil
	slot0._mats = nil
	slot0._isClip = false
	slot0._isNowClip = false

	slot0:__onDispose()
end

return slot0
