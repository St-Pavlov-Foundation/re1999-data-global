module("modules.logic.versionactivity2_5.decoratestore.view.V2a5_DecorateStoreView", package.seeall)

slot0 = class("V2a5_DecorateStoreView", BaseView)

function slot0.onInitView(slot0)
	slot0.btnShop = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/Right/#btn_goto")
	slot0.txtLimitTime = gohelper.findChildTextMesh(slot0.viewGO, "Root/Right/#txt_LimitTime")
	slot0.btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0.items = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnShop, slot0._btngotoOnClick, slot0)

	if slot0.btnClose then
		slot0:addClickCb(slot0.btnClose, slot0.onClickBtnClose, slot0)
	end

	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, slot0.refreshView, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onClickBtnClose(slot0)
	slot0:closeThis()
end

function slot0._btngotoOnClick(slot0)
	if 10176 and slot1 ~= 0 then
		GameFacade.jump(slot1)
	end
end

function slot0.onUpdateParam(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	if slot0.viewParam and slot0.viewParam.parent then
		gohelper.addChild(slot1, slot0.viewGO)
	end

	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.refreshParam(slot0)
	slot0.actId = ActivityEnum.Activity.V2a5_DecorateStore
end

function slot0.refreshView(slot0)
	slot0:_showDeadline()
	slot0:refreshItems()
end

function slot0.refreshItems(slot0)
	for slot5, slot6 in ipairs(ActivityConfig.instance:getNorSignActivityCos(slot0.actId)) do
		if slot0:getOrCreateItem(slot5) then
			slot0:updateItem(slot7, slot6)
		end
	end
end

function slot0.getOrCreateItem(slot0, slot1)
	if not slot0.items[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot7 = slot1
		slot2.go = gohelper.findChild(slot0.viewGO, string.format("Root/Right/Day/go_day%s", slot7))
		slot2.rewards = {}

		for slot7 = 1, 3 do
			slot2.rewards[slot7] = slot0:createReward(slot3, slot7)
		end

		slot2.goTomorrow = gohelper.findChild(slot3, "#go_TomorrowTag")
		slot0.items[slot1] = slot2
	end

	return slot2
end

function slot0.updateItem(slot0, slot1, slot2)
	slot3 = slot2.id
	slot6 = ActivityType101Model.instance:getType101LoginCount(slot0.actId)
	slot11 = #GameUtil.splitString2(slot2.bonus, true)

	for slot11 = 1, math.max(#slot1.rewards, slot11) do
		slot0:updateReward(slot1.rewards[slot11], slot7[slot11], {
			actId = slot0.actId,
			index = slot3,
			rewardGet = ActivityType101Model.instance:isType101RewardGet(slot0.actId, slot3),
			couldGet = ActivityType101Model.instance:isType101RewardCouldGet(slot0.actId, slot3)
		})
	end

	gohelper.setActive(slot1.goTomorrow, slot3 == slot6 + 1)
end

function slot0.createReward(slot0, slot1, slot2)
	slot3 = slot0:getUserDataTb_()
	slot3.go = gohelper.findChild(slot1, string.format("reward/#go_rewarditem%s", slot2))
	slot3.iconGO = gohelper.findChild(slot3.go, "go_icon")
	slot3.goCanget = gohelper.findChild(slot3.go, "go_canget")
	slot3.goReceive = gohelper.findChild(slot3.go, "go_receive")

	return slot3
end

function slot0.updateReward(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	gohelper.setActive(slot1.go, slot2 ~= nil)

	if not slot2 then
		return
	end

	gohelper.setActive(slot1.goCanget, slot3.couldGet)
	gohelper.setActive(slot1.goReceive, slot3.rewardGet)

	if not slot1.itemIcon then
		slot1.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot1.iconGO)
	end

	slot1.itemIcon:setMOValue(slot2[1], slot2[2], slot2[3])
	slot1.itemIcon:setScale(0.7)
	slot1.itemIcon:setCountFontSize(46)
	slot1.itemIcon:setHideLvAndBreakFlag(true)
	slot1.itemIcon:hideEquipLvAndBreak(true)

	slot3.itemCo = slot2

	slot1.itemIcon:customOnClickCallback(uv0.onClickItemIcon, slot3)
end

function slot0.onClickItemIcon(slot0)
	slot2 = slot0.index

	if not ActivityModel.instance:isActOnLine(slot0.actId) then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	if ActivityType101Model.instance:isType101RewardCouldGet(slot1, slot2) then
		Activity101Rpc.instance:sendGet101BonusRequest(slot1, slot2)

		return
	end

	slot4 = slot0.itemCo

	MaterialTipController.instance:showMaterialInfo(slot4[1], slot4[2])
end

function slot0._showDeadline(slot0)
	slot0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	TaskDispatcher.runRepeat(slot0._onRefreshDeadline, slot0, 60)
end

function slot0._onRefreshDeadline(slot0)
	slot0.txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(slot0.actId)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
end

return slot0
