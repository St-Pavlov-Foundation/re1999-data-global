module("modules.logic.fight.view.preview.SkillEditorBuffSelectView", package.seeall)

slot0 = class("SkillEditorBuffSelectView", BaseView)
slot0.idCounter = 0
slot0._show_frame = false

function slot0.ctor(slot0)
end

function slot0.onInitView(slot0)
	slot0._buffViewGO = gohelper.findChild(slot0.viewGO, "selectBuff")
	slot0._btnBuffPreviewL = gohelper.findChildButtonWithAudio(slot0.viewGO, "scene/Grid/btnBuffPreview")
	slot0._inp = gohelper.findChildTextMeshInputField(slot0.viewGO, "selectBuff/inp")
	slot0._btnClose = SLFramework.UGUI.ButtonWrap.GetWithPath(slot0.viewGO, "selectBuff/btnClose")
	slot0._btnClearBuff = SLFramework.UGUI.ButtonWrap.GetWithPath(slot0.viewGO, "selectBuff/btnClearBuff")
	slot0._btnswitchframestate = SLFramework.UGUI.ButtonWrap.GetWithPath(slot0.viewGO, "selectBuff/btnSwitchFrameState")
end

function slot0.addEvents(slot0)
	slot0._btnBuffPreviewL:AddClickListener(slot0._showThis, slot0, FightEnum.EntitySide.EnemySide)
	slot0._inp:AddOnValueChanged(slot0._onInpValueChanged, slot0)
	slot0._btnClose:AddClickListener(slot0._hideThis, slot0)
	slot0._btnClearBuff:AddClickListener(slot0._clearBuff, slot0)
	slot0._btnswitchframestate:AddClickListener(slot0._onSwitchFrameState, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnEditorPlayBuffStart, slot0._onPlayBuffStart, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnEditorPlayBuffEnd, slot0._onPlayBuffEnd, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnBuffClick, slot0._onBuffClick, slot0)
	SLFramework.UGUI.UIClickListener.Get(slot0._buffViewGO):AddClickListener(slot0._hideThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnBuffPreviewL:RemoveClickListener()
	slot0._inp:RemoveOnValueChanged()
	slot0._btnClose:RemoveClickListener()
	slot0._btnClearBuff:RemoveClickListener()
	slot0._btnswitchframestate:RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(slot0._buffViewGO):RemoveClickListener()
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

	gohelper.setActive(slot0._buffViewGO, true)
	slot0:_updateItems()
end

function slot0._hideThis(slot0)
	gohelper.setActive(slot0._buffViewGO, false)
end

function slot0._onInpValueChanged(slot0, slot1)
	slot0:_updateItems()
end

function slot0._clearBuff(slot0)
	for slot5, slot6 in ipairs(FightHelper.getSideEntitys(SkillEditorMgr.instance.cur_select_side, false)) do
		for slot11, slot12 in pairs(slot6:getMO():getBuffDic()) do
			slot6:getMO():delBuff(slot12.uid)
			slot6.buff:delBuff(slot12.uid)
		end
	end

	FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate)
	slot0:_hideThis()
end

function slot0._updateItems(slot0)
	SkillEditorBuffSelectModel.instance:setSelect(slot0._attacker, slot0._inp:GetText())
end

function slot0.genBuffUid()
	uv0.idCounter = uv0.idCounter + 1

	return uv0.idCounter
end

function slot0._onSwitchFrameState(slot0)
	uv0._show_frame = not uv0._show_frame
	slot0._btnswitchframestate.transform:Find("Text"):GetComponent(gohelper.Type_TextMesh).text = uv0._show_frame and "关闭帧数显示" or "开启帧数显示"
end

function slot0._onPlayBuffStart(slot0)
	gohelper.setActive(slot0._buffViewGO, false)
end

function slot0._onPlayBuffEnd(slot0)
	gohelper.setActive(slot0._buffViewGO, true)
end

function slot0._onBuffClick(slot0, slot1, slot2, slot3, slot4)
	ViewMgr.instance:openView(ViewName.FightBuffTipsView, slot1)
end

return slot0
