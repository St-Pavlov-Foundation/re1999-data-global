module("modules.logic.summon.view.custompick.SummonThreeCustomPickView", package.seeall)

slot0 = class("SummonThreeCustomPickView", BaseView)

function slot0.onInitView(slot0)
	slot0._goui = gohelper.findChild(slot0.viewGO, "#go_ui")
	slot0._gounselected = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_unselected")
	slot0._simagebgunselect = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_unselected/#simage_bgunselect")
	slot0._simageunselect = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_unselected/#simage_unselect")
	slot0._simageline = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_unselected/#simage_line")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_selected")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_selected/#simage_bg")
	slot0._simageline1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_selected/#simage_line1")
	slot0._gorole1 = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_selected/#go_role1")
	slot0._simagerole1outline = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_selected/#go_role1/#simage_role1_outline")
	slot0._simagerole1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_selected/#go_role1/#simage_role1")
	slot0._gocharacteritem1 = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_selected/#go_role1/#go_characteritem1")
	slot0._gorole3 = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_selected/#go_role3")
	slot0._simagerole3outline = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_selected/#go_role3/#simage_role3_outline")
	slot0._simagerole3 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_selected/#go_role3/#simage_role3")
	slot0._gocharacteritem3 = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_selected/#go_role3/#go_characteritem3")
	slot0._simagemask2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_selected/#simage_mask2")
	slot0._gorole2 = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_selected/#go_role2")
	slot0._simagerole2outline = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_selected/#go_role2/#simage_role2_outline")
	slot0._simagerole2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_selected/#go_role2/#simage_role2")
	slot0._gocharacteritem2 = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_selected/#go_role2/#go_characteritem2")
	slot0._simageline31 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_selected/#simage_line3_1")
	slot0._simageline32 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_selected/#simage_line3_2")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_selected/#simage_mask")
	slot0._simageline2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_selected/#simage_line2")
	slot0._simagefrontbg1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_frontbg1")
	slot0._simagefrontbg2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_frontbg2")
	slot0._simagetitle1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/title/#simage_title1")
	slot0._simagetips = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/tip/#simage_tips")
	slot0._gotip2bg = gohelper.findChild(slot0.viewGO, "#go_ui/current/tip/#go_tip2bg")
	slot0._txttips2 = gohelper.findChildText(slot0.viewGO, "#go_ui/current/tip/#txt_tips2")
	slot0._txtdeadline = gohelper.findChildText(slot0.viewGO, "#go_ui/current/#txt_deadline")
	slot0._simageline3 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#txt_deadline/#simage_line3")
	slot0._goselfselect = gohelper.findChild(slot0.viewGO, "#go_ui/#go_selfselect")
	slot0._btnselfselect = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/#go_selfselect/#btn_selfselect")
	slot0._gosummonbtns = gohelper.findChild(slot0.viewGO, "#go_ui/#go_summonbtns")
	slot0._btnsummon1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/#go_summonbtns/summon1/#btn_summon1")
	slot0._simagecurrency1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/#go_summonbtns/summon1/currency/#simage_currency1")
	slot0._txtcurrency11 = gohelper.findChildText(slot0.viewGO, "#go_ui/#go_summonbtns/summon1/currency/#txt_currency1_1")
	slot0._txtcurrency12 = gohelper.findChildText(slot0.viewGO, "#go_ui/#go_summonbtns/summon1/currency/#txt_currency1_2")
	slot0._btnsummon10 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/#go_summonbtns/summon10/#btn_summon10")
	slot0._simagecurrency10 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/#go_summonbtns/summon10/currency/#simage_currency10")
	slot0._txtcurrency101 = gohelper.findChildText(slot0.viewGO, "#go_ui/#go_summonbtns/summon10/currency/#txt_currency10_1")
	slot0._txtcurrency102 = gohelper.findChildText(slot0.viewGO, "#go_ui/#go_summonbtns/summon10/currency/#txt_currency10_2")
	slot0._gocount = gohelper.findChild(slot0.viewGO, "#go_ui/#go_summonbtns/summon10/#go_count")
	slot0._txtcount = gohelper.findChildText(slot0.viewGO, "#go_ui/#go_summonbtns/summon10/#go_count/#txt_count")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_ui/#go_lefttop")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "#go_ui/#go_righttop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnselfselect:AddClickListener(slot0._btnselfselectOnClick, slot0)
	slot0._btnsummon1:AddClickListener(slot0._btnsummon1OnClick, slot0)
	slot0._btnsummon10:AddClickListener(slot0._btnsummon10OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnselfselect:RemoveClickListener()
	slot0._btnsummon1:RemoveClickListener()
	slot0._btnsummon10:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	logNormal("SummonThreeCustomPickView:_editableInitView()")

	slot0._animRoot = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	slot0._simageline3:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	slot0._txttips = gohelper.findChildText(slot0.viewGO, "#go_ui/current/txt_tips")
	slot0._characteritems = {}
	slot0._charaterItemCount = slot0._charaterItemCount or SummonCustomPickModel.instance:getMaxSelectCount(SummonMainModel.instance:getCurPool().id)

	for slot5 = 1, slot0._charaterItemCount do
		slot6 = slot0:getUserDataTb_()
		slot7 = tostring(slot5)
		slot6.go = gohelper.findChild(slot0.viewGO, string.format("#go_ui/current/#go_selected/#go_role%s/#go_characteritem%s", slot7, slot7))
		slot6.imagecareer = gohelper.findChildImage(slot6.go, "image_career")
		slot6.txtnamecn = gohelper.findChildText(slot6.go, "txt_namecn")
		slot6.btndetail = gohelper.findChildButtonWithAudio(slot6.go, "btn_detail", AudioEnum.UI.play_ui_action_explore)
		slot6.gorole = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_selected/#go_role" .. slot7)
		slot6.simagehero = gohelper.findChildSingleImage(slot6.gorole, "#simage_role" .. slot7)
		slot12 = "#simage_role%s_outline"
		slot6.simageroleoutline = gohelper.findChildSingleImage(slot6.gorole, string.format(slot12, slot7))
		slot6.tfimagehero = slot6.simagehero.transform
		slot6.rares = {}

		for slot12 = 1, 6 do
			table.insert(slot6.rares, gohelper.findChild(slot6.go, "rare/go_rare" .. slot12))
		end

		table.insert(slot0._characteritems, slot6)
		slot6.btndetail:AddClickListener(slot0._onClickDetailByIndex, slot0, slot5)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	logNormal("SummonThreeCustomPickView:onOpen()")
	slot0:playEnterAnim()
	slot0:refreshView()
	slot0:addAllEvents()
end

function slot0.onClose(slot0)
	logNormal("SummonThreeCustomPickView:onClose()")
	slot0:removeAllEvents()
end

function slot0.onDestroyView(slot0)
	logNormal("SummonThreeCustomPickView:onDestroyView()")
	slot0._simagebg:UnLoadImage()
	slot0._simagebgunselect:UnLoadImage()
	slot0._simageunselect:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simageline1:UnLoadImage()
	slot0._simageline2:UnLoadImage()
	slot0._simageline3:UnLoadImage()
	slot0._simageline31:UnLoadImage()
	slot0._simageline32:UnLoadImage()
	slot0._simagemask:UnLoadImage()
	slot0._simagemask2:UnLoadImage()
	slot0._simagefrontbg1:UnLoadImage()
	slot0._simagefrontbg2:UnLoadImage()
	slot0._simagetitle1:UnLoadImage()
	slot0._simagetips:UnLoadImage()

	if slot0._compFreeButton then
		slot0._compFreeButton:dispose()

		slot0._compFreeButton = nil
	end

	if slot0._characteritems then
		for slot4, slot5 in ipairs(slot0._characteritems) do
			slot5.btndetail:RemoveClickListener()
			slot5.simagehero:UnLoadImage()
			slot5.simageroleoutline:UnLoadImage()
		end

		slot0._characteritems = nil
	end
end

function slot0._btnselfselectOnClick(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonCustomPickChoice, {
		poolId = slot1.id
	})
end

function slot0._btnsummon1OnClick(slot0)
	if SummonController.instance:isInSummonGuide() then
		return
	end

	if not SummonMainModel.instance:getCurPool() then
		return
	end

	slot3, slot4, slot5 = slot1.getCostByConfig(slot2.cost1)

	if not (slot5 <= ItemModel.instance:getItemQuantity(slot3, slot4)) and slot1:getOwnCostCurrencyNum() < slot1.everyCostCount then
		-- Nothing
	end

	if slot8 then
		slot6.needTransform = false

		slot0:_summon1Confirm()

		return
	else
		slot6.needTransform = true
		slot6.cost_type = slot1.costCurrencyType
		slot6.cost_id = slot1.costCurrencyId
		slot6.cost_quantity = slot9
		slot6.miss_quantity = 1
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, {
		type = slot3,
		id = slot4,
		quantity = slot5,
		callback = slot0._summon1Confirm,
		callbackObj = slot0,
		notEnough = false,
		notEnough = true
	})
end

function slot0._btnsummon10OnClick(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	slot2 = SummonMainModel.instance
	slot3, slot4, slot5 = slot2.getCostByConfig(slot1.cost10)
	slot6 = slot2:getDiscountCost10(slot1.id)

	if slot2:getDiscountCostId(slot1.id) == slot4 then
		slot5 = slot6 < 0 and slot5 or slot6
	end

	if not (slot5 <= ItemModel.instance:getItemQuantity(slot3, slot4)) and slot2:getOwnCostCurrencyNum() < slot2.everyCostCount * (slot5 - slot9) then
		-- Nothing
	end

	if slot10 then
		slot8.needTransform = false

		slot0:_summon10Confirm()

		return
	else
		slot8.needTransform = true
		slot8.cost_type = slot2.costCurrencyType
		slot8.cost_id = slot2.costCurrencyId
		slot8.cost_quantity = slot14
		slot8.miss_quantity = slot13
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, {
		type = slot3,
		id = slot4,
		quantity = slot5,
		callback = slot0._summon10Confirm,
		callbackObj = slot0,
		notEnough = false,
		notEnough = true
	})
end

function slot0._summon10Confirm(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	SummonMainController.instance:sendStartSummon(slot1.id, 10, false, true)
end

function slot0._summon1Confirm(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	SummonMainController.instance:sendStartSummon(slot1.id, 1, false, true)
end

function slot0.refreshView(slot0)
	slot0.summonSuccess = false

	if not SummonMainModel.instance:getList() or #slot1 <= 0 then
		gohelper.setActive(slot0._goui, false)

		return
	end

	slot0:refreshPoolUI()
end

function slot0.getPickHeroIds(slot0, slot1)
	if SummonMainModel.instance:getPoolServerMO(slot1.id) and slot2.customPickMO then
		return slot2.customPickMO.pickHeroIds
	end

	return nil
end

function slot0.refreshPoolUI(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	slot0:handlePickStatus(SummonCustomPickModel.instance:isCustomPickOver(slot1.id), slot1)
	slot0:_refreshOpenTime()
end

function slot0.handlePickStatus(slot0, slot1, slot2)
	gohelper.setActive(slot0._gosummonbtns, slot1)
	gohelper.setActive(slot0._goselected, slot1)

	slot3 = not slot1

	gohelper.setActive(slot0._simageunselect, slot3)
	gohelper.setActive(slot0._goselfselect, slot3)
	gohelper.setActive(slot0._txttips, slot3)
	gohelper.setActive(slot0._simageunselect, slot3)

	if slot1 then
		slot0:refreshCost()
		slot0:refreshFreeSummonButton(slot2)
		slot0:refreshPickHeroes(slot2)
	else
		for slot7 = 1, slot0._charaterItemCount do
			slot0:refreshPickHero(slot2.id, slot7, nil)
		end
	end
end

function slot0.refreshPickHeroes(slot0, slot1)
	if SummonMainModel.instance:getPoolServerMO(slot1.id) and slot2.customPickMO then
		table.sort(slot2.customPickMO.pickHeroIds)

		for slot7 = 1, slot0._charaterItemCount do
			slot0:refreshPickHero(slot1.id, slot7, slot3[slot7])
		end
	end
end

function slot0.refreshPickHero(slot0, slot1, slot2, slot3)
	if slot0._characteritems[slot2] then
		if slot3 then
			gohelper.setActive(slot4.go, true)
			gohelper.setActive(slot4.simagehero, true)

			slot5 = HeroConfig.instance:getHeroCO(slot3)
			slot9 = "lssx_" .. tostring(slot5.career)

			UISpriteSetMgr.instance:setCommonSprite(slot4.imagecareer, slot9)

			slot4.txtnamecn.text = slot5.name

			for slot9 = 1, 6 do
				gohelper.setActive(slot4.rares[slot9], slot9 <= CharacterEnum.Star[slot5.rare])
			end

			slot6, slot7, slot8 = slot0:getOffset(slot5.skinId)

			slot4.simagehero:LoadImage(ResUrl.getHeadIconImg(slot5.skinId), slot0.handleLoadedImageOutline, {
				imgTransform = slot4.simagehero.gameObject.transform,
				offsetX = slot6,
				offsetY = slot7,
				scale = slot8
			})
			slot4.simageroleoutline:LoadImage(ResUrl.getHeadIconImg(slot5.skinId), slot0.handleLoadedImageOutline, {
				imgTransform = slot4.simageroleoutline.gameObject.transform,
				offsetX = slot6 - 5,
				offsetY = slot7 + 2,
				scale = slot8
			})
		else
			gohelper.setActive(slot4.go, false)
			gohelper.setActive(slot4.simagehero, false)
		end
	end
end

function slot0.getOffset(slot0, slot1)
	if not string.nilorempty(SkinConfig.instance:getSkinCo(slot1).summonPickUpImgOffset) then
		slot4 = string.splitToNumber(slot3, "#")

		return slot4[1], slot4[2], slot4[3]
	end

	return -150, -150, 0.6
end

function slot0.handleLoadedImage(slot0)
	ZProj.UGUIHelper.SetImageSize(slot0.panel._characteritems[slot0.index].simagehero.gameObject)

	if not string.nilorempty(SkinConfig.instance:getSkinCo(slot0.skinId).skinViewImgOffset) then
		slot7 = string.splitToNumber(slot6, "#")

		recthelper.setAnchor(slot4.tfimagehero, tonumber(slot7[1]), tonumber(slot7[2]))
		transformhelper.setLocalScale(slot4.tfimagehero, tonumber(slot7[3]), tonumber(slot7[3]), tonumber(slot7[3]))
	else
		recthelper.setAnchor(slot4.tfimagehero, -150, -150)
		transformhelper.setLocalScale(slot4.tfimagehero, 0.6, 0.6, 0.6)
	end
end

function slot0.handleLoadedImageOutline(slot0)
	slot1 = slot0.imgTransform
	slot4 = slot0.scale

	ZProj.UGUIHelper.SetImageSize(slot1.gameObject)
	recthelper.setAnchor(slot1, slot0.offsetX, slot0.offsetY)
	transformhelper.setLocalScale(slot1, slot4, slot4, slot4)
end

function slot0.refreshFreeSummonButton(slot0, slot1)
	slot0._compFreeButton = slot0._compFreeButton or SummonFreeSingleGacha.New(slot0._btnsummon1.gameObject, slot1.id)

	slot0._compFreeButton:refreshUI()
end

function slot0._onClickDetailByIndex(slot0, slot1)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	if SummonMainModel.instance:getPoolServerMO(slot2.id) and slot3.customPickMO and slot3.customPickMO.pickHeroIds[slot1] then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = slot4
		})
	end
end

function slot0._refreshOpenTime(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	if SummonMainModel.instance:getPoolServerMO(slot1.id) ~= nil and slot2.offlineTime ~= 0 and slot2.offlineTime < TimeUtil.maxDateTimeStamp then
		slot0._txtdeadline.text = string.format(luaLang("summonmainequipprobup_deadline"), SummonModel.formatRemainTime(slot2.offlineTime - ServerTime.now()))
	else
		slot0._txtdeadline.text = ""
	end
end

function slot0.refreshCost(slot0)
	if SummonMainModel.instance:getCurPool() then
		slot0:_refreshSingleCost(slot1.cost1, slot0._simagecurrency1, "_txtcurrency1")
		slot0:refreshCost10(slot1.cost10)
	end
end

function slot0.refreshTicket(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	slot2 = 0

	if slot1.ticketId ~= 0 then
		slot2 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, slot1.ticketId)
	end

	slot0._txtticket.text = tostring(slot2)
end

function slot0._refreshSingleCost(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6 = SummonMainModel.getCostByConfig(slot1)

	slot2:LoadImage(SummonMainModel.getSummonItemIcon(slot4, slot5))

	slot9 = slot6 <= ItemModel.instance:getItemQuantity(slot4, slot5)
	slot0[slot3 .. "1"].text = luaLang("multiple") .. slot6
	slot0[slot3 .. "2"].text = ""
end

function slot0.refreshCost10(slot0, slot1)
	slot2, slot3, slot0._txtcurrency102.text = SummonMainModel.instance.getCostByConfig(slot1)

	slot0._simagecurrency10:LoadImage(SummonMainModel.instance.getSummonItemIcon(slot2, slot3))

	slot6 = SummonMainModel.instance:getCurId()

	gohelper.setActive(slot0._gotip2bg, SummonMainModel.instance:getDiscountTime10Server(slot6) > 0)
	gohelper.setActive(slot0._txttips2, slot8 > 0)

	if slot3 == SummonMainModel.instance:getDiscountCostId(slot6) then
		gohelper.setActive(slot0._gocount, slot8 > 0)

		if slot8 > 0 then
			slot9 = SummonMainModel.instance:getDiscountCost10(slot6)
			slot0._txtcurrency101.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("multiple_color"), "#FFE095", luaLang("multiple") .. slot9)
			slot0._txtcount.text = string.format(luaLang("summonpickchoice_discount"), (slot4 - slot9) / slot4 * 100)

			return
		end
	else
		gohelper.setActive(slot0._gocount, false)
	end

	slot0._txtcurrency101.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("multiple_color"), "#000000", luaLang("multiple") .. slot4)
	slot0._txtcurrency102.text = ""
end

function slot0.onSummonFailed(slot0)
	slot0.summonSuccess = false

	slot0:refreshCost()
end

function slot0.onSummonReply(slot0)
	slot0.summonSuccess = true
end

function slot0.onItemChanged(slot0)
	if SummonController.instance.isWaitingSummonResult or slot0.summonSuccess then
		return
	end

	slot0:refreshCost()
end

function slot0.addAllEvents(slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonFailed, slot0.onSummonFailed, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, slot0.onSummonReply, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, slot0.playerEnterAnimFromScene, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.onItemChanged, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.onItemChanged, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, slot0.refreshView, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, slot0._refreshOpenTime, slot0)
end

function slot0.removeAllEvents(slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonFailed, slot0.onSummonFailed, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, slot0.onSummonReply, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, slot0.playerEnterAnimFromScene, slot0)
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.onItemChanged, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.onItemChanged, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, slot0.refreshView, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, slot0._refreshOpenTime, slot0)
end

function slot0.playEnterAnim(slot0)
	if SummonMainModel.instance:getFirstTimeSwitch() then
		SummonMainModel.instance:setFirstTimeSwitch(false)
		slot0._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
	else
		slot0._animRoot:Play(SummonEnum.SummonCharAnimationSwitch, 0, 0)
	end
end

function slot0.playerEnterAnimFromScene(slot0)
	slot0._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
end

return slot0
