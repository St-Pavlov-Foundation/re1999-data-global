module("modules.logic.lifecircle.view.LifeCircleRewardView", package.seeall)

local var_0_0 = class("LifeCircleRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtDays = gohelper.findChildText(arg_1_0.viewGO, "TitleBG/#txt_Days")
	arg_1_0._simageIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Icon")
	arg_1_0._goReward = gohelper.findChild(arg_1_0.viewGO, "#go_Reward")
	arg_1_0._scrollitem = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_Reward/#scroll_Reward")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#go_Reward/#scroll_Reward/Viewport/#go_Content")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._click:RemoveClickListener()
end

local var_0_1 = SLFramework.AnimatorPlayer
local var_0_2 = {
	ShowingRewards = 3,
	ShownRewards = 4,
	OpeningBox = 1,
	OpenedBox = 2,
	None = 0
}

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._state = var_0_2.None
	arg_4_0._contentGrid = arg_4_0._goContent:GetComponent(gohelper.Type_GridLayoutGroup)
	arg_4_0._click = gohelper.getClick(arg_4_0.viewGO)
	arg_4_0._animatorPlayer = var_0_1.Get(arg_4_0.viewGO)
	arg_4_0._animSelf = arg_4_0._animatorPlayer.animator
	arg_4_0._scrollitemTrans = arg_4_0._scrollitem.transform
	arg_4_0._goContentTrans = arg_4_0._goContent.transform

	local var_4_0 = arg_4_0._contentGrid.cellSize
	local var_4_1 = arg_4_0._contentGrid.spacing

	arg_4_0._w = recthelper.getWidth(arg_4_0._scrollitemTrans)
	arg_4_0._h = recthelper.getHeight(arg_4_0._scrollitemTrans)
	arg_4_0._colCount = arg_4_0._contentGrid.constraintCount
	arg_4_0._itemHeight = var_4_0.y
	arg_4_0._spacingY = var_4_1.y

	NavigateMgr.instance:addEscape(arg_4_0.viewName, arg_4_0.closeThis, arg_4_0)
	arg_4_0:_setActive_goReward(false)
end

function var_0_0.closeThis(arg_5_0)
	if arg_5_0._state == var_0_2.None then
		arg_5_0:_moveState()
	end

	if not arg_5_0:_allowCloseView() then
		return
	end

	var_0_0.super.closeThis(arg_5_0)
end

function var_0_0.onClickModalMask(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0.onUpdateParam(arg_7_0)
	CommonPropListItem.hasOpen = false
	arg_7_0._contentGrid.enabled = false

	arg_7_0:_setPropItems()

	arg_7_0._txtDays.text = arg_7_0:_loginDayCount()
end

function var_0_0._loginDayCount(arg_8_0)
	return arg_8_0.viewParam.loginDayCount or 0
end

function var_0_0._materialDataMOList(arg_9_0)
	return arg_9_0.viewParam.materialDataMOList or {}
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:onUpdateParam()
end

function var_0_0.onOpenFinish(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_tangren_qiandao_open_25251110)
end

function var_0_0.onClose(arg_12_0)
	FrameTimerController.onDestroyViewMember(arg_12_0, "_fTimer")
	CommonPropListModel.instance:clear()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_shutdown)

	CommonPropListItem.hasOpen = false

	TaskDispatcher.cancelTask(arg_12_0._moveState, arg_12_0)
	NavigateMgr.instance:removeEscape(arg_12_0.viewName)
end

function var_0_0.onDestroyView(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._moveState, arg_13_0)
end

function var_0_0._setPropItems(arg_14_0)
	CommonPropListModel.instance:setPropList(arg_14_0:_materialDataMOList())

	local var_14_0 = arg_14_0:_getContentHeight()

	recthelper.setSize(arg_14_0._goContentTrans, arg_14_0._w, var_14_0)

	arg_14_0._contentGrid.enabled = true

	local var_14_1 = true

	FrameTimerController.onDestroyViewMember(arg_14_0, "_fTimer")

	arg_14_0._fTimer = FrameTimerController.instance:register(function()
		arg_14_0._contentGrid.enabled = var_14_1
		var_14_1 = not var_14_1
	end, 5, 2)

	arg_14_0._fTimer:Start()
end

function var_0_0._setActive_goReward(arg_16_0, arg_16_1)
	gohelper.setActive(arg_16_0._goReward, arg_16_1)
end

function var_0_0._playAnim(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_0._animatorPlayer:Play(arg_17_1, arg_17_2, arg_17_3)
end

function var_0_0._moveState(arg_18_0)
	arg_18_0:_setState(arg_18_0._state + 1)
end

function var_0_0._setState(arg_19_0, arg_19_1)
	if arg_19_1 <= arg_19_0._state then
		return
	end

	arg_19_0._state = arg_19_1

	if arg_19_1 == var_0_2.OpeningBox then
		arg_19_0:_onOpenBoxAnim()
	elseif arg_19_1 == var_0_2.OpenedBox then
		arg_19_0:_onOpenedBox()
	elseif arg_19_1 == var_0_2.ShowingRewards then
		arg_19_0:_onShowingRewards()
	elseif arg_19_1 == var_0_2.ShownRewards then
		-- block empty
	end
end

function var_0_0._onOpenBoxAnim(arg_20_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_tangren_qiandao_leiji_25251111)
	arg_20_0:_playAnim(UIAnimationName.Click, arg_20_0._moveState, arg_20_0)
end

function var_0_0._onOpenedBox(arg_21_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_rewards_rare_2000081)
	arg_21_0:_setActive_goReward(true)
	arg_21_0:_moveState()
end

function var_0_0._onShowingRewards(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._moveState, arg_22_0)
	TaskDispatcher.runDelay(arg_22_0._moveState, arg_22_0, 0.8)
end

function var_0_0._allowCloseView(arg_23_0)
	return arg_23_0._state >= var_0_2.ShownRewards
end

function var_0_0._getContentHeight(arg_24_0)
	local var_24_0 = #CommonPropListModel.instance:getList()
	local var_24_1 = arg_24_0._colCount
	local var_24_2 = arg_24_0._itemHeight
	local var_24_3 = arg_24_0._spacingY
	local var_24_4 = math.max(1, math.ceil(var_24_0 / var_24_1))
	local var_24_5 = math.max(arg_24_0._h, arg_24_0._contentGrid.preferredHeight)

	return (math.max(var_24_5, (var_24_4 - 1) * var_24_3 + var_24_2 * var_24_4))
end

return var_0_0
