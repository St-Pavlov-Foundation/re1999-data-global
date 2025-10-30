module("modules.logic.season.view3_0.Season3_0MainView", package.seeall)

local var_0_0 = class("Season3_0MainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goreadprocess = gohelper.findChild(arg_1_0.viewGO, "leftbtns/#go_readprocess")
	arg_1_0._txtNum = gohelper.findChildTextMesh(arg_1_0.viewGO, "leftbtns/#go_readprocess/#btn_Store/#txt_Num")
	arg_1_0._btnreadprocess = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "leftbtns/#go_readprocess/#btn_readprocess")
	arg_1_0._gotask = gohelper.findChild(arg_1_0.viewGO, "leftbtns/#go_task")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "leftbtns/#go_task/#btn_task")
	arg_1_0._gotaskreddot = gohelper.findChild(arg_1_0.viewGO, "leftbtns/#go_task/#go_taskreddot")
	arg_1_0._gocelebrity = gohelper.findChild(arg_1_0.viewGO, "rightbtns/#go_celebrity")
	arg_1_0._btncelebrity = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rightbtns/#go_celebrity/#btn_celebrity")
	arg_1_0._goretail = gohelper.findChild(arg_1_0.viewGO, "rightbtns/#go_retail")
	arg_1_0._gocurrency = gohelper.findChild(arg_1_0.viewGO, "rightbtns/#go_retail/#go_currency")
	arg_1_0._imagecurrencyicon = gohelper.findChildImage(arg_1_0.viewGO, "rightbtns/#go_retail/#go_currency/#image_currencyicon")
	arg_1_0._btncurrencyicon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rightbtns/#go_retail/#go_currency/#image_currencyicon")
	arg_1_0._txtcurrencycount = gohelper.findChildText(arg_1_0.viewGO, "rightbtns/#go_retail/#go_currency/#txt_currencycount")
	arg_1_0._btnretail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rightbtns/#go_retail/#btn_retail")
	arg_1_0._goassemblying = gohelper.findChild(arg_1_0.viewGO, "rightbtns/#go_retail/#go_assemblying")
	arg_1_0._gotitle = gohelper.findChild(arg_1_0.viewGO, "#go_title")
	arg_1_0._txtunlocktime = gohelper.findChildText(arg_1_0.viewGO, "#go_title/txt_unlocktime")
	arg_1_0._goentrance = gohelper.findChild(arg_1_0.viewGO, "#go_entrance")
	arg_1_0._gotop = gohelper.findChild(arg_1_0.viewGO, "#go_entrance/#go_top")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.viewGO, "#go_entrance/#txt_index")
	arg_1_0._txtmapname = gohelper.findChildText(arg_1_0.viewGO, "#go_entrance/#txt_mapname")
	arg_1_0._btnentrance = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_entrance/#btn_entrance", AudioEnum.UI.play_ui_leimi_biguncharted_open)
	arg_1_0._godiscount = gohelper.findChild(arg_1_0.viewGO, "#go_discount")
	arg_1_0._gonewdiscount = gohelper.findChild(arg_1_0.viewGO, "#go_discount/#go_new")
	arg_1_0._btndiscount = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_discount/#btn_discount")
	arg_1_0._godiscountlock = gohelper.findChild(arg_1_0.viewGO, "#go_discount_lock")
	arg_1_0._txtdiscountunlock = gohelper.findChildText(arg_1_0.viewGO, "#go_discount_lock/#txt_discountunlock")
	arg_1_0._btndiscountlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_discount_lock/#btn_discountlock")
	arg_1_0._goMask = gohelper.findChild(arg_1_0.viewGO, "#go_mask")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#go_entrance/decorates/#go_arrow")
	arg_1_0._animationEvent = arg_1_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	arg_1_0._goEnterEffect = gohelper.findChild(arg_1_0.viewGO, "eff")

	RedDotController.instance:addRedDot(arg_1_0._gotaskreddot, RedDotEnum.DotNode.SeasonTaskLevel)

	arg_1_0._goletter = gohelper.findChild(arg_1_0.viewGO, "#go_letter")
	arg_1_0._btnletter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_letter/#btn_try")
	arg_1_0._gotry = gohelper.findChild(arg_1_0.viewGO, "#go_try")
	arg_1_0._trialTxtNameen = gohelper.findChildTextMesh(arg_1_0._gotry, "#txt_characteren")
	arg_1_0._trialTxtNamecn = gohelper.findChildTextMesh(arg_1_0._gotry, "#txt_charactercn")
	arg_1_0._btntrial = gohelper.findChildButtonWithAudio(arg_1_0._gotry, "#btn_try")
	arg_1_0._trialCardGo = gohelper.findChild(arg_1_0._gotry, "#go_card")
	arg_1_0._btnstory = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_story/#btn_story")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreadprocess:AddClickListener(arg_2_0._btnreadprocessOnClick, arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btncelebrity:AddClickListener(arg_2_0._btncelebrityOnClick, arg_2_0)
	arg_2_0._btnretail:AddClickListener(arg_2_0._btnretailOnClick, arg_2_0)
	arg_2_0._btnentrance:AddClickListener(arg_2_0._btnentranceOnClick, arg_2_0)
	arg_2_0._btndiscount:AddClickListener(arg_2_0._btndiscountOnClick, arg_2_0)
	arg_2_0._btndiscountlock:AddClickListener(arg_2_0._btndiscountlockOnClick, arg_2_0)
	arg_2_0._btncurrencyicon:AddClickListener(arg_2_0._btncurrencyiconOnClick, arg_2_0)
	arg_2_0._btnletter:AddClickListener(arg_2_0._btnletterOnClick, arg_2_0)
	arg_2_0._btntrial:AddClickListener(arg_2_0._btntrialOnClick, arg_2_0)
	arg_2_0._btnstory:AddClickListener(arg_2_0._btnStoryOnClick, arg_2_0)
	arg_2_0._animationEvent:AddEventListener("levelup", arg_2_0.onLevelUp, arg_2_0)
	arg_2_0:addEventCb(Activity104Controller.instance, Activity104Event.RefreshRetail, arg_2_0._onRefreshRetail, arg_2_0)
	arg_2_0:addEventCb(GuideController.instance, GuideEvent.SeasonShowUTTU, arg_2_0._showUTTU, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._onChangeRetail, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0.refreshCurrency, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreadprocess:RemoveClickListener()
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btncelebrity:RemoveClickListener()
	arg_3_0._btnretail:RemoveClickListener()
	arg_3_0._btnentrance:RemoveClickListener()
	arg_3_0._btndiscount:RemoveClickListener()
	arg_3_0._btndiscountlock:RemoveClickListener()
	arg_3_0._btncurrencyicon:RemoveClickListener()
	arg_3_0._btnletter:RemoveClickListener()
	arg_3_0._btntrial:RemoveClickListener()
	arg_3_0._btnstory:RemoveClickListener()
	arg_3_0._animationEvent:RemoveEventListener("levelup")
	arg_3_0:removeEventCb(Activity104Controller.instance, Activity104Event.RefreshRetail, arg_3_0._onRefreshRetail, arg_3_0)
	arg_3_0:removeEventCb(GuideController.instance, GuideEvent.SeasonShowUTTU, arg_3_0._showUTTU, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._onChangeRetail, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0.refreshCurrency, arg_3_0)
end

function var_0_0._onCloseView(arg_4_0, arg_4_1)
	if arg_4_1 == ViewName.LoadingView then
		if not arg_4_0._isViewOpen then
			arg_4_0:realOpen()
		end

		return
	end

	local var_4_0 = Activity104Model.instance:getCurSeasonId()

	if arg_4_1 == SeasonViewHelper.getViewName(var_4_0, Activity104Enum.ViewName.StoryPagePopView) then
		arg_4_0.viewContainer:getScene():showLevelObjs(arg_4_0.levelUpStage)
	end
end

function var_0_0.hideMask(arg_5_0)
	gohelper.setActive(arg_5_0._goMask, false)

	local var_5_0 = Activity104Model.instance:getCurSeasonId()

	if Activity104Model.instance:hasSeasonReview(var_5_0) and Activity104Model.instance:getIsPopSummary(var_5_0) and Activity104Model.instance:getLastMaxLayer(var_5_0) > 0 then
		Activity104Controller.instance:openSeasonSumView()
	else
		Activity104Controller.instance:dispatchEvent(Activity104Event.EnterSeasonMainView)
	end
end

function var_0_0.activeMask(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0._goMask, arg_6_1)
end

function var_0_0._btnStoryOnClick(arg_7_0)
	Activity104Controller.instance:openSeasonStoryView()
end

function var_0_0._btnletterOnClick(arg_8_0)
	Activity104Controller.instance:openSeasonSumView()
end

function var_0_0._btntrialOnClick(arg_9_0)
	local var_9_0 = Activity104Model.instance:getCurSeasonId()
	local var_9_1 = Activity104Model.instance:getTrialId(var_9_0)
	local var_9_2 = SeasonConfig.instance:getTrialConfig(var_9_0, var_9_1)

	if var_9_2 then
		Activity104Model.instance:enterAct104Battle(var_9_2.episodeId, var_9_1)
	end
end

function var_0_0.onTrialBattleReply(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_2 ~= 0 then
		return
	end

	Activity104Model.instance:onStartAct104BattleReply(arg_10_3)
end

function var_0_0._btndiscountOnClick(arg_11_0)
	Activity104Controller.instance:openSeasonSpecialMarketView()
end

function var_0_0._btndiscountlockOnClick(arg_12_0)
	GameFacade.showToast(ToastEnum.SeasonSpecialNotOpen)
end

function var_0_0._btnretailOnClick(arg_13_0)
	Activity104Controller.instance:openSeasonRetailView()
end

function var_0_0._btnentranceOnClick(arg_14_0)
	Activity104Controller.instance:openSeasonMarketView()
end

function var_0_0._btnreadprocessOnClick(arg_15_0)
	Activity104Controller.instance:openSeasonStoreView()
end

function var_0_0._btntaskOnClick(arg_16_0)
	Activity104Controller.instance:openSeasonTaskView()
end

function var_0_0._btncelebrityOnClick(arg_17_0)
	Activity104Controller.instance:openSeasonCardBook()
end

function var_0_0._btncurrencyiconOnClick(arg_18_0)
	local var_18_0 = Activity104Model.instance:getCurSeasonId()
	local var_18_1 = SeasonConfig.instance:getRetailTicket(var_18_0)

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, var_18_1)
end

function var_0_0._editableInitView(arg_19_0)
	arg_19_0._progressItems = {}

	local var_19_0 = gohelper.findChild(arg_19_0.viewGO, "#go_entrance/progress")

	for iter_19_0 = 1, 7 do
		arg_19_0._progressItems[iter_19_0] = arg_19_0:createProgress(iter_19_0, var_19_0)
	end
end

function var_0_0.onUpdateParam(arg_20_0)
	arg_20_0:_refreshUI()
	arg_20_0:checkJump()
end

function var_0_0.onOpen(arg_21_0)
	local var_21_0 = arg_21_0.viewParam and arg_21_0.viewParam.jumpId

	if ViewMgr.instance:isOpen(ViewName.LoadingView) and var_21_0 ~= nil then
		return
	end

	arg_21_0:realOpen()
end

function var_0_0.realOpen(arg_22_0)
	arg_22_0._isViewOpen = true

	gohelper.setActive(arg_22_0.viewGO, false)
	gohelper.setActive(arg_22_0.viewGO, true)
	arg_22_0:activeMask(true)
	TaskDispatcher.cancelTask(arg_22_0.hideMask, arg_22_0)
	TaskDispatcher.runDelay(arg_22_0.hideMask, arg_22_0, 1.5)
	TaskDispatcher.runDelay(arg_22_0._checkShowEquipSelfChoiceView, arg_22_0, 0.1)
	arg_22_0:checkLevupStage()
	arg_22_0:_refreshUI()
	arg_22_0:checkJump()

	if not arg_22_0.levelUpStage and (not arg_22_0.viewParam or not arg_22_0.viewParam.jumpId) then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity1_2.play_ui_lvhu_goldcup_open)
	end
end

function var_0_0.checkLevupStage(arg_23_0)
	arg_23_0.levelUpStage = arg_23_0.viewParam and arg_23_0.viewParam.levelUpStage

	if arg_23_0.levelUpStage then
		arg_23_0.viewContainer:stopUI()
		TaskDispatcher.runDelay(arg_23_0.showStoryPage, arg_23_0, 0.2)
	end
end

function var_0_0.showStoryPage(arg_24_0)
	if not arg_24_0.levelUpStage then
		return
	end

	local var_24_0 = {
		actId = Activity104Model.instance:getCurSeasonId(),
		stageId = arg_24_0.levelUpStage - 1
	}

	Activity104Controller.instance:openSeasonStoryPagePopView(var_24_0)
end

function var_0_0.checkJump(arg_25_0)
	local var_25_0 = arg_25_0.viewParam and arg_25_0.viewParam.jumpId
	local var_25_1 = arg_25_0.viewParam and arg_25_0.viewParam.jumpParam

	if var_25_0 == Activity104Enum.JumpId.Market then
		Activity104Controller.instance:openSeasonMarketView(var_25_1)
	elseif var_25_0 == Activity104Enum.JumpId.Retail then
		Activity104Controller.instance:openSeasonRetailView(var_25_1)
	elseif var_25_0 == Activity104Enum.JumpId.Discount then
		Activity104Controller.instance:openSeasonSpecialMarketView(var_25_1)
	end
end

function var_0_0._checkShowEquipSelfChoiceView(arg_26_0)
	Activity104Controller.instance:checkShowEquipSelfChoiceView()
end

function var_0_0.onLevelUp(arg_27_0)
	if not arg_27_0.levelUpStage then
		return
	end

	arg_27_0:activeProgressLevup(arg_27_0.levelUpStage, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_symbol_upgrade)

	arg_27_0._passStage = arg_27_0.levelUpStage
	arg_27_0.levelUpStage = nil
end

function var_0_0._refreshUI(arg_28_0)
	arg_28_0:_refreshMain()
	arg_28_0:_refreshRetail()
	arg_28_0:refreshCurrency()
	TaskDispatcher.cancelTask(arg_28_0._refreshMain, arg_28_0)
	TaskDispatcher.runRepeat(arg_28_0._refreshMain, arg_28_0, 60)
end

function var_0_0._refreshMain(arg_29_0)
	arg_29_0:refreshMarketEpisode()
	arg_29_0:refreshDiscount()
	arg_29_0:refreshProgress()
	arg_29_0:refreshTime()
	arg_29_0:refreshTrial()

	local var_29_0 = Activity104Model.instance:getCurSeasonId()
	local var_29_1 = Activity104Model.instance:hasSeasonReview(var_29_0)

	gohelper.setActive(arg_29_0._goletter, var_29_1)
end

local var_0_1 = Vector2(-92.8, -42.3)
local var_0_2 = Vector2(-76.6, -42.3)
local var_0_3 = Vector2(53.3, 15.7)
local var_0_4 = Vector2(72, 16.1)

function var_0_0.refreshMarketEpisode(arg_30_0)
	local var_30_0 = Activity104Model.instance:getCurSeasonId()
	local var_30_1 = Activity104Model.instance:getAct104CurLayer()
	local var_30_2 = Activity104Model.instance:getMaxLayer()

	arg_30_0._txtindex.text = string.format("%02d", var_30_1)

	local var_30_3 = var_30_2 == var_30_1 and var_0_2 or var_0_1
	local var_30_4 = var_30_2 == var_30_1 and var_0_4 or var_0_3

	recthelper.setAnchor(arg_30_0._txtindex.transform, var_30_3.x, var_30_3.y)
	recthelper.setAnchor(arg_30_0._goarrow.transform, var_30_4.x, var_30_4.y)
	gohelper.setActive(arg_30_0._gotop, var_30_2 == var_30_1 and Activity104Model.instance:isLayerPassed(var_30_0, var_30_1))

	local var_30_5 = SeasonConfig.instance:getSeasonEpisodeCo(var_30_0, var_30_1)

	arg_30_0._txtmapname.text = var_30_5.stageName
end

function var_0_0.refreshDiscount(arg_31_0)
	local var_31_0 = Activity104Model.instance:getCurSeasonId()
	local var_31_1 = Activity104Model.instance:isSpecialOpen()

	gohelper.setActive(arg_31_0._godiscount, var_31_1)
	gohelper.setActive(arg_31_0._godiscountlock, not var_31_1)

	if not var_31_1 then
		local var_31_2 = SeasonConfig.instance:getSeasonConstCo(var_31_0, Activity104Enum.ConstEnum.SpecialOpenLayer)
		local var_31_3 = var_31_2 and var_31_2.value1

		if Activity104Model.instance:isLayerPassed(var_31_0, var_31_3) then
			local var_31_4 = SeasonConfig.instance:getSeasonConstCo(var_31_0, Activity104Enum.ConstEnum.SpecialOpenDayCount).value1 - 1
			local var_31_5 = ActivityModel.instance:getActStartTime(var_31_0) / 1000 + var_31_4 * 86400 - ServerTime.now()
			local var_31_6 = string.format("%s%s", TimeUtil.secondToRoughTime2(var_31_5))

			arg_31_0._txtdiscountunlock.text = string.format(luaLang("seasonmainview_timeopencondition"), var_31_6)
		else
			arg_31_0._txtdiscountunlock.text = string.format(luaLang("seasonmainview_layeropencondition"), var_31_3)
		end
	else
		gohelper.setActive(arg_31_0._godiscountlock, false)

		local var_31_7 = Activity104Model.instance:isSpecialLayerOpen(var_31_0, 6)

		gohelper.setActive(arg_31_0._gonewdiscount, var_31_7)
	end
end

function var_0_0.refreshTime(arg_32_0)
	arg_32_0:_refreshTime()
end

function var_0_0._refreshTime(arg_33_0)
	local var_33_0 = Activity104Model.instance:getCurSeasonId()

	if not var_33_0 then
		return
	end

	local var_33_1 = ActivityModel.instance:getActMO(var_33_0)

	if not var_33_1 then
		return
	end

	local var_33_2 = var_33_1:getRealEndTimeStamp() - ServerTime.now()
	local var_33_3 = Mathf.Floor(var_33_2 / TimeUtil.OneDaySecond)
	local var_33_4 = var_33_2 % TimeUtil.OneDaySecond
	local var_33_5 = Mathf.Floor(var_33_4 / TimeUtil.OneHourSecond)
	local var_33_6 = GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
		var_33_3,
		var_33_5
	})

	arg_33_0._txtunlocktime.text = formatLuaLang("remain", var_33_6)
end

function var_0_0.refreshProgress(arg_34_0)
	local var_34_0 = Activity104Model.instance:getCurSeasonId()
	local var_34_1 = Activity104Model.instance:getMaxStage(var_34_0)
	local var_34_2 = Activity104Model.instance:getAct104CurStage(var_34_0)

	for iter_34_0, iter_34_1 in ipairs(arg_34_0._progressItems) do
		arg_34_0:updateProgress(iter_34_1, var_34_2, var_34_1)
	end
end

function var_0_0.refreshTrial(arg_35_0)
	local var_35_0 = Activity104Model.instance:getCurSeasonId()
	local var_35_1 = Activity104Model.instance:getTrialId(var_35_0)
	local var_35_2 = SeasonConfig.instance:getTrialConfig(var_35_0, var_35_1)

	if var_35_2 then
		gohelper.setActive(arg_35_0._gotry, true)

		local var_35_3 = SeasonConfig.instance:getTrialCount(var_35_0) + 1

		if not arg_35_0.starComp then
			local var_35_4 = gohelper.findChild(arg_35_0._gotry, "progress")

			arg_35_0.starComp = MonoHelper.addNoUpdateLuaComOnceToGo(var_35_4, SeasonStarProgressComp)
		end

		arg_35_0.starComp:refreshStar("#go_progress", var_35_1, var_35_3)

		arg_35_0._trialTxtNameen.text = var_35_2.nameEn
		arg_35_0._trialTxtNamecn.text = var_35_2.name

		local var_35_5 = DungeonConfig.instance:getEpisodeCO(var_35_2.episodeId)
		local var_35_6 = var_35_5 and var_35_5.battleId
		local var_35_7

		var_35_7 = var_35_6 and lua_battle.configDict[var_35_6]

		if not arg_35_0.trialCardItem then
			arg_35_0.trialCardItem = Season3_0CelebrityCardItem.New()

			arg_35_0.trialCardItem:init(arg_35_0._trialCardGo, var_35_2.equipId, {
				noClick = true
			})
		else
			arg_35_0.trialCardItem:reset(var_35_2.equipId)
		end
	else
		gohelper.setActive(arg_35_0._gotry, false)
	end
end

function var_0_0._refreshRetail(arg_36_0)
	local var_36_0 = Activity104Model.instance:getCurSeasonId()
	local var_36_1 = SeasonConfig.instance:getRetailTicket(var_36_0)
	local var_36_2 = CurrencyConfig.instance:getCurrencyCo(var_36_1)
	local var_36_3 = var_36_2 and var_36_2.icon

	if var_36_3 then
		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_36_0._imagecurrencyicon, var_36_3 .. "_1", true)
	end

	local var_36_4 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SeasonRetail)
	local var_36_5 = GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU)
	local var_36_6 = var_36_5 or GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount)

	gohelper.setActive(arg_36_0._goretail, var_36_4 and not var_36_5)

	arg_36_0._retailProcessing = #Activity104Model.instance:getAct104Retails() > 0

	gohelper.setActive(arg_36_0._goassemblying, arg_36_0._retailProcessing)
	gohelper.setActive(arg_36_0._gocurrency, not arg_36_0._retailProcessing)

	if not arg_36_0._retailProcessing then
		local var_36_7 = var_36_2 and var_36_2.recoverLimit
		local var_36_8 = CurrencyModel.instance:getCurrency(var_36_1)
		local var_36_9 = var_36_8 and var_36_8.quantity or 0

		arg_36_0._hasEnoughTicket = var_36_9 >= 1

		local var_36_10 = var_36_9 > 0 and var_36_9 or "<color=#CF4543>" .. var_36_9 .. "</color>"

		arg_36_0._txtcurrencycount.text = string.format("%s/%s", var_36_10, var_36_7)
	end

	gohelper.setActive(arg_36_0._goEnterEffect, not var_36_6)
end

function var_0_0._showUTTU(arg_37_0)
	arg_37_0:_refreshRetail()

	local var_37_0 = gohelper.onceAddComponent(arg_37_0._goretail, typeof(UnityEngine.Animator))

	if var_37_0 then
		var_37_0:Play(UIAnimationName.Switch, 0, 0)
	end
end

function var_0_0._onRefreshRetail(arg_38_0)
	arg_38_0:_refreshRetail()
end

function var_0_0._onChangeRetail(arg_39_0, arg_39_1)
	local var_39_0 = Activity104Model.instance:getCurSeasonId()
	local var_39_1 = SeasonConfig.instance:getRetailTicket(var_39_0)

	if not var_39_1 or not arg_39_1[var_39_1] then
		return
	end

	arg_39_0:_refreshRetail()
end

function var_0_0.createProgress(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_0:getUserDataTb_()

	var_40_0.index = arg_40_1
	var_40_0.go = gohelper.findChild(arg_40_2, string.format("#go_progress%s", arg_40_1))
	var_40_0.dark = gohelper.findChild(var_40_0.go, "dark")
	var_40_0.light = gohelper.findChild(var_40_0.go, "light")
	var_40_0.lightImg = var_40_0.light:GetComponent(gohelper.Type_Image)
	var_40_0.leveup = gohelper.findChild(var_40_0.go, "leveup")
	var_40_0.leveupImg = gohelper.findChildImage(var_40_0.go, "leveup/lock")

	return var_40_0
end

function var_0_0.activeProgress(arg_41_0, arg_41_1, arg_41_2)
	if not arg_41_1 then
		return
	end

	gohelper.setActive(arg_41_1.go, arg_41_2)
end

function var_0_0.activeProgressLevup(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_0._progressItems[arg_42_1]

	if not var_42_0 then
		return
	end

	gohelper.setActive(var_42_0.leveup, arg_42_2)

	if arg_42_2 then
		local var_42_1 = Activity104Model.instance:getCurSeasonId()
		local var_42_2 = Activity104Model.instance:getMaxStage(var_42_1) == arg_42_1 and "#B83838" or "#FFFFFF"

		SLFramework.UGUI.GuiHelper.SetColor(var_42_0.leveupImg, var_42_2)
	end
end

function var_0_0.activeProgressLight(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0._progressItems[arg_43_1]

	if not var_43_0 then
		return
	end

	gohelper.setActive(var_43_0.light, arg_43_2)
end

function var_0_0.updateProgress(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	if not arg_44_1 then
		return
	end

	local var_44_0 = arg_44_1.index
	local var_44_1 = var_44_0 == arg_44_3

	if arg_44_3 < var_44_0 or var_44_1 and arg_44_2 < var_44_0 then
		gohelper.setActive(arg_44_1.go, false)

		return
	end

	gohelper.setActive(arg_44_1.go, true)

	local var_44_2 = var_44_1 and "#B83838" or "#FFFFFF"

	SLFramework.UGUI.GuiHelper.SetColor(arg_44_1.lightImg, var_44_2)
	gohelper.setActive(arg_44_1.light, var_44_0 <= arg_44_2 and arg_44_0.levelUpStage ~= var_44_0)
	gohelper.setActive(arg_44_1.dark, arg_44_2 < var_44_0)
end

function var_0_0.refreshCurrency(arg_45_0)
	local var_45_0 = Activity104Model.instance:getCurSeasonId()
	local var_45_1 = Activity104Enum.StoreUTTU[var_45_0]
	local var_45_2 = CurrencyModel.instance:getCurrency(var_45_1)
	local var_45_3 = var_45_2 and var_45_2.quantity or 0

	arg_45_0._txtNum.text = GameUtil.numberDisplay(var_45_3)
end

function var_0_0.onClose(arg_46_0)
	return
end

function var_0_0.onDestroyView(arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._refreshMain, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0.hideMask, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._checkShowEquipSelfChoiceView, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0.showStoryPage, arg_47_0)
end

return var_0_0
