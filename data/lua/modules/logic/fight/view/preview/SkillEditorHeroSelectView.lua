module("modules.logic.fight.view.preview.SkillEditorHeroSelectView", package.seeall)

slot0 = class("SkillEditorHeroSelectView", BaseView)

function slot0.ctor(slot0)
	slot0._selectType = SkillEditorMgr.SelectType.Hero
end

function slot0.onInitView(slot0)
	slot0._heroViewGO = gohelper.findChild(slot0.viewGO, "selectHeros")
	slot0._btnHeroPreviewL = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/btnSelectHero")
	slot0._btnHeroPreviewR = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/btnSelectHero")
	slot0._btnAutoPlaySkill = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/autoplayskill")
	slot0._btnGroupGO = gohelper.findChild(slot0.viewGO, "selectHeros/btnGroup")
	slot0._txtcount = gohelper.findChildText(slot0.viewGO, "selectHeros/btnGroup/btnSelectHero/imgSelect/Text")
	slot0._txtcount = gohelper.findChildText(slot0.viewGO, "selectHeros/btnGroup/btnSelectMonster/imgSelect/Text")
	slot0._selectHeroImg = gohelper.findChild(slot0.viewGO, "selectHeros/btnGroup/btnSelectHero/imgSelect")
	slot0._selectMonsterImg = gohelper.findChild(slot0.viewGO, "selectHeros/btnGroup/btnSelectMonster/imgSelect")
	slot0._selectMonsterGroupImg = gohelper.findChild(slot0.viewGO, "selectHeros/btnGroup/btnSelectMonsterGroup/imgSelect")
	slot0._selectSubHeroImg = gohelper.findChild(slot0.viewGO, "selectHeros/btnGroup/btnSelectSubHero/imgSelect")
	slot0._btnClose = SLFramework.UGUI.ButtonWrap.GetWithPath(slot0.viewGO, "selectHeros/btnClose")
	slot0._btnSelectHero = SLFramework.UGUI.ButtonWrap.GetWithPath(slot0.viewGO, "selectHeros/btnGroup/btnSelectHero")
	slot0._btnSelectSubHero = SLFramework.UGUI.ButtonWrap.GetWithPath(slot0.viewGO, "selectHeros/btnGroup/btnSelectSubHero")
	slot0._btnSelectMonster = SLFramework.UGUI.ButtonWrap.GetWithPath(slot0.viewGO, "selectHeros/btnGroup/btnSelectMonster")
	slot0._btnSelectMonsterGroup = SLFramework.UGUI.ButtonWrap.GetWithPath(slot0.viewGO, "selectHeros/btnGroup/btnSelectMonsterGroup")
	slot0._btncountAdd = SLFramework.UGUI.ButtonWrap.GetWithPath(slot0.viewGO, "selectHeros/btnGroup/btnSelectHero/imgSelect/btnAdd")
	slot0._btncountMinus = SLFramework.UGUI.ButtonWrap.GetWithPath(slot0.viewGO, "selectHeros/btnGroup/btnSelectHero/imgSelect/btnMinus")
	slot0._btnMonsterCountAdd = SLFramework.UGUI.ButtonWrap.GetWithPath(slot0.viewGO, "selectHeros/btnGroup/btnSelectMonster/imgSelect/btnAdd")
	slot0._btnMonsterCountMinus = SLFramework.UGUI.ButtonWrap.GetWithPath(slot0.viewGO, "selectHeros/btnGroup/btnSelectMonster/imgSelect/btnMinus")
	slot0._inp = gohelper.findChildTextMeshInputField(slot0.viewGO, "selectHeros/inp")
	slot0._btnclearsub = SLFramework.UGUI.ButtonWrap.GetWithPath(slot0.viewGO, "selectHeros/btn_clear_sub")
	slot0._goSelect = gohelper.findChild(slot0.viewGO, "selectHeros/goSelect")
	slot0._goAutoPlaySkill = gohelper.findChild(slot0.viewGO, "autoPlaySkill")
	slot0._isOpenAutoSkillTool = false
end

function slot0.addEvents(slot0)
	SLFramework.UGUI.UIClickListener.Get(slot0._heroViewGO):AddClickListener(slot0._hideThis, slot0)
	slot0._btnClose:AddClickListener(slot0._hideThis, slot0)
	slot0._btnSelectHero:AddClickListener(slot0._onClickSelectHero, slot0)
	slot0._btnAutoPlaySkill:AddClickListener(slot0._openAutoPlaySkillTool, slot0)
	slot0._btnSelectSubHero:AddClickListener(slot0._onClickSelectSubHero, slot0)
	slot0._btnSelectMonster:AddClickListener(slot0._onClickSelectMonster, slot0)
	slot0._btnSelectMonsterGroup:AddClickListener(slot0._onClickSelectMonsterGroup, slot0)
	slot0._btncountAdd:AddClickListener(slot0._onClickAdd, slot0)
	slot0._btncountMinus:AddClickListener(slot0._onClickMinus, slot0)
	slot0._btnMonsterCountAdd:AddClickListener(slot0._onClickAdd, slot0)
	slot0._btnMonsterCountMinus:AddClickListener(slot0._onClickMinus, slot0)
	slot0._btnHeroPreviewL:AddClickListener(slot0._showThis, slot0, FightEnum.EntitySide.EnemySide)
	slot0._btnHeroPreviewR:AddClickListener(slot0._showThis, slot0, FightEnum.EntitySide.MySide)
	slot0._inp:AddOnValueChanged(slot0._onInpValueChanged, slot0)
	slot0._btnclearsub:AddClickListener(slot0._clearSubHero, slot0)
	SkillEditorMgr.instance:registerCallback(SkillEditorMgr.ShowHeroSelectView, slot0._showWithStancePosId, slot0)
end

function slot0.removeEvents(slot0)
	SLFramework.UGUI.UIClickListener.Get(slot0._heroViewGO):RemoveClickListener()
	slot0._btnClose:RemoveClickListener()
	slot0._btnSelectHero:RemoveClickListener()
	slot0._btnAutoPlaySkill:RemoveClickListener()
	slot0._btnSelectSubHero:RemoveClickListener()
	slot0._btnSelectMonster:RemoveClickListener()
	slot0._btnSelectMonsterGroup:RemoveClickListener()
	slot0._btncountAdd:RemoveClickListener()
	slot0._btncountMinus:RemoveClickListener()
	slot0._btnMonsterCountAdd:RemoveClickListener()
	slot0._btnMonsterCountMinus:RemoveClickListener()
	slot0._btnHeroPreviewL:RemoveClickListener()
	slot0._btnHeroPreviewR:RemoveClickListener()
	slot0._inp:RemoveOnValueChanged()
	slot0._btnclearsub:RemoveClickListener()
	SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr.ShowHeroSelectView, slot0._showWithStancePosId, slot0)
end

function slot0._onInpValueChanged(slot0, slot1)
	slot0:_updateItems()
	slot0:_updateItemSelect()
end

function slot0._showThis(slot0, slot1)
	gohelper.setActive(slot0._heroViewGO, true)
	gohelper.setActive(slot0._btnGroupGO, true)

	slot0._side = slot1
	slot0._stancePosId = nil
	slot0._selectType = SkillEditorMgr.instance:getTypeInfo(slot0._side)

	slot0:_updateTypeSelect()
	slot0:_updateItems()
	slot0:_updateItemSelect()
end

function slot0._hideThis(slot0)
	gohelper.setActive(slot0._heroViewGO, false)
end

function slot0._showWithStancePosId(slot0, slot1, slot2)
	gohelper.setActive(slot0._heroViewGO, true)
	gohelper.setActive(slot0._btnGroupGO, false)

	slot0._side = slot1
	slot0._stancePosId = slot2
	slot0._selectType = SkillEditorMgr.instance:getTypeInfo(slot0._side)

	if slot0._selectType == SkillEditorMgr.SelectType.Group then
		slot0._selectType = SkillEditorMgr.SelectType.Monster
	end

	slot0:_updateTypeSelect()
	slot0:_updateItems()
	slot0:_updateItemSelect()
end

function slot0._btnStateChange(slot0, slot1)
	gohelper.addChild(slot1, slot0._goSelect)
	recthelper.setAnchor(slot0._goSelect.transform, 95, 34)
end

function slot0._onClickSelectHero(slot0)
	slot0:_btnStateChange(slot0._btnSelectHero.gameObject)

	slot0._selectType = SkillEditorMgr.SelectType.Hero

	slot0:_updateTypeSelect()
	slot0:_updateItems()
	slot0:_updateItemSelect()
end

function slot0._onClickSelectSubHero(slot0)
	slot0:_btnStateChange(slot0._btnSelectSubHero.gameObject)

	slot0._selectType = SkillEditorMgr.SelectType.SubHero

	slot0:_updateTypeSelect()
	slot0:_updateItems()
	slot0:_updateItemSelect()
end

function slot0._onClickSelectMonster(slot0)
	slot0:_btnStateChange(slot0._btnSelectMonster.gameObject)

	slot0._selectType = SkillEditorMgr.SelectType.Monster

	slot0:_updateItems()
	slot0:_updateTypeSelect()
	slot0:_updateItemSelect()
end

function slot0._onClickSelectMonsterGroup(slot0)
	slot0:_btnStateChange(slot0._btnSelectMonsterGroup.gameObject)

	slot0._selectType = SkillEditorMgr.SelectType.Group

	slot0:_updateItems()
	slot0:_updateTypeSelect()
	slot0:_updateItemSelect()
end

function slot0._openAutoPlaySkillTool(slot0)
	slot0._isOpenAutoSkillTool = not slot0._isOpenAutoSkillTool

	gohelper.setActive(slot0._goAutoPlaySkill, slot0._isOpenAutoSkillTool)
end

function slot0._onClickAdd(slot0)
	slot1, slot2 = SkillEditorMgr.instance:getTypeInfo(slot0._side)

	if (SkillEditorHeroSelectModel.instance.side == FightEnum.EntitySide.MySide and SkillEditorMgr.instance.stance_count_limit or SkillEditorMgr.instance.enemy_stance_count_limit) > #slot2.ids then
		table.insert(slot2.ids, slot2.ids[1])
		table.insert(slot2.skinIds, slot2.skinIds[1])
		SkillEditorMgr.instance:refreshInfo(slot0._side)
		SkillEditorMgr.instance:rebuildEntitys(slot0._side)
	end
end

function slot0._onClickMinus(slot0)
	slot1, slot2 = SkillEditorMgr.instance:getTypeInfo(slot0._side)

	if #slot2.ids > 1 then
		table.remove(slot2.ids, #slot2.ids)
		table.remove(slot2.skinIds, #slot2.ids)
		SkillEditorMgr.instance:refreshInfo(slot0._side)
		SkillEditorMgr.instance:rebuildEntitys(slot0._side)
	end
end

function slot0._updateItems(slot0)
	SkillEditorHeroSelectModel.instance:setSelect(slot0._side, slot0._selectType, slot0._stancePosId, slot0._inp:GetText())
end

function slot0._updateTypeSelect(slot0)
	gohelper.setActive(slot0._selectHeroImg, slot0._selectType == SkillEditorMgr.SelectType.Hero)
	gohelper.setActive(slot0._selectMonsterImg, slot0._selectType == SkillEditorMgr.SelectType.Monster)
	gohelper.setActive(slot0._selectMonsterGroupImg, slot0._selectType == SkillEditorMgr.SelectType.Group)
	gohelper.setActive(slot0._btnclearsub.gameObject, slot0._selectType == SkillEditorMgr.SelectType.SubHero)
	gohelper.setActive(slot0._selectSubHeroImg, slot0._selectType == SkillEditorMgr.SelectType.SubHero)
end

function slot0._updateItemSelect(slot0)
	slot2, slot3 = SkillEditorMgr.instance:getTypeInfo(slot0._side)

	for slot7, slot8 in ipairs(SkillEditorHeroSelectModel.instance:getList()) do
		if slot3.ids[slot0._stancePosId or 1] == slot8.co.id then
			if slot3.skinIds[slot10] == slot9.skinId then
				SkillEditorHeroSelectModel.instance:selectCell(slot8.id, true)
			end
		elseif slot3.groupId == slot9.id then
			SkillEditorHeroSelectModel.instance:selectCell(slot8.id, true)
		end
	end
end

function slot0._clearSubHero(slot0)
	SkillEditorMgr.instance:clearSubHero()
end

return slot0
