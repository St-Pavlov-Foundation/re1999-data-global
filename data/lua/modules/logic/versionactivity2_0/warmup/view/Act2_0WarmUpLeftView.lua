module("modules.logic.versionactivity2_0.warmup.view.Act2_0WarmUpLeftView", package.seeall)

slot0 = class("Act2_0WarmUpLeftView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbglight = gohelper.findChildSingleImage(slot0.viewGO, "Middle/eye/#simage_fullbg_light")
	slot0._godrag = gohelper.findChild(slot0.viewGO, "Middle/eye/eye0/#go_drag")
	slot0._goClickArea = gohelper.findChild(slot0.viewGO, "Middle/eye/eye1/#go_ClickArea")
	slot0._simageday = gohelper.findChildSingleImage(slot0.viewGO, "Middle/eye_detail/#simage_day")
	slot0._simagedaybg = gohelper.findChildSingleImage(slot0.viewGO, "Middle/eye_detail/#simage_daybg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot1 = SLFramework.AnimatorPlayer

function slot0._editableInitView(slot0)
	slot0._middleGo = gohelper.findChild(slot0.viewGO, "Middle")
	slot0._animatorPlayer = uv0.Get(slot0._middleGo)
	slot0._animSelf = slot0._animatorPlayer.animator
	slot0._guideGo = gohelper.findChild(slot0.viewGO, "Middle/guide")
	slot0._animatorPlayer_guide = uv0.Get(slot0._guideGo)
	slot0._eye0Go = gohelper.findChild(slot0.viewGO, "Middle/eye/eye0")
	slot0._itemClick1 = gohelper.getClickWithAudio(slot0._godrag, AudioEnum.UI.play_ui_common_click_20200111)
	slot0._itemClick2 = gohelper.getClickWithAudio(slot0._goClickArea, AudioEnum.UI.play_ui_common_click_20200111)

	slot0._itemClick1:AddClickListener(slot0._onItemClick, slot0)
	slot0._itemClick2:AddClickListener(slot0._onItemClick, slot0)

	slot0._drag = UIDragListenerHelper.New()
end

function slot0._onItemClick(slot0)
	if not slot0.viewContainer:checkLidIsOpened() then
		return
	end

	slot0:playAnim_Eye(true)
end

function slot0.onDataUpdateFirst(slot0)
	if not slot0.viewContainer:checkLidIsOpened() then
		slot0._drag:create(slot0._godrag)
		slot0._drag:registerCallback(slot0._drag.EventBegin, slot0._onDragBegin, slot0)
		slot0._drag:registerCallback(slot0._drag.EventEnd, slot0._onDragEnd, slot0)
	end
end

function slot0.onDataUpdate(slot0)
	slot0:_refresh()
end

function slot0.onSwitchEpisode(slot0)
	slot0:_refresh()
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	GameUtil.onDestroyViewMember(slot0, "_drag")
	GameUtil.onDestroyViewMember_ClickListener(slot0, "_itemClick1")
	GameUtil.onDestroyViewMember_ClickListener(slot0, "_itemClick2")
	slot0._simagefullbglight:UnLoadImage()
	slot0._simageday:UnLoadImage()
	slot0._simagedaybg:UnLoadImage()
end

function slot0._setActive_drag(slot0, slot1)
	gohelper.setActive(slot0._godrag, slot1)
	gohelper.setActive(slot0._guideGo, slot1)
end

function slot0._episodeId(slot0)
	return slot0.viewContainer:getCurSelectedEpisode()
end

function slot0._refresh(slot0)
	slot1 = slot0:_episodeId()

	slot0._simageday:LoadImage(slot0.viewContainer:getImgResUrl(slot0.viewContainer:episode2Index(slot1)))
	slot0:_setActive_drag(not slot0.viewContainer:checkLidIsOpened())

	if slot0.viewContainer:checkEyeIsClicked(slot1) then
		slot0:_zoomed_Eye()
	elseif slot2 then
		slot0:_opened_Eye()
	else
		slot0:_closed_Lid()
	end
end

function slot0.openGuide(slot0, slot1, slot2)
	slot0._animatorPlayer_guide:Play("guide_warmup1_loop", slot1, slot2)
end

function slot0._onDragBegin(slot0)
	gohelper.setActive(slot0._guideGo, false)
end

function slot0._onDragEnd(slot0)
	if slot0.viewContainer:checkLidIsOpened() then
		return
	end

	if slot0._drag:isMoveVerticalMajor() and slot0._drag:isSwipeUp() then
		slot0:playAnim_Lid(true)
	end
end

function slot0._playAnim(slot0, slot1, slot2, slot3)
	slot0._animatorPlayer:Play(slot1, slot2, slot3)
end

function slot0._playAnimRaw(slot0, slot1, ...)
	slot0._animSelf.enabled = true

	slot0._animSelf:Play(slot1, ...)
end

slot2 = "Act2_0WarmUpLeftView:playAnim_Lid"
slot3 = 9.99

function slot0.playAnim_Lid(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feichi_dooreye_20200112)

	if slot1 == slot0.viewContainer:checkLidIsOpened() then
		return
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(uv0, uv1, slot0.viewName)

	slot0._animSelf.speed = slot1 and 1 or -1

	slot0:_playAnim("eye1", function ()
		uv0.viewContainer:saveLidState(uv1)
		UIBlockHelper.instance:endBlock(uv2)
		UIBlockMgrExtend.setNeedCircleMv(true)
	end)
end

slot4 = "Act2_0WarmUpLeftView:playAnim_Eye"

function slot0.playAnim_Eye(slot0, slot1)
	if slot1 == slot0.viewContainer:checkEyeIsClicked(slot0:_episodeId()) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feichi_zoom_20200113)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(uv0, uv1, slot0.viewName)

	slot0._animSelf.speed = slot1 and 1 or -1

	slot0:_playAnim("eyedetail", function ()
		uv0.viewContainer:saveEyeState(uv1, uv2)
		uv0.viewContainer:openDesc()
		UIBlockHelper.instance:endBlock(uv3)
		UIBlockMgrExtend.setNeedCircleMv(true)
	end)
end

function slot0._opened_Eye(slot0)
	slot0:_playAnimRaw("eye1", 0, 1)
end

function slot0._closed_Lid(slot0)
	slot0:_playAnimRaw("eye0", 0, 1)
end

function slot0._zoomed_Eye(slot0)
	slot0:_playAnimRaw("eyedetail", 0, 1)
end

return slot0
