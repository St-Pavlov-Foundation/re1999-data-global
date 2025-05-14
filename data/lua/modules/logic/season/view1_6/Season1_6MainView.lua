module("modules.logic.season.view1_6.Season1_6MainView", package.seeall)

local var_0_0 = class("Season1_6MainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goreadprocess = gohelper.findChild(arg_1_0.viewGO, "leftbtns/#go_readprocess")
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
	arg_2_0._animationEvent:AddEventListener("levelup", arg_2_0.onLevelUp, arg_2_0)
	arg_2_0:addEventCb(Activity104Controller.instance, Activity104Event.RefreshRetail, arg_2_0._onRefreshRetail, arg_2_0)
	arg_2_0:addEventCb(GuideController.instance, GuideEvent.SeasonShowUTTU, arg_2_0._showUTTU, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._onChangeRetail, arg_2_0)
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
	arg_3_0._animationEvent:RemoveEventListener("levelup")
	arg_3_0:removeEventCb(Activity104Controller.instance, Activity104Event.RefreshRetail, arg_3_0._onRefreshRetail, arg_3_0)
	arg_3_0:removeEventCb(GuideController.instance, GuideEvent.SeasonShowUTTU, arg_3_0._showUTTU, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._onChangeRetail, arg_3_0)
end

function var_0_0.hideMask(arg_4_0)
	gohelper.setActive(arg_4_0._goMask, false)

	local var_4_0 = Activity104Model.instance:getCurSeasonId()

	if Activity104Model.instance:getIsPopSummary(var_4_0) and Activity104Model.instance:getLastMaxLayer(var_4_0) > 0 then
		Activity104Controller.instance:openSeasonSumView()
	else
		Activity104Controller.instance:dispatchEvent(Activity104Event.EnterSeasonMainView)
	end
end

function var_0_0.activeMask(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._goMask, arg_5_1)
end

function var_0_0._btnletterOnClick(arg_6_0)
	Activity104Controller.instance:openSeasonSumView()
end

function var_0_0._btntrialOnClick(arg_7_0)
	local var_7_0 = Activity104Model.instance:getCurSeasonId()
	local var_7_1 = Activity104Model.instance:getTrialId(var_7_0)
	local var_7_2 = SeasonConfig.instance:getTrialConfig(var_7_0, var_7_1)

	if var_7_2 then
		Activity104Model.instance:enterAct104Battle(var_7_2.episodeId, var_7_1)
	end
end

function var_0_0.onTrialBattleReply(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2 ~= 0 then
		return
	end

	Activity104Model.instance:onStartAct104BattleReply(arg_8_3)
end

function var_0_0._btndiscountOnClick(arg_9_0)
	Activity104Controller.instance:openSeasonSpecialMarketView()
end

function var_0_0._btndiscountlockOnClick(arg_10_0)
	if not string.nilorempty(arg_10_0._discountLockTipsStr) then
		ToastController.instance:showToastWithString(arg_10_0._discountLockTipsStr)
	end
end

function var_0_0._btnretailOnClick(arg_11_0)
	Activity104Controller.instance:openSeasonRetailView()
end

function var_0_0._btnentranceOnClick(arg_12_0)
	Activity104Controller.instance:openSeasonMarketView()
end

function var_0_0._btnreadprocessOnClick(arg_13_0)
	Activity104Controller.instance:openSeasonStoreView()
end

function var_0_0._btntaskOnClick(arg_14_0)
	Activity104Controller.instance:openSeasonTaskView()
end

function var_0_0._btncelebrityOnClick(arg_15_0)
	Activity104Controller.instance:openSeasonCardBook()
end

function var_0_0._btncurrencyiconOnClick(arg_16_0)
	local var_16_0 = Activity104Model.instance:getCurSeasonId()
	local var_16_1 = SeasonConfig.instance:getRetailTicket(var_16_0)

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, var_16_1)
end

function var_0_0._editableInitView(arg_17_0)
	arg_17_0._progressItems = {}

	local var_17_0 = gohelper.findChild(arg_17_0.viewGO, "#go_entrance/progress")

	for iter_17_0 = 1, 7 do
		arg_17_0._progressItems[iter_17_0] = arg_17_0:createProgress(iter_17_0, var_17_0)
	end
end

function var_0_0.onUpdateParam(arg_18_0)
	arg_18_0:_refreshUI()
	arg_18_0:checkJump()
end

function var_0_0.onOpen(arg_19_0)
	arg_19_0:activeMask(true)
	TaskDispatcher.cancelTask(arg_19_0.hideMask, arg_19_0)
	TaskDispatcher.runDelay(arg_19_0.hideMask, arg_19_0, 1.5)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_hippie_open)

	arg_19_0.levelUpStage = arg_19_0.viewParam and arg_19_0.viewParam.levelUpStage

	if arg_19_0.levelUpStage then
		arg_19_0.viewContainer:getScene():showLevelObjs(arg_19_0.levelUpStage)
	end

	arg_19_0:_refreshUI()
	TaskDispatcher.runDelay(arg_19_0._checkShowEquipSelfChoiceView, arg_19_0, 0.1)
	arg_19_0:checkJump()
end

function var_0_0.checkJump(arg_20_0)
	local var_20_0 = arg_20_0.viewParam and arg_20_0.viewParam.jumpId
	local var_20_1 = arg_20_0.viewParam and arg_20_0.viewParam.jumpParam

	if var_20_0 == Activity104Enum.JumpId.Market then
		Activity104Controller.instance:openSeasonMarketView(var_20_1)
	elseif var_20_0 == Activity104Enum.JumpId.Retail then
		Activity104Controller.instance:openSeasonRetailView(var_20_1)
	elseif var_20_0 == Activity104Enum.JumpId.Discount then
		Activity104Controller.instance:openSeasonSpecialMarketView(var_20_1)
	end
end

function var_0_0._checkShowEquipSelfChoiceView(arg_21_0)
	Activity104Controller.instance:checkShowEquipSelfChoiceView()
end

function var_0_0.onLevelUp(arg_22_0)
	if not arg_22_0.levelUpStage then
		return
	end

	arg_22_0:activeProgressLevup(arg_22_0.levelUpStage, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_symbol_upgrade)

	arg_22_0._passStage = arg_22_0.levelUpStage

	TaskDispatcher.runDelay(arg_22_0._showPassTips, arg_22_0, 0.6)

	arg_22_0.levelUpStage = nil
end

function var_0_0._showPassTips(arg_23_0)
	if arg_23_0._passStage == 7 then
		GameFacade.showToast(ToastEnum.SeasonMarketPassTips2)
	else
		GameFacade.showToast(ToastEnum.SeasonMarketPassTips1)
	end
end

function var_0_0._refreshUI(arg_24_0)
	arg_24_0:_refreshMain()
	arg_24_0:_refreshRetail()
	TaskDispatcher.cancelTask(arg_24_0._refreshMain, arg_24_0)
	TaskDispatcher.runRepeat(arg_24_0._refreshMain, arg_24_0, 60)
end

local var_0_1 = Vector2(-92.8, -42.3)
local var_0_2 = Vector2(-76.6, -42.3)
local var_0_3 = Vector2(53.3, 15.7)
local var_0_4 = Vector2(72, 16.1)

function var_0_0._refreshMain(arg_25_0)
	local var_25_0 = Activity104Model.instance:getCurSeasonId()
	local var_25_1 = Activity104Model.instance:isSpecialOpen()
	local var_25_2 = Activity104Model.instance:isEnterSpecial()
	local var_25_3 = Activity104Model.instance:getAct104CurLayer()
	local var_25_4 = Activity104Model.instance:getMaxLayer()
	local var_25_5 = SeasonConfig.instance:getSeasonConstCo(var_25_0, Activity104Enum.ConstEnum.SpecialOpenLayer)
	local var_25_6 = var_25_5 and var_25_5.value1 or 0
	local var_25_7 = var_25_6 < var_25_3

	gohelper.setActive(arg_25_0._godiscount, var_25_1)
	gohelper.setActive(arg_25_0._godiscountlock, var_25_2 or var_25_7)

	arg_25_0._discountLockTipsStr = ""

	if not var_25_1 then
		if var_25_7 then
			local var_25_8 = SeasonConfig.instance:getSeasonConstCo(var_25_0, Activity104Enum.ConstEnum.SpecialOpenDayCount).value1 - 1
			local var_25_9 = ActivityModel.instance:getActStartTime(var_25_0) / 1000 + var_25_8 * 86400 - ServerTime.now()
			local var_25_10 = string.format("%s%s", TimeUtil.secondToRoughTime2(var_25_9))

			arg_25_0._txtdiscountunlock.text = string.format(luaLang("seasonmainview_timeopencondition"), var_25_10)
		else
			arg_25_0._txtdiscountunlock.text = string.format(luaLang("seasonmainview_layeropencondition"), var_25_6)
		end

		arg_25_0._discountLockTipsStr = arg_25_0._txtdiscountunlock.text
	else
		gohelper.setActive(arg_25_0._godiscountlock, false)
	end

	arg_25_0._txtindex.text = string.format("%02d", var_25_3)

	local var_25_11 = var_25_4 == var_25_3 and var_0_2 or var_0_1
	local var_25_12 = var_25_4 == var_25_3 and var_0_4 or var_0_3

	recthelper.setAnchor(arg_25_0._txtindex.transform, var_25_11.x, var_25_11.y)
	recthelper.setAnchor(arg_25_0._goarrow.transform, var_25_12.x, var_25_12.y)
	gohelper.setActive(arg_25_0._gotop, var_25_4 == var_25_3 and Activity104Model.instance:isLayerPassed(var_25_0, var_25_3))

	local var_25_13 = SeasonConfig.instance:getSeasonEpisodeCo(var_25_0, var_25_3)

	arg_25_0._txtmapname.text = var_25_13.stageName

	local var_25_14 = Activity104Model.instance:getAct104CurStage()

	arg_25_0:activeProgress(arg_25_0._progressItems[7], var_25_14 == 7)

	for iter_25_0, iter_25_1 in ipairs(arg_25_0._progressItems) do
		arg_25_0:updateProgress(iter_25_1, var_25_14)
	end

	local var_25_15 = ActivityModel.instance:getActMO(var_25_0):getRealEndTimeStamp() - ServerTime.now()
	local var_25_16 = Mathf.Floor(var_25_15 / TimeUtil.OneDaySecond)
	local var_25_17 = var_25_15 % TimeUtil.OneDaySecond
	local var_25_18 = Mathf.Floor(var_25_17 / TimeUtil.OneHourSecond)
	local var_25_19 = GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
		var_25_16,
		var_25_18
	})

	arg_25_0._txtunlocktime.text = formatLuaLang("remain", var_25_19)

	arg_25_0:refreshTrial()
end

function var_0_0.refreshTrial(arg_26_0)
	local var_26_0 = Activity104Model.instance:getCurSeasonId()
	local var_26_1 = Activity104Model.instance:getTrialId(var_26_0)
	local var_26_2 = SeasonConfig.instance:getTrialConfig(var_26_0, var_26_1)

	if var_26_2 then
		gohelper.setActive(arg_26_0._gotry, true)

		local var_26_3 = SeasonConfig.instance:getSeasonEpisodeCo(var_26_0, var_26_2.unlockLayer).stage

		if not arg_26_0._trialProgressItems then
			arg_26_0._trialProgressItems = {}

			local var_26_4 = gohelper.findChild(arg_26_0._gotry, "progress")

			for iter_26_0 = 1, 7 do
				arg_26_0._trialProgressItems[iter_26_0] = arg_26_0:createProgress(iter_26_0, var_26_4)
			end
		end

		arg_26_0:activeProgress(arg_26_0._trialProgressItems[7], var_26_3 == 7)

		for iter_26_1, iter_26_2 in ipairs(arg_26_0._trialProgressItems) do
			arg_26_0:updateProgress(iter_26_2, var_26_3)
		end

		arg_26_0._trialTxtNameen.text = var_26_2.nameEn
		arg_26_0._trialTxtNamecn.text = var_26_2.name

		local var_26_5 = DungeonConfig.instance:getEpisodeCO(var_26_2.episodeId)
		local var_26_6 = var_26_5 and var_26_5.battleId
		local var_26_7 = var_26_6 and lua_battle.configDict[var_26_6]

		if not arg_26_0.trialCardItem then
			arg_26_0.trialCardItem = Season1_6CelebrityCardItem.New()

			arg_26_0.trialCardItem:init(arg_26_0._trialCardGo, var_26_7.trialMainAct104EuqipId, {
				noClick = true
			})
		else
			arg_26_0.trialCardItem:reset(var_26_7.trialMainAct104EuqipId)
		end
	else
		gohelper.setActive(arg_26_0._gotry, false)
	end
end

function var_0_0._refreshRetail(arg_27_0)
	local var_27_0 = Activity104Model.instance:getCurSeasonId()
	local var_27_1 = SeasonConfig.instance:getRetailTicket(var_27_0)
	local var_27_2 = CurrencyConfig.instance:getCurrencyCo(var_27_1)
	local var_27_3 = var_27_2 and var_27_2.icon

	if var_27_3 then
		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_27_0._imagecurrencyicon, var_27_3 .. "_1", true)
	end

	local var_27_4 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SeasonRetail)
	local var_27_5 = GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU)
	local var_27_6 = var_27_5 or GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount)

	gohelper.setActive(arg_27_0._goretail, var_27_4 and not var_27_5)

	arg_27_0._retailProcessing = #Activity104Model.instance:getAct104Retails() > 0

	gohelper.setActive(arg_27_0._goassemblying, arg_27_0._retailProcessing)
	gohelper.setActive(arg_27_0._gocurrency, not arg_27_0._retailProcessing)

	if not arg_27_0._retailProcessing then
		local var_27_7 = var_27_2 and var_27_2.recoverLimit
		local var_27_8 = CurrencyModel.instance:getCurrency(var_27_1)
		local var_27_9 = var_27_8 and var_27_8.quantity or 0

		arg_27_0._hasEnoughTicket = var_27_9 >= 1

		local var_27_10 = var_27_9 > 0 and var_27_9 or "<color=#CF4543>" .. var_27_9 .. "</color>"

		arg_27_0._txtcurrencycount.text = string.format("%s/%s", var_27_10, var_27_7)
	end

	gohelper.setActive(arg_27_0._goEnterEffect, not var_27_6)
end

function var_0_0._showUTTU(arg_28_0)
	arg_28_0:_refreshRetail()

	local var_28_0 = gohelper.onceAddComponent(arg_28_0._goretail, typeof(UnityEngine.Animator))

	if var_28_0 then
		var_28_0:Play(UIAnimationName.Switch, 0, 0)
	end
end

function var_0_0._onRefreshRetail(arg_29_0)
	arg_29_0:_refreshRetail()
end

function var_0_0._onChangeRetail(arg_30_0, arg_30_1)
	local var_30_0 = Activity104Model.instance:getCurSeasonId()
	local var_30_1 = SeasonConfig.instance:getRetailTicket(var_30_0)

	if not var_30_1 or not arg_30_1[var_30_1] then
		return
	end

	arg_30_0:_refreshRetail()
end

function var_0_0.createProgress(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0:getUserDataTb_()

	var_31_0.index = arg_31_1
	var_31_0.go = gohelper.findChild(arg_31_2, string.format("#go_progress%s", arg_31_1))
	var_31_0.dark = gohelper.findChild(var_31_0.go, "dark")
	var_31_0.light = gohelper.findChild(var_31_0.go, "light")
	var_31_0.lightImg = var_31_0.light:GetComponent(gohelper.Type_Image)
	var_31_0.leveup = gohelper.findChild(var_31_0.go, "leveup")

	return var_31_0
end

function var_0_0.activeProgress(arg_32_0, arg_32_1, arg_32_2)
	if not arg_32_1 then
		return
	end

	gohelper.setActive(arg_32_1.go, arg_32_2)
end

function var_0_0.activeProgressLevup(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0._progressItems[arg_33_1]

	if not var_33_0 then
		return
	end

	gohelper.setActive(var_33_0.leveup, arg_33_2)
end

function var_0_0.activeProgressLight(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0._progressItems[arg_34_1]

	if not var_34_0 then
		return
	end

	gohelper.setActive(var_34_0.light, arg_34_2)
end

function var_0_0.updateProgress(arg_35_0, arg_35_1, arg_35_2)
	if not arg_35_1 then
		return
	end

	local var_35_0 = arg_35_1.index
	local var_35_1 = var_35_0 == 7 and "#B83838" or "#FFFFFF"

	SLFramework.UGUI.GuiHelper.SetColor(arg_35_1.lightImg, var_35_1)
	gohelper.setActive(arg_35_1.light, var_35_0 <= arg_35_2 and arg_35_0.levelUpStage ~= var_35_0)
	gohelper.setActive(arg_35_1.dark, arg_35_2 < var_35_0)
end

function var_0_0.onTrialBattle(arg_36_0, arg_36_1)
	return
end

function var_0_0.onClose(arg_37_0)
	return
end

function var_0_0.onDestroyView(arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0._refreshMain, arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0.hideMask, arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0._showPassTips, arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0._checkShowEquipSelfChoiceView, arg_38_0)
end

return var_0_0
