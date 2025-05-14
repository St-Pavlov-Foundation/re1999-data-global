﻿module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessStoryViewItem", package.seeall)

local var_0_0 = class("Activity1_3ChessStoryViewItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "#txt_Num")
	arg_1_0._txtTitleEn = gohelper.findChildText(arg_1_0.viewGO, "#txt_Num/#txt_TitleEn")
	arg_1_0._goLocked = gohelper.findChild(arg_1_0.viewGO, "#go_Locked")
	arg_1_0._goUnLocked = gohelper.findChild(arg_1_0.viewGO, "#go_UnLocked")
	arg_1_0._simageModIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_UnLocked/image_UnLockedMod/#simage_ModIcon")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_UnLocked/image_UnLockedMod/#simage_ModIcon")
	arg_1_0._txtModName = gohelper.findChildText(arg_1_0.viewGO, "#go_UnLocked/#txt_ModName")
	arg_1_0._btnReview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Review/#btn_Review")
	arg_1_0._goTxtReview = gohelper.findChild(arg_1_0.viewGO, "Review/#btn_Review/#go_TxtReview")
	arg_1_0._goTxtLocked = gohelper.findChild(arg_1_0.viewGO, "Review/#btn_Review/#go_TxtLocked")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnReview:AddClickListener(arg_2_0._btnReviewOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnReview:RemoveClickListener()
end

function var_0_0._btnReviewOnClick(arg_4_0)
	if not arg_4_0._storyMO then
		return
	end

	if arg_4_0._storyMO:isLocked() then
		GameFacade.showToast(ToastEnum.Va3Act122StoryIsLock)

		return
	end

	arg_4_0._needBg = arg_4_0._storyMO.cfg.needbg == 1

	local var_4_0 = arg_4_0._storyMO.cfg.bgPath

	if arg_4_0._needBg then
		Va3ChessController.instance:dispatchEvent(Va3ChessEvent.StoryReviewSceneActvie, arg_4_0._needBg, var_4_0)
	end

	Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.MapSceneActvie, arg_4_0._needBg)

	local var_4_1 = {}

	var_4_1.hideStartAndEndDark = true

	StoryController.instance:playStory(arg_4_0._storyMO.storyId, var_4_1, arg_4_0.afterPlayStory, arg_4_0)
end

function var_0_0.afterPlayStory(arg_5_0)
	local var_5_0 = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

	gohelper.setActive(var_5_0, false)

	if arg_5_0._needBg then
		Va3ChessController.instance:dispatchEvent(Va3ChessEvent.StoryReviewSceneActvie, false)
	end

	Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.MapSceneActvie, true)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._canvasGroup = gohelper.findChild(arg_6_0.viewGO, "Review"):GetComponent(typeof(UnityEngine.CanvasGroup))
end

function var_0_0._editableAddEvents(arg_7_0)
	return
end

function var_0_0._editableRemoveEvents(arg_8_0)
	return
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._storyMO = arg_9_1

	arg_9_0:_refreshUI()
end

function var_0_0.onSelect(arg_10_0, arg_10_1)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simageModIcon:UnLoadImage()
end

function var_0_0._refreshUI(arg_12_0)
	if not arg_12_0._storyMO then
		return
	end

	local var_12_0 = arg_12_0._storyMO:isLocked()

	arg_12_0._txtNum.text = arg_12_0:_getNumStr(arg_12_0._storyMO.index)
	arg_12_0._txtModName.text = arg_12_0._storyMO.cfg.name
	arg_12_0._txtTitleEn.text = var_12_0 and "UNKNOWN" or arg_12_0._storyMO.cfg.nameen

	gohelper.setActive(arg_12_0._goLocked, var_12_0)
	gohelper.setActive(arg_12_0._goUnLocked, not var_12_0)

	if not var_12_0 then
		arg_12_0._simageModIcon:LoadImage(string.format("%s.png", arg_12_0._storyMO.cfg.icon), arg_12_0._onLoadIconDone, arg_12_0)
	end

	if arg_12_0._lastIsLocked ~= var_12_0 then
		arg_12_0._lastIsLocked = var_12_0
		arg_12_0._canvasGroup.alpha = var_12_0 and 0.5 or 1

		local var_12_1 = var_12_0 and "#3B3E47" or "#A69F83"

		SLFramework.UGUI.GuiHelper.SetColor(arg_12_0._txtNum, var_12_1)
		SLFramework.UGUI.GuiHelper.SetColor(arg_12_0._txtTitleEn, var_12_1)
	end
end

function var_0_0._onLoadIconDone(arg_13_0)
	if arg_13_0._imageicon and not gohelper.isNil(arg_13_0._imageicon) then
		arg_13_0._imageicon:SetNativeSize()
	end
end

function var_0_0._getNumStr(arg_14_0, arg_14_1)
	if arg_14_1 < 10 then
		return "0" .. arg_14_1
	end

	return tostring(arg_14_1)
end

var_0_0.prefabPath = "ui/viewres/versionactivity_1_3/v1a3_role2/v1a3_role2_storyviewitem.prefab"

return var_0_0
