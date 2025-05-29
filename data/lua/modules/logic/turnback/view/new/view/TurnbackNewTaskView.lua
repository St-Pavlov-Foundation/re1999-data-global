module("modules.logic.turnback.view.new.view.TurnbackNewTaskView", package.seeall)

local var_0_0 = class("TurnbackNewTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnreplay = gohelper.findChildButton(arg_1_0.viewGO, "top/#btn_replay")
	arg_1_0._btnbuy = gohelper.findChildButton(arg_1_0.viewGO, "top/normalbg/#btn_buy")
	arg_1_0._gotop = gohelper.findChild(arg_1_0.viewGO, "top")
	arg_1_0._goright = gohelper.findChild(arg_1_0.viewGO, "right")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "top/normalbg")
	arg_1_0._godouble = gohelper.findChild(arg_1_0.viewGO, "top/doublebg")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "top/#scroll_view")
	arg_1_0._scrolltask = gohelper.findChildScrollRect(arg_1_0.viewGO, "left/#scroll_task")
	arg_1_0._gorewardviewport = gohelper.findChild(arg_1_0.viewGO, "top/#scroll_view/Viewport")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "top/#scroll_view/Viewport/Content")
	arg_1_0._gorewardItem = gohelper.findChild(arg_1_0.viewGO, "top/#scroll_view/Viewport/Content/#go_rewarditem")
	arg_1_0._gobigrewardItem = gohelper.findChild(arg_1_0.viewGO, "top/#go_special")
	arg_1_0._imgFill = gohelper.findChildImage(arg_1_0.viewGO, "top/#scroll_view/Viewport/Content/progressbg/fill")
	arg_1_0._txtActiveNum = gohelper.findChildText(arg_1_0.viewGO, "top/#txt_activeNum")
	arg_1_0._btnleft = gohelper.findChildButton(arg_1_0.viewGO, "right/simage_rightbg/#btn_last")
	arg_1_0._btnright = gohelper.findChildButton(arg_1_0.viewGO, "right/simage_rightbg/#btn_next")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "right/simage_rightbg/numbg/#txt_num")
	arg_1_0._gonumbg = gohelper.findChild(arg_1_0.viewGO, "right/simage_rightbg/numbg")
	arg_1_0._gotitlebg = gohelper.findChild(arg_1_0.viewGO, "right/simage_rightbg/titlebg")
	arg_1_0._gounfinish = gohelper.findChild(arg_1_0.viewGO, "right/unfinish")
	arg_1_0._gofinished = gohelper.findChild(arg_1_0.viewGO, "right/finished")
	arg_1_0._simageHero = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/unfinish/simage_role")
	arg_1_0._goscrolldesc = gohelper.findChild(arg_1_0.viewGO, "right/unfinish/#scroll_desc")
	arg_1_0._txtHeroDesc = gohelper.findChildText(arg_1_0.viewGO, "right/unfinish/#scroll_desc/Viewport/#txt_dec")
	arg_1_0._btnexchange = gohelper.findChildButton(arg_1_0.viewGO, "right/unfinish/#btn_exchange")
	arg_1_0._rewardNodeList = {}
	arg_1_0._heroIndex = 1
	arg_1_0._isreverse = false
	arg_1_0._isfinish = false
	arg_1_0._topAnimator = arg_1_0._gotop:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._rightAnimator = arg_1_0._goright:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._rightTextAnim = arg_1_0._goscrolldesc:GetComponent(typeof(UnityEngine.Animation))
	arg_1_0.fullscrollWidth = 780
	arg_1_0.normalscrollWidth = 604

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreplay:AddClickListener(arg_2_0.onClickReplay, arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0.onClickBuy, arg_2_0)
	arg_2_0._btnleft:AddClickListener(arg_2_0.onClickLeft, arg_2_0)
	arg_2_0._btnright:AddClickListener(arg_2_0.onClickRight, arg_2_0)
	arg_2_0._btnexchange:AddClickListener(arg_2_0.onCilckReverse, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.OnTaskRewardGetFinish, arg_2_0._playGetRewardFinishAnim, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0.onCurrencyChange, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, arg_2_0._refreshUI, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.AfterBuyDoubleReward, arg_2_0.succbuydoublereward, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseViewFinish, arg_2_0)
	arg_2_0._scrollreward:AddOnValueChanged(arg_2_0._onScrollRectValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreplay:RemoveClickListener()
	arg_3_0._btnbuy:RemoveClickListener()
	arg_3_0._btnleft:RemoveClickListener()
	arg_3_0._btnright:RemoveClickListener()
	arg_3_0._btnexchange:RemoveClickListener()
	arg_3_0._scrollreward:RemoveOnValueChanged()
	arg_3_0._scrolltask:RemoveOnValueChanged()
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.OnTaskRewardGetFinish, arg_3_0._playGetRewardFinishAnim, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0.onCurrencyChange, arg_3_0)
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, arg_3_0._refreshUI, arg_3_0)
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.AfterBuyDoubleReward, arg_3_0.succbuydoublereward, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseViewFinish, arg_3_0)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._rewardNodeList) do
		iter_3_1.btnclick:RemoveClickListener()
	end
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._turnbackId = TurnbackModel.instance:getCurTurnbackId()

	arg_4_0:_initRewardNode()
	arg_4_0:_initBigRewardNode()
	arg_4_0:_refreshFill()
	arg_4_0:refreshTopBg()

	local var_4_0 = TurnbackModel.instance:getUnlockHeroList()

	arg_4_0._heroIndex = #var_4_0
	arg_4_0._maxUnlockHeroIndex = #var_4_0

	arg_4_0:_refreshHero()

	arg_4_0._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(arg_4_0.viewContainer._scrollView)

	arg_4_0._taskAnimRemoveItem:setMoveInterval(0)
	arg_4_0._taskAnimRemoveItem:setMoveAnimationTime(TurnbackEnum.TaskMaskTime - TurnbackEnum.TaskGetAnimTime)

	gohelper.findChildText(arg_4_0.viewGO, "left/txt_dec").text = ServerTime.ReplaceUTCStr(luaLang("p_turnbacknewtaskview_txt_daily"))
end

function var_0_0._onScrollRectValueChanged(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:checkNeedHideReward(arg_5_1)

	if not arg_5_0._scrollTime then
		arg_5_0._scrollTime = 0
		arg_5_0._scrollX = arg_5_1

		TaskDispatcher.runRepeat(arg_5_0.checkScrollEnd, arg_5_0, 0)
	end

	if arg_5_0._scrollTime and math.abs(arg_5_0._scrollX - arg_5_1) > 0.05 then
		arg_5_0._scrollTime = 0
		arg_5_0._scrollX = arg_5_1
	end
end

function var_0_0.checkScrollEnd(arg_6_0)
	arg_6_0._scrollTime = arg_6_0._scrollTime + UnityEngine.Time.deltaTime

	if arg_6_0._scrollTime > 0.05 then
		arg_6_0._scrollTime = nil

		TaskDispatcher.cancelTask(arg_6_0.checkScrollEnd, arg_6_0)
	end
end

function var_0_0.checkNeedHideReward(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	if arg_7_1 > 0.8 then
		recthelper.setWidth(arg_7_0._scrollreward.transform, arg_7_0.fullscrollWidth)
		gohelper.setActive(arg_7_0._gobigrewardItem, false)
	else
		recthelper.setWidth(arg_7_0._scrollreward.transform, arg_7_0.normalscrollWidth)
		gohelper.setActive(arg_7_0._gobigrewardItem, true)
	end
end

function var_0_0._refreshUI(arg_8_0)
	arg_8_0:refreshTopBg()
	arg_8_0:_refreshFill()
	arg_8_0:_refreshHero()
	arg_8_0:refreshBigRewardNode()

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._rewardNodeList) do
		arg_8_0:refreshRewardNode(iter_8_1)
	end

	if TurnbackModel.instance:checkHasGetAllTaskReward() then
		local var_8_0 = TurnbackConfig.instance:getTurnbackCo(arg_8_0._turnbackId)

		if var_8_0 and not StoryModel.instance:isStoryFinished(var_8_0.endStory) then
			local var_8_1 = var_8_0.endStory

			if var_8_1 then
				StoryController.instance:playStory(var_8_1)
			else
				logError(string.format("TurnbackTaskView endStoryId is nil", var_8_1))
			end
		end
	end
end

function var_0_0._refreshHero(arg_9_0)
	arg_9_0._unlockHeroCoList = TurnbackModel.instance:getUnlockHeroList()

	local var_9_0 = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(arg_9_0._turnbackId)
	local var_9_1 = arg_9_0._heroIndex > 1
	local var_9_2 = arg_9_0._heroIndex < #arg_9_0._unlockHeroCoList

	gohelper.setActive(arg_9_0._btnleft.gameObject, var_9_1)
	gohelper.setActive(arg_9_0._btnright.gameObject, var_9_2)

	if arg_9_0._heroIndex == #var_9_0 then
		gohelper.setActive(arg_9_0._btnright.gameObject, true)
	end

	local var_9_3 = arg_9_0._unlockHeroCoList[arg_9_0._heroIndex]

	if not var_9_3 then
		return
	end

	arg_9_0._txtHeroDesc.text = var_9_3.content

	arg_9_0._simageHero:LoadImage(ResUrl.getTurnbackIcon("new/task/turnback_new_task_role" .. arg_9_0._heroIndex))

	local var_9_4 = TurnbackModel.instance:getCanGetRewardList()

	if arg_9_0._heroIndex > 1 then
		local var_9_5 = arg_9_0._unlockHeroCoList[arg_9_0._heroIndex - 1]

		arg_9_0._txtnum.text = var_9_5.needPoint

		gohelper.setActive(arg_9_0._gonumbg, true)
	else
		gohelper.setActive(arg_9_0._gonumbg, false)
	end
end

function var_0_0.getSchedule(arg_10_0)
	local var_10_0 = 0
	local var_10_1 = 0.06
	local var_10_2 = 1
	local var_10_3 = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(arg_10_0._turnbackId)
	local var_10_4 = #var_10_3
	local var_10_5 = var_10_3[1].needPoint
	local var_10_6 = TurnbackModel.instance:getCurrentPointId(arg_10_0._turnbackId)
	local var_10_7 = 0
	local var_10_8 = 0
	local var_10_9 = 0

	for iter_10_0, iter_10_1 in ipairs(var_10_3) do
		if var_10_6 >= iter_10_1.needPoint then
			var_10_7 = iter_10_0
			var_10_8 = iter_10_1.needPoint
		else
			var_10_9 = iter_10_1.needPoint

			break
		end
	end

	local var_10_10 = (var_10_2 - var_10_1) / (var_10_4 - 1)
	local var_10_11 = (var_10_6 - var_10_8) / (var_10_9 - var_10_8)

	if var_10_7 == var_10_4 then
		var_10_0 = 1
	elseif var_10_7 - 1 + var_10_11 <= 0 then
		var_10_0 = var_10_6 / var_10_5 * var_10_1
	else
		var_10_0 = var_10_1 + var_10_10 * (var_10_7 - 1 + var_10_11)
	end

	return var_10_0
end

function var_0_0.refreshTopBg(arg_11_0)
	local var_11_0 = TurnbackModel.instance:getBuyDoubleBonus()

	gohelper.setActive(arg_11_0._gonormal, not var_11_0)
	gohelper.setActive(arg_11_0._godouble, var_11_0)

	local var_11_1 = 50
	local var_11_2 = 50
	local var_11_3 = 100
	local var_11_4 = 100
	local var_11_5 = TurnbackModel.instance:getNextUnlockReward()
	local var_11_6 = TurnbackModel.instance:getContentWidth() - arg_11_0.normalscrollWidth

	if TurnbackModel.instance:checkHasGetAllTaskReward() then
		arg_11_0._scrollreward.horizontalNormalizedPosition = 1
	elseif var_11_5 > 1 then
		local var_11_7 = var_11_5 - 2
		local var_11_8 = 0
		local var_11_9 = (var_11_4 * var_11_7 + var_11_3 * (var_11_7 - 1) + var_11_1 + var_11_2) / var_11_6

		if var_11_9 >= 1 then
			arg_11_0._scrollreward.horizontalNormalizedPosition = 1
		else
			arg_11_0._scrollreward.horizontalNormalizedPosition = var_11_9
		end
	else
		arg_11_0._scrollreward.horizontalNormalizedPosition = 0
	end
end

function var_0_0.onCurrencyChange(arg_12_0)
	arg_12_0:_refreshFill()

	arg_12_0._unlockHeroCoList = TurnbackModel.instance:getUnlockHeroList()

	local var_12_0 = #arg_12_0._unlockHeroCoList

	if var_12_0 > arg_12_0._maxUnlockHeroIndex then
		arg_12_0._maxUnlockHeroIndex = var_12_0
		arg_12_0._heroIndex = var_12_0

		if arg_12_0._isreverse then
			arg_12_0._isreverse = not arg_12_0._isreverse

			gohelper.setActive(arg_12_0._simageHero.gameObject, not arg_12_0._isreverse)
			gohelper.setActive(arg_12_0._goscrolldesc, arg_12_0._isreverse)
		end
	end

	arg_12_0:_refreshHero()
	arg_12_0:refreshTopBg()
end

function var_0_0._refreshFill(arg_13_0)
	local var_13_0 = TurnbackConfig.instance:getTurnbackLastBounsPoint(arg_13_0._turnbackId)
	local var_13_1 = TurnbackModel.instance:getCurrentPointId(arg_13_0._turnbackId)

	arg_13_0._txtActiveNum.text = var_13_1 .. "/" .. var_13_0
	arg_13_0._imgFill.fillAmount = arg_13_0:getSchedule()
end

function var_0_0._initRewardNode(arg_14_0)
	local var_14_0 = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(arg_14_0._turnbackId)

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_1 = arg_14_0:getUserDataTb_()

		var_14_1.co = iter_14_1
		var_14_1.go = gohelper.cloneInPlace(arg_14_0._gorewardItem, "node" .. iter_14_0)
		var_14_1.imgquality = gohelper.findChildImage(var_14_1.go, "#image_quality")
		var_14_1.imgCircle = gohelper.findChildImage(var_14_1.go, "#image_circle")
		var_14_1.goicon = gohelper.findChild(var_14_1.go, "go_icon")
		var_14_1.txtNum = gohelper.findChildText(var_14_1.go, "#txt_num")
		var_14_1.gocanget = gohelper.findChild(var_14_1.go, "go_canget")
		var_14_1.goreceive = gohelper.findChild(var_14_1.go, "go_receive")
		var_14_1.txtPoint = gohelper.findChildText(var_14_1.go, "point/#txt_point")
		var_14_1.golight = gohelper.findChild(var_14_1.go, "point/light")
		var_14_1.gogrey = gohelper.findChild(var_14_1.go, "point/grey")
		var_14_1.btnclick = gohelper.findChildButton(var_14_1.go, "go_canget/btn_click")

		local function var_14_2()
			local var_15_0 = {
				id = TurnbackModel.instance:getCurTurnbackId(),
				bonusPointId = var_14_1.co.id
			}

			TurnbackRpc.instance:sendTurnbackBonusPointRequest(var_15_0)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_buttonegg)
		end

		var_14_1.btnclick:AddClickListener(var_14_2, arg_14_0)
		gohelper.setActive(var_14_1.go, true)
		table.insert(arg_14_0._rewardNodeList, var_14_1)

		local var_14_3 = string.splitToNumber(iter_14_1.bonus, "#")
		local var_14_4 = var_14_3[1]
		local var_14_5 = var_14_3[2]
		local var_14_6 = var_14_3[3]
		local var_14_7 = ItemConfig.instance:getItemConfig(var_14_4, var_14_5)

		UISpriteSetMgr.instance:setUiFBSprite(var_14_1.imgquality, "bg2_pinjidi_" .. var_14_7.rare)
		UISpriteSetMgr.instance:setUiFBSprite(var_14_1.imgCircle, "bg_pinjidi_lanse_" .. var_14_7.rare)

		if var_14_3 then
			if not var_14_1.itemIcon then
				var_14_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(var_14_1.goicon)
			end

			var_14_1.itemIcon:setMOValue(var_14_3[1], var_14_3[2], var_14_3[3], nil, true)
			var_14_1.itemIcon:isShowQuality(false)
			var_14_1.itemIcon:isShowCount(false)
		end

		var_14_1.txtNum.text = var_14_6
		var_14_1.txtPoint.text = iter_14_1.needPoint

		arg_14_0:refreshRewardNode(var_14_1)
	end
end

function var_0_0.refreshRewardNode(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.co.id
	local var_16_1 = TurnbackModel.instance:checkBonusCanGetById(var_16_0)
	local var_16_2 = TurnbackModel.instance:checkBonusGetById(var_16_0)

	gohelper.setActive(arg_16_1.gocanget, var_16_1)
	gohelper.setActive(arg_16_1.goreceive, var_16_2)

	if var_16_1 or var_16_2 then
		gohelper.setActive(arg_16_1.golight, true)
		gohelper.setActive(arg_16_1.gogrey, false)
	else
		gohelper.setActive(arg_16_1.golight, false)
		gohelper.setActive(arg_16_1.gogrey, true)
	end
end

function var_0_0._initBigRewardNode(arg_17_0)
	arg_17_0.bignode = arg_17_0:getUserDataTb_()

	local var_17_0 = arg_17_0._gobigrewardItem

	arg_17_0.bignode.go = var_17_0
	arg_17_0.bignode.imgquality = gohelper.findChildImage(var_17_0, "#image_quality")
	arg_17_0.bignode.imgCircle = gohelper.findChildImage(var_17_0, "#image_circle")
	arg_17_0.bignode.goicon = gohelper.findChild(var_17_0, "go_icon")
	arg_17_0.bignode.txtNum = gohelper.findChildText(var_17_0, "#txt_num")
	arg_17_0.bignode.gocanget = gohelper.findChild(var_17_0, "go_canget")
	arg_17_0.bignode.goreceive = gohelper.findChild(var_17_0, "go_receive")
	arg_17_0.bignode.txtPoint = gohelper.findChildText(var_17_0, "point/#txt_point")
	arg_17_0.bignode.golight = gohelper.findChild(var_17_0, "point/light")
	arg_17_0.bignode.gogrey = gohelper.findChild(var_17_0, "point/grey")

	local var_17_1 = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(arg_17_0._turnbackId)
	local var_17_2 = var_17_1[#var_17_1]

	arg_17_0.bignode.config = var_17_2

	local var_17_3 = string.splitToNumber(var_17_2.bonus, "#")
	local var_17_4 = var_17_3[1]
	local var_17_5 = var_17_3[2]
	local var_17_6 = var_17_3[3]
	local var_17_7 = ItemConfig.instance:getItemConfig(var_17_4, var_17_5)

	UISpriteSetMgr.instance:setUiFBSprite(arg_17_0.bignode.imgquality, "bg2_pinjidi_" .. var_17_7.rare)
	UISpriteSetMgr.instance:setUiFBSprite(arg_17_0.bignode.imgCircle, "bg_pinjidi_lanse_" .. var_17_7.rare)

	if var_17_3 then
		if not arg_17_0.bignode.itemIcon then
			arg_17_0.bignode.itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_17_0.bignode.goicon)
		end

		arg_17_0.bignode.itemIcon:setMOValue(var_17_3[1], var_17_3[2], var_17_3[3], nil, true)
		arg_17_0.bignode.itemIcon:isShowQuality(false)
		arg_17_0.bignode.itemIcon:isShowCount(false)
	end

	arg_17_0.bignode.txtNum.text = var_17_6
	arg_17_0.bignode.txtPoint.text = var_17_2.needPoint

	arg_17_0:refreshBigRewardNode()
end

function var_0_0.refreshBigRewardNode(arg_18_0)
	local var_18_0 = TurnbackModel.instance:checkBonusGetById(arg_18_0.bignode.config.id)

	gohelper.setActive(arg_18_0.bignode.goreceive, var_18_0)
	gohelper.setActive(arg_18_0.bignode.golight, var_18_0)
	gohelper.setActive(arg_18_0.bignode.gogrey, not var_18_0)
end

function var_0_0.onClickReplay(arg_19_0)
	local var_19_0 = TurnbackModel.instance:getCurTurnbackMo()
	local var_19_1 = var_19_0 and var_19_0.config and var_19_0.config.startStory

	if var_19_1 then
		StoryController.instance:playStory(var_19_1)
	else
		logError(string.format("TurnbackRewardShowView startStoryId is nil", var_19_1))
	end
end

function var_0_0.onClickBuy(arg_20_0)
	if not TurnbackModel.instance:getBuyDoubleBonus() then
		ViewMgr.instance:openView(ViewName.TurnbackDoubleRewardChargeView)
		StatController.instance:track(StatEnum.EventName.ClickReflowDoubleClaim, {})
	end
end

function var_0_0.onClickLeft(arg_21_0)
	if arg_21_0._heroIndex > 1 then
		arg_21_0._rightAnimator:Update(0)
		arg_21_0._rightAnimator:Play("leftout")
		TaskDispatcher.runDelay(arg_21_0._afterleftout, arg_21_0, 0.3)
		AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_nameplate_switch)
	end
end

function var_0_0._afterleftout(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._afterleftout, arg_22_0)
	arg_22_0._rightAnimator:Update(0)
	arg_22_0._rightAnimator:Play("leftin")

	local var_22_0 = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(arg_22_0._turnbackId)

	if arg_22_0._heroIndex == #var_22_0 and arg_22_0._isfinish then
		arg_22_0._isfinish = false

		gohelper.setActive(arg_22_0._gofinished, arg_22_0._isfinish)
		gohelper.setActive(arg_22_0._gounfinish, not arg_22_0._isfinish)
		gohelper.setActive(arg_22_0._gonumbg, not arg_22_0._isfinish)
		gohelper.setActive(arg_22_0._gotitlebg, not arg_22_0._isfinish)
		gohelper.setActive(arg_22_0._btnright.gameObject, not arg_22_0._isfinish)
	else
		arg_22_0._heroIndex = arg_22_0._heroIndex - 1

		arg_22_0:_refreshHero()
	end

	TaskDispatcher.runDelay(arg_22_0._afterleftin, arg_22_0, 0.3)
end

function var_0_0._afterleftin(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._afterleftin, arg_23_0)
end

function var_0_0._afterrightout(arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._afterrightout, arg_24_0)
	arg_24_0._rightAnimator:Update(0)
	arg_24_0._rightAnimator:Play("rightin")

	local var_24_0 = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(arg_24_0._turnbackId)

	if arg_24_0._heroIndex < #var_24_0 then
		arg_24_0._heroIndex = arg_24_0._heroIndex + 1

		arg_24_0:_refreshHero()
	else
		arg_24_0._isfinish = true

		gohelper.setActive(arg_24_0._gofinished, arg_24_0._isfinish)
		gohelper.setActive(arg_24_0._gounfinish, not arg_24_0._isfinish)
		gohelper.setActive(arg_24_0._gonumbg, not arg_24_0._isfinish)
		gohelper.setActive(arg_24_0._gotitlebg, not arg_24_0._isfinish)
		gohelper.setActive(arg_24_0._btnright.gameObject, not arg_24_0._isfinish)
	end

	TaskDispatcher.runDelay(arg_24_0._afterrightin, arg_24_0, 0.3)
end

function var_0_0._afterrightin(arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._afterrightin, arg_25_0)
end

function var_0_0.onClickRight(arg_26_0)
	arg_26_0._rightAnimator:Update(0)
	arg_26_0._rightAnimator:Play("rightout")
	TaskDispatcher.runDelay(arg_26_0._afterrightout, arg_26_0, 0.3)
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_nameplate_switch)
end

function var_0_0.onCilckReverse(arg_27_0)
	arg_27_0._isreverse = not arg_27_0._isreverse

	gohelper.setActive(arg_27_0._simageHero.gameObject, not arg_27_0._isreverse)
	gohelper.setActive(arg_27_0._goscrolldesc, arg_27_0._isreverse)
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_nameplate_switch)

	if arg_27_0._isreverse then
		arg_27_0._rightTextAnim:Play()
	end
end

function var_0_0._playGetRewardFinishAnim(arg_28_0, arg_28_1)
	if arg_28_1 then
		arg_28_0.removeIndexTab = {
			arg_28_1
		}
	end

	TaskDispatcher.runDelay(arg_28_0.delayPlayFinishAnim, arg_28_0, TurnbackEnum.TaskGetAnimTime)
end

function var_0_0.delayPlayFinishAnim(arg_29_0)
	arg_29_0._taskAnimRemoveItem:removeByIndexs(arg_29_0.removeIndexTab)
end

function var_0_0.succbuydoublereward(arg_30_0)
	arg_30_0._needPlayAnim = true
end

function var_0_0._afterbuyanim(arg_31_0)
	arg_31_0._needPlayAnim = false

	TaskDispatcher.cancelTask(arg_31_0._afterbuyanim, arg_31_0)
	gohelper.setActive(arg_31_0._gonormal, true)
	gohelper.setActive(arg_31_0._godouble, true)
	arg_31_0._topAnimator:Play("unlock")
	TaskDispatcher.runDelay(arg_31_0._afterunlockanim, arg_31_0, 0.6)
end

function var_0_0._afterunlockanim(arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0._afterunlockanim, arg_32_0)
	arg_32_0:refreshTopBg()
end

function var_0_0._onCloseViewFinish(arg_33_0, arg_33_1)
	if arg_33_1 == ViewName.CommonPropView then
		arg_33_0:_refreshUI()
	end

	if arg_33_0._needPlayAnim then
		TaskDispatcher.runDelay(arg_33_0._afterbuyanim, arg_33_0, 0.3)
	end
end

function var_0_0.onOpen(arg_34_0)
	local var_34_0 = arg_34_0.viewParam.parent

	gohelper.addChild(var_34_0, arg_34_0.viewGO)
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_Interface_entry_01)
	arg_34_0:refreshTopBg()
end

function var_0_0.onClose(arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._afterbuyanim, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._afterunlockanim, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._afterleftin, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._afterleftout, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._afterrightin, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._afterrightout, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0.checkScrollEnd, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0.checkTaskScrollEnd, arg_35_0)
	arg_35_0._simageHero:UnLoadImage()
end

function var_0_0.onDestroyView(arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0.delayPlayFinishAnim, arg_36_0)
end

return var_0_0
