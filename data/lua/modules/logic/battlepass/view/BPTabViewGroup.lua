module("modules.logic.battlepass.view.BPTabViewGroup", package.seeall)

slot0 = class("BPTabViewGroup", TabViewGroup)

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)

	slot0.isInClosingTween = false
	slot0._tabAnims = {}
	slot0._closeViewIndex = nil
	slot0._openId = nil
end

function slot0._openTabView(slot0, slot1)
	if slot0._curTabId == slot1 then
		return
	end

	uv0.super._openTabView(slot0, slot1)
end

function slot0._setVisible(slot0, slot1, slot2)
	slot3 = slot0._tabViews[slot1].viewGO
	slot5 = false

	if slot0._tabAnims[slot1] == nil then
		slot0._tabAnims[slot1] = slot3:GetComponent(typeof(UnityEngine.Animator)) and ZProj.ProjAnimatorPlayer.Get(slot3) or false
		slot5 = true
	end

	if slot2 then
		if slot0.isInClosingTween then
			slot0._openId = slot1

			if slot0._closeViewIndex ~= slot1 then
				if slot5 then
					slot3:GetComponent(typeof(UnityEngine.Animator)).enabled = false
				end

				uv0.super._setVisible(slot0, slot1, false)
			end

			return
		end

		slot3:GetComponent(typeof(UnityEngine.Animator)).enabled = true

		uv0.super._setVisible(slot0, slot1, true)

		if slot4 then
			slot4:Play(UIAnimationName.Open)
		end

		slot0.viewContainer:dispatchEvent(BpEvent.TapViewOpenAnimBegin, slot1)
	else
		if slot0.isInClosingTween then
			return
		end

		if slot0._openId == slot1 then
			slot0._openId = nil
		end

		if slot4 then
			slot0.isInClosingTween = true
			slot0._closeViewIndex = slot1

			slot0.viewContainer:dispatchEvent(BpEvent.TapViewCloseAnimBegin, slot1)
			slot4:Play(UIAnimationName.Close, slot0.onCloseTweenFinish, slot0)
		else
			uv0.super._setVisible(slot0, slot1, false)
		end
	end
end

function slot0.onCloseTweenFinish(slot0)
	if not slot0._closeViewIndex then
		return
	end

	slot1 = slot0._closeViewIndex

	uv0.super._setVisible(slot0, slot0._closeViewIndex, false)

	slot0._closeViewIndex = nil
	slot0.isInClosingTween = false

	if slot0._openId then
		slot0:_setVisible(slot0._openId, true)

		slot0._openId = nil
	end

	slot0.viewContainer:dispatchEvent(BpEvent.TapViewCloseAnimEnd, slot1)
end

function slot0.onDestroyView(slot0, ...)
	slot0.isInClosingTween = nil
	slot0._tabAnims = nil
	slot0._closeViewIndex = nil
	slot0._openId = nil

	uv0.super.onDestroyView(slot0, ...)
end

return slot0
