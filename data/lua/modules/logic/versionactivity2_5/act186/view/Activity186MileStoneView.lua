module("modules.logic.versionactivity2_5.act186.view.Activity186MileStoneView", package.seeall)

slot0 = class("Activity186MileStoneView", BaseView)

function slot0.onInitView(slot0)
	slot0.btnStoneCanget = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/bonusNode/milestone/go_canget")
	slot0.txtStoneProgress = gohelper.findChildTextMesh(slot0.viewGO, "root/bonusNode/milestone/progress/txtprogress")
	slot0.itemGO = gohelper.findChild(slot0.viewGO, "root/bonusNode/#scroll_reward/Viewport/#go_content/rewarditem")

	gohelper.setActive(slot0.itemGO, false)

	slot0.goLine = gohelper.findChild(slot0.viewGO, "root/bonusNode/#scroll_reward/Viewport/#go_content/#go_normalline")
	slot0.trsLine = slot0.goLine.transform
	slot0.goContent = gohelper.findChild(slot0.viewGO, "root/bonusNode/#scroll_reward/Viewport/#go_content")
	slot0.contentTransform = slot0.goContent.transform
	slot0.goScroll = gohelper.findChild(slot0.viewGO, "root/bonusNode/#scroll_reward")
	slot0.scroll = gohelper.findChildScrollRect(slot0.viewGO, "root/bonusNode/#scroll_reward")
	slot0.scrollRect = gohelper.findChildComponent(slot0.viewGO, "root/bonusNode/#scroll_reward", typeof(ZProj.LimitedScrollRect))
	slot0.scrollWidth = recthelper.getWidth(slot0.goScroll.transform)
	slot0.goBubble = gohelper.findChild(slot0.viewGO, "root/bonusNode/bubble")
	slot0.btnSpBonus = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/bonusNode/bubble/btn")
	slot0.goreward = gohelper.findChild(slot0.viewGO, "root/bonusNode/bubble/goreward")

	gohelper.setActive(slot0.goBubble, false)

	slot0.cellSpace = 30
	slot0.bonusAnim = gohelper.findChildComponent(slot0.viewGO, "root/bonusNode", gohelper.Type_Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0.scroll:AddOnValueChanged(slot0.onValueChanged, slot0)
	slot0:addClickCb(slot0.btnStoneCanget, slot0.onClickBtnStoneCanget, slot0)
	slot0:addClickCb(slot0.btnSpBonus, slot0.onClickBtnSpBonus, slot0)
	slot0:addEventCb(Activity186Controller.instance, Activity186Event.GetDailyCollection, slot0.onGetDailyCollection, slot0)
	slot0:addEventCb(Activity186Controller.instance, Activity186Event.GetMilestoneReward, slot0.onGetMilestoneReward, slot0)
	slot0:addEventCb(Activity186Controller.instance, Activity186Event.UpdateInfo, slot0.onUpdateInfo, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.onCurrencyChange, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseView, slot0)
end

function slot0.removeEvents(slot0)
	slot0.scroll:RemoveOnValueChanged()
end

function slot0._editableInitView(slot0)
	slot0.txttips = gohelper.findChildTextMesh(slot0.viewGO, "root/bonusNode/tips/txt_tips")
	slot0.txttips.text = ServerTime.ReplaceUTCStr(luaLang("p_activity186taskview_txt_tips"))
end

function slot0.onValueChanged(slot0)
	slot0:refreshSpBonusReward()
end

function slot0.onClickBtnStoneCanget(slot0)
	Activity186Rpc.instance:sendGetAct186DailyCollectionRequest(slot0.actId)
end

function slot0.onClickBtnSpBonus(slot0)
	slot0:_moveToIndex(slot0._spBonusIndex)
end

function slot0.onCloseView(slot0, slot1)
	if slot1 == ViewName.CommonPropView and slot0._waitRefresh then
		slot0:refreshView()
	end
end

function slot0.onCurrencyChange(slot0, slot1)
	if not slot1 then
		return
	end

	if slot1[Activity186Config.instance:getConstNum(Activity186Enum.ConstId.CurrencyId)] then
		slot0._waitRefresh = true
	end
end

function slot0.onGetMilestoneReward(slot0)
	slot0:refreshList()
end

function slot0.onUpdateInfo(slot0)
	slot0:refreshView()
end

function slot0.onGetDailyCollection(slot0)
	slot0:refreshStone()
end

function slot0.onUpdateParam(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0:refreshParam()
	slot0:refreshView(true)
end

function slot0.refreshParam(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.actMo = Activity186Model.instance:getById(slot0.actId)

	Activity186MileStoneListModel.instance:init(slot0.actMo)
end

function slot0.refreshView(slot0)
	slot0._waitRefresh = false

	slot0:refreshStone()
	slot0:refreshList()
end

function slot0.refreshStone(slot0)
	slot4 = GameUtil.splitString2(Activity186Config.instance:getConstStr(Activity186Enum.ConstId.DailyStoneCount), true)[1][3]

	if not slot0.actMo.getDailyCollection then
		gohelper.setActive(slot0.btnStoneCanget, true)

		slot0.txtStoneProgress.text = string.format("%s/%s", slot4, slot4)
	else
		gohelper.setActive(slot0.btnStoneCanget, false)

		slot0.txtStoneProgress.text = string.format("0/%s", slot4)
	end
end

function slot0.refreshList(slot0)
	Activity186MileStoneListModel.instance:refresh()
	TaskDispatcher.cancelTask(slot0.refreshLine, slot0)
	TaskDispatcher.runDelay(slot0.refreshLine, slot0, 0.01)
end

function slot0.refreshLine(slot0)
	slot1 = Activity186MileStoneListModel.instance:caleProgressIndex()
	slot2 = math.floor(slot1)
	slot3 = slot0:getItemWidth(slot2)

	if slot1 - slot2 > 0 then
		slot4 = slot2 > 0 and slot0:getItemPosX(slot2) - 15 + (slot0:getItemWidth(slot2 + 1) + slot0.cellSpace) * slot5 or 72 * slot5
	end

	if slot0._moveTweenId then
		ZProj.TweenHelper.KillById(slot0._moveTweenId)

		slot0._moveTweenId = nil
	end

	if slot0._lineWith and slot0._lineWith ~= slot4 then
		slot0._lineWith = slot4
		slot0._moveTweenId = ZProj.TweenHelper.DOWidth(slot0.trsLine, slot4, 2)

		slot0.bonusAnim:Play("get", 0, 0)
	else
		slot0.bonusAnim:Play("idle")

		slot0._lineWith = slot4

		recthelper.setWidth(slot0.trsLine, slot4)
	end

	if not slot0.isOpen then
		slot0.isOpen = true

		slot0:moveToDefaultPos()
	end

	slot0:onValueChanged()
end

function slot0.caleProgressIndex(slot0, slot1)
	slot2 = 0
	slot4 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, Activity186Config.instance:getConstNum(Activity186Enum.ConstId.CurrencyId))
	slot5 = 0

	for slot9, slot10 in ipairs(slot1) do
		if slot4 < slot10.coinNum then
			return slot9 + (slot4 - slot5) / (slot11 - slot5) - 1
		end

		slot5 = slot11
	end

	slot5 = slot1[#slot1 - 1] and slot1[slot6 - 1].coinNum or 0
	slot8 = slot0.actMo.getMilestoneProgress
	slot9 = slot1[slot6].loopBonusIntervalNum or 1

	return slot8 < slot7.coinNum and slot6 or math.floor((slot8 - slot10) / slot9) < math.floor((slot4 - slot10) / slot9) and slot6 or slot6 - 1 + slot11 - slot12
end

function slot0.refreshSpBonusReward(slot0)
	if slot0._spBonusIndex == slot0:getSpBonusIndex() then
		return
	end

	slot0._spBonusIndex = slot1

	gohelper.setActive(slot0.goBubble, slot1 ~= nil)

	if slot1 ~= nil and Activity186Config.instance:getMileStoneList(slot0.actId)[slot1] then
		slot5 = GameUtil.splitString2(slot3.bonus, true)[1]

		if not slot0.itemIcon then
			slot0.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot0.goreward)
		end

		slot0.itemIcon:setMOValue(slot5[1], slot5[2], slot5[3])
		slot0.itemIcon:isShowQuality(false)
		slot0.itemIcon:isShowEquipAndItemCount(false)
		slot0.itemIcon:setCanShowDeadLine(false)
	end
end

function slot0.getSpBonusIndex(slot0)
	slot1 = recthelper.getAnchorX(slot0.contentTransform)
	slot2 = -(slot1 - slot0.scrollWidth)

	for slot8, slot9 in ipairs(Activity186MileStoneListModel.instance:getList()) do
		if slot9.isSpBonus then
			slot11 = slot0.actMo:getMilestoneRewardStatus(slot9.rewardId)

			if -slot1 <= slot0:getItemPosX(slot8) and slot10 <= slot2 and slot11 == Activity186Enum.RewardStatus.Canget then
				return
			end

			if slot2 < slot10 and slot11 ~= Activity186Enum.RewardStatus.Hasget then
				return slot8
			end
		end
	end
end

function slot0.getItemPosX(slot0, slot1)
	if slot1 <= 0 then
		return 0
	end

	return (slot1 - 1) * 240 + 95
end

function slot0.getItemWidth(slot0, slot1)
	if not slot1 then
		return 0
	end

	if Activity186MileStoneListModel.instance:getList()[slot1] then
		return 210
	end

	return 0
end

function slot0.moveToDefaultPos(slot0)
	slot2 = 1

	for slot6, slot7 in ipairs(Activity186Config.instance:getMileStoneList(slot0.actId)) do
		if slot0.actMo:getMilestoneRewardStatus(slot7.rewardId) ~= Activity186Enum.RewardStatus.Hasget then
			slot2 = slot6

			break
		end
	end

	slot0:_moveToIndex(slot2)
end

function slot0._moveToIndex(slot0, slot1)
	if not slot1 then
		return
	end

	slot0.viewContainer.mileStoneScrollView:moveToByIndex(slot1)
	slot0:onValueChanged()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.refreshLine, slot0)

	if slot0._moveTweenId then
		ZProj.TweenHelper.KillById(slot0._moveTweenId)

		slot0._moveTweenId = nil
	end
end

return slot0
