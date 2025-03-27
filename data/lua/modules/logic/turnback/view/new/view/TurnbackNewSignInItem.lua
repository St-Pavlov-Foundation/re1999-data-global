module("modules.logic.turnback.view.new.view.TurnbackNewSignInItem", package.seeall)

slot0 = class("TurnbackNewSignInItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._txtday = gohelper.findChildText(slot0.go, "group/txt_day")
	slot0._gocanget = gohelper.findChild(slot0.go, "#go_canget")
	slot0._gohasget = gohelper.findChild(slot0.go, "#go_hasget")
	slot0._btncanget = gohelper.findChildButtonWithAudio(slot0.go, "#btn_click")
	slot0._btnlatter = gohelper.findChildButtonWithAudio(slot0.go, "#btn_latter")
	slot0.canvasgroup = gohelper.findChild(slot0.go, "group"):GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0.rewardList = {}
end

function slot0.addEventListeners(slot0)
	TurnbackController.instance:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshSignInItem, slot0.refreshItem, slot0)
	slot0._btncanget:AddClickListener(slot0._btncangetOnClick, slot0)
	slot0._btnlatter:AddClickListener(slot0._btnlatterOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	TurnbackController.instance:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshSignInItem, slot0.refreshItem, slot0)
	slot0._btncanget:RemoveClickListener()
	slot0._btnlatter:RemoveClickListener()

	if slot0._isLastDay then
		slot0.btndetail:RemoveClickListener()
	end
end

function slot0.initItem(slot0, slot1)
	slot0.turnbackId = TurnbackModel.instance:getCurTurnbackId()
	slot0.id = slot1
	slot0._isLastDay = slot0.id == 7
	slot0.config = TurnbackConfig.instance:getTurnbackSignInDayCo(slot0.turnbackId, slot0.id)
	slot0.state = TurnbackSignInModel.instance:getSignInStateById(slot0.id)

	if not slot0._isLastDay then
		slot0._txtday.text = slot0.id

		for slot6 = 1, 2 do
			if not slot0.rewardList[slot6] then
				slot7 = slot0:getUserDataTb_()
				slot7.go = gohelper.findChild(slot0.go, "group/reward" .. slot6)
				slot7.goIcon = gohelper.findChild(slot7.go, "rewardicon")
				slot7.txtNum = gohelper.findChildText(slot7.go, "#txt_num")
				slot8 = GameUtil.splitString2(slot0.config.bonus, true)[slot6]
				slot11 = slot8[3]
				slot12, slot13 = ItemModel.instance:getItemConfigAndIcon(slot8[1], slot8[2], true)

				if slot13 then
					slot7.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot7.goIcon)

					slot7.itemIcon:setMOValue(slot9, slot10, slot11, nil, true)
					slot7.itemIcon:isShowQuality(false)
					slot7.itemIcon:isShowCount(false)
				end

				slot7.txtNum.text = slot11

				table.insert(slot0.rewardList, slot7)
			end
		end
	else
		slot0.btndetail = gohelper.findChildButtonWithAudio(slot0.go, "group/dec3")

		slot0.btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
	end

	slot0.canvasgroup.alpha = slot0.state == TurnbackEnum.SignInState.HasGet and 0.5 or 1

	gohelper.setActive(slot0._gohasget, slot0.state == TurnbackEnum.SignInState.HasGet)
	gohelper.setActive(slot0._gocanget, slot0.state == TurnbackEnum.SignInState.CanGet)
	gohelper.setActive(slot0._btncanget.gameObject, slot0.state == TurnbackEnum.SignInState.CanGet)
	gohelper.setActive(slot0._btnlatter.gameObject, slot0.state == TurnbackEnum.SignInState.CanGet or slot0.state == TurnbackEnum.SignInState.HasGet)
end

function slot0.refreshItem(slot0)
	slot0.state = TurnbackSignInModel.instance:getSignInStateById(slot0.id)
	slot0.canvasgroup.alpha = slot0.state == TurnbackEnum.SignInState.HasGet and 0.5 or 1

	gohelper.setActive(slot0._gohasget, slot0.state == TurnbackEnum.SignInState.HasGet)
	gohelper.setActive(slot0._gocanget, slot0.state == TurnbackEnum.SignInState.CanGet)
	gohelper.setActive(slot0._btncanget.gameObject, slot0.state == TurnbackEnum.SignInState.CanGet)
	gohelper.setActive(slot0._btnlatter.gameObject, slot0.state == TurnbackEnum.SignInState.CanGet or slot0.state == TurnbackEnum.SignInState.HasGet)
end

function slot0._btncangetOnClick(slot0)
	if slot0.state == TurnbackEnum.SignInState.CanGet then
		TurnbackRpc.instance:sendTurnbackSignInRequest(TurnbackModel.instance:getCurTurnbackId(), slot0.id)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_OK)
	end
end

function slot0._btndetailOnClick(slot0)
	ViewMgr.instance:openView(ViewName.TurnbackNewShowRewardView, {
		bonus = slot0.config.bonus
	})
end

function slot0._btnlatterOnClick(slot0)
	if slot0.id == 1 then
		ViewMgr.instance:openView(ViewName.TurnbackNewLatterView, {
			isNormal = false,
			notfirst = true,
			day = slot0.id
		})
	else
		ViewMgr.instance:openView(ViewName.TurnbackNewLatterView, {
			isNormal = true,
			day = slot0.id
		})
	end
end

function slot0._btnclickOnClick(slot0)
	ViewMgr.openView(ViewName.TurnbackLatterView, slot0.id)
end

function slot0.onDestroy(slot0)
end

return slot0
