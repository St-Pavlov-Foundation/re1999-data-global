module("modules.logic.seasonver.act123.view2_0.Season123_2_0DecomposeView", package.seeall)

slot0 = class("Season123_2_0DecomposeView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocardpos = gohelper.findChild(slot0.viewGO, "object/Info/card/#go_cardpos")
	slot0._txtcardName = gohelper.findChildText(slot0.viewGO, "object/Info/card/#txt_cardName")
	slot0._simagegetCoin = gohelper.findChildSingleImage(slot0.viewGO, "object/Info/coin/#simage_getCoin")
	slot0._txtcoinName = gohelper.findChildText(slot0.viewGO, "object/Info/coin/#txt_coinName")
	slot0._inputvalue = gohelper.findChildTextMeshInputField(slot0.viewGO, "object/#go_decompose/valuebg/#input_value")
	slot0._btnmin = gohelper.findChildButtonWithAudio(slot0.viewGO, "object/#go_decompose/#btn_min")
	slot0._btnsub = gohelper.findChildButtonWithAudio(slot0.viewGO, "object/#go_decompose/#btn_sub")
	slot0._btnadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "object/#go_decompose/#btn_add")
	slot0._btnmax = gohelper.findChildButtonWithAudio(slot0.viewGO, "object/#go_decompose/#btn_max")
	slot0._simagecoin = gohelper.findChildSingleImage(slot0.viewGO, "object/#go_decompose/decomposeGet/txt/#simage_coin")
	slot0._txtgetCoin = gohelper.findChildText(slot0.viewGO, "object/#go_decompose/decomposeGet/#txt_getCoin")
	slot0._btndecompose = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_decompose")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnmin:AddClickListener(slot0._btnminOnClick, slot0)
	slot0._btnsub:AddClickListener(slot0._btnsubOnClick, slot0)
	slot0._btnadd:AddClickListener(slot0._btnaddOnClick, slot0)
	slot0._btnmax:AddClickListener(slot0._btnmaxOnClick, slot0)
	slot0._btndecompose:AddClickListener(slot0._btndecomposeOnClick, slot0)
	slot0._inputvalue:AddOnEndEdit(slot0._onEndEdit, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnmin:RemoveClickListener()
	slot0._btnsub:RemoveClickListener()
	slot0._btnadd:RemoveClickListener()
	slot0._btnmax:RemoveClickListener()
	slot0._btndecompose:RemoveClickListener()
	slot0._inputvalue:RemoveOnEndEdit()
end

function slot0._btnminOnClick(slot0)
	slot0.curCount = slot0.minDecomposeCount

	slot0:refreshInfoBySelectCount()
end

function slot0._btnsubOnClick(slot0)
	if slot0.curCount <= slot0.minDecomposeCount then
		slot0.curCount = slot0.minDecomposeCount

		return
	else
		slot0.curCount = slot0.curCount - 1
	end

	slot0:refreshInfoBySelectCount()
end

function slot0._btnaddOnClick(slot0)
	if slot0.maxDecomposeCount <= slot0.curCount then
		slot0.curCount = slot0.maxDecomposeCount

		GameFacade.showToast(ToastEnum.MaxEquips)

		return
	else
		slot0.curCount = slot0.curCount + 1
	end

	slot0:refreshInfoBySelectCount()
end

function slot0._btnmaxOnClick(slot0)
	slot0.curCount = slot0.maxDecomposeCount

	slot0:refreshInfoBySelectCount()
end

function slot0._btndecomposeOnClick(slot0)
	slot0.selectDecomposeList = {}

	for slot4 = 1, #slot0.decomposeItemList do
		if slot4 <= slot0.curCount then
			table.insert(slot0.selectDecomposeList, slot0.decomposeItemList[slot4])
		end
	end

	if Season123DecomposeModel.instance:isDecomposeItemUsedByHero(slot0.selectDecomposeList) then
		GameFacade.showMessageBox(MessageBoxIdDefine.SeasonComposeMatIsEquiped, MsgBoxEnum.BoxType.Yes_No, slot0.sendDecomposeEquipRequest, nil, , slot0)
	else
		slot0:sendDecomposeEquipRequest()
	end
end

function slot0.sendDecomposeEquipRequest(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.selectDecomposeList) do
		table.insert(slot1, slot6.uid)
	end

	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnDecomposeEffectPlay, slot1)
	slot0:closeThis()
end

function slot0._onEndEdit(slot0)
	if not tonumber(slot0._inputvalue:GetText()) or not math.floor(slot1) or slot1 <= 0 then
		slot1 = slot0.minDecomposeCount
	end

	slot0.curCount = math.max(math.min(slot1, slot0.maxDecomposeCount), slot0.minDecomposeCount)

	slot0:refreshInfoBySelectCount()
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	slot0.itemId = slot0.viewParam.itemId
	slot0.actId = slot0.viewParam.actId
	slot0.curCount = 1
	slot0.minDecomposeCount = 1
	slot0.decomposeItemList = Season123DecomposeModel.instance:getDecomposeItemsByItemId(slot0.actId, slot0.itemId)
	slot0.maxDecomposeCount = GameUtil.getTabLen(slot0.decomposeItemList)

	slot0:CreateCardIcon()
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0.itemConfig = Season123Config.instance:getSeasonEquipCo(slot0.itemId)
	slot0._txtcardName.text = GameUtil.getSubPlaceholderLuaLang(luaLang("season123_decompose_cardName"), {
		slot0.itemConfig.name,
		"1"
	})
	slot0.coinConfig = CurrencyConfig.instance:getCurrencyCo(Season123Config.instance:getEquipItemCoin(slot0.actId, Activity123Enum.Const.EquipItemCoin))

	slot0._simagegetCoin:LoadImage(ResUrl.getCurrencyItemIcon(slot0.coinConfig.icon))
	slot0._simagecoin:LoadImage(ResUrl.getCurrencyItemIcon(slot0.coinConfig.icon))

	slot0._txtcoinName.text = GameUtil.getSubPlaceholderLuaLang(luaLang("season123_decompose_cardName2"), {
		slot0.coinConfig.name,
		slot0.itemConfig.decomposeGet
	})
	slot0._txtgetCoin.text = luaLang("multiple") .. slot0.curCount * slot0.itemConfig.decomposeGet
end

function slot0.refreshInfoBySelectCount(slot0)
	slot0._inputvalue:SetText(slot0.curCount)

	slot0._txtgetCoin.text = luaLang("multiple") .. slot0.curCount * slot0.itemConfig.decomposeGet
end

function slot0.CreateCardIcon(slot0)
	if not slot0.cardIcon then
		slot0.cardIcon = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gocardpos, "icon"), Season123_2_0CelebrityCardEquip)
	end

	slot0.cardIcon:updateData(slot0.itemId)
	slot0.cardIcon:setClickCall(slot0.showMaterialInfoTip, slot0)
end

function slot0.showMaterialInfoTip(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Season123EquipCard, slot0.itemId)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0.cardIcon then
		slot0.cardIcon:disposeUI()
	end
end

return slot0
