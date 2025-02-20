module("modules.logic.fight.view.preview.SkillEditorCharacterSkinSelectView", package.seeall)

slot0 = class("SkillEditorCharacterSkinSelectView", BaseView)

function slot0.ctor(slot0)
end

function slot0.onInitView(slot0)
	slot0._actionViewGO = gohelper.findChild(slot0.viewGO, "selectSkin")
	slot0._itemGOParent = gohelper.findChild(slot0.viewGO, "selectSkin/scroll/content")
	slot0._itemGOPrefab = gohelper.findChild(slot0.viewGO, "selectSkin/scroll/item")
	slot0._btnselectSkinID = gohelper.findChildButton(slot0.viewGO, "scene/Grid/btnSelectSkin")
end

function slot0.addEvents(slot0)
	SLFramework.UGUI.UIClickListener.Get(slot0._actionViewGO):AddClickListener(slot0._hideThis, slot0)
	slot0:addClickCb(slot0._btnselectSkinID, slot0._showThis, slot0)
end

function slot0.removeEvents(slot0)
	SLFramework.UGUI.UIClickListener.Get(slot0._actionViewGO):RemoveClickListener()
end

function slot0.onOpen(slot0)
end

function slot0._hideThis(slot0)
	gohelper.setActive(slot0._actionViewGO, false)
end

function slot0._showThis(slot0)
	gohelper.setActive(slot0._actionViewGO, true)

	if SkillEditorMgr.instance.cur_select_entity_id then
		slot0._attacker = GameSceneMgr.instance:getCurScene().entityMgr:getEntity(SkillEditorMgr.instance.cur_select_entity_id)
	else
		slot0._attacker = slot1.entityMgr:getEntityByPosId(SceneTag.UnitPlayer, SkillEditorView.selectPosId[FightEnum.EntitySide.MySide])
	end

	if not slot0._attacker then
		logError("所选对象错误，请从新选择对象")

		return
	end

	slot0.entity_mo = slot0._attacker:getMO()
	slot2 = SkinConfig.instance:getCharacterSkinCoList(slot0.entity_mo.modelId) or {}

	gohelper.CreateObjList(slot0, slot0.OnItemShow, slot2, slot0._itemGOParent, slot0._itemGOPrefab)

	if #slot2 == 0 then
		logError("所选对象没有可选皮肤")
		slot0:_hideThis()
	end
end

function slot0.OnItemShow(slot0, slot1, slot2, slot3)
	slot1.transform:Find("Text"):GetComponent(gohelper.Type_TextMesh).text = slot2.des
	slot6 = slot1:GetComponent(typeof(SLFramework.UGUI.ButtonWrap))

	slot0:removeClickCb(slot6)
	slot0:addClickCb(slot6, slot0.OnItemClick, slot0, slot2)
end

function slot0.OnItemClick(slot0, slot1)
	slot2 = SkillEditorMgr.instance.cur_select_side
	slot3, slot4 = SkillEditorMgr.instance:getTypeInfo(slot2)
	slot4.skinIds[slot0.entity_mo.position] = slot1.id

	SkillEditorMgr.instance:setTypeInfo(slot2, slot3, slot4.ids, slot4.skinIds, slot4.groupId)

	slot5 = slot2 == FightEnum.EntitySide.MySide and SceneTag.UnitPlayer or SceneTag.UnitMonster

	if GameSceneMgr.instance:getCurScene().entityMgr:getEntity(slot0._attacker.id).skill then
		slot7.skill:stopSkill()
	end

	FightController.instance:dispatchEvent(FightEvent.BeforeDeadEffect, slot7.id)
	slot6:removeUnit(slot5, slot0._attacker.id)

	slot0.entity_mo.skin = slot1.id

	if FightDataHelper.entityMgr:isSub(slot0.entity_mo.id) then
		slot6:buildSubSpine(slot0.entity_mo)
	else
		slot6:buildSpine(slot0.entity_mo)
	end
end

return slot0
