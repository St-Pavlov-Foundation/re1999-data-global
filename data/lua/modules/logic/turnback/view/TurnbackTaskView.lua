module("modules.logic.turnback.view.TurnbackTaskView", package.seeall)

local var_0_0 = class("TurnbackTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg")
	arg_1_0._goprocessIcon = gohelper.findChild(arg_1_0.viewGO, "left/title/#go_progressIcon")
	arg_1_0._gonoprocessIcon = gohelper.findChild(arg_1_0.viewGO, "left/title/#go_noprogressIcon")
	arg_1_0._txtactiveNum = gohelper.findChildText(arg_1_0.viewGO, "left/title/#txt_activeNum")
	arg_1_0._imageactiveIcon = gohelper.findChildImage(arg_1_0.viewGO, "left/title/#txt_activeNum/icon")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "left/#scroll_reward")
	arg_1_0._gobar = gohelper.findChild(arg_1_0.viewGO, "left/#scroll_reward/Viewport/#go_rewardContent/#go_bar")
	arg_1_0._imageprogress = gohelper.findChildImage(arg_1_0.viewGO, "left/#scroll_reward/Viewport/#go_rewardContent/#go_bar/#image_progress")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "left/#scroll_reward/Viewport/#go_rewardContent")
	arg_1_0._gorewardItem = gohelper.findChild(arg_1_0.viewGO, "left/#scroll_reward/Viewport/#go_rewardContent/#go_rewardItem")
	arg_1_0._txtremainTime = gohelper.findChildText(arg_1_0.viewGO, "right/#txt_remainTime")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "right/desc_scroll/viewport/#txt_desc")
	arg_1_0._scrolltask = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/#scroll_task")
	arg_1_0._gotaskViewport = gohelper.findChild(arg_1_0.viewGO, "right/#scroll_task/Viewport")
	arg_1_0._gotaskContent = gohelper.findChild(arg_1_0.viewGO, "right/#scroll_task/Viewport/#go_taskContent")
	arg_1_0._godaytime = gohelper.findChild(arg_1_0.viewGO, "right/#go_daytime")
	arg_1_0._gotoggleGroup = gohelper.findChild(arg_1_0.viewGO, "right/taskToggleGroup")
	arg_1_0._toggleGroup = arg_1_0._gotoggleGroup:GetComponent(typeof(UnityEngine.UI.ToggleGroup))
	arg_1_0._btnstory = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_story")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end

	arg_1_0._txtdaytime = gohelper.findChildText(arg_1_0.viewGO, "right/#go_daytime/txt")
	arg_1_0._txtdaytime.text = ServerTime.ReplaceUTCStr(luaLang("p_turnbacktaskview_txt_time"))
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.OnTaskRewardGetFinish, arg_2_0._playGetRewardFinishAnim, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshTaskRedDot, arg_2_0._refreshRedDot, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, arg_2_0._refreshRemainTime, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, arg_2_0._refreshUI, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._playEndStory, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._refreshBonusPoint, arg_2_0)
	arg_2_0._btnstory:AddClickListener(arg_2_0._btnstoryOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.OnTaskRewardGetFinish, arg_3_0._playGetRewardFinishAnim, arg_3_0)
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshTaskRedDot, arg_3_0._refreshRedDot, arg_3_0)
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, arg_3_0._refreshRemainTime, arg_3_0)
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, arg_3_0._refreshUI, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0._playEndStory, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._refreshBonusPoint, arg_3_0)
	arg_3_0._btnstory:RemoveClickListener()
end

local var_0_1 = {
	TurnbackEnum.TaskLoopType.Day,
	TurnbackEnum.TaskLoopType.Long
}
local var_0_2 = 4

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg:LoadImage(ResUrl.getTurnbackIcon("turnback_taskfullbg"))

	arg_4_0._isFirstEnter = true

	gohelper.setActive(arg_4_0._gorewardItem, false)

	arg_4_0._rewardItemTab = arg_4_0:getUserDataTb_()
	arg_4_0._taskToggleWraps = arg_4_0:getUserDataTb_()
	arg_4_0._toggleRedDotTab = arg_4_0:getUserDataTb_()
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.parent

	arg_6_0.viewConfig = TurnbackConfig.instance:getTurnbackSubModuleCo(arg_6_0.viewParam.actId)
	arg_6_0.curTaskLoopType = TurnbackEnum.TaskLoopType.Day
	arg_6_0.curTurnbackId = TurnbackModel.instance:getCurTurnbackId()
	arg_6_0.bonusPointType, arg_6_0.bonusPointId = TurnbackConfig.instance:getBonusPointCo(arg_6_0.curTurnbackId)

	local var_6_1 = CurrencyConfig.instance:getCurrencyCo(arg_6_0.bonusPointId)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_6_0._imageactiveIcon, var_6_1.icon .. "_1")
	gohelper.addChild(var_6_0, arg_6_0.viewGO)
	arg_6_0:_initComp()
	arg_6_0:_createTaskBonusItem()
	arg_6_0:_onToggleValueChanged(1, true)
	arg_6_0:_refreshUI()

	arg_6_0._isFirstEnter = false
end

function var_0_0._initComp(arg_7_0)
	local var_7_0 = arg_7_0._gotoggleGroup.transform
	local var_7_1 = var_7_0.childCount

	for iter_7_0 = 1, var_7_1 do
		local var_7_2 = var_7_0:GetChild(iter_7_0 - 1)

		if var_7_2:GetComponent(typeof(UnityEngine.UI.Toggle)) then
			local var_7_3 = gohelper.onceAddComponent(var_7_2, typeof(SLFramework.UGUI.ToggleWrap))

			var_7_3:AddOnValueChanged(arg_7_0._onToggleValueChanged, arg_7_0, iter_7_0)

			arg_7_0._taskToggleWraps[iter_7_0] = var_7_3
		end
	end

	for iter_7_1 = 1, 2 do
		arg_7_0._toggleRedDotTab[iter_7_1] = gohelper.findChild(arg_7_0.viewGO, "right/redDot/#go_reddot" .. iter_7_1)
	end

	arg_7_0._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(arg_7_0.viewContainer._scrollView)

	arg_7_0._taskAnimRemoveItem:setMoveInterval(0)
	arg_7_0._taskAnimRemoveItem:setMoveAnimationTime(TurnbackEnum.TaskMaskTime - TurnbackEnum.TaskGetAnimTime)
end

function var_0_0._createTaskBonusItem(arg_8_0)
	local var_8_0 = GameUtil.getTabLen(TurnbackConfig.instance:getAllTurnbackTaskBonusCo(arg_8_0.curTurnbackId))

	for iter_8_0 = 1, var_8_0 do
		if not arg_8_0._rewardItemTab[iter_8_0] then
			local var_8_1 = arg_8_0:getUserDataTb_()

			var_8_1.go = gohelper.clone(arg_8_0._gorewardItem, arg_8_0._gorewardContent, "rewardItem" .. iter_8_0)
			var_8_1.item = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_1.go, TurnbackTaskBonusItem, {
				index = iter_8_0,
				parentScrollGO = arg_8_0._scrollreward.gameObject
			})

			gohelper.setActive(var_8_1.go, true)
			table.insert(arg_8_0._rewardItemTab, var_8_1)
		end
	end

	for iter_8_1 = var_8_0 + 1, #arg_8_0._rewardItemTab do
		gohelper.setActive(arg_8_0._rewardItemTab[iter_8_1].go, false)
	end
end

function var_0_0._refreshTaskProcessBar(arg_9_0, arg_9_1)
	local var_9_0 = 26
	local var_9_1 = 52
	local var_9_2 = 98
	local var_9_3 = 25
	local var_9_4 = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(arg_9_0.curTurnbackId)
	local var_9_5 = GameUtil.getTabLen(var_9_4)
	local var_9_6 = var_9_0 + (var_9_5 - 1) * var_9_2 + var_9_5 * var_9_1 + var_9_3

	recthelper.setHeight(arg_9_0._gobar.transform, var_9_6)

	local var_9_7 = 0
	local var_9_8 = 0
	local var_9_9 = 0
	local var_9_10 = 0
	local var_9_11 = 0

	for iter_9_0, iter_9_1 in ipairs(var_9_4) do
		if arg_9_1 >= iter_9_1.needPoint then
			var_9_7 = iter_9_0
			var_9_8 = iter_9_1.needPoint
			var_9_9 = iter_9_1.needPoint
		elseif var_9_9 <= var_9_8 then
			var_9_9 = iter_9_1.needPoint
		end
	end

	if var_9_9 ~= var_9_8 then
		var_9_10 = (arg_9_1 - var_9_8) / (var_9_9 - var_9_8)
	end

	if var_9_7 == 0 then
		var_9_11 = var_9_0 * var_9_10
	else
		var_9_11 = var_9_0 + var_9_7 * var_9_1 + (var_9_7 - 1) * var_9_2 + var_9_10 * var_9_2
	end

	if var_9_7 == var_9_5 then
		var_9_11 = var_9_11 + var_9_3
	end

	recthelper.setHeight(arg_9_0._imageprogress.transform, var_9_11)
end

function var_0_0._onToggleValueChanged(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 then
		if not arg_10_0._isFirstEnter then
			AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_switch)
		end

		arg_10_0.curTaskLoopType = var_0_1[arg_10_1]

		TurnbackTaskModel.instance:refreshList(arg_10_0.curTaskLoopType)

		arg_10_0._scrolltask.verticalNormalizedPosition = 1
	end

	for iter_10_0 = 1, #arg_10_0._taskToggleWraps do
		local var_10_0 = gohelper.findChildText(arg_10_0._taskToggleWraps[iter_10_0].gameObject, "txt")

		SLFramework.UGUI.GuiHelper.SetColor(var_10_0, arg_10_0.curTaskLoopType == var_0_1[iter_10_0] and "#E99B56" or "#ffffff")
		ZProj.UGUIHelper.SetColorAlpha(var_10_0, arg_10_0.curTaskLoopType == var_0_1[iter_10_0] and 1 or 0.3)

		local var_10_1 = gohelper.findChild(arg_10_0._taskToggleWraps[iter_10_0].gameObject, "Background/go_normal")
		local var_10_2 = gohelper.findChild(arg_10_0._taskToggleWraps[iter_10_0].gameObject, "Background/go_select")

		gohelper.setActive(var_10_1, arg_10_0.curTaskLoopType ~= var_0_1[iter_10_0])
		gohelper.setActive(var_10_2, arg_10_0.curTaskLoopType == var_0_1[iter_10_0])
	end

	gohelper.setActive(arg_10_0._godaytime, arg_10_0.curTaskLoopType == TurnbackEnum.TaskLoopType.Day)
	recthelper.setAnchorY(arg_10_0._scrolltask.gameObject.transform, arg_10_0.curTaskLoopType == TurnbackEnum.TaskLoopType.Day and 0 or 50)

	local var_10_3 = TurnbackTaskModel.instance:getCount()

	recthelper.setHeight(arg_10_0._scrolltask.gameObject.transform, var_10_3 <= var_0_2 and 496 or 683)

	if var_10_3 <= var_0_2 then
		arg_10_0._gotaskViewport.transform.offsetMin = Vector2(0, 0)
	else
		arg_10_0._gotaskViewport.transform.offsetMin = Vector2(0, arg_10_0.viewContainer._scrollView._param.cellHeight + arg_10_0.viewContainer._scrollView._param.cellSpaceV)
	end
end

function var_0_0._btnstoryOnClick(arg_11_0)
	local var_11_0 = TurnbackModel.instance:getCurTurnbackMo()
	local var_11_1 = var_11_0 and var_11_0.config and var_11_0.config.endStory

	if var_11_1 then
		StoryController.instance:playStory(var_11_1)
	else
		logError(string.format("TurnbackTaskView endStoryId is nil", var_11_1))
	end
end

function var_0_0._refreshUI(arg_12_0)
	local var_12_0 = CurrencyModel.instance:getCurrency(arg_12_0.bonusPointId)
	local var_12_1 = var_12_0 and var_12_0.quantity or 0

	arg_12_0:_refreshTaskProcessBar(var_12_1)

	arg_12_0._txtactiveNum.text = var_12_1
	arg_12_0._txtdesc.text = arg_12_0.viewConfig.actDesc

	gohelper.setActive(arg_12_0._goprocessIcon, var_12_1 > 0)
	gohelper.setActive(arg_12_0._gonoprocessIcon, var_12_1 == 0)
	arg_12_0:_refreshRemainTime()
	arg_12_0:_refreshRedDot()
	arg_12_0:_refreshStoryBtn()
end

function var_0_0._refreshRedDot(arg_13_0)
	local var_13_0 = TurnbackTaskModel.instance:getTaskLoopTypeDotState()

	for iter_13_0, iter_13_1 in pairs(arg_13_0._toggleRedDotTab) do
		local var_13_1 = var_0_1[iter_13_0]

		gohelper.setActive(iter_13_1, var_13_0[var_13_1])
	end
end

function var_0_0._refreshRemainTime(arg_14_0)
	arg_14_0._txtremainTime.text = TurnbackController.instance:refreshRemainTime()
end

function var_0_0._refreshStoryBtn(arg_15_0)
	local var_15_0 = TurnbackConfig.instance:getTurnbackCo(arg_15_0.curTurnbackId)
	local var_15_1 = var_15_0 and StoryModel.instance:isStoryFinished(var_15_0.endStory) and arg_15_0:_canPlayEndStory()

	gohelper.setActive(arg_15_0._btnstory, var_15_1)
end

function var_0_0._refreshBonusPoint(arg_16_0, arg_16_1)
	if arg_16_1[arg_16_0.bonusPointId] then
		arg_16_0:_refreshUI()
		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshTaskRewardItem)
	end
end

function var_0_0._playGetRewardFinishAnim(arg_17_0, arg_17_1)
	if not TurnbackModel.instance:isInOpenTime() or not arg_17_1 then
		TaskDispatcher.cancelTask(arg_17_0.delayPlayFinishAnim, arg_17_0)

		return
	end

	if arg_17_1 then
		arg_17_0.removeIndexTab = {
			arg_17_1
		}
	end

	TaskDispatcher.runDelay(arg_17_0.delayPlayFinishAnim, arg_17_0, TurnbackEnum.TaskGetAnimTime)
end

function var_0_0.delayPlayFinishAnim(arg_18_0)
	arg_18_0._taskAnimRemoveItem:removeByIndexs(arg_18_0.removeIndexTab)
end

function var_0_0._playEndStory(arg_19_0, arg_19_1)
	if arg_19_1 == ViewName.CommonPropView and arg_19_0:_canPlayEndStory() then
		local var_19_0 = TurnbackModel.instance:getCurTurnbackMo().config.endStory

		if not StoryModel.instance:isStoryFinished(var_19_0) then
			StoryController.instance:playStory(var_19_0, nil, arg_19_0._refreshStoryBtn, arg_19_0)
		end
	end
end

function var_0_0._canPlayEndStory(arg_20_0)
	local var_20_0 = TurnbackModel.instance:getCurTurnbackMo()
	local var_20_1 = GameUtil.getTabLen(TurnbackConfig.instance:getAllTurnbackTaskBonusCo(var_20_0.id))

	return #var_20_0.hasGetTaskBonus == var_20_1
end

function var_0_0.onClose(arg_21_0)
	for iter_21_0 = 1, #arg_21_0._taskToggleWraps do
		arg_21_0._taskToggleWraps[iter_21_0]:RemoveOnValueChanged()
	end

	arg_21_0._simagebg:UnLoadImage()
	TaskDispatcher.cancelTask(arg_21_0.delayPlayFinishAnim, arg_21_0)
end

function var_0_0.onDestroyView(arg_22_0)
	return
end

return var_0_0
