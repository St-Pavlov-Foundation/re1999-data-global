module("modules.logic.activity.view.V1a5_DoubleFestival_PanelSignView", package.seeall)

local var_0_0 = class("V1a5_DoubleFestival_PanelSignView", Activity101SignViewBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_PanelBG")
	arg_1_0._goSign = gohelper.findChild(arg_1_0.viewGO, "Root/#go_Sign")
	arg_1_0._imageSignNext = gohelper.findChildImage(arg_1_0.viewGO, "Root/#go_Sign/#image_SignNext")
	arg_1_0._imageSignNow = gohelper.findChildImage(arg_1_0.viewGO, "Root/#go_Sign/#image_SignNow")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_Descr")
	arg_1_0._scrollItemList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/#scroll_ItemList")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_Close")
	arg_1_0._btnemptyTop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyTop")
	arg_1_0._btnemptyBottom = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyBottom")
	arg_1_0._btnemptyLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyLeft")
	arg_1_0._btnemptyRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyRight")
	arg_1_0._goBlock = gohelper.findChild(arg_1_0.viewGO, "#go_Block")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	Activity101SignViewBase.addEvents(arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0._btnemptyTop:AddClickListener(arg_2_0._btnemptyTopOnClick, arg_2_0)
	arg_2_0._btnemptyBottom:AddClickListener(arg_2_0._btnemptyBottomOnClick, arg_2_0)
	arg_2_0._btnemptyLeft:AddClickListener(arg_2_0._btnemptyLeftOnClick, arg_2_0)
	arg_2_0._btnemptyRight:AddClickListener(arg_2_0._btnemptyRightOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	Activity101SignViewBase.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnemptyTop:RemoveClickListener()
	arg_3_0._btnemptyBottom:RemoveClickListener()
	arg_3_0._btnemptyLeft:RemoveClickListener()
	arg_3_0._btnemptyRight:RemoveClickListener()
end

local var_0_1 = ActivityEnum.Activity.DoubleFestivalSign_1_5
local var_0_2 = "onSwitchEnd"

function var_0_0._btnCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnemptyTopOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnemptyBottomOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._btnemptyLeftOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._btnemptyRightOnClick(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._imageSignNextTran = arg_9_0._imageSignNext.transform
	arg_9_0._imageSignNowTran = arg_9_0._imageSignNow.transform
	arg_9_0._animSelf = arg_9_0._goSign:GetComponent(gohelper.Type_Animator)
	arg_9_0._animEvent = arg_9_0._goSign:GetComponent(gohelper.Type_AnimationEventWrap)

	arg_9_0._animEvent:AddEventListener(var_0_2, arg_9_0._onSwitchEnd, arg_9_0)
	arg_9_0._simageTitle:LoadImage(ResUrl.getV1a5SignSingleBgLang("v1a5_sign_df_title"))
	arg_9_0._simagePanelBG:LoadImage(ResUrl.getV1a5SignSingleBg("v1a5_df_sign_panelbg"))

	arg_9_0._txtDescr.text = ""
end

function var_0_0.onOpen(arg_10_0)
	ActivityType101Model.instance:setCurIndex(nil)

	arg_10_0._lastDay = nil
	arg_10_0._txtLimitTime.text = ""

	arg_10_0:_setActiveBlock(false)
	arg_10_0:internal_set_actId(arg_10_0.viewParam.actId)
	arg_10_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
	arg_10_0:internal_onOpen()

	local var_10_0 = ActivityType101Model.instance:getLastGetIndex(var_0_1)

	arg_10_0:_resetByDay(var_10_0)
	TaskDispatcher.runRepeat(arg_10_0._refreshTimeTick, arg_10_0, 1)
end

function var_0_0.onClose(arg_11_0)
	arg_11_0._animEvent:RemoveEventListener(var_0_2)

	if arg_11_0._fTimer then
		arg_11_0._fTimer:Stop()

		arg_11_0._fTimer = nil
	end

	TaskDispatcher.cancelTask(arg_11_0._refreshTimeTick, arg_11_0)
	arg_11_0:_setActiveBlock(false)
end

function var_0_0.onDestroyView(arg_12_0)
	Activity101SignViewBase._internal_onDestroy(arg_12_0)
	arg_12_0._simageTitle:UnLoadImage()
	arg_12_0._simagePanelBG:UnLoadImage()
	TaskDispatcher.cancelTask(arg_12_0._refreshTimeTick, arg_12_0)
end

function var_0_0.onRefresh(arg_13_0)
	arg_13_0:_refreshList()
	arg_13_0:_refreshTimeTick()
end

function var_0_0._refreshTimeTick(arg_14_0)
	arg_14_0._txtLimitTime.text = arg_14_0:getRemainTimeStr()
end

function var_0_0._setPinStartIndex(arg_15_0, arg_15_1)
	local var_15_0, var_15_1 = arg_15_0:getRewardCouldGetIndex()
	local var_15_2 = var_15_1 <= 4 and 1 or 3

	arg_15_0.viewContainer:getScrollModel():setStartPinIndex(var_15_2)
end

function var_0_0._resetByDay(arg_16_0, arg_16_1)
	local var_16_0 = ActivityType101Config.instance:getDoubleFestivalCOByDay(var_0_1, arg_16_1)

	GameUtil.setActive01(arg_16_0._imageSignNowTran, var_16_0 ~= nil)
	GameUtil.setActive01(arg_16_0._imageSignNextTran, false)

	if var_16_0 then
		UISpriteSetMgr.instance:setV1a5DfSignSprite(arg_16_0._imageSignNow, var_16_0.bgSpriteName)
	end

	arg_16_0._lastDay = arg_16_1

	arg_16_0._animSelf:Play(UIAnimationName.Idle, 0, 1)

	arg_16_0._txtDescr.text = var_16_0.blessContentType or ""
end

function var_0_0._setActiveBlock(arg_17_0, arg_17_1)
	gohelper.setActive(arg_17_0._goBlock, arg_17_1)
end

function var_0_0._tweenSprite(arg_18_0, arg_18_1)
	if not arg_18_1 then
		return
	end

	arg_18_0:_setActiveBlock(true)

	arg_18_0._curDay = arg_18_1

	local var_18_0 = ActivityType101Config.instance:getDoubleFestivalCOByDay(var_0_1, arg_18_0._lastDay)
	local var_18_1 = ActivityType101Config.instance:getDoubleFestivalCOByDay(var_0_1, arg_18_1)

	GameUtil.setActive01(arg_18_0._imageSignNextTran, var_18_1 ~= nil)

	if var_18_1 then
		local var_18_2 = var_18_1.bgSpriteName

		if var_18_0 and var_18_0.bgSpriteName == var_18_2 then
			arg_18_0:_onSwitchEnd()

			return
		end

		UISpriteSetMgr.instance:setV1a5DfSignSprite(arg_18_0._imageSignNext, var_18_2)
	end

	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_5_wulu.play_ui_wulu_seal_cutting_eft)
	arg_18_0._animSelf:Play(UIAnimationName.Switch, 0, 0)
end

function var_0_0._onSwitchEnd(arg_19_0)
	local var_19_0 = arg_19_0._curDay

	arg_19_0:_showWish(var_19_0)
	arg_19_0:_setActiveBlock(false)
end

function var_0_0._showWish(arg_20_0, arg_20_1)
	if not arg_20_1 then
		return
	end

	if not arg_20_0._fTimer then
		arg_20_0._fTimer = FrameTimer.New(nil, 0, 0)
	end

	local var_20_0 = true

	arg_20_0._fTimer:Reset(function()
		if var_20_0 then
			var_20_0 = false

			ViewMgr.instance:openView(ViewName.V1a5_DoubleFestival_WishPanel, {
				day = arg_20_1
			})
		else
			arg_20_0:_resetByDay(arg_20_1)
		end
	end, 1, 2)
	arg_20_0._fTimer:Start()
end

function var_0_0._onCloseView(arg_22_0, arg_22_1)
	if arg_22_1 ~= ViewName.CommonPropView then
		return
	end

	local var_22_0 = ActivityType101Model.instance:getCurIndex()

	if not var_22_0 then
		return
	end

	if arg_22_0._lastDay == var_22_0 then
		return
	end

	arg_22_0:_tweenSprite(var_22_0)
end

return var_0_0
