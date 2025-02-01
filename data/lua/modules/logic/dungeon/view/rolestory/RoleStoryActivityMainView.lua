module("modules.logic.dungeon.view.rolestory.RoleStoryActivityMainView", package.seeall)

slot0 = class("RoleStoryActivityMainView", BaseView)

function slot0.onInitView(slot0)
	slot0._actViewGO = gohelper.findChild(slot0.viewGO, "actview")
	slot0._challengeViewGO = gohelper.findChild(slot0.viewGO, "challengeview")
	slot0._showActView = true
	slot0.btnScore = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_scorereward")
	slot0.txtScore = gohelper.findChildTextMesh(slot0.viewGO, "#btn_scorereward/score/#txt_score")
	slot0.scoreAnim = gohelper.findChildComponent(slot0.viewGO, "#btn_scorereward/ani", typeof(UnityEngine.Animator))
	slot0.goScoreRed = gohelper.findChild(slot0.viewGO, "#btn_scorereward/#go_rewardredpoint")
	slot0.btnProgress = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_progress")
	slot0.slider = gohelper.findChildImage(slot0.viewGO, "#go_progress/Background")
	slot0.txtProgress = gohelper.findChildTextMesh(slot0.viewGO, "#go_progress/#txt_schedule")
	slot0.imgaePower = gohelper.findChildImage(slot0.viewGO, "#go_progress/#icon1")
	slot0.simageCost = gohelper.findChildSingleImage(slot0.viewGO, "#go_progress/#icon2")
	slot0.goTips = gohelper.findChild(slot0.viewGO, "#go_progress/#go_ruletipdetail")
	slot0.btnTips = gohelper.findChildButtonWithAudio(slot0.goTips, "#btn_closeruletip")
	slot0.txtTips = gohelper.findChildTextMesh(slot0.goTips, "#go_rule2/rule2")
	slot0.vxGO1 = gohelper.findChild(slot0.viewGO, "#go_topright/vx_collect")
	slot0.vxGO2 = gohelper.findChild(slot0.viewGO, "#go_progress/vx_collect")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0.btnScore:AddClickListener(slot0._btnscoreOnClick, slot0)
	slot0.btnProgress:AddClickListener(slot0._btnprogressOnClick, slot0)
	slot0.btnTips:AddClickListener(slot0._btntipsOnClick, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ActStoryChange, slot0._onStoryChange, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ChangeMainViewShow, slot0._onChangeMainViewShow, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ScoreUpdate, slot0._onScoreUpdate, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.GetScoreBonus, slot0._onScoreUpdate, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.UpdateInfo, slot0._onUpdateInfo, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ExchangeTick, slot0._onExchangeTick, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.PowerChange, slot0._onPowerChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0.btnScore:RemoveClickListener()
	slot0.btnProgress:RemoveClickListener()
	slot0.btnTips:RemoveClickListener()
	slot0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.ActStoryChange, slot0._onStoryChange, slot0)
	slot0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.ChangeMainViewShow, slot0._onChangeMainViewShow, slot0)
	slot0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.ScoreUpdate, slot0._onScoreUpdate, slot0)
	slot0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.GetScoreBonus, slot0._onScoreUpdate, slot0)
	slot0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.UpdateInfo, slot0._onUpdateInfo, slot0)
	slot0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.ExchangeTick, slot0._onExchangeTick, slot0)
	slot0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.PowerChange, slot0._onPowerChange, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._btnscoreOnClick(slot0)
	ViewMgr.instance:openView(ViewName.RoleStoryRewardView)
end

function slot0._onStoryChange(slot0)
	HeroStoryRpc.instance:sendGetHeroStoryRequest()
end

function slot0.onUpdateParam(slot0)
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	if slot0.viewParam and slot0.viewParam[1] == 1 then
		slot0._showActView = false
	end

	slot0:refreshCurrency()
	slot0:refreshProgress()
	slot0:refreshScore()
	slot0:refreshView()
	gohelper.setActive(slot0._actViewGO, slot0._showActView)
	gohelper.setActive(slot0._challengeViewGO, not slot0._showActView)
end

function slot0.onClose(slot0)
end

function slot0._onChangeMainViewShow(slot0, slot1)
	if slot0._showActView == slot1 then
		return
	end

	slot0:_btntipsOnClick()

	slot0._showActView = slot1

	slot0:refreshScore()
	slot0:refreshCurrency()
	slot0:refreshProgress(true)
	slot0:refreshView()
	gohelper.setActive(slot0._actViewGO, true)
	gohelper.setActive(slot0._challengeViewGO, true)
	UIBlockMgr.instance:startBlock("RoleStoryActivityMainViewSwitch")

	if slot1 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Rolesopen)
		slot0.viewContainer:playAnim("to_act", slot0.onAnimFinish, slot0)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Rolesclose)
		slot0.viewContainer:playAnim("to_challege", slot0.onAnimFinish, slot0)
	end
end

function slot0.onAnimFinish(slot0)
	gohelper.setActive(slot0._actViewGO, slot0._showActView)
	gohelper.setActive(slot0._challengeViewGO, not slot0._showActView)
	UIBlockMgr.instance:endBlock("RoleStoryActivityMainViewSwitch")
end

function slot0._onScoreUpdate(slot0)
	slot0:refreshScore()
end

function slot0._onUpdateInfo(slot0)
	slot0:refreshScore()
	slot0:refreshView()
end

function slot0.refreshCurrency(slot0)
	if slot0._showActView then
		slot0.viewContainer:refreshCurrency({
			{
				isIcon = true,
				type = MaterialEnum.MaterialType.Item,
				id = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryActivityItemId)
			},
			CurrencyEnum.CurrencyType.RoleStory
		})
	else
		slot0.viewContainer:refreshCurrency({
			{
				isIcon = true,
				type = MaterialEnum.MaterialType.Item,
				id = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryActivityItemId)
			}
		})
	end
end

function slot0.onSetVisible(slot0)
	if slot0.waitRefresh then
		slot0:refreshView()
	end
end

function slot0.refreshView(slot0)
	if not slot0.viewContainer:getVisible() then
		slot0.waitRefresh = true

		return
	end

	slot0.waitRefresh = false

	if slot0._showActView then
		slot0.viewContainer.actView:refreshView()
	else
		slot0.viewContainer.challengeView:refreshView()
	end

	slot0:checkEnterActivity()
end

function slot0.checkEnterActivity(slot0)
	if RoleStoryConfig.instance:getStoryById(RoleStoryModel.instance:getCurActStoryId()) and slot2.activityId > 0 then
		ActivityEnterMgr.instance:enterActivity(slot2.activityId)
		ActivityRpc.instance:sendActivityNewStageReadRequest({
			slot2.activityId
		})
		ActivityStageHelper.recordOneActivityStage(slot2.activityId)
	end
end

function slot0.refreshScore(slot0)
	if not RoleStoryModel.instance:getById(RoleStoryModel.instance:getCurActStoryId()) then
		return
	end

	slot0.txtScore.text = slot2:getScore()
	slot3 = slot2:hasScoreReward()

	gohelper.setActive(slot0.goScoreRed, slot3)

	if slot3 then
		slot0.scoreAnim:Play("loop")
	else
		slot0.scoreAnim:Play("idle")
	end
end

function slot0._btnprogressOnClick(slot0)
	gohelper.setActive(slot0.goTips, true)

	slot0.txtTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rolestoryactivitytips"), {
		CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost),
		CommonConfig.instance:getConstNum(ConstEnum.RoleStoryDayChangeNum)
	})
end

function slot0._btntipsOnClick(slot0)
	gohelper.setActive(slot0.goTips, false)
end

function slot0._onExchangeTick(slot0)
	slot0:refreshProgress()
end

function slot0._onPowerChange(slot0)
	slot0:refreshProgress()
end

function slot0.refreshProgress(slot0)
	gohelper.setActive(slot0.vxGO1, false)
	gohelper.setActive(slot0.vxGO2, false)
	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0.imgaePower, ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.Power).icon .. "_1")
	slot0.simageCost:LoadImage(ItemModel.instance:getItemSmallIcon(CommonConfig.instance:getConstNum(ConstEnum.RoleStoryActivityItemId)))

	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end

	slot4, slot5 = RoleStoryModel.instance:getLeftNum()

	if slot5 ~= slot4 then
		UIBlockMgr.instance:startBlock(slot0.viewName)
		RoleStoryModel.instance:setLastLeftNum(slot4)

		if CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost) <= slot5 and slot6 <= slot4 then
			slot0:setFinalValue()
		else
			slot4 = math.min(slot4, slot6)
			slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(slot5, slot4, math.abs(slot4 - slot5) * 0.01, slot0.setSliderValue, slot0.setFinalValue, slot0, nil, EaseType.Linear)
		end
	else
		slot0:setFinalValue()
	end
end

function slot0.setFinalValue(slot0)
	UIBlockMgr.instance:endBlock(slot0.viewName)
	slot0:setSliderValue(RoleStoryModel.instance:getLeftNum())
	slot0:checkChangeTick()
end

function slot0.setSliderValue(slot0, slot1)
	slot0.slider.fillAmount = slot1 / CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost)

	if not RoleStoryModel.instance:checkTodayCanExchange() then
		slot0.txtProgress.text = luaLang("reachUpperLimit")
	else
		slot0.txtProgress.text = string.format("%s/%s", math.floor(slot1), slot2)
	end
end

function slot0.checkChangeTick(slot0)
	if CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost) <= RoleStoryModel.instance:getLeftNum() and RoleStoryModel.instance:checkTodayCanExchange() then
		UIBlockMgr.instance:startBlock(slot0.viewName)
		gohelper.setActive(slot0.vxGO1, true)
		gohelper.setActive(slot0.vxGO2, true)
		TaskDispatcher.cancelTask(slot0.sendExchangeTicket, slot0)
		TaskDispatcher.runDelay(slot0.sendExchangeTicket, slot0, 1.5)
	end
end

function slot0.sendExchangeTicket(slot0)
	UIBlockMgr.instance:endBlock(slot0.viewName)
	TaskDispatcher.cancelTask(slot0.sendExchangeTicket, slot0)
	HeroStoryRpc.instance:sendExchangeTicketRequest()
end

function slot0.onDestroyView(slot0)
	UIBlockMgr.instance:endBlock(slot0.viewName)
	TaskDispatcher.cancelTask(slot0.sendExchangeTicket, slot0)
	slot0.simageCost:UnLoadImage()
end

return slot0
