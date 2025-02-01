module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessStoryViewItem", package.seeall)

slot0 = class("Activity1_3ChessStoryViewItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._txtNum = gohelper.findChildText(slot0.viewGO, "#txt_Num")
	slot0._txtTitleEn = gohelper.findChildText(slot0.viewGO, "#txt_Num/#txt_TitleEn")
	slot0._goLocked = gohelper.findChild(slot0.viewGO, "#go_Locked")
	slot0._goUnLocked = gohelper.findChild(slot0.viewGO, "#go_UnLocked")
	slot0._simageModIcon = gohelper.findChildSingleImage(slot0.viewGO, "#go_UnLocked/image_UnLockedMod/#simage_ModIcon")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#go_UnLocked/image_UnLockedMod/#simage_ModIcon")
	slot0._txtModName = gohelper.findChildText(slot0.viewGO, "#go_UnLocked/#txt_ModName")
	slot0._btnReview = gohelper.findChildButtonWithAudio(slot0.viewGO, "Review/#btn_Review")
	slot0._goTxtReview = gohelper.findChild(slot0.viewGO, "Review/#btn_Review/#go_TxtReview")
	slot0._goTxtLocked = gohelper.findChild(slot0.viewGO, "Review/#btn_Review/#go_TxtLocked")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnReview:AddClickListener(slot0._btnReviewOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnReview:RemoveClickListener()
end

function slot0._btnReviewOnClick(slot0)
	if not slot0._storyMO then
		return
	end

	if slot0._storyMO:isLocked() then
		GameFacade.showToast(ToastEnum.Va3Act122StoryIsLock)

		return
	end

	slot0._needBg = slot0._storyMO.cfg.needbg == 1

	if slot0._needBg then
		Va3ChessController.instance:dispatchEvent(Va3ChessEvent.StoryReviewSceneActvie, slot0._needBg, slot0._storyMO.cfg.bgPath)
	end

	Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.MapSceneActvie, slot0._needBg)
	StoryController.instance:playStory(slot0._storyMO.storyId, {
		hideStartAndEndDark = true
	}, slot0.afterPlayStory, slot0)
end

function slot0.afterPlayStory(slot0)
	gohelper.setActive(ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO, false)

	if slot0._needBg then
		Va3ChessController.instance:dispatchEvent(Va3ChessEvent.StoryReviewSceneActvie, false)
	end

	Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.MapSceneActvie, true)
end

function slot0._editableInitView(slot0)
	slot0._canvasGroup = gohelper.findChild(slot0.viewGO, "Review"):GetComponent(typeof(UnityEngine.CanvasGroup))
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
	slot0._simageModIcon:UnLoadImage()
end

function slot0._refreshUI(slot0)
	if not slot0._storyMO then
		return
	end

	slot0._txtNum.text = slot0:_getNumStr(slot0._storyMO.index)
	slot0._txtModName.text = slot0._storyMO.cfg.name
	slot0._txtTitleEn.text = slot0._storyMO:isLocked() and "UNKNOWN" or slot0._storyMO.cfg.nameen

	gohelper.setActive(slot0._goLocked, slot1)
	gohelper.setActive(slot0._goUnLocked, not slot1)

	if not slot1 then
		slot0._simageModIcon:LoadImage(string.format("%s.png", slot0._storyMO.cfg.icon), slot0._onLoadIconDone, slot0)
	end

	if slot0._lastIsLocked ~= slot1 then
		slot0._lastIsLocked = slot1
		slot0._canvasGroup.alpha = slot1 and 0.5 or 1
		slot2 = slot1 and "#3B3E47" or "#A69F83"

		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtNum, slot2)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtTitleEn, slot2)
	end
end

function slot0._onLoadIconDone(slot0)
	if slot0._imageicon and not gohelper.isNil(slot0._imageicon) then
		slot0._imageicon:SetNativeSize()
	end
end

function slot0._getNumStr(slot0, slot1)
	if slot1 < 10 then
		return "0" .. slot1
	end

	return tostring(slot1)
end

slot0.prefabPath = "ui/viewres/versionactivity_1_3/v1a3_role2/v1a3_role2_storyviewitem.prefab"

return slot0
