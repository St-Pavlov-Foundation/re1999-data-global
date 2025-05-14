module("modules.logic.fight.view.preview.SkillEditorActionSelectView", package.seeall)

local var_0_0 = class("SkillEditorActionSelectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._itemGOs = arg_1_0:getUserDataTb_()
	arg_1_0._actionViewGO = gohelper.findChild(arg_1_0.viewGO, "selectAction")
	arg_1_0._btnActionPreviewL = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "scene/Grid/btnActionPreview")
	arg_1_0._itemGOParent = gohelper.findChild(arg_1_0.viewGO, "selectAction/scroll/content")
	arg_1_0._itemGOPrefab = gohelper.findChild(arg_1_0.viewGO, "selectAction/scroll/item")

	gohelper.setActive(arg_1_0._itemGOPrefab, false)

	arg_1_0._btnClose = SLFramework.UGUI.ButtonWrap.GetWithPath(arg_1_0.viewGO, "selectAction/btnClose")
	arg_1_0._btnMulti = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "selectAction/btnMulti")
	arg_1_0._txtMulti = gohelper.findChildText(arg_1_0.viewGO, "selectAction/btnMulti/image/txtMulti")
	arg_1_0._toggleLoop = gohelper.findChildToggle(arg_1_0.viewGO, "selectAction/toggleLoop")
	arg_1_0._toggleMulti = gohelper.findChildToggle(arg_1_0.viewGO, "selectAction/toggleMulti")
	arg_1_0._multiImgTr = gohelper.findChild(arg_1_0.viewGO, "selectAction/btnMulti/image").transform
	arg_1_0._toggleLoop.isOn = false
	arg_1_0._toggleMulti.isOn = false

	gohelper.setActive(arg_1_0._btnMulti.gameObject, false)

	arg_1_0._multiList = {}
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnActionPreviewL:AddClickListener(arg_2_0._showThis, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._hideThis, arg_2_0)
	arg_2_0._btnMulti:AddClickListener(arg_2_0._onClickMulti, arg_2_0)
	arg_2_0._toggleMulti:AddOnValueChanged(arg_2_0._onToggleMultiChange, arg_2_0)
	SLFramework.UGUI.UIClickListener.Get(arg_2_0._actionViewGO):AddClickListener(arg_2_0._hideThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnActionPreviewL:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnMulti:RemoveClickListener()
	arg_3_0._toggleMulti:RemoveOnValueChanged()
	SLFramework.UGUI.UIClickListener.Get(arg_3_0._actionViewGO):RemoveClickListener()
end

function var_0_0._showThis(arg_4_0, arg_4_1)
	local var_4_0 = GameSceneMgr.instance:getCurScene()

	if SkillEditorMgr.instance.cur_select_entity_id then
		arg_4_0._attacker = var_4_0.entityMgr:getEntity(SkillEditorMgr.instance.cur_select_entity_id)
	else
		arg_4_0._attacker = var_4_0.entityMgr:getEntityByPosId(SceneTag.UnitPlayer, SkillEditorView.selectPosId[FightEnum.EntitySide.MySide])
	end

	if not arg_4_0._attacker then
		logError("所选对象错误，请从新选择对象")

		return
	end

	arg_4_0._skinId = arg_4_0._attacker:getMO().skin

	gohelper.setActive(arg_4_0._actionViewGO, true)
	arg_4_0:_updateItems()
end

function var_0_0._hideThis(arg_5_0)
	FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniEnd)
	gohelper.setActive(arg_5_0._actionViewGO, false)
end

function var_0_0._updateItems(arg_6_0)
	local var_6_0 = arg_6_0:_getActionNameList()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = arg_6_0._itemGOs[iter_6_0]

		if not var_6_1 then
			var_6_1 = gohelper.clone(arg_6_0._itemGOPrefab, arg_6_0._itemGOParent, "item" .. iter_6_0)

			arg_6_0:addClickCb(SLFramework.UGUI.UIClickListener.Get(var_6_1), arg_6_0._onClickItem, arg_6_0, iter_6_0)
			table.insert(arg_6_0._itemGOs, var_6_1)
		end

		gohelper.setActive(var_6_1, true)

		local var_6_2 = gohelper.findChildText(var_6_1, "Text")
		local var_6_3 = arg_6_0._attacker.spine:hasAnimation(iter_6_1)

		var_6_2.text = iter_6_1 .. (var_6_3 and "" or "(缺)")
	end

	for iter_6_2 = #var_6_0 + 1, #arg_6_0._itemGOs do
		gohelper.setActive(arg_6_0._itemGOs[iter_6_2], false)
	end

	local var_6_4 = (#var_6_0 / 6 + 1) * 100

	recthelper.setHeight(arg_6_0._itemGOParent.transform, var_6_4)
end

function var_0_0._onClickMulti(arg_7_0)
	if #arg_7_0._multiList > 0 then
		arg_7_0._multiIndex = 1

		arg_7_0:_playMultiAction()
	else
		GameFacade.showToast(ToastEnum.IconId, "未选择动作")
	end
end

function var_0_0._onToggleMultiChange(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._btnMulti.gameObject, arg_8_0._toggleMulti.isOn)

	if not arg_8_1 then
		tabletool.clear(arg_8_0._multiList)

		arg_8_0._txtMulti.text = ""

		recthelper.setWidth(arg_8_0._multiImgTr, 0)
	end
end

function var_0_0._playMultiAction(arg_9_0)
	local var_9_0 = arg_9_0._multiList[arg_9_0._multiIndex]

	if var_9_0 then
		arg_9_0._attacker.spine:removeAnimEventCallback(arg_9_0._onMultiAnimEvent, arg_9_0)
		arg_9_0._attacker.spine:addAnimEventCallback(arg_9_0._onMultiAnimEvent, arg_9_0)
		arg_9_0._attacker.spine.super.play(arg_9_0._attacker.spine, var_9_0, false, true)
		FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniStart, arg_9_0._attacker)
	else
		FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniEnd)
		arg_9_0._attacker.spine:removeAnimEventCallback(arg_9_0._onAnimEvent, arg_9_0)
		arg_9_0._attacker:resetAnimState()
	end

	local var_9_1 = ""

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._multiList) do
		local var_9_2 = iter_9_0 == #arg_9_0._multiList and "" or "->"

		if iter_9_0 == arg_9_0._multiIndex then
			var_9_1 = string.format("%s<color=red>%s</color>%s", var_9_1, iter_9_1, var_9_2)
		else
			var_9_1 = string.format("%s%s%s", var_9_1, iter_9_1, var_9_2)
		end
	end

	arg_9_0._txtMulti.text = var_9_1
end

function var_0_0._onMultiAnimEvent(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_2 == SpineAnimEvent.ActionComplete then
		arg_10_0._multiIndex = arg_10_0._multiIndex + 1

		arg_10_0:_playMultiAction()
	end
end

function var_0_0._onClickItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:_getActionNameList()[arg_11_1]

	if arg_11_0._toggleMulti.isOn then
		table.insert(arg_11_0._multiList, var_11_0)

		arg_11_0._txtMulti.text = table.concat(arg_11_0._multiList, "->")

		recthelper.setWidth(arg_11_0._multiImgTr, arg_11_0._txtMulti.preferredWidth)
	elseif arg_11_0._toggleLoop.isOn then
		arg_11_0._attacker.spine:play(var_11_0, true, true)
	else
		arg_11_0._attacker.spine:removeAnimEventCallback(arg_11_0._onAnimEvent, arg_11_0)
		TaskDispatcher.cancelTask(arg_11_0._delayResetAnim, arg_11_0)

		local var_11_1 = FightConfig.instance:getSkinSpineActionDict(arg_11_0._skinId)
		local var_11_2 = var_11_1 and var_11_1[var_11_0]

		if var_11_2 and var_11_2.effectRemoveTime > 0 then
			local var_11_3 = var_11_2.effectRemoveTime / FightModel.instance:getSpeed()

			TaskDispatcher.runDelay(arg_11_0._delayResetAnim, arg_11_0, var_11_3)
		else
			arg_11_0._ani_need_transition, arg_11_0._transition_ani = FightHelper.needPlayTransitionAni(arg_11_0._attacker, var_11_0)

			arg_11_0._attacker.spine:addAnimEventCallback(arg_11_0._onAnimEvent, arg_11_0)
		end

		arg_11_0._attacker.spine:play(var_11_0, false, true)
		FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniStart, arg_11_0._attacker)
	end
end

function var_0_0._delayResetAnim(arg_12_0)
	FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniEnd)
	arg_12_0._attacker.spine:removeAnimEventCallback(arg_12_0._onAnimEvent, arg_12_0)
	arg_12_0._attacker:resetAnimState()
end

function var_0_0._onAnimEvent(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_2 == SpineAnimEvent.ActionComplete then
		if arg_13_0._ani_need_transition and arg_13_0._transition_ani == arg_13_1 then
			return
		end

		FightController.instance:dispatchEvent(FightEvent.OnEditorPlaySpineAniEnd)
		arg_13_0._attacker.spine:removeAnimEventCallback(arg_13_0._onAnimEvent, arg_13_0)
		arg_13_0._attacker:resetAnimState()
	end
end

local var_0_1 = {
	"die",
	"hit",
	"idle",
	"sleep",
	"freeze"
}

function var_0_0._getActionNameList(arg_14_0)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(SpineAnimState) do
		if type(iter_14_1) == "string" and arg_14_0._attacker.spine:hasAnimation(iter_14_1) then
			table.insert(var_14_0, iter_14_1)
		end
	end

	for iter_14_2, iter_14_3 in ipairs(var_0_1) do
		if not tabletool.indexOf(var_14_0, iter_14_3) then
			table.insert(var_14_0, iter_14_3)
		end
	end

	return var_14_0
end

return var_0_0
