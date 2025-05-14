module("modules.logic.versionactivity2_5.act187.view.Activity187View", package.seeall)

local var_0_0 = class("Activity187View", BaseView)
local var_0_1 = 0.5
local var_0_2 = 1

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtremainTime = gohelper.findChildText(arg_1_0.viewGO, "#go_title/image_TimeBG/#txt_remainTime")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.viewGO, "#go_lantern/#txt_index")
	arg_1_0._btnleft = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#go_lantern/#btn_left")
	arg_1_0._golowribbon = gohelper.findChild(arg_1_0.viewGO, "#go_lantern/#go_decorationLower")
	arg_1_0._simagelantern = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_lantern/#simage_lantern/#simage_lantern1")
	arg_1_0._btnlantern = gohelper.findChildClick(arg_1_0.viewGO, "#go_lantern/#simage_lantern/#btn_click")
	arg_1_0._goupribbon = gohelper.findChild(arg_1_0.viewGO, "#go_lantern/#go_decorationUpper")
	arg_1_0._simagepicture = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_lantern/#simage_lantern/#simage_picture")
	arg_1_0._gotail = gohelper.findChild(arg_1_0.viewGO, "#go_lantern/#simage_lantern/#go_tail")
	arg_1_0._goincomplete = gohelper.findChild(arg_1_0.viewGO, "#go_lantern/#simage_lantern/#go_tail/#go_incomplete")
	arg_1_0._btnshowRiddles = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#go_lantern/#simage_lantern/#go_tail/#btn_showRiddles")
	arg_1_0._goriddles = gohelper.findChild(arg_1_0.viewGO, "#go_lantern/#simage_lantern/#go_riddles")
	arg_1_0._btncloseRiddles = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#go_lantern/#simage_lantern/#go_riddles/#btn_closeRiddles")
	arg_1_0._txtriddles = gohelper.findChildText(arg_1_0.viewGO, "#go_lantern/#simage_lantern/#go_riddles/#txt_riddles")
	arg_1_0._goriddlesRewards = gohelper.findChild(arg_1_0.viewGO, "#go_lantern/#simage_lantern/#go_riddles/#go_riddlesRewards")
	arg_1_0._goriddlesRewardItem = gohelper.findChild(arg_1_0.viewGO, "#go_lantern/#simage_lantern/#go_riddles/#go_riddlesRewards/#go_riddlesRewardItem")
	arg_1_0._btnright = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#go_lantern/#btn_right")
	arg_1_0._btnpaint = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#btn_paint")
	arg_1_0._gopaintreddot = gohelper.findChild(arg_1_0.viewGO, "#btn_paint/#go_reddot")
	arg_1_0._gobegin = gohelper.findChild(arg_1_0.viewGO, "#btn_paint/#go_begin")
	arg_1_0._txtpaintTimes = gohelper.findChildText(arg_1_0.viewGO, "#btn_paint/#go_begin/#txt_paintTimes")
	arg_1_0._gonoPaint = gohelper.findChild(arg_1_0.viewGO, "#btn_paint/#go_noPaint")
	arg_1_0._gorewardBarBg = gohelper.findChild(arg_1_0.viewGO, "#go_rewards/#go_grayLine")
	arg_1_0._gorewardBar = gohelper.findChild(arg_1_0.viewGO, "#go_rewards/#go_grayLine/#go_highLine")
	arg_1_0._gorewardItemLayout = gohelper.findChild(arg_1_0.viewGO, "#go_rewards/#go_rewardLayout")
	arg_1_0._gorewardItem = gohelper.findChild(arg_1_0.viewGO, "#go_rewards/#go_rewardLayout/#go_rewardItem")
	arg_1_0._gopaintingview = gohelper.findChildClick(arg_1_0.viewGO, "v2a5_lanternfestivalpainting")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnleft:AddClickListener(arg_2_0._btnleftOnClick, arg_2_0)
	arg_2_0._btnlantern:AddClickListener(arg_2_0._btnlanternOnClick, arg_2_0)
	arg_2_0._btnshowRiddles:AddClickListener(arg_2_0._btnshowRiddlesOnClick, arg_2_0)
	arg_2_0._btncloseRiddles:AddClickListener(arg_2_0._btncloseRiddlesOnClick, arg_2_0)
	arg_2_0._btnright:AddClickListener(arg_2_0._btnrightOnClick, arg_2_0)
	arg_2_0._btnpaint:AddClickListener(arg_2_0._btnpaintOnClick, arg_2_0)
	arg_2_0._lanternAnimationEvent:AddEventListener("left", arg_2_0._onLeftRefresh, arg_2_0)
	arg_2_0._lanternAnimationEvent:AddEventListener("right", arg_2_0._onRightRefresh, arg_2_0)
	NavigateMgr.instance:addEscape(arg_2_0.viewName, arg_2_0.onBtnEsc, arg_2_0)
	arg_2_0:addEventCb(Activity187Controller.instance, Activity187Event.GetAct187Info, arg_2_0.onGetActInfo, arg_2_0)
	arg_2_0:addEventCb(Activity187Controller.instance, Activity187Event.FinishPainting, arg_2_0.onFinishPainting, arg_2_0)
	arg_2_0:addEventCb(Activity187Controller.instance, Activity187Event.GetAccrueReward, arg_2_0.onGetAccrueReward, arg_2_0)
	arg_2_0:addEventCb(Activity187Controller.instance, Activity187Event.RefreshAccrueReward, arg_2_0.onRefreshAccrueReward, arg_2_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_2_0.checkActivityInfo, arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0.checkActivityInfo, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnleft:RemoveClickListener()
	arg_3_0._btnlantern:RemoveClickListener()
	arg_3_0._btnshowRiddles:RemoveClickListener()
	arg_3_0._btncloseRiddles:RemoveClickListener()
	arg_3_0._btnright:RemoveClickListener()
	arg_3_0._btnpaint:RemoveClickListener()
	arg_3_0._lanternAnimationEvent:RemoveAllEventListener()
	arg_3_0:removeEventCb(Activity187Controller.instance, Activity187Event.GetAct187Info, arg_3_0.onGetActInfo, arg_3_0)
	arg_3_0:removeEventCb(Activity187Controller.instance, Activity187Event.FinishPainting, arg_3_0.onFinishPainting, arg_3_0)
	arg_3_0:removeEventCb(Activity187Controller.instance, Activity187Event.GetAccrueReward, arg_3_0.onGetAccrueReward, arg_3_0)
	arg_3_0:removeEventCb(Activity187Controller.instance, Activity187Event.RefreshAccrueReward, arg_3_0.onRefreshAccrueReward, arg_3_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshActivityState, arg_3_0.checkActivityInfo, arg_3_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_3_0.checkActivityInfo, arg_3_0)
end

function var_0_0._btnleftOnClick(arg_4_0)
	if arg_4_0._curIndex <= 1 then
		return
	end

	arg_4_0:refreshLanternIndex()

	arg_4_0._curIndex = arg_4_0._curIndex - 1

	arg_4_0._lanternAnimator:Play("left", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_yuanxiao_switch)
end

function var_0_0._onLeftRefresh(arg_5_0)
	arg_5_0:refreshLanternIndex()
end

function var_0_0._btnlanternOnClick(arg_6_0)
	local var_6_0 = Activity187Model.instance:getFinishPaintingIndex()
	local var_6_1 = Activity187Model.instance:getPaintingRewardId(arg_6_0._curIndex)

	if var_6_0 < arg_6_0._curIndex and not var_6_1 then
		arg_6_0:_btnpaintOnClick()
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function var_0_0._btnshowRiddlesOnClick(arg_7_0)
	arg_7_0:setRiddlesShow(true)
	AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_mln_page_turn)
end

function var_0_0._btncloseRiddlesOnClick(arg_8_0)
	arg_8_0:setRiddlesShow(false)
end

function var_0_0._btnrightOnClick(arg_9_0)
	if arg_9_0._curIndex >= arg_9_0._maxIndex then
		return
	end

	arg_9_0:refreshLanternIndex()

	arg_9_0._curIndex = arg_9_0._curIndex + 1

	arg_9_0._lanternAnimator:Play("right", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_yuanxiao_switch)
end

function var_0_0._onRightRefresh(arg_10_0)
	arg_10_0:refreshLanternIndex()
end

function var_0_0._btnpaintOnClick(arg_11_0)
	if not ((Activity187Model.instance:getRemainPaintingCount() or 0) > 0) then
		return
	end

	if Activity187Model.instance:getFinishPaintingIndex() == arg_11_0._maxIndex then
		return
	end

	arg_11_0._curIndex = arg_11_0._maxIndex

	arg_11_0:refreshLanternIndex()
	arg_11_0:setPaintingViewDisplay(true)
end

function var_0_0.onBtnEsc(arg_12_0)
	if arg_12_0.isShowPaintView then
		arg_12_0:setPaintingViewDisplay(false)
	else
		arg_12_0:closeThis()
	end
end

function var_0_0.onGetActInfo(arg_13_0)
	arg_13_0:setLanternIndex()
	arg_13_0:setAccrueReward()
	arg_13_0:refresh()
end

function var_0_0.onFinishPainting(arg_14_0, arg_14_1)
	arg_14_0:setLanternIndex(arg_14_1)
	arg_14_0:refresh()
	arg_14_0:refreshAccrueRewardItem()
	arg_14_0:setRiddlesShow(true)
end

function var_0_0.onGetAccrueReward(arg_15_0, arg_15_1)
	arg_15_0._rewardsMaterials = arg_15_1

	arg_15_0:refreshAccrueRewardItem(true)
end

function var_0_0.onRefreshAccrueReward(arg_16_0)
	arg_16_0:refreshAccrueProgress()

	if arg_16_0._accrueRewardItemList then
		for iter_16_0, iter_16_1 in ipairs(arg_16_0._accrueRewardItemList) do
			iter_16_1:refreshStatus()
		end
	end
end

function var_0_0.checkActivityInfo(arg_17_0, arg_17_1)
	local var_17_0 = Activity187Model.instance:getAct187Id()

	if arg_17_1 and arg_17_1 ~= var_17_0 then
		return
	end

	if Activity187Model.instance:isAct187Open(true) then
		Activity187Controller.instance:getAct187Info()
	else
		arg_17_0:closeThis()
	end
end

function var_0_0._editableInitView(arg_18_0)
	arg_18_0._lowRibbonDict = arg_18_0:getUserDataTb_()
	arg_18_0._upRibbonDict = arg_18_0:getUserDataTb_()

	arg_18_0:_fillRibbonDict(arg_18_0._golowribbon.transform, arg_18_0._lowRibbonDict)
	arg_18_0:_fillRibbonDict(arg_18_0._goupribbon.transform, arg_18_0._upRibbonDict)

	local var_18_0 = gohelper.findChild(arg_18_0.viewGO, "#go_lantern")

	arg_18_0._lanternAnimationEvent = var_18_0:GetComponent(typeof(ZProj.AnimationEventWrap))
	arg_18_0._lanternAnimator = var_18_0:GetComponent(typeof(UnityEngine.Animator))
	arg_18_0._barBgWidth = recthelper.getWidth(arg_18_0._gorewardBarBg.transform)
	arg_18_0._riddlesRewardItemList = {}

	gohelper.setActive(arg_18_0._goriddlesRewardItem, false)

	arg_18_0.animator = arg_18_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_18_0.isShowPaintView = false
end

function var_0_0._fillRibbonDict(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1.childCount

	for iter_19_0 = 1, var_19_0 do
		local var_19_1 = arg_19_1:GetChild(iter_19_0 - 1)

		arg_19_2[var_19_1.name] = var_19_1
	end
end

function var_0_0.onUpdateParam(arg_20_0)
	return
end

function var_0_0.onOpen(arg_21_0)
	arg_21_0:setLanternIndex()
	arg_21_0:setAccrueReward()
	arg_21_0:refresh()
	TaskDispatcher.cancelTask(arg_21_0.refreshRemainTime, arg_21_0)
	TaskDispatcher.runRepeat(arg_21_0.refreshRemainTime, arg_21_0, TimeUtil.OneMinuteSecond)
	RedDotController.instance:addRedDot(arg_21_0._gopaintreddot, RedDotEnum.DotNode.V2a5_Act187CanPaint)
	AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_tangren_yuanxiao_open)
end

function var_0_0.setLanternIndex(arg_22_0, arg_22_1)
	local var_22_0 = Activity187Model.instance:getFinishPaintingIndex()
	local var_22_1 = var_22_0

	if (Activity187Model.instance:getRemainPaintingCount() or 0) > 0 then
		var_22_1 = var_22_0 + 1
	end

	local var_22_2 = Activity187Config.instance:getAct187Const(Activity187Enum.ConstId.MaxLanternCount)
	local var_22_3

	var_22_3 = tonumber(var_22_2) or 0

	if var_22_3 < 0 then
		var_22_3 = var_22_1
	end

	arg_22_0._maxIndex = math.min(var_22_1, var_22_3)
	arg_22_0._curIndex = arg_22_1 or arg_22_0._maxIndex
end

local function var_0_3(arg_23_0, arg_23_1)
	return arg_23_0 < arg_23_1
end

function var_0_0.setAccrueReward(arg_24_0)
	arg_24_0._accrueRewardItemList = {}

	local var_24_0 = Activity187Model.instance:getAct187Id()
	local var_24_1 = Activity187Config.instance:getAccrueRewardIdList(var_24_0)

	table.sort(var_24_1, var_0_3)

	local var_24_2 = {}

	for iter_24_0, iter_24_1 in ipairs(var_24_1) do
		local var_24_3 = Activity187Config.instance:getAccrueRewards(var_24_0, iter_24_1)

		var_24_2[#var_24_2 + 1] = var_24_3[1]
	end

	gohelper.CreateObjList(arg_24_0, arg_24_0._onSetAccrueRewardItem, var_24_2, arg_24_0._gorewardItemLayout, arg_24_0._gorewardItem, Activity187AccrueRewardItem)
end

function var_0_0._onSetAccrueRewardItem(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	arg_25_1:setData(arg_25_2)

	arg_25_0._accrueRewardItemList[arg_25_3] = arg_25_1
end

function var_0_0.setRiddlesShow(arg_26_0, arg_26_1)
	gohelper.setActive(arg_26_0._gotail, not arg_26_1)
	gohelper.setActive(arg_26_0._goriddles, arg_26_1)
end

function var_0_0.setPaintingViewDisplay(arg_27_0, arg_27_1)
	if arg_27_0.isShowPaintView == arg_27_1 then
		return
	end

	arg_27_0.isShowPaintView = arg_27_1

	if arg_27_0.isShowPaintView then
		arg_27_0.animator:Play("MainToDraw", 0, 0)
	else
		arg_27_0.animator:Play("DrawToMain", 0, 0)
	end

	AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_tangren_yuanxiao_pop)
	UIBlockMgr.instance:startBlock(Activity187Enum.BlockKey.SwitchView)
	TaskDispatcher.cancelTask(arg_27_0._endBlock, arg_27_0)
	TaskDispatcher.runDelay(arg_27_0._endBlock, arg_27_0, var_0_1)
	Activity187Controller.instance:dispatchEvent(Activity187Event.PaintViewDisplayChange, arg_27_0.isShowPaintView, arg_27_0._maxIndex)
end

function var_0_0._endBlock(arg_28_0)
	UIBlockMgr.instance:endBlock(Activity187Enum.BlockKey.SwitchView)
end

function var_0_0.refresh(arg_29_0)
	arg_29_0:refreshLanternIndex()
	arg_29_0:refreshPaintingCount()
	arg_29_0:refreshAccrueProgress()
	arg_29_0:refreshRemainTime()
end

function var_0_0.refreshLanternIndex(arg_30_0)
	local var_30_0 = luaLang("room_wholesale_weekly_revenue")

	arg_30_0._txtindex.text = GameUtil.getSubPlaceholderLuaLangTwoParam(var_30_0, arg_30_0._curIndex, arg_30_0._maxIndex)

	arg_30_0:refreshLantern()
	arg_30_0:refreshArrow()
end

function var_0_0.refreshLantern(arg_31_0)
	arg_31_0:hideAllRiddlesRewardItem()

	local var_31_0 = Activity187Enum.EmptyLantern
	local var_31_1
	local var_31_2 = Activity187Model.instance:getPaintingRewardId(arg_31_0._curIndex)

	if var_31_2 then
		local var_31_3 = Activity187Model.instance:getAct187Id()

		var_31_0 = Activity187Config.instance:getLantern(var_31_3, var_31_2)
		var_31_1 = Activity187Config.instance:getLanternRibbon(var_31_3, var_31_2)

		local var_31_4 = Activity187Config.instance:getLanternImg(var_31_3, var_31_2)

		arg_31_0._simagepicture:LoadImage(ResUrl.getAct184LanternIcon(var_31_4))

		arg_31_0._txtriddles.text = Activity187Config.instance:getBlessing(var_31_3, var_31_2)

		local var_31_5 = Activity187Model.instance:getPaintingRewardList(arg_31_0._curIndex)

		for iter_31_0, iter_31_1 in ipairs(var_31_5) do
			arg_31_0:getRiddlesRewardItem(iter_31_0).itemIcon:onUpdateMO(iter_31_1)
		end
	end

	arg_31_0._simagelantern:LoadImage(ResUrl.getAct184LanternIcon(var_31_0))

	for iter_31_2, iter_31_3 in pairs(arg_31_0._lowRibbonDict) do
		gohelper.setActive(iter_31_3, iter_31_2 == var_31_1)
	end

	for iter_31_4, iter_31_5 in pairs(arg_31_0._upRibbonDict) do
		gohelper.setActive(iter_31_5, iter_31_4 == var_31_1)
	end

	gohelper.setActive(arg_31_0._simagepicture, var_31_2)
	gohelper.setActive(arg_31_0._btnshowRiddles, var_31_2)
	gohelper.setActive(arg_31_0._goincomplete, not var_31_2)
	arg_31_0:setRiddlesShow(false)
end

function var_0_0.hideAllRiddlesRewardItem(arg_32_0)
	if not arg_32_0._riddlesRewardItemList then
		arg_32_0._riddlesRewardItemList = {}
	end

	for iter_32_0, iter_32_1 in ipairs(arg_32_0._riddlesRewardItemList) do
		gohelper.setActive(iter_32_1.go, false)
	end
end

function var_0_0.getRiddlesRewardItem(arg_33_0, arg_33_1)
	if not arg_33_0._riddlesRewardItemList then
		arg_33_0._riddlesRewardItemList = {}
	end

	local var_33_0 = arg_33_0._riddlesRewardItemList[arg_33_1]

	if not var_33_0 then
		var_33_0 = arg_33_0:getUserDataTb_()
		var_33_0.go = gohelper.clone(arg_33_0._goriddlesRewardItem, arg_33_0._goriddlesRewards, arg_33_1)

		local var_33_1 = gohelper.findChild(var_33_0.go, "#go_item")

		var_33_0.itemIcon = IconMgr.instance:getCommonItemIcon(var_33_1)

		var_33_0.itemIcon:setCountFontSize(40)

		arg_33_0._riddlesRewardItemList[arg_33_1] = var_33_0
	end

	gohelper.setActive(var_33_0.go, true)

	return var_33_0
end

function var_0_0.refreshArrow(arg_34_0)
	gohelper.setActive(arg_34_0._btnleft, arg_34_0._curIndex > 1)
	gohelper.setActive(arg_34_0._btnright, arg_34_0._curIndex < arg_34_0._maxIndex)
end

function var_0_0.refreshPaintingCount(arg_35_0)
	local var_35_0 = Activity187Model.instance:getRemainPaintingCount() or 0
	local var_35_1 = var_35_0 > 0

	arg_35_0._txtpaintTimes.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act187_painting_count"), var_35_0)

	gohelper.setActive(arg_35_0._gobegin, var_35_1)
	gohelper.setActive(arg_35_0._gonoPaint, not var_35_1)
end

function var_0_0.refreshAccrueProgress(arg_36_0)
	local var_36_0 = Activity187Model.instance:getAct187Id()
	local var_36_1 = Activity187Config.instance:getAccrueRewardIdList(var_36_0)

	table.sort(var_36_1, var_0_3)

	local var_36_2 = 0
	local var_36_3 = Activity187Model.instance:getAccrueRewardIndex()

	for iter_36_0, iter_36_1 in ipairs(var_36_1) do
		if iter_36_1 <= var_36_3 then
			var_36_2 = iter_36_0 - 1
		end
	end

	local var_36_4 = var_36_2 * (1 / (#var_36_1 - 1))

	recthelper.setWidth(arg_36_0._gorewardBar.transform, var_36_4 * arg_36_0._barBgWidth)
end

function var_0_0.refreshRemainTime(arg_37_0)
	local var_37_0 = Activity187Model.instance:getAct187RemainTimeStr()

	arg_37_0._txtremainTime.text = var_37_0
end

function var_0_0.refreshAccrueRewardItem(arg_38_0, arg_38_1)
	if arg_38_0._accrueRewardItemList then
		for iter_38_0, iter_38_1 in ipairs(arg_38_0._accrueRewardItemList) do
			iter_38_1:refreshStatus(arg_38_1)
		end
	end

	if arg_38_0._rewardsMaterials then
		UIBlockMgr.instance:startBlock(Activity187Enum.BlockKey.GetAccrueReward)
		AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_single)
		TaskDispatcher.cancelTask(arg_38_0._showMaterials, arg_38_0)
		TaskDispatcher.runDelay(arg_38_0._showMaterials, arg_38_0, var_0_2)
	end
end

function var_0_0._showMaterials(arg_39_0)
	RoomController.instance:popUpRoomBlockPackageView(arg_39_0._rewardsMaterials)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, arg_39_0._rewardsMaterials)

	arg_39_0._rewardsMaterials = nil

	UIBlockMgr.instance:endBlock(Activity187Enum.BlockKey.GetAccrueReward)
end

function var_0_0.onClose(arg_40_0)
	arg_40_0._simagepicture:UnLoadImage()
	arg_40_0._simagelantern:UnLoadImage()
	TaskDispatcher.cancelTask(arg_40_0._endBlock, arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0._showMaterials, arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0.refreshRemainTime, arg_40_0)
	UIBlockMgr.instance:endBlock(Activity187Enum.BlockKey.SwitchView)
	UIBlockMgr.instance:endBlock(Activity187Enum.BlockKey.GetAccrueReward)

	arg_40_0._rewardsMaterials = nil
end

function var_0_0.onDestroyView(arg_41_0)
	return
end

return var_0_0
