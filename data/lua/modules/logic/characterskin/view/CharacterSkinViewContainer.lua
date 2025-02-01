module("modules.logic.characterskin.view.CharacterSkinViewContainer", package.seeall)

slot0 = class("CharacterSkinViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, CharacterSkinSwitchRightView.New())
	table.insert(slot1, CharacterSkinLeftView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btntopleft"))
	table.insert(slot1, CharacterSkinSwitchSpineGCView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		slot0.navigateView
	}
end

function slot0.playOpenTransition(slot0)
	slot0:_cancelBlock()
	slot0:_stopOpenCloseAnim()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	ZProj.ProjAnimatorPlayer.Get(slot0.viewGO):Play(UIAnimationName.Open, slot0.onOpenAnimDone, slot0)
end

function slot0.onOpenAnimDone(slot0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	slot0:onPlayOpenTransitionFinish()
end

function slot0.playCloseTransition(slot0)
	slot0:_cancelBlock()
	slot0:_stopOpenCloseAnim()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	ZProj.ProjAnimatorPlayer.Get(slot0.viewGO):Play(UIAnimationName.Close, slot0.onCloseAnimDone, slot0)
end

function slot0.onCloseAnimDone(slot0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	slot0:onPlayCloseTransitionFinish()
end

return slot0
