module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchMainView", package.seeall)

slot0 = class("RoleStoryDispatchMainView", BaseView)

function slot0.onInitView(slot0)
	slot0.txtTitle = gohelper.findChildTextMesh(slot0.viewGO, "Right/Title/#txt_Title")
	slot0.txtTitleen = gohelper.findChildTextMesh(slot0.viewGO, "Right/Title/#txt_Titleen")
	slot0.txtTime = gohelper.findChildTextMesh(slot0.viewGO, "Right/#txt_LimitTime")
	slot0.btnProgress = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_progress")
	slot0.slider = gohelper.findChildImage(slot0.viewGO, "Right/#go_progress/Background")
	slot0.txtProgress = gohelper.findChildTextMesh(slot0.viewGO, "Right/#go_progress/#txt_schedule")
	slot0.imgaePower = gohelper.findChildImage(slot0.viewGO, "Right/#go_progress/#icon1")
	slot0.simageCost = gohelper.findChildSingleImage(slot0.viewGO, "Right/#go_progress/#icon2")
	slot0.goTips = gohelper.findChild(slot0.viewGO, "Right/#go_progress/#go_ruletipdetail")
	slot0.btnTips = gohelper.findChildButtonWithAudio(slot0.goTips, "#btn_closeruletip")
	slot0.txtTips = gohelper.findChildTextMesh(slot0.goTips, "#go_rule2/rule2")
	slot0.vxGO1 = gohelper.findChild(slot0.viewGO, "#go_topright/vx_collect")
	slot0.vxGO2 = gohelper.findChild(slot0.viewGO, "Right/#go_progress/vx_collect")
	slot0.btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Enter")
	slot0.goEnterRed = gohelper.findChild(slot0.viewGO, "Right/#btn_Enter/#image_reddot")

	RedDotController.instance:addRedDot(slot0.goEnterRed, RedDotEnum.DotNode.RoleStoryDispatch)

	slot0.btnScore = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_scorereward")
	slot0.txtScore = gohelper.findChildTextMesh(slot0.viewGO, "Right/#btn_scorereward/score/#txt_score")
	slot0.scoreAnim = gohelper.findChildComponent(slot0.viewGO, "Right/#btn_scorereward/ani", typeof(UnityEngine.Animator))
	slot0.goScoreRed = gohelper.findChild(slot0.viewGO, "Right/#btn_scorereward/#go_rewardredpoint")
	slot0.btnRead = gohelper.findChildButtonWithAudio(slot0.viewGO, "Middle/#btn_read")
	slot0.itemPos = gohelper.findChild(slot0.viewGO, "Middle/#go_rolestoryitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnProgress, slot0.onClickBtnProgress, slot0)
	slot0:addClickCb(slot0.btnTips, slot0.onClickBtnTips, slot0)
	slot0:addClickCb(slot0.btnEnter, slot0.onClickBtnEnter, slot0)
	slot0:addClickCb(slot0.btnScore, slot0.onClickBtnScore, slot0)
	slot0:addClickCb(slot0.btnRead, slot0.onClickBtnRead, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ActStoryChange, slot0._onStoryChange, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ScoreUpdate, slot0._onScoreUpdate, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.GetScoreBonus, slot0._onScoreUpdate, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.UpdateInfo, slot0._onUpdateInfo, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ExchangeTick, slot0._onExchangeTick, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.PowerChange, slot0._onPowerChange, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onClickBtnProgress(slot0)
	gohelper.setActive(slot0.goTips, true)

	slot0.txtTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rolestoryactivitytips"), {
		CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost),
		CommonConfig.instance:getConstNum(ConstEnum.RoleStoryDayChangeNum)
	})
end

function slot0.onClickBtnTips(slot0)
	gohelper.setActive(slot0.goTips, false)
end

function slot0.onClickBtnEnter(slot0)
	RoleStoryController.instance:openDispatchView(RoleStoryModel.instance:getCurActStoryId())
end

function slot0.onClickBtnScore(slot0)
	ViewMgr.instance:openView(ViewName.RoleStoryRewardView)
end

function slot0.onClickBtnRead(slot0)
	if not RoleStoryModel.instance:getById(RoleStoryModel.instance:getCurActStoryId()) then
		return
	end

	if slot2.hasUnlock then
		RoleStoryController.instance:enterRoleStoryChapter(slot1)
	end
end

function slot0._onStoryChange(slot0)
	HeroStoryRpc.instance:sendGetHeroStoryRequest()
end

function slot0._onScoreUpdate(slot0)
	slot0:refreshScore()
end

function slot0._onUpdateInfo(slot0)
	slot0:refreshScore()
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0:refreshProgress()
	slot0:refreshScore()
	slot0:refreshView()

	if slot0.viewParam and slot0.viewParam.clickItem and slot0.roleItem then
		slot0.roleItem:onClickItem()
	end
end

function slot0.onUpdateParam(slot0)
	slot0:refreshProgress()
	slot0:refreshScore()
	slot0:refreshView()
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

function slot0.refreshView(slot0)
	slot0:refreshRoleItem()
	slot0:refreshLeftTime()
	slot0:refreshTitle()
	TaskDispatcher.cancelTask(slot0.refreshLeftTime, slot0)
	TaskDispatcher.runRepeat(slot0.refreshLeftTime, slot0, 1)
	slot0:checkEnterActivity()
end

function slot0.refreshTitle(slot0)
	if not RoleStoryModel.instance:getById(RoleStoryModel.instance:getCurActStoryId()) then
		return
	end

	slot3 = slot2.cfg.name
	slot5 = GameUtil.utf8sub(slot3, 1, 1)
	slot6 = ""
	slot7 = ""

	if GameUtil.utf8len(slot3) > 1 then
		slot6 = GameUtil.utf8sub(slot3, 2, 2)
	end

	if slot4 > 3 then
		slot7 = GameUtil.utf8sub(slot3, 4, slot4 - 3)
	end

	slot0.txtTitle.text = string.format("<size=100>%s</size>%s%s", slot5, slot6, slot7)
	slot0.txtTitleen.text = slot2.cfg.nameEn
end

function slot0.refreshRoleItem(slot0)
	if not slot0.roleItem then
		slot1 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes.itemRes, slot0.itemPos)
		slot0.roleItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot1, RoleStoryItem)

		slot0.roleItem:initInternal(slot1, slot0)
	end

	slot2 = RoleStoryModel.instance:getById(RoleStoryModel.instance:getCurActStoryId())

	slot0.roleItem:onUpdateMO(slot2)
	gohelper.setActive(slot0.btnRead, slot2 and slot2.hasUnlock)
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

function slot0._onExchangeTick(slot0)
	slot0:refreshProgress()
end

function slot0._onPowerChange(slot0)
	slot0:refreshProgress()
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

function slot0.refreshLeftTime(slot0)
	if not RoleStoryModel.instance:getById(RoleStoryModel.instance:getCurActStoryId()) then
		return
	end

	slot3, slot4 = slot2:getActTime()

	if slot4 - ServerTime.now() > 0 then
		slot6, slot7, slot8, slot9 = TimeUtil.secondsToDDHHMMSS(slot5)
		slot10 = nil

		if slot6 > 0 then
			slot10 = GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
				string.format("<color=#f09a5a>%s</color>", slot6),
				string.format("<color=#f09a5a>%s</color>", slot7)
			})
		elseif slot7 > 0 then
			slot10 = GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
				string.format("<color=#f09a5a>%s</color>", slot7),
				string.format("<color=#f09a5a>%s</color>", slot8)
			})
		elseif slot8 > 0 then
			slot10 = GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
				string.format("<color=#f09a5a>%s</color>", 0),
				string.format("<color=#f09a5a>%s</color>", slot8)
			})
		elseif slot9 > 0 then
			slot10 = GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
				string.format("<color=#f09a5a>%s</color>", 0),
				string.format("<color=#f09a5a>%s</color>", 1)
			})
		end

		slot0.txtTime.text = formatLuaLang("summonmainequipprobup_deadline", slot10)
	else
		TaskDispatcher.cancelTask(slot0.refreshLeftTime, slot0)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.refreshLeftTime, slot0)
end

return slot0
