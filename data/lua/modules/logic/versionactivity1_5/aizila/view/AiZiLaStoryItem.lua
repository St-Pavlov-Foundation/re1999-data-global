module("modules.logic.versionactivity1_5.aizila.view.AiZiLaStoryItem", package.seeall)

slot0 = class("AiZiLaStoryItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goLocked = gohelper.findChild(slot0.viewGO, "#go_Locked")
	slot0._txtLockTitleEn = gohelper.findChildText(slot0.viewGO, "#go_Locked/#txt_LockTitleEn")
	slot0._txtLockNum = gohelper.findChildText(slot0.viewGO, "#go_Locked/#txt_LockNum")
	slot0._btnLockReview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Locked/Review/#btn_LockReview")
	slot0._goTxtLocked = gohelper.findChild(slot0.viewGO, "#go_Locked/Review/#btn_LockReview/#go_TxtLocked")
	slot0._goUnLocked = gohelper.findChild(slot0.viewGO, "#go_UnLocked")
	slot0._txtTitleEn = gohelper.findChildText(slot0.viewGO, "#go_UnLocked/#txt_TitleEn")
	slot0._txtNum = gohelper.findChildText(slot0.viewGO, "#go_UnLocked/#txt_Num")
	slot0._simageModIcon1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_UnLocked/#simage_ModIcon1")
	slot0._simageModIcon2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_UnLocked/#simage_ModIcon2")
	slot0._txtModName = gohelper.findChildText(slot0.viewGO, "#go_UnLocked/#txt_ModName")
	slot0._txtModNameEn = gohelper.findChildText(slot0.viewGO, "#go_UnLocked/#txt_ModNameEn")
	slot0._btnReview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_UnLocked/Review/#btn_Review")
	slot0._goTxtReview = gohelper.findChild(slot0.viewGO, "#go_UnLocked/Review/#btn_Review/#go_TxtReview")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnLockReview:AddClickListener(slot0._btnLockReviewOnClick, slot0)
	slot0._btnReview:AddClickListener(slot0._btnReviewOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnLockReview:RemoveClickListener()
	slot0._btnReview:RemoveClickListener()
end

function slot0._btnLockReviewOnClick(slot0)
	GameFacade.showToast(ToastEnum.V1a5AiZiLaStroyLock)
end

function slot0._btnReviewOnClick(slot0)
	if not slot0._storyMO then
		return
	end

	if slot0._storyMO:isLocked() then
		GameFacade.showToast(ToastEnum.V1a5AiZiLaStroyLock)

		return
	end

	StoryController.instance:playStory(slot0._storyMO.storyId, {
		hideStartAndEndDark = true
	})
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._storyMO = slot1

	slot0:_refreshUI()
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	slot0._simageModIcon2:UnLoadImage()
end

function slot0._refreshUI(slot0)
	if not slot0._storyMO then
		return
	end

	slot1 = slot0._storyMO:isLocked()
	slot2 = slot0:_getNumStr(slot0._storyMO.index)
	slot0._txtNum.text = slot2
	slot0._txtLockNum.text = slot2
	slot0._txtModName.text = slot0._storyMO.config.name
	slot0._txtTitleEn.text = slot0._storyMO.config.nameen
	slot0._txtLockTitleEn.text = slot0._storyMO.config.nameen
	slot0._txtModNameEn.text = slot0._storyMO.config.titleen
	slot3 = slot0._storyMO.index == 1

	gohelper.setActive(slot0._simageModIcon2, not slot3)
	gohelper.setActive(slot0._simageModIcon1, slot3)
	gohelper.setActive(slot0._goLocked, slot1)
	gohelper.setActive(slot0._goUnLocked, not slot1)
end

function slot0._getNumStr(slot0, slot1)
	if slot1 < 10 then
		return "0" .. slot1
	end

	return tostring(slot1)
end

slot0.prefabPath = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_storyviewitem.prefab"

return slot0
