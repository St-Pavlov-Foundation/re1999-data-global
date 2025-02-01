module("modules.logic.explore.view.ExploreBlackView", package.seeall)

slot0 = class("ExploreBlackView", BaseView)

function slot0.onInitView(slot0)
	slot0.anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.onOpenFinish(slot0)
	if slot0._has_onOpen then
		slot0.anim.enabled = true

		slot0.anim:Play("loop", 0, 0)
	end
end

return slot0
