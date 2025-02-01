module("modules.logic.explore.view.unit.ExploreUnitDialogueView", package.seeall)

slot0 = class("ExploreUnitDialogueView", ExploreUnitBaseView)

function slot0.ctor(slot0, slot1)
	slot0._offsetY2d = 200

	uv0.super.ctor(slot0, slot1, "ui/viewres/explore/explorebubbleview.prefab")
end

function slot0.onInit(slot0)
	slot0.txt = gohelper.findChildTextMesh(slot0.viewGO, "go_btns/tip")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.addEventListeners(slot0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreenUp, slot0._onTouchScreen, slot0)
end

function slot0.removeEventListeners(slot0)
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, slot0._onTouchScreen, slot0)
end

function slot0._onTouchScreen(slot0)
	if slot0._tweenId then
		return
	end

	slot0._anim:Play("close")
	AudioMgr.instance:trigger(AudioEnum.Explore.BubbleHide)

	slot0._tweenId = ZProj.TweenHelper.DOScale(slot0.viewGO.transform, 0, 0, 0, 0.5, slot0.closeThis, slot0)
end

function slot0.onOpen(slot0)
	slot0.txt.text = ""

	transformhelper.setLocalScale(slot0.viewGO.transform, 0, 0, 0)

	slot0._tweenId = ZProj.TweenHelper.DOScale(slot0.viewGO.transform, 1, 1, 1, 0.5, slot0.onTweenOpenEnd, slot0)

	if slot0._id then
		slot0:setDialogueId(slot0._id)
	end

	slot0._anim:Play("open")
	AudioMgr.instance:trigger(AudioEnum.Explore.BubbleShow)
end

function slot0.onTweenOpenEnd(slot0)
	slot0._tweenId = nil
end

function slot0.setDialogueId(slot0, slot1)
	slot0._id = slot1

	if not slot0.txt then
		return
	end

	slot0.txt.text = lua_explore_bubble.configDict[slot1].content
end

function slot0.onDestroy(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	uv0.super.onDestroy(slot0)
end

return slot0
