module("modules.logic.turnback.view.new.view.TurnbackDoubleRewardChargeView", package.seeall)

slot0 = class("TurnbackDoubleRewardChargeView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._btnbgclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "close")
	slot0._btnbuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "content/#btn_buy")
	slot0._txtcost = gohelper.findChildText(slot0.viewGO, "content/#btn_buy/#txt_cost")
	slot0._golockreward = gohelper.findChild(slot0.viewGO, "content/lockreward/reward")
	slot0._gounlockreward1 = gohelper.findChild(slot0.viewGO, "content/unlockreward/reward1")
	slot0._gounlockreward2 = gohelper.findChild(slot0.viewGO, "content/unlockreward/reward2")
	slot0._contentanim = gohelper.findChild(slot0.viewGO, "content"):GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btnclsoeOnClick, slot0)
	slot0._btnbgclose:AddClickListener(slot0._btnclsoeOnClick, slot0)
	slot0._btnbuy:AddClickListener(slot0._btnbuyOnClick, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.AfterBuyDoubleReward, slot0.succbuydoublereward, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnbgclose:RemoveClickListener()
	slot0._btnbuy:RemoveClickListener()
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.AfterBuyDoubleReward, slot0.succbuydoublereward, slot0)
end

function slot0._btnbuyOnClick(slot0)
	TurnbackRpc.instance:sendBuyDoubleBonusRequest(TurnbackModel.instance:getCurTurnbackId())
end

function slot0.succbuydoublereward(slot0)
	slot0._contentanim:Play("unlock")
	TaskDispatcher.runDelay(slot0.afterAnim, slot0, 0.8)
end

function slot0.afterAnim(slot0)
	slot0:closeThis()
end

function slot0._btnclsoeOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.rewardList = {}

	slot0:getRewardIcon(slot0._golockreward)
	slot0:getRewardIcon(slot0._gounlockreward1)
	slot0:getRewardIcon(slot0._gounlockreward2)
end

function slot0.getRewardIcon(slot0, slot1)
	slot2 = {}

	for slot6 = 1, 4 do
		table.insert(slot2, gohelper.findChild(slot1, "icon" .. slot6))
	end

	table.insert(slot0.rewardList, slot2)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot1 = TurnbackModel.instance:getAllBonus()

	for slot5, slot6 in ipairs(slot0.rewardList) do
		for slot10, slot11 in ipairs(slot1) do
			if not slot0:getUserDataTb_().itemIcon then
				slot12.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot6[slot10])
			end

			slot12.itemIcon:setMOValue(slot11[1], slot11[2], slot11[3], nil, true)
			slot12.itemIcon:setCountFontSize(30)
		end
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
