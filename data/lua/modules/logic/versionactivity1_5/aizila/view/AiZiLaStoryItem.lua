module("modules.logic.versionactivity1_5.aizila.view.AiZiLaStoryItem", package.seeall)

local var_0_0 = class("AiZiLaStoryItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goLocked = gohelper.findChild(arg_1_0.viewGO, "#go_Locked")
	arg_1_0._txtLockTitleEn = gohelper.findChildText(arg_1_0.viewGO, "#go_Locked/#txt_LockTitleEn")
	arg_1_0._txtLockNum = gohelper.findChildText(arg_1_0.viewGO, "#go_Locked/#txt_LockNum")
	arg_1_0._btnLockReview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Locked/Review/#btn_LockReview")
	arg_1_0._goTxtLocked = gohelper.findChild(arg_1_0.viewGO, "#go_Locked/Review/#btn_LockReview/#go_TxtLocked")
	arg_1_0._goUnLocked = gohelper.findChild(arg_1_0.viewGO, "#go_UnLocked")
	arg_1_0._txtTitleEn = gohelper.findChildText(arg_1_0.viewGO, "#go_UnLocked/#txt_TitleEn")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "#go_UnLocked/#txt_Num")
	arg_1_0._simageModIcon1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_UnLocked/#simage_ModIcon1")
	arg_1_0._simageModIcon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_UnLocked/#simage_ModIcon2")
	arg_1_0._txtModName = gohelper.findChildText(arg_1_0.viewGO, "#go_UnLocked/#txt_ModName")
	arg_1_0._txtModNameEn = gohelper.findChildText(arg_1_0.viewGO, "#go_UnLocked/#txt_ModNameEn")
	arg_1_0._btnReview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_UnLocked/Review/#btn_Review")
	arg_1_0._goTxtReview = gohelper.findChild(arg_1_0.viewGO, "#go_UnLocked/Review/#btn_Review/#go_TxtReview")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnLockReview:AddClickListener(arg_2_0._btnLockReviewOnClick, arg_2_0)
	arg_2_0._btnReview:AddClickListener(arg_2_0._btnReviewOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnLockReview:RemoveClickListener()
	arg_3_0._btnReview:RemoveClickListener()
end

function var_0_0._btnLockReviewOnClick(arg_4_0)
	GameFacade.showToast(ToastEnum.V1a5AiZiLaStroyLock)
end

function var_0_0._btnReviewOnClick(arg_5_0)
	if not arg_5_0._storyMO then
		return
	end

	if arg_5_0._storyMO:isLocked() then
		GameFacade.showToast(ToastEnum.V1a5AiZiLaStroyLock)

		return
	end

	local var_5_0 = {}

	var_5_0.hideStartAndEndDark = true

	StoryController.instance:playStory(arg_5_0._storyMO.storyId, var_5_0)
end

function var_0_0._editableInitView(arg_6_0)
	return
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
	arg_11_0._simageModIcon2:UnLoadImage()
end

function var_0_0._refreshUI(arg_12_0)
	if not arg_12_0._storyMO then
		return
	end

	local var_12_0 = arg_12_0._storyMO:isLocked()
	local var_12_1 = arg_12_0:_getNumStr(arg_12_0._storyMO.index)

	arg_12_0._txtNum.text = var_12_1
	arg_12_0._txtLockNum.text = var_12_1
	arg_12_0._txtModName.text = arg_12_0._storyMO.config.name
	arg_12_0._txtTitleEn.text = arg_12_0._storyMO.config.nameen
	arg_12_0._txtLockTitleEn.text = arg_12_0._storyMO.config.nameen
	arg_12_0._txtModNameEn.text = arg_12_0._storyMO.config.titleen

	local var_12_2 = arg_12_0._storyMO.index == 1

	gohelper.setActive(arg_12_0._simageModIcon2, not var_12_2)
	gohelper.setActive(arg_12_0._simageModIcon1, var_12_2)
	gohelper.setActive(arg_12_0._goLocked, var_12_0)
	gohelper.setActive(arg_12_0._goUnLocked, not var_12_0)
end

function var_0_0._getNumStr(arg_13_0, arg_13_1)
	if arg_13_1 < 10 then
		return "0" .. arg_13_1
	end

	return tostring(arg_13_1)
end

var_0_0.prefabPath = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_storyviewitem.prefab"

return var_0_0
