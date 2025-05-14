module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchMainView", package.seeall)

local var_0_0 = class("RoleStoryDispatchMainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.txtTitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/Title/#txt_Title")
	arg_1_0.txtTitleen = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/Title/#txt_Titleen")
	arg_1_0.txtTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#txt_LimitTime")
	arg_1_0.btnProgress = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_progress")
	arg_1_0.slider = gohelper.findChildImage(arg_1_0.viewGO, "Right/#go_progress/Background")
	arg_1_0.txtProgress = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#go_progress/#txt_schedule")
	arg_1_0.imgaePower = gohelper.findChildImage(arg_1_0.viewGO, "Right/#go_progress/#icon1")
	arg_1_0.simageCost = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#go_progress/#icon2")
	arg_1_0.goTips = gohelper.findChild(arg_1_0.viewGO, "Right/#go_progress/#go_ruletipdetail")
	arg_1_0.btnTips = gohelper.findChildButtonWithAudio(arg_1_0.goTips, "#btn_closeruletip")
	arg_1_0.txtTips = gohelper.findChildTextMesh(arg_1_0.goTips, "#go_rule2/rule2")
	arg_1_0.vxGO1 = gohelper.findChild(arg_1_0.viewGO, "#go_topright/vx_collect")
	arg_1_0.vxGO2 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_progress/vx_collect")
	arg_1_0.btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0.goEnterRed = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Enter/#image_reddot")

	RedDotController.instance:addRedDot(arg_1_0.goEnterRed, RedDotEnum.DotNode.RoleStoryDispatch)

	arg_1_0.btnScore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_scorereward")
	arg_1_0.txtScore = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#btn_scorereward/score/#txt_score")
	arg_1_0.scoreAnim = gohelper.findChildComponent(arg_1_0.viewGO, "Right/#btn_scorereward/ani", typeof(UnityEngine.Animator))
	arg_1_0.goScoreRed = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_scorereward/#go_rewardredpoint")
	arg_1_0.btnRead = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Middle/#btn_read")
	arg_1_0.itemPos = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_rolestoryitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnProgress, arg_2_0.onClickBtnProgress, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnTips, arg_2_0.onClickBtnTips, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnEnter, arg_2_0.onClickBtnEnter, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnScore, arg_2_0.onClickBtnScore, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnRead, arg_2_0.onClickBtnRead, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ActStoryChange, arg_2_0._onStoryChange, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ScoreUpdate, arg_2_0._onScoreUpdate, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.GetScoreBonus, arg_2_0._onScoreUpdate, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.UpdateInfo, arg_2_0._onUpdateInfo, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ExchangeTick, arg_2_0._onExchangeTick, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.PowerChange, arg_2_0._onPowerChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickBtnProgress(arg_5_0)
	gohelper.setActive(arg_5_0.goTips, true)

	local var_5_0 = {
		CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost),
		CommonConfig.instance:getConstNum(ConstEnum.RoleStoryDayChangeNum)
	}

	arg_5_0.txtTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rolestoryactivitytips"), var_5_0)
end

function var_0_0.onClickBtnTips(arg_6_0)
	gohelper.setActive(arg_6_0.goTips, false)
end

function var_0_0.onClickBtnEnter(arg_7_0)
	local var_7_0 = RoleStoryModel.instance:getCurActStoryId()

	RoleStoryController.instance:openDispatchView(var_7_0)
end

function var_0_0.onClickBtnScore(arg_8_0)
	ViewMgr.instance:openView(ViewName.RoleStoryRewardView)
end

function var_0_0.onClickBtnRead(arg_9_0)
	local var_9_0 = RoleStoryModel.instance:getCurActStoryId()
	local var_9_1 = RoleStoryModel.instance:getById(var_9_0)

	if not var_9_1 then
		return
	end

	if var_9_1.hasUnlock then
		RoleStoryController.instance:enterRoleStoryChapter(var_9_0)
	end
end

function var_0_0._onStoryChange(arg_10_0)
	HeroStoryRpc.instance:sendGetHeroStoryRequest()
end

function var_0_0._onScoreUpdate(arg_11_0)
	arg_11_0:refreshScore()
end

function var_0_0._onUpdateInfo(arg_12_0)
	arg_12_0:refreshScore()
	arg_12_0:refreshView()
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0:refreshProgress()
	arg_13_0:refreshScore()
	arg_13_0:refreshView()

	if arg_13_0.viewParam and arg_13_0.viewParam.clickItem and arg_13_0.roleItem then
		arg_13_0.roleItem:onClickItem()
	end
end

function var_0_0.onUpdateParam(arg_14_0)
	arg_14_0:refreshProgress()
	arg_14_0:refreshScore()
	arg_14_0:refreshView()
end

function var_0_0.checkEnterActivity(arg_15_0)
	local var_15_0 = RoleStoryModel.instance:getCurActStoryId()
	local var_15_1 = RoleStoryConfig.instance:getStoryById(var_15_0)

	if var_15_1 and var_15_1.activityId > 0 then
		ActivityEnterMgr.instance:enterActivity(var_15_1.activityId)
		ActivityRpc.instance:sendActivityNewStageReadRequest({
			var_15_1.activityId
		})
		ActivityStageHelper.recordOneActivityStage(var_15_1.activityId)
	end
end

function var_0_0.refreshScore(arg_16_0)
	local var_16_0 = RoleStoryModel.instance:getCurActStoryId()
	local var_16_1 = RoleStoryModel.instance:getById(var_16_0)

	if not var_16_1 then
		return
	end

	arg_16_0.txtScore.text = var_16_1:getScore()

	local var_16_2 = var_16_1:hasScoreReward()

	gohelper.setActive(arg_16_0.goScoreRed, var_16_2)

	if var_16_2 then
		arg_16_0.scoreAnim:Play("loop")
	else
		arg_16_0.scoreAnim:Play("idle")
	end
end

function var_0_0.refreshView(arg_17_0)
	arg_17_0:refreshRoleItem()
	arg_17_0:refreshLeftTime()
	arg_17_0:refreshTitle()
	TaskDispatcher.cancelTask(arg_17_0.refreshLeftTime, arg_17_0)
	TaskDispatcher.runRepeat(arg_17_0.refreshLeftTime, arg_17_0, 1)
	arg_17_0:checkEnterActivity()
end

function var_0_0.refreshTitle(arg_18_0)
	local var_18_0 = RoleStoryModel.instance:getCurActStoryId()
	local var_18_1 = RoleStoryModel.instance:getById(var_18_0)

	if not var_18_1 then
		return
	end

	local var_18_2 = var_18_1.cfg.name
	local var_18_3 = GameUtil.utf8len(var_18_2)
	local var_18_4 = GameUtil.utf8sub(var_18_2, 1, 1)
	local var_18_5 = ""
	local var_18_6 = ""

	if var_18_3 > 1 then
		var_18_5 = GameUtil.utf8sub(var_18_2, 2, 2)
	end

	if var_18_3 > 3 then
		var_18_6 = GameUtil.utf8sub(var_18_2, 4, var_18_3 - 3)
	end

	arg_18_0.txtTitle.text = string.format("<size=100>%s</size>%s%s", var_18_4, var_18_5, var_18_6)
	arg_18_0.txtTitleen.text = var_18_1.cfg.nameEn
end

function var_0_0.refreshRoleItem(arg_19_0)
	if not arg_19_0.roleItem then
		local var_19_0 = arg_19_0:getResInst(arg_19_0.viewContainer:getSetting().otherRes.itemRes, arg_19_0.itemPos)

		arg_19_0.roleItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_19_0, RoleStoryItem)

		arg_19_0.roleItem:initInternal(var_19_0, arg_19_0)
	end

	local var_19_1 = RoleStoryModel.instance:getCurActStoryId()
	local var_19_2 = RoleStoryModel.instance:getById(var_19_1)

	arg_19_0.roleItem:onUpdateMO(var_19_2)
	gohelper.setActive(arg_19_0.btnRead, var_19_2 and var_19_2.hasUnlock)
end

function var_0_0.refreshProgress(arg_20_0)
	gohelper.setActive(arg_20_0.vxGO1, false)
	gohelper.setActive(arg_20_0.vxGO2, false)

	local var_20_0 = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.Power)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_20_0.imgaePower, var_20_0.icon .. "_1")

	local var_20_1 = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryActivityItemId)
	local var_20_2 = ItemModel.instance:getItemSmallIcon(var_20_1)

	arg_20_0.simageCost:LoadImage(var_20_2)

	if arg_20_0.tweenId then
		ZProj.TweenHelper.KillById(arg_20_0.tweenId)

		arg_20_0.tweenId = nil
	end

	local var_20_3, var_20_4 = RoleStoryModel.instance:getLeftNum()

	if var_20_4 ~= var_20_3 then
		UIBlockMgr.instance:startBlock(arg_20_0.viewName)
		RoleStoryModel.instance:setLastLeftNum(var_20_3)

		local var_20_5 = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost)

		if var_20_5 <= var_20_4 and var_20_5 <= var_20_3 then
			arg_20_0:setFinalValue()
		else
			local var_20_6 = math.min(var_20_3, var_20_5)
			local var_20_7 = math.abs(var_20_6 - var_20_4) * 0.01

			arg_20_0.tweenId = ZProj.TweenHelper.DOTweenFloat(var_20_4, var_20_6, var_20_7, arg_20_0.setSliderValue, arg_20_0.setFinalValue, arg_20_0, nil, EaseType.Linear)
		end
	else
		arg_20_0:setFinalValue()
	end
end

function var_0_0._onExchangeTick(arg_21_0)
	arg_21_0:refreshProgress()
end

function var_0_0._onPowerChange(arg_22_0)
	arg_22_0:refreshProgress()
end

function var_0_0.setFinalValue(arg_23_0)
	UIBlockMgr.instance:endBlock(arg_23_0.viewName)

	local var_23_0 = RoleStoryModel.instance:getLeftNum()

	arg_23_0:setSliderValue(var_23_0)
	arg_23_0:checkChangeTick()
end

function var_0_0.setSliderValue(arg_24_0, arg_24_1)
	local var_24_0 = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost)

	arg_24_0.slider.fillAmount = arg_24_1 / var_24_0

	if not RoleStoryModel.instance:checkTodayCanExchange() then
		arg_24_0.txtProgress.text = luaLang("reachUpperLimit")
	else
		arg_24_0.txtProgress.text = string.format("%s/%s", math.floor(arg_24_1), var_24_0)
	end
end

function var_0_0.checkChangeTick(arg_25_0)
	if CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost) <= RoleStoryModel.instance:getLeftNum() and RoleStoryModel.instance:checkTodayCanExchange() then
		UIBlockMgr.instance:startBlock(arg_25_0.viewName)
		gohelper.setActive(arg_25_0.vxGO1, true)
		gohelper.setActive(arg_25_0.vxGO2, true)
		TaskDispatcher.cancelTask(arg_25_0.sendExchangeTicket, arg_25_0)
		TaskDispatcher.runDelay(arg_25_0.sendExchangeTicket, arg_25_0, 1.5)
	end
end

function var_0_0.sendExchangeTicket(arg_26_0)
	UIBlockMgr.instance:endBlock(arg_26_0.viewName)
	TaskDispatcher.cancelTask(arg_26_0.sendExchangeTicket, arg_26_0)
	HeroStoryRpc.instance:sendExchangeTicketRequest()
end

function var_0_0.refreshLeftTime(arg_27_0)
	local var_27_0 = RoleStoryModel.instance:getCurActStoryId()
	local var_27_1 = RoleStoryModel.instance:getById(var_27_0)

	if not var_27_1 then
		return
	end

	local var_27_2, var_27_3 = var_27_1:getActTime()
	local var_27_4 = var_27_3 - ServerTime.now()

	if var_27_4 > 0 then
		local var_27_5, var_27_6, var_27_7, var_27_8 = TimeUtil.secondsToDDHHMMSS(var_27_4)
		local var_27_9

		if var_27_5 > 0 then
			var_27_9 = GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
				string.format("<color=#f09a5a>%s</color>", var_27_5),
				string.format("<color=#f09a5a>%s</color>", var_27_6)
			})
		elseif var_27_6 > 0 then
			var_27_9 = GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
				string.format("<color=#f09a5a>%s</color>", var_27_6),
				string.format("<color=#f09a5a>%s</color>", var_27_7)
			})
		elseif var_27_7 > 0 then
			var_27_9 = GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
				string.format("<color=#f09a5a>%s</color>", 0),
				string.format("<color=#f09a5a>%s</color>", var_27_7)
			})
		elseif var_27_8 > 0 then
			var_27_9 = GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
				string.format("<color=#f09a5a>%s</color>", 0),
				string.format("<color=#f09a5a>%s</color>", 1)
			})
		end

		arg_27_0.txtTime.text = formatLuaLang("summonmainequipprobup_deadline", var_27_9)
	else
		TaskDispatcher.cancelTask(arg_27_0.refreshLeftTime, arg_27_0)
	end
end

function var_0_0.onClose(arg_28_0)
	return
end

function var_0_0.onDestroyView(arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0.refreshLeftTime, arg_29_0)
end

return var_0_0
