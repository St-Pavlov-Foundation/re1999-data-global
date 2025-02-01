module("modules.logic.versionactivity2_1.warmup.view.Act2_1WarmUpLeftView", package.seeall)

slot0 = class("Act2_1WarmUpLeftView", BaseView)

function slot0.onInitView(slot0)
	slot1 = gohelper.findChild(slot0.viewGO, "Middle")
	slot0._middleGo = slot1
	slot0._godrag = gohelper.findChild(slot1, "#go_drag")
	slot0._imageicon = gohelper.findChildImage(slot1, "#image_icon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot1 = -1
slot2 = 0
slot3 = 1
slot4 = SLFramework.AnimatorPlayer

function slot0._editableInitView(slot0)
	slot0._drag = UIDragListenerHelper.New()
	slot0._animatorPlayer = uv0.Get(slot0._middleGo)
	slot0._animSelf = slot0._animatorPlayer.animator
	slot0._guideGo = gohelper.findChild(slot0.viewGO, "Middle/guide")
	slot0._animatorPlayer_guide = uv0.Get(slot0._guideGo)
	slot0._audioClick = gohelper.getClickWithDefaultAudio(slot0._godrag)
	slot0._draggedState = uv1
end

function slot0.onDataUpdateFirst(slot0)
	slot0._draggedState = slot0:_checkIsOpen() and uv0 or uv1

	slot0._drag:create(slot0._godrag)
	slot0._drag:registerCallback(slot0._drag.EventBegin, slot0._onDragBegin, slot0)
	slot0._drag:registerCallback(slot0._drag.EventEnd, slot0._onDragEnd, slot0)
end

function slot0.onDataUpdate(slot0)
	slot0:_refresh()
end

function slot0.onSwitchEpisode(slot0)
	if slot0._draggedState == uv0 and not slot0:_checkIsOpen() then
		slot0._draggedState = uv1 - 1
	elseif slot0._draggedState < uv1 and slot1 then
		slot0._draggedState = uv0
	end

	slot0:_refresh()
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	GameUtil.onDestroyViewMember(slot0, "_drag")
end

function slot0._setActive_drag(slot0, slot1)
	gohelper.setActive(slot0._godrag, slot1)
end

function slot0._setActive_guide(slot0, slot1)
	gohelper.setActive(slot0._guideGo, slot1)
end

function slot0._episodeId(slot0)
	return slot0.viewContainer:getCurSelectedEpisode()
end

function slot0._checkIsOpen(slot0, slot1)
	return slot0.viewContainer:checkIsOpen(slot1 or slot0:_episodeId())
end

function slot0._refresh(slot0)
	slot1 = slot0:_episodeId()

	UISpriteSetMgr.instance:setV2a1WarmupSprite(slot0._imageicon, slot0.viewContainer:getImgSpriteName(slot0.viewContainer:episode2Index(slot1)), true)
	slot0:_setActive_guide(not slot0:_checkIsOpen(slot1) and slot0._draggedState <= uv0)
	slot0:_setActive_drag(not slot2)
	slot0:_setBoxState(slot2)
end

function slot0.openGuide(slot0, slot1, slot2)
	slot0._animatorPlayer_guide:Play("guide_warmup1_loop", slot1, slot2)
end

function slot0._onDragBegin(slot0)
	slot0:_setActive_guide(false)

	slot0._draggedState = uv0
end

function slot0._onDragEnd(slot0)
	if slot0:_checkIsOpen() then
		return
	end

	if slot0._drag:isMoveVerticalMajor() and slot0._drag:isSwipeUp() then
		slot0:_playAnim_Box(true)
	end
end

function slot0._playAnim(slot0, slot1, slot2, slot3)
	slot0._animatorPlayer:Play(slot1, slot2, slot3)
end

function slot0._playAnimRaw(slot0, slot1, ...)
	slot0._animSelf.enabled = true

	slot0._animSelf:Play(slot1, ...)
end

slot5 = "Act2_1WarmUpLeftView:_playAnim_Box"
slot6 = 9.99

function slot0._playAnim_Box(slot0, slot1)
	if slot1 == slot0:_checkIsOpen(slot0:_episodeId()) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wangshi_carton_open_20211603)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(uv0, uv1, slot0.viewName)

	slot0._animSelf.speed = slot1 and 1 or -1

	slot0:_playAnim("open", function ()
		uv0.viewContainer:saveBoxState(uv1, uv2)
		uv0.viewContainer:openDesc()
		UIBlockHelper.instance:endBlock(uv3)
		UIBlockMgrExtend.setNeedCircleMv(true)
	end)
end

function slot0._setBoxState(slot0, slot1)
	slot0:_playAnimRaw(slot1 and "unlock" or "lock", 0, 1)
end

return slot0
