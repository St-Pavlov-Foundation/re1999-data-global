module("modules.logic.seasonver.act123.view2_1.Season123_2_1EntryView", package.seeall)

slot0 = class("Season123_2_1EntryView", BaseView)

function slot0.onInitView(slot0)
	slot0._goentranceitem = gohelper.findChild(slot0.viewGO, "#go_entrance/#go_entrance_item")
	slot0._btnprev = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_entrance/#btn_prev")
	slot0._btnnext = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_entrance/#btn_next")
	slot0._btnstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "leftbtns/#go_store/#btn_store")
	slot0._txtstoreCoinNum = gohelper.findChildText(slot0.viewGO, "leftbtns/#go_store/#txt_num")
	slot0._btnstory = gohelper.findChildButtonWithAudio(slot0.viewGO, "rightbtns/#go_story/#btn_story")
	slot0._gostoryRedDot = gohelper.findChild(slot0.viewGO, "rightbtns/#go_story/#btn_story/#go_storyRedDot")
	slot0._btnequipBook = gohelper.findChildButtonWithAudio(slot0.viewGO, "rightbtns/#go_celebrity/#btn_celebrity")
	slot0._btnoverview = gohelper.findChildButtonWithAudio(slot0.viewGO, "leftbtns/#btn_overview")
	slot0._btnachievement = gohelper.findChildButtonWithAudio(slot0.viewGO, "rightbtns/#go_achievement/#btn_achievement")
	slot0._goachievementRedDot = gohelper.findChild(slot0.viewGO, "rightbtns/#go_achievement/#btn_achievement/#go_achievementRedDot")
	slot0._gocards = gohelper.findChild(slot0.viewGO, "rightbtns/#go_cards")
	slot0._btncards = gohelper.findChildButtonWithAudio(slot0.viewGO, "rightbtns/#go_cards/#btn_cards")
	slot0._gohasget = gohelper.findChild(slot0.viewGO, "rightbtns/#go_cards/#go_hasget")
	slot0._txtcardPackageNum = gohelper.findChildText(slot0.viewGO, "rightbtns/#go_cards/#go_hasget/#txt_num")
	slot0._txtpropnum = gohelper.findChildText(slot0.viewGO, "rightbtns/#go_retail/#go_currency/#txt_propnum")
	slot0._goretail = gohelper.findChild(slot0.viewGO, "rightbtns/#go_retail")
	slot0._btnretail = gohelper.findChildButtonWithAudio(slot0.viewGO, "rightbtns/#go_retail/#btn_retail")
	slot0._golight = gohelper.findChild(slot0.viewGO, "#go_entrance/light")
	slot0._goexcessive = gohelper.findChild(slot0.viewGO, "#go_excessive")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "#go_title/#txt_time")
	slot0._anim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0._animExcessive = slot0._goexcessive:GetComponent(gohelper.Type_Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnprev:AddClickListener(slot0._btnprevOnClick, slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
	slot0._btnstore:AddClickListener(slot0._btnStoreOnClick, slot0)
	slot0._btnstory:AddClickListener(slot0._btnStoryOnClick, slot0)
	slot0._btnequipBook:AddClickListener(slot0._btnEquipBookOnClick, slot0)
	slot0._btnoverview:AddClickListener(slot0._btnOverviewOnClick, slot0)
	slot0._btnachievement:AddClickListener(slot0._btnAchievementOnClick, slot0)
	slot0._btncards:AddClickListener(slot0._btnCardPackageOnClick, slot0)
	slot0._btnretail:AddClickListener(slot0._btnRetailOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnprev:RemoveClickListener()
	slot0._btnnext:RemoveClickListener()
	slot0._btnstore:RemoveClickListener()
	slot0._btnstory:RemoveClickListener()
	slot0._btnequipBook:RemoveClickListener()
	slot0._btnoverview:RemoveClickListener()
	slot0._btnachievement:RemoveClickListener()
	slot0._btncards:RemoveClickListener()
	slot0._btnretail:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._entryList = {}
	slot0._centerItem = nil
end

function slot0.onDestroyView(slot0)
	if slot0._centerItem then
		slot0._centerItem:dispose()

		slot0._centerItem = nil
	end

	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
	Season123EntryController.instance:onCloseView()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.season123_entryview_open)

	slot1 = slot0.viewParam.actId

	slot0:addEventCb(Season123Controller.instance, Season123Event.GetActInfo, slot0.handleGetActInfo, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.StageInfoChanged, slot0.refreshCenter, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.TaskUpdated, slot0.refreshCenter, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.StageFinishWithoutStory, slot0.handleStageFinishWithoutStory, slot0)
	slot0:addEventCb(Season123EntryController.instance, Season123Event.EntrySceneLoaded, slot0.handleSceneLoaded, slot0)
	slot0:addEventCb(Season123EntryController.instance, Season123Event.EntryStageChanged, slot0.refreshUI, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.refreshCardPackageUI, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.handleItemChanged, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.handleItemChanged, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.OtherViewAutoOpened, slot0.handleOtherViewAutoOpened, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseView, slot0)
	Season123EntryController.instance:onOpenView(slot1)

	if not ActivityModel.instance:getActMO(slot1) or not slot2:isOpen() or slot2:isExpired() then
		return
	end

	slot0:checkFirstOpenOverview()
	slot0:checkSceneLoaded()
	slot0:refreshUI()
	slot0:initRedDot()
	Season123Controller.instance:dispatchEvent(Season123Event.GuideEntryOtherViewPop)

	if slot0.viewParam.jumpId then
		Season123EntryController.instance:processJumpParam(slot0.viewParam)
	else
		Season123Controller.instance:dispatchEvent(Season123Event.GuideEntryOtherViewClose)
	end

	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, 1)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._switchStage, slot0)
	TaskDispatcher.cancelTask(slot0._enterRetailView, slot0)
	TaskDispatcher.cancelTask(slot0._endBlock, slot0)
	TaskDispatcher.cancelTask(slot0._autoClickNext, slot0)
end

function slot0.checkFirstOpenOverview(slot0)
	if Season123EntryModel.instance:isFirstOpen() then
		Season123Controller.instance:openSeasonOverview({
			actId = slot0.viewParam.actId
		})
		Season123EntryModel.instance:setAlreadyVisited(slot0.viewParam.actId)
	end
end

function slot0.checkSceneIsLoaded(slot0)
end

function slot0.refreshUI(slot0)
	if not ActivityModel.instance:getActMO(slot0.viewParam.actId) or not slot1:isOpen() or slot1:isExpired() then
		return
	end

	slot0:refreshCenter()
	slot0:refreshPageBtn()
	slot0:refreshCardPackageUI()
	slot0:refreshUTTURetailTicket()
	slot0:refreshStoreCoin()
	slot0:checkHasReadUnlockStory()
	slot0:refreshRemainTime()
end

function slot0.refreshCenter(slot0)
	if slot0._centerItem then
		slot0._centerItem:refreshUI()
	end

	slot1, slot2, slot3 = Season123ProgressUtils.isStageUnlock(slot0.viewParam.actId, Season123EntryModel.instance:getCurrentStage())

	gohelper.setActive(slot0._golight, slot1)
	slot0:checkHasReadUnlockStory()
end

function slot0.refreshPageBtn(slot0)
	if not Season123Config.instance:getStageCos(Season123EntryModel.instance.activityId) or #slot1 <= 1 then
		gohelper.setActive(slot0._btnprev, false)
		gohelper.setActive(slot0._btnnext, false)

		return
	end

	gohelper.setActive(slot0._btnprev, Season123EntryModel.instance:getCurrentStageIndex() > 1)
	gohelper.setActive(slot0._btnnext, slot2 < #slot1)
end

function slot0.refreshCardPackageUI(slot0)
	slot0._btncards.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = Season123CardPackageModel.instance:initPackageCount() == 0 and 0.5 or 1
	slot0._txtcardPackageNum.text = slot1

	gohelper.setActive(slot0._gohasget, slot1 > 0)
end

function slot0.refreshUTTURetailTicket(slot0)
	slot1 = Season123EntryModel.instance:isRetailOpen()

	gohelper.setActive(slot0._goretail, slot1)

	if slot1 then
		slot2, slot3 = Season123EntryModel.instance:getUTTUTicketNum()
		slot0._hasEnoughTicket = slot2 >= 1
		slot0._txtpropnum.text = slot2 == 0 and "<color=#CF4543>" .. slot2 .. "</color>/" .. slot3 or slot2 .. "/" .. slot3
	end
end

function slot0.refreshStoreCoin(slot0)
	slot0._txtstoreCoinNum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(Season123Config.instance:getSeasonConstNum(slot0.viewParam.actId, Activity123Enum.Const.StoreCoinId)) and slot2.quantity or 0)
end

function slot0.refreshRemainTime(slot0)
	slot1 = slot0.viewParam.actId

	if not ActivityModel.instance:getActMO(slot0.viewParam.actId) then
		return
	end

	if slot2:getRealEndTimeStamp() - ServerTime.now() > 0 then
		slot0._txttime.text = TimeUtil.SecondToActivityTimeFormat(slot3)
	else
		slot0._txttime.text = luaLang("ended")
	end
end

function slot0.handleGetActInfo(slot0, slot1)
	if slot0.viewParam.actId == slot1 then
		slot0:refreshUI()
	end
end

function slot0.handleOtherViewAutoOpened(slot0)
	slot0._anim:Play(uv0.Anim.Close)
end

function slot0.handleItemChanged(slot0)
	slot0:refreshUTTURetailTicket()
	slot0:refreshStoreCoin()
end

function slot0.handleSceneLoaded(slot0)
	slot0:checkSceneLoaded()
end

function slot0.handleStageFinishWithoutStory(slot0)
	if slot0._anim then
		slot0._anim:Play(uv0.Anim.Switch, 0, 0)
	end
end

function slot0.checkSceneLoaded(slot0)
	if slot0._isCenterInited then
		return
	end

	if gohelper.findChild(CameraMgr.instance:getSceneRoot(), "Season123_2_1EntryScene/scene") then
		gohelper.setActive(slot0._goentranceitem, true)

		slot0._centerItem = Season123_2_1EntryItem.New()

		slot0._centerItem:init(slot0._goentranceitem, slot0._anim)
		slot0._centerItem:initData(slot0.viewParam.actId)

		slot0._isCenterInited = true
	end
end

function slot0._btnprevOnClick(slot0)
	UIBlockMgrExtend.instance:setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("switchStage")
	slot0._animExcessive:Play(uv0.Anim.Hard)
	AudioMgr.instance:trigger(AudioEnum.UI.season123_stage_switch)

	slot0.isNext = false

	TaskDispatcher.runDelay(slot0._switchStage, slot0, 0.5)
	TaskDispatcher.runDelay(slot0._endBlock, slot0, 1)
end

function slot0._btnnextOnClick(slot0)
	UIBlockMgrExtend.instance:setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("switchStage")
	slot0._animExcessive:Play(uv0.Anim.Story)
	AudioMgr.instance:trigger(AudioEnum.UI.season123_stage_switch)

	slot0.isNext = true

	TaskDispatcher.runDelay(slot0._switchStage, slot0, 0.5)
	TaskDispatcher.runDelay(slot0._endBlock, slot0, 1)
end

function slot0._btnStoreOnClick(slot0)
	Season123Controller.instance:openSeasonStoreView(slot0.viewParam.actId)
end

function slot0._btnStoryOnClick(slot0)
	Season123Controller.instance:openSeasonStoryView({
		actId = slot0.viewParam.actId
	})
end

function slot0._btnEquipBookOnClick(slot0)
	Season123Controller.instance:openSeasonEquipBookView(slot0.viewParam.actId)
end

function slot0._btnOverviewOnClick(slot0)
	Season123Controller.instance:openSeasonOverview({
		actId = slot0.viewParam.actId
	})
end

function slot0._btnAchievementOnClick(slot0)
	Season123Controller.instance:openSeasonTaskView({
		actId = slot0.viewParam.actId
	})
end

function slot0._btnCardPackageOnClick(slot0)
	Season123Controller.instance:openSeasonCardPackageView({
		actId = slot0.viewParam.actId
	})
end

function slot0._btnRetailOnClick(slot0)
	if not slot0._isCenterInited then
		return
	end

	slot0._anim:Play(uv0.Anim.Close)
	TaskDispatcher.runDelay(slot0._enterRetailView, slot0, 0.17)
end

function slot0._enterRetailView(slot0)
	Season123Controller.instance:openSeasonRetail({
		actId = slot0.viewParam.actId
	})
end

function slot0._btnTrialOnClick(slot0)
	Season123EntryController.instance:enterTrailFightScene()
end

function slot0.onCloseView(slot0, slot1)
	if slot1 == ViewName.Season123_2_1EpisodeListView then
		slot0._anim:Play(uv0.Anim.Switch1, 0, 0)
	end

	if slot1 == ViewName.Season123_2_1RetailView then
		slot0._anim:Play(uv0.Anim.Switch, 0, 0)
	end

	if slot1 == ViewName.Season123_2_1StoryPagePopView then
		slot0._anim:Play(uv0.Anim.Switch, 0, 0)
		TaskDispatcher.runDelay(slot0._autoClickNext, slot0, 0.5)
	end
end

function slot0._switchStage(slot0)
	Season123EntryController.instance:switchStage(slot0.isNext)

	slot0.isNext = nil
end

function slot0._endBlock(slot0)
	UIBlockMgr.instance:endBlock("switchStage")
	UIBlockMgrExtend.instance:setNeedCircleMv(true)
end

function slot0.initRedDot(slot0)
	slot1 = {}

	for slot5 = 1, 6 do
		table.insert(slot1, {
			id = RedDotEnum.DotNode.Season123StageReward,
			uid = slot5
		})
	end

	table.insert(slot1, {
		id = RedDotEnum.DotNode.Season123Task
	})
	RedDotController.instance:addMultiRedDot(slot0._goachievementRedDot, slot1)
	RedDotController.instance:addRedDot(slot0._gostoryRedDot, RedDotEnum.DotNode.Season123Story)
end

function slot0.checkHasReadUnlockStory(slot0)
	Season123Controller.instance:checkHasReadUnlockStory(slot0.viewParam.actId)
end

function slot0._autoClickNext(slot0)
	if Season123Model.instance:getActInfo(slot0.viewParam.actId) and slot1:getCurrentStage() and not Season123Config.instance:isLastStage(slot0.viewParam.actId, slot2.stage) then
		slot0:_btnnextOnClick()
	end
end

slot0.Anim = {
	Story = "story",
	Close = "close",
	Switch1 = "switch1",
	Switch = "swicth",
	Hard = "hard"
}

return slot0
