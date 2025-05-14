module("modules.logic.activity.view.V1a5_DoubleFestival_FullSignView", package.seeall)

local var_0_0 = class("V1a5_DoubleFestival_FullSignView", Activity101SignViewBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._goSign = gohelper.findChild(arg_1_0.viewGO, "Root/#go_Sign")
	arg_1_0._imageSignNext = gohelper.findChildImage(arg_1_0.viewGO, "Root/#go_Sign/#image_SignNext")
	arg_1_0._imageSignNow = gohelper.findChildImage(arg_1_0.viewGO, "Root/#go_Sign/#image_SignNow")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_Descr")
	arg_1_0._scrollItemList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/#scroll_ItemList")
	arg_1_0._goBlock = gohelper.findChild(arg_1_0.viewGO, "#go_Block")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	Activity101SignViewBase.addEvents(arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	Activity101SignViewBase.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
end

local var_0_1 = ActivityEnum.Activity.DoubleFestivalSign_1_5
local var_0_2 = "onSwitchEnd"

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._imageSignNextTran = arg_4_0._imageSignNext.transform
	arg_4_0._imageSignNowTran = arg_4_0._imageSignNow.transform
	arg_4_0._animSelf = arg_4_0._goSign:GetComponent(gohelper.Type_Animator)
	arg_4_0._animEvent = arg_4_0._goSign:GetComponent(gohelper.Type_AnimationEventWrap)

	arg_4_0._animEvent:AddEventListener(var_0_2, arg_4_0._onSwitchEnd, arg_4_0)
	arg_4_0._simageTitle:LoadImage(ResUrl.getV1a5SignSingleBgLang("v1a5_sign_df_title"))
	arg_4_0._simageFullBG:LoadImage(ResUrl.getV1a5SignSingleBg("v1a5_df_sign_fullbg"))

	arg_4_0._txtDescr.text = ""
end

function var_0_0.onOpen(arg_5_0)
	ActivityType101Model.instance:setCurIndex(nil)

	arg_5_0._lastDay = nil
	arg_5_0._txtLimitTime.text = ""

	arg_5_0:_setActiveBlock(false)
	arg_5_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
	arg_5_0:internal_onOpen()

	local var_5_0 = ActivityType101Model.instance:getLastGetIndex(var_0_1)

	arg_5_0:_resetByDay(var_5_0)
	TaskDispatcher.runRepeat(arg_5_0._refreshTimeTick, arg_5_0, 1)
end

function var_0_0.onClose(arg_6_0)
	arg_6_0._animEvent:RemoveEventListener(var_0_2)

	if arg_6_0._fTimer then
		arg_6_0._fTimer:Stop()

		arg_6_0._fTimer = nil
	end

	arg_6_0._isFirstUpdateScrollPos = nil

	TaskDispatcher.cancelTask(arg_6_0._refreshTimeTick, arg_6_0)
	arg_6_0:_setActiveBlock(false)
end

function var_0_0.onDestroyView(arg_7_0)
	Activity101SignViewBase._internal_onDestroy(arg_7_0)
	arg_7_0._simageTitle:UnLoadImage()
	arg_7_0._simageFullBG:UnLoadImage()
	TaskDispatcher.cancelTask(arg_7_0._refreshTimeTick, arg_7_0)
end

function var_0_0.onRefresh(arg_8_0)
	arg_8_0:_refreshList()
	arg_8_0:_refreshTimeTick()
end

function var_0_0._refreshTimeTick(arg_9_0)
	arg_9_0._txtLimitTime.text = arg_9_0:getRemainTimeStr()
end

function var_0_0._setPinStartIndex(arg_10_0, arg_10_1)
	local var_10_0, var_10_1 = arg_10_0:getRewardCouldGetIndex()
	local var_10_2 = var_10_1 <= 4 and 1 or 3

	arg_10_0.viewContainer:getScrollModel():setStartPinIndex(var_10_2)
end

function var_0_0._resetByDay(arg_11_0, arg_11_1)
	local var_11_0 = ActivityType101Config.instance:getDoubleFestivalCOByDay(var_0_1, arg_11_1)

	GameUtil.setActive01(arg_11_0._imageSignNowTran, var_11_0 ~= nil)
	GameUtil.setActive01(arg_11_0._imageSignNextTran, false)

	if var_11_0 then
		UISpriteSetMgr.instance:setV1a5DfSignSprite(arg_11_0._imageSignNow, var_11_0.bgSpriteName)
	end

	arg_11_0._lastDay = arg_11_1

	arg_11_0._animSelf:Play(UIAnimationName.Idle, 0, 1)

	arg_11_0._txtDescr.text = var_11_0.blessContentType or ""
end

function var_0_0._setActiveBlock(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._goBlock, arg_12_1)
end

function var_0_0._tweenSprite(arg_13_0, arg_13_1)
	if not arg_13_1 then
		return
	end

	arg_13_0:_setActiveBlock(true)

	arg_13_0._curDay = arg_13_1

	local var_13_0 = ActivityType101Config.instance:getDoubleFestivalCOByDay(var_0_1, arg_13_0._lastDay)
	local var_13_1 = ActivityType101Config.instance:getDoubleFestivalCOByDay(var_0_1, arg_13_1)

	GameUtil.setActive01(arg_13_0._imageSignNextTran, var_13_1 ~= nil)

	if var_13_1 then
		local var_13_2 = var_13_1.bgSpriteName

		if var_13_0 and var_13_0.bgSpriteName == var_13_2 then
			arg_13_0:_onSwitchEnd()

			return
		end

		UISpriteSetMgr.instance:setV1a5DfSignSprite(arg_13_0._imageSignNext, var_13_2)
	end

	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_5_wulu.play_ui_wulu_seal_cutting_eft)
	arg_13_0._animSelf:Play(UIAnimationName.Switch, 0, 0)
end

function var_0_0._onSwitchEnd(arg_14_0)
	local var_14_0 = arg_14_0._curDay

	arg_14_0:_showWish(var_14_0)
	arg_14_0:_setActiveBlock(false)
end

function var_0_0._showWish(arg_15_0, arg_15_1)
	if not arg_15_1 then
		return
	end

	if not arg_15_0._fTimer then
		arg_15_0._fTimer = FrameTimer.New(nil, 0, 0)
	end

	local var_15_0 = true

	arg_15_0._fTimer:Reset(function()
		if var_15_0 then
			var_15_0 = false

			ViewMgr.instance:openView(ViewName.V1a5_DoubleFestival_WishPanel, {
				day = arg_15_1
			})
		else
			arg_15_0:_resetByDay(arg_15_1)
		end
	end, 1, 2)
	arg_15_0._fTimer:Start()
end

function var_0_0._onCloseView(arg_17_0, arg_17_1)
	if arg_17_1 ~= ViewName.CommonPropView then
		return
	end

	local var_17_0 = ActivityType101Model.instance:getCurIndex()

	if not var_17_0 then
		return
	end

	if arg_17_0._lastDay == var_17_0 then
		return
	end

	arg_17_0:_tweenSprite(var_17_0)
end

return var_0_0
