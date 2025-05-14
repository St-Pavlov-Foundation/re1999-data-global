module("modules.logic.fight.view.preview.SkillEditorStanceSelectView", package.seeall)

local var_0_0 = class("SkillEditorStanceSelectView", BaseView)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._actionViewGO = gohelper.findChild(arg_2_0.viewGO, "selectStance")
	arg_2_0._itemGOParent = gohelper.findChild(arg_2_0.viewGO, "selectStance/scroll/content")
	arg_2_0._itemGOPrefab = gohelper.findChild(arg_2_0.viewGO, "selectStance/scroll/item")
	arg_2_0._btnSelectStanceID = gohelper.findChildButton(arg_2_0.viewGO, "scene/Grid/btnSelectStanceID")
end

function var_0_0.addEvents(arg_3_0)
	SLFramework.UGUI.UIClickListener.Get(arg_3_0._actionViewGO):AddClickListener(arg_3_0._hideThis, arg_3_0)
	arg_3_0:addClickCb(arg_3_0._btnSelectStanceID, arg_3_0._showThis, arg_3_0)
	arg_3_0:addEventCb(SkillEditorMgr.instance, SkillEditorMgr.OnSelectStance, arg_3_0._onSelectStance, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	SLFramework.UGUI.UIClickListener.Get(arg_4_0._actionViewGO):RemoveClickListener()
	arg_4_0:removeClickCb(arg_4_0._btnSelectStanceID)
	arg_4_0:removeEventCb(SkillEditorMgr.instance, SkillEditorMgr.OnSelectStance, arg_4_0._onSelectStance, arg_4_0)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0.data_list = arg_5_0.data_list or lua_stance.configList

	gohelper.CreateObjList(arg_5_0, arg_5_0.OnItemShow, arg_5_0.data_list, arg_5_0._itemGOParent, arg_5_0._itemGOPrefab)
end

function var_0_0._hideThis(arg_6_0)
	gohelper.setActive(arg_6_0._actionViewGO, false)
end

function var_0_0._showThis(arg_7_0)
	gohelper.setActive(arg_7_0._actionViewGO, true)
end

function var_0_0.OnItemShow(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_1.transform:Find("Text"):GetComponent(gohelper.Type_TextMesh).text = arg_8_2.dec_stance

	arg_8_0:addClickCb(arg_8_1:GetComponent(typeof(SLFramework.UGUI.ButtonWrap)), arg_8_0.OnItemClick, arg_8_0, arg_8_2)
end

function var_0_0.OnItemClick(arg_9_0, arg_9_1)
	arg_9_0.cur_select = SkillEditorMgr.instance.cur_select_side == FightEnum.EntitySide.EnemySide and "enemy_" or ""
	SkillEditorMgr.instance[arg_9_0.cur_select .. "stance_id"] = arg_9_1.id

	local var_9_0 = SkillEditorMgr.instance.cur_select_side
	local var_9_1 = 0

	for iter_9_0 = 1, 5 do
		if #arg_9_1["pos" .. iter_9_0] ~= 0 then
			var_9_1 = var_9_1 + 1
		end
	end

	local var_9_2, var_9_3 = SkillEditorMgr.instance:getTypeInfo(var_9_0)

	while var_9_1 < #var_9_3.ids do
		local var_9_4 = #var_9_3.ids

		if SkillEditorMgr.instance.cur_select_entity_id == var_9_3.ids[var_9_4] then
			SkillEditorMgr.instance.cur_select_entity_id = var_9_3.ids[var_9_4 - 1]
		end

		table.remove(var_9_3.ids, var_9_4)
		table.remove(var_9_3.skinIds, var_9_4)
	end

	SkillEditorMgr.instance[arg_9_0.cur_select .. "stance_count_limit"] = var_9_1

	SkillEditorMgr.instance:refreshInfo(var_9_0)
	SkillEditorMgr.instance:rebuildEntitys(var_9_0)
end

function var_0_0._onSelectStance(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = lua_stance.configDict[arg_10_2]

	if not var_10_0 then
		logError("站位不存在: " .. arg_10_2)

		return
	end

	arg_10_0.cur_select = arg_10_1 == FightEnum.EntitySide.EnemySide and "enemy_" or ""
	SkillEditorMgr.instance[arg_10_0.cur_select .. "stance_id"] = var_10_0.id

	local var_10_1 = 0

	for iter_10_0 = 1, 5 do
		if #var_10_0["pos" .. iter_10_0] ~= 0 then
			var_10_1 = var_10_1 + 1
		end
	end

	local var_10_2, var_10_3 = SkillEditorMgr.instance:getTypeInfo(arg_10_1)

	while var_10_1 < #var_10_3.ids do
		local var_10_4 = #var_10_3.ids

		if SkillEditorMgr.instance.cur_select_entity_id == var_10_3.ids[var_10_4] then
			SkillEditorMgr.instance.cur_select_entity_id = var_10_3.ids[var_10_4 - 1]
		end

		table.remove(var_10_3.ids, var_10_4)
		table.remove(var_10_3.skinIds, var_10_4)
	end

	SkillEditorMgr.instance[arg_10_0.cur_select .. "stance_count_limit"] = var_10_1

	SkillEditorMgr.instance:refreshInfo(arg_10_1)

	if arg_10_3 then
		SkillEditorMgr.instance:rebuildEntitys(arg_10_1)
	end
end

return var_0_0
