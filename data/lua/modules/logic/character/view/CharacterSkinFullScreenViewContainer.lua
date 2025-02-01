module("modules.logic.character.view.CharacterSkinFullScreenViewContainer", package.seeall)

slot0 = class("CharacterSkinFullScreenViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "top_left"))
	table.insert(slot1, CharacterSkinFullScreenView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		}, 100)
	}
end

function slot0.playOpenTransition(slot0)
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	uv0.super.playOpenTransition(slot0)
end

function slot0.onPlayOpenTransitionFinish(slot0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	uv0.super.onPlayOpenTransitionFinish(slot0)
end

return slot0
