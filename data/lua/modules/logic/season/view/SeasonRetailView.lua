module("modules.logic.season.view.SeasonRetailView", package.seeall)

slot0 = class("SeasonRetailView", BaseView)

function slot0.onInitView(slot0)
	slot0._goentrance1 = gohelper.findChild(slot0.viewGO, "#go_entrance1")
	slot0._goitem1 = gohelper.findChild(slot0.viewGO, "#go_entrance1/#go_item1")
	slot0._txtlevelnum1 = gohelper.findChildText(slot0.viewGO, "#go_entrance1/#go_item1/mask/#txt_levelnum1")
	slot0._btngo1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_entrance1/#go_item1/#btn_go1")
	slot0._gorewards1 = gohelper.findChild(slot0.viewGO, "#go_entrance1/#go_item1/#go_rewards1")
	slot0._scrollcelebritycard1 = gohelper.findChildScrollRect(slot0.viewGO, "#go_entrance1/#go_item1/#go_rewards1/rewardlist/#scroll_celebritycard1")
	slot0._gotag1 = gohelper.findChild(slot0.viewGO, "#go_entrance1/#go_item1/#go_tag1")
	slot0._gonormaltips1 = gohelper.findChild(slot0.viewGO, "#go_entrance1/#go_item1/#go_normaltips1")
	slot0._gospecialtips1 = gohelper.findChild(slot0.viewGO, "#go_entrance1/#go_item1/#go_specialtips1")
	slot0._goentrance2 = gohelper.findChild(slot0.viewGO, "#go_entrance2")
	slot0._goitem2 = gohelper.findChild(slot0.viewGO, "#go_entrance2/#go_item2")
	slot0._txtlevelnum2 = gohelper.findChildText(slot0.viewGO, "#go_entrance2/#go_item2/mask/#txt_levelnum2")
	slot0._btngo2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_entrance2/#go_item2/#btn_go2")
	slot0._gorewards2 = gohelper.findChild(slot0.viewGO, "#go_entrance2/#go_item2/#go_rewards2")
	slot0._scrollcelebritycard2 = gohelper.findChildScrollRect(slot0.viewGO, "#go_entrance2/#go_item2/#go_rewards2/rewardlist/#scroll_celebritycard2")
	slot0._gotag2 = gohelper.findChild(slot0.viewGO, "#go_entrance2/#go_item2/#go_tag2")
	slot0._gonormaltips2 = gohelper.findChild(slot0.viewGO, "#go_entrance2/#go_item2/#go_normaltips2")
	slot0._gospecialtips2 = gohelper.findChild(slot0.viewGO, "#go_entrance2/#go_item2/#go_specialtips2")
	slot0._goentrance3 = gohelper.findChild(slot0.viewGO, "#go_entrance3")
	slot0._goitem3 = gohelper.findChild(slot0.viewGO, "#go_entrance3/#go_item3")
	slot0._txtlevelnum3 = gohelper.findChildText(slot0.viewGO, "#go_entrance3/#go_item3/mask/#txt_levelnum3")
	slot0._btngo3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_entrance3/#go_item3/#btn_go3")
	slot0._gorewards3 = gohelper.findChild(slot0.viewGO, "#go_entrance3/#go_item3/#go_rewards3")
	slot0._scrollcelebritycard3 = gohelper.findChildScrollRect(slot0.viewGO, "#go_entrance3/#go_item3/#go_rewards3/rewardlist/#scroll_celebritycard3")
	slot0._gotag3 = gohelper.findChild(slot0.viewGO, "#go_entrance3/#go_item3/#go_tag3")
	slot0._gonormaltips3 = gohelper.findChild(slot0.viewGO, "#go_entrance3/#go_item3/#go_normaltips3")
	slot0._gospecialtips3 = gohelper.findChild(slot0.viewGO, "#go_entrance3/#go_item3/#go_specialtips3")
	slot0._goentrance4 = gohelper.findChild(slot0.viewGO, "#go_entrance4")
	slot0._goitem4 = gohelper.findChild(slot0.viewGO, "#go_entrance4/#go_item4")
	slot0._txtlevelnum4 = gohelper.findChildText(slot0.viewGO, "#go_entrance4/#go_item4/mask/#txt_levelnum4")
	slot0._btngo4 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_entrance4/#go_item4/#btn_go4")
	slot0._gorewards4 = gohelper.findChild(slot0.viewGO, "#go_entrance4/#go_item4/#go_rewards4")
	slot0._scrollcelebritycard4 = gohelper.findChildScrollRect(slot0.viewGO, "#go_entrance4/#go_item4/#go_rewards4/rewardlist/#scroll_celebritycard4")
	slot0._gotag4 = gohelper.findChild(slot0.viewGO, "#go_entrance4/#go_item4/#go_tag4")
	slot0._gonormaltips4 = gohelper.findChild(slot0.viewGO, "#go_entrance4/#go_item4/#go_normaltips4")
	slot0._gospecialtips4 = gohelper.findChild(slot0.viewGO, "#go_entrance4/#go_item4/#go_specialtips4")
	slot0._goentrance5 = gohelper.findChild(slot0.viewGO, "#go_entrance5")
	slot0._goitem5 = gohelper.findChild(slot0.viewGO, "#go_entrance5/#go_item5")
	slot0._txtlevelnum5 = gohelper.findChildText(slot0.viewGO, "#go_entrance5/#go_item5/mask/#txt_levelnum5")
	slot0._btngo5 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_entrance5/#go_item5/#btn_go5")
	slot0._gorewards5 = gohelper.findChild(slot0.viewGO, "#go_entrance5/#go_item5/#go_rewards5")
	slot0._scrollcelebritycard5 = gohelper.findChildScrollRect(slot0.viewGO, "#go_entrance5/#go_item5/#go_rewards5/rewardlist/#scroll_celebritycard5")
	slot0._gotag5 = gohelper.findChild(slot0.viewGO, "#go_entrance5/#go_item5/#go_tag5")
	slot0._gonormaltips5 = gohelper.findChild(slot0.viewGO, "#go_entrance5/#go_item5/#go_normaltips5")
	slot0._gospecialtips5 = gohelper.findChild(slot0.viewGO, "#go_entrance5/#go_item5/#go_specialtips5")
	slot0._goentrance6 = gohelper.findChild(slot0.viewGO, "#go_entrance6")
	slot0._goitem6 = gohelper.findChild(slot0.viewGO, "#go_entrance6/#go_item6")
	slot0._txtlevelnum6 = gohelper.findChildText(slot0.viewGO, "#go_entrance6/#go_item6/mask/#txt_levelnum6")
	slot0._btngo6 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_entrance6/#go_item6/#btn_go6")
	slot0._gorewards6 = gohelper.findChild(slot0.viewGO, "#go_entrance6/#go_item6/#go_rewards6")
	slot0._scrollcelebritycard6 = gohelper.findChildScrollRect(slot0.viewGO, "#go_entrance6/#go_item6/#go_rewards6/rewardlist/#scroll_celebritycard6")
	slot0._gotag6 = gohelper.findChild(slot0.viewGO, "#go_entrance6/#go_item6/#go_tag6")
	slot0._gonormaltips6 = gohelper.findChild(slot0.viewGO, "#go_entrance6/#go_item6/#go_normaltips6")
	slot0._gospecialtips6 = gohelper.findChild(slot0.viewGO, "#go_entrance6/#go_item6/#go_specialtips6")
	slot0._btnsummon = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#go_summon/#btn_summon")
	slot0._txtpropnum = gohelper.findChildText(slot0.viewGO, "right/#go_summon/#go_currency/#txt_propnum")
	slot0._imagecurrencyicon = gohelper.findChildImage(slot0.viewGO, "right/#go_summon/#go_currency/#image_currencyicon")
	slot0._btncurrencyicon = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#go_summon/#go_currency/#image_currencyicon")
	slot0._btnruledetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_ruledetail")
	slot0._goruletipdetail = gohelper.findChild(slot0.viewGO, "right/#go_ruletipdetail")
	slot0._btncloseruletip = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#go_ruletipdetail/#btn_closeruletip")
	slot0._txtruletips = gohelper.findChildText(slot0.viewGO, "right/#go_ruletips/#txt_ruletips")
	slot0._gomaxrarecard = gohelper.findChild(slot0.viewGO, "right/#go_ruletips/#txt_ruletips/#go_maxrarecard")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._txttitletips = gohelper.findChildText(slot0.viewGO, "title/tips/tips")
	slot0._txtsummon1 = gohelper.findChildText(slot0.viewGO, "right/#go_summon/circle/#txt_summon1")
	slot0._txtsummon2 = gohelper.findChildText(slot0.viewGO, "right/#go_summon/circle/circle/#txt_summon2")
	slot0._goprogress1 = gohelper.findChild(slot0.viewGO, "title/progress/#go_progress1")
	slot0._goprogress2 = gohelper.findChild(slot0.viewGO, "title/progress/#go_progress2")
	slot0._goprogress3 = gohelper.findChild(slot0.viewGO, "title/progress/#go_progress3")
	slot0._goprogress4 = gohelper.findChild(slot0.viewGO, "title/progress/#go_progress4")
	slot0._goprogress5 = gohelper.findChild(slot0.viewGO, "title/progress/#go_progress5")
	slot0._goprogress6 = gohelper.findChild(slot0.viewGO, "title/progress/#go_progress6")
	slot0._goprogress7 = gohelper.findChild(slot0.viewGO, "title/progress/#go_progress7")
	slot0._animationEvent = slot0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btngo1:AddClickListener(slot0._btngo1OnClick, slot0)
	slot0._btngo2:AddClickListener(slot0._btngo2OnClick, slot0)
	slot0._btngo3:AddClickListener(slot0._btngo3OnClick, slot0)
	slot0._btngo4:AddClickListener(slot0._btngo4OnClick, slot0)
	slot0._btngo5:AddClickListener(slot0._btngo5OnClick, slot0)
	slot0._btngo6:AddClickListener(slot0._btngo6OnClick, slot0)
	slot0._btncurrencyicon:AddClickListener(slot0._btncurrencyiconOnClick, slot0)
	slot0._btnsummon:AddClickListener(slot0._btnsummonOnClick, slot0)
	slot0._btnruledetail:AddClickListener(slot0._btnruledetailOnClick, slot0)
	slot0._btncloseruletip:AddClickListener(slot0._btncloseruletipOnClick, slot0)
	slot0._animationEvent:AddEventListener("switch", slot0.onSwitchCard, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btngo1:RemoveClickListener()
	slot0._btngo2:RemoveClickListener()
	slot0._btngo3:RemoveClickListener()
	slot0._btngo4:RemoveClickListener()
	slot0._btngo5:RemoveClickListener()
	slot0._btngo6:RemoveClickListener()
	slot0._btncurrencyicon:RemoveClickListener()
	slot0._btnsummon:RemoveClickListener()
	slot0._btnruledetail:RemoveClickListener()
	slot0._btncloseruletip:RemoveClickListener()
	slot0._animationEvent:RemoveEventListener("switch")
end

function slot0._btngo1OnClick(slot0)
	slot0:_enterLevelInfoView(1)
end

function slot0._btngo2OnClick(slot0)
	slot0:_enterLevelInfoView(2)
end

function slot0._btngo3OnClick(slot0)
	slot0:_enterLevelInfoView(3)
end

function slot0._btngo4OnClick(slot0)
	slot0:_enterLevelInfoView(4)
end

function slot0._btngo5OnClick(slot0)
	slot0:_enterLevelInfoView(5)
end

function slot0._btngo6OnClick(slot0)
	slot0:_enterLevelInfoView(6)
end

function slot0._btnruledetailOnClick(slot0)
	gohelper.setActive(slot0._goruletipdetail, true)
end

function slot0._btncloseruletipOnClick(slot0)
	gohelper.setActive(slot0._goruletipdetail, false)
end

function slot0._btncurrencyiconOnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, SeasonConfig.instance:getRetailTicket(Activity104Model.instance:getCurSeasonId()))
end

function slot0._enterLevelInfoView(slot0, slot1)
	for slot6, slot7 in pairs(Activity104Model.instance:getAct104Retails()) do
		if slot7.position == slot1 then
			Activity104Controller.instance:openSeasonRetailLevelInfoView({
				retail = slot7,
				episodeId = slot7.id
			})

			return
		end
	end
end

function slot0._btnsummonOnClick(slot0)
	if slot0._hasEnoughTicket then
		if tabletool.len(Activity104Model.instance:getAct104Retails()) == 0 then
			function ()
				Activity104Rpc.instance:sendRefreshRetailRequest(ActivityEnum.Activity.Season)
			end()
		else
			GameFacade.showMessageBox(MessageBoxIdDefine.SeasonRetailTicketLimited, MsgBoxEnum.BoxType.Yes_No, slot1)
		end
	else
		GameFacade.showToast(ToastEnum.SeasonReadCountLimitedAndWait)
	end
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if slot0.viewParam then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_smalluncharted_return)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_smalluncharted_open)
	end

	slot4 = Activity104Controller.instance

	slot0:addEventCb(slot4, Activity104Event.RefreshRetail, slot0._onRefreshRetailSuccess, slot0)

	slot0._rewardCardItems = {}

	for slot4 = 1, 6 do
		slot0._rewardCardItems[slot4] = {
			celebrityCards = {}
		}
	end

	Activity104Controller.instance:dispatchEvent(Activity104Event.ChangeCameraSize, true)
	slot0:_refreshLevel()
	slot0:_refreshTitle()
	slot0:_refreshConstTips()
end

function slot0._refreshConstTips(slot0)
	slot1, slot2, slot3 = Activity104Model.instance:caleStageEquipRareWeight()

	if slot3 ~= 0 then
		if not slot0._rareCard then
			slot0._rareCard = SeasonCelebrityCardItem.New()

			slot0._rareCard:init(slot0._gomaxrarecard)
		end

		slot0._rareCard:reset(slot3)
	end

	slot0._txtruletips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("seasonretailview_rule1"), {
		luaLang("seasonretailview_rare_" .. slot2),
		math.floor(slot1 * 100)
	})
end

function slot0._onRefreshRetailSuccess(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_smalluncharted_refresh)
	slot0.viewContainer:playAnim(UIAnimationName.Switch, 0, 0)
end

function slot0.onSwitchCard(slot0)
	slot0:_refreshLevel()
	slot0:_refreshTitle()
end

function slot0._refreshTitle(slot0)
	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagecurrencyicon, CurrencyConfig.instance:getCurrencyCo(SeasonConfig.instance:getRetailTicket(Activity104Model.instance:getCurSeasonId())).icon .. "_1", true)
	slot0:_setStages()
end

function slot0._setStages(slot0)
	gohelper.setActive(slot0._goprogress7, Activity104Model.instance:getAct104CurStage() == 7)

	for slot5 = 1, 7 do
		gohelper.setActive(gohelper.findChildImage(slot0["_goprogress" .. slot5], "light").gameObject, slot5 <= slot1)
		gohelper.setActive(gohelper.findChildImage(slot0["_goprogress" .. slot5], "dark").gameObject, slot1 < slot5)
		SLFramework.UGUI.GuiHelper.SetColor(slot7, slot5 == 7 and "#B83838" or "#FFFFFF")
	end
end

function slot0._refreshLevel(slot0)
	slot2 = SeasonConfig.instance:getRetailTicket(Activity104Model.instance:getCurSeasonId())
	slot3 = CurrencyConfig.instance:getCurrencyCo(slot2).recoverLimit
	slot0._hasEnoughTicket = CurrencyModel.instance:getCurrency(slot2).quantity >= 1
	slot0._txtpropnum.text = slot4 == 0 and "<color=#CF4543>" .. slot4 .. "</color>/" .. slot3 or slot4 .. "/" .. slot3

	slot0:_showEntrance()
end

slot1 = {
	targetFlagUIPosX = -25.9,
	targetFlagUIScale = 2.3,
	targetFlagUIPosY = 19.5,
	showNewFlag2 = false
}

function slot0._showEntrance(slot0)
	gohelper.setActive(slot0._goentrance1, false)
	gohelper.setActive(slot0._goentrance2, false)
	gohelper.setActive(slot0._goentrance3, false)
	gohelper.setActive(slot0._goentrance4, false)
	gohelper.setActive(slot0._goentrance5, false)
	gohelper.setActive(slot0._goentrance6, false)

	for slot7, slot8 in pairs(Activity104Model.instance:getAct104Retails()) do
		slot2 = 0 + 1

		gohelper.setActive(slot0["_goentrance" .. slot8.position], true)

		slot0["_txtlevelnum" .. slot8.position].text = SeasonConfig.instance:getSeasonTagDesc(Activity104Model.instance:getCurSeasonId(), slot8.tag).name .. " " .. GameUtil.getRomanNums(math.min(Activity104Model.instance:getAct104CurStage(), 6))

		gohelper.setActive(slot0["_gonormaltips" .. slot8.position], slot8.advancedId ~= 0 and slot8.advancedRare == 1)
		gohelper.setActive(slot0["_gospecialtips" .. slot8.position], slot8.advancedId ~= 0 and slot8.advancedRare == 2)

		if slot8.advancedId ~= 0 and slot8.advancedRare == 2 then
			slot10 = ""

			for slot14, slot15 in pairs(slot8.showActivity104EquipIds) do
				if SeasonConfig.instance:getSeasonEquipCo(slot15).isOptional == 1 then
					slot10 = slot16.name

					break
				end
			end

			gohelper.findChildText(slot0["_gospecialtips" .. slot8.position], "tips").text = string.format(luaLang("season_retail_specialtips"), slot10)
		end

		slot10 = gohelper.findChild(slot0["_scrollcelebritycard" .. slot8.position].gameObject, "scrollcontent_seasoncelebritycarditem")

		if #slot0._rewardCardItems[slot8.position].celebrityCards > 0 then
			slot14 = slot8.position

			for slot14, slot15 in pairs(slot0._rewardCardItems[slot14].celebrityCards) do
				gohelper.setActive(slot15.go, false)
			end
		end

		for slot15 = 1, math.min(#slot8.showActivity104EquipIds, 3) do
			if not slot0._rewardCardItems[slot8.position].celebrityCards[slot15] then
				slot0._rewardCardItems[slot8.position].celebrityCards[slot15] = SeasonCelebrityCardItem.New()
				uv0.showNewFlag2 = Activity104Model.instance:isNew104Equip(slot8.showActivity104EquipIds[slot15])

				slot0._rewardCardItems[slot8.position].celebrityCards[slot15]:init(slot10, slot16, uv0)
				slot0._rewardCardItems[slot8.position].celebrityCards[slot15]:showTag(true)
			else
				slot18 = slot0._rewardCardItems[slot8.position].celebrityCards[slot15]

				gohelper.setActive(slot18.go, true)
				slot18:reset(slot16)
				slot18:showNewFlag2(slot17)
			end
		end
	end

	if slot2 == 0 then
		slot0._txttitletips.text = luaLang("seasonretailview_unrefreshlevel")
		slot0._txtsummon1.text = luaLang("p_seasonretailview_search")
		slot0._txtsummon2.text = luaLang("p_seasonretailview_search")
	else
		slot0._txttitletips.text = luaLang("p_seasonretailview_tips")
		slot0._txtsummon1.text = luaLang("p_seasonsecretlandview_btnsummon")
		slot0._txtsummon2.text = luaLang("p_seasonsecretlandview_btnsummon")
	end
end

function slot0.onClose(slot0)
	Activity104Controller.instance:dispatchEvent(Activity104Event.ChangeCameraSize, false)
	slot0:removeEventCb(Activity104Controller.instance, Activity104Event.RefreshRetail, slot0._onRefreshRetailSuccess, slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._rewardCardItems then
		for slot4, slot5 in pairs(slot0._rewardCardItems) do
			for slot9, slot10 in pairs(slot5.celebrityCards) do
				slot10:destroy()
			end
		end

		slot0._rewardCardItems = nil
	end
end

return slot0
