module("modules.logic.season.view3_0.Season3_0RetailView", package.seeall)

local var_0_0 = class("Season3_0RetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnsummon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_summon/#btn_summon")
	arg_1_0._txtpropnum = gohelper.findChildText(arg_1_0.viewGO, "right/#go_summon/#go_currency/#txt_propnum")
	arg_1_0._imagecurrencyicon = gohelper.findChildImage(arg_1_0.viewGO, "right/#go_summon/#go_currency/#image_currencyicon")
	arg_1_0._btncurrencyicon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_summon/#go_currency/#image_currencyicon")
	arg_1_0._btnruledetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_ruledetail")
	arg_1_0._goruletipdetail = gohelper.findChild(arg_1_0.viewGO, "right/#go_ruletipdetail")
	arg_1_0._btncloseruletip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_ruletipdetail/#btn_closeruletip")
	arg_1_0._goruletips = gohelper.findChild(arg_1_0.viewGO, "right/#go_ruletips")
	arg_1_0._txtruletips = gohelper.findChildText(arg_1_0.viewGO, "right/#go_ruletips/#txt_ruletips")
	arg_1_0._gomaxrarecard = gohelper.findChild(arg_1_0.viewGO, "right/#go_ruletips/#txt_ruletips/#go_maxrarecard")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._txttitletips = gohelper.findChildText(arg_1_0.viewGO, "title/tips/tips")
	arg_1_0._txtsummon1 = gohelper.findChildText(arg_1_0.viewGO, "right/#go_summon/#txt_summon1")
	arg_1_0._txtsummon2 = gohelper.findChildText(arg_1_0.viewGO, "right/#go_summon/circle/#txt_summon2")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "title/progress")
	arg_1_0._animationEvent = arg_1_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	MainCameraMgr.instance:addView(ViewName.Season3_0RetailView, arg_1_0.autoInitRetailViewCamera, nil, arg_1_0)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncurrencyicon:AddClickListener(arg_2_0._btncurrencyiconOnClick, arg_2_0)
	arg_2_0._btnsummon:AddClickListener(arg_2_0._btnsummonOnClick, arg_2_0)
	arg_2_0._btnruledetail:AddClickListener(arg_2_0._btnruledetailOnClick, arg_2_0)
	arg_2_0._btncloseruletip:AddClickListener(arg_2_0._btncloseruletipOnClick, arg_2_0)
	arg_2_0._animationEvent:AddEventListener("switch", arg_2_0.onSwitchCard, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._onChangeRetail, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncurrencyicon:RemoveClickListener()
	arg_3_0._btnsummon:RemoveClickListener()
	arg_3_0._btnruledetail:RemoveClickListener()
	arg_3_0._btncloseruletip:RemoveClickListener()
	arg_3_0._animationEvent:RemoveEventListener("switch")
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._onChangeRetail, arg_3_0)
end

function var_0_0._btnruledetailOnClick(arg_4_0)
	gohelper.setActive(arg_4_0._goruletipdetail, true)
end

function var_0_0._btncloseruletipOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._goruletipdetail, false)
end

function var_0_0._btncurrencyiconOnClick(arg_6_0)
	local var_6_0 = Activity104Model.instance:getCurSeasonId()
	local var_6_1 = SeasonConfig.instance:getRetailTicket(var_6_0)

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, var_6_1)
end

function var_0_0._enterLevelInfoView(arg_7_0, arg_7_1)
	local var_7_0 = Activity104Model.instance:getAct104Retails()

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		if iter_7_1.position == arg_7_1 then
			local var_7_1 = {
				retail = iter_7_1
			}

			Activity104Controller.instance:openSeasonRetailLevelInfoView(var_7_1)

			return
		end
	end
end

function var_0_0._btnsummonOnClick(arg_8_0)
	if arg_8_0._waitRefreshingRetailReply then
		return
	end

	if arg_8_0._hasEnoughTicket then
		local function var_8_0(arg_9_0)
			local var_9_0 = Activity104Model.instance:getCurSeasonId()

			Activity104Rpc.instance:sendRefreshRetailRequest(var_9_0)

			arg_9_0._waitRefreshingRetailReply = false
		end

		local var_8_1 = Activity104Model.instance:getAct104Retails()

		if tabletool.len(var_8_1) == 0 then
			var_8_0(arg_8_0)
		else
			GameFacade.showMessageBox(MessageBoxIdDefine.SeasonRetailTicketLimited, MsgBoxEnum.BoxType.Yes_No, var_8_0, nil, nil, arg_8_0)
		end
	else
		GameFacade.showToast(ToastEnum.SeasonReadCountLimitedAndWait)
	end
end

function var_0_0._editableInitView(arg_10_0)
	return
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	if arg_12_0.viewParam then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_smalluncharted_return)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_smalluncharted_open)
	end

	arg_12_0._waitRefreshingRetailReply = false

	arg_12_0:addEventCb(Activity104Controller.instance, Activity104Event.RefreshRetail, arg_12_0._onRefreshRetailSuccess, arg_12_0)
	arg_12_0:_refreshLevel()
	arg_12_0:_refreshTitle()
	arg_12_0:_refreshConstTips()
end

function var_0_0._refreshConstTips(arg_13_0)
	local var_13_0, var_13_1, var_13_2 = Activity104Model.instance:caleRetailEquipRareWeight()

	if var_13_2 == 0 then
		gohelper.setActive(arg_13_0._goruletips, false)

		return
	end

	gohelper.setActive(arg_13_0._goruletips, true)

	if not arg_13_0._rareCard then
		arg_13_0._rareCard = Season3_0CelebrityCardItem.New()

		arg_13_0._rareCard:init(arg_13_0._gomaxrarecard)
	end

	arg_13_0._rareCard:reset(var_13_2)

	local var_13_3 = math.floor(var_13_0 * 100)
	local var_13_4 = {
		luaLang("seasonretailview_rare_" .. var_13_1),
		var_13_3
	}

	arg_13_0._txtruletips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("seasonretailview_rule1"), var_13_4)
end

function var_0_0._onRefreshRetailSuccess(arg_14_0)
	arg_14_0._waitRefreshingRetailReply = false

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_smalluncharted_refresh)
	arg_14_0.viewContainer:playAnim(UIAnimationName.Switch, 0, 0)
end

function var_0_0.onSwitchCard(arg_15_0)
	arg_15_0:_refreshLevel()
	arg_15_0:_refreshTitle()
end

function var_0_0._refreshTitle(arg_16_0)
	local var_16_0 = Activity104Model.instance:getCurSeasonId()
	local var_16_1 = SeasonConfig.instance:getRetailTicket(var_16_0)
	local var_16_2 = CurrencyConfig.instance:getCurrencyCo(var_16_1).icon

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_16_0._imagecurrencyicon, var_16_2 .. "_1", true)
	arg_16_0:_setStages()
end

function var_0_0._setStages(arg_17_0)
	local var_17_0 = Activity104Model.instance:getAct104CurStage()
	local var_17_1 = Activity104Model.instance:getMaxStage()

	if not arg_17_0.starComp then
		arg_17_0.starComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_17_0._goprogress, SeasonStarProgressComp)
	end

	arg_17_0.starComp:refreshStar("#go_progress", var_17_0, var_17_1)
end

function var_0_0._refreshLevel(arg_18_0)
	arg_18_0:_refreshTicket()
	arg_18_0:_showEntrance()
end

function var_0_0._refreshTicket(arg_19_0)
	local var_19_0 = Activity104Model.instance:getCurSeasonId()
	local var_19_1 = SeasonConfig.instance:getRetailTicket(var_19_0)
	local var_19_2 = CurrencyConfig.instance:getCurrencyCo(var_19_1).recoverLimit
	local var_19_3 = CurrencyModel.instance:getCurrency(var_19_1).quantity

	arg_19_0._hasEnoughTicket = var_19_3 >= 1

	local var_19_4 = var_19_3 == 0 and "<color=#CF4543>" .. var_19_3 .. "</color>/" .. var_19_2 or var_19_3 .. "/" .. var_19_2

	arg_19_0._txtpropnum.text = var_19_4
end

function var_0_0._onChangeRetail(arg_20_0, arg_20_1)
	local var_20_0 = Activity104Model.instance:getCurSeasonId()
	local var_20_1 = SeasonConfig.instance:getRetailTicket(var_20_0)

	if not var_20_1 or not arg_20_1[var_20_1] then
		return
	end

	arg_20_0:_refreshTicket()
end

local var_0_1 = {
	targetFlagUIPosX = -25.9,
	targetFlagUIScale = 2.3,
	targetFlagUIPosY = 19.5,
	showNewFlag2 = false
}

function var_0_0._showEntrance(arg_21_0)
	arg_21_0:_initRetailItemList()

	local var_21_0 = Activity104Model.instance:getAct104Retails()
	local var_21_1 = #var_21_0

	for iter_21_0, iter_21_1 in pairs(var_21_0) do
		arg_21_0:_refreshRetailEpisode(iter_21_1)
	end

	if var_21_1 == 0 then
		arg_21_0._txttitletips.text = luaLang("seasonretailview_unrefreshlevel")
		arg_21_0._txtsummon1.text = luaLang("p_seasonretailview_search")
		arg_21_0._txtsummon2.text = luaLang("p_seasonretailview_search")
	else
		arg_21_0._txttitletips.text = luaLang("p_seasonretailview_tips")
		arg_21_0._txtsummon1.text = luaLang("p_seasonsecretlandview_btnsummon")
		arg_21_0._txtsummon2.text = luaLang("p_seasonsecretlandview_btnsummon")
	end
end

function var_0_0._initRetailItemList(arg_22_0)
	if not arg_22_0._retailItemList then
		arg_22_0._retailItemList = {}

		for iter_22_0 = 1, 6 do
			arg_22_0._retailItemList[iter_22_0] = arg_22_0:_createRetailItem(iter_22_0)
		end
	end

	for iter_22_1, iter_22_2 in ipairs(arg_22_0._retailItemList) do
		gohelper.setActive(iter_22_2.go, false)
	end
end

function var_0_0._createRetailItem(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getUserDataTb_()

	var_23_0.index = arg_23_1
	var_23_0.go = gohelper.findChild(arg_23_0.viewGO, string.format("#go_entrance%s", arg_23_1))
	var_23_0.goitem = gohelper.findChild(var_23_0.go, string.format("#go_item%s", arg_23_1))
	var_23_0.txtlevelnum = gohelper.findChildText(var_23_0.goitem, string.format("mask/#txt_levelnum%s", arg_23_1))
	var_23_0.btngo = gohelper.findChildButtonWithAudio(var_23_0.goitem, string.format("#btn_go%s", arg_23_1))
	var_23_0.gorewards = gohelper.findChild(var_23_0.goitem, string.format("#go_rewards%s", arg_23_1))
	var_23_0.cardRoot = gohelper.findChild(var_23_0.gorewards, string.format("rewardlist/#scroll_celebritycard%s/scrollcontent_seasoncelebritycarditem", arg_23_1))
	var_23_0.gotag = gohelper.findChild(var_23_0.goitem, string.format("#go_tag%s", arg_23_1))
	var_23_0.gonormaltips = gohelper.findChild(var_23_0.goitem, string.format("#go_normaltips%s", arg_23_1))
	var_23_0.gospecialtips = gohelper.findChild(var_23_0.goitem, string.format("#go_specialtips%s", arg_23_1))
	var_23_0.txtspecialtips = gohelper.findChildText(var_23_0.gospecialtips, "bg/tips")

	var_23_0.btngo:AddClickListener(arg_23_0._enterLevelInfoView, arg_23_0, arg_23_1)

	return var_23_0
end

function var_0_0._refreshRetailEpisode(arg_24_0, arg_24_1)
	if not arg_24_1 then
		return
	end

	local var_24_0 = arg_24_1.position
	local var_24_1 = arg_24_0._retailItemList[var_24_0]

	if not var_24_1 then
		logError(string.format("no find retail episode position, episodeId:%s  position:%s", arg_24_1.id, var_24_0))

		return
	end

	gohelper.setActive(var_24_1.go, true)

	local var_24_2 = Activity104Model.instance:getCurSeasonId()
	local var_24_3 = SeasonConfig.instance:getSeasonRetailEpisodeCo(var_24_2, arg_24_1.id)
	local var_24_4 = arg_24_1.advancedId
	local var_24_5 = arg_24_1.advancedRare

	var_24_1.txtlevelnum.text = var_24_3 and var_24_3.desc or ""

	gohelper.setActive(var_24_1.gonormaltips, var_24_4 ~= 0 and var_24_5 == 1)
	gohelper.setActive(var_24_1.gospecialtips, var_24_4 ~= 0 and var_24_5 == 2)

	if var_24_4 ~= 0 and var_24_5 == 2 then
		local var_24_6 = ""

		for iter_24_0, iter_24_1 in pairs(arg_24_1.showActivity104EquipIds) do
			local var_24_7 = SeasonConfig.instance:getSeasonEquipCo(iter_24_1)

			if var_24_7.isOptional == 1 then
				var_24_6 = var_24_7.name

				break
			end
		end

		var_24_1.txtspecialtips.text = formatLuaLang("season_retail_specialtips", var_24_6)
	end

	if not var_24_1.cardItems then
		var_24_1.cardItems = {}
	end

	for iter_24_2 = 1, 3 do
		local var_24_8 = var_24_1.cardItems[iter_24_2]
		local var_24_9 = arg_24_1.showActivity104EquipIds[iter_24_2]

		if var_24_9 and var_24_9 ~= 0 then
			local var_24_10 = Activity104Model.instance:isNew104Equip(var_24_9)

			if not var_24_8 then
				var_24_8 = Season3_0CelebrityCardItem.New()
				var_0_1.showNewFlag2 = var_24_10

				var_24_8:init(var_24_1.cardRoot, var_24_9, var_0_1)
				var_24_8:showTag(true)

				var_24_1.cardItems[iter_24_2] = var_24_8
			else
				var_24_8:reset(var_24_9)
				var_24_8:showNewFlag2(var_24_10)
			end
		elseif var_24_8 then
			var_24_8:setVisible(false)
		end
	end
end

function var_0_0.onClose(arg_25_0)
	Activity104Controller.instance:dispatchEvent(Activity104Event.ChangeCameraSize, false)
	arg_25_0:removeEventCb(Activity104Controller.instance, Activity104Event.RefreshRetail, arg_25_0._onRefreshRetailSuccess, arg_25_0)
end

function var_0_0.autoInitRetailViewCamera(arg_26_0)
	Activity104Controller.instance:dispatchEvent(Activity104Event.ChangeCameraSize, true)
end

function var_0_0.onDestroyView(arg_27_0)
	if arg_27_0._retailItemList then
		for iter_27_0, iter_27_1 in pairs(arg_27_0._retailItemList) do
			iter_27_1.btngo:RemoveClickListener()

			if iter_27_1.cardItems then
				for iter_27_2, iter_27_3 in pairs(iter_27_1.cardItems) do
					iter_27_3:destroy()
				end
			end
		end
	end
end

return var_0_0
