module("modules.logic.character.view.CharacterViewContainer", package.seeall)

slot0 = class("CharacterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._equipView = CharacterDefaultEquipView.New()

	table.insert(slot1, CharacterView.New())
	table.insert(slot1, slot0._equipView)
	table.insert(slot1, CharacterSpineGCView.New())
	table.insert(slot1, CommonRainEffectView.New("anim/bgcanvas/#go_glowcontainer"))

	slot0.helpShowView = HelpShowView.New()

	table.insert(slot1, slot0.helpShowView)

	return slot1
end

function slot0.getEquipView(slot0)
	return slot0._equipView
end

function slot0.playOpenTransition(slot0)
	slot0:_cancelBlock()
	slot0:_stopOpenCloseAnim()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	ZProj.ProjAnimatorPlayer.Get(slot0.viewGO):Play(UIAnimationName.Open, slot0.onOpenAnimDone, slot0)
	slot0:startViewOpenBlock()
end

function slot0.onOpenAnimDone(slot0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	slot0:onPlayOpenTransitionFinish()
	slot0:_cancelBlock()
	slot0:_stopOpenCloseAnim()
end

function slot0.playCloseTransition(slot0)
	slot0:_cancelBlock()
	slot0:_stopOpenCloseAnim()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	ZProj.ProjAnimatorPlayer.Get(slot0.viewGO):Play(UIAnimationName.Close, slot0.onCloseAnimDone, slot0)
	slot0:startViewCloseBlock()
end

function slot0.onCloseAnimDone(slot0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	slot0:onPlayCloseTransitionFinish()
	slot0:_cancelBlock()
	slot0:_stopOpenCloseAnim()
end

function slot0.setIsOwnHero(slot0, slot1)
	if slot1 then
		slot0._isOwnHero = slot1.isOwnHero
	else
		slot0._isOwnHero = true
	end
end

function slot0.isOwnHero(slot0)
	return slot0._isOwnHero
end

return slot0
