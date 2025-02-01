module("modules.logic.guide.controller.action.impl.GuideActionPlayAnimator", package.seeall)

slot0 = class("GuideActionPlayAnimator", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot2 = string.split(slot0.actionParam, "#")
	slot0._animRoot = slot2[1]
	slot0._controllerPath = slot2[2]
	slot0._endAnim = slot2[3]
	slot0._endAnimTime = tonumber(slot2[4])
	slot3 = MultiAbLoader.New()
	slot0._loader = slot3

	slot3:addPath(slot0._controllerPath)
	slot3:startLoad(slot0._loadedFinish, slot0)
	slot0:onDone(true)
end

function slot0._loadedFinish(slot0, slot1)
	slot3 = slot0._loader:getFirstAssetItem():GetResource()

	if not gohelper.onceAddComponent(gohelper.find(slot0._animRoot), typeof(UnityEngine.Animator)) then
		return
	end

	slot4.enabled = true
	slot4.runtimeAnimatorController = slot3
	slot0._animator = slot4
end

function slot0._stopAnimator(slot0)
	if slot0._animator and gohelper.isNil(slot0._animator) == false then
		slot0._animator.runtimeAnimatorController = nil
		slot0._animator.enabled = false
	end
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)

	if slot0._animator and slot0._endAnim then
		slot0._animator:Play(slot0._endAnim)
	end

	if slot0._animator and slot0._endAnimTime then
		TaskDispatcher.runDelay(slot0._stopAnimator, slot0, slot0._endAnimTime)
	end

	if slot0._loader then
		slot0._loader:dispose()
	end
end

return slot0
