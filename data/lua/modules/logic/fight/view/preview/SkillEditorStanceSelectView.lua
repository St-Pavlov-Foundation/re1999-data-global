module("modules.logic.fight.view.preview.SkillEditorStanceSelectView", package.seeall)

slot0 = class("SkillEditorStanceSelectView", BaseView)

function slot0.ctor(slot0)
end

function slot0.onInitView(slot0)
	slot0._actionViewGO = gohelper.findChild(slot0.viewGO, "selectStance")
	slot0._itemGOParent = gohelper.findChild(slot0.viewGO, "selectStance/scroll/content")
	slot0._itemGOPrefab = gohelper.findChild(slot0.viewGO, "selectStance/scroll/item")
	slot0._btnSelectStanceID = gohelper.findChildButton(slot0.viewGO, "scene/Grid/btnSelectStanceID")
end

function slot0.addEvents(slot0)
	SLFramework.UGUI.UIClickListener.Get(slot0._actionViewGO):AddClickListener(slot0._hideThis, slot0)
	slot0:addClickCb(slot0._btnSelectStanceID, slot0._showThis, slot0)
	slot0:addEventCb(SkillEditorMgr.instance, SkillEditorMgr.OnSelectStance, slot0._onSelectStance, slot0)
end

function slot0.removeEvents(slot0)
	SLFramework.UGUI.UIClickListener.Get(slot0._actionViewGO):RemoveClickListener()
	slot0:removeClickCb(slot0._btnSelectStanceID)
	slot0:removeEventCb(SkillEditorMgr.instance, SkillEditorMgr.OnSelectStance, slot0._onSelectStance, slot0)
end

function slot0.onOpen(slot0)
	slot0.data_list = slot0.data_list or lua_stance.configList

	gohelper.CreateObjList(slot0, slot0.OnItemShow, slot0.data_list, slot0._itemGOParent, slot0._itemGOPrefab)
end

function slot0._hideThis(slot0)
	gohelper.setActive(slot0._actionViewGO, false)
end

function slot0._showThis(slot0)
	gohelper.setActive(slot0._actionViewGO, true)
end

function slot0.OnItemShow(slot0, slot1, slot2, slot3)
	slot1.transform:Find("Text"):GetComponent(gohelper.Type_TextMesh).text = slot2.dec_stance

	slot0:addClickCb(slot1:GetComponent(typeof(SLFramework.UGUI.ButtonWrap)), slot0.OnItemClick, slot0, slot2)
end

function slot0.OnItemClick(slot0, slot1)
	slot0.cur_select = SkillEditorMgr.instance.cur_select_side == FightEnum.EntitySide.EnemySide and "enemy_" or ""
	SkillEditorMgr.instance[slot0.cur_select .. "stance_id"] = slot1.id
	slot2 = SkillEditorMgr.instance.cur_select_side

	for slot7 = 1, 5 do
		if #slot1["pos" .. slot7] ~= 0 then
			slot3 = 0 + 1
		end
	end

	slot4, slot5 = SkillEditorMgr.instance:getTypeInfo(slot2)

	while slot3 < #slot5.ids do
		if SkillEditorMgr.instance.cur_select_entity_id == slot5.ids[#slot5.ids] then
			SkillEditorMgr.instance.cur_select_entity_id = slot5.ids[slot6 - 1]
		end

		table.remove(slot5.ids, slot6)
		table.remove(slot5.skinIds, slot6)
	end

	SkillEditorMgr.instance[slot0.cur_select .. "stance_count_limit"] = slot3

	SkillEditorMgr.instance:refreshInfo(slot2)
	SkillEditorMgr.instance:rebuildEntitys(slot2)
end

function slot0._onSelectStance(slot0, slot1, slot2, slot3)
	if not lua_stance.configDict[slot2] then
		logError("站位不存在: " .. slot2)

		return
	end

	slot0.cur_select = slot1 == FightEnum.EntitySide.EnemySide and "enemy_" or ""
	SkillEditorMgr.instance[slot0.cur_select .. "stance_id"] = slot4.id

	for slot9 = 1, 5 do
		if #slot4["pos" .. slot9] ~= 0 then
			slot5 = 0 + 1
		end
	end

	slot6, slot7 = SkillEditorMgr.instance:getTypeInfo(slot1)

	while slot5 < #slot7.ids do
		if SkillEditorMgr.instance.cur_select_entity_id == slot7.ids[#slot7.ids] then
			SkillEditorMgr.instance.cur_select_entity_id = slot7.ids[slot8 - 1]
		end

		table.remove(slot7.ids, slot8)
		table.remove(slot7.skinIds, slot8)
	end

	SkillEditorMgr.instance[slot0.cur_select .. "stance_count_limit"] = slot5

	SkillEditorMgr.instance:refreshInfo(slot1)

	if slot3 then
		SkillEditorMgr.instance:rebuildEntitys(slot1)
	end
end

return slot0
