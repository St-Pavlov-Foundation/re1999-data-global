module("modules.logic.fight.view.FightSeasonChangeHeroSelectView", package.seeall)

slot0 = class("FightSeasonChangeHeroSelectView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._block = gohelper.findChildClick(slot0.viewGO, "block")
	slot0._blockTransform = slot0._block:GetComponent(gohelper.Type_RectTransform)
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0._block, slot0._onBlock, slot0)
	FightController.instance:registerCallback(FightEvent.ReceiveChangeSubHeroReply, slot0._onReceiveChangeSubHeroReply, slot0)
end

function slot0.removeEvents(slot0)
	FightController.instance:unregisterCallback(FightEvent.ReceiveChangeSubHeroReply, slot0._onReceiveChangeSubHeroReply, slot0)
end

function slot0._onReceiveChangeSubHeroReply(slot0)
	slot0:closeThis()
end

function slot0._onBlock(slot0, slot1, slot2)
	if FightSkillSelectView.getClickEntity(FightHelper.getSideEntitys(FightEnum.EntitySide.MySide), slot0._blockTransform, slot2) then
		if not FightDataHelper.entityMgr:getById(slot4) then
			return
		end

		if slot0._curSelectId == slot4 then
			FightRpc.instance:sendChangeSubHeroRequest(slot0._changeId, slot4)
		else
			slot0._curSelectId = slot4

			FightController.instance:dispatchEvent(FightEvent.SeasonSelectChangeHeroTarget, slot0._curSelectId)
		end

		return
	end

	slot0:closeThis()
end

function slot0.onOpen(slot0)
	FightDataHelper.stageMgr:enterOperateState(FightStageMgr.OperateStateType.SeasonChangeHero)

	slot0._curSelectId = nil
	slot0._changeId = slot0.viewParam
end

function slot0.onClose(slot0)
	FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.SeasonChangeHero)
end

function slot0.onDestroyView(slot0)
end

return slot0
