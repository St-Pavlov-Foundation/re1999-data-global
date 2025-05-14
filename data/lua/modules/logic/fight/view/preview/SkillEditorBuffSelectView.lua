module("modules.logic.fight.view.preview.SkillEditorBuffSelectView", package.seeall)

local var_0_0 = class("SkillEditorBuffSelectView", BaseView)

var_0_0.idCounter = 0
var_0_0._show_frame = false

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._buffViewGO = gohelper.findChild(arg_2_0.viewGO, "selectBuff")
	arg_2_0._btnBuffPreviewL = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "scene/Grid/btnBuffPreview")
	arg_2_0._inp = gohelper.findChildTextMeshInputField(arg_2_0.viewGO, "selectBuff/inp")
	arg_2_0._btnClose = SLFramework.UGUI.ButtonWrap.GetWithPath(arg_2_0.viewGO, "selectBuff/btnClose")
	arg_2_0._btnClearBuff = SLFramework.UGUI.ButtonWrap.GetWithPath(arg_2_0.viewGO, "selectBuff/btnClearBuff")
	arg_2_0._btnswitchframestate = SLFramework.UGUI.ButtonWrap.GetWithPath(arg_2_0.viewGO, "selectBuff/btnSwitchFrameState")
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnBuffPreviewL:AddClickListener(arg_3_0._showThis, arg_3_0, FightEnum.EntitySide.EnemySide)
	arg_3_0._inp:AddOnValueChanged(arg_3_0._onInpValueChanged, arg_3_0)
	arg_3_0._btnClose:AddClickListener(arg_3_0._hideThis, arg_3_0)
	arg_3_0._btnClearBuff:AddClickListener(arg_3_0._clearBuff, arg_3_0)
	arg_3_0._btnswitchframestate:AddClickListener(arg_3_0._onSwitchFrameState, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnEditorPlayBuffStart, arg_3_0._onPlayBuffStart, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnEditorPlayBuffEnd, arg_3_0._onPlayBuffEnd, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnBuffClick, arg_3_0._onBuffClick, arg_3_0)
	SLFramework.UGUI.UIClickListener.Get(arg_3_0._buffViewGO):AddClickListener(arg_3_0._hideThis, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnBuffPreviewL:RemoveClickListener()
	arg_4_0._inp:RemoveOnValueChanged()
	arg_4_0._btnClose:RemoveClickListener()
	arg_4_0._btnClearBuff:RemoveClickListener()
	arg_4_0._btnswitchframestate:RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(arg_4_0._buffViewGO):RemoveClickListener()
end

function var_0_0._showThis(arg_5_0, arg_5_1)
	local var_5_0 = GameSceneMgr.instance:getCurScene()

	if SkillEditorMgr.instance.cur_select_entity_id then
		arg_5_0._attacker = var_5_0.entityMgr:getEntity(SkillEditorMgr.instance.cur_select_entity_id)
	else
		arg_5_0._attacker = var_5_0.entityMgr:getEntityByPosId(SceneTag.UnitPlayer, SkillEditorView.selectPosId[FightEnum.EntitySide.MySide])
	end

	if not arg_5_0._attacker then
		logError("所选对象错误，请从新选择对象")

		return
	end

	gohelper.setActive(arg_5_0._buffViewGO, true)
	arg_5_0:_updateItems()
end

function var_0_0._hideThis(arg_6_0)
	gohelper.setActive(arg_6_0._buffViewGO, false)
end

function var_0_0._onInpValueChanged(arg_7_0, arg_7_1)
	arg_7_0:_updateItems()
end

function var_0_0._clearBuff(arg_8_0)
	local var_8_0 = FightHelper.getSideEntitys(SkillEditorMgr.instance.cur_select_side, false)

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_1 = iter_8_1:getMO():getBuffDic()

		for iter_8_2, iter_8_3 in pairs(var_8_1) do
			iter_8_1:getMO():delBuff(iter_8_3.uid)
			iter_8_1.buff:delBuff(iter_8_3.uid)
		end
	end

	FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate)
	arg_8_0:_hideThis()
end

function var_0_0._updateItems(arg_9_0)
	SkillEditorBuffSelectModel.instance:setSelect(arg_9_0._attacker, arg_9_0._inp:GetText())
end

function var_0_0.genBuffUid()
	var_0_0.idCounter = var_0_0.idCounter + 1

	return var_0_0.idCounter
end

function var_0_0._onSwitchFrameState(arg_11_0)
	var_0_0._show_frame = not var_0_0._show_frame
	arg_11_0._btnswitchframestate.transform:Find("Text"):GetComponent(gohelper.Type_TextMesh).text = var_0_0._show_frame and "关闭帧数显示" or "开启帧数显示"
end

function var_0_0._onPlayBuffStart(arg_12_0)
	gohelper.setActive(arg_12_0._buffViewGO, false)
end

function var_0_0._onPlayBuffEnd(arg_13_0)
	gohelper.setActive(arg_13_0._buffViewGO, true)
end

function var_0_0._onBuffClick(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	ViewMgr.instance:openView(ViewName.FightBuffTipsView, arg_14_1)
end

return var_0_0
