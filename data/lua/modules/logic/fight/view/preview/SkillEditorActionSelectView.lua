module("modules.logic.fight.view.preview.SkillEditorActionSelectView", package.seeall)

slot0 = class("SkillEditorActionSelectView", BaseView)

function slot0.onInitView(slot0)
	slot0._itemGOs = slot0:getUserDataTb_()
	slot0._actionViewGO = gohelper.findChild(slot0.viewGO, "selectAction")
	slot0._btnActionPreviewL = gohelper.findChildButtonWithAudio(slot0.viewGO, "scene/Grid/btnActionPreview")
	slot0._itemGOParent = gohelper.findChild(slot0.viewGO, "selectAction/scroll/content")
	slot0._itemGOPrefab = gohelper.findChild(slot0.viewGO, "selectAction/scroll/item")

	gohelper.setActive(slot0._itemGOPrefab, false)

	slot0._btnClose = SLFramework.UGUI.ButtonWrap.GetWithPath(slot0.viewGO, "selectAction/btnClose")
	slot0._btnMulti = gohelper.findChildButtonWithAudio(slot0.viewGO, "selectAction/btnMulti")
	slot0._txtMulti = gohelper.findChildText(slot0.viewGO, "selectAction/btnMulti/image/txtMulti")
	slot0._toggleLoop = gohelper.findChildToggle(slot0.viewGO, "selectAction/toggleLoop")
	slot0._toggleMulti = gohelper.findChildToggle(slot0.viewGO, "selectAction/toggleMulti")
	slot0._multiImgTr = gohelper.findChild(slot0.viewGO, "selectAction/btnMulti/image").transform
	slot0._toggleLoop.isOn = false
	slot0._toggleMulti.isOn = false

	gohelper.setActive(slot0._btnMulti.gameObject, false)

	slot0._multiList = {}
end

function slot0.addEvents(slot0)
	slot0._btnActionPreviewL:AddClickListener(slot0._showThis, slot0)
	slot0._btnClose:AddClickListener(slot0._hideThis, slot0)
	slot0._btnMulti:AddClickListener(slot0._onClickMulti, slot0)
	slot0._toggleMulti:AddOnValueChanged(slot0._onToggleMultiChange, slot0)
	SLFramework.UGUI.UIClickListener.Get(slot0._actionViewGO):AddClickListener(slot0._hideThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnActionPreviewL:RemoveClickListener()
	slot0._btnClose:RemoveClickListener()
	slot0._btnMulti:RemoveClickListener()
	slot0._toggleMulti:RemoveOnValueChanged()
	SLFramework.UGUI.UIClickListener.Get(slot0._actionViewGO):RemoveClickListener()
end

function slot0._showThis(slot0, slot1)
	if SkillEditorMgr.instance.cur_select_entity_id then
		slot0._attacker = GameSceneMgr.instance:getCurScene().entityMgr:getEntity(SkillEditorMgr.instance.cur_select_entity_id)
	else
		slot0._attacker = slot2.entityMgr:getEntityByPosId(SceneTag.UnitPlayer, SkillEditorView.selectPosId[FightEnum.EntitySide.MySide])
	end

	if not slot0._attacker then
		logError("所选对象错误，请从新选择对象")

		return
	end

	slot0._skinId = slot0._attacker:getMO().skin

	gohelper.setActive(slot0._actionViewGO, true)
	slot0:_updateItems()
end

function slot0._hideThis(slot0)
	FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniEnd)
	gohelper.setActive(slot0._actionViewGO, false)
end

function slot0._updateItems(slot0)
	for slot5, slot6 in ipairs(slot0:_getActionNameList()) do
		if not slot0._itemGOs[slot5] then
			slot7 = gohelper.clone(slot0._itemGOPrefab, slot0._itemGOParent, "item" .. slot5)

			slot0:addClickCb(SLFramework.UGUI.UIClickListener.Get(slot7), slot0._onClickItem, slot0, slot5)
			table.insert(slot0._itemGOs, slot7)
		end

		gohelper.setActive(slot7, true)

		gohelper.findChildText(slot7, "Text").text = slot6 .. (slot0._attacker.spine:hasAnimation(slot6) and "" or "(缺)")
	end

	for slot5 = #slot1 + 1, #slot0._itemGOs do
		gohelper.setActive(slot0._itemGOs[slot5], false)
	end

	recthelper.setHeight(slot0._itemGOParent.transform, (#slot1 / 6 + 1) * 100)
end

function slot0._onClickMulti(slot0)
	if #slot0._multiList > 0 then
		slot0._multiIndex = 1

		slot0:_playMultiAction()
	else
		GameFacade.showToast(ToastEnum.IconId, "未选择动作")
	end
end

function slot0._onToggleMultiChange(slot0, slot1)
	gohelper.setActive(slot0._btnMulti.gameObject, slot0._toggleMulti.isOn)

	if not slot1 then
		tabletool.clear(slot0._multiList)

		slot0._txtMulti.text = ""

		recthelper.setWidth(slot0._multiImgTr, 0)
	end
end

function slot0._playMultiAction(slot0)
	if slot0._multiList[slot0._multiIndex] then
		slot0._attacker.spine:removeAnimEventCallback(slot0._onMultiAnimEvent, slot0)
		slot0._attacker.spine:addAnimEventCallback(slot0._onMultiAnimEvent, slot0)
		slot0._attacker.spine.super.play(slot0._attacker.spine, slot1, false, true)
		FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniStart, slot0._attacker)
	else
		FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniEnd)
		slot0._attacker.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
		slot0._attacker:resetAnimState()
	end

	slot2 = ""

	for slot6, slot7 in ipairs(slot0._multiList) do
		slot8 = slot6 == #slot0._multiList and "" or "->"
		slot2 = (slot6 ~= slot0._multiIndex or string.format("%s<color=red>%s</color>%s", slot2, slot7, slot8)) and string.format("%s%s%s", string.format("%s<color=red>%s</color>%s", slot2, slot7, slot8), slot7, slot8)
	end

	slot0._txtMulti.text = slot2
end

function slot0._onMultiAnimEvent(slot0, slot1, slot2, slot3)
	if slot2 == SpineAnimEvent.ActionComplete then
		slot0._multiIndex = slot0._multiIndex + 1

		slot0:_playMultiAction()
	end
end

function slot0._onClickItem(slot0, slot1)
	if slot0._toggleMulti.isOn then
		table.insert(slot0._multiList, slot0:_getActionNameList()[slot1])

		slot0._txtMulti.text = table.concat(slot0._multiList, "->")

		recthelper.setWidth(slot0._multiImgTr, slot0._txtMulti.preferredWidth)
	elseif slot0._toggleLoop.isOn then
		slot0._attacker.spine:play(slot3, true, true)
	else
		slot0._attacker.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
		TaskDispatcher.cancelTask(slot0._delayResetAnim, slot0)

		if FightConfig.instance:getSkinSpineActionDict(slot0._skinId) and slot4[slot3] and slot5.effectRemoveTime > 0 then
			TaskDispatcher.runDelay(slot0._delayResetAnim, slot0, slot5.effectRemoveTime / FightModel.instance:getSpeed())
		else
			slot0._ani_need_transition, slot0._transition_ani = FightHelper.needPlayTransitionAni(slot0._attacker, slot3)

			slot0._attacker.spine:addAnimEventCallback(slot0._onAnimEvent, slot0)
		end

		slot0._attacker.spine:play(slot3, false, true)
		FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniStart, slot0._attacker)
	end
end

function slot0._delayResetAnim(slot0)
	FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniEnd)
	slot0._attacker.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
	slot0._attacker:resetAnimState()
end

function slot0._onAnimEvent(slot0, slot1, slot2, slot3)
	if slot2 == SpineAnimEvent.ActionComplete then
		if slot0._ani_need_transition and slot0._transition_ani == slot1 then
			return
		end

		FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniEnd)
		slot0._attacker.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
		slot0._attacker:resetAnimState()
	end
end

slot1 = {
	"die",
	"hit",
	"idle",
	"sleep",
	"freeze"
}

function slot0._getActionNameList(slot0)
	for slot5, slot6 in pairs(SpineAnimState) do
		if type(slot6) == "string" and slot0._attacker.spine:hasAnimation(slot6) then
			table.insert({}, slot6)
		end
	end

	for slot5, slot6 in ipairs(uv0) do
		if not tabletool.indexOf(slot1, slot6) then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

return slot0
