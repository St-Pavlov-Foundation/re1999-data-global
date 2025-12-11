module("modules.logic.fight.view.preview.SkillEditorHeroSelectView", package.seeall)

local var_0_0 = class("SkillEditorHeroSelectView", BaseView)

function var_0_0.ctor(arg_1_0)
	arg_1_0._selectType = SkillEditorMgr.SelectType.Hero
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._heroViewGO = gohelper.findChild(arg_2_0.viewGO, "selectHeros")
	arg_2_0._btnHeroPreviewL = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "left/btnSelectHero")
	arg_2_0._btnHeroPreviewR = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "right/btnSelectHero")
	arg_2_0._btnAutoPlaySkill = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "right/autoplayskill")
	arg_2_0._btnGroupGO = gohelper.findChild(arg_2_0.viewGO, "selectHeros/btnGroup")
	arg_2_0._txtcount = gohelper.findChildText(arg_2_0.viewGO, "selectHeros/btnGroup/btnSelectHero/imgSelect/Text")
	arg_2_0._txtcount = gohelper.findChildText(arg_2_0.viewGO, "selectHeros/btnGroup/btnSelectMonster/imgSelect/Text")
	arg_2_0._selectHeroImg = gohelper.findChild(arg_2_0.viewGO, "selectHeros/btnGroup/btnSelectHero/imgSelect")
	arg_2_0._selectMonsterImg = gohelper.findChild(arg_2_0.viewGO, "selectHeros/btnGroup/btnSelectMonster/imgSelect")
	arg_2_0._selectMonsterGroupImg = gohelper.findChild(arg_2_0.viewGO, "selectHeros/btnGroup/btnSelectMonsterGroup/imgSelect")
	arg_2_0._selectSubHeroImg = gohelper.findChild(arg_2_0.viewGO, "selectHeros/btnGroup/btnSelectSubHero/imgSelect")
	arg_2_0._selectMonsterIdImg = gohelper.findChild(arg_2_0.viewGO, "selectHeros/btnGroup/btnSelectMonsterId/imgSelect")
	arg_2_0._btnClose = SLFramework.UGUI.ButtonWrap.GetWithPath(arg_2_0.viewGO, "selectHeros/btnClose")
	arg_2_0._btnSelectHero = SLFramework.UGUI.ButtonWrap.GetWithPath(arg_2_0.viewGO, "selectHeros/btnGroup/btnSelectHero")
	arg_2_0._btnSelectSubHero = SLFramework.UGUI.ButtonWrap.GetWithPath(arg_2_0.viewGO, "selectHeros/btnGroup/btnSelectSubHero")
	arg_2_0._btnSelectMonster = SLFramework.UGUI.ButtonWrap.GetWithPath(arg_2_0.viewGO, "selectHeros/btnGroup/btnSelectMonster")
	arg_2_0._btnSelectMonsterGroup = SLFramework.UGUI.ButtonWrap.GetWithPath(arg_2_0.viewGO, "selectHeros/btnGroup/btnSelectMonsterGroup")
	arg_2_0._btnSelectMonsterId = SLFramework.UGUI.ButtonWrap.GetWithPath(arg_2_0.viewGO, "selectHeros/btnGroup/btnSelectMonsterId")
	arg_2_0._btncountAdd = SLFramework.UGUI.ButtonWrap.GetWithPath(arg_2_0.viewGO, "selectHeros/btnGroup/btnSelectHero/imgSelect/btnAdd")
	arg_2_0._btncountMinus = SLFramework.UGUI.ButtonWrap.GetWithPath(arg_2_0.viewGO, "selectHeros/btnGroup/btnSelectHero/imgSelect/btnMinus")
	arg_2_0._btnMonsterCountAdd = SLFramework.UGUI.ButtonWrap.GetWithPath(arg_2_0.viewGO, "selectHeros/btnGroup/btnSelectMonster/imgSelect/btnAdd")
	arg_2_0._btnMonsterCountMinus = SLFramework.UGUI.ButtonWrap.GetWithPath(arg_2_0.viewGO, "selectHeros/btnGroup/btnSelectMonster/imgSelect/btnMinus")
	arg_2_0._inp = gohelper.findChildTextMeshInputField(arg_2_0.viewGO, "selectHeros/inp")
	arg_2_0._btnclearsub = SLFramework.UGUI.ButtonWrap.GetWithPath(arg_2_0.viewGO, "selectHeros/btn_clear_sub")
	arg_2_0._goSelect = gohelper.findChild(arg_2_0.viewGO, "selectHeros/goSelect")
	arg_2_0._goAutoPlaySkill = gohelper.findChild(arg_2_0.viewGO, "autoPlaySkill")
	arg_2_0._isOpenAutoSkillTool = false
end

function var_0_0.addEvents(arg_3_0)
	SLFramework.UGUI.UIClickListener.Get(arg_3_0._heroViewGO):AddClickListener(arg_3_0._hideThis, arg_3_0)
	arg_3_0._btnClose:AddClickListener(arg_3_0._hideThis, arg_3_0)
	arg_3_0._btnSelectHero:AddClickListener(arg_3_0._onClickSelectHero, arg_3_0)
	arg_3_0._btnAutoPlaySkill:AddClickListener(arg_3_0._openAutoPlaySkillTool, arg_3_0)
	arg_3_0._btnSelectSubHero:AddClickListener(arg_3_0._onClickSelectSubHero, arg_3_0)
	arg_3_0._btnSelectMonster:AddClickListener(arg_3_0._onClickSelectMonster, arg_3_0)
	arg_3_0._btnSelectMonsterGroup:AddClickListener(arg_3_0._onClickSelectMonsterGroup, arg_3_0)
	arg_3_0._btnSelectMonsterId:AddClickListener(arg_3_0._onClickSelectMonsterId, arg_3_0)
	arg_3_0._btncountAdd:AddClickListener(arg_3_0._onClickAdd, arg_3_0)
	arg_3_0._btncountMinus:AddClickListener(arg_3_0._onClickMinus, arg_3_0)
	arg_3_0._btnMonsterCountAdd:AddClickListener(arg_3_0._onClickAdd, arg_3_0)
	arg_3_0._btnMonsterCountMinus:AddClickListener(arg_3_0._onClickMinus, arg_3_0)
	arg_3_0._btnHeroPreviewL:AddClickListener(arg_3_0._showThis, arg_3_0, FightEnum.EntitySide.EnemySide)
	arg_3_0._btnHeroPreviewR:AddClickListener(arg_3_0._showThis, arg_3_0, FightEnum.EntitySide.MySide)
	arg_3_0._inp:AddOnValueChanged(arg_3_0._onInpValueChanged, arg_3_0)
	arg_3_0._btnclearsub:AddClickListener(arg_3_0._clearSubHero, arg_3_0)
	SkillEditorMgr.instance:registerCallback(SkillEditorMgr.ShowHeroSelectView, arg_3_0._showWithStancePosId, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	SLFramework.UGUI.UIClickListener.Get(arg_4_0._heroViewGO):RemoveClickListener()
	arg_4_0._btnClose:RemoveClickListener()
	arg_4_0._btnSelectHero:RemoveClickListener()
	arg_4_0._btnAutoPlaySkill:RemoveClickListener()
	arg_4_0._btnSelectSubHero:RemoveClickListener()
	arg_4_0._btnSelectMonster:RemoveClickListener()
	arg_4_0._btnSelectMonsterGroup:RemoveClickListener()
	arg_4_0._btnSelectMonsterId:RemoveClickListener()
	arg_4_0._btncountAdd:RemoveClickListener()
	arg_4_0._btncountMinus:RemoveClickListener()
	arg_4_0._btnMonsterCountAdd:RemoveClickListener()
	arg_4_0._btnMonsterCountMinus:RemoveClickListener()
	arg_4_0._btnHeroPreviewL:RemoveClickListener()
	arg_4_0._btnHeroPreviewR:RemoveClickListener()
	arg_4_0._inp:RemoveOnValueChanged()
	arg_4_0._btnclearsub:RemoveClickListener()
	SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr.ShowHeroSelectView, arg_4_0._showWithStancePosId, arg_4_0)
end

function var_0_0._onInpValueChanged(arg_5_0, arg_5_1)
	arg_5_0:_updateItems()
	arg_5_0:_updateItemSelect()
end

function var_0_0._showThis(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0._heroViewGO, true)
	gohelper.setActive(arg_6_0._btnGroupGO, true)

	arg_6_0._side = arg_6_1
	arg_6_0._stancePosId = nil
	arg_6_0._selectType = SkillEditorMgr.instance:getTypeInfo(arg_6_0._side)

	arg_6_0:_updateTypeSelect()
	arg_6_0:_updateItems()
	arg_6_0:_updateItemSelect()
end

function var_0_0._hideThis(arg_7_0)
	gohelper.setActive(arg_7_0._heroViewGO, false)
end

function var_0_0._showWithStancePosId(arg_8_0, arg_8_1, arg_8_2)
	gohelper.setActive(arg_8_0._heroViewGO, true)
	gohelper.setActive(arg_8_0._btnGroupGO, false)

	arg_8_0._side = arg_8_1
	arg_8_0._stancePosId = arg_8_2
	arg_8_0._selectType = SkillEditorMgr.instance:getTypeInfo(arg_8_0._side)

	if arg_8_0._selectType == SkillEditorMgr.SelectType.Group then
		arg_8_0._selectType = SkillEditorMgr.SelectType.Monster
	end

	arg_8_0:_updateTypeSelect()
	arg_8_0:_updateItems()
	arg_8_0:_updateItemSelect()
end

function var_0_0._btnStateChange(arg_9_0, arg_9_1)
	gohelper.addChild(arg_9_1, arg_9_0._goSelect)
	recthelper.setAnchor(arg_9_0._goSelect.transform, 95, 34)
end

function var_0_0._onClickSelectHero(arg_10_0)
	arg_10_0:_btnStateChange(arg_10_0._btnSelectHero.gameObject)

	arg_10_0._selectType = SkillEditorMgr.SelectType.Hero

	arg_10_0:_updateTypeSelect()
	arg_10_0:_updateItems()
	arg_10_0:_updateItemSelect()
end

function var_0_0._onClickSelectSubHero(arg_11_0)
	arg_11_0:_btnStateChange(arg_11_0._btnSelectSubHero.gameObject)

	arg_11_0._selectType = SkillEditorMgr.SelectType.SubHero

	arg_11_0:_updateTypeSelect()
	arg_11_0:_updateItems()
	arg_11_0:_updateItemSelect()
end

function var_0_0._onClickSelectMonster(arg_12_0)
	arg_12_0:_btnStateChange(arg_12_0._btnSelectMonster.gameObject)

	arg_12_0._selectType = SkillEditorMgr.SelectType.Monster

	arg_12_0:_updateItems()
	arg_12_0:_updateTypeSelect()
	arg_12_0:_updateItemSelect()
end

function var_0_0._onClickSelectMonsterGroup(arg_13_0)
	arg_13_0:_btnStateChange(arg_13_0._btnSelectMonsterGroup.gameObject)

	arg_13_0._selectType = SkillEditorMgr.SelectType.Group

	arg_13_0:_updateItems()
	arg_13_0:_updateTypeSelect()
	arg_13_0:_updateItemSelect()
end

function var_0_0._onClickSelectMonsterId(arg_14_0)
	arg_14_0:_btnStateChange(arg_14_0._btnSelectMonsterId.gameObject)

	arg_14_0._selectType = SkillEditorMgr.SelectType.MonsterId

	arg_14_0:_updateItems()
	arg_14_0:_updateTypeSelect()
	arg_14_0:_updateItemSelect()
end

function var_0_0._openAutoPlaySkillTool(arg_15_0)
	arg_15_0._isOpenAutoSkillTool = not arg_15_0._isOpenAutoSkillTool

	gohelper.setActive(arg_15_0._goAutoPlaySkill, arg_15_0._isOpenAutoSkillTool)
end

function var_0_0._onClickAdd(arg_16_0)
	local var_16_0, var_16_1 = SkillEditorMgr.instance:getTypeInfo(arg_16_0._side)

	if (SkillEditorHeroSelectModel.instance.side == FightEnum.EntitySide.MySide and SkillEditorMgr.instance.stance_count_limit or SkillEditorMgr.instance.enemy_stance_count_limit) > #var_16_1.ids then
		table.insert(var_16_1.ids, var_16_1.ids[1])
		table.insert(var_16_1.skinIds, var_16_1.skinIds[1])
		SkillEditorMgr.instance:refreshInfo(arg_16_0._side)
		SkillEditorMgr.instance:rebuildEntitys(arg_16_0._side)
	end
end

function var_0_0._onClickMinus(arg_17_0)
	local var_17_0, var_17_1 = SkillEditorMgr.instance:getTypeInfo(arg_17_0._side)

	if #var_17_1.ids > 1 then
		table.remove(var_17_1.ids, #var_17_1.ids)
		table.remove(var_17_1.skinIds, #var_17_1.ids)
		SkillEditorMgr.instance:refreshInfo(arg_17_0._side)
		SkillEditorMgr.instance:rebuildEntitys(arg_17_0._side)
	end
end

function var_0_0._updateItems(arg_18_0)
	SkillEditorHeroSelectModel.instance:setSelect(arg_18_0._side, arg_18_0._selectType, arg_18_0._stancePosId, arg_18_0._inp:GetText())
end

function var_0_0._updateTypeSelect(arg_19_0)
	gohelper.setActive(arg_19_0._selectHeroImg, arg_19_0._selectType == SkillEditorMgr.SelectType.Hero)
	gohelper.setActive(arg_19_0._selectMonsterImg, arg_19_0._selectType == SkillEditorMgr.SelectType.Monster)
	gohelper.setActive(arg_19_0._selectMonsterGroupImg, arg_19_0._selectType == SkillEditorMgr.SelectType.Group)
	gohelper.setActive(arg_19_0._btnclearsub.gameObject, arg_19_0._selectType == SkillEditorMgr.SelectType.SubHero)
	gohelper.setActive(arg_19_0._selectSubHeroImg, arg_19_0._selectType == SkillEditorMgr.SelectType.SubHero)
	gohelper.setActive(arg_19_0._selectMonsterIdImg, arg_19_0._selectType == SkillEditorMgr.SelectType.MonsterId)
end

function var_0_0._updateItemSelect(arg_20_0)
	local var_20_0 = SkillEditorHeroSelectModel.instance:getList()
	local var_20_1, var_20_2 = SkillEditorMgr.instance:getTypeInfo(arg_20_0._side)

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		local var_20_3 = iter_20_1.co
		local var_20_4 = arg_20_0._stancePosId or 1

		if var_20_2.ids[var_20_4] == var_20_3.id then
			if var_20_2.skinIds[var_20_4] == var_20_3.skinId then
				SkillEditorHeroSelectModel.instance:selectCell(iter_20_1.id, true)
			end
		elseif var_20_2.groupId == var_20_3.id then
			SkillEditorHeroSelectModel.instance:selectCell(iter_20_1.id, true)
		end
	end
end

function var_0_0._clearSubHero(arg_21_0)
	SkillEditorMgr.instance:clearSubHero()
end

return var_0_0
