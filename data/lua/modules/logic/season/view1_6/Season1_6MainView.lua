module("modules.logic.season.view1_6.Season1_6MainView", package.seeall)

slot0 = class("Season1_6MainView", BaseView)

function slot0.onInitView(slot0)
	slot0._goreadprocess = gohelper.findChild(slot0.viewGO, "leftbtns/#go_readprocess")
	slot0._btnreadprocess = gohelper.findChildButtonWithAudio(slot0.viewGO, "leftbtns/#go_readprocess/#btn_readprocess")
	slot0._gotask = gohelper.findChild(slot0.viewGO, "leftbtns/#go_task")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "leftbtns/#go_task/#btn_task")
	slot0._gotaskreddot = gohelper.findChild(slot0.viewGO, "leftbtns/#go_task/#go_taskreddot")
	slot0._gocelebrity = gohelper.findChild(slot0.viewGO, "rightbtns/#go_celebrity")
	slot0._btncelebrity = gohelper.findChildButtonWithAudio(slot0.viewGO, "rightbtns/#go_celebrity/#btn_celebrity")
	slot0._goretail = gohelper.findChild(slot0.viewGO, "rightbtns/#go_retail")
	slot0._gocurrency = gohelper.findChild(slot0.viewGO, "rightbtns/#go_retail/#go_currency")
	slot0._imagecurrencyicon = gohelper.findChildImage(slot0.viewGO, "rightbtns/#go_retail/#go_currency/#image_currencyicon")
	slot0._btncurrencyicon = gohelper.findChildButtonWithAudio(slot0.viewGO, "rightbtns/#go_retail/#go_currency/#image_currencyicon")
	slot0._txtcurrencycount = gohelper.findChildText(slot0.viewGO, "rightbtns/#go_retail/#go_currency/#txt_currencycount")
	slot0._btnretail = gohelper.findChildButtonWithAudio(slot0.viewGO, "rightbtns/#go_retail/#btn_retail")
	slot0._goassemblying = gohelper.findChild(slot0.viewGO, "rightbtns/#go_retail/#go_assemblying")
	slot0._gotitle = gohelper.findChild(slot0.viewGO, "#go_title")
	slot0._txtunlocktime = gohelper.findChildText(slot0.viewGO, "#go_title/txt_unlocktime")
	slot0._goentrance = gohelper.findChild(slot0.viewGO, "#go_entrance")
	slot0._gotop = gohelper.findChild(slot0.viewGO, "#go_entrance/#go_top")
	slot0._txtindex = gohelper.findChildText(slot0.viewGO, "#go_entrance/#txt_index")
	slot0._txtmapname = gohelper.findChildText(slot0.viewGO, "#go_entrance/#txt_mapname")
	slot0._btnentrance = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_entrance/#btn_entrance", AudioEnum.UI.play_ui_leimi_biguncharted_open)
	slot0._godiscount = gohelper.findChild(slot0.viewGO, "#go_discount")
	slot0._btndiscount = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_discount/#btn_discount")
	slot0._godiscountlock = gohelper.findChild(slot0.viewGO, "#go_discount_lock")
	slot0._txtdiscountunlock = gohelper.findChildText(slot0.viewGO, "#go_discount_lock/#txt_discountunlock")
	slot0._btndiscountlock = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_discount_lock/#btn_discountlock")
	slot0._goMask = gohelper.findChild(slot0.viewGO, "#go_mask")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#go_entrance/decorates/#go_arrow")
	slot0._animationEvent = slot0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	slot0._goEnterEffect = gohelper.findChild(slot0.viewGO, "eff")

	RedDotController.instance:addRedDot(slot0._gotaskreddot, RedDotEnum.DotNode.SeasonTaskLevel)

	slot0._goletter = gohelper.findChild(slot0.viewGO, "#go_letter")
	slot0._btnletter = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_letter/#btn_try")
	slot0._gotry = gohelper.findChild(slot0.viewGO, "#go_try")
	slot0._trialTxtNameen = gohelper.findChildTextMesh(slot0._gotry, "#txt_characteren")
	slot0._trialTxtNamecn = gohelper.findChildTextMesh(slot0._gotry, "#txt_charactercn")
	slot0._btntrial = gohelper.findChildButtonWithAudio(slot0._gotry, "#btn_try")
	slot0._trialCardGo = gohelper.findChild(slot0._gotry, "#go_card")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreadprocess:AddClickListener(slot0._btnreadprocessOnClick, slot0)
	slot0._btntask:AddClickListener(slot0._btntaskOnClick, slot0)
	slot0._btncelebrity:AddClickListener(slot0._btncelebrityOnClick, slot0)
	slot0._btnretail:AddClickListener(slot0._btnretailOnClick, slot0)
	slot0._btnentrance:AddClickListener(slot0._btnentranceOnClick, slot0)
	slot0._btndiscount:AddClickListener(slot0._btndiscountOnClick, slot0)
	slot0._btndiscountlock:AddClickListener(slot0._btndiscountlockOnClick, slot0)
	slot0._btncurrencyicon:AddClickListener(slot0._btncurrencyiconOnClick, slot0)
	slot0._btnletter:AddClickListener(slot0._btnletterOnClick, slot0)
	slot0._btntrial:AddClickListener(slot0._btntrialOnClick, slot0)
	slot0._animationEvent:AddEventListener("levelup", slot0.onLevelUp, slot0)
	slot0:addEventCb(Activity104Controller.instance, Activity104Event.RefreshRetail, slot0._onRefreshRetail, slot0)
	slot0:addEventCb(GuideController.instance, GuideEvent.SeasonShowUTTU, slot0._showUTTU, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onChangeRetail, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreadprocess:RemoveClickListener()
	slot0._btntask:RemoveClickListener()
	slot0._btncelebrity:RemoveClickListener()
	slot0._btnretail:RemoveClickListener()
	slot0._btnentrance:RemoveClickListener()
	slot0._btndiscount:RemoveClickListener()
	slot0._btndiscountlock:RemoveClickListener()
	slot0._btncurrencyicon:RemoveClickListener()
	slot0._btnletter:RemoveClickListener()
	slot0._btntrial:RemoveClickListener()
	slot0._animationEvent:RemoveEventListener("levelup")
	slot0:removeEventCb(Activity104Controller.instance, Activity104Event.RefreshRetail, slot0._onRefreshRetail, slot0)
	slot0:removeEventCb(GuideController.instance, GuideEvent.SeasonShowUTTU, slot0._showUTTU, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onChangeRetail, slot0)
end

function slot0.hideMask(slot0)
	gohelper.setActive(slot0._goMask, false)

	if Activity104Model.instance:getIsPopSummary(Activity104Model.instance:getCurSeasonId()) and Activity104Model.instance:getLastMaxLayer(slot1) > 0 then
		Activity104Controller.instance:openSeasonSumView()
	else
		Activity104Controller.instance:dispatchEvent(Activity104Event.EnterSeasonMainView)
	end
end

function slot0.activeMask(slot0, slot1)
	gohelper.setActive(slot0._goMask, slot1)
end

function slot0._btnletterOnClick(slot0)
	Activity104Controller.instance:openSeasonSumView()
end

function slot0._btntrialOnClick(slot0)
	slot1 = Activity104Model.instance:getCurSeasonId()

	if SeasonConfig.instance:getTrialConfig(slot1, Activity104Model.instance:getTrialId(slot1)) then
		Activity104Model.instance:enterAct104Battle(slot3.episodeId, slot2)
	end
end

function slot0.onTrialBattleReply(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	Activity104Model.instance:onStartAct104BattleReply(slot3)
end

function slot0._btndiscountOnClick(slot0)
	Activity104Controller.instance:openSeasonSpecialMarketView()
end

function slot0._btndiscountlockOnClick(slot0)
	if not string.nilorempty(slot0._discountLockTipsStr) then
		ToastController.instance:showToastWithString(slot0._discountLockTipsStr)
	end
end

function slot0._btnretailOnClick(slot0)
	Activity104Controller.instance:openSeasonRetailView()
end

function slot0._btnentranceOnClick(slot0)
	Activity104Controller.instance:openSeasonMarketView()
end

function slot0._btnreadprocessOnClick(slot0)
	Activity104Controller.instance:openSeasonStoreView()
end

function slot0._btntaskOnClick(slot0)
	Activity104Controller.instance:openSeasonTaskView()
end

function slot0._btncelebrityOnClick(slot0)
	Activity104Controller.instance:openSeasonCardBook()
end

function slot0._btncurrencyiconOnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, SeasonConfig.instance:getRetailTicket(Activity104Model.instance:getCurSeasonId()))
end

function slot0._editableInitView(slot0)
	slot0._progressItems = {}

	for slot5 = 1, 7 do
		slot0._progressItems[slot5] = slot0:createProgress(slot5, gohelper.findChild(slot0.viewGO, "#go_entrance/progress"))
	end
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshUI()
	slot0:checkJump()
end

function slot0.onOpen(slot0)
	slot0:activeMask(true)
	TaskDispatcher.cancelTask(slot0.hideMask, slot0)
	TaskDispatcher.runDelay(slot0.hideMask, slot0, 1.5)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_hippie_open)

	slot0.levelUpStage = slot0.viewParam and slot0.viewParam.levelUpStage

	if slot0.levelUpStage then
		slot0.viewContainer:getScene():showLevelObjs(slot0.levelUpStage)
	end

	slot0:_refreshUI()
	TaskDispatcher.runDelay(slot0._checkShowEquipSelfChoiceView, slot0, 0.1)
	slot0:checkJump()
end

function slot0.checkJump(slot0)
	if (slot0.viewParam and slot0.viewParam.jumpId) == Activity104Enum.JumpId.Market then
		Activity104Controller.instance:openSeasonMarketView(slot0.viewParam and slot0.viewParam.jumpParam)
	elseif slot1 == Activity104Enum.JumpId.Retail then
		Activity104Controller.instance:openSeasonRetailView(slot2)
	elseif slot1 == Activity104Enum.JumpId.Discount then
		Activity104Controller.instance:openSeasonSpecialMarketView(slot2)
	end
end

function slot0._checkShowEquipSelfChoiceView(slot0)
	Activity104Controller.instance:checkShowEquipSelfChoiceView()
end

function slot0.onLevelUp(slot0)
	if not slot0.levelUpStage then
		return
	end

	slot0:activeProgressLevup(slot0.levelUpStage, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_symbol_upgrade)

	slot0._passStage = slot0.levelUpStage

	TaskDispatcher.runDelay(slot0._showPassTips, slot0, 0.6)

	slot0.levelUpStage = nil
end

function slot0._showPassTips(slot0)
	if slot0._passStage == 7 then
		GameFacade.showToast(ToastEnum.SeasonMarketPassTips2)
	else
		GameFacade.showToast(ToastEnum.SeasonMarketPassTips1)
	end
end

function slot0._refreshUI(slot0)
	slot0:_refreshMain()
	slot0:_refreshRetail()
	TaskDispatcher.cancelTask(slot0._refreshMain, slot0)
	TaskDispatcher.runRepeat(slot0._refreshMain, slot0, 60)
end

slot1 = Vector2(-92.8, -42.3)
slot2 = Vector2(-76.6, -42.3)
slot3 = Vector2(53.3, 15.7)
slot4 = Vector2(72, 16.1)

function slot0._refreshMain(slot0)
	slot2 = Activity104Model.instance:isSpecialOpen()
	slot5 = Activity104Model.instance:getMaxLayer()

	gohelper.setActive(slot0._godiscount, slot2)
	gohelper.setActive(slot0._godiscountlock, Activity104Model.instance:isEnterSpecial() or Activity104Model.instance:getAct104CurLayer() > (SeasonConfig.instance:getSeasonConstCo(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ConstEnum.SpecialOpenLayer) and slot6.value1 or 0))

	slot0._discountLockTipsStr = ""

	if not slot2 then
		if slot8 then
			slot0._txtdiscountunlock.text = string.format(luaLang("seasonmainview_timeopencondition"), string.format("%s%s", TimeUtil.secondToRoughTime2(ActivityModel.instance:getActStartTime(slot1) / 1000 + (SeasonConfig.instance:getSeasonConstCo(slot1, Activity104Enum.ConstEnum.SpecialOpenDayCount).value1 - 1) * 86400 - ServerTime.now())))
		else
			slot0._txtdiscountunlock.text = string.format(luaLang("seasonmainview_layeropencondition"), slot7)
		end

		slot0._discountLockTipsStr = slot0._txtdiscountunlock.text
	else
		gohelper.setActive(slot0._godiscountlock, false)
	end

	slot0._txtindex.text = string.format("%02d", slot4)
	slot9 = slot5 == slot4 and uv0 or uv1
	slot10 = slot5 == slot4 and uv2 or uv3

	recthelper.setAnchor(slot0._txtindex.transform, slot9.x, slot9.y)
	recthelper.setAnchor(slot0._goarrow.transform, slot10.x, slot10.y)
	gohelper.setActive(slot0._gotop, slot5 == slot4 and Activity104Model.instance:isLayerPassed(slot1, slot4))

	slot0._txtmapname.text = SeasonConfig.instance:getSeasonEpisodeCo(slot1, slot4).stageName

	slot0:activeProgress(slot0._progressItems[7], Activity104Model.instance:getAct104CurStage() == 7)

	for slot16, slot17 in ipairs(slot0._progressItems) do
		slot0:updateProgress(slot17, slot12)
	end

	slot14 = ActivityModel.instance:getActMO(slot1):getRealEndTimeStamp() - ServerTime.now()
	slot0._txtunlocktime.text = formatLuaLang("remain", GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
		Mathf.Floor(slot14 / TimeUtil.OneDaySecond),
		Mathf.Floor(slot14 % TimeUtil.OneDaySecond / TimeUtil.OneHourSecond)
	}))

	slot0:refreshTrial()
end

function slot0.refreshTrial(slot0)
	slot1 = Activity104Model.instance:getCurSeasonId()

	if SeasonConfig.instance:getTrialConfig(slot1, Activity104Model.instance:getTrialId(slot1)) then
		gohelper.setActive(slot0._gotry, true)

		slot5 = SeasonConfig.instance:getSeasonEpisodeCo(slot1, slot3.unlockLayer).stage

		if not slot0._trialProgressItems then
			slot0._trialProgressItems = {}

			for slot10 = 1, 7 do
				slot0._trialProgressItems[slot10] = slot0:createProgress(slot10, gohelper.findChild(slot0._gotry, "progress"))
			end
		end

		slot0:activeProgress(slot0._trialProgressItems[7], slot5 == 7)

		for slot9, slot10 in ipairs(slot0._trialProgressItems) do
			slot0:updateProgress(slot10, slot5)
		end

		slot0._trialTxtNameen.text = slot3.nameEn
		slot0._trialTxtNamecn.text = slot3.name
		slot7 = DungeonConfig.instance:getEpisodeCO(slot3.episodeId) and slot6.battleId

		if not slot0.trialCardItem then
			slot0.trialCardItem = Season1_6CelebrityCardItem.New()

			slot0.trialCardItem:init(slot0._trialCardGo, (slot7 and lua_battle.configDict[slot7]).trialMainAct104EuqipId, {
				noClick = true
			})
		else
			slot0.trialCardItem:reset(slot8.trialMainAct104EuqipId)
		end
	else
		gohelper.setActive(slot0._gotry, false)
	end
end

function slot0._refreshRetail(slot0)
	if CurrencyConfig.instance:getCurrencyCo(SeasonConfig.instance:getRetailTicket(Activity104Model.instance:getCurSeasonId())) and slot3.icon then
		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagecurrencyicon, slot4 .. "_1", true)
	end

	slot7 = GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount)

	gohelper.setActive(slot0._goretail, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SeasonRetail) and not slot6)

	slot0._retailProcessing = #Activity104Model.instance:getAct104Retails() > 0

	gohelper.setActive(slot0._goassemblying, slot0._retailProcessing)
	gohelper.setActive(slot0._gocurrency, not slot0._retailProcessing)

	if not slot0._retailProcessing then
		slot10 = CurrencyModel.instance:getCurrency(slot2) and slot9.quantity or 0
		slot0._hasEnoughTicket = slot10 >= 1
		slot0._txtcurrencycount.text = string.format("%s/%s", slot10 > 0 and slot10 or "<color=#CF4543>" .. slot10 .. "</color>", slot3 and slot3.recoverLimit)
	end

	gohelper.setActive(slot0._goEnterEffect, not slot7)
end

function slot0._showUTTU(slot0)
	slot0:_refreshRetail()

	if gohelper.onceAddComponent(slot0._goretail, typeof(UnityEngine.Animator)) then
		slot1:Play(UIAnimationName.Switch, 0, 0)
	end
end

function slot0._onRefreshRetail(slot0)
	slot0:_refreshRetail()
end

function slot0._onChangeRetail(slot0, slot1)
	if not SeasonConfig.instance:getRetailTicket(Activity104Model.instance:getCurSeasonId()) or not slot1[slot3] then
		return
	end

	slot0:_refreshRetail()
end

function slot0.createProgress(slot0, slot1, slot2)
	slot3 = slot0:getUserDataTb_()
	slot3.index = slot1
	slot3.go = gohelper.findChild(slot2, string.format("#go_progress%s", slot1))
	slot3.dark = gohelper.findChild(slot3.go, "dark")
	slot3.light = gohelper.findChild(slot3.go, "light")
	slot3.lightImg = slot3.light:GetComponent(gohelper.Type_Image)
	slot3.leveup = gohelper.findChild(slot3.go, "leveup")

	return slot3
end

function slot0.activeProgress(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	gohelper.setActive(slot1.go, slot2)
end

function slot0.activeProgressLevup(slot0, slot1, slot2)
	if not slot0._progressItems[slot1] then
		return
	end

	gohelper.setActive(slot3.leveup, slot2)
end

function slot0.activeProgressLight(slot0, slot1, slot2)
	if not slot0._progressItems[slot1] then
		return
	end

	gohelper.setActive(slot3.light, slot2)
end

function slot0.updateProgress(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	SLFramework.UGUI.GuiHelper.SetColor(slot1.lightImg, slot1.index == 7 and "#B83838" or "#FFFFFF")
	gohelper.setActive(slot1.light, slot3 <= slot2 and slot0.levelUpStage ~= slot3)
	gohelper.setActive(slot1.dark, slot2 < slot3)
end

function slot0.onTrialBattle(slot0, slot1)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._refreshMain, slot0)
	TaskDispatcher.cancelTask(slot0.hideMask, slot0)
	TaskDispatcher.cancelTask(slot0._showPassTips, slot0)
	TaskDispatcher.cancelTask(slot0._checkShowEquipSelfChoiceView, slot0)
end

return slot0
