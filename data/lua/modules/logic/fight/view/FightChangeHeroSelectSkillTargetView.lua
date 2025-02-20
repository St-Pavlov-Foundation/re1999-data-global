module("modules.logic.fight.view.FightChangeHeroSelectSkillTargetView", package.seeall)

slot0 = class("FightChangeHeroSelectSkillTargetView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._block = gohelper.findChildClick(slot0.viewGO, "block")
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0._block, slot0._onBlock, slot0)
	FightController.instance:registerCallback(FightEvent.ChangeSubHeroExSkillReply, slot0._onChangeSubHeroExSkillReply, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0.removeEvents(slot0)
	FightController.instance:unregisterCallback(FightEvent.ChangeSubHeroExSkillReply, slot0._onChangeSubHeroExSkillReply, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.FightSkillTargetView then
		slot0:closeThis()
	end
end

function slot0._onChangeSubHeroExSkillReply(slot0)
	slot0:closeThis()
end

function slot0._onBtnEsc(slot0)
end

function slot0._onBlock(slot0)
	slot0._clickCounter = slot0._clickCounter + 1

	if slot0._clickCounter >= 5 then
		slot0:closeThis()
	end
end

function slot0.onOpen(slot0)
	slot0._clickCounter = 0

	NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0._onBtnEsc, slot0)

	if FightEnum.ShowLogicTargetView[slot0.viewParam.skillConfig.logicTarget] and slot1.targetLimit == FightEnum.TargetLimit.MySide then
		if #FightDataHelper.entityMgr:getMyNormalList() + #FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.MySide) > 1 then
			ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
				mustSelect = true,
				fromId = slot0.viewParam.fromId,
				skillId = slot1.id,
				callback = slot0._onChangeHeroSkillSelected,
				callbackObj = slot0
			})
		elseif slot5 == 1 then
			FightRpc.instance:sendChangeSubHeroExSkillRequest((#slot3 > 0 and slot3 or slot4)[1].id)
		else
			slot0:closeThis()
		end
	else
		FightRpc.instance:sendChangeSubHeroExSkillRequest(FightCardModel.instance.curSelectEntityId)
	end
end

function slot0._onChangeHeroSkillSelected(slot0, slot1)
	FightRpc.instance:sendChangeSubHeroExSkillRequest(slot1)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
