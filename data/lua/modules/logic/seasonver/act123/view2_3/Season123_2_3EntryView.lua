module("modules.logic.seasonver.act123.view2_3.Season123_2_3EntryView", package.seeall)

local var_0_0 = class("Season123_2_3EntryView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goentranceitem = gohelper.findChild(arg_1_0.viewGO, "#go_entrance/#go_entrance_item")
	arg_1_0._btnprev = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_entrance/#btn_prev")
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_entrance/#btn_next")
	arg_1_0._btnstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "leftbtns/#go_store/#btn_store")
	arg_1_0._txtstoreCoinNum = gohelper.findChildText(arg_1_0.viewGO, "leftbtns/#go_store/#txt_num")
	arg_1_0._btnstory = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rightbtns/#go_story/#btn_story")
	arg_1_0._gostoryRedDot = gohelper.findChild(arg_1_0.viewGO, "rightbtns/#go_story/#btn_story/#go_storyRedDot")
	arg_1_0._btnequipBook = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rightbtns/#go_celebrity/#btn_celebrity")
	arg_1_0._btnoverview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "leftbtns/#btn_overview")
	arg_1_0._btnachievement = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rightbtns/#go_achievement/#btn_achievement")
	arg_1_0._goachievementRedDot = gohelper.findChild(arg_1_0.viewGO, "rightbtns/#go_achievement/#btn_achievement/#go_achievementRedDot")
	arg_1_0._gocards = gohelper.findChild(arg_1_0.viewGO, "rightbtns/#go_cards")
	arg_1_0._btncards = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rightbtns/#go_cards/#btn_cards")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.viewGO, "rightbtns/#go_cards/#go_hasget")
	arg_1_0._txtcardPackageNum = gohelper.findChildText(arg_1_0.viewGO, "rightbtns/#go_cards/#go_hasget/#txt_num")
	arg_1_0._txtpropnum = gohelper.findChildText(arg_1_0.viewGO, "rightbtns/#go_retail/#go_currency/#txt_propnum")
	arg_1_0._goretail = gohelper.findChild(arg_1_0.viewGO, "rightbtns/#go_retail")
	arg_1_0._btnretail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rightbtns/#go_retail/#btn_retail")
	arg_1_0._golight = gohelper.findChild(arg_1_0.viewGO, "#go_entrance/light")
	arg_1_0._goexcessive = gohelper.findChild(arg_1_0.viewGO, "#go_excessive")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "#go_title/#txt_time")
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0._animExcessive = arg_1_0._goexcessive:GetComponent(gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnprev:AddClickListener(arg_2_0._btnprevOnClick, arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
	arg_2_0._btnstore:AddClickListener(arg_2_0._btnStoreOnClick, arg_2_0)
	arg_2_0._btnstory:AddClickListener(arg_2_0._btnStoryOnClick, arg_2_0)
	arg_2_0._btnequipBook:AddClickListener(arg_2_0._btnEquipBookOnClick, arg_2_0)
	arg_2_0._btnoverview:AddClickListener(arg_2_0._btnOverviewOnClick, arg_2_0)
	arg_2_0._btnachievement:AddClickListener(arg_2_0._btnAchievementOnClick, arg_2_0)
	arg_2_0._btncards:AddClickListener(arg_2_0._btnCardPackageOnClick, arg_2_0)
	arg_2_0._btnretail:AddClickListener(arg_2_0._btnRetailOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnprev:RemoveClickListener()
	arg_3_0._btnnext:RemoveClickListener()
	arg_3_0._btnstore:RemoveClickListener()
	arg_3_0._btnstory:RemoveClickListener()
	arg_3_0._btnequipBook:RemoveClickListener()
	arg_3_0._btnoverview:RemoveClickListener()
	arg_3_0._btnachievement:RemoveClickListener()
	arg_3_0._btncards:RemoveClickListener()
	arg_3_0._btnretail:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._entryList = {}
	arg_4_0._centerItem = nil
end

function var_0_0.onDestroyView(arg_5_0)
	if arg_5_0._centerItem then
		arg_5_0._centerItem:dispose()

		arg_5_0._centerItem = nil
	end

	TaskDispatcher.cancelTask(arg_5_0.refreshRemainTime, arg_5_0)
	Season123EntryController.instance:onCloseView()
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.season123_entryview_open)

	local var_6_0 = arg_6_0.viewParam.actId

	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.GetActInfo, arg_6_0.handleGetActInfo, arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.StageInfoChanged, arg_6_0.refreshCenter, arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.TaskUpdated, arg_6_0.refreshCenter, arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.StageFinishWithoutStory, arg_6_0.handleStageFinishWithoutStory, arg_6_0)
	arg_6_0:addEventCb(Season123EntryController.instance, Season123Event.EntrySceneLoaded, arg_6_0.handleSceneLoaded, arg_6_0)
	arg_6_0:addEventCb(Season123EntryController.instance, Season123Event.EntryStageChanged, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_6_0.refreshCardPackageUI, arg_6_0)
	arg_6_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_6_0.handleItemChanged, arg_6_0)
	arg_6_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_6_0.handleItemChanged, arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.OtherViewAutoOpened, arg_6_0.handleOtherViewAutoOpened, arg_6_0)
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_6_0.onCloseView, arg_6_0)
	Season123EntryController.instance:onOpenView(var_6_0)

	local var_6_1 = ActivityModel.instance:getActMO(var_6_0)

	if not var_6_1 or not var_6_1:isOpen() or var_6_1:isExpired() then
		return
	end

	arg_6_0:checkFirstOpenOverview()
	arg_6_0:checkSceneLoaded()
	arg_6_0:refreshUI()
	arg_6_0:initRedDot()
	Season123Controller.instance:dispatchEvent(Season123Event.GuideEntryOtherViewPop)

	if arg_6_0.viewParam.jumpId then
		Season123EntryController.instance:processJumpParam(arg_6_0.viewParam)
	else
		Season123Controller.instance:dispatchEvent(Season123Event.GuideEntryOtherViewClose)
	end

	TaskDispatcher.runRepeat(arg_6_0.refreshRemainTime, arg_6_0, 1)
end

function var_0_0.onClose(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._switchStage, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._enterRetailView, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._endBlock, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._autoClickNext, arg_7_0)
end

function var_0_0.checkFirstOpenOverview(arg_8_0)
	if Season123EntryModel.instance:isFirstOpen() then
		Season123Controller.instance:openSeasonOverview({
			actId = arg_8_0.viewParam.actId
		})
		Season123EntryModel.instance:setAlreadyVisited(arg_8_0.viewParam.actId)
	end
end

function var_0_0.checkSceneIsLoaded(arg_9_0)
	return
end

function var_0_0.refreshUI(arg_10_0)
	local var_10_0 = ActivityModel.instance:getActMO(arg_10_0.viewParam.actId)

	if not var_10_0 or not var_10_0:isOpen() or var_10_0:isExpired() then
		return
	end

	arg_10_0:refreshCenter()
	arg_10_0:refreshPageBtn()
	arg_10_0:refreshCardPackageUI()
	arg_10_0:refreshUTTURetailTicket()
	arg_10_0:refreshStoreCoin()
	arg_10_0:checkHasReadUnlockStory()
	arg_10_0:refreshRemainTime()
end

function var_0_0.refreshCenter(arg_11_0)
	if arg_11_0._centerItem then
		arg_11_0._centerItem:refreshUI()
	end

	local var_11_0, var_11_1, var_11_2 = Season123ProgressUtils.isStageUnlock(arg_11_0.viewParam.actId, Season123EntryModel.instance:getCurrentStage())

	gohelper.setActive(arg_11_0._golight, var_11_0)
	arg_11_0:checkHasReadUnlockStory()
end

function var_0_0.refreshPageBtn(arg_12_0)
	local var_12_0 = Season123Config.instance:getStageCos(Season123EntryModel.instance.activityId)

	if not var_12_0 or #var_12_0 <= 1 then
		gohelper.setActive(arg_12_0._btnprev, false)
		gohelper.setActive(arg_12_0._btnnext, false)

		return
	end

	local var_12_1 = Season123EntryModel.instance:getCurrentStageIndex()

	gohelper.setActive(arg_12_0._btnprev, var_12_1 > 1)
	gohelper.setActive(arg_12_0._btnnext, var_12_1 < #var_12_0)
end

function var_0_0.refreshCardPackageUI(arg_13_0)
	local var_13_0 = Season123CardPackageModel.instance:initPackageCount()

	arg_13_0._btncards.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = var_13_0 == 0 and 0.5 or 1
	arg_13_0._txtcardPackageNum.text = var_13_0

	gohelper.setActive(arg_13_0._gohasget, var_13_0 > 0)
end

function var_0_0.refreshUTTURetailTicket(arg_14_0)
	local var_14_0 = Season123EntryModel.instance:isRetailOpen()

	gohelper.setActive(arg_14_0._goretail, var_14_0)

	if var_14_0 then
		local var_14_1, var_14_2 = Season123EntryModel.instance:getUTTUTicketNum()

		arg_14_0._hasEnoughTicket = var_14_1 >= 1

		local var_14_3 = var_14_1 == 0 and "<color=#CF4543>" .. var_14_1 .. "</color>/" .. var_14_2 or var_14_1 .. "/" .. var_14_2

		arg_14_0._txtpropnum.text = var_14_3
	end
end

function var_0_0.refreshStoreCoin(arg_15_0)
	local var_15_0 = Season123Config.instance:getSeasonConstNum(arg_15_0.viewParam.actId, Activity123Enum.Const.StoreCoinId)
	local var_15_1 = CurrencyModel.instance:getCurrency(var_15_0)
	local var_15_2 = var_15_1 and var_15_1.quantity or 0

	arg_15_0._txtstoreCoinNum.text = GameUtil.numberDisplay(var_15_2)
end

function var_0_0.refreshRemainTime(arg_16_0)
	local var_16_0 = arg_16_0.viewParam.actId
	local var_16_1 = ActivityModel.instance:getActMO(arg_16_0.viewParam.actId)

	if not var_16_1 then
		return
	end

	local var_16_2 = var_16_1:getRealEndTimeStamp() - ServerTime.now()

	if var_16_2 > 0 then
		local var_16_3 = TimeUtil.SecondToActivityTimeFormat(var_16_2)

		arg_16_0._txttime.text = var_16_3
	else
		arg_16_0._txttime.text = luaLang("ended")
	end
end

function var_0_0.handleGetActInfo(arg_17_0, arg_17_1)
	if arg_17_0.viewParam.actId == arg_17_1 then
		arg_17_0:refreshUI()
	end
end

function var_0_0.handleOtherViewAutoOpened(arg_18_0)
	arg_18_0._anim:Play(var_0_0.Anim.Close)
end

function var_0_0.handleItemChanged(arg_19_0)
	arg_19_0:refreshUTTURetailTicket()
	arg_19_0:refreshStoreCoin()
end

function var_0_0.handleSceneLoaded(arg_20_0)
	arg_20_0:checkSceneLoaded()
end

function var_0_0.handleStageFinishWithoutStory(arg_21_0)
	if arg_21_0._anim then
		arg_21_0._anim:Play(var_0_0.Anim.Switch, 0, 0)
	end
end

function var_0_0.checkSceneLoaded(arg_22_0)
	if arg_22_0._isCenterInited then
		return
	end

	local var_22_0 = CameraMgr.instance:getSceneRoot()

	if gohelper.findChild(var_22_0, "Season123_2_3EntryScene/scene") then
		gohelper.setActive(arg_22_0._goentranceitem, true)

		arg_22_0._centerItem = Season123_2_3EntryItem.New()

		arg_22_0._centerItem:init(arg_22_0._goentranceitem, arg_22_0._anim)
		arg_22_0._centerItem:initData(arg_22_0.viewParam.actId)

		arg_22_0._isCenterInited = true
	end
end

function var_0_0._btnprevOnClick(arg_23_0)
	UIBlockMgrExtend.instance:setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("switchStage")
	arg_23_0._animExcessive:Play(var_0_0.Anim.Hard)
	AudioMgr.instance:trigger(AudioEnum.UI.season123_stage_switch)

	arg_23_0.isNext = false

	TaskDispatcher.runDelay(arg_23_0._switchStage, arg_23_0, 0.5)
	TaskDispatcher.runDelay(arg_23_0._endBlock, arg_23_0, 1)
end

function var_0_0._btnnextOnClick(arg_24_0)
	UIBlockMgrExtend.instance:setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("switchStage")
	arg_24_0._animExcessive:Play(var_0_0.Anim.Story)
	AudioMgr.instance:trigger(AudioEnum.UI.season123_stage_switch)

	arg_24_0.isNext = true

	TaskDispatcher.runDelay(arg_24_0._switchStage, arg_24_0, 0.5)
	TaskDispatcher.runDelay(arg_24_0._endBlock, arg_24_0, 1)
end

function var_0_0._btnStoreOnClick(arg_25_0)
	Season123Controller.instance:openSeasonStoreView(arg_25_0.viewParam.actId)
end

function var_0_0._btnStoryOnClick(arg_26_0)
	Season123Controller.instance:openSeasonStoryView({
		actId = arg_26_0.viewParam.actId
	})
end

function var_0_0._btnEquipBookOnClick(arg_27_0)
	Season123Controller.instance:openSeasonEquipBookView(arg_27_0.viewParam.actId)
end

function var_0_0._btnOverviewOnClick(arg_28_0)
	Season123Controller.instance:openSeasonOverview({
		actId = arg_28_0.viewParam.actId
	})
end

function var_0_0._btnAchievementOnClick(arg_29_0)
	Season123Controller.instance:openSeasonTaskView({
		actId = arg_29_0.viewParam.actId
	})
end

function var_0_0._btnCardPackageOnClick(arg_30_0)
	Season123Controller.instance:openSeasonCardPackageView({
		actId = arg_30_0.viewParam.actId
	})
end

function var_0_0._btnRetailOnClick(arg_31_0)
	if not arg_31_0._isCenterInited then
		return
	end

	arg_31_0._anim:Play(var_0_0.Anim.Close)
	TaskDispatcher.runDelay(arg_31_0._enterRetailView, arg_31_0, 0.17)
end

function var_0_0._enterRetailView(arg_32_0)
	Season123Controller.instance:openSeasonRetail({
		actId = arg_32_0.viewParam.actId
	})
end

function var_0_0._btnTrialOnClick(arg_33_0)
	Season123EntryController.instance:enterTrailFightScene()
end

function var_0_0.onCloseView(arg_34_0, arg_34_1)
	if arg_34_1 == ViewName.Season123_2_3EpisodeListView then
		arg_34_0._anim:Play(var_0_0.Anim.Switch1, 0, 0)
	end

	if arg_34_1 == ViewName.Season123_2_3RetailView then
		arg_34_0._anim:Play(var_0_0.Anim.Switch, 0, 0)
	end

	if arg_34_1 == ViewName.Season123_2_3StoryPagePopView then
		arg_34_0._anim:Play(var_0_0.Anim.Switch, 0, 0)
		TaskDispatcher.runDelay(arg_34_0._autoClickNext, arg_34_0, 0.5)
	end
end

function var_0_0._switchStage(arg_35_0)
	Season123EntryController.instance:switchStage(arg_35_0.isNext)

	arg_35_0.isNext = nil
end

function var_0_0._endBlock(arg_36_0)
	UIBlockMgr.instance:endBlock("switchStage")
	UIBlockMgrExtend.instance:setNeedCircleMv(true)
end

function var_0_0.initRedDot(arg_37_0)
	local var_37_0 = {}

	for iter_37_0 = 1, 6 do
		table.insert(var_37_0, {
			id = RedDotEnum.DotNode.Season123StageReward,
			uid = iter_37_0
		})
	end

	table.insert(var_37_0, {
		id = RedDotEnum.DotNode.Season123Task
	})
	RedDotController.instance:addMultiRedDot(arg_37_0._goachievementRedDot, var_37_0)
	RedDotController.instance:addRedDot(arg_37_0._gostoryRedDot, RedDotEnum.DotNode.Season123Story)
end

function var_0_0.checkHasReadUnlockStory(arg_38_0)
	Season123Controller.instance:checkHasReadUnlockStory(arg_38_0.viewParam.actId)
end

function var_0_0._autoClickNext(arg_39_0)
	local var_39_0 = Season123Model.instance:getActInfo(arg_39_0.viewParam.actId)

	if var_39_0 then
		local var_39_1 = var_39_0:getCurrentStage()

		if var_39_1 and not Season123Config.instance:isLastStage(arg_39_0.viewParam.actId, var_39_1.stage) then
			arg_39_0:_btnnextOnClick()
		end
	end
end

var_0_0.Anim = {
	Story = "story",
	Close = "close",
	Switch1 = "switch1",
	Switch = "swicth",
	Hard = "hard"
}

return var_0_0
