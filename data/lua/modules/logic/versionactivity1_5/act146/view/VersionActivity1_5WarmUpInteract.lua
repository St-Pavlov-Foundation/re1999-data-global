module("modules.logic.versionactivity1_5.act146.view.VersionActivity1_5WarmUpInteract", package.seeall)

slot0 = class("VersionActivity1_5WarmUpInteract", BaseView)

function slot0.onInitView(slot0)
	slot0._godragarea = gohelper.findChild(slot0.viewGO, "Middle/#go_dragarea")
	slot0._goguide1 = gohelper.findChild(slot0.viewGO, "Middle/#go_guide1")
	slot0._goguide2 = gohelper.findChild(slot0.viewGO, "Middle/#go_guide2")
	slot0._imagePhotoMask1 = gohelper.findChildImage(slot0.viewGO, "Middle/#go_mail2/image_PhotoMask/#image_PhotoMask1")
	slot0._imagePhotoMask2 = gohelper.findChildImage(slot0.viewGO, "Middle/#go_mail2/image_PhotoMask/#image_PhotoMask2")
	slot0._imagePhotoMask3 = gohelper.findChildImage(slot0.viewGO, "Middle/#go_mail2/image_PhotoMask/#image_PhotoMask3")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Activity146Controller.instance, Activity146Event.DataUpdate, slot0._onDataUpdate, slot0)
	slot0._drag:AddDragListener(slot0._onDragging, slot0)
	slot0._drag:AddDragBeginListener(slot0._onBeginDrag, slot0)
	slot0._drag:AddDragEndListener(slot0._onEndDrag, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(Activity146Controller.instance, Activity146Event.DataUpdate, slot0._onDataUpdate, slot0)
	slot0._drag:RemoveDragListener()
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
end

slot0.InteractType = {
	Counting = 2,
	Vertical = 1
}

function slot0._onBeginDrag(slot0, slot1, slot2)
	if uv0.DragFuncMap[slot0._interactType] and slot3.onBegin then
		slot3.onBegin(slot0, slot1, slot2)
	end
end

function slot0._onDragging(slot0, slot1, slot2)
	if uv0.DragFuncMap[slot0._interactType] and slot3.onDrag then
		slot3.onDrag(slot0, slot1, slot2)
	end
end

function slot0._onEndDrag(slot0, slot1, slot2)
	if uv0.DragFuncMap[slot0._interactType] and slot3.onEnd then
		slot3.onEnd(slot0, slot1, slot2)
	end
end

function slot0._onBeginDragVertical(slot0, slot1, slot2)
	slot0._isPassEpisode = false
	slot0._dragLengthen = 0

	gohelper.setActive(slot0._goguide1, false)
	gohelper.setActive(slot0._goguide2, false)

	slot0._atticletterOpeningId = AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_opening)
end

slot1 = 80

function slot0._onDraggingVertical(slot0, slot1, slot2)
	if not slot0._isPassEpisode and Mathf.Abs(slot2.delta.x) <= Mathf.Abs(slot2.delta.y) then
		slot0._dragLengthen = slot0._dragLengthen + slot4

		if Mathf.Clamp(slot0._dragLengthen / uv0, 0, 1) >= 1 then
			slot0._isPassEpisode = true
		end
	end
end

function slot0._onEndDragVertical(slot0)
	if slot0._isPassEpisode then
		Activity146Controller.instance:dispatchEvent(Activity146Event.OnEpisodeFinished)
	end

	if slot0._atticletterOpeningId then
		AudioMgr.instance:stopPlayingID(slot0._atticletterOpeningId)

		slot0._atticletterOpeningId = nil
	end
end

slot2 = 3
slot3 = 10

function slot0._onBeginDragCounting(slot0, slot1, slot2)
	slot0._isPassEpisode = false
	slot0._dragLengthenX = 0
	slot0._dragLengthenY = 0

	gohelper.setActive(slot0._goguide1, false)
	gohelper.setActive(slot0._goguide2, false)
end

slot4 = {
	"1st",
	"2nd",
	"3rd"
}

function slot0._onDraggingCounting(slot0, slot1, slot2)
	if not slot0._isPassEpisode then
		slot3 = false

		if uv0 < Mathf.Abs(slot2.delta.x) and slot2.delta.x * slot0._dragLengthenX <= 0 then
			slot3 = true
		elseif uv0 < Mathf.Abs(slot2.delta.y) and slot2.delta.y * slot0._dragLengthenY <= 0 then
			slot3 = true
		end

		if slot3 then
			slot0._dragLengthenX = slot2.delta.x
			slot0._dragLengthenY = slot2.delta.y
			slot0._dragCount = slot0._dragCount or 0
			slot0._dragCount = slot0._dragCount + 1

			slot0._photoMaskAnim:Play(uv1[slot0._dragCount] or "idle", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_cleaning)

			if uv2 <= slot0._dragCount then
				slot0._isPassEpisode = true
			end
		end
	end
end

function slot0._onEndDragCounting(slot0)
	if slot0._isPassEpisode then
		Activity146Controller.instance:dispatchEvent(Activity146Event.OnEpisodeFinished)
	end
end

function slot0._editableInitView(slot0)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._godragarea)
	slot0._photoMaskAnim = gohelper.onceAddComponent(gohelper.findChild(slot0.viewGO, "Middle/#go_mail2/image_PhotoMask"), typeof(UnityEngine.Animator))
end

function slot0._onDataUpdate(slot0)
	slot0._interactType = Activity146Config.instance:getEpisodeInteractType(slot0.viewParam.actId, Activity146Model.instance:getCurSelectedEpisode())

	slot0._photoMaskAnim:Play("idle", 0, 0)

	slot0._dragCount = 0
end

slot0.DragFuncMap = {
	[slot0.InteractType.Counting] = {
		onBegin = slot0._onBeginDragCounting,
		onDrag = slot0._onDraggingCounting,
		onEnd = slot0._onEndDragCounting
	},
	[slot0.InteractType.Vertical] = {
		onBegin = slot0._onBeginDragVertical,
		onDrag = slot0._onDraggingVertical,
		onEnd = slot0._onEndDragVertical
	}
}

function slot0.onClose(slot0)
	if slot0._atticletterOpeningId then
		AudioMgr.instance:stopPlayingID(slot0._atticletterOpeningId)

		slot0._atticletterOpeningId = nil
	end
end

return slot0
