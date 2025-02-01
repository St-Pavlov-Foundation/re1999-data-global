module("modules.logic.rouge.view.RougeRewardLayout", package.seeall)

slot0 = class("RougeRewardLayout", LuaCompBase)

function slot0.initcomp(slot0, slot1, slot2, slot3)
	slot0._go = slot1

	gohelper.setActive(slot0._go, false)

	slot0._config = slot2

	for slot7, slot8 in ipairs(slot2) do
		slot0._stage = slot8.stage

		break
	end

	slot0._index = slot3
	slot0._imgSlider = gohelper.findChildImage(slot1, "Slider/image_SliderFG")
	slot0._imgSliderIcon = gohelper.findChildImage(slot1, "Slider/image_SliderFG/image_SliderFGIcon")
	slot0._goVxLight = gohelper.findChild(slot1, "Slider/image_SliderFG/image_SliderFGIcon/vx_light")
	slot0._goReward = gohelper.findChild(slot1, "Layout/#go_Reward")
	slot0._goExchange = gohelper.findChild(slot1, "Layout/#go_Exchange")
	slot0._btnExchange = gohelper.findChildButtonWithAudio(slot1, "Layout/#go_Exchange/btn")
	slot0._txtCost = gohelper.findChildText(slot1, "Layout/#go_Exchange/#txt_Cost")
	slot0._imgIcon = gohelper.findChildImage(slot1, "Layout/#go_Exchange/#txt_Cost/costIcon")
	slot0._animator = slot0._go:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(slot0._goVxLight, false)
	slot0:addEvents()

	slot0._rewardList = {}
	slot0._costConfig = RougeConfig.instance:getOutSideConstValueByID(RougeEnum.OutsideConst.RewardCost)
	slot4 = string.split(slot0._costConfig, "#")
	slot0._costNum = slot4[3]
	slot0._costId = slot4[2]
	slot0._costType = slot4[1]
	slot0._click = false
	slot0._currentSelectIndex = 1
	slot0._currentSelectId = nil
	slot0._longPressArr = {
		0.5,
		99999
	}

	slot0:_initItems()
	slot0:refreshSlider(slot0._config)

	slot0.itemspace = 186
	slot0._spacetime = 0.03
end

function slot0.refreshcomp(slot0, slot1)
	slot0._config = slot1
	slot2 = nil

	for slot6, slot7 in ipairs(slot1) do
		slot2 = slot7.stage

		break
	end

	if slot2 ~= slot0._stage then
		slot0:_onSwitchAnim(true)
		slot0:hideExchangeBtn()

		slot0._stage = slot2
		slot0._lastRate = nil
	else
		slot0:refreshItem()
		slot0:refreshSlider()
	end
end

function slot0.refreshItem(slot0)
	for slot4, slot5 in ipairs(slot0._config) do
		slot6 = slot0._rewardList[slot4]
		slot7 = string.split(slot5.value, "#")
		slot11, slot12 = ItemModel.instance:getItemConfigAndIcon(slot7[1], slot7[2], true)
		slot6.co = slot5
		slot6.id = slot5.id
		slot6.index = slot4
		slot6._txtNum.text = slot7[3]

		slot6._simageItem:LoadImage(slot12)
		UISpriteSetMgr.instance:setRougeSprite(slot6._imgQuality, "rouge_reward_quality" .. slot11.rare)

		slot13 = RougeRewardModel.instance:checkRewardGot(slot5.stage, slot5.id)

		gohelper.setActive(slot6._goClaimed, slot13)
		slot6._long:RemoveLongPressListener()

		function slot0.LongPressFunc()
			MaterialTipController.instance:showMaterialInfo(uv0, uv1)
		end

		slot6._long:AddLongPressListener(slot0.LongPressFunc, slot0)

		slot6._isLongPress = false

		if slot13 then
			slot14 = string.split(slot5.value, "#")
			slot15 = slot14[1]
			slot16 = slot14[2]
			slot17 = slot14[3]

			slot6._btn:AddClickListener(function ()
				MaterialTipController.instance:showMaterialInfo(uv0, uv1)
			end, slot0, slot6)
		else
			slot6._btn:AddClickListener(slot0._btnOnClick, slot0, slot6)
		end

		slot6._imgQuality.color = slot13 and uv0.Get or uv0.noGet
		slot6._imgItem.color = slot13 and uv0.Get or uv0.noGet
	end
end

function slot0.hideExchangeBtn(slot0)
	if slot0._click then
		gohelper.setActive(slot0._goExchange, false)

		slot0._click = false

		slot0:_refreshReward(false)
	end
end

function slot0.refreshSlider(slot0)
	if not slot0._config then
		return
	end

	slot1 = #slot0._config

	for slot6, slot7 in ipairs(slot0._config) do
		if RougeRewardModel.instance:checkRewardGot(slot7.stage, slot7.id) then
			slot2 = 0 + 1
		end
	end

	if not slot0._lastRate then
		slot0._lastRate = slot2 / slot1
	elseif slot0._lastRate ~= slot3 and slot3 == 1 then
		slot0._showAnim = true
		slot0._lastRate = slot3
	else
		slot0._showAnim = false
	end

	if not slot0._showAnim then
		slot0._imgSlider.fillAmount = slot3

		if slot0._imgSlider.fillAmount == 1 then
			UISpriteSetMgr.instance:setRougeSprite(slot0._imgSliderIcon, "rouge_reward_key1")
		else
			UISpriteSetMgr.instance:setRougeSprite(slot0._imgSliderIcon, "rouge_reward_key0")
		end
	end
end

slot0.noGet = Color(1, 1, 1, 1)
slot0.Get = Color(0.3, 0.3, 0.3, 1)

function slot0._initItems(slot0)
	for slot4, slot5 in ipairs(slot0._config) do
		slot7 = string.split(slot5.value, "#")
		slot10 = slot7[3]
		slot11, slot12 = ItemModel.instance:getItemConfigAndIcon(slot7[1], slot7[2], true)

		if not slot0._rewardList[slot4] then
			slot6 = slot0:getUserDataTb_()
			slot13 = gohelper.cloneInPlace(slot0._goReward, "reward" .. slot4)

			gohelper.setActive(slot13, true)

			slot6.go = slot13
			slot6.index = slot4
			slot6.co = slot5
			slot6.id = slot5.id
			slot6._imgQuality = gohelper.findChildImage(slot13, "#img_Quality")
			slot6._simageItem = gohelper.findChildSingleImage(slot13, "#simage_Item")
			slot6._imgItem = slot6._simageItem:GetComponent(gohelper.Type_Image)
			slot6._goSelected1 = gohelper.findChild(slot13, "#go_Selected1")
			slot6._goSelected2 = gohelper.findChild(slot13, "#go_Selected2")
			slot6._txtNum = gohelper.findChildText(slot13, "image_NumBG/#txt_Num")
			slot6._goClaimed = gohelper.findChild(slot13, "#go_Claimed")
			slot6._gobtn = gohelper.findChild(slot13, "btn")
			slot6._btn = gohelper.findChildButtonWithAudio(slot13, "btn")

			slot6._btn:AddClickListener(slot0._btnOnClick, slot0, slot6)

			slot6._long = SLFramework.UGUI.UILongPressListener.Get(slot6._btn.gameObject)

			slot6._long:SetLongPressTime(slot0._longPressArr)

			function slot0.LongPressFunc()
				MaterialTipController.instance:showMaterialInfo(uv0, uv1)
			end

			slot6._long:AddLongPressListener(slot0.LongPressFunc, slot0)

			slot6._isLongPress = false

			table.insert(slot0._rewardList, slot6)
		end

		slot6._txtNum.text = slot10

		slot6._simageItem:LoadImage(slot12)
		UISpriteSetMgr.instance:setRougeSprite(slot6._imgQuality, "rouge_reward_quality" .. slot11.rare)

		slot13 = RougeRewardModel.instance:checkRewardGot(slot5.stage, slot5.id)

		gohelper.setActive(slot6._goClaimed, slot13)

		slot6._imgQuality.color = slot13 and uv0.Get or uv0.noGet
		slot6._imgItem.color = slot13 and uv0.Get or uv0.noGet
	end

	slot0:_onSwitchAnim(false)
	gohelper.setAsLastSibling(slot0._goExchange)
	slot0._btnExchange:AddClickListener(slot0._onClickExChangeBtn, slot0)
end

function slot0._onEnterAnim(slot0)
	TaskDispatcher.cancelTask(slot0._onEnterAnim, slot0)
	gohelper.setActive(slot0._go, true)
	slot0._animator:Update(0)
	slot0._animator:Play("in", 0, 0)
	slot0:refreshItem()
	slot0:refreshSlider()
end

function slot0._onSwitchAnim(slot0, slot1)
	slot0._animator:Update(0)
	slot0._animator:Play("out", 0, 0)
	TaskDispatcher.runDelay(slot0._onEnterAnim, slot0, 0.03 * slot0._index + (slot1 and 0.167 or 0))
end

function slot0.addEvents(slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnClickReward, slot0.refreshLayout, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnGetRougeReward, slot0.OnGetRougeReward, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
end

function slot0._btnOnClick(slot0, slot1)
	if slot0._currentSelectIndex ~= slot1.index then
		if slot0._click then
			slot0._click = not slot0._click

			gohelper.setActive(slot0._goExchange, slot0._click)
			recthelper.setAnchorX(slot0._goExchange.transform, (slot1.index - 1) * slot0.itemspace - slot0.itemspace / 2)

			if slot0:_getUnlockNum(slot1.index) > 0 then
				slot4 = slot2 * slot0._costNum
				slot0._txtCost.text = slot4

				if RougeRewardModel.instance:getRewardPoint() < slot4 then
					slot0._txtCost.color = GameUtil.parseColor("#9F342C")
				else
					slot0._txtCost.color = GameUtil.parseColor("#E99B56")
				end

				UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imgIcon, string.format("%s_1", slot0._costId))
			end
		end

		slot0._currentSelectIndex = slot1.index
	end

	if slot0._currentSelectId ~= slot1.id then
		slot0._currentSelectId = slot1.id
	end

	RougeController.instance:dispatchEvent(RougeEvent.OnClickReward, slot0._index)
end

function slot0._onClickExChangeBtn(slot0)
	slot3 = 0

	if slot0:_getUnlockNum(slot0._currentSelectIndex) > 0 then
		if RougeRewardModel.instance:getRewardPoint() >= slot2 * slot0._costNum then
			RougeOutsideRpc.instance:sendRougeReceivePointBonusRequest(RougeOutsideModel.instance:season(), slot0._currentSelectId)
		else
			GameFacade.showToast(ToastEnum.ExchangeFreeDiamond)
		end

		AudioMgr.instance:trigger(AudioEnum.UI.RewardCommonClick)
	end
end

function slot0.refreshLayout(slot0, slot1)
	if slot0._index == slot1 then
		for slot5, slot6 in ipairs(slot0._rewardList) do
			slot7 = slot6.co

			if slot5 == slot0._currentSelectIndex and not RougeRewardModel.instance:checkRewardGot(slot7.stage, slot7.id) then
				slot0._click = not slot0._click

				gohelper.setActive(slot0._goExchange, slot0._click)
				recthelper.setAnchorX(slot0._goExchange.transform, (slot0._currentSelectIndex - 1) * slot0.itemspace - slot0.itemspace / 2)

				if slot0:_getUnlockNum(slot5) > 0 then
					slot11 = slot9 * slot0._costNum
					slot0._txtCost.text = slot11

					if RougeRewardModel.instance:getRewardPoint() < slot11 then
						slot0._txtCost.color = GameUtil.parseColor("#9F342C")
					else
						slot0._txtCost.color = GameUtil.parseColor("#E99B56")
					end

					UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imgIcon, string.format("%s_1", slot0._costId))
				end
			end
		end

		slot0:_refreshReward(slot0._click)
		slot0:refreshSlider(RougeRewardConfig.instance:getStageToLayourConfig(slot0._stage, slot0._index))
	else
		gohelper.setActive(slot0._goExchange, false)

		slot0._click = false

		slot0:_refreshReward(false)
	end
end

function slot0._refreshReward(slot0, slot1)
	if slot1 then
		for slot5, slot6 in ipairs(slot0._rewardList) do
			slot7 = slot6.co

			if not RougeRewardModel.instance:checkRewardGot(slot7.stage, slot7.id) then
				slot9 = slot6.index == slot0._currentSelectIndex

				if slot6.index <= slot0._currentSelectIndex then
					gohelper.setActive(slot6._goSelected1, not slot9)
					gohelper.setActive(slot6._goSelected2, slot9)
				else
					gohelper.setActive(slot6._goSelected1, false)
					gohelper.setActive(slot6._goSelected2, false)
				end
			else
				gohelper.setActive(slot6._goSelected1, false)
				gohelper.setActive(slot6._goSelected2, false)
			end
		end
	else
		for slot5, slot6 in ipairs(slot0._rewardList) do
			gohelper.setActive(slot6._goSelected1, slot1)
			gohelper.setActive(slot6._goSelected2, slot1)
		end
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.CommonPropView then
		gohelper.setActive(slot0._goVxLight, slot0._showAnim)

		slot0._imgSlider.fillAmount = slot0._lastRate

		if slot0._imgSlider.fillAmount == 1 then
			UISpriteSetMgr.instance:setRougeSprite(slot0._imgSliderIcon, "rouge_reward_key1")
		else
			UISpriteSetMgr.instance:setRougeSprite(slot0._imgSliderIcon, "rouge_reward_key0")
		end
	end
end

function slot0.OnGetRougeReward(slot0, slot1)
	slot0._click = false

	gohelper.setActive(slot0._goExchange, slot0._click)
	slot0:_refreshReward(false)
end

function slot0._getUnlockNum(slot0, slot1)
	for slot6 = 1, slot1 do
		slot7 = slot0._rewardList[slot6].co

		if not RougeRewardModel.instance:checkRewardGot(slot7.stage, slot7.id) then
			slot2 = 0 + 1
		end
	end

	return slot2
end

function slot0.onDestroy(slot0)
	slot0:removeEventCb(RougeController.instance, RougeEvent.OnClickReward, slot0.refreshLayout, slot0)
	slot0:removeEventCb(RougeController.instance, RougeEvent.OnGetRougeReward, slot0.OnGetRougeReward, slot0)

	slot4 = ViewEvent.OnCloseView
	slot5 = slot0._onCloseViewFinish

	slot0:removeEventCb(ViewMgr.instance, slot4, slot5, slot0)
	TaskDispatcher.cancelTask(slot0._onEnterAnim, slot0)

	for slot4, slot5 in pairs(slot0._rewardList) do
		slot5._btn:RemoveClickListener()
		slot5._long:RemoveLongPressListener()
	end

	slot0._btnExchange:RemoveClickListener()
end

return slot0
