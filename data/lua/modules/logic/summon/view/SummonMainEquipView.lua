module("modules.logic.summon.view.SummonMainEquipView", package.seeall)

local var_0_0 = class("SummonMainEquipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagebgline01 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bgline01")
	arg_1_0._simagebgline02 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bgline02")
	arg_1_0._txtdeadline = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/#txt_deadline")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/#txt_deadline/#simage_line")
	arg_1_0._goui = gohelper.findChild(arg_1_0.viewGO, "#go_ui")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/equip/#btn_detail")
	arg_1_0._goequip1 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/equip/#go_equip1")
	arg_1_0._goequip2 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/equip/#go_equip2")
	arg_1_0._goequip3 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/equip/#go_equip3")
	arg_1_0._goequip4 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/equip/#go_equip4")
	arg_1_0._goequip5 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/equip/#go_equip5")
	arg_1_0._simageequipbg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/equip/#go_equip1/#simage_equipbg1")
	arg_1_0._simageequipbg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/equip/#go_equip2/#simage_equipbg2")
	arg_1_0._btnsummon1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/summonbtns/summon1/#btn_summon1")
	arg_1_0._txtsummon1 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon1/#txt_summon1")
	arg_1_0._simagecurrency1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/summonbtns/summon1/currency/#simage_currency1")
	arg_1_0._txtcurrency11 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_1")
	arg_1_0._txtcurrency12 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_2")
	arg_1_0._btnsummon10 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/#btn_summon10")
	arg_1_0._simagecurrency10 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/currency/#simage_currency10")
	arg_1_0._txtcurrency101 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_1")
	arg_1_0._txtcurrency102 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_2")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_righttop")
	arg_1_0._gosinglefree = gohelper.findChild(arg_1_0.viewGO, "#go_ui/summonbtns/summon1/#go_singlefree")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
	arg_2_0._btnsummon1:AddClickListener(arg_2_0._btnsummon1OnClick, arg_2_0)
	arg_2_0._btnsummon10:AddClickListener(arg_2_0._btnsummon10OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndetail:RemoveClickListener()
	arg_3_0._btnsummon1:RemoveClickListener()
	arg_3_0._btnsummon10:RemoveClickListener()
end

var_0_0.preloadList = {
	ResUrl.getSummonEquipIcon("full/bg_xxkc")
}

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg:LoadImage(ResUrl.getSummonEquipIcon("full/bg_xxkc"))
	arg_4_0._simagebgline01:LoadImage(ResUrl.getSummonEquipIcon("bg_summonline_01"))
	arg_4_0._simagebgline02:LoadImage(ResUrl.getSummonEquipIcon("bg_summonline_02"))
	arg_4_0._simageequipbg1:LoadImage(ResUrl.getSummonEquipIcon("bg_role_shade"))
	arg_4_0._simageequipbg2:LoadImage(ResUrl.getSummonEquipIcon("bg_role_shade"))
	arg_4_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	arg_4_0._animRoot = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_4_0:_initEquipItems()
end

local var_0_1 = 5
local var_0_2 = 6

function var_0_0._initEquipItems(arg_5_0)
	arg_5_0._equipItemsMap = arg_5_0._equipItemsMap or {}

	for iter_5_0 = 1, var_0_1 do
		local var_5_0 = arg_5_0["_goequip" .. tostring(iter_5_0)]

		if not gohelper.isNil(var_5_0) then
			local var_5_1 = arg_5_0:getUserDataTb_()

			var_5_1.go = var_5_0
			var_5_1.imageIcon = gohelper.findChildSingleImage(var_5_0, "simage_icon")
			var_5_1.btnDetail = gohelper.findChildButtonWithAudio(var_5_0, "btn_detail")

			var_5_1.btnDetail:AddClickListener(arg_5_0.onClickItem, arg_5_0, iter_5_0)

			arg_5_0._equipItemsMap[iter_5_0] = var_5_1
		end
	end
end

function var_0_0.onClickItem(arg_6_0, arg_6_1)
	local var_6_0 = SummonMainModel.instance:getCurPool()
	local var_6_1 = SummonMainModel.instance:getEquipDetailListByPool(var_6_0)[arg_6_1]

	if var_6_1 then
		local var_6_2 = EquipConfig.instance:getEquipCo(var_6_1.equipId)

		if var_6_2 then
			local var_6_3 = {
				equipId = var_6_2.id
			}

			EquipController.instance:openEquipView(var_6_3)
		end
	end
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_8_0.onSummonReply, arg_8_0)
	arg_8_0:addEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_8_0.onSummonFailed, arg_8_0)
	arg_8_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_8_0.onItemChanged, arg_8_0)
	arg_8_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_8_0.onItemChanged, arg_8_0)
	arg_8_0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_8_0.onInfoGot, arg_8_0)
	arg_8_0:addEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_8_0.playEnterAnim, arg_8_0)
	arg_8_0:addEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, arg_8_0._refreshOpenTime, arg_8_0)
	arg_8_0:playEnterAnim()
	arg_8_0:_refreshView()
end

function var_0_0.playEnterAnim(arg_9_0)
	if SummonMainModel.instance:getFirstTimeSwitch() then
		SummonMainModel.instance:setFirstTimeSwitch(false)
	end

	arg_9_0._animRoot:Play(SummonEnum.SummonEquipAnimationSwitch, 0, 0)
end

function var_0_0.onClose(arg_10_0)
	arg_10_0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_10_0.onSummonReply, arg_10_0)
	arg_10_0:removeEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_10_0.onSummonFailed, arg_10_0)
	arg_10_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_10_0.onItemChanged, arg_10_0)
	arg_10_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_10_0.onItemChanged, arg_10_0)
	arg_10_0:removeEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_10_0.onInfoGot, arg_10_0)
	arg_10_0:removeEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_10_0.playEnterAnim, arg_10_0)
	arg_10_0:removeEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, arg_10_0._refreshOpenTime, arg_10_0)
end

function var_0_0._btndetailOnClick(arg_11_0)
	local var_11_0 = SummonMainModel.instance:getCurPool()
	local var_11_1 = SummonMainModel.instance:getEquipDetailListByPool(var_11_0)

	if #var_11_1 == 0 then
		logError("no logo equip found, check summon_pool config first!")

		return
	end

	local var_11_2 = {
		equipId = var_11_1[1].equipCo.id
	}

	EquipController.instance:openEquipView(var_11_2)
end

function var_0_0._btnsummon1OnClick(arg_12_0)
	local var_12_0 = SummonMainModel.instance:getCurPool()

	if not var_12_0 then
		return
	end

	local var_12_1, var_12_2, var_12_3 = SummonMainModel.getCostByConfig(var_12_0.cost1)

	if SummonModel.instance:getFreeEquipSummon() then
		var_12_3 = 0
	end

	local var_12_4 = {
		type = var_12_1,
		id = var_12_2,
		quantity = var_12_3,
		callback = arg_12_0._summon1Confirm,
		callbackObj = arg_12_0
	}

	var_12_4.notEnough = false

	local var_12_5 = var_12_3 <= ItemModel.instance:getItemQuantity(var_12_1, var_12_2)
	local var_12_6 = SummonMainModel.instance.everyCostCount
	local var_12_7 = SummonMainModel.instance:getOwnCostCurrencyNum()

	if not var_12_5 and var_12_7 < var_12_6 then
		var_12_4.notEnough = true
	end

	if var_12_5 then
		var_12_4.needTransform = false

		arg_12_0:_summon1Confirm()

		return
	else
		var_12_4.needTransform = true
		var_12_4.cost_type = SummonMainModel.instance.costCurrencyType
		var_12_4.cost_id = SummonMainModel.instance.costCurrencyId
		var_12_4.cost_quantity = var_12_6
		var_12_4.miss_quantity = 1
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, var_12_4)
end

function var_0_0._summon1Confirm(arg_13_0)
	local var_13_0 = SummonMainModel.instance:getCurPool()

	if not var_13_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_13_0.id, 1, true, true)
end

function var_0_0._btnsummon10OnClick(arg_14_0)
	local var_14_0 = SummonMainModel.instance:getCurPool()

	if not var_14_0 then
		return
	end

	local var_14_1, var_14_2, var_14_3 = SummonMainModel.getCostByConfig(var_14_0.cost10)
	local var_14_4 = {
		type = var_14_1,
		id = var_14_2,
		quantity = var_14_3,
		callback = arg_14_0._summon10Confirm,
		callbackObj = arg_14_0
	}

	var_14_4.notEnough = false

	local var_14_5 = ItemModel.instance:getItemQuantity(var_14_1, var_14_2)
	local var_14_6 = var_14_3 <= var_14_5
	local var_14_7 = SummonMainModel.instance.everyCostCount
	local var_14_8 = SummonMainModel.instance:getOwnCostCurrencyNum()
	local var_14_9 = 10 - var_14_5
	local var_14_10 = var_14_7 * var_14_9

	if not var_14_6 and var_14_8 < var_14_10 then
		var_14_4.notEnough = true
	end

	if var_14_6 then
		var_14_4.needTransform = false

		arg_14_0:_summon10Confirm()

		return
	else
		var_14_4.needTransform = true
		var_14_4.cost_type = SummonMainModel.instance.costCurrencyType
		var_14_4.cost_id = SummonMainModel.instance.costCurrencyId
		var_14_4.cost_quantity = var_14_10
		var_14_4.miss_quantity = var_14_9
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, var_14_4)
end

function var_0_0._summon10Confirm(arg_15_0)
	local var_15_0 = SummonMainModel.instance:getCurPool()

	if not var_15_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_15_0.id, 10, false, false)
end

function var_0_0._refreshView(arg_16_0)
	arg_16_0.summonSuccess = false

	arg_16_0:_refreshCost()
	arg_16_0:_refreshEquips()
	arg_16_0:_refreshOpenTime()
end

var_0_0.SingleFreeTextPosX = 17.4
var_0_0.SingleCostTextPosX = 83.3

function var_0_0._refreshCost(arg_17_0)
	local var_17_0 = SummonMainModel.instance:getCurPool()

	if not var_17_0 then
		return
	end

	if SummonModel.instance:getFreeEquipSummon() then
		arg_17_0._txtsummon1.text = luaLang("summon_equip_free")

		recthelper.setAnchorX(arg_17_0._txtsummon1.transform, var_0_0.SingleFreeTextPosX)
		arg_17_0:_refreshSingleFree(var_17_0.cost1, arg_17_0._simagecurrency1, "_txtcurrency1")
		gohelper.setActive(arg_17_0._gosinglefree, true)
	else
		arg_17_0._txtsummon1.text = luaLang("summon_equip_one_times")

		recthelper.setAnchorX(arg_17_0._txtsummon1.transform, var_0_0.SingleCostTextPosX)
		arg_17_0:_refreshSingleCost(var_17_0.cost1, arg_17_0._simagecurrency1, "_txtcurrency1")
		gohelper.setActive(arg_17_0._gosinglefree, false)
	end

	arg_17_0:_refreshSingleCost(var_17_0.cost10, arg_17_0._simagecurrency10, "_txtcurrency10")
end

function var_0_0._refreshSingleCost(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0, var_18_1, var_18_2 = SummonMainModel.getCostByConfig(arg_18_1)
	local var_18_3 = SummonMainModel.getSummonItemIcon(var_18_0, var_18_1)

	gohelper.setActive(arg_18_2.gameObject, true)
	arg_18_2:LoadImage(var_18_3)

	local var_18_4

	var_18_4 = var_18_2 <= ItemModel.instance:getItemQuantity(var_18_0, var_18_1)
	arg_18_0[arg_18_3 .. "1"].text = luaLang("multiple") .. var_18_2
	arg_18_0[arg_18_3 .. "2"].text = ""
end

function var_0_0._refreshOpenTime(arg_19_0)
	local var_19_0 = SummonMainModel.instance:getCurPool()
	local var_19_1 = SummonMainModel.instance:getPoolServerMO(var_19_0.id)

	if var_19_1 ~= nil and var_19_1.offlineTime ~= 0 and var_19_1.offlineTime < TimeUtil.maxDateTimeStamp then
		local var_19_2 = var_19_1.offlineTime - ServerTime.now()

		arg_19_0._txtdeadline.text = string.format(luaLang("summonmainequipprobup_deadline"), SummonModel.formatRemainTime(var_19_2))
	else
		arg_19_0._txtdeadline.text = ""
	end
end

function var_0_0._refreshSingleFree(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0, var_20_1, var_20_2 = SummonMainModel.getCostByConfig(arg_20_1)
	local var_20_3 = SummonMainModel.getSummonItemIcon(var_20_0, var_20_1)

	gohelper.setActive(arg_20_2.gameObject, false)

	arg_20_0[arg_20_3 .. "1"].text = ""
	arg_20_0[arg_20_3 .. "2"].text = ""
end

function var_0_0._refreshEquips(arg_21_0)
	local var_21_0 = SummonMainModel.instance:getCurPool()
	local var_21_1 = SummonMainModel.instance:getEquipDetailListByPool(var_21_0)

	for iter_21_0 = 1, var_0_1 do
		local var_21_2 = arg_21_0._equipItemsMap[iter_21_0]

		if not var_21_1[iter_21_0] then
			if var_21_2 then
				var_21_2.go:SetActive(false)
			end
		elseif var_21_2 then
			arg_21_0:_refreshEquipItem(var_21_2, iter_21_0, var_21_1[iter_21_0])
		end
	end
end

function var_0_0._refreshEquipItem(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	arg_22_1.go:SetActive(true)

	local var_22_0 = EquipConfig.instance:getEquipCo(arg_22_3.equipId)

	arg_22_1.imageIcon:LoadImage(ResUrl.getSummonEquipIcon("img_role_" .. arg_22_2))
end

function var_0_0._applyStars(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = 1 + arg_23_2

	for iter_23_0 = 1, var_0_2 do
		gohelper.setActive(arg_23_1["star" .. tostring(iter_23_0)], iter_23_0 <= var_23_0)
	end
end

function var_0_0._applyRare(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = 1 + arg_24_2

	for iter_24_0 = 5, var_0_2 do
		gohelper.setActive(arg_24_1["rare" .. tostring(iter_24_0)], iter_24_0 == var_24_0)
	end
end

function var_0_0.onSummonFailed(arg_25_0)
	arg_25_0.summonSuccess = false

	arg_25_0:_refreshCost()
end

function var_0_0.onSummonReply(arg_26_0)
	arg_26_0.summonSuccess = true
end

function var_0_0.onItemChanged(arg_27_0)
	if SummonController.instance.isWaitingSummonResult or arg_27_0.summonSuccess then
		return
	end

	arg_27_0:_refreshCost()
end

function var_0_0.onInfoGot(arg_28_0)
	arg_28_0:_refreshCost()
end

function var_0_0.onDestroyView(arg_29_0)
	arg_29_0._simagebg:UnLoadImage()
	arg_29_0._simageequipbg1:UnLoadImage()
	arg_29_0._simageequipbg2:UnLoadImage()
	arg_29_0._simageline:UnLoadImage()

	if arg_29_0._equipItemsMap then
		for iter_29_0, iter_29_1 in pairs(arg_29_0._equipItemsMap) do
			iter_29_1.btnDetail:RemoveClickListener()
		end

		arg_29_0._equipItemsMap = nil
	end

	arg_29_0._simagecurrency1:UnLoadImage()
	arg_29_0._simagecurrency10:UnLoadImage()
	arg_29_0._simagebgline01:UnLoadImage()
	arg_29_0._simagebgline02:UnLoadImage()
end

return var_0_0
