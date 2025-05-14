module("modules.logic.fight.view.preview.SkillEditorCharacterSkinSelectView", package.seeall)

local var_0_0 = class("SkillEditorCharacterSkinSelectView", BaseView)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._actionViewGO = gohelper.findChild(arg_2_0.viewGO, "selectSkin")
	arg_2_0._itemGOParent = gohelper.findChild(arg_2_0.viewGO, "selectSkin/scroll/content")
	arg_2_0._itemGOPrefab = gohelper.findChild(arg_2_0.viewGO, "selectSkin/scroll/item")
	arg_2_0._btnselectSkinID = gohelper.findChildButton(arg_2_0.viewGO, "scene/Grid/btnSelectSkin")
end

function var_0_0.addEvents(arg_3_0)
	SLFramework.UGUI.UIClickListener.Get(arg_3_0._actionViewGO):AddClickListener(arg_3_0._hideThis, arg_3_0)
	arg_3_0:addClickCb(arg_3_0._btnselectSkinID, arg_3_0._showThis, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	SLFramework.UGUI.UIClickListener.Get(arg_4_0._actionViewGO):RemoveClickListener()
end

function var_0_0.onOpen(arg_5_0)
	return
end

function var_0_0._hideThis(arg_6_0)
	gohelper.setActive(arg_6_0._actionViewGO, false)
end

function var_0_0._showThis(arg_7_0)
	gohelper.setActive(arg_7_0._actionViewGO, true)

	local var_7_0 = GameSceneMgr.instance:getCurScene()

	if SkillEditorMgr.instance.cur_select_entity_id then
		arg_7_0._attacker = var_7_0.entityMgr:getEntity(SkillEditorMgr.instance.cur_select_entity_id)
	else
		arg_7_0._attacker = var_7_0.entityMgr:getEntityByPosId(SceneTag.UnitPlayer, SkillEditorView.selectPosId[FightEnum.EntitySide.MySide])
	end

	if not arg_7_0._attacker then
		logError("所选对象错误，请从新选择对象")

		return
	end

	arg_7_0.entity_mo = arg_7_0._attacker:getMO()

	local var_7_1 = SkinConfig.instance:getCharacterSkinCoList(arg_7_0.entity_mo.modelId) or {}

	gohelper.CreateObjList(arg_7_0, arg_7_0.OnItemShow, var_7_1, arg_7_0._itemGOParent, arg_7_0._itemGOPrefab)

	if #var_7_1 == 0 then
		logError("所选对象没有可选皮肤")
		arg_7_0:_hideThis()
	end
end

function var_0_0.OnItemShow(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_1.transform:Find("Text"):GetComponent(gohelper.Type_TextMesh).text = arg_8_2.des

	local var_8_0 = arg_8_1:GetComponent(typeof(SLFramework.UGUI.ButtonWrap))

	arg_8_0:removeClickCb(var_8_0)
	arg_8_0:addClickCb(var_8_0, arg_8_0.OnItemClick, arg_8_0, arg_8_2)
end

function var_0_0.OnItemClick(arg_9_0, arg_9_1)
	local var_9_0 = SkillEditorMgr.instance.cur_select_side
	local var_9_1, var_9_2 = SkillEditorMgr.instance:getTypeInfo(var_9_0)

	var_9_2.skinIds[arg_9_0.entity_mo.position] = arg_9_1.id

	SkillEditorMgr.instance:setTypeInfo(var_9_0, var_9_1, var_9_2.ids, var_9_2.skinIds, var_9_2.groupId)

	local var_9_3 = var_9_0 == FightEnum.EntitySide.MySide and SceneTag.UnitPlayer or SceneTag.UnitMonster
	local var_9_4 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_9_5 = var_9_4:getEntity(arg_9_0._attacker.id)

	if var_9_5.skill then
		var_9_5.skill:stopSkill()
	end

	FightController.instance:dispatchEvent(FightEvent.BeforeDeadEffect, var_9_5.id)
	var_9_4:removeUnit(var_9_3, arg_9_0._attacker.id)

	arg_9_0.entity_mo.skin = arg_9_1.id

	if FightDataHelper.entityMgr:isSub(arg_9_0.entity_mo.id) then
		var_9_4:buildSubSpine(arg_9_0.entity_mo)
	else
		var_9_4:buildSpine(arg_9_0.entity_mo)
	end
end

return var_0_0
