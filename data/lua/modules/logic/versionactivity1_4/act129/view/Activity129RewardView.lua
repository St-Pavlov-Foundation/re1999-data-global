module("modules.logic.versionactivity1_4.act129.view.Activity129RewardView", package.seeall)

slot0 = class("Activity129RewardView", BaseView)

function slot0.onInitView(slot0)
	slot0.goRewards = gohelper.findChild(slot0.viewGO, "#go_Rewards")
	slot0.goRewardItem = gohelper.findChild(slot0.goRewards, "#scroll_RewardList/Viewport/Content/#go_RewardItem")
	slot0.goBuy = gohelper.findChild(slot0.viewGO, "#go_Rewards/Buy")
	slot0.inputValue = gohelper.findChildTextMeshInputField(slot0.goBuy, "ValueBG/#input_Value")
	slot0.txtCost = gohelper.findChildTextMesh(slot0.goBuy, "#btn_Buy/#txt_Cost")
	slot0.simageIcon = gohelper.findChildSingleImage(slot0.goBuy, "#btn_Buy/#simage_CostIcon")
	slot0.txtBuy = gohelper.findChildTextMesh(slot0.goBuy, "#btn_Buy/txt_Buy")
	slot0.imgBuy = gohelper.findChildImage(slot0.goBuy, "#btn_Buy")
	slot0.btnBuy = gohelper.findChildButtonWithAudio(slot0.goBuy, "#btn_Buy")
	slot0.btnMax = gohelper.findChildButtonWithAudio(slot0.goBuy, "#btn_Max")
	slot0.btnMin = gohelper.findChildButtonWithAudio(slot0.goBuy, "#btn_Min")
	slot0.goAdd = gohelper.findChild(slot0.goBuy, "#btn_Add")
	slot0.goSub = gohelper.findChild(slot0.goBuy, "#btn_Sub")
	slot0.maxDisable = gohelper.findChild(slot0.goBuy, "#btn_Max/image_Disable")
	slot0.minDisable = gohelper.findChild(slot0.goBuy, "#btn_Min/image_Disable")
	slot0.goBack = gohelper.findChild(slot0.viewGO, "#go_BackBtns")
	slot0.goCurreny = gohelper.findChild(slot0.viewGO, "#go_CurrenyBar")
	slot0.txtTitleEn = gohelper.findChildTextMesh(slot0.goRewards, "RewardTitle/image_RewardTitleBG/txt_RewardTitleEn")
	slot0.txtTitle = gohelper.findChildTextMesh(slot0.goRewards, "RewardTitle/image_RewardTitleBG/txt_RewardTitle")
	slot0.anim = slot0.goRewards:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0.inputValue:AddOnValueChanged(slot0._onValueChanged, slot0)
	slot0:addClickCb(slot0.btnBuy, slot0.onClickBuy, slot0)
	slot0:addClickCb(slot0.btnMax, slot0.onClickMax, slot0)
	slot0:addClickCb(slot0.btnMin, slot0.onClickMin, slot0)
	slot0:addEventCb(Activity129Controller.instance, Activity129Event.OnEnterPool, slot0.onEnterPool, slot0)
	slot0:addEventCb(Activity129Controller.instance, Activity129Event.OnLotterySuccess, slot0.onLotterySuccess, slot0)
	slot0:addEventCb(Activity129Controller.instance, Activity129Event.OnLotteryEnd, slot0.onLotteryEnd, slot0)

	slot5 = slot0._onCurrencyChange

	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot5, slot0)

	slot1 = {
		0.5
	}

	for slot5 = 2, 10 do
		table.insert(slot1, math.max(0.7 * slot1[slot5 - 1], 0.1))
	end

	slot0._subPress = SLFramework.UGUI.UILongPressListener.Get(slot0.goSub)

	slot0._subPress:SetLongPressTime(slot1)
	slot0._subPress:AddLongPressListener(slot0._subLongPressTimeEnd, slot0)

	slot0._subClick = SLFramework.UGUI.UIClickListener.Get(slot0.goSub)

	slot0._subClick:AddClickListener(slot0.onClickSub, slot0)
	slot0._subClick:AddClickUpListener(slot0._subClickUp, slot0)

	slot0._addPress = SLFramework.UGUI.UILongPressListener.Get(slot0.goAdd)

	slot0._addPress:SetLongPressTime(slot1)
	slot0._addPress:AddLongPressListener(slot0._addLongPressTimeEnd, slot0)

	slot0._addClick = SLFramework.UGUI.UIClickListener.Get(slot0.goAdd)

	slot0._addClick:AddClickListener(slot0.onClickAdd, slot0)
	slot0._addClick:AddClickUpListener(slot0._addClickUp, slot0)
end

function slot0.removeEvents(slot0)
	slot0.inputValue:RemoveOnValueChanged()
	slot0:removeClickCb(slot0.btnBuy)
	slot0:removeClickCb(slot0.btnMax)
	slot0:removeClickCb(slot0.btnMin)
	slot0:removeEventCb(Activity129Controller.instance, Activity129Event.OnEnterPool, slot0.onEnterPool, slot0)
	slot0:removeEventCb(Activity129Controller.instance, Activity129Event.OnLotterySuccess, slot0.onLotterySuccess, slot0)
	slot0:removeEventCb(Activity129Controller.instance, Activity129Event.OnLotteryEnd, slot0.onLotteryEnd, slot0)
	slot0:removeEventCb(Activity129Controller.instance, Activity129Event.OnLotteryEnd, slot0.onLotteryEnd, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0._subPress:RemoveLongPressListener()
	slot0._subClick:RemoveClickListener()
	slot0._subClick:RemoveClickUpListener()
	slot0._addPress:RemoveLongPressListener()
	slot0._addClick:RemoveClickListener()
	slot0._addClick:RemoveClickUpListener()
end

function slot0._editableInitView(slot0)
	slot0.poolItems = {}
	slot0.rewardItems = {}

	for slot4 = 1, 2 do
		slot0.poolItems[slot4] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(slot0.goRewards, string.format("#scroll_RewardList/Viewport/Content/Reward%s", slot4)), Activity129RewardPoolItem, {
			goItem = slot0.goRewardItem,
			itemList = slot0.rewardItems,
			rare = slot4 == 1 and 5 or 4
		})
	end
end

function slot0._onCurrencyChange(slot0, slot1)
	if not slot0.actId then
		return
	end

	if not slot1[Activity129Config.instance:getConstValue1(slot0.actId, Activity129Enum.ConstEnum.CostId)] then
		return
	end

	slot0:refreshBuyButton()
end

function slot0.onLotterySuccess(slot0)
	gohelper.setActive(slot0.goBack, false)
	gohelper.setActive(slot0.goCurreny, false)
	slot0:setVisible(false)
end

function slot0.onLotteryEnd(slot0)
	gohelper.setActive(slot0.goBack, true)
	gohelper.setActive(slot0.goCurreny, true)
	slot0:refreshView()
end

function slot0.onEnterPool(slot0)
	slot0.curCount = 1

	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId

	slot0:refreshView()
end

function slot0.refreshView(slot0)
	if not Activity129Model.instance:getSelectPoolId() then
		slot0:setVisible(false)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	slot0:setVisible(true)
	slot0:refreshMaxCount()
	slot0:refreshReward()
	slot0:refreshBuy()
end

function slot0.refreshMaxCount(slot0)
	if not Activity129Model.instance:getSelectPoolId() then
		return
	end

	slot0.maxCount = Activity129Config.instance:getPoolConfig(slot0.actId, slot1).maxDraw or Activity129Config.instance:getConstValue1(slot0.actId, Activity129Enum.ConstEnum.MaxMoreDraw) or 1
	slot5, slot6 = Activity129Model.instance:getActivityMo(slot0.actId):getPoolMo(slot1):getPoolDrawCount()
	slot0.maxCount = math.min(slot0:_calcAffordableCount(1), slot0.maxCount)

	if slot6 > 0 then
		if slot6 - slot5 <= 0 then
			slot8 = 1
		end

		slot0.maxCount = math.min(slot8, slot0.maxCount)
	end

	slot0.maxCount = math.max(1, slot0.maxCount)
end

function slot0.refreshReward(slot0)
	if not Activity129Model.instance:getSelectPoolId() then
		return
	end

	for slot5, slot6 in ipairs(slot0.rewardItems) do
		slot6:setHideMark()
	end

	slot3 = {}

	if Activity129Config.instance:getGoodsDict(slot1) then
		for slot7, slot8 in pairs(slot2) do
			slot3[slot7] = GameUtil.splitString2(slot8.goodsId, true)
		end
	end

	for slot7, slot8 in ipairs(slot0.poolItems) do
		slot8:setDict(slot3, slot0.actId, slot1)
	end

	for slot7, slot8 in ipairs(slot0.rewardItems) do
		slot8:checkHide()
	end

	slot4 = Activity129Config.instance:getPoolConfig(slot0.actId, slot1)
	slot0.txtTitle.text = slot4.name
	slot0.txtTitleEn.text = slot4.nameEn
end

function slot0.refreshBuy(slot0)
	slot0:setInputTxt(slot0:getInputCount(0, slot0.curCount or slot0.maxCount))
	slot0:refreshBuyButton()
end

function slot0.refreshBuyButton(slot0)
	if not Activity129Model.instance:getSelectPoolId() then
		return
	end

	slot6 = string.splitToNumber(Activity129Config.instance:getPoolConfig(slot0.actId, slot1).cost, "#")
	slot8, slot9 = ItemModel.instance:getItemConfigAndIcon(slot6[1], slot6[2], true)

	slot0.simageIcon:LoadImage(slot9)

	slot0.txtCost.text = slot6[3] * tonumber(slot0.inputValue:GetText()) <= ItemModel.instance:getItemQuantity(slot6[1], slot6[2]) and tostring(slot7) or string.format("<color=#d33838>%s</color>", slot7)
	slot0.txtBuy.text = formatLuaLang("v1a4_tokenstore_confirm", GameUtil.getNum2Chinese(slot5))

	gohelper.setActive(slot0.maxDisable, false)
	gohelper.setActive(slot0.minDisable, false)
end

function slot0._onValueChanged(slot0)
	if not tonumber(slot0.inputValue:GetText()) or slot2 < 1 or slot0.maxCount < slot2 then
		slot0:setInputTxt(slot0:getInputCount(0, slot2))
	end

	slot0:refreshBuyButton()
end

function slot0.onClickBuy(slot0)
	if not Activity129Model.instance:getSelectPoolId() then
		return
	end

	if Activity129Model.instance:checkPoolIsEmpty(slot0.actId, slot1) then
		GameFacade.showToast(ToastEnum.Activity129PoolIsEmpty)
		Activity129Controller.instance:dispatchEvent(Activity129Event.OnClickEmptyPool)

		return
	end

	slot6 = string.splitToNumber(Activity129Config.instance:getPoolConfig(slot0.actId, slot1).cost, "#")
	slot7 = {}

	table.insert(slot7, {
		type = slot6[1],
		id = slot6[2],
		quantity = slot6[3] * (tonumber(slot0.inputValue:GetText()) or 1)
	})

	slot9, slot10, slot11 = ItemModel.instance:hasEnoughItems(slot7)

	if not slot10 then
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, slot11, slot9)

		return
	end

	if not Activity129Model.instance:getSelectPoolId() then
		return
	end

	Activity129Rpc.instance:sendAct129LotteryRequest(slot0.actId, slot12, slot5)
end

function slot0.onClickMin(slot0)
	slot0:setInputTxt(1)
end

function slot0.onClickMax(slot0)
	slot0:setInputTxt(slot0.maxCount)
end

function slot0.setInputTxt(slot0, slot1)
	slot0.curCount = tonumber(slot1)

	slot0.inputValue:SetText(tostring(slot1))
end

function slot0.getInputCount(slot0, slot1, slot2)
	return Mathf.Clamp((slot2 or tonumber(slot0.inputValue:GetText()) or slot0.curCount or 1) + (slot1 or 0), 1, slot0.maxCount)
end

function slot0.onClickAdd(slot0)
	slot0:setInputTxt(slot0:getInputCount(1))
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function slot0.onClickSub(slot0)
	slot0:setInputTxt(slot0:getInputCount(-1))
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function slot0._subLongPressTimeEnd(slot0)
	slot0._isLongPress = true

	slot0:setInputTxt(slot0:getInputCount(-1))

	if not slot0._isLongPress then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function slot0._subClickUp(slot0)
	slot0._isLongPress = false
end

function slot0._addLongPressTimeEnd(slot0)
	slot0._isLongPress = true

	slot0:setInputTxt(slot0:getInputCount(1))

	if not slot0._isLongPress then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function slot0._addClickUp(slot0)
	slot0._isLongPress = false
end

function slot0.setVisible(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._hide, slot0)

	if slot1 then
		gohelper.setActive(slot0.goRewards, true)
	else
		slot0.anim:Play("close")
		TaskDispatcher.runDelay(slot0._hide, slot0, 0.17)
	end
end

function slot0._hide(slot0)
	gohelper.setActive(slot0.goRewards, false)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._hide, slot0)
end

function slot0.onDestroyView(slot0)
	slot0.simageIcon:UnLoadImage()
end

function slot0._calcAffordableCount(slot0, slot1)
	if not Activity129Model.instance:getSelectPoolId() then
		return slot1 or 0
	end

	slot5 = string.splitToNumber(Activity129Config.instance:getPoolConfig(slot0.actId, slot2).cost, "#")

	return math.floor(ItemModel.instance:getItemQuantity(slot5[1], slot5[2]) / slot5[3])
end

return slot0
