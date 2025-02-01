module("modules.logic.summon.view.SummonMainEquipView", package.seeall)

slot0 = class("SummonMainEquipView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagebgline01 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bgline01")
	slot0._simagebgline02 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bgline02")
	slot0._txtdeadline = gohelper.findChildText(slot0.viewGO, "#go_ui/#txt_deadline")
	slot0._simageline = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/#txt_deadline/#simage_line")
	slot0._goui = gohelper.findChild(slot0.viewGO, "#go_ui")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/equip/#btn_detail")
	slot0._goequip1 = gohelper.findChild(slot0.viewGO, "#go_ui/equip/#go_equip1")
	slot0._goequip2 = gohelper.findChild(slot0.viewGO, "#go_ui/equip/#go_equip2")
	slot0._goequip3 = gohelper.findChild(slot0.viewGO, "#go_ui/equip/#go_equip3")
	slot0._goequip4 = gohelper.findChild(slot0.viewGO, "#go_ui/equip/#go_equip4")
	slot0._goequip5 = gohelper.findChild(slot0.viewGO, "#go_ui/equip/#go_equip5")
	slot0._simageequipbg1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/equip/#go_equip1/#simage_equipbg1")
	slot0._simageequipbg2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/equip/#go_equip2/#simage_equipbg2")
	slot0._btnsummon1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/summonbtns/summon1/#btn_summon1")
	slot0._txtsummon1 = gohelper.findChildText(slot0.viewGO, "#go_ui/summonbtns/summon1/#txt_summon1")
	slot0._simagecurrency1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/summonbtns/summon1/currency/#simage_currency1")
	slot0._txtcurrency11 = gohelper.findChildText(slot0.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_1")
	slot0._txtcurrency12 = gohelper.findChildText(slot0.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_2")
	slot0._btnsummon10 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/summonbtns/summon10/#btn_summon10")
	slot0._simagecurrency10 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/summonbtns/summon10/currency/#simage_currency10")
	slot0._txtcurrency101 = gohelper.findChildText(slot0.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_1")
	slot0._txtcurrency102 = gohelper.findChildText(slot0.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_2")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "#go_ui/#go_righttop")
	slot0._gosinglefree = gohelper.findChild(slot0.viewGO, "#go_ui/summonbtns/summon1/#go_singlefree")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
	slot0._btnsummon1:AddClickListener(slot0._btnsummon1OnClick, slot0)
	slot0._btnsummon10:AddClickListener(slot0._btnsummon10OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btndetail:RemoveClickListener()
	slot0._btnsummon1:RemoveClickListener()
	slot0._btnsummon10:RemoveClickListener()
end

slot0.preloadList = {
	ResUrl.getSummonEquipIcon("full/bg_xxkc")
}

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getSummonEquipIcon("full/bg_xxkc"))
	slot0._simagebgline01:LoadImage(ResUrl.getSummonEquipIcon("bg_summonline_01"))
	slot0._simagebgline02:LoadImage(ResUrl.getSummonEquipIcon("bg_summonline_02"))
	slot0._simageequipbg1:LoadImage(ResUrl.getSummonEquipIcon("bg_role_shade"))
	slot0._simageequipbg2:LoadImage(ResUrl.getSummonEquipIcon("bg_role_shade"))
	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	slot0._animRoot = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	slot0:_initEquipItems()
end

slot1 = 5
slot2 = 6

function slot0._initEquipItems(slot0)
	slot0._equipItemsMap = slot0._equipItemsMap or {}

	for slot4 = 1, uv0 do
		if not gohelper.isNil(slot0["_goequip" .. tostring(slot4)]) then
			slot6 = slot0:getUserDataTb_()
			slot6.go = slot5
			slot6.imageIcon = gohelper.findChildSingleImage(slot5, "simage_icon")
			slot6.btnDetail = gohelper.findChildButtonWithAudio(slot5, "btn_detail")

			slot6.btnDetail:AddClickListener(slot0.onClickItem, slot0, slot4)

			slot0._equipItemsMap[slot4] = slot6
		end
	end
end

function slot0.onClickItem(slot0, slot1)
	if SummonMainModel.instance:getEquipDetailListByPool(SummonMainModel.instance:getCurPool())[slot1] and EquipConfig.instance:getEquipCo(slot4.equipId) then
		EquipController.instance:openEquipView({
			equipId = slot5.id
		})
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, slot0.onSummonReply, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonFailed, slot0.onSummonFailed, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.onItemChanged, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.onItemChanged, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, slot0.onInfoGot, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, slot0.playEnterAnim, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, slot0._refreshOpenTime, slot0)
	slot0:playEnterAnim()
	slot0:_refreshView()
end

function slot0.playEnterAnim(slot0)
	if SummonMainModel.instance:getFirstTimeSwitch() then
		SummonMainModel.instance:setFirstTimeSwitch(false)
	end

	slot0._animRoot:Play(SummonEnum.SummonEquipAnimationSwitch, 0, 0)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, slot0.onSummonReply, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonFailed, slot0.onSummonFailed, slot0)
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.onItemChanged, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.onItemChanged, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, slot0.onInfoGot, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, slot0.playEnterAnim, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, slot0._refreshOpenTime, slot0)
end

function slot0._btndetailOnClick(slot0)
	if #SummonMainModel.instance:getEquipDetailListByPool(SummonMainModel.instance:getCurPool()) == 0 then
		logError("no logo equip found, check summon_pool config first!")

		return
	end

	EquipController.instance:openEquipView({
		equipId = slot2[1].equipCo.id
	})
end

function slot0._btnsummon1OnClick(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	slot2, slot3, slot4 = SummonMainModel.getCostByConfig(slot1.cost1)

	if SummonModel.instance:getFreeEquipSummon() then
		slot4 = 0
	end

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

function slot0._summon1Confirm(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	SummonMainController.instance:sendStartSummon(slot1.id, 1, true, true)
end

function slot0._btnsummon10OnClick(slot0)
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

	SummonMainController.instance:sendStartSummon(slot1.id, 10, false, false)
end

function slot0._refreshView(slot0)
	slot0.summonSuccess = false

	slot0:_refreshCost()
	slot0:_refreshEquips()
	slot0:_refreshOpenTime()
end

slot0.SingleFreeTextPosX = 17.4
slot0.SingleCostTextPosX = 83.3

function slot0._refreshCost(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	if SummonModel.instance:getFreeEquipSummon() then
		slot0._txtsummon1.text = luaLang("summon_equip_free")

		recthelper.setAnchorX(slot0._txtsummon1.transform, uv0.SingleFreeTextPosX)
		slot0:_refreshSingleFree(slot1.cost1, slot0._simagecurrency1, "_txtcurrency1")
		gohelper.setActive(slot0._gosinglefree, true)
	else
		slot0._txtsummon1.text = luaLang("summon_equip_one_times")

		recthelper.setAnchorX(slot0._txtsummon1.transform, uv0.SingleCostTextPosX)
		slot0:_refreshSingleCost(slot1.cost1, slot0._simagecurrency1, "_txtcurrency1")
		gohelper.setActive(slot0._gosinglefree, false)
	end

	slot0:_refreshSingleCost(slot1.cost10, slot0._simagecurrency10, "_txtcurrency10")
end

function slot0._refreshSingleCost(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6 = SummonMainModel.getCostByConfig(slot1)

	gohelper.setActive(slot2.gameObject, true)
	slot2:LoadImage(SummonMainModel.getSummonItemIcon(slot4, slot5))

	slot9 = slot6 <= ItemModel.instance:getItemQuantity(slot4, slot5)
	slot0[slot3 .. "1"].text = luaLang("multiple") .. slot6
	slot0[slot3 .. "2"].text = ""
end

function slot0._refreshOpenTime(slot0)
	if SummonMainModel.instance:getPoolServerMO(SummonMainModel.instance:getCurPool().id) ~= nil and slot2.offlineTime ~= 0 and slot2.offlineTime < TimeUtil.maxDateTimeStamp then
		slot0._txtdeadline.text = string.format(luaLang("summonmainequipprobup_deadline"), SummonModel.formatRemainTime(slot2.offlineTime - ServerTime.now()))
	else
		slot0._txtdeadline.text = ""
	end
end

function slot0._refreshSingleFree(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6 = SummonMainModel.getCostByConfig(slot1)
	slot7 = SummonMainModel.getSummonItemIcon(slot4, slot5)

	gohelper.setActive(slot2.gameObject, false)

	slot0[slot3 .. "1"].text = ""
	slot0[slot3 .. "2"].text = ""
end

function slot0._refreshEquips(slot0)
	for slot6 = 1, uv0 do
		slot7 = slot0._equipItemsMap[slot6]

		if not SummonMainModel.instance:getEquipDetailListByPool(SummonMainModel.instance:getCurPool())[slot6] then
			if slot7 then
				slot7.go:SetActive(false)
			end
		elseif slot7 then
			slot0:_refreshEquipItem(slot7, slot6, slot2[slot6])
		end
	end
end

function slot0._refreshEquipItem(slot0, slot1, slot2, slot3)
	slot1.go:SetActive(true)

	slot4 = EquipConfig.instance:getEquipCo(slot3.equipId)

	slot1.imageIcon:LoadImage(ResUrl.getSummonEquipIcon("img_role_" .. slot2))
end

function slot0._applyStars(slot0, slot1, slot2)
	for slot7 = 1, uv0 do
		gohelper.setActive(slot1["star" .. tostring(slot7)], slot7 <= 1 + slot2)
	end
end

function slot0._applyRare(slot0, slot1, slot2)
	for slot7 = 5, uv0 do
		gohelper.setActive(slot1["rare" .. tostring(slot7)], slot7 == 1 + slot2)
	end
end

function slot0.onSummonFailed(slot0)
	slot0.summonSuccess = false

	slot0:_refreshCost()
end

function slot0.onSummonReply(slot0)
	slot0.summonSuccess = true
end

function slot0.onItemChanged(slot0)
	if SummonController.instance.isWaitingSummonResult or slot0.summonSuccess then
		return
	end

	slot0:_refreshCost()
end

function slot0.onInfoGot(slot0)
	slot0:_refreshCost()
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageequipbg1:UnLoadImage()
	slot0._simageequipbg2:UnLoadImage()
	slot0._simageline:UnLoadImage()

	if slot0._equipItemsMap then
		for slot4, slot5 in pairs(slot0._equipItemsMap) do
			slot5.btnDetail:RemoveClickListener()
		end

		slot0._equipItemsMap = nil
	end

	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
	slot0._simagebgline01:UnLoadImage()
	slot0._simagebgline02:UnLoadImage()
end

return slot0
