module("modules.logic.gm.view.GMResetCardsView", package.seeall)

slot0 = class("GMResetCardsView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnClose")
	slot0._btnOK = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnOK")
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
	slot0._btnOK:AddClickListener(slot0._onClickOK, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._btnOK:RemoveClickListener()
end

function slot0.onOpen(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(FightCardModel.instance:getHandCardsByOps({})) do
		table.insert(slot1, {
			oldEntityId = slot7.uid,
			oldSkillId = slot7.skillId
		})
	end

	GMResetCardsModel.instance:getModel1():setList(slot1)

	slot4 = {}

	for slot9, slot10 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, false)) do
		for slot15, slot16 in ipairs(slot10:getMO().skillGroup1) do
			table.insert(slot4, {
				entityId = slot10.id,
				skillId = slot16
			})
		end

		for slot15, slot16 in ipairs(slot11.skillGroup2) do
			table.insert(slot4, {
				entityId = slot10.id,
				skillId = slot16
			})
		end

		table.insert(slot4, {
			entityId = slot10.id,
			skillId = slot11.exSkill
		})
	end

	GMResetCardsModel.instance:getModel2():setList(slot4)
end

function slot0._onClickOK(slot0)
	slot1 = GMResetCardsModel.instance:getModel1()
	slot8 = slot1

	for slot7, slot8 in ipairs(slot1.getList(slot8)) do
		if slot7 < slot1:getCount() then
			slot2 = "" .. (slot8.newSkillId or slot8.oldSkillId) .. "#"
		end
	end

	GMRpc.instance:sendGMRequest("fight resetCards " .. slot2)
	slot0:closeThis()
end

return slot0
