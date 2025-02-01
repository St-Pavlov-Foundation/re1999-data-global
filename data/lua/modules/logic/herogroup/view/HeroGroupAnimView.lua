module("modules.logic.herogroup.view.HeroGroupAnimView", package.seeall)

slot0 = class("HeroGroupAnimView", BaseView)

function slot0.onInitView(slot0)
	slot0._goherogroupcontain = gohelper.findChild(slot0.viewGO, "herogroupcontain")
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#go_container")
	slot0._goBtnContain = gohelper.findChild(slot0.viewGO, "#go_container/btnContain")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupExitEffect, slot0._playHeroGroupExitEffect, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayCloseHeroGroupAnimation, slot0._playCloseHeroGroupAnimation, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupExitEffect, slot0._playHeroGroupExitEffect, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.PlayCloseHeroGroupAnimation, slot0._playCloseHeroGroupAnimation, slot0)
end

function slot0._editableInitView(slot0)
	slot0._heroContainAnim = slot0._goherogroupcontain:GetComponent(typeof(UnityEngine.Animator))
	slot0._anim = slot0._gocontainer:GetComponent(typeof(UnityEngine.Animator))
	slot0._btnContainAnim = slot0._goBtnContain:GetComponent(typeof(UnityEngine.Animator))
end

function slot0._playHeroGroupExitEffect(slot0)
	slot0._anim:Play(UIAnimationName.Close, 0, 0)
	slot0._btnContainAnim:Play(UIAnimationName.Close, 0, 0)
end

function slot0._playCloseHeroGroupAnimation(slot0)
	slot0._anim:Play(UIAnimationName.Close, 0, 0)
	slot0._btnContainAnim:Play(UIAnimationName.Close, 0, 0)

	slot0._heroContainAnim.enabled = true

	slot0._heroContainAnim:Play("herogroupcontain_out", 0, 0)
	TaskDispatcher.runDelay(slot0._closeHeroContainAnim, slot0, 0.133)
end

function slot0._closeHeroContainAnim(slot0)
	if slot0._heroContainAnim then
		slot0._heroContainAnim.enabled = false
	end
end

function slot0.onClose(slot0)
	slot0:_playHeroGroupExitEffect()

	slot0._heroContainAnim.enabled = true

	slot0._heroContainAnim:Play("herogroupcontain_out", 0, 0)
	TaskDispatcher.cancelTask(slot0._closeHeroContainAnim, slot0)
end

return slot0
