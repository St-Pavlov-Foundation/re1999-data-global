module("modules.logic.seasonver.act123.view2_0.Season123_2_0DecomposeView", package.seeall)

local var_0_0 = class("Season123_2_0DecomposeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocardpos = gohelper.findChild(arg_1_0.viewGO, "object/Info/card/#go_cardpos")
	arg_1_0._txtcardName = gohelper.findChildText(arg_1_0.viewGO, "object/Info/card/#txt_cardName")
	arg_1_0._simagegetCoin = gohelper.findChildSingleImage(arg_1_0.viewGO, "object/Info/coin/#simage_getCoin")
	arg_1_0._txtcoinName = gohelper.findChildText(arg_1_0.viewGO, "object/Info/coin/#txt_coinName")
	arg_1_0._inputvalue = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "object/#go_decompose/valuebg/#input_value")
	arg_1_0._btnmin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "object/#go_decompose/#btn_min")
	arg_1_0._btnsub = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "object/#go_decompose/#btn_sub")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "object/#go_decompose/#btn_add")
	arg_1_0._btnmax = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "object/#go_decompose/#btn_max")
	arg_1_0._simagecoin = gohelper.findChildSingleImage(arg_1_0.viewGO, "object/#go_decompose/decomposeGet/txt/#simage_coin")
	arg_1_0._txtgetCoin = gohelper.findChildText(arg_1_0.viewGO, "object/#go_decompose/decomposeGet/#txt_getCoin")
	arg_1_0._btndecompose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_decompose")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnmin:AddClickListener(arg_2_0._btnminOnClick, arg_2_0)
	arg_2_0._btnsub:AddClickListener(arg_2_0._btnsubOnClick, arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
	arg_2_0._btnmax:AddClickListener(arg_2_0._btnmaxOnClick, arg_2_0)
	arg_2_0._btndecompose:AddClickListener(arg_2_0._btndecomposeOnClick, arg_2_0)
	arg_2_0._inputvalue:AddOnEndEdit(arg_2_0._onEndEdit, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnmin:RemoveClickListener()
	arg_3_0._btnsub:RemoveClickListener()
	arg_3_0._btnadd:RemoveClickListener()
	arg_3_0._btnmax:RemoveClickListener()
	arg_3_0._btndecompose:RemoveClickListener()
	arg_3_0._inputvalue:RemoveOnEndEdit()
end

function var_0_0._btnminOnClick(arg_4_0)
	arg_4_0.curCount = arg_4_0.minDecomposeCount

	arg_4_0:refreshInfoBySelectCount()
end

function var_0_0._btnsubOnClick(arg_5_0)
	if arg_5_0.curCount <= arg_5_0.minDecomposeCount then
		arg_5_0.curCount = arg_5_0.minDecomposeCount

		return
	else
		arg_5_0.curCount = arg_5_0.curCount - 1
	end

	arg_5_0:refreshInfoBySelectCount()
end

function var_0_0._btnaddOnClick(arg_6_0)
	if arg_6_0.curCount >= arg_6_0.maxDecomposeCount then
		arg_6_0.curCount = arg_6_0.maxDecomposeCount

		GameFacade.showToast(ToastEnum.MaxEquips)

		return
	else
		arg_6_0.curCount = arg_6_0.curCount + 1
	end

	arg_6_0:refreshInfoBySelectCount()
end

function var_0_0._btnmaxOnClick(arg_7_0)
	arg_7_0.curCount = arg_7_0.maxDecomposeCount

	arg_7_0:refreshInfoBySelectCount()
end

function var_0_0._btndecomposeOnClick(arg_8_0)
	arg_8_0.selectDecomposeList = {}

	for iter_8_0 = 1, #arg_8_0.decomposeItemList do
		if iter_8_0 <= arg_8_0.curCount then
			table.insert(arg_8_0.selectDecomposeList, arg_8_0.decomposeItemList[iter_8_0])
		end
	end

	if Season123DecomposeModel.instance:isDecomposeItemUsedByHero(arg_8_0.selectDecomposeList) then
		GameFacade.showMessageBox(MessageBoxIdDefine.SeasonComposeMatIsEquiped, MsgBoxEnum.BoxType.Yes_No, arg_8_0.sendDecomposeEquipRequest, nil, nil, arg_8_0)
	else
		arg_8_0:sendDecomposeEquipRequest()
	end
end

function var_0_0.sendDecomposeEquipRequest(arg_9_0)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.selectDecomposeList) do
		table.insert(var_9_0, iter_9_1.uid)
	end

	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnDecomposeEffectPlay, var_9_0)
	arg_9_0:closeThis()
end

function var_0_0._onEndEdit(arg_10_0)
	local var_10_0 = tonumber(arg_10_0._inputvalue:GetText())

	var_10_0 = var_10_0 and math.floor(var_10_0)

	if not var_10_0 or var_10_0 <= 0 then
		var_10_0 = arg_10_0.minDecomposeCount
	end

	arg_10_0.curCount = math.max(math.min(var_10_0, arg_10_0.maxDecomposeCount), arg_10_0.minDecomposeCount)

	arg_10_0:refreshInfoBySelectCount()
end

function var_0_0._editableInitView(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0.itemId = arg_12_0.viewParam.itemId
	arg_12_0.actId = arg_12_0.viewParam.actId
	arg_12_0.curCount = 1
	arg_12_0.minDecomposeCount = 1
	arg_12_0.decomposeItemList = Season123DecomposeModel.instance:getDecomposeItemsByItemId(arg_12_0.actId, arg_12_0.itemId)
	arg_12_0.maxDecomposeCount = GameUtil.getTabLen(arg_12_0.decomposeItemList)

	arg_12_0:CreateCardIcon()
	arg_12_0:refreshUI()
end

function var_0_0.refreshUI(arg_13_0)
	arg_13_0.itemConfig = Season123Config.instance:getSeasonEquipCo(arg_13_0.itemId)
	arg_13_0._txtcardName.text = GameUtil.getSubPlaceholderLuaLang(luaLang("season123_decompose_cardName"), {
		arg_13_0.itemConfig.name,
		"1"
	})

	local var_13_0 = Season123Config.instance:getEquipItemCoin(arg_13_0.actId, Activity123Enum.Const.EquipItemCoin)

	arg_13_0.coinConfig = CurrencyConfig.instance:getCurrencyCo(var_13_0)

	arg_13_0._simagegetCoin:LoadImage(ResUrl.getCurrencyItemIcon(arg_13_0.coinConfig.icon))
	arg_13_0._simagecoin:LoadImage(ResUrl.getCurrencyItemIcon(arg_13_0.coinConfig.icon))

	arg_13_0._txtcoinName.text = GameUtil.getSubPlaceholderLuaLang(luaLang("season123_decompose_cardName2"), {
		arg_13_0.coinConfig.name,
		arg_13_0.itemConfig.decomposeGet
	})
	arg_13_0._txtgetCoin.text = luaLang("multiple") .. arg_13_0.curCount * arg_13_0.itemConfig.decomposeGet
end

function var_0_0.refreshInfoBySelectCount(arg_14_0)
	arg_14_0._inputvalue:SetText(arg_14_0.curCount)

	arg_14_0._txtgetCoin.text = luaLang("multiple") .. arg_14_0.curCount * arg_14_0.itemConfig.decomposeGet
end

function var_0_0.CreateCardIcon(arg_15_0)
	if not arg_15_0.cardIcon then
		local var_15_0 = arg_15_0.viewContainer:getSetting().otherRes[1]
		local var_15_1 = arg_15_0:getResInst(var_15_0, arg_15_0._gocardpos, "icon")

		arg_15_0.cardIcon = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_1, Season123_2_0CelebrityCardEquip)
	end

	arg_15_0.cardIcon:updateData(arg_15_0.itemId)
	arg_15_0.cardIcon:setClickCall(arg_15_0.showMaterialInfoTip, arg_15_0)
end

function var_0_0.showMaterialInfoTip(arg_16_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Season123EquipCard, arg_16_0.itemId)
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	if arg_18_0.cardIcon then
		arg_18_0.cardIcon:disposeUI()
	end
end

return var_0_0
