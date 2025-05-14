module("modules.logic.versionactivity2_1.warmup.view.Act2_1WarmUpLeftView", package.seeall)

local var_0_0 = class("Act2_1WarmUpLeftView", BaseView)

function var_0_0.onInitView(arg_1_0)
	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "Middle")

	arg_1_0._middleGo = var_1_0
	arg_1_0._godrag = gohelper.findChild(var_1_0, "#go_drag")
	arg_1_0._imageicon = gohelper.findChildImage(var_1_0, "#image_icon")

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

local var_0_1 = -1
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = SLFramework.AnimatorPlayer

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._drag = UIDragListenerHelper.New()
	arg_4_0._animatorPlayer = var_0_4.Get(arg_4_0._middleGo)
	arg_4_0._animSelf = arg_4_0._animatorPlayer.animator
	arg_4_0._guideGo = gohelper.findChild(arg_4_0.viewGO, "Middle/guide")
	arg_4_0._animatorPlayer_guide = var_0_4.Get(arg_4_0._guideGo)
	arg_4_0._audioClick = gohelper.getClickWithDefaultAudio(arg_4_0._godrag)
	arg_4_0._draggedState = var_0_1
end

function var_0_0.onDataUpdateFirst(arg_5_0)
	arg_5_0._draggedState = arg_5_0:_checkIsOpen() and var_0_2 or var_0_1

	arg_5_0._drag:create(arg_5_0._godrag)
	arg_5_0._drag:registerCallback(arg_5_0._drag.EventBegin, arg_5_0._onDragBegin, arg_5_0)
	arg_5_0._drag:registerCallback(arg_5_0._drag.EventEnd, arg_5_0._onDragEnd, arg_5_0)
end

function var_0_0.onDataUpdate(arg_6_0)
	arg_6_0:_refresh()
end

function var_0_0.onSwitchEpisode(arg_7_0)
	local var_7_0 = arg_7_0:_checkIsOpen()

	if arg_7_0._draggedState == var_0_2 and not var_7_0 then
		arg_7_0._draggedState = var_0_1 - 1
	elseif arg_7_0._draggedState < var_0_1 and var_7_0 then
		arg_7_0._draggedState = var_0_2
	end

	arg_7_0:_refresh()
end

function var_0_0.onOpen(arg_8_0)
	return
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	GameUtil.onDestroyViewMember(arg_10_0, "_drag")
end

function var_0_0._setActive_drag(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._godrag, arg_11_1)
end

function var_0_0._setActive_guide(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._guideGo, arg_12_1)
end

function var_0_0._episodeId(arg_13_0)
	return arg_13_0.viewContainer:getCurSelectedEpisode()
end

function var_0_0._checkIsOpen(arg_14_0, arg_14_1)
	return arg_14_0.viewContainer:checkIsOpen(arg_14_1 or arg_14_0:_episodeId())
end

function var_0_0._refresh(arg_15_0)
	local var_15_0 = arg_15_0:_episodeId()
	local var_15_1 = arg_15_0:_checkIsOpen(var_15_0)
	local var_15_2 = arg_15_0.viewContainer:getImgSpriteName(arg_15_0.viewContainer:episode2Index(var_15_0))

	UISpriteSetMgr.instance:setV2a1WarmupSprite(arg_15_0._imageicon, var_15_2, true)
	arg_15_0:_setActive_guide(not var_15_1 and arg_15_0._draggedState <= var_0_1)
	arg_15_0:_setActive_drag(not var_15_1)
	arg_15_0:_setBoxState(var_15_1)
end

function var_0_0.openGuide(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._animatorPlayer_guide:Play("guide_warmup1_loop", arg_16_1, arg_16_2)
end

function var_0_0._onDragBegin(arg_17_0)
	arg_17_0:_setActive_guide(false)

	arg_17_0._draggedState = var_0_3
end

function var_0_0._onDragEnd(arg_18_0)
	if arg_18_0:_checkIsOpen() then
		return
	end

	if arg_18_0._drag:isMoveVerticalMajor() and arg_18_0._drag:isSwipeUp() then
		arg_18_0:_playAnim_Box(true)
	end
end

function var_0_0._playAnim(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_0._animatorPlayer:Play(arg_19_1, arg_19_2, arg_19_3)
end

function var_0_0._playAnimRaw(arg_20_0, arg_20_1, ...)
	arg_20_0._animSelf.enabled = true

	arg_20_0._animSelf:Play(arg_20_1, ...)
end

local var_0_5 = "Act2_1WarmUpLeftView:_playAnim_Box"
local var_0_6 = 9.99

function var_0_0._playAnim_Box(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:_episodeId()

	if arg_21_1 == arg_21_0:_checkIsOpen(var_21_0) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wangshi_carton_open_20211603)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(var_0_5, var_0_6, arg_21_0.viewName)

	arg_21_0._animSelf.speed = arg_21_1 and 1 or -1

	arg_21_0:_playAnim("open", function()
		arg_21_0.viewContainer:saveBoxState(var_21_0, arg_21_1)
		arg_21_0.viewContainer:openDesc()
		UIBlockHelper.instance:endBlock(var_0_5)
		UIBlockMgrExtend.setNeedCircleMv(true)
	end)
end

function var_0_0._setBoxState(arg_23_0, arg_23_1)
	arg_23_0:_playAnimRaw(arg_23_1 and "unlock" or "lock", 0, 1)
end

return var_0_0
