module("modules.logic.summon.view.luckybag.SummonMainLuckyBagView", package.seeall)

slot0 = class("SummonMainLuckyBagView", BaseView)

function slot0.onInitView(slot0)
	slot0._goui = gohelper.findChild(slot0.viewGO, "#go_ui")
	slot0._gocharacteritem1 = gohelper.findChild(slot0.viewGO, "#go_ui/current/right/#go_characteritem1")
	slot0._gocharacteritem2 = gohelper.findChild(slot0.viewGO, "#go_ui/current/right/#go_characteritem2")
	slot0._btnsummon1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/summonbtns/summon1/#btn_summon1")
	slot0._simagecurrency1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/summonbtns/summon1/currency/#simage_currency1")
	slot0._txtcurrency11 = gohelper.findChildText(slot0.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_1")
	slot0._txtcurrency12 = gohelper.findChildText(slot0.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_2")
	slot0._gosummon10 = gohelper.findChild(slot0.viewGO, "#go_ui/summonbtns/summon10")
	slot0._btnsummon10 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/summonbtns/summon10/#btn_summon10")
	slot0._simagecurrency10 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/summonbtns/summon10/currency/#simage_currency10")
	slot0._txtcurrency101 = gohelper.findChildText(slot0.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_1")
	slot0._txtcurrency102 = gohelper.findChildText(slot0.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_2")
	slot0._gopageitem = gohelper.findChild(slot0.viewGO, "#go_ui/pageicon/#go_pageitem")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_ui/#go_lefttop")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "#go_ui/#go_righttop")
	slot0._gosummonbtns = gohelper.findChild(slot0.viewGO, "#go_ui/summonbtns")
	slot0._goluckybagbtns = gohelper.findChild(slot0.viewGO, "#go_ui/#go_luckybagopen")
	slot0._goluckbagbtn = gohelper.findChild(slot0.viewGO, "#go_ui/#go_luckybagopen/btnopenluckbag")
	slot0._btnluckybagbtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/#go_luckybagopen/btnopenluckbag/#btn_openluckbag")
	slot0._goalreadyinvited = gohelper.findChild(slot0.viewGO, "#go_ui/#go_luckybagopen/#go_alreadyinvited")
	slot0._txtdeadline = gohelper.findChildText(slot0.viewGO, "#go_ui/current/#txt_deadline")
	slot0._simageline = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#txt_deadline/#simage_line")
	slot0._txttimes = gohelper.findChildText(slot0.viewGO, "#go_ui/#go_remaintimes/bg/#txt_times")
	slot0._simageluckybag = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/#go_luckybagopen/btnopenluckbag/#simage_jinfangjie")
	slot0._goremaintimes = gohelper.findChild(slot0.viewGO, "#go_ui/#go_remaintimes")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnluckybagbtn:AddClickListener(slot0._btnopenluckbagOnClick, slot0)
	slot0._btnsummon1:AddClickListener(slot0._btnsummon1OnClick, slot0)
	slot0._btnsummon10:AddClickListener(slot0._btnsummon10OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnluckybagbtn:RemoveClickListener()
	slot0._btnsummon1:RemoveClickListener()
	slot0._btnsummon10:RemoveClickListener()
end

slot0.preloadList = {
	"singlebg/summon/heroversion_2_4/v2a4_fudai/v2a4_fudai_summon_fullbg1.png",
	"singlebg/summon/heroversion_2_4/v2a4_fudai/v2a4_fudai_summon_role1.png",
	"singlebg/summon/heroversion_2_4/v2a4_fudai/v2a4_fudai_summon_role2.png"
}

function slot0._editableInitView(slot0)
	slot0._luckyBagCount = 2
	slot0._pageitems = {}
	slot0._animRoot = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	slot0._rectremaintimes = slot0._goremaintimes.transform

	slot0:initSingleBg()
	slot0:initLuckyBagComp()
end

function slot0.onDestroyView(slot0)
	for slot4 = 1, slot0._luckyBagCount do
		if slot0:getLuckyBagDetailBtn(slot4) then
			slot5:RemoveClickListener()
		end

		slot0["_simagerole" .. tostring(slot4)]:UnLoadImage()
		slot0["_simageshowicon" .. tostring(slot4)]:UnLoadImage()
	end

	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
	slot0._simageline:UnLoadImage()

	if slot0._compFreeButton then
		slot0._compFreeButton:dispose()

		slot0._compFreeButton = nil
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	logNormal("SummonMainLuckyBagView:onOpen()")
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonFailed, slot0.onSummonFailed, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, slot0.onSummonReply, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, slot0.playerEnterAnimFromScene, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.onItemChanged, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.onItemChanged, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, slot0.refreshView, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, slot0._refreshOpenTime, slot0)
	slot0:playEnterAnim()
	slot0:refreshView()
	slot0:checkAutoOpenLuckyBag()
	SummonController.instance:dispatchEvent(SummonEvent.LuckyBagViewOpen)
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

function slot0.checkAutoOpenLuckyBag(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	slot3, slot4 = SummonLuckyBagModel.instance:isLuckyBagGot(slot1.id)

	if slot3 and not SummonLuckyBagModel.instance:isLuckyBagOpened(slot2, slot4) and SummonLuckyBagModel.instance:needAutoPopup(slot2) then
		ViewMgr.instance:openView(ViewName.SummonLuckyBagChoice, {
			poolId = slot2,
			luckyBagId = slot4
		})
		SummonLuckyBagModel.instance:recordAutoPopup(slot2)
	end
end

function slot0.onClose(slot0)
	logNormal("SummonMainLuckyBagView:onClose()")
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonFailed, slot0.onSummonFailed, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, slot0.onSummonReply, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, slot0.playerEnterAnimFromScene, slot0)
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.onItemChanged, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.onItemChanged, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, slot0.refreshView, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, slot0._refreshOpenTime, slot0)
end

function slot0.initSingleBg(slot0)
	for slot4 = 1, slot0._luckyBagCount do
		slot0["_simagerole" .. tostring(slot4)] = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_role" .. tostring(slot4))
		slot0["_simageshowicon" .. tostring(slot4)] = gohelper.findChildSingleImage(slot0.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/dec1", slot4))
	end
end

function slot0.initLuckyBagComp(slot0)
	for slot4 = 1, slot0._luckyBagCount do
		if gohelper.findChildButtonWithAudio(slot0.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/btn_detail", slot4)) then
			slot0["_btnluckybag" .. tostring(slot4)] = slot6

			slot6:AddClickListener(uv0.onClickLuckyBagDetail, slot0, slot4)
		end

		slot0["_txtName" .. tostring(slot4)] = gohelper.findChildText(slot0.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/txt1", slot4))
		slot0["_gogotvfx" .. tostring(slot4)] = gohelper.findChild(slot0.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/dec1_glow", slot4))
		slot0["_gogotimage" .. tostring(slot4)] = gohelper.findChild(slot0.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/#simage_alreadyget", slot4))
	end
end

function slot0._btnopenluckbagOnClick(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	slot2, slot3 = SummonLuckyBagModel.instance:isLuckyBagGot(slot1.id)

	if slot2 and not SummonLuckyBagModel.instance:isLuckyBagOpened(slot1.id, slot3) then
		ViewMgr.instance:openView(ViewName.SummonLuckyBagChoice, {
			poolId = slot1.id,
			luckyBagId = slot3
		})
	end
end

function slot0._btnsummon1OnClick(slot0)
	if SummonController.instance:isInSummonGuide() then
		return
	end

	if not SummonMainModel.instance:getCurPool() then
		return
	end

	slot2, slot3, slot4 = SummonMainModel.getCostByConfig(slot1.cost1)

	if not (slot4 <= ItemModel.instance:getItemQuantity(slot2, slot3)) and SummonMainModel.instance:getOwnCostCurrencyNum() < SummonMainModel.instance.everyCostCount then
		-- Nothing
	end

	if slot7 then
		slot5.needTransform = false

		slot0:_summon1Confirm()

		return
	else
		slot5.needTransform = true
		slot5.cost_type = SummonMainModel.instance.costCurrencyType
		slot5.cost_id = SummonMainModel.instance.costCurrencyId
		slot5.cost_quantity = slot8
		slot5.miss_quantity = 1
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, {
		type = slot2,
		id = slot3,
		quantity = slot4,
		callback = slot0._summon1Confirm,
		callbackObj = slot0,
		notEnough = false,
		notEnough = true
	})
end

function slot0._btnsummon10OnClick(slot0)
	if not slot0:checkRemainTimesEnough10() then
		return
	end

	if not SummonMainModel.instance:getCurPool() then
		return
	end

	slot2, slot3, slot4 = SummonMainModel.getCostByConfig(slot1.cost10)

	if not (slot4 <= ItemModel.instance:getItemQuantity(slot2, slot3)) and SummonMainModel.instance:getOwnCostCurrencyNum() < SummonMainModel.instance.everyCostCount * (10 - slot6) then
		-- Nothing
	end

	if slot7 then
		slot5.needTransform = false

		slot0:_summon10Confirm()

		return
	else
		slot5.needTransform = true
		slot5.cost_type = SummonMainModel.instance.costCurrencyType
		slot5.cost_id = SummonMainModel.instance.costCurrencyId
		slot5.cost_quantity = slot11
		slot5.miss_quantity = slot10
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, {
		type = slot2,
		id = slot3,
		quantity = slot4,
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

function slot0.checkRemainTimesEnough10(slot0)
	if SummonMainModel.instance:getCurPool() then
		if SummonLuckyBagModel.instance:getGachaRemainTimes(slot1.id) >= 10 then
			return true
		else
			GameFacade.showToast(ToastEnum.SummonLuckyBagLessThanSummon10)

			return false
		end
	end
end

function slot0._summon1Confirm(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	SummonMainController.instance:sendStartSummon(slot1.id, 1, false, true)
end

function slot0.onClickLuckyBagDetail(slot0, slot1)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	if not SummonConfig.instance:getSummonLuckyBag(slot2.id) then
		return
	end

	if slot3[slot1] then
		SummonMainController.instance:openSummonDetail(slot2, slot4)
	end
end

function slot0.refreshView(slot0)
	slot0.summonSuccess = false

	if not SummonMainModel.instance:getList() or #slot1 <= 0 then
		gohelper.setActive(slot0._goui, false)

		return
	end

	slot0:refreshPoolUI()
end

function slot0.refreshPoolUI(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	slot0:refreshLuckyBagStatus(slot1)
	slot0:refreshLuckyBagDetails(slot1)
	slot0:_refreshOpenTime()
end

function slot0.refreshLuckyBagDetails(slot0, slot1)
	if SummonConfig.instance:getSummonLuckyBag(slot1.id) and next(slot2) then
		for slot7 = 1, slot0._luckyBagCount do
			if slot0:getLuckyBagDetailBtn(slot7) ~= nil then
				gohelper.setActive(slot8, slot7 <= #slot2)
			end

			if slot0["_txtName" .. tostring(slot7)] ~= nil then
				gohelper.setActive(slot10, slot7 <= slot3)

				if slot7 <= slot3 then
					slot10.text = SummonConfig.instance:getLuckyBag(slot1.id, slot2[slot7]).name
				end
			end
		end
	end
end

slot0.RemainTimesPosition = {
	NoLuckyBag = {
		x = -232.5,
		y = 113.9
	},
	ExistLuckyBag = {
		x = 140,
		y = 113.9
	}
}

function slot0.refreshLuckyBagStatus(slot0, slot1)
	slot2, slot3 = SummonLuckyBagModel.instance:isLuckyBagGot(slot1.id)

	gohelper.setActive(slot0._goluckybagbtns, slot2)
	gohelper.setActive(slot0._gosummonbtns, not slot2)

	if slot2 then
		slot0:refreshGotStatus(slot1, slot3)
	else
		slot0:refreshGachaStatus(slot1)
	end
end

function slot0.refreshGotStatus(slot0, slot1, slot2)
	slot3 = SummonLuckyBagModel.instance:isLuckyBagOpened(slot1.id, slot2)

	gohelper.setActive(slot0._goalreadyinvited, slot3)
	gohelper.setActive(slot0._goluckbagbtn, not slot3)

	if SummonConfig.instance:getLuckyBag(slot1.id, slot2) then
		slot0._simageluckybag:LoadImage(ResUrl.getSummonCoverBg(slot4.icon))
	end

	gohelper.setActive(slot0._goremaintimes, not slot3)

	if not slot3 then
		slot5 = uv0.RemainTimesPosition.ExistLuckyBag

		recthelper.setAnchor(slot0._rectremaintimes, slot5.x, slot5.y)
		slot0:refreshRemainTimes(slot1)
	end

	if SummonConfig.instance:getSummonLuckyBag(slot1.id) then
		slot0:setLuckyBagIconVfx(tabletool.indexOf(slot5, slot2))
	else
		slot0:setLuckyBagIconVfx(-1)
	end
end

function slot0.refreshGachaStatus(slot0, slot1)
	slot0:refreshCost()
	slot0:refreshFreeSummonButton(slot1)
	slot0:setLuckyBagIconVfx(-1)

	slot2 = uv0.RemainTimesPosition.NoLuckyBag

	recthelper.setAnchor(slot0._rectremaintimes, slot2.x, slot2.y)
	slot0:refreshRemainTimes(slot1)
end

function slot0.setLuckyBagIconVfx(slot0, slot1)
	for slot5 = 1, slot0._luckyBagCount do
		gohelper.setActive(slot0["_gogotvfx" .. tostring(slot5)], slot1 == slot5)
		gohelper.setActive(slot0["_gogotimage" .. tostring(slot5)], slot1 == slot5)
	end
end

function slot0.refreshFreeSummonButton(slot0, slot1)
	slot0._compFreeButton = slot0._compFreeButton or SummonFreeSingleGacha.New(slot0._btnsummon1.gameObject, slot1.id)

	slot0._compFreeButton:refreshUI()
end

function slot0.refreshRemainTimes(slot0, slot1)
	if SummonMainModel.instance:getPoolServerMO(slot1.id) and slot3.luckyBagMO then
		slot0._txttimes.text = string.format("%s/%s", slot3.luckyBagMO.summonTimes, SummonConfig.getSummonSSRTimes(slot1))
	else
		slot0._txttimes.text = "-"
	end
end

function slot0.refreshCost(slot0)
	if SummonMainModel.instance:getCurPool() then
		slot0:_refreshSingleCost(slot1.cost1, slot0._simagecurrency1, "_txtcurrency1")

		if SummonLuckyBagModel.instance:getGachaRemainTimes(slot1.id) and slot2 >= 10 then
			ZProj.UGUIHelper.SetGrayscale(slot0._btnsummon10.gameObject, false)
			ZProj.UGUIHelper.SetGrayscale(slot0._simagecurrency10.gameObject, false)
		else
			ZProj.UGUIHelper.SetGrayscale(slot0._btnsummon10.gameObject, true)
			ZProj.UGUIHelper.SetGrayscale(slot0._simagecurrency10.gameObject, true)
		end

		slot0:_refreshSingleCost(slot1.cost10, slot0._simagecurrency10, "_txtcurrency10")
	end
end

function slot0._refreshSingleCost(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6 = SummonMainModel.getCostByConfig(slot1)

	slot2:LoadImage(SummonMainModel.getSummonItemIcon(slot4, slot5))

	slot9 = slot6 <= ItemModel.instance:getItemQuantity(slot4, slot5)
	slot0[slot3 .. "1"].text = luaLang("multiple") .. slot6
	slot0[slot3 .. "2"].text = ""
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

function slot0.getLuckyBagDetailBtn(slot0, slot1)
	return slot0["_btnluckybag" .. tostring(slot1)]
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

return slot0
