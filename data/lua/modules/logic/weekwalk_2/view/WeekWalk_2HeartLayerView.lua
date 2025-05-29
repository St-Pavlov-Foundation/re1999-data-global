module("modules.logic.weekwalk_2.view.WeekWalk_2HeartLayerView", package.seeall)

local var_0_0 = class("WeekWalk_2HeartLayerView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._goheart = gohelper.findChild(arg_1_0.viewGO, "bottom_left/#go_heart")
	arg_1_0._gocountdown = gohelper.findChild(arg_1_0.viewGO, "bottom_left/#go_heart/#go_countdown")
	arg_1_0._txtcountday = gohelper.findChildText(arg_1_0.viewGO, "bottom_left/#go_heart/#go_countdown/bg/#txt_countday")
	arg_1_0._goexcept = gohelper.findChild(arg_1_0.viewGO, "bottom_left/#go_heart/#go_except")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom_left/#go_heart/#btn_reward")
	arg_1_0._gobubble = gohelper.findChild(arg_1_0.viewGO, "bottom_left/#go_heart/#btn_reward/#go_bubble")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bottom_left/#go_heart/#btn_reward/#go_bubble/#simage_icon")
	arg_1_0._goruleIcon = gohelper.findChild(arg_1_0.viewGO, "#go_ruleIcon")
	arg_1_0._btnruleIcon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ruleIcon/#btn_ruleIcon")
	arg_1_0._gorulenew = gohelper.findChild(arg_1_0.viewGO, "#go_ruleIcon/#go_rulenew")
	arg_1_0._gobuffIcon = gohelper.findChild(arg_1_0.viewGO, "#go_buffIcon")
	arg_1_0._btnbuffIcon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buffIcon/#btn_buffIcon")
	arg_1_0._gobuffnew = gohelper.findChild(arg_1_0.viewGO, "#go_buffIcon/#go_buffnew")
	arg_1_0._goreviewIcon = gohelper.findChild(arg_1_0.viewGO, "#go_reviewIcon")
	arg_1_0._btnreviewIcon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_reviewIcon/#btn_reviewIcon")
	arg_1_0._txtdetaildesc = gohelper.findChildText(arg_1_0.viewGO, "bottom_right/#txt_detaildesc")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "bottom_right/badgelist/#go_item")
	arg_1_0._simagebgimgnext = gohelper.findChildSingleImage(arg_1_0.viewGO, "transition/ani/#simage_bgimg_next")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btnruleIcon:AddClickListener(arg_2_0._btnruleIconOnClick, arg_2_0)
	arg_2_0._btnbuffIcon:AddClickListener(arg_2_0._btnbuffIconOnClick, arg_2_0)
	arg_2_0._btnreviewIcon:AddClickListener(arg_2_0._btnreviewIconOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btnruleIcon:RemoveClickListener()
	arg_3_0._btnbuffIcon:RemoveClickListener()
	arg_3_0._btnreviewIcon:RemoveClickListener()
end

function var_0_0._btnrewardOnClick(arg_4_0)
	WeekWalk_2Controller.instance:openWeekWalk_2LayerRewardView({
		mapId = 0
	})
end

function var_0_0._btnreviewIconOnClick(arg_5_0)
	Weekwalk_2Rpc.instance:sendWeekwalkVer2GetSettleInfoRequest()
end

function var_0_0._btnruleIconOnClick(arg_6_0)
	WeekWalk_2Controller.instance:openWeekWalk_2RuleView()
end

function var_0_0._btnbuffIconOnClick(arg_7_0)
	WeekWalk_2Controller.instance:openWeekWalk_2HeartBuffView()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._rewardAnimator = arg_8_0._btnreward.gameObject:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_8_0._goitem, false)
	arg_8_0:_initPage()
end

function var_0_0._initItemList(arg_9_0)
	if arg_9_0._itemList then
		return
	end

	arg_9_0._itemList = arg_9_0:getUserDataTb_()

	for iter_9_0 = 1, WeekWalk_2Enum.MaxLayer do
		local var_9_0 = gohelper.cloneInPlace(arg_9_0._goitem)

		gohelper.setActive(var_9_0, true)

		local var_9_1 = gohelper.findChildImage(var_9_0, "badgelayout/1/icon")
		local var_9_2 = gohelper.findChildImage(var_9_0, "badgelayout/2/icon")
		local var_9_3 = gohelper.findChildText(var_9_0, "chapternum")

		var_9_3.text = iter_9_0

		local var_9_4 = arg_9_0:getResInst(arg_9_0.viewContainer._viewSetting.otherRes.weekwalkheart_star, var_9_1.gameObject)
		local var_9_5 = arg_9_0:getResInst(arg_9_0.viewContainer._viewSetting.otherRes.weekwalkheart_star, var_9_2.gameObject)

		var_9_1.enabled = false
		var_9_2.enabled = false
		arg_9_0._itemList[iter_9_0] = {
			icon1Effect = var_9_4,
			icon2Effect = var_9_5,
			txt = var_9_3
		}
	end

	arg_9_0:_updateItemList()
end

function var_0_0._updateItemList(arg_10_0)
	for iter_10_0 = 1, WeekWalk_2Enum.MaxLayer do
		local var_10_0 = arg_10_0._itemList[iter_10_0]
		local var_10_1 = var_10_0.icon1Effect
		local var_10_2 = var_10_0.icon2Effect
		local var_10_3 = arg_10_0._info:getLayerInfoByLayerIndex(iter_10_0)
		local var_10_4 = var_10_3:getBattleInfo(WeekWalk_2Enum.BattleIndex.First)
		local var_10_5 = var_10_3:getBattleInfo(WeekWalk_2Enum.BattleIndex.Second)

		if var_10_4 then
			local var_10_6 = var_10_4:getCupMaxResult() == WeekWalk_2Enum.CupType.Platinum and WeekWalk_2Enum.CupType.Platinum or WeekWalk_2Enum.CupType.None2

			WeekWalk_2Helper.setCupEffectByResult(var_10_1, var_10_6)
		end

		if var_10_5 then
			local var_10_7 = var_10_5:getCupMaxResult() == WeekWalk_2Enum.CupType.Platinum and WeekWalk_2Enum.CupType.Platinum or WeekWalk_2Enum.CupType.None2

			WeekWalk_2Helper.setCupEffectByResult(var_10_2, var_10_7)
		end
	end
end

function var_0_0._initPage(arg_11_0)
	local var_11_0 = arg_11_0:getResInst(arg_11_0.viewContainer._viewSetting.otherRes[1], arg_11_0._gocontent)

	arg_11_0._layerPage = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_0, WeekWalk_2HeartLayerPage, arg_11_0)
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnGetInfo, arg_13_0._onGetInfo, arg_13_0)
	arg_13_0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkInfoChange, arg_13_0._onChangeInfo, arg_13_0)
	arg_13_0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, arg_13_0._onWeekwalk_2TaskUpdate, arg_13_0)
	arg_13_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_13_0._onOpenView, arg_13_0)
	arg_13_0:_showDeadline()
	arg_13_0:_initItemList()
	arg_13_0:_onWeekwalk_2TaskUpdate()
	arg_13_0:_updateNewFlag()
end

function var_0_0.onOpenFinish(arg_14_0)
	local var_14_0 = arg_14_0._info.timeId

	if not not WeekWalk_2Controller.hasOnceActionKey(WeekWalk_2Enum.OnceAnimType.ResultReview, var_14_0) then
		return
	end

	WeekWalk_2Controller.setOnceActionKey(WeekWalk_2Enum.OnceAnimType.ResultReview, var_14_0)

	local var_14_1 = arg_14_0._goreviewIcon:GetComponent(typeof(UnityEngine.Animator))

	if var_14_1 then
		var_14_1:Play("open", 0, 0)
	end
end

function var_0_0._updateNewFlag(arg_15_0)
	local var_15_0 = arg_15_0._info.timeId
	local var_15_1 = not WeekWalk_2Controller.hasOnceActionKey(WeekWalk_2Enum.OnceAnimType.RuleNew, var_15_0)
	local var_15_2 = not WeekWalk_2Controller.hasOnceActionKey(WeekWalk_2Enum.OnceAnimType.BuffNew, var_15_0)

	gohelper.setActive(arg_15_0._gorulenew, var_15_1)
	gohelper.setActive(arg_15_0._gobuffnew, var_15_2)
end

function var_0_0._onOpenView(arg_16_0, arg_16_1)
	if arg_16_1 == ViewName.WeekWalk_2HeartBuffView then
		local var_16_0 = arg_16_0._info.timeId

		WeekWalk_2Controller.setOnceActionKey(WeekWalk_2Enum.OnceAnimType.BuffNew, var_16_0)
		arg_16_0:_updateNewFlag()
	elseif arg_16_1 == ViewName.WeekWalk_2RuleView then
		local var_16_1 = arg_16_0._info.timeId

		WeekWalk_2Controller.setOnceActionKey(WeekWalk_2Enum.OnceAnimType.RuleNew, var_16_1)
		arg_16_0:_updateNewFlag()
	end
end

function var_0_0._onWeekwalk_2TaskUpdate(arg_17_0)
	local var_17_0 = WeekWalk_2Enum.TaskType.Once
	local var_17_1, var_17_2 = WeekWalk_2TaskListModel.instance:canGetRewardNum(var_17_0)
	local var_17_3 = var_17_1 > 0

	gohelper.setActive(arg_17_0._gobubble, true)

	arg_17_0._gobubbleReddot = arg_17_0._gobubbleReddot or gohelper.findChild(arg_17_0.viewGO, "bottom_left/#go_heart/#btn_reward/reddot")

	gohelper.setActive(arg_17_0._gobubbleReddot, var_17_3)

	if arg_17_0._rewardAnimator then
		arg_17_0._rewardAnimator:Play(var_17_3 and "reward" or "idle")
	end

	if var_17_1 == 0 and var_17_2 == 0 then
		gohelper.setActive(arg_17_0._btnreward, false)
	end
end

function var_0_0._onChangeInfo(arg_18_0)
	arg_18_0:_updateItemList()
	arg_18_0:_showReviewIcon()
end

function var_0_0._onGetInfo(arg_19_0)
	arg_19_0:_showDeadline()
end

function var_0_0._showDeadline(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._onRefreshDeadline, arg_20_0)

	arg_20_0._info = WeekWalk_2Model.instance:getInfo()
	arg_20_0._endTime = arg_20_0._info.endTime

	TaskDispatcher.runRepeat(arg_20_0._onRefreshDeadline, arg_20_0, 1)
	arg_20_0:_onRefreshDeadline()
	arg_20_0:_showReviewIcon()
end

function var_0_0._showReviewIcon(arg_21_0)
	gohelper.setActive(arg_21_0._goreviewIcon, arg_21_0._info:allLayerPass())
end

function var_0_0._onRefreshDeadline(arg_22_0)
	local var_22_0 = arg_22_0._endTime - ServerTime.now()

	if var_22_0 <= 0 then
		TaskDispatcher.cancelTask(arg_22_0._onRefreshDeadline, arg_22_0)
	end

	local var_22_1 = luaLang("p_dungeonweekwalkview_device")
	local var_22_2, var_22_3 = TimeUtil.secondToRoughTime2(math.floor(var_22_0))

	arg_22_0._txtcountday.text = var_22_1 .. var_22_2 .. var_22_3
end

function var_0_0.onClose(arg_23_0)
	return
end

function var_0_0.onDestroyView(arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._onRefreshDeadline, arg_24_0)
end

return var_0_0
