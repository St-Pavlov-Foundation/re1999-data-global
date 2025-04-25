module("modules.common.others.LuaListScrollViewWithAnimator", package.seeall)

slot0 = class("LuaListScrollViewWithAnimator", LuaListScrollView)

function slot0.ctor(slot0, slot1, slot2, slot3)
	uv0.super.ctor(slot0, slot1, slot2)

	slot0._animationStartTime = nil
	slot0._animationDelayTimes = slot3
	slot0._firstUpdate = true
	slot0.dontPlayCloseAnimation = false
	slot0.indexOffset = 0
end

function slot0.ResetFirstUpdate(slot0)
	slot0._firstUpdate = true
end

function slot0._getAnimationTime(slot0, slot1)
	if not slot0._animationStartTime then
		return nil
	end

	if slot1 - slot0.indexOffset < 1 then
		return nil
	end

	if not slot0._animationDelayTimes or not slot0._animationDelayTimes[slot1] then
		return nil
	end

	return slot0._animationStartTime + slot0._animationDelayTimes[slot1]
end

function slot0.playOpenAnimation(slot0)
	slot0._animationStartTime = Time.time

	slot0:onModelUpdate()
end

function slot0.changeDelayTime(slot0, slot1)
	if slot1 and slot0._animationDelayTimes then
		for slot5, slot6 in ipairs(slot0._animationDelayTimes) do
			slot0._animationDelayTimes[slot5] = slot6 + slot1
		end
	end
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)

	if slot0.viewContainer.notPlayAnimation then
		return
	end

	slot0:playOpenAnimation()
end

function slot0.onClose(slot0)
	uv0.super.onClose(slot0)

	if slot0.dontPlayCloseAnimation then
		return
	end

	for slot4, slot5 in pairs(slot0._cellCompDict) do
		uv0._playCloseAnimation(slot4)
	end
end

function slot0._onUpdateCell(slot0, slot1, slot2)
	if slot0._firstUpdate then
		slot0._firstUpdate = false
		slot0._animationStartTime = Time.time
	end

	uv0.super._onUpdateCell(slot0, slot1, slot2)

	if not gohelper.findChild(slot1, LuaListScrollView.PrefabInstName) then
		return
	end

	uv0._refreshOpenAnimation(MonoHelper.getLuaComFromGo(slot3, slot0._param.cellClass))
end

slot1 = UnityEngine.Animator.StringToHash(UIAnimationName.Idle)

function slot0._refreshOpenAnimation(slot0)
	if not slot0 then
		return
	end

	if not slot0.getAnimator then
		return
	end

	if not slot0:getAnimator() or not slot1.gameObject.activeInHierarchy then
		return
	end

	if not slot0._view:_getAnimationTime(slot0._index) then
		slot1.speed = 0

		slot1:Play(UIAnimationName.Open, 0, 1)
		slot1:Update(0)
	else
		if not uv0._getOpenAnimLen(slot0) or slot3 >= Time.time - slot2 or not uv0._haveIdleAnim(slot0) then
			slot1.speed = 0

			slot1:Play(UIAnimationName.Open, 0, 0)
			slot1:Update(0)
		else
			slot1:Play(uv1, 0, 0)
		end

		uv0._delayPlayOpenAnimation(slot0)
	end
end

function slot0._getOpenAnimLen(slot0)
	if not slot0 then
		return false
	end

	if slot0.__openAnimLen ~= nil then
		return slot0.__openAnimLen
	end

	if not slot0.getAnimator then
		return false
	end

	for slot6 = 0, slot0:getAnimator().runtimeAnimatorController.animationClips.Length - 1 do
		if slot2[slot6].name:find(UIAnimationName.Open) then
			slot0.__openAnimLen = math.abs(slot7.length)

			break
		end
	end

	slot0.__openAnimLen = slot0.__openAnimLen or false

	return slot0.__openAnimLen
end

function slot0._haveIdleAnim(slot0)
	if not slot0 then
		return false
	end

	if not slot0.getAnimator then
		return false
	end

	return slot0:getAnimator():HasState(0, uv0)
end

function slot0._delayPlayOpenAnimation(slot0)
	if not slot0 then
		return
	end

	if not slot0.getAnimator then
		return
	end

	if not slot0:getAnimator() or not slot1.gameObject.activeInHierarchy then
		return
	end

	if not slot0._view:_getAnimationTime(slot0._index) then
		return
	end

	slot1.speed = 1

	if uv0._getOpenAnimLen(slot0) and slot3 < Time.time - slot0._view:_getAnimationTime(slot0._index) and uv0._haveIdleAnim(slot0) then
		slot1:Play(UIAnimationName.Idle, 0, 0)

		return
	end

	slot1:Play(UIAnimationName.Open, 0, 0)
	slot1:Update(0)

	if slot1:GetCurrentAnimatorStateInfo(0).length <= 0 then
		slot5 = 1
	end

	slot1:Play(UIAnimationName.Open, 0, (Time.time - slot2) / slot5)
	slot1:Update(0)
end

function slot0._playCloseAnimation(slot0)
	if not slot0 then
		return
	end

	if not slot0.getAnimator then
		return
	end

	if slot0:getAnimator() and slot1.gameObject.activeInHierarchy then
		slot1.speed = 1

		slot1:Play(UIAnimationName.Close, 0, 0)
	end
end

function slot0.moveToByCheckFunc(slot0, slot1, slot2, slot3, slot4)
	if not slot1 then
		return
	end

	if not slot0._model:getList() then
		return
	end

	slot6 = nil

	for slot10, slot11 in ipairs(slot5) do
		if slot1(slot11) then
			slot6 = slot10

			break
		end
	end

	if not slot6 then
		return
	end

	slot0:moveToByIndex(slot6, slot2, slot3, slot4)
end

function slot0.moveToByIndex(slot0, slot1, slot2, slot3, slot4)
	slot6 = slot0._csListScroll.gameObject:GetComponent(gohelper.Type_ScrollRect).content
	slot8 = slot0._param.scrollDir == ScrollEnum.ScrollDirV
	slot12 = slot0._param.startSpace + (math.ceil(slot1 / slot0._param.lineCount) - 1) * ((slot8 and slot0._param.cellSpaceV or slot0._param.cellSpaceH) + (slot8 and slot0._param.cellHeight or slot0._param.cellWidth))
	slot13 = 0
	slot12 = (not slot8 or math.min(math.max(0, recthelper.getHeight(slot6) - recthelper.getHeight(slot5.transform)), slot12)) and -math.min(math.max(0, recthelper.getWidth(slot6) - recthelper.getWidth(slot5.transform)), slot12)

	if slot0._moveTweenId then
		ZProj.TweenHelper.KillById(slot0._moveTweenId)

		slot0._moveTweenId = nil
	end

	if slot2 and slot2 > 0 then
		if slot8 then
			slot0._moveTweenId = ZProj.TweenHelper.DOAnchorPosY(slot6, slot12, slot2, slot3, slot4)
		else
			slot0._moveTweenId = ZProj.TweenHelper.DOAnchorPosX(slot6, slot12, slot2, slot3, slot4)
		end
	else
		if slot8 then
			recthelper.setAnchorY(slot6, slot12)
		else
			recthelper.setAnchorX(slot6, slot12)
		end

		if slot3 then
			slot3(slot4)
		end
	end
end

return slot0
