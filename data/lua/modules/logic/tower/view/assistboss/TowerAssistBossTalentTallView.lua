module("modules.logic.tower.view.assistboss.TowerAssistBossTalentTallView", package.seeall)

slot0 = class("TowerAssistBossTalentTallView", BaseView)

function slot0.onInitView(slot0)
	slot0.goEmpty = gohelper.findChild(slot0.viewGO, "#go_Empty")
	slot0.goScroll = gohelper.findChild(slot0.viewGO, "#scroll_Descr")
	slot0.goItem = gohelper.findChild(slot0.viewGO, "#scroll_Descr/Viewport/Content/#go_Item")

	gohelper.setActive(slot0.goItem, false)

	slot0.items = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.refreshParam(slot0)
	slot0.bossId = slot0.viewParam.bossId
	slot0.bossMo = TowerAssistBossModel.instance:getBoss(slot0.bossId)
	slot0.talentTree = slot0.bossMo:getTalentTree()
end

function slot0.refreshView(slot0)
	slot0:refreshList()
end

function slot0.refreshList(slot0)
	slot3 = #slot0.talentTree:getActiveTalentList() == 0

	gohelper.setActive(slot0.goScroll, not slot3)
	gohelper.setActive(slot0.goEmpty, slot3)

	if not slot3 then
		for slot9 = 1, math.max(#slot0.items, slot2) do
			slot0:getItem(slot9):onUpdateMO(slot1[slot9])
		end
	end
end

function slot0.getItem(slot0, slot1)
	if not slot0.items[slot1] then
		slot0.items[slot1] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0.goItem, tostring(slot1)), TowerAssistBossTalentTallItem)
	end

	return slot0.items[slot1]
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
