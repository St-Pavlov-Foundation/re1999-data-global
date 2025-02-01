module("modules.logic.bossrush.view.FightViewBossHpBossRushActionOpItem", package.seeall)

slot0 = class("FightViewBossHpBossRushActionOpItem", BaseViewExtended)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ForbidBossRushHpChannelSkillOpItem, slot0._onForbidBossRushHpChannelSkillOpItem, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onRefreshViewParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0._onForbidBossRushHpChannelSkillOpItem(slot0, slot1)
	if slot1 == slot0._data then
		slot0:refreshUI(slot0.viewGO, slot1)
	end
end

function slot0.refreshUI(slot0, slot1, slot2)
	slot0.viewGO = slot1
	slot0._data = slot2

	gohelper.setActive(gohelper.findChild(slot0.viewGO, "root/act"), slot2.skillId ~= 0)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "root/noAct"), slot5 == 0)

	if slot5 == 0 then
		return
	end

	gohelper.setActive(gohelper.findChild(slot0.viewGO, "root/act/forbid"), slot2.isChannelPosedSkill and slot2.forbidden)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "root/act/round"), slot2.isChannelSkill)

	gohelper.findChildText(slot0.viewGO, "root/act/round/num").text = slot2.round or 0

	MonoHelper.addNoUpdateLuaComOnceToGo(slot4, FightOpItem):updateCardInfoMO({
		uid = slot0:getParentView()._bossEntityMO.uid,
		skillId = slot2.skillId
	})
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
