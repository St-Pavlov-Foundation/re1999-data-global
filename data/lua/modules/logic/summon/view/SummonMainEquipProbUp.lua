module("modules.logic.summon.view.SummonMainEquipProbUp", package.seeall)

local var_0_0 = class("SummonMainEquipProbUp", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simageequip1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_equip1")
	arg_1_0._simageequip2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_equip2")
	arg_1_0._simageequip3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_equip3")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/#txt_deadline/#simage_line")
	arg_1_0._goui = gohelper.findChild(arg_1_0.viewGO, "#go_ui")
	arg_1_0._goequip1 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/equip/right/#go_equip1")
	arg_1_0._goequip2 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/equip/right/#go_equip2")
	arg_1_0._goequip3 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/equip/right/#go_equip3")
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
	arg_1_0._txtdeadline = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/#txt_deadline")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnsummon1:AddClickListener(arg_2_0._btnsummon1OnClick, arg_2_0)
	arg_2_0._btnsummon10:AddClickListener(arg_2_0._btnsummon10OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnsummon1:RemoveClickListener()
	arg_3_0._btnsummon10:RemoveClickListener()
end

var_0_0.preloadList = {
	ResUrl.getSummonEquipIcon("full/bg")
}

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:initConst()
	arg_4_0:refreshSingleImage()

	arg_4_0._animRoot = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_4_0:_initEquipItems()
end

local var_0_1 = 6

function var_0_0.initConst(arg_5_0)
	arg_5_0._uiMaxLocation = 3
end

function var_0_0._initEquipItems(arg_6_0)
	arg_6_0._equipItemsMap = arg_6_0._equipItemsMap or {}

	for iter_6_0 = 1, arg_6_0._uiMaxLocation do
		local var_6_0 = arg_6_0["_goequip" .. tostring(iter_6_0)]

		if not gohelper.isNil(var_6_0) then
			local var_6_1 = arg_6_0:getUserDataTb_()

			var_6_1.go = var_6_0
			var_6_1.txtName = gohelper.findChildText(var_6_0, "name")
			var_6_1.btnDetail = gohelper.findChildButtonWithAudio(var_6_0, "btn_detail")

			var_6_1.btnDetail:AddClickListener(arg_6_0.onClickItem, arg_6_0, iter_6_0)

			for iter_6_1 = 1, var_0_1 do
				var_6_1["star" .. iter_6_1] = gohelper.findChild(var_6_0, "stars/go_star" .. tostring(iter_6_1))
			end

			for iter_6_2 = 5, var_0_1 do
				var_6_1["rare" .. iter_6_2] = gohelper.findChild(var_6_0, "rare/rare" .. tostring(iter_6_2))
			end

			arg_6_0._equipItemsMap[iter_6_0] = var_6_1
		end
	end
end

function var_0_0.onDestroyView(arg_7_0)
	if arg_7_0._equipItemsMap then
		for iter_7_0, iter_7_1 in pairs(arg_7_0._equipItemsMap) do
			iter_7_1.btnDetail:RemoveClickListener()
		end

		arg_7_0._equipItemsMap = nil
	end

	arg_7_0:unloadSingleImage()
end

function var_0_0.refreshSingleImage(arg_8_0)
	arg_8_0._simagebg:LoadImage(ResUrl.getSummonEquipIcon("full/bg"))
	arg_8_0._simageequip1:LoadImage(ResUrl.getSummonEquipIcon("img_role_6"))
	arg_8_0._simageequip2:LoadImage(ResUrl.getSummonEquipIcon("img_role_7"))
	arg_8_0._simageequip3:LoadImage(ResUrl.getSummonEquipIcon("img_role_8"))
	arg_8_0._simageline:LoadImage(ResUrl.getSummonCoverBg("hero/title_img_deco"))
end

function var_0_0.unloadSingleImage(arg_9_0)
	arg_9_0._simagebg:UnLoadImage()
	arg_9_0._simageequip1:UnLoadImage()
	arg_9_0._simageequip2:UnLoadImage()
	arg_9_0._simageequip3:UnLoadImage()
	arg_9_0._simageline:UnLoadImage()
	arg_9_0._simagecurrency1:UnLoadImage()
	arg_9_0._simagecurrency10:UnLoadImage()
end

function var_0_0.onClickItem(arg_10_0, arg_10_1)
	local var_10_0 = SummonMainModel.instance:getCurPool()
	local var_10_1 = SummonMainModel.instance:getEquipDetailListByPool(var_10_0)[arg_10_1]

	if var_10_1 then
		local var_10_2 = EquipConfig.instance:getEquipCo(var_10_1.equipId)

		if var_10_2 then
			local var_10_3 = {
				equipId = var_10_2.id
			}

			EquipController.instance:openEquipView(var_10_3)
		end
	end
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_12_0.onSummonReply, arg_12_0)
	arg_12_0:addEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_12_0.onSummonFailed, arg_12_0)
	arg_12_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_12_0.onItemChanged, arg_12_0)
	arg_12_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_12_0.onItemChanged, arg_12_0)
	arg_12_0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_12_0.onInfoGot, arg_12_0)
	arg_12_0:addEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_12_0.playEnterAnim, arg_12_0)
	arg_12_0:addEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, arg_12_0._refreshOpenTime, arg_12_0)
	arg_12_0:playEnterAnim()
	arg_12_0:_refreshView()
end

function var_0_0.playEnterAnim(arg_13_0)
	if SummonMainModel.instance:getFirstTimeSwitch() then
		SummonMainModel.instance:setFirstTimeSwitch(false)
	end

	if arg_13_0._animRoot then
		arg_13_0._animRoot:Play(SummonEnum.SummonEquipAnimationSwitch, 0, 0)
	end
end

function var_0_0.onClose(arg_14_0)
	arg_14_0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_14_0.onSummonReply, arg_14_0)
	arg_14_0:removeEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_14_0.onSummonFailed, arg_14_0)
	arg_14_0:removeEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_14_0.playEnterAnim, arg_14_0)
	arg_14_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_14_0.onItemChanged, arg_14_0)
	arg_14_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_14_0.onItemChanged, arg_14_0)
	arg_14_0:removeEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_14_0.onInfoGot, arg_14_0)
	arg_14_0:removeEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, arg_14_0._refreshOpenTime, arg_14_0)
end

function var_0_0._btnsummon1OnClick(arg_15_0)
	local var_15_0 = SummonMainModel.instance:getCurPool()

	if not var_15_0 then
		return
	end

	local var_15_1, var_15_2, var_15_3 = SummonMainModel.getCostByConfig(var_15_0.cost1)
	local var_15_4 = {
		type = var_15_1,
		id = var_15_2,
		quantity = var_15_3,
		callback = arg_15_0._summon1Confirm,
		callbackObj = arg_15_0
	}

	var_15_4.notEnough = false

	local var_15_5 = var_15_3 <= ItemModel.instance:getItemQuantity(var_15_1, var_15_2)
	local var_15_6 = SummonMainModel.instance.everyCostCount
	local var_15_7 = SummonMainModel.instance:getOwnCostCurrencyNum()

	if not var_15_5 and var_15_7 < var_15_6 then
		var_15_4.notEnough = true
	end

	if var_15_5 then
		var_15_4.needTransform = false

		arg_15_0:_summon1Confirm()

		return
	else
		var_15_4.needTransform = true
		var_15_4.cost_type = SummonMainModel.instance.costCurrencyType
		var_15_4.cost_id = SummonMainModel.instance.costCurrencyId
		var_15_4.cost_quantity = var_15_6
		var_15_4.miss_quantity = 1
	end

	SummonMainController.instance:openSummonConfirmView(var_15_4)
end

function var_0_0._summon1Confirm(arg_16_0)
	local var_16_0 = SummonMainModel.instance:getCurPool()

	if not var_16_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_16_0.id, 1, false, true)
end

function var_0_0._btnsummon10OnClick(arg_17_0)
	local var_17_0 = SummonMainModel.instance:getCurPool()

	if not var_17_0 then
		return
	end

	local var_17_1, var_17_2, var_17_3 = SummonMainModel.getCostByConfig(var_17_0.cost10)
	local var_17_4 = {
		type = var_17_1,
		id = var_17_2,
		quantity = var_17_3,
		callback = arg_17_0._summon10Confirm,
		callbackObj = arg_17_0
	}

	var_17_4.notEnough = false

	local var_17_5 = ItemModel.instance:getItemQuantity(var_17_1, var_17_2)
	local var_17_6 = var_17_3 <= var_17_5
	local var_17_7 = SummonMainModel.instance.everyCostCount
	local var_17_8 = SummonMainModel.instance:getOwnCostCurrencyNum()
	local var_17_9 = 10 - var_17_5
	local var_17_10 = var_17_7 * var_17_9

	if not var_17_6 and var_17_8 < var_17_10 then
		var_17_4.notEnough = true
	end

	if var_17_6 then
		var_17_4.needTransform = false

		arg_17_0:_summon10Confirm()

		return
	else
		var_17_4.needTransform = true
		var_17_4.cost_type = SummonMainModel.instance.costCurrencyType
		var_17_4.cost_id = SummonMainModel.instance.costCurrencyId
		var_17_4.cost_quantity = var_17_10
		var_17_4.miss_quantity = var_17_9
	end

	SummonMainController.instance:openSummonConfirmView(var_17_4)
end

function var_0_0._summon10Confirm(arg_18_0)
	local var_18_0 = SummonMainModel.instance:getCurPool()

	if not var_18_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_18_0.id, 10, false, true)
end

function var_0_0._refreshView(arg_19_0)
	arg_19_0.summonSuccess = false

	arg_19_0:_refreshCost()
	arg_19_0:_refreshEquips()
	arg_19_0:_refreshOpenTime()
end

function var_0_0._refreshOpenTime(arg_20_0)
	local var_20_0 = SummonMainModel.instance:getCurPool()

	if not var_20_0 then
		return
	end

	local var_20_1 = SummonMainModel.instance:getPoolServerMO(var_20_0.id)

	if var_20_1 ~= nil and var_20_1.offlineTime ~= 0 and var_20_1.offlineTime < TimeUtil.maxDateTimeStamp then
		local var_20_2 = var_20_1.offlineTime - ServerTime.now()

		arg_20_0._txtdeadline.text = string.format(luaLang("summonmainequipprobup_deadline"), SummonModel.formatRemainTime(var_20_2))
	else
		arg_20_0._txtdeadline.text = ""
	end
end

var_0_0.SingleFreeTextPosX = 17.4
var_0_0.SingleCostTextPosX = 83.3

function var_0_0._refreshCost(arg_21_0)
	local var_21_0 = SummonMainModel.instance:getCurPool()

	arg_21_0._txtsummon1.text = luaLang("summon_equip_one_times")

	recthelper.setAnchorX(arg_21_0._txtsummon1.transform, var_0_0.SingleCostTextPosX)
	gohelper.setActive(arg_21_0._gosinglefree, false)

	if var_21_0 then
		arg_21_0:_refreshSingleCost(var_21_0.cost1, arg_21_0._simagecurrency1, "_txtcurrency1")
		arg_21_0:_refreshSingleCost(var_21_0.cost10, arg_21_0._simagecurrency10, "_txtcurrency10")
	end
end

function var_0_0._refreshSingleCost(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0, var_22_1, var_22_2 = SummonMainModel.getCostByConfig(arg_22_1)
	local var_22_3 = SummonMainModel.getSummonItemIcon(var_22_0, var_22_1)

	gohelper.setActive(arg_22_2.gameObject, true)
	arg_22_2:LoadImage(var_22_3)

	local var_22_4

	var_22_4 = var_22_2 <= ItemModel.instance:getItemQuantity(var_22_0, var_22_1)
	arg_22_0[arg_22_3 .. "1"].text = luaLang("multiple") .. var_22_2
	arg_22_0[arg_22_3 .. "2"].text = ""
end

function var_0_0._refreshSingleFree(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0, var_23_1, var_23_2 = SummonMainModel.getCostByConfig(arg_23_1)
	local var_23_3 = SummonMainModel.getSummonItemIcon(var_23_0, var_23_1)

	gohelper.setActive(arg_23_2.gameObject, false)

	arg_23_0[arg_23_3 .. "1"].text = ""
	arg_23_0[arg_23_3 .. "2"].text = ""
end

function var_0_0._refreshEquips(arg_24_0)
	local var_24_0 = SummonMainModel.instance:getCurPool()
	local var_24_1 = SummonMainModel.instance:getEquipDetailListByPool(var_24_0)

	for iter_24_0 = 1, arg_24_0._uiMaxLocation do
		local var_24_2 = arg_24_0._equipItemsMap[iter_24_0]

		if not var_24_1[iter_24_0] then
			if var_24_2 then
				var_24_2.go:SetActive(false)
			end
		elseif var_24_2 then
			arg_24_0:_refreshEquipItem(var_24_2, iter_24_0, var_24_1[iter_24_0])
		end
	end
end

function var_0_0._refreshEquipItem(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	arg_25_1.go:SetActive(true)

	local var_25_0 = EquipConfig.instance:getEquipCo(arg_25_3.equipId)

	arg_25_1.txtName.text = var_25_0.name

	arg_25_0:_applyStars(arg_25_1, var_25_0.rare)
	arg_25_0:_applyRare(arg_25_1, var_25_0.rare)
end

function var_0_0._applyStars(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = 1 + arg_26_2

	for iter_26_0 = 1, var_0_1 do
		gohelper.setActive(arg_26_1["star" .. tostring(iter_26_0)], iter_26_0 <= var_26_0)
	end
end

function var_0_0._applyRare(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = 1 + arg_27_2

	for iter_27_0 = 5, var_0_1 do
		gohelper.setActive(arg_27_1["rare" .. tostring(iter_27_0)], iter_27_0 == var_27_0)
	end
end

function var_0_0.onSummonFailed(arg_28_0)
	arg_28_0.summonSuccess = false

	arg_28_0:_refreshCost()
end

function var_0_0.onSummonReply(arg_29_0)
	arg_29_0.summonSuccess = true
end

function var_0_0.onItemChanged(arg_30_0)
	if SummonController.instance.isWaitingSummonResult or arg_30_0.summonSuccess then
		return
	end

	arg_30_0:_refreshCost()
end

function var_0_0.onInfoGot(arg_31_0)
	arg_31_0:_refreshCost()
end

return var_0_0
