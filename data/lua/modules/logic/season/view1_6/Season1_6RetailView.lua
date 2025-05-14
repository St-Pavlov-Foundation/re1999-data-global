module("modules.logic.season.view1_6.Season1_6RetailView", package.seeall)

local var_0_0 = class("Season1_6RetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goentrance1 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance1")
	arg_1_0._goitem1 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance1/#go_item1")
	arg_1_0._txtlevelnum1 = gohelper.findChildText(arg_1_0.viewGO, "#go_entrance1/#go_item1/mask/#txt_levelnum1")
	arg_1_0._btngo1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_entrance1/#go_item1/#btn_go1")
	arg_1_0._gorewards1 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance1/#go_item1/#go_rewards1")
	arg_1_0._scrollcelebritycard1 = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_entrance1/#go_item1/#go_rewards1/rewardlist/#scroll_celebritycard1")
	arg_1_0._gotag1 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance1/#go_item1/#go_tag1")
	arg_1_0._gonormaltips1 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance1/#go_item1/#go_normaltips1")
	arg_1_0._gospecialtips1 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance1/#go_item1/#go_specialtips1")
	arg_1_0._goentrance2 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance2")
	arg_1_0._goitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance2/#go_item2")
	arg_1_0._txtlevelnum2 = gohelper.findChildText(arg_1_0.viewGO, "#go_entrance2/#go_item2/mask/#txt_levelnum2")
	arg_1_0._btngo2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_entrance2/#go_item2/#btn_go2")
	arg_1_0._gorewards2 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance2/#go_item2/#go_rewards2")
	arg_1_0._scrollcelebritycard2 = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_entrance2/#go_item2/#go_rewards2/rewardlist/#scroll_celebritycard2")
	arg_1_0._gotag2 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance2/#go_item2/#go_tag2")
	arg_1_0._gonormaltips2 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance2/#go_item2/#go_normaltips2")
	arg_1_0._gospecialtips2 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance2/#go_item2/#go_specialtips2")
	arg_1_0._goentrance3 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance3")
	arg_1_0._goitem3 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance3/#go_item3")
	arg_1_0._txtlevelnum3 = gohelper.findChildText(arg_1_0.viewGO, "#go_entrance3/#go_item3/mask/#txt_levelnum3")
	arg_1_0._btngo3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_entrance3/#go_item3/#btn_go3")
	arg_1_0._gorewards3 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance3/#go_item3/#go_rewards3")
	arg_1_0._scrollcelebritycard3 = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_entrance3/#go_item3/#go_rewards3/rewardlist/#scroll_celebritycard3")
	arg_1_0._gotag3 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance3/#go_item3/#go_tag3")
	arg_1_0._gonormaltips3 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance3/#go_item3/#go_normaltips3")
	arg_1_0._gospecialtips3 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance3/#go_item3/#go_specialtips3")
	arg_1_0._goentrance4 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance4")
	arg_1_0._goitem4 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance4/#go_item4")
	arg_1_0._txtlevelnum4 = gohelper.findChildText(arg_1_0.viewGO, "#go_entrance4/#go_item4/mask/#txt_levelnum4")
	arg_1_0._btngo4 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_entrance4/#go_item4/#btn_go4")
	arg_1_0._gorewards4 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance4/#go_item4/#go_rewards4")
	arg_1_0._scrollcelebritycard4 = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_entrance4/#go_item4/#go_rewards4/rewardlist/#scroll_celebritycard4")
	arg_1_0._gotag4 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance4/#go_item4/#go_tag4")
	arg_1_0._gonormaltips4 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance4/#go_item4/#go_normaltips4")
	arg_1_0._gospecialtips4 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance4/#go_item4/#go_specialtips4")
	arg_1_0._goentrance5 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance5")
	arg_1_0._goitem5 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance5/#go_item5")
	arg_1_0._txtlevelnum5 = gohelper.findChildText(arg_1_0.viewGO, "#go_entrance5/#go_item5/mask/#txt_levelnum5")
	arg_1_0._btngo5 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_entrance5/#go_item5/#btn_go5")
	arg_1_0._gorewards5 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance5/#go_item5/#go_rewards5")
	arg_1_0._scrollcelebritycard5 = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_entrance5/#go_item5/#go_rewards5/rewardlist/#scroll_celebritycard5")
	arg_1_0._gotag5 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance5/#go_item5/#go_tag5")
	arg_1_0._gonormaltips5 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance5/#go_item5/#go_normaltips5")
	arg_1_0._gospecialtips5 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance5/#go_item5/#go_specialtips5")
	arg_1_0._goentrance6 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance6")
	arg_1_0._goitem6 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance6/#go_item6")
	arg_1_0._txtlevelnum6 = gohelper.findChildText(arg_1_0.viewGO, "#go_entrance6/#go_item6/mask/#txt_levelnum6")
	arg_1_0._btngo6 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_entrance6/#go_item6/#btn_go6")
	arg_1_0._gorewards6 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance6/#go_item6/#go_rewards6")
	arg_1_0._scrollcelebritycard6 = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_entrance6/#go_item6/#go_rewards6/rewardlist/#scroll_celebritycard6")
	arg_1_0._gotag6 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance6/#go_item6/#go_tag6")
	arg_1_0._gonormaltips6 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance6/#go_item6/#go_normaltips6")
	arg_1_0._gospecialtips6 = gohelper.findChild(arg_1_0.viewGO, "#go_entrance6/#go_item6/#go_specialtips6")
	arg_1_0._btnsummon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_summon/#btn_summon")
	arg_1_0._txtpropnum = gohelper.findChildText(arg_1_0.viewGO, "right/#go_summon/#go_currency/#txt_propnum")
	arg_1_0._imagecurrencyicon = gohelper.findChildImage(arg_1_0.viewGO, "right/#go_summon/#go_currency/#image_currencyicon")
	arg_1_0._btncurrencyicon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_summon/#go_currency/#image_currencyicon")
	arg_1_0._btnruledetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_ruledetail")
	arg_1_0._goruletipdetail = gohelper.findChild(arg_1_0.viewGO, "right/#go_ruletipdetail")
	arg_1_0._btncloseruletip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_ruletipdetail/#btn_closeruletip")
	arg_1_0._txtruletips = gohelper.findChildText(arg_1_0.viewGO, "right/#go_ruletips/bg/#txt_ruletips")
	arg_1_0._gomaxrarecard = gohelper.findChild(arg_1_0.viewGO, "right/#go_ruletips/bg/#txt_ruletips/#go_maxrarecard")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._txttitletips = gohelper.findChildText(arg_1_0.viewGO, "title/tips/tips")
	arg_1_0._txtsummon1 = gohelper.findChildText(arg_1_0.viewGO, "right/#go_summon/#txt_summon1")
	arg_1_0._txtsummon2 = gohelper.findChildText(arg_1_0.viewGO, "right/#go_summon/circle/#txt_summon2")
	arg_1_0._goprogress1 = gohelper.findChild(arg_1_0.viewGO, "title/progress/#go_progress1")
	arg_1_0._goprogress2 = gohelper.findChild(arg_1_0.viewGO, "title/progress/#go_progress2")
	arg_1_0._goprogress3 = gohelper.findChild(arg_1_0.viewGO, "title/progress/#go_progress3")
	arg_1_0._goprogress4 = gohelper.findChild(arg_1_0.viewGO, "title/progress/#go_progress4")
	arg_1_0._goprogress5 = gohelper.findChild(arg_1_0.viewGO, "title/progress/#go_progress5")
	arg_1_0._goprogress6 = gohelper.findChild(arg_1_0.viewGO, "title/progress/#go_progress6")
	arg_1_0._goprogress7 = gohelper.findChild(arg_1_0.viewGO, "title/progress/#go_progress7")
	arg_1_0._animationEvent = arg_1_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	MainCameraMgr.instance:addView(ViewName.Season1_6RetailView, arg_1_0.autoInitRetailViewCamera, nil, arg_1_0)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btngo1:AddClickListener(arg_2_0._btngo1OnClick, arg_2_0)
	arg_2_0._btngo2:AddClickListener(arg_2_0._btngo2OnClick, arg_2_0)
	arg_2_0._btngo3:AddClickListener(arg_2_0._btngo3OnClick, arg_2_0)
	arg_2_0._btngo4:AddClickListener(arg_2_0._btngo4OnClick, arg_2_0)
	arg_2_0._btngo5:AddClickListener(arg_2_0._btngo5OnClick, arg_2_0)
	arg_2_0._btngo6:AddClickListener(arg_2_0._btngo6OnClick, arg_2_0)
	arg_2_0._btncurrencyicon:AddClickListener(arg_2_0._btncurrencyiconOnClick, arg_2_0)
	arg_2_0._btnsummon:AddClickListener(arg_2_0._btnsummonOnClick, arg_2_0)
	arg_2_0._btnruledetail:AddClickListener(arg_2_0._btnruledetailOnClick, arg_2_0)
	arg_2_0._btncloseruletip:AddClickListener(arg_2_0._btncloseruletipOnClick, arg_2_0)
	arg_2_0._animationEvent:AddEventListener("switch", arg_2_0.onSwitchCard, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._onChangeRetail, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btngo1:RemoveClickListener()
	arg_3_0._btngo2:RemoveClickListener()
	arg_3_0._btngo3:RemoveClickListener()
	arg_3_0._btngo4:RemoveClickListener()
	arg_3_0._btngo5:RemoveClickListener()
	arg_3_0._btngo6:RemoveClickListener()
	arg_3_0._btncurrencyicon:RemoveClickListener()
	arg_3_0._btnsummon:RemoveClickListener()
	arg_3_0._btnruledetail:RemoveClickListener()
	arg_3_0._btncloseruletip:RemoveClickListener()
	arg_3_0._animationEvent:RemoveEventListener("switch")
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._onChangeRetail, arg_3_0)
end

function var_0_0._btngo1OnClick(arg_4_0)
	arg_4_0:_enterLevelInfoView(1)
end

function var_0_0._btngo2OnClick(arg_5_0)
	arg_5_0:_enterLevelInfoView(2)
end

function var_0_0._btngo3OnClick(arg_6_0)
	arg_6_0:_enterLevelInfoView(3)
end

function var_0_0._btngo4OnClick(arg_7_0)
	arg_7_0:_enterLevelInfoView(4)
end

function var_0_0._btngo5OnClick(arg_8_0)
	arg_8_0:_enterLevelInfoView(5)
end

function var_0_0._btngo6OnClick(arg_9_0)
	arg_9_0:_enterLevelInfoView(6)
end

function var_0_0._btnruledetailOnClick(arg_10_0)
	gohelper.setActive(arg_10_0._goruletipdetail, true)
end

function var_0_0._btncloseruletipOnClick(arg_11_0)
	gohelper.setActive(arg_11_0._goruletipdetail, false)
end

function var_0_0._btncurrencyiconOnClick(arg_12_0)
	local var_12_0 = Activity104Model.instance:getCurSeasonId()
	local var_12_1 = SeasonConfig.instance:getRetailTicket(var_12_0)

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, var_12_1)
end

function var_0_0._enterLevelInfoView(arg_13_0, arg_13_1)
	local var_13_0 = Activity104Model.instance:getAct104Retails()

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		if iter_13_1.position == arg_13_1 then
			local var_13_1 = {
				retail = iter_13_1,
				episodeId = iter_13_1.id
			}

			Activity104Controller.instance:openSeasonRetailLevelInfoView(var_13_1)

			return
		end
	end
end

function var_0_0._btnsummonOnClick(arg_14_0)
	if arg_14_0._waitRefreshingRetailReply then
		return
	end

	if arg_14_0._hasEnoughTicket then
		local function var_14_0(arg_15_0)
			local var_15_0 = Activity104Model.instance:getCurSeasonId()

			Activity104Rpc.instance:sendRefreshRetailRequest(var_15_0)

			arg_15_0._waitRefreshingRetailReply = false
		end

		local var_14_1 = Activity104Model.instance:getAct104Retails()

		if tabletool.len(var_14_1) == 0 then
			var_14_0(arg_14_0)
		else
			GameFacade.showMessageBox(MessageBoxIdDefine.SeasonRetailTicketLimited, MsgBoxEnum.BoxType.Yes_No, var_14_0, nil, nil, arg_14_0)
		end
	else
		GameFacade.showToast(ToastEnum.SeasonReadCountLimitedAndWait)
	end
end

function var_0_0._editableInitView(arg_16_0)
	return
end

function var_0_0.onUpdateParam(arg_17_0)
	return
end

function var_0_0.onOpen(arg_18_0)
	if arg_18_0.viewParam then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_smalluncharted_return)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_smalluncharted_open)
	end

	arg_18_0._waitRefreshingRetailReply = false

	arg_18_0:addEventCb(Activity104Controller.instance, Activity104Event.RefreshRetail, arg_18_0._onRefreshRetailSuccess, arg_18_0)

	arg_18_0._rewardCardItems = {}

	for iter_18_0 = 1, 6 do
		arg_18_0._rewardCardItems[iter_18_0] = {}
		arg_18_0._rewardCardItems[iter_18_0].celebrityCards = {}
	end

	arg_18_0:_refreshLevel()
	arg_18_0:_refreshTitle()
	arg_18_0:_refreshConstTips()
end

function var_0_0._refreshConstTips(arg_19_0)
	local var_19_0, var_19_1, var_19_2 = Activity104Model.instance:caleStageEquipRareWeight()

	if var_19_2 ~= 0 then
		if not arg_19_0._rareCard then
			arg_19_0._rareCard = Season1_6CelebrityCardItem.New()

			arg_19_0._rareCard:init(arg_19_0._gomaxrarecard)
		end

		arg_19_0._rareCard:reset(var_19_2)
	end

	local var_19_3 = math.floor(var_19_0 * 100)
	local var_19_4 = {
		luaLang("seasonretailview_rare_" .. var_19_1),
		var_19_3
	}

	arg_19_0._txtruletips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("seasonretailview_rule1"), var_19_4)
end

function var_0_0._onRefreshRetailSuccess(arg_20_0)
	arg_20_0._waitRefreshingRetailReply = false

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_smalluncharted_refresh)
	arg_20_0.viewContainer:playAnim(UIAnimationName.Switch, 0, 0)
end

function var_0_0.onSwitchCard(arg_21_0)
	arg_21_0:_refreshLevel()
	arg_21_0:_refreshTitle()
end

function var_0_0._refreshTitle(arg_22_0)
	local var_22_0 = Activity104Model.instance:getCurSeasonId()
	local var_22_1 = SeasonConfig.instance:getRetailTicket(var_22_0)
	local var_22_2 = CurrencyConfig.instance:getCurrencyCo(var_22_1).icon

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_22_0._imagecurrencyicon, var_22_2 .. "_1", true)
	arg_22_0:_setStages()
end

function var_0_0._setStages(arg_23_0)
	local var_23_0 = Activity104Model.instance:getAct104CurStage()

	gohelper.setActive(arg_23_0._goprogress7, var_23_0 == 7)

	for iter_23_0 = 1, 7 do
		local var_23_1 = gohelper.findChildImage(arg_23_0["_goprogress" .. iter_23_0], "dark")
		local var_23_2 = gohelper.findChildImage(arg_23_0["_goprogress" .. iter_23_0], "light")

		gohelper.setActive(var_23_2.gameObject, iter_23_0 <= var_23_0)
		gohelper.setActive(var_23_1.gameObject, var_23_0 < iter_23_0)

		local var_23_3 = iter_23_0 == 7 and "#B83838" or "#FFFFFF"

		SLFramework.UGUI.GuiHelper.SetColor(var_23_2, var_23_3)
	end
end

function var_0_0._refreshLevel(arg_24_0)
	arg_24_0:_refreshTicket()
	arg_24_0:_showEntrance()
end

function var_0_0._refreshTicket(arg_25_0)
	local var_25_0 = Activity104Model.instance:getCurSeasonId()
	local var_25_1 = SeasonConfig.instance:getRetailTicket(var_25_0)
	local var_25_2 = CurrencyConfig.instance:getCurrencyCo(var_25_1).recoverLimit
	local var_25_3 = CurrencyModel.instance:getCurrency(var_25_1).quantity

	arg_25_0._hasEnoughTicket = var_25_3 >= 1

	local var_25_4 = var_25_3 == 0 and "<color=#CF4543>" .. var_25_3 .. "</color>/" .. var_25_2 or var_25_3 .. "/" .. var_25_2

	arg_25_0._txtpropnum.text = var_25_4
end

function var_0_0._onChangeRetail(arg_26_0, arg_26_1)
	local var_26_0 = Activity104Model.instance:getCurSeasonId()
	local var_26_1 = SeasonConfig.instance:getRetailTicket(var_26_0)

	if not var_26_1 or not arg_26_1[var_26_1] then
		return
	end

	arg_26_0:_refreshTicket()
end

local var_0_1 = {
	targetFlagUIPosX = -25.9,
	targetFlagUIScale = 2.3,
	targetFlagUIPosY = 19.5,
	showNewFlag2 = false
}

function var_0_0._showEntrance(arg_27_0)
	gohelper.setActive(arg_27_0._goentrance1, false)
	gohelper.setActive(arg_27_0._goentrance2, false)
	gohelper.setActive(arg_27_0._goentrance3, false)
	gohelper.setActive(arg_27_0._goentrance4, false)
	gohelper.setActive(arg_27_0._goentrance5, false)
	gohelper.setActive(arg_27_0._goentrance6, false)

	local var_27_0 = Activity104Model.instance:getAct104Retails()
	local var_27_1 = 0
	local var_27_2 = Activity104Model.instance:getCurSeasonId()

	for iter_27_0, iter_27_1 in pairs(var_27_0) do
		var_27_1 = var_27_1 + 1

		gohelper.setActive(arg_27_0["_goentrance" .. iter_27_1.position], true)

		local var_27_3 = math.min(Activity104Model.instance:getAct104CurStage(), 6)
		local var_27_4 = SeasonConfig.instance:getSeasonTagDesc(var_27_2, iter_27_1.tag)

		arg_27_0["_txtlevelnum" .. iter_27_1.position].text = string.format("%s %s", var_27_4.name, GameUtil.getRomanNums(var_27_3))

		gohelper.setActive(arg_27_0["_gonormaltips" .. iter_27_1.position], iter_27_1.advancedId ~= 0 and iter_27_1.advancedRare == 1)
		gohelper.setActive(arg_27_0["_gospecialtips" .. iter_27_1.position], iter_27_1.advancedId ~= 0 and iter_27_1.advancedRare == 2)

		if iter_27_1.advancedId ~= 0 and iter_27_1.advancedRare == 2 then
			local var_27_5 = ""

			for iter_27_2, iter_27_3 in pairs(iter_27_1.showActivity104EquipIds) do
				local var_27_6 = SeasonConfig.instance:getSeasonEquipCo(iter_27_3)

				if var_27_6.isOptional == 1 then
					var_27_5 = var_27_6.name

					break
				end
			end

			gohelper.findChildText(arg_27_0["_gospecialtips" .. iter_27_1.position], "bg/tips").text = string.format(luaLang("season_retail_specialtips"), var_27_5)
		end

		local var_27_7 = gohelper.findChild(arg_27_0["_scrollcelebritycard" .. iter_27_1.position].gameObject, "scrollcontent_seasoncelebritycarditem")

		if #arg_27_0._rewardCardItems[iter_27_1.position].celebrityCards > 0 then
			for iter_27_4, iter_27_5 in pairs(arg_27_0._rewardCardItems[iter_27_1.position].celebrityCards) do
				gohelper.setActive(iter_27_5.go, false)
			end
		end

		for iter_27_6 = 1, 3 do
			local var_27_8 = iter_27_1.showActivity104EquipIds[iter_27_6]
			local var_27_9 = Activity104Model.instance:isNew104Equip(var_27_8)

			if not arg_27_0._rewardCardItems[iter_27_1.position].celebrityCards[iter_27_6] then
				arg_27_0._rewardCardItems[iter_27_1.position].celebrityCards[iter_27_6] = Season1_6CelebrityCardItem.New()
				var_0_1.showNewFlag2 = var_27_9

				arg_27_0._rewardCardItems[iter_27_1.position].celebrityCards[iter_27_6]:init(var_27_7, var_27_8, var_0_1)
				arg_27_0._rewardCardItems[iter_27_1.position].celebrityCards[iter_27_6]:showTag(true)
			else
				local var_27_10 = arg_27_0._rewardCardItems[iter_27_1.position].celebrityCards[iter_27_6]

				gohelper.setActive(var_27_10.go, true)
				var_27_10:reset(var_27_8)
				var_27_10:showNewFlag2(var_27_9)
			end
		end
	end

	if var_27_1 == 0 then
		arg_27_0._txttitletips.text = luaLang("seasonretailview_unrefreshlevel")
		arg_27_0._txtsummon1.text = luaLang("p_seasonretailview_search")
		arg_27_0._txtsummon2.text = luaLang("p_seasonretailview_search")
	else
		arg_27_0._txttitletips.text = luaLang("p_seasonretailview_tips")
		arg_27_0._txtsummon1.text = luaLang("p_seasonsecretlandview_btnsummon")
		arg_27_0._txtsummon2.text = luaLang("p_seasonsecretlandview_btnsummon")
	end
end

function var_0_0.onClose(arg_28_0)
	Activity104Controller.instance:dispatchEvent(Activity104Event.ChangeCameraSize, false)
	arg_28_0:removeEventCb(Activity104Controller.instance, Activity104Event.RefreshRetail, arg_28_0._onRefreshRetailSuccess, arg_28_0)
end

function var_0_0.autoInitRetailViewCamera(arg_29_0)
	Activity104Controller.instance:dispatchEvent(Activity104Event.ChangeCameraSize, true)
end

function var_0_0.onDestroyView(arg_30_0)
	if arg_30_0._rewardCardItems then
		for iter_30_0, iter_30_1 in pairs(arg_30_0._rewardCardItems) do
			for iter_30_2, iter_30_3 in pairs(iter_30_1.celebrityCards) do
				iter_30_3:destroy()
			end
		end

		arg_30_0._rewardCardItems = nil
	end
end

return var_0_0
