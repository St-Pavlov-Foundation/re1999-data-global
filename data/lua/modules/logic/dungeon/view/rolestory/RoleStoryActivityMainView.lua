module("modules.logic.dungeon.view.rolestory.RoleStoryActivityMainView", package.seeall)

local var_0_0 = class("RoleStoryActivityMainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._actViewGO = gohelper.findChild(arg_1_0.viewGO, "actview")
	arg_1_0._challengeViewGO = gohelper.findChild(arg_1_0.viewGO, "challengeview")
	arg_1_0._showActView = true
	arg_1_0.btnScore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_scorereward")
	arg_1_0.txtScore = gohelper.findChildTextMesh(arg_1_0.viewGO, "#btn_scorereward/score/#txt_score")
	arg_1_0.scoreAnim = gohelper.findChildComponent(arg_1_0.viewGO, "#btn_scorereward/ani", typeof(UnityEngine.Animator))
	arg_1_0.goScoreRed = gohelper.findChild(arg_1_0.viewGO, "#btn_scorereward/#go_rewardredpoint")
	arg_1_0.btnProgress = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_progress")
	arg_1_0.slider = gohelper.findChildImage(arg_1_0.viewGO, "#go_progress/Background")
	arg_1_0.txtProgress = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_progress/#txt_schedule")
	arg_1_0.imgaePower = gohelper.findChildImage(arg_1_0.viewGO, "#go_progress/#icon1")
	arg_1_0.simageCost = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_progress/#icon2")
	arg_1_0.goTips = gohelper.findChild(arg_1_0.viewGO, "#go_progress/#go_ruletipdetail")
	arg_1_0.btnTips = gohelper.findChildButtonWithAudio(arg_1_0.goTips, "#btn_closeruletip")
	arg_1_0.txtTips = gohelper.findChildTextMesh(arg_1_0.goTips, "#go_rule2/rule2")
	arg_1_0.vxGO1 = gohelper.findChild(arg_1_0.viewGO, "#go_topright/vx_collect")
	arg_1_0.vxGO2 = gohelper.findChild(arg_1_0.viewGO, "#go_progress/vx_collect")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.btnScore:AddClickListener(arg_2_0._btnscoreOnClick, arg_2_0)
	arg_2_0.btnProgress:AddClickListener(arg_2_0._btnprogressOnClick, arg_2_0)
	arg_2_0.btnTips:AddClickListener(arg_2_0._btntipsOnClick, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ActStoryChange, arg_2_0._onStoryChange, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ChangeMainViewShow, arg_2_0._onChangeMainViewShow, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ScoreUpdate, arg_2_0._onScoreUpdate, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.GetScoreBonus, arg_2_0._onScoreUpdate, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.UpdateInfo, arg_2_0._onUpdateInfo, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ExchangeTick, arg_2_0._onExchangeTick, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.PowerChange, arg_2_0._onPowerChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.btnScore:RemoveClickListener()
	arg_3_0.btnProgress:RemoveClickListener()
	arg_3_0.btnTips:RemoveClickListener()
	arg_3_0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.ActStoryChange, arg_3_0._onStoryChange, arg_3_0)
	arg_3_0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.ChangeMainViewShow, arg_3_0._onChangeMainViewShow, arg_3_0)
	arg_3_0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.ScoreUpdate, arg_3_0._onScoreUpdate, arg_3_0)
	arg_3_0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.GetScoreBonus, arg_3_0._onScoreUpdate, arg_3_0)
	arg_3_0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.UpdateInfo, arg_3_0._onUpdateInfo, arg_3_0)
	arg_3_0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.ExchangeTick, arg_3_0._onExchangeTick, arg_3_0)
	arg_3_0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.PowerChange, arg_3_0._onPowerChange, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._btnscoreOnClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.RoleStoryRewardView)
end

function var_0_0._onStoryChange(arg_6_0)
	HeroStoryRpc.instance:sendGetHeroStoryRequest()
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:refreshView()
end

function var_0_0.onOpen(arg_8_0)
	if arg_8_0.viewParam and arg_8_0.viewParam[1] == 1 then
		arg_8_0._showActView = false
	end

	arg_8_0:refreshCurrency()
	arg_8_0:refreshProgress()
	arg_8_0:refreshScore()
	arg_8_0:refreshView()
	gohelper.setActive(arg_8_0._actViewGO, arg_8_0._showActView)
	gohelper.setActive(arg_8_0._challengeViewGO, not arg_8_0._showActView)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0._onChangeMainViewShow(arg_10_0, arg_10_1)
	if arg_10_0._showActView == arg_10_1 then
		return
	end

	arg_10_0:_btntipsOnClick()

	arg_10_0._showActView = arg_10_1

	arg_10_0:refreshScore()
	arg_10_0:refreshCurrency()
	arg_10_0:refreshProgress(true)
	arg_10_0:refreshView()
	gohelper.setActive(arg_10_0._actViewGO, true)
	gohelper.setActive(arg_10_0._challengeViewGO, true)
	UIBlockMgr.instance:startBlock("RoleStoryActivityMainViewSwitch")

	if arg_10_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Rolesopen)
		arg_10_0.viewContainer:playAnim("to_act", arg_10_0.onAnimFinish, arg_10_0)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Rolesclose)
		arg_10_0.viewContainer:playAnim("to_challege", arg_10_0.onAnimFinish, arg_10_0)
	end
end

function var_0_0.onAnimFinish(arg_11_0)
	gohelper.setActive(arg_11_0._actViewGO, arg_11_0._showActView)
	gohelper.setActive(arg_11_0._challengeViewGO, not arg_11_0._showActView)
	UIBlockMgr.instance:endBlock("RoleStoryActivityMainViewSwitch")
end

function var_0_0._onScoreUpdate(arg_12_0)
	arg_12_0:refreshScore()
end

function var_0_0._onUpdateInfo(arg_13_0)
	arg_13_0:refreshScore()
	arg_13_0:refreshView()
end

function var_0_0.refreshCurrency(arg_14_0)
	if arg_14_0._showActView then
		local var_14_0 = {
			{
				isIcon = true,
				type = MaterialEnum.MaterialType.Item,
				id = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryActivityItemId)
			},
			CurrencyEnum.CurrencyType.RoleStory
		}

		arg_14_0.viewContainer:refreshCurrency(var_14_0)
	else
		local var_14_1 = {
			{
				isIcon = true,
				type = MaterialEnum.MaterialType.Item,
				id = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryActivityItemId)
			}
		}

		arg_14_0.viewContainer:refreshCurrency(var_14_1)
	end
end

function var_0_0.onSetVisible(arg_15_0)
	if arg_15_0.waitRefresh then
		arg_15_0:refreshView()
	end
end

function var_0_0.refreshView(arg_16_0)
	if not arg_16_0.viewContainer:getVisible() then
		arg_16_0.waitRefresh = true

		return
	end

	arg_16_0.waitRefresh = false

	if arg_16_0._showActView then
		arg_16_0.viewContainer.actView:refreshView()
	else
		arg_16_0.viewContainer.challengeView:refreshView()
	end

	arg_16_0:checkEnterActivity()
end

function var_0_0.checkEnterActivity(arg_17_0)
	local var_17_0 = RoleStoryModel.instance:getCurActStoryId()
	local var_17_1 = RoleStoryConfig.instance:getStoryById(var_17_0)

	if var_17_1 and var_17_1.activityId > 0 then
		ActivityEnterMgr.instance:enterActivity(var_17_1.activityId)
		ActivityRpc.instance:sendActivityNewStageReadRequest({
			var_17_1.activityId
		})
		ActivityStageHelper.recordOneActivityStage(var_17_1.activityId)
	end
end

function var_0_0.refreshScore(arg_18_0)
	local var_18_0 = RoleStoryModel.instance:getCurActStoryId()
	local var_18_1 = RoleStoryModel.instance:getById(var_18_0)

	if not var_18_1 then
		return
	end

	arg_18_0.txtScore.text = var_18_1:getScore()

	local var_18_2 = var_18_1:hasScoreReward()

	gohelper.setActive(arg_18_0.goScoreRed, var_18_2)

	if var_18_2 then
		arg_18_0.scoreAnim:Play("loop")
	else
		arg_18_0.scoreAnim:Play("idle")
	end
end

function var_0_0._btnprogressOnClick(arg_19_0)
	gohelper.setActive(arg_19_0.goTips, true)

	local var_19_0 = {
		CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost),
		CommonConfig.instance:getConstNum(ConstEnum.RoleStoryDayChangeNum)
	}

	arg_19_0.txtTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rolestoryactivitytips"), var_19_0)
end

function var_0_0._btntipsOnClick(arg_20_0)
	gohelper.setActive(arg_20_0.goTips, false)
end

function var_0_0._onExchangeTick(arg_21_0)
	arg_21_0:refreshProgress()
end

function var_0_0._onPowerChange(arg_22_0)
	arg_22_0:refreshProgress()
end

function var_0_0.refreshProgress(arg_23_0)
	gohelper.setActive(arg_23_0.vxGO1, false)
	gohelper.setActive(arg_23_0.vxGO2, false)

	local var_23_0 = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.Power)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_23_0.imgaePower, var_23_0.icon .. "_1")

	local var_23_1 = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryActivityItemId)
	local var_23_2 = ItemModel.instance:getItemSmallIcon(var_23_1)

	arg_23_0.simageCost:LoadImage(var_23_2)

	if arg_23_0.tweenId then
		ZProj.TweenHelper.KillById(arg_23_0.tweenId)

		arg_23_0.tweenId = nil
	end

	local var_23_3, var_23_4 = RoleStoryModel.instance:getLeftNum()

	if var_23_4 ~= var_23_3 then
		UIBlockMgr.instance:startBlock(arg_23_0.viewName)
		RoleStoryModel.instance:setLastLeftNum(var_23_3)

		local var_23_5 = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost)

		if var_23_5 <= var_23_4 and var_23_5 <= var_23_3 then
			arg_23_0:setFinalValue()
		else
			local var_23_6 = math.min(var_23_3, var_23_5)
			local var_23_7 = math.abs(var_23_6 - var_23_4) * 0.01

			arg_23_0.tweenId = ZProj.TweenHelper.DOTweenFloat(var_23_4, var_23_6, var_23_7, arg_23_0.setSliderValue, arg_23_0.setFinalValue, arg_23_0, nil, EaseType.Linear)
		end
	else
		arg_23_0:setFinalValue()
	end
end

function var_0_0.setFinalValue(arg_24_0)
	UIBlockMgr.instance:endBlock(arg_24_0.viewName)

	local var_24_0 = RoleStoryModel.instance:getLeftNum()

	arg_24_0:setSliderValue(var_24_0)
	arg_24_0:checkChangeTick()
end

function var_0_0.setSliderValue(arg_25_0, arg_25_1)
	local var_25_0 = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost)

	arg_25_0.slider.fillAmount = arg_25_1 / var_25_0

	if not RoleStoryModel.instance:checkTodayCanExchange() then
		arg_25_0.txtProgress.text = luaLang("reachUpperLimit")
	else
		arg_25_0.txtProgress.text = string.format("%s/%s", math.floor(arg_25_1), var_25_0)
	end
end

function var_0_0.checkChangeTick(arg_26_0)
	if CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost) <= RoleStoryModel.instance:getLeftNum() and RoleStoryModel.instance:checkTodayCanExchange() then
		UIBlockMgr.instance:startBlock(arg_26_0.viewName)
		gohelper.setActive(arg_26_0.vxGO1, true)
		gohelper.setActive(arg_26_0.vxGO2, true)
		TaskDispatcher.cancelTask(arg_26_0.sendExchangeTicket, arg_26_0)
		TaskDispatcher.runDelay(arg_26_0.sendExchangeTicket, arg_26_0, 1.5)
	end
end

function var_0_0.sendExchangeTicket(arg_27_0)
	UIBlockMgr.instance:endBlock(arg_27_0.viewName)
	TaskDispatcher.cancelTask(arg_27_0.sendExchangeTicket, arg_27_0)
	HeroStoryRpc.instance:sendExchangeTicketRequest()
end

function var_0_0.onDestroyView(arg_28_0)
	UIBlockMgr.instance:endBlock(arg_28_0.viewName)
	TaskDispatcher.cancelTask(arg_28_0.sendExchangeTicket, arg_28_0)
	arg_28_0.simageCost:UnLoadImage()
end

return var_0_0
