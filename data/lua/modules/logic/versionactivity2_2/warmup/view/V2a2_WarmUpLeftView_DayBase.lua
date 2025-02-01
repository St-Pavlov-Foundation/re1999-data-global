module("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_DayBase", package.seeall)

slot0 = class("V2a2_WarmUpLeftView_DayBase", RougeSimpleItemBase)
slot1 = SLFramework.AnimatorPlayer
slot2 = ZProj.TweenHelper
slot3 = -1
slot4 = 0
slot5 = 1

function slot0.ctor(slot0, slot1)
	RougeSimpleItemBase.ctor(slot0, slot1)
	slot0:markIsFinishedInteractive(false)
end

function slot0._editableInitView(slot0)
	RougeSimpleItemBase._editableInitView(slot0)

	slot0._beforeGo = gohelper.findChild(slot0.viewGO, "before")
	slot0._afterGo = gohelper.findChild(slot0.viewGO, "after")
	slot0._animPlayer_before = uv0.Get(slot0._beforeGo)
	slot0._animPlayer_after = uv0.Get(slot0._afterGo)
	slot0._anim_before = slot0._animPlayer_before and slot0._animPlayer_before.animator
	slot0._anim_after = slot0._animPlayer_after and slot0._animPlayer_after.animator

	slot0:setActive_before(false)
	slot0:setActive_after(false)

	slot0._guideState = uv1
	slot0._isDestroying = false
end

function slot0.episodeId(slot0)
	return slot0._episodeId
end

function slot0._internal_setEpisode(slot0, slot1)
	slot0._episodeId = slot1
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0.viewGO, slot1)
end

function slot0.setActive_before(slot0, slot1)
	gohelper.setActive(slot0._beforeGo, slot1)
end

function slot0.setActive_after(slot0, slot1)
	gohelper.setActive(slot0._afterGo, slot1)
end

function slot0.saveState(slot0, slot1)
	assert(slot1 ~= 1999, "please call saveStateDone instead")
	slot0:_assetGetViewContainer():saveState(slot0:episodeId(), slot1)
end

function slot0.getState(slot0, slot1)
	return slot0:_assetGetViewContainer():getState(slot0:episodeId(), slot1)
end

function slot0.saveStateDone(slot0, slot1)
	slot0:_assetGetViewContainer():saveStateDone(slot0:episodeId(), slot1)
end

function slot0.checkIsDone(slot0)
	return slot0:_assetGetViewContainer():checkIsDone(slot0:episodeId())
end

function slot0.openDesc(slot0)
	return slot0:_assetGetViewContainer():openDesc()
end

function slot0.setPosToEnd(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = recthelper.rectToRelativeAnchorPos(slot1.position, slot2.parent)

	if slot3 then
		slot0._tweenIds = slot0._tweenIds or {}

		uv0.KillByObj(slot2)
		table.insert(slot0._tweenIds, uv0.DOAnchorPos(slot2, slot7.x, slot7.y, slot4 or 0.2, slot5, slot6))
	else
		recthelper.setAnchor(slot2, slot7.x, slot7.y)
	end
end

function slot0.tweenAnchorPos(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	GameUtil.onDestroyViewMember_TweenId(slot0, "_tweenId_DOAnchorPos")

	slot0._tweenId_DOAnchorPos = uv0.DOAnchorPos(slot1, slot2, slot3, slot4 or 0.2, slot5, slot6)
end

function slot0.onDestroyView(slot0)
	slot0._isDestroying = true

	GameUtil.onDestroyViewMember_TweenId(slot0, "_tweenId_DOAnchorPos")

	if slot0._tweenIds then
		for slot4, slot5 in ipairs(slot0._tweenIds) do
			uv0.KillById(slot5)
		end

		slot0._tweenIds = nil
	end

	CommonDragHelper.instance:setGlobalEnabled(true)
	RougeSimpleItemBase.onDestroyView(slot0)
end

function slot11()
end

for slot15, slot16 in ipairs({
	"click",
	"click_r",
	"in",
	"out",
	"finish",
	"idle",
	"loop"
}) do
	slot0["playAnim_before_" .. slot16] = function (slot0, slot1, slot2)
		if not slot0._beforeGo.activeInHierarchy then
			slot0:setActive_before(true)
		end

		slot0._animPlayer_before:Play(uv0, slot1 or uv1, slot2)
	end

	slot0["playAnimRaw_before_" .. slot16] = function (slot0, slot1, slot2)
		slot3 = slot0._anim_before
		slot3.enabled = true

		slot3:Play(uv0, slot1, slot2)
	end

	slot0["playAnim_after_" .. slot16] = function (slot0, slot1, slot2)
		if not slot0._afterGo.activeInHierarchy then
			slot0:setActive_after(true)
		end

		slot0._animPlayer_after:Play(uv0, slot1 or uv1, slot2)
	end

	slot0["playAnimRaw_after_" .. slot16] = function (slot0, slot1, slot2)
		slot3 = slot0._anim_after
		slot3.enabled = true

		slot3:Play(uv0, slot1, slot2)
	end
end

function slot0.markGuided(slot0)
	slot0._guideState = uv0
end

function slot0.markIsFinishedInteractive(slot0, slot1)
	slot0._isFinishInteractive = slot1
end

function slot0.isFinishInteractive(slot0)
	return slot0._isFinishInteractive
end

function slot0._onDragBegin(slot0)
	slot0:_setActive_guide(false)
	slot0:markGuided()
end

function slot0._setActive_guide(slot0, slot1)
	gohelper.setActive(slot0._guideGo, slot1)
end

function slot0.setData(slot0)
	if slot0:isFinishInteractive() then
		return
	end

	if slot0._isDestroying then
		return
	end

	CommonDragHelper.instance:setGlobalEnabled(true)
	slot0:_setActive_guide(not slot0:checkIsDone() and slot0._guideState <= uv0)
end

function slot0.onDataUpdateFirst(slot0)
	slot0._guideState = slot0:checkIsDone() and uv0 or uv1

	slot0:_setActive_guide(true)
end

function slot0.onDataUpdate(slot0)
	if slot0:isFinishInteractive() then
		return
	end

	slot0:setData()
end

function slot0.onSwitchEpisode(slot0)
	if slot0._guideState == uv0 and not slot0:checkIsDone() then
		slot0._guideState = uv1 - 1
	elseif slot0._guideState < uv1 and slot1 then
		slot0._guideState = uv0
	end

	slot0:setData()
end

return slot0
