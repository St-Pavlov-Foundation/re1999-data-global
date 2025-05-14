module("modules.logic.season.view1_2.Season1_2MainView", package.seeall)

local var_0_0 = class("Season1_2MainView", BaseView)

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
	arg_3_0._animationEvent:RemoveEventListener("levelup")
	arg_3_0:removeEventCb(Activity104Controller.instance, Activity104Event.RefreshRetail, arg_3_0._onRefreshRetail, arg_3_0)
	arg_3_0:removeEventCb(GuideController.instance, GuideEvent.SeasonShowUTTU, arg_3_0._showUTTU, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._onChangeRetail, arg_3_0)
end

function var_0_0.hideMask(arg_4_0)
	gohelper.setActive(arg_4_0._goMask, false)
end

function var_0_0.activeMask(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._goMask, arg_5_1)
end

function var_0_0._btndiscountOnClick(arg_6_0)
	Activity104Controller.instance:openSeasonSpecialMarketView()
end

function var_0_0._btndiscountlockOnClick(arg_7_0)
	return
end

function var_0_0._btnretailOnClick(arg_8_0)
	Activity104Controller.instance:openSeasonRetailView()
end

function var_0_0._btnentranceOnClick(arg_9_0)
	Activity104Controller.instance:openSeasonMarketView()
end

function var_0_0._btnreadprocessOnClick(arg_10_0)
	VersionActivityController.instance:openSeasonStoreView()
end

function var_0_0._btntaskOnClick(arg_11_0)
	Activity104Controller.instance:openSeasonTaskView()
end

function var_0_0._btncelebrityOnClick(arg_12_0)
	Activity104Controller.instance:openSeasonCardBook()
end

function var_0_0._btncurrencyiconOnClick(arg_13_0)
	local var_13_0 = Activity104Model.instance:getCurSeasonId()
	local var_13_1 = SeasonConfig.instance:getRetailTicket(var_13_0)

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, var_13_1)
end

function var_0_0._editableInitView(arg_14_0)
	arg_14_0._progressItems = {}

	for iter_14_0 = 1, 7 do
		arg_14_0._progressItems[iter_14_0] = arg_14_0:createProgress(iter_14_0)
	end
end

function var_0_0.onUpdateParam(arg_15_0)
	arg_15_0:_refreshUI()
	arg_15_0:checkJump()
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0:activeMask(true)
	TaskDispatcher.cancelTask(arg_16_0.hideMask, arg_16_0)
	TaskDispatcher.runDelay(arg_16_0.hideMask, arg_16_0, 1.5)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_hippie_open)

	arg_16_0.levelUpStage = arg_16_0.viewParam and arg_16_0.viewParam.levelUpStage

	if arg_16_0.levelUpStage then
		arg_16_0.viewContainer:getScene():showLevelObjs(arg_16_0.levelUpStage)
	end

	arg_16_0:_refreshUI()
	TaskDispatcher.runDelay(arg_16_0._checkShowEquipSelfChoiceView, arg_16_0, 0.1)
	arg_16_0:checkJump()
end

function var_0_0.checkJump(arg_17_0)
	local var_17_0 = arg_17_0.viewParam and arg_17_0.viewParam.jumpId
	local var_17_1 = arg_17_0.viewParam and arg_17_0.viewParam.jumpParam

	if var_17_0 == Activity104Enum.JumpId.Market then
		Activity104Controller.instance:openSeasonMarketView(var_17_1)
	elseif var_17_0 == Activity104Enum.JumpId.Retail then
		Activity104Controller.instance:openSeasonRetailView(var_17_1)
	elseif var_17_0 == Activity104Enum.JumpId.Discount then
		Activity104Controller.instance:openSeasonSpecialMarketView(var_17_1)
	end
end

function var_0_0._checkShowEquipSelfChoiceView(arg_18_0)
	Activity104Controller.instance:checkShowEquipSelfChoiceView()
end

function var_0_0.onLevelUp(arg_19_0)
	if not arg_19_0.levelUpStage then
		return
	end

	arg_19_0:activeProgressLevup(arg_19_0.levelUpStage, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_symbol_upgrade)

	arg_19_0._passStage = arg_19_0.levelUpStage

	TaskDispatcher.runDelay(arg_19_0._showPassTips, arg_19_0, 0.6)

	arg_19_0.levelUpStage = nil
end

function var_0_0._showPassTips(arg_20_0)
	if arg_20_0._passStage == 7 then
		GameFacade.showToast(ToastEnum.SeasonMarketPassTips2)
	else
		GameFacade.showToast(ToastEnum.SeasonMarketPassTips1)
	end
end

function var_0_0._refreshUI(arg_21_0)
	arg_21_0:_refreshMain()
	arg_21_0:_refreshRetail()
	TaskDispatcher.cancelTask(arg_21_0._refreshMain, arg_21_0)
	TaskDispatcher.runRepeat(arg_21_0._refreshMain, arg_21_0, 60)
end

local var_0_1 = Vector2(-92.8, -42.3)
local var_0_2 = Vector2(-76.6, -42.3)
local var_0_3 = Vector2(53.3, 15.7)
local var_0_4 = Vector2(72, 16.1)

function var_0_0._refreshMain(arg_22_0)
	local var_22_0 = Activity104Model.instance:getCurSeasonId()
	local var_22_1 = Activity104Model.instance:isSpecialOpen()
	local var_22_2 = Activity104Model.instance:isEnterSpecial()
	local var_22_3 = Activity104Model.instance:getAct104CurLayer()
	local var_22_4 = Activity104Model.instance:getMaxLayer()
	local var_22_5 = SeasonConfig.instance:getSeasonConstCo(var_22_0, Activity104Enum.ConstEnum.SpecialOpenLayer)
	local var_22_6 = var_22_5 and var_22_5.value1 or 0
	local var_22_7 = var_22_6 < var_22_3

	gohelper.setActive(arg_22_0._godiscount, var_22_1)
	gohelper.setActive(arg_22_0._godiscountlock, var_22_2 or var_22_7)

	if not var_22_1 then
		if var_22_7 then
			local var_22_8 = SeasonConfig.instance:getSeasonConstCo(var_22_0, Activity104Enum.ConstEnum.SpecialOpenDayCount).value1 - 1
			local var_22_9 = ActivityModel.instance:getActStartTime(var_22_0) / 1000 + var_22_8 * 86400 - ServerTime.now()
			local var_22_10 = string.format("%s%s", TimeUtil.secondToRoughTime2(var_22_9))

			arg_22_0._txtdiscountunlock.text = string.format(luaLang("seasonmainview_timeopencondition"), var_22_10)
		else
			arg_22_0._txtdiscountunlock.text = string.format(luaLang("seasonmainview_layeropencondition"), var_22_6)
		end
	else
		gohelper.setActive(arg_22_0._godiscountlock, false)
	end

	arg_22_0._txtindex.text = string.format("%02d", var_22_3)

	local var_22_11 = var_22_4 == var_22_3 and var_0_2 or var_0_1
	local var_22_12 = var_22_4 == var_22_3 and var_0_4 or var_0_3

	recthelper.setAnchor(arg_22_0._txtindex.transform, var_22_11.x, var_22_11.y)
	recthelper.setAnchor(arg_22_0._goarrow.transform, var_22_12.x, var_22_12.y)
	gohelper.setActive(arg_22_0._gotop, var_22_4 == var_22_3 and Activity104Model.instance:isLayerPassed(var_22_0, var_22_3))

	local var_22_13 = SeasonConfig.instance:getSeasonEpisodeCo(var_22_0, var_22_3)

	arg_22_0._txtmapname.text = var_22_13.stageName

	local var_22_14 = Activity104Model.instance:getAct104CurStage()

	arg_22_0:activeProgress(7, var_22_14 == 7)

	for iter_22_0, iter_22_1 in ipairs(arg_22_0._progressItems) do
		arg_22_0:updateProgress(iter_22_0, var_22_14)
	end

	local var_22_15 = ActivityModel.instance:getActMO(var_22_0):getRealEndTimeStamp() - ServerTime.now()
	local var_22_16 = Mathf.Floor(var_22_15 / TimeUtil.OneDaySecond)
	local var_22_17 = var_22_15 % TimeUtil.OneDaySecond
	local var_22_18 = Mathf.Floor(var_22_17 / TimeUtil.OneHourSecond)
	local var_22_19 = GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
		var_22_16,
		var_22_18
	})

	arg_22_0._txtunlocktime.text = formatLuaLang("remain", var_22_19)
end

function var_0_0._refreshRetail(arg_23_0)
	local var_23_0 = Activity104Model.instance:getCurSeasonId()
	local var_23_1 = SeasonConfig.instance:getRetailTicket(var_23_0)
	local var_23_2 = CurrencyConfig.instance:getCurrencyCo(var_23_1)
	local var_23_3 = var_23_2 and var_23_2.icon

	if var_23_3 then
		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_23_0._imagecurrencyicon, var_23_3 .. "_1", true)
	end

	local var_23_4 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SeasonRetail)
	local var_23_5 = GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU)
	local var_23_6 = var_23_5 or GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount)

	gohelper.setActive(arg_23_0._goretail, var_23_4 and not var_23_5)

	arg_23_0._retailProcessing = #Activity104Model.instance:getAct104Retails() > 0

	gohelper.setActive(arg_23_0._goassemblying, arg_23_0._retailProcessing)
	gohelper.setActive(arg_23_0._gocurrency, not arg_23_0._retailProcessing)

	if not arg_23_0._retailProcessing then
		local var_23_7 = var_23_2 and var_23_2.recoverLimit
		local var_23_8 = CurrencyModel.instance:getCurrency(var_23_1)
		local var_23_9 = var_23_8 and var_23_8.quantity or 0

		arg_23_0._hasEnoughTicket = var_23_9 >= 1

		local var_23_10 = var_23_9 > 0 and var_23_9 or "<color=#CF4543>" .. var_23_9 .. "</color>"

		arg_23_0._txtcurrencycount.text = string.format("%s/%s", var_23_10, var_23_7)
	end

	gohelper.setActive(arg_23_0._goEnterEffect, not var_23_6)

	if var_23_6 then
		local var_23_11 = gohelper.onceAddComponent(arg_23_0.viewGO, typeof(UnityEngine.Animator))

		if var_23_11 then
			var_23_11:Play(UIAnimationName.Switch, 0, 1.8)
		end
	end
end

function var_0_0._showUTTU(arg_24_0)
	arg_24_0:_refreshRetail()

	local var_24_0 = gohelper.onceAddComponent(arg_24_0._goretail, typeof(UnityEngine.Animator))

	if var_24_0 then
		var_24_0:Play(UIAnimationName.Switch, 0, 0)
	end
end

function var_0_0._onRefreshRetail(arg_25_0)
	arg_25_0:_refreshRetail()
end

function var_0_0._onChangeRetail(arg_26_0, arg_26_1)
	local var_26_0 = Activity104Model.instance:getCurSeasonId()
	local var_26_1 = SeasonConfig.instance:getRetailTicket(var_26_0)

	if not var_26_1 or not arg_26_1[var_26_1] then
		return
	end

	arg_26_0:_refreshRetail()
end

function var_0_0.createProgress(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:getUserDataTb_()

	var_27_0.go = gohelper.findChild(arg_27_0.viewGO, string.format("#go_entrance/progress/#go_progress%s", arg_27_1))
	var_27_0.dark = gohelper.findChild(var_27_0.go, "dark")
	var_27_0.light = gohelper.findChild(var_27_0.go, "light")
	var_27_0.lightImg = var_27_0.light:GetComponent(gohelper.Type_Image)
	var_27_0.leveup = gohelper.findChild(var_27_0.go, "leveup")

	return var_27_0
end

function var_0_0.activeProgress(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0._progressItems[arg_28_1]

	if not var_28_0 then
		return
	end

	gohelper.setActive(var_28_0.go, arg_28_2)
end

function var_0_0.activeProgressLevup(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0._progressItems[arg_29_1]

	if not var_29_0 then
		return
	end

	gohelper.setActive(var_29_0.leveup, arg_29_2)
end

function var_0_0.activeProgressLight(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0._progressItems[arg_30_1]

	if not var_30_0 then
		return
	end

	gohelper.setActive(var_30_0.light, arg_30_2)
end

function var_0_0.updateProgress(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0._progressItems[arg_31_1]

	if not var_31_0 then
		return
	end

	local var_31_1 = arg_31_1 == 7 and "#B83838" or "#FFFFFF"

	SLFramework.UGUI.GuiHelper.SetColor(var_31_0.lightImg, var_31_1)
	gohelper.setActive(var_31_0.light, arg_31_1 <= arg_31_2 and arg_31_0.levelUpStage ~= arg_31_1)
	gohelper.setActive(var_31_0.dark, arg_31_2 < arg_31_1)
end

function var_0_0.onClose(arg_32_0)
	return
end

function var_0_0.onDestroyView(arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0._refreshMain, arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0.hideMask, arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0._showPassTips, arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0._checkShowEquipSelfChoiceView, arg_33_0)
end

return var_0_0
