module("modules.logic.versionactivity2_0.warmup.view.Act2_0WarmUpLeftView", package.seeall)

local var_0_0 = class("Act2_0WarmUpLeftView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbglight = gohelper.findChildSingleImage(arg_1_0.viewGO, "Middle/eye/#simage_fullbg_light")
	arg_1_0._godrag = gohelper.findChild(arg_1_0.viewGO, "Middle/eye/eye0/#go_drag")
	arg_1_0._goClickArea = gohelper.findChild(arg_1_0.viewGO, "Middle/eye/eye1/#go_ClickArea")
	arg_1_0._simageday = gohelper.findChildSingleImage(arg_1_0.viewGO, "Middle/eye_detail/#simage_day")
	arg_1_0._simagedaybg = gohelper.findChildSingleImage(arg_1_0.viewGO, "Middle/eye_detail/#simage_daybg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

local var_0_1 = SLFramework.AnimatorPlayer

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._middleGo = gohelper.findChild(arg_4_0.viewGO, "Middle")
	arg_4_0._animatorPlayer = var_0_1.Get(arg_4_0._middleGo)
	arg_4_0._animSelf = arg_4_0._animatorPlayer.animator
	arg_4_0._guideGo = gohelper.findChild(arg_4_0.viewGO, "Middle/guide")
	arg_4_0._animatorPlayer_guide = var_0_1.Get(arg_4_0._guideGo)
	arg_4_0._eye0Go = gohelper.findChild(arg_4_0.viewGO, "Middle/eye/eye0")
	arg_4_0._itemClick1 = gohelper.getClickWithAudio(arg_4_0._godrag, AudioEnum.UI.play_ui_common_click_20200111)
	arg_4_0._itemClick2 = gohelper.getClickWithAudio(arg_4_0._goClickArea, AudioEnum.UI.play_ui_common_click_20200111)

	arg_4_0._itemClick1:AddClickListener(arg_4_0._onItemClick, arg_4_0)
	arg_4_0._itemClick2:AddClickListener(arg_4_0._onItemClick, arg_4_0)

	arg_4_0._drag = UIDragListenerHelper.New()
end

function var_0_0._onItemClick(arg_5_0)
	if not arg_5_0.viewContainer:checkLidIsOpened() then
		return
	end

	arg_5_0:playAnim_Eye(true)
end

function var_0_0.onDataUpdateFirst(arg_6_0)
	if not arg_6_0.viewContainer:checkLidIsOpened() then
		arg_6_0._drag:create(arg_6_0._godrag)
		arg_6_0._drag:registerCallback(arg_6_0._drag.EventBegin, arg_6_0._onDragBegin, arg_6_0)
		arg_6_0._drag:registerCallback(arg_6_0._drag.EventEnd, arg_6_0._onDragEnd, arg_6_0)
	end
end

function var_0_0.onDataUpdate(arg_7_0)
	arg_7_0:_refresh()
end

function var_0_0.onSwitchEpisode(arg_8_0)
	arg_8_0:_refresh()
end

function var_0_0.onOpen(arg_9_0)
	return
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	GameUtil.onDestroyViewMember(arg_11_0, "_drag")
	GameUtil.onDestroyViewMember_ClickListener(arg_11_0, "_itemClick1")
	GameUtil.onDestroyViewMember_ClickListener(arg_11_0, "_itemClick2")
	arg_11_0._simagefullbglight:UnLoadImage()
	arg_11_0._simageday:UnLoadImage()
	arg_11_0._simagedaybg:UnLoadImage()
end

function var_0_0._setActive_drag(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._godrag, arg_12_1)
	gohelper.setActive(arg_12_0._guideGo, arg_12_1)
end

function var_0_0._episodeId(arg_13_0)
	return arg_13_0.viewContainer:getCurSelectedEpisode()
end

function var_0_0._refresh(arg_14_0)
	local var_14_0 = arg_14_0:_episodeId()
	local var_14_1 = arg_14_0.viewContainer:checkLidIsOpened()
	local var_14_2 = arg_14_0.viewContainer:checkEyeIsClicked(var_14_0)
	local var_14_3 = arg_14_0.viewContainer:getImgResUrl(arg_14_0.viewContainer:episode2Index(var_14_0))

	arg_14_0._simageday:LoadImage(var_14_3)
	arg_14_0:_setActive_drag(not var_14_1)

	if var_14_2 then
		arg_14_0:_zoomed_Eye()
	elseif var_14_1 then
		arg_14_0:_opened_Eye()
	else
		arg_14_0:_closed_Lid()
	end
end

function var_0_0.openGuide(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0._animatorPlayer_guide:Play("guide_warmup1_loop", arg_15_1, arg_15_2)
end

function var_0_0._onDragBegin(arg_16_0)
	gohelper.setActive(arg_16_0._guideGo, false)
end

function var_0_0._onDragEnd(arg_17_0)
	if arg_17_0.viewContainer:checkLidIsOpened() then
		return
	end

	if arg_17_0._drag:isMoveVerticalMajor() and arg_17_0._drag:isSwipeUp() then
		arg_17_0:playAnim_Lid(true)
	end
end

function var_0_0._playAnim(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_0._animatorPlayer:Play(arg_18_1, arg_18_2, arg_18_3)
end

function var_0_0._playAnimRaw(arg_19_0, arg_19_1, ...)
	arg_19_0._animSelf.enabled = true

	arg_19_0._animSelf:Play(arg_19_1, ...)
end

local var_0_2 = "Act2_0WarmUpLeftView:playAnim_Lid"
local var_0_3 = 9.99

function var_0_0.playAnim_Lid(arg_20_0, arg_20_1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feichi_dooreye_20200112)

	if arg_20_1 == arg_20_0.viewContainer:checkLidIsOpened() then
		return
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(var_0_2, var_0_3, arg_20_0.viewName)

	arg_20_0._animSelf.speed = arg_20_1 and 1 or -1

	arg_20_0:_playAnim("eye1", function()
		arg_20_0.viewContainer:saveLidState(arg_20_1)
		UIBlockHelper.instance:endBlock(var_0_2)
		UIBlockMgrExtend.setNeedCircleMv(true)
	end)
end

local var_0_4 = "Act2_0WarmUpLeftView:playAnim_Eye"

function var_0_0.playAnim_Eye(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:_episodeId()

	if arg_22_1 == arg_22_0.viewContainer:checkEyeIsClicked(var_22_0) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feichi_zoom_20200113)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(var_0_4, var_0_3, arg_22_0.viewName)

	arg_22_0._animSelf.speed = arg_22_1 and 1 or -1

	arg_22_0:_playAnim("eyedetail", function()
		arg_22_0.viewContainer:saveEyeState(var_22_0, arg_22_1)
		arg_22_0.viewContainer:openDesc()
		UIBlockHelper.instance:endBlock(var_0_4)
		UIBlockMgrExtend.setNeedCircleMv(true)
	end)
end

function var_0_0._opened_Eye(arg_24_0)
	arg_24_0:_playAnimRaw("eye1", 0, 1)
end

function var_0_0._closed_Lid(arg_25_0)
	arg_25_0:_playAnimRaw("eye0", 0, 1)
end

function var_0_0._zoomed_Eye(arg_26_0)
	arg_26_0:_playAnimRaw("eyedetail", 0, 1)
end

return var_0_0
