module("modules.common.others.CustomAnimContainer", package.seeall)

slot0 = BaseViewContainer
slot1 = typeof(SLFramework.AnimatorPlayer)
slot0.superOnContainerInit = slot0.onContainerInit
slot0.superOnPlayOpenTransitionFinish = slot0.onPlayOpenTransitionFinish
slot0.superOnPlayCloseTransitionFinish = slot0.onPlayCloseTransitionFinish
slot0.superDestroyView = slot0.destroyView
slot0.openViewTime = 0.2
slot0.closeViewTime = 0.1
slot0.openViewEase = EaseType.Linear
slot0.closeViewEase = EaseType.Linear
slot2 = nil

function slot0.initForceAnimViewList()
	uv0 = {
		ViewName.HeroGroupEditView,
		ViewName.RougeHeroGroupEditView,
		ViewName.V1a6_CachotHeroGroupEditView,
		ViewName.Season123HeroGroupEditView,
		ViewName.Season123_2_3HeroGroupEditView,
		ViewName.VersionActivity_1_2_HeroGroupEditView,
		ViewName.Act183HeroGroupEditView,
		ViewName.DungeonView,
		ViewName.DungeonStoryEntranceView,
		ViewName.TaskView,
		ViewName.ActivityNormalView,
		ViewName.PowerView,
		ViewName.RoomFormulaView,
		ViewName.RoomBlockPackageGetView,
		ViewName.VersionActivity1_2EnterView
	}
end

function slot0.onContainerInit(slot0)
	uv0.superOnContainerInit(slot0)

	if not slot0.viewGO then
		return
	end

	if not slot0.viewGO:GetComponent(typeof(UnityEngine.Animator)) then
		return
	end

	if slot1:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
		return
	end

	if slot2.length * (1 - slot3) <= 0 then
		return
	end

	uv0.openViewAnimStartTime = Time.time
	uv0.openViewAnimLength = math.min(slot4, 1)
end

function slot0.playOpenTransition(slot0, slot1)
	slot0:_cancelBlock()
	slot0:_stopOpenCloseAnim()

	if not slot0._viewSetting.anim or slot0._viewSetting.anim ~= ViewAnim.Default then
		if not string.nilorempty(slot0._viewSetting.anim) then
			slot0:_setAnimatorRes()

			if not slot1 or not slot1.noBlock then
				slot0:startViewOpenBlock()
			end

			if not gohelper.isNil(slot0:__getAnimatorPlayer()) then
				slot2:Play(slot1 and slot1.anim or "open", slot0.onPlayOpenTransitionFinish, slot0)
			end

			TaskDispatcher.runDelay(slot0.onPlayOpenTransitionFinish, slot0, slot1 and slot1.duration or 2)
		else
			slot0:onPlayOpenTransitionFinish()
		end

		return
	end

	if not slot0._canvasGroup then
		slot0:onPlayOpenTransitionFinish()

		return
	end

	if not slot1 or not slot1.noBlock then
		slot0:startViewOpenBlock()
	end

	slot0:_animSetAlpha(0.01, true)

	slot0._openAnimTweenId = ZProj.TweenHelper.DOTweenFloat(0.01, 1, slot0._viewSetting.customAnimFadeTime and slot0._viewSetting.customAnimFadeTime[1] or uv0.openViewTime, slot0._onOpenTweenFrameCallback, slot0._onOpenTweenFinishCallback, slot0, nil, uv0.openViewEase)

	TaskDispatcher.runDelay(slot0.onPlayOpenTransitionFinish, slot0, 2)
end

function slot0.onPlayOpenTransitionFinish(slot0)
	TaskDispatcher.cancelTask(slot0.onPlayOpenTransitionFinish, slot0)
	slot0:_cancelBlock()
	uv0.superOnPlayOpenTransitionFinish(slot0)
end

function slot0._setAnimatorRes(slot0)
	if string.find(slot0._viewSetting.anim, ".controller") then
		gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.Animator)).runtimeAnimatorController = slot0._abLoader:getAssetItem(slot0._viewSetting.anim):GetResource()
	end
end

function slot0.__getAnimatorPlayer(slot0)
	if not slot0.__animatorPlayer and not gohelper.isNil(slot0.viewGO) then
		slot0.__animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
	end

	return slot0.__animatorPlayer
end

function slot0._onOpenTweenFrameCallback(slot0, slot1)
	if slot0._viewStatus ~= uv0.Status_Opening then
		return
	end

	slot0:_animSetAlpha(slot1, true)
end

function slot0._onOpenTweenFinishCallback(slot0)
	slot0._openAnimTweenId = nil

	if slot0._viewStatus ~= uv0.Status_Opening then
		return
	end

	slot0:_animSetAlpha(1)
	slot0:onPlayOpenTransitionFinish()
end

function slot0._animSetAlpha(slot0, slot1, slot2)
	slot0._canvasGroup.alpha = slot1

	return

	slot3 = slot1

	if slot2 then
		slot3 = slot1 <= 0.0001 and 0 or 1 / slot1
	end

	if not slot0:_animGetBgs() then
		return
	end

	for slot8, slot9 in pairs(slot4) do
		if slot9.gameObject then
			slot9:SetAlpha(slot3)
		end
	end
end

function slot0._animGetBgs(slot0)
	if not slot0._viewSetting.customAnimBg then
		return nil
	end

	if slot0._animBgs then
		return slot0._animBgs
	end

	slot0._animBgs = {}

	for slot4, slot5 in ipairs(slot0._viewSetting.customAnimBg) do
		if gohelper.findChild(slot0.viewGO, slot5) then
			if slot6:GetComponent(typeof(UnityEngine.CanvasRenderer)) then
				table.insert(slot0._animBgs, slot7)
			end

			slot9 = slot6:GetComponentsInChildren(typeof(UnityEngine.CanvasRenderer), true):GetEnumerator()

			while slot9:MoveNext() do
				table.insert(slot0._animBgs, slot9.Current)
			end
		end
	end

	return slot0._animBgs
end

function slot0.animBgUpdate(slot0)
	slot0._animBgs = nil
end

function slot0.playCloseTransition(slot0, slot1)
	slot0:_cancelBlock()
	slot0:_stopOpenCloseAnim()

	if not uv0 then
		uv1.initForceAnimViewList()
	end

	if (not slot0._viewSetting.anim or slot0._viewSetting.anim ~= ViewAnim.Default) and not LuaUtil.tableContains(uv0, slot0.viewName) then
		if not string.nilorempty(slot0._viewSetting.anim) then
			slot0:_setAnimatorRes()

			if not slot1 or not slot1.noBlock then
				slot0:startViewCloseBlock()
			end

			if not gohelper.isNil(slot0:__getAnimatorPlayer()) then
				slot2:Play(slot1 and slot1.anim or "close", slot0.onPlayCloseTransitionFinish, slot0)
			end

			TaskDispatcher.runDelay(slot0.onPlayCloseTransitionFinish, slot0, slot1 and slot1.duration or 2)
		else
			slot0:onPlayCloseTransitionFinish()
		end

		return
	end

	if not slot0._canvasGroup then
		slot0:onPlayCloseTransitionFinish()

		return
	end

	if not slot1 or not slot1.noBlock then
		slot0:startViewCloseBlock()
	end

	slot0:_animSetAlpha(1)

	slot0._closeAnimTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, slot0._viewSetting.customAnimFadeTime and slot0._viewSetting.customAnimFadeTime[2] or uv1.closeViewTime, slot0._onCloseTweenFrameCallback, slot0._onCloseTweenFinishCallback, slot0, nil, uv1.closeViewEase)

	TaskDispatcher.runDelay(slot0.onPlayCloseTransitionFinish, slot0, 2)
end

function slot0.onPlayCloseTransitionFinish(slot0)
	TaskDispatcher.cancelTask(slot0.onPlayCloseTransitionFinish, slot0)
	slot0:_cancelBlock()
	uv0.superOnPlayCloseTransitionFinish(slot0)
end

function slot0._onCloseTweenFrameCallback(slot0, slot1)
	if slot0._viewStatus ~= uv0.Status_Closing then
		return
	end

	slot0:_animSetAlpha(slot1)
end

function slot0._onCloseTweenFinishCallback(slot0)
	slot0._closeAnimTweenId = nil

	if slot0._viewStatus ~= uv0.Status_Closing then
		return
	end

	slot0:_animSetAlpha(0)
	slot0:onPlayCloseTransitionFinish()
end

function slot0.startViewOpenBlock(slot0)
	UIBlockMgr.instance:startBlock(slot0:_getViewOpenBlock())
end

function slot0.startViewCloseBlock(slot0)
	UIBlockMgr.instance:startBlock(slot0:_getViewCloseBlock())
end

function slot0._cancelBlock(slot0)
	UIBlockMgr.instance:endBlock(slot0:_getViewOpenBlock())
	UIBlockMgr.instance:endBlock(slot0:_getViewCloseBlock())
end

function slot0._getViewOpenBlock(slot0)
	if not slot0._viewOpenBlock then
		slot0._viewOpenBlock = slot0.viewName .. "ViewOpenAnim"
	end

	return slot0._viewOpenBlock
end

function slot0._getViewCloseBlock(slot0)
	if not slot0._viewCloseBlock then
		slot0._viewCloseBlock = slot0.viewName .. "ViewCloseAnim"
	end

	return slot0._viewCloseBlock
end

function slot0._stopOpenCloseAnim(slot0)
	if slot0._openAnimTweenId then
		ZProj.TweenHelper.KillById(slot0._openAnimTweenId)

		slot0._openAnimTweenId = nil
	end

	if slot0._closeAnimTweenId then
		ZProj.TweenHelper.KillById(slot0._closeAnimTweenId)

		slot0._closeAnimTweenId = nil
	end

	if not gohelper.isNil(slot0.__animatorPlayer) then
		slot0.__animatorPlayer:Stop()
	end

	TaskDispatcher.cancelTask(slot0.onPlayOpenTransitionFinish, slot0)
	TaskDispatcher.cancelTask(slot0.onPlayCloseTransitionFinish, slot0)
end

function slot0._stopAllAnimatorPlayers(slot0)
	if not gohelper.isNil(slot0.viewGO) and slot0.viewGO:GetComponentsInChildren(uv0, true) then
		for slot5 = 0, slot1.Length - 1 do
			slot1[slot5]:Stop()
		end
	end
end

function slot0.destroyView(slot0)
	slot0:_cancelBlock()
	slot0:_stopOpenCloseAnim()
	slot0:_stopAllAnimatorPlayers()

	slot0.__animatorPlayer = nil

	uv0.superDestroyView(slot0)
end

function slot0.activateCustom()
end

return slot0
