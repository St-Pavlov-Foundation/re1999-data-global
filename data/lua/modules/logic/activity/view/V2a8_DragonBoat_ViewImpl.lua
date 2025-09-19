module("modules.logic.activity.view.V2a8_DragonBoat_ViewImpl", package.seeall)

local var_0_0 = SLFramework.AnimatorPlayer
local var_0_1 = SLFramework.UGUI.UIDragListener
local var_0_2 = SLFramework.UGUI.UIClickListener
local var_0_3 = class("V2a8_DragonBoat_ViewImpl", Activity101SignViewBase)

function var_0_3._createList(arg_1_0)
	if arg_1_0.__itemList then
		return
	end

	recthelper.setWidth(arg_1_0.viewContainer:getScrollContentTranform(), arg_1_0:calcContentWidth())

	arg_1_0.__itemList = {}

	arg_1_0:_createListDirectly()
end

function var_0_3._updateScrollViewPos(arg_2_0)
	if arg_2_0._isFirstUpdateScrollPos then
		return
	end

	arg_2_0._isFirstUpdateScrollPos = true

	arg_2_0:updateRewardCouldGetHorizontalScrollPixel(function(arg_3_0)
		return arg_3_0 - 1
	end)
end

function var_0_3.addEvents(arg_4_0)
	var_0_3.super.addEvents(arg_4_0)
end

function var_0_3.removeEvents(arg_5_0)
	var_0_3.super.removeEvents(arg_5_0)
end

function var_0_3._editableInitView(arg_6_0)
	arg_6_0._txtLimitTime.text = ""
	arg_6_0._txt_dec.text = ""
	arg_6_0._leftAnimPlayer = var_0_0.Get(arg_6_0._leftGo)
	arg_6_0._leftAnimator = arg_6_0._leftAnimPlayer.animator
	arg_6_0._leftAnimEvent = gohelper.onceAddComponent(arg_6_0.viewGO, gohelper.Type_AnimationEventWrap)
	arg_6_0._animEvent = gohelper.onceAddComponent(arg_6_0._leftGo, gohelper.Type_AnimationEventWrap)

	arg_6_0._animEvent:AddEventListener("play_ui_mln_no_effect", arg_6_0._onplay_ui_mln_no_effect, arg_6_0)

	arg_6_0._drag = var_0_1.Get(arg_6_0._scrollItemListGo)

	arg_6_0._drag:AddDragBeginListener(arg_6_0._onDragBeginHandler, arg_6_0)
	arg_6_0._drag:AddDragEndListener(arg_6_0._onDragEndHandler, arg_6_0)

	arg_6_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_6_0._scrollItemListGo, DungeonMapEpisodeAudio, arg_6_0._scrollItemList)
	arg_6_0._touch = var_0_2.Get(arg_6_0._scrollItemListGo)

	arg_6_0._touch:AddClickDownListener(arg_6_0._onClickDownHandler, arg_6_0)
	arg_6_0:_setActive_normalGo(false)
	arg_6_0:_setActive_cangetGo(false)
	arg_6_0:_setActive_hasgetGo(false)
end

function var_0_3.onOpen(arg_7_0)
	arg_7_0:internal_set_actId(arg_7_0.viewParam.actId)
	arg_7_0:internal_onOpen()
	arg_7_0:_clearTimeTick()
	TaskDispatcher.runRepeat(arg_7_0._refreshTimeTick, arg_7_0, 1)
	arg_7_0:_playAnim_None()
end

function var_0_3._clearTimeTick(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._refreshTimeTick, arg_8_0)
end

function var_0_3._refreshTimeTick(arg_9_0)
	arg_9_0._txtLimitTime.text = arg_9_0:getRemainTimeStr()
end

function var_0_3.onClose(arg_10_0)
	arg_10_0:_clearTimeTick()
	var_0_3.super.onClose(arg_10_0)
end

function var_0_3.onDestroyView(arg_11_0)
	arg_11_0._animEvent:RemoveAllEventListener()
	arg_11_0:_clearTimeTick()
	arg_11_0:_setIntOnAnime(nil)

	if arg_11_0._drag then
		arg_11_0._drag:RemoveDragBeginListener()
		arg_11_0._drag:RemoveDragEndListener()
	end

	arg_11_0._drag = nil

	if arg_11_0._touch then
		arg_11_0._touch:RemoveClickDownListener()
	end

	arg_11_0._touch = nil

	if arg_11_0._audioScroll then
		arg_11_0._audioScroll:onDestroy()
	end

	arg_11_0._audioScroll = nil

	Activity101SignViewBase._internal_onDestroy(arg_11_0)
	var_0_3.super.onDestroyView(arg_11_0)
end

function var_0_3.onRefresh(arg_12_0)
	arg_12_0:_refreshList()
	arg_12_0:_refreshTimeTick()
	arg_12_0:_refreshRightTop()
	arg_12_0:_refreshLeft()
	arg_12_0:_updateScrollViewPos()
end

function var_0_3._refreshLeft(arg_13_0)
	local var_13_0 = arg_13_0.viewContainer:getMoonFestivalSignMaxDay()
	local var_13_1 = false

	for iter_13_0 = 1, var_13_0 do
		if arg_13_0.viewContainer:isType101RewardCouldGet(iter_13_0) and not arg_13_0.viewContainer:isStateDone(iter_13_0) then
			var_13_1 = true

			break
		end
	end

	arg_13_0:_setActive_btnstartGO(var_13_1)
end

function var_0_3._refreshRightTop(arg_14_0)
	local var_14_0 = arg_14_0.viewContainer:getCurrentTaskCO()

	if not var_14_0 then
		arg_14_0._txt_dec.text = ""

		return
	end

	local var_14_1 = GameUtil.splitString2(var_14_0.bonus, true)[1]
	local var_14_2 = arg_14_0.viewContainer:isFinishedTask(var_14_0.id)
	local var_14_3 = arg_14_0.viewContainer:isRewardable(var_14_0.id)

	arg_14_0:_setActive_cangetGo(var_14_3)
	arg_14_0:_setActive_hasgetGo(var_14_2)
	arg_14_0:_setActive_normalGo(not var_14_3 and not var_14_2)

	arg_14_0._txt_dec.text = var_14_0.taskDesc
	arg_14_0._bonusItem = var_14_1
end

function var_0_3._onItemClick(arg_15_0)
	if not arg_15_0.viewContainer:sendGet101SpBonusRequest(arg_15_0._onReceiveGet101SpBonusReplySucc, arg_15_0) and arg_15_0._bonusItem then
		MaterialTipController.instance:showMaterialInfo(arg_15_0._bonusItem[1], arg_15_0._bonusItem[2])
	end
end

function var_0_3._setActive_normalGo(arg_16_0, arg_16_1)
	gohelper.setActive(arg_16_0._normalGo, arg_16_1)
end

function var_0_3._setActive_cangetGo(arg_17_0, arg_17_1)
	gohelper.setActive(arg_17_0._cangetGo, arg_17_1)
end

function var_0_3._setActive_hasgetGo(arg_18_0, arg_18_1)
	gohelper.setActive(arg_18_0._hasgetGo, arg_18_1)
end

function var_0_3._setActive_btnstartGO(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0._btnstartGO, arg_19_1)
end

function var_0_3._onReceiveGet101SpBonusReplySucc(arg_20_0)
	arg_20_0:_refreshRightTop()

	if not ActivityType101Model.instance:isType101SpRewardCouldGetAnyOne(arg_20_0:actId()) then
		RedDotRpc.instance:sendGetRedDotInfosRequest({
			RedDotEnum.DotNode.ActivityNoviceTab
		})
	end
end

function var_0_3._playAnim(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	arg_21_0._leftAnimator.enabled = true

	arg_21_0._leftAnimPlayer:Play(arg_21_1, arg_21_2 or function()
		return
	end, arg_21_3)
end

function var_0_3._playAnim_None(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0:_playAnim(UIAnimationName.None, arg_23_1, arg_23_2)
end

function var_0_3._playAnim_Open(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0:_playAnim(UIAnimationName.Open, arg_24_1, arg_24_2)
end

function var_0_3._getTargetDay(arg_25_0)
	local var_25_0 = arg_25_0.viewContainer:getFirstAvailableIndex()
	local var_25_1 = arg_25_0.viewContainer:getMoonFestivalSignMaxDay()

	if var_25_1 < var_25_0 then
		return
	end

	for iter_25_0 = var_25_0 == 0 and 1 or var_25_0, var_25_1 do
		if arg_25_0.viewContainer:isPlayAnimAvaliable(iter_25_0) then
			return iter_25_0
		end
	end

	return nil
end

function var_0_3._onClickMedicinalBath(arg_26_0)
	local var_26_0 = arg_26_0:_getTargetDay()

	if not var_26_0 then
		return
	end

	if arg_26_0:_isOnAnime() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.play_ui_fuleyuan_yaoyu_make)
	arg_26_0:focusByIndex(var_26_0 - 1)
	arg_26_0:_setIntOnAnime(var_26_0)
	arg_26_0:_playAnim_Open(arg_26_0._onOpenAnimDone, arg_26_0)
end

function var_0_3._getPrefsKeyPrefix_OnAnime(arg_27_0)
	return arg_27_0.viewContainer:getPrefsKeyPrefix() .. "OnAnime"
end

function var_0_3._setIntOnAnime(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0:_getPrefsKeyPrefix_OnAnime()

	arg_28_0.viewContainer:saveInt(var_28_0, arg_28_1 or 0)
end

function var_0_3._getIntOnAnime(arg_29_0)
	local var_29_0 = arg_29_0:_getPrefsKeyPrefix_OnAnime()

	return arg_29_0.viewContainer:getInt(var_29_0, 0)
end

function var_0_3._isOnAnime(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:_getIntOnAnime()

	if arg_30_1 then
		return var_30_0 == arg_30_1
	end

	return var_30_0 > 0
end

function var_0_3._onOpenAnimDone(arg_31_0)
	local var_31_0 = arg_31_0:_getIntOnAnime()
	local var_31_1 = arg_31_0:getItemByIndex(var_31_0)

	if not var_31_1 then
		if arg_31_0:_isOnAnime() then
			arg_31_0:_setIntOnAnime(nil)
			arg_31_0:_playAnim_None()
		end

		return
	end

	var_31_1:playAnim_unlock(arg_31_0._saveStateDone, arg_31_0)
end

function var_0_3._saveStateDone(arg_32_0)
	local var_32_0 = arg_32_0:_getIntOnAnime()

	arg_32_0:_setIntOnAnime(nil)

	if not var_32_0 or var_32_0 == 0 then
		return
	end

	arg_32_0.viewContainer:saveStateDone(var_32_0, true)
	arg_32_0:_refreshLeft()
	arg_32_0:_playAnim_None()
end

function var_0_3._onDragBeginHandler(arg_33_0)
	arg_33_0._audioScroll:onDragBegin()
end

function var_0_3._onDragEndHandler(arg_34_0)
	arg_34_0._audioScroll:onDragEnd()
end

function var_0_3._onClickDownHandler(arg_35_0)
	arg_35_0._audioScroll:onClickDown()
end

function var_0_3._onplay_ui_mln_no_effect(arg_36_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_no_effect)
end

return var_0_3
