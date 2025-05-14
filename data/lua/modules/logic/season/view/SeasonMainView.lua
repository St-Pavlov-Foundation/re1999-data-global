module("modules.logic.season.view.SeasonMainView", package.seeall)

local var_0_0 = class("SeasonMainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_mask")
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

	RedDotController.instance:addRedDot(arg_1_0._gotaskreddot, RedDotEnum.DotNode.SeasonTaskLevel)

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
	arg_2_0._animationEvent:AddEventListener("levelup", arg_2_0.onLevelUp, arg_2_0)
	arg_2_0:addEventCb(GuideController.instance, GuideEvent.SeasonShowUTTU, arg_2_0._showUTTU, arg_2_0)
	arg_2_0:addEventCb(Activity104Controller.instance, Activity104Event.RefreshRetail, arg_2_0._onRefreshRetail, arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0._refreshUI, arg_2_0)
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
	arg_3_0._animationEvent:RemoveEventListener("levelup")
	arg_3_0:removeEventCb(GuideController.instance, GuideEvent.SeasonShowUTTU, arg_3_0._showUTTU, arg_3_0)
	arg_3_0:removeEventCb(Activity104Controller.instance, Activity104Event.RefreshRetail, arg_3_0._onRefreshRetail, arg_3_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_3_0._refreshUI, arg_3_0)
end

function var_0_0.activeMask(arg_4_0, arg_4_1)
	gohelper.setActive(arg_4_0._goMask, arg_4_1)
end

function var_0_0._btndiscountOnClick(arg_5_0)
	Activity104Controller.instance:openSeasonSpecialMarketView()
end

function var_0_0._btndiscountlockOnClick(arg_6_0)
	return
end

function var_0_0._btnretailOnClick(arg_7_0)
	Activity104Controller.instance:openSeasonRetailView()
end

function var_0_0._btnentranceOnClick(arg_8_0)
	Activity104Controller.instance:openSeasonMarketView()
end

function var_0_0._btnreadprocessOnClick(arg_9_0)
	VersionActivityController.instance:openSeasonStoreView()
end

function var_0_0._btntaskOnClick(arg_10_0)
	Activity104Controller.instance:openSeasonTaskView()
end

function var_0_0._btncelebrityOnClick(arg_11_0)
	Activity104Controller.instance:openSeasonCardBook(Activity104Model.instance:getCurSeasonId())
end

function var_0_0._btncurrencyiconOnClick(arg_12_0)
	local var_12_0 = Activity104Model.instance:getCurSeasonId()
	local var_12_1 = SeasonConfig.instance:getRetailTicket(var_12_0)

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, var_12_1)
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0._progressItems = {}

	for iter_13_0 = 1, 7 do
		arg_13_0._progressItems[iter_13_0] = arg_13_0:createProgress(iter_13_0)
	end

	arg_13_0._simagemask:LoadImage(ResUrl.getSeasonIcon("full/mask.png"))
end

function var_0_0.onUpdateParam(arg_14_0)
	arg_14_0:_refreshUI()
	arg_14_0:checkJump()
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:activeMask(false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_hippie_open)

	arg_15_0.levelUpStage = arg_15_0.viewParam and arg_15_0.viewParam.levelUpStage

	if arg_15_0.levelUpStage then
		arg_15_0.viewContainer:getScene():showLevelObjs(arg_15_0.levelUpStage)
	end

	arg_15_0:_refreshUI()
	TaskDispatcher.runDelay(arg_15_0._checkShowEquipSelfChoiceView, arg_15_0, 0.1)
	arg_15_0:checkJump()
end

function var_0_0.checkJump(arg_16_0)
	local var_16_0 = arg_16_0.viewParam and arg_16_0.viewParam.jumpId

	if var_16_0 == Activity104Enum.JumpId.Market then
		Activity104Controller.instance:openSeasonMarketView()
	elseif var_16_0 == Activity104Enum.JumpId.Retail then
		Activity104Controller.instance:openSeasonRetailView()
	elseif var_16_0 == Activity104Enum.JumpId.Discount then
		Activity104Controller.instance:openSeasonSpecialMarketView()
	end
end

function var_0_0._checkShowEquipSelfChoiceView(arg_17_0)
	local var_17_0 = Activity104Model.instance:getCurSeasonId()

	Activity104Controller.instance:checkShowEquipSelfChoiceView(var_17_0)
end

function var_0_0.onLevelUp(arg_18_0)
	if not arg_18_0.levelUpStage then
		return
	end

	arg_18_0:activeProgressLevup(arg_18_0.levelUpStage, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_symbol_upgrade)

	arg_18_0._passStage = arg_18_0.levelUpStage

	TaskDispatcher.runDelay(arg_18_0._showPassTips, arg_18_0, 0.6)

	arg_18_0.levelUpStage = nil
end

function var_0_0._showPassTips(arg_19_0)
	if arg_19_0._passStage == 7 then
		GameFacade.showToast(ToastEnum.SeasonMarketPassTips2)
	else
		GameFacade.showToast(ToastEnum.SeasonMarketPassTips1)
	end
end

function var_0_0._refreshUI(arg_20_0)
	arg_20_0:_refreshMain()
	arg_20_0:_refreshRetail()
end

local var_0_1 = Vector2(-92.8, -42.3)
local var_0_2 = Vector2(-76.6, -42.3)
local var_0_3 = Vector2(53.3, 15.7)
local var_0_4 = Vector2(72, 16.1)

function var_0_0._refreshMain(arg_21_0)
	local var_21_0 = Activity104Model.instance:getCurSeasonId()
	local var_21_1 = Activity104Model.instance:isSpecialOpen()
	local var_21_2 = Activity104Model.instance:isEnterSpecial()
	local var_21_3 = Activity104Model.instance:getAct104CurLayer()
	local var_21_4 = Activity104Model.instance:getMaxLayer()
	local var_21_5 = SeasonConfig.instance:getSeasonConstCo(var_21_0, Activity104Enum.ConstEnum.SpecialOpenLayer)
	local var_21_6 = var_21_5 and var_21_5.value1 or 0
	local var_21_7 = var_21_6 < var_21_3

	gohelper.setActive(arg_21_0._godiscount, var_21_1)
	gohelper.setActive(arg_21_0._godiscountlock, var_21_2 or var_21_7)

	if not var_21_1 then
		if var_21_7 then
			local var_21_8 = SeasonConfig.instance:getSeasonConstCo(var_21_0, Activity104Enum.ConstEnum.SpecialOpenDayCount).value1 - 1
			local var_21_9 = ActivityModel.instance:getActStartTime(var_21_0) / 1000 + var_21_8 * 86400 - ServerTime.now()
			local var_21_10 = string.format("%s%s", TimeUtil.secondToRoughTime2(var_21_9))

			arg_21_0._txtdiscountunlock.text = string.format(luaLang("seasonmainview_timeopencondition"), var_21_10)
		else
			arg_21_0._txtdiscountunlock.text = string.format(luaLang("seasonmainview_layeropencondition"), var_21_6)
		end
	else
		gohelper.setActive(arg_21_0._godiscountlock, false)
	end

	arg_21_0._txtindex.text = string.format("%02d", var_21_3)

	local var_21_11 = var_21_4 == var_21_3 and var_0_2 or var_0_1
	local var_21_12 = var_21_4 == var_21_3 and var_0_4 or var_0_3

	recthelper.setAnchor(arg_21_0._txtindex.transform, var_21_11.x, var_21_11.y)
	recthelper.setAnchor(arg_21_0._goarrow.transform, var_21_12.x, var_21_12.y)
	gohelper.setActive(arg_21_0._gotop, var_21_4 == var_21_3 and Activity104Model.instance:isLayerPassed(var_21_3))

	local var_21_13 = SeasonConfig.instance:getSeasonEpisodeCo(var_21_0, var_21_3)

	arg_21_0._txtmapname.text = var_21_13.stageName

	local var_21_14 = Activity104Model.instance:getAct104CurStage()

	arg_21_0:activeProgress(7, var_21_14 == 7)

	for iter_21_0, iter_21_1 in ipairs(arg_21_0._progressItems) do
		arg_21_0:updateProgress(iter_21_0, var_21_14)
	end

	local var_21_15 = ActivityModel.instance:getActivityInfo()[var_21_0]:getRealEndTimeStamp() - ServerTime.now()
	local var_21_16 = Mathf.Floor(var_21_15 / TimeUtil.OneDaySecond)
	local var_21_17 = var_21_15 % TimeUtil.OneDaySecond
	local var_21_18 = Mathf.Floor(var_21_17 / TimeUtil.OneHourSecond)
	local var_21_19 = GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
		var_21_16,
		var_21_18
	})

	arg_21_0._txtunlocktime.text = formatLuaLang("remain", var_21_19)
end

function var_0_0._refreshRetail(arg_22_0)
	local var_22_0 = Activity104Model.instance:getCurSeasonId()
	local var_22_1 = SeasonConfig.instance:getRetailTicket(var_22_0)
	local var_22_2 = CurrencyConfig.instance:getCurrencyCo(var_22_1).icon

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_22_0._imagecurrencyicon, var_22_2 .. "_1", true)

	local var_22_3 = not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU)
	local var_22_4 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SeasonRetail)

	gohelper.setActive(arg_22_0._goretail, var_22_3 and var_22_4)

	arg_22_0._retailProcessing = #Activity104Model.instance:getAct104Retails() > 0

	gohelper.setActive(arg_22_0._goassemblying, arg_22_0._retailProcessing)
	gohelper.setActive(arg_22_0._gocurrency, not arg_22_0._retailProcessing)

	if not arg_22_0._retailProcessing then
		local var_22_5 = CurrencyConfig.instance:getCurrencyCo(var_22_1).recoverLimit
		local var_22_6 = CurrencyModel.instance:getCurrency(var_22_1).quantity

		arg_22_0._hasEnoughTicket = var_22_6 >= 1

		local var_22_7 = var_22_6 > 0 and var_22_6 or "<color=#CF4543>" .. var_22_6 .. "</color>"

		arg_22_0._txtcurrencycount.text = string.format("%s/%s", var_22_7, var_22_5)
	end
end

function var_0_0._showUTTU(arg_23_0)
	arg_23_0:_refreshRetail()

	local var_23_0 = gohelper.onceAddComponent(arg_23_0._goretail, typeof(UnityEngine.Animator))

	if var_23_0 then
		var_23_0:Play(UIAnimationName.Switch, 0, 0)
	end
end

function var_0_0._onRefreshRetail(arg_24_0)
	arg_24_0:_refreshRetail()
end

function var_0_0.createProgress(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getUserDataTb_()

	var_25_0.go = gohelper.findChild(arg_25_0.viewGO, string.format("#go_entrance/progress/#go_progress%s", arg_25_1))
	var_25_0.dark = gohelper.findChild(var_25_0.go, "dark")
	var_25_0.light = gohelper.findChild(var_25_0.go, "light")
	var_25_0.lightImg = var_25_0.light:GetComponent(gohelper.Type_Image)
	var_25_0.leveup = gohelper.findChild(var_25_0.go, "leveup")

	return var_25_0
end

function var_0_0.activeProgress(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0._progressItems[arg_26_1]

	if not var_26_0 then
		return
	end

	gohelper.setActive(var_26_0.go, arg_26_2)
end

function var_0_0.activeProgressLevup(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0._progressItems[arg_27_1]

	if not var_27_0 then
		return
	end

	gohelper.setActive(var_27_0.leveup, arg_27_2)
end

function var_0_0.activeProgressLight(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0._progressItems[arg_28_1]

	if not var_28_0 then
		return
	end

	gohelper.setActive(var_28_0.light, arg_28_2)
end

function var_0_0.updateProgress(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0._progressItems[arg_29_1]

	if not var_29_0 then
		return
	end

	local var_29_1 = arg_29_1 == 7 and "#B83838" or "#FFFFFF"

	SLFramework.UGUI.GuiHelper.SetColor(var_29_0.lightImg, var_29_1)
	gohelper.setActive(var_29_0.light, arg_29_1 <= arg_29_2 and arg_29_0.levelUpStage ~= arg_29_1)
	gohelper.setActive(var_29_0.dark, arg_29_2 < arg_29_1)
end

function var_0_0.onClose(arg_30_0)
	return
end

function var_0_0.onDestroyView(arg_31_0)
	arg_31_0._simagemask:UnLoadImage()
	TaskDispatcher.cancelTask(arg_31_0._showPassTips, arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0._checkShowEquipSelfChoiceView, arg_31_0)
end

return var_0_0
