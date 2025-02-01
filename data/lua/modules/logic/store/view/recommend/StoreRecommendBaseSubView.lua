module("modules.logic.store.view.recommend.StoreRecommendBaseSubView", package.seeall)

slot0 = class("StoreRecommendBaseSubView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btn:AddClickListener(slot0._onClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btn:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
end

function slot0.onOpen(slot0)
	if slot0._animator then
		slot0._animator.enabled = true

		slot0._animator:Play(UIAnimationName.Open, 0, 0)
		slot0._animator:Update(0)
	end
end

function slot0.switchClose(slot0, slot1, slot2)
	if slot0._animator then
		slot0._animator.enabled = false
	end

	if slot0._animatorPlayer then
		slot0._animatorPlayer:Play(UIAnimationName.Close, slot1, slot2)
	end
end

function slot0.stopAnimator(slot0)
	if slot0._animatorPlayer then
		slot0._animatorPlayer:Stop()
	end

	if slot0._animator then
		slot0._animator.enabled = false
	end
end

function slot0.onClose(slot0)
end

return slot0
