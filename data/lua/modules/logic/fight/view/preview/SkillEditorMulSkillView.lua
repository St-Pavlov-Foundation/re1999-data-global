module("modules.logic.fight.view.preview.SkillEditorMulSkillView", package.seeall)

local var_0_0 = class("SkillEditorMulSkillView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._infos = {}
	arg_1_0._btnMulSkill = gohelper.findChildButton(arg_1_0.viewGO, "scene/Grid/btnMulSkill")
	arg_1_0._btnClose = gohelper.findChildButton(arg_1_0.viewGO, "mulSkill/btnGroup/btnClose")
	arg_1_0._btnStart = gohelper.findChildButton(arg_1_0.viewGO, "mulSkill/btnGroup/btnStart")
	arg_1_0._toggleParallel = gohelper.findChildToggle(arg_1_0.viewGO, "mulSkill/btnGroup/toggleParallel")
	arg_1_0._toggleNoSpeedUp = gohelper.findChildToggle(arg_1_0.viewGO, "mulSkill/btnGroup/toggleNoSpeedUp")
	arg_1_0._toggleHideAllUI = gohelper.findChildToggle(arg_1_0.viewGO, "mulSkill/btnGroup/toggleHideAllUI")
	arg_1_0._toggleDelay = gohelper.findChildToggle(arg_1_0.viewGO, "mulSkill/btnGroup/toggleDelay")
	arg_1_0._inputDelay = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "mulSkill/btnGroup/toggleDelay/#input_delay")
	arg_1_0._mulSkillViewGO = gohelper.findChild(arg_1_0.viewGO, "mulSkill")
	arg_1_0._items = {
		gohelper.findChild(arg_1_0.viewGO, "mulSkill/content/item")
	}

	gohelper.setActive(arg_1_0._mulSkillViewGO, false)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnMulSkill, arg_2_0._showThis, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnClose, arg_2_0._hideThis, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnStart, arg_2_0._onClickStart, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0._btnMulSkill, arg_3_0._showThis, arg_3_0)
	arg_3_0:removeClickCb(arg_3_0._btnClose, arg_3_0._hideThis, arg_3_0)
	arg_3_0:removeClickCb(arg_3_0._btnStart, arg_3_0._onClickStart, arg_3_0)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._items) do
		gohelper.findChildButtonWithAudio(iter_3_1, "imgRemove"):RemoveClickListener()
	end
end

function var_0_0._showThis(arg_4_0)
	gohelper.setActive(arg_4_0._mulSkillViewGO, true)
	arg_4_0:_updateItems()
	SkillEditorMgr.instance:registerCallback(SkillEditorMgr.OnSelectSkill, arg_4_0._onSelectSkill, arg_4_0)
end

function var_0_0._hideThis(arg_5_0)
	gohelper.setActive(arg_5_0._mulSkillViewGO, false)
	SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr.OnSelectSkill, arg_5_0._onSelectSkill, arg_5_0)
end

function var_0_0._onSelectSkill(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {}
	local var_6_1 = arg_6_1.side
	local var_6_2 = var_6_1 == FightEnum.EntitySide.EnemySide and FightEnum.EntitySide.MySide or FightEnum.EntitySide.EnemySide

	var_6_0.stancePos, var_6_0.side = SkillEditorView.selectPosId[var_6_1], var_6_1
	var_6_0.modelId = arg_6_1.modelId
	var_6_0.skillId = arg_6_2

	local var_6_3 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_6_4 = var_6_1 == FightEnum.EntitySide.MySide and SceneTag.UnitMonster or SceneTag.UnitPlayer

	var_6_0.targetId = var_6_3:getEntityByPosId(var_6_4, SkillEditorView.selectPosId[var_6_2]).id

	table.insert(arg_6_0._infos, var_6_0)
	arg_6_0:_updateItems()
end

function var_0_0._updateItems(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._infos) do
		local var_7_0 = arg_7_0._items[iter_7_0]

		if not var_7_0 then
			var_7_0 = gohelper.cloneInPlace(arg_7_0._items[1], "item" .. iter_7_0)

			table.insert(arg_7_0._items, var_7_0)
		end

		gohelper.setActive(var_7_0, true)

		local var_7_1 = FightDataHelper.entityMgr:getByPosId(iter_7_1.side, iter_7_1.stancePos)

		if var_7_1 then
			local var_7_2 = gohelper.findChildText(var_7_0, "Text")
			local var_7_3 = var_7_1:getEntityName()
			local var_7_4 = FightConfig.instance:getSkinSkillTimeline(var_7_1.skin, iter_7_1.skillId)
			local var_7_5 = string.split(var_7_4, "_")
			local var_7_6 = var_7_5[#var_7_5]

			var_7_2.text = string.format("%s-%s", var_7_3, var_7_6)
		end

		gohelper.findChildButtonWithAudio(var_7_0, "imgRemove"):AddClickListener(arg_7_0._onClickRemoveInfo, arg_7_0, iter_7_0)
	end

	for iter_7_2 = #arg_7_0._infos + 1, #arg_7_0._items do
		gohelper.setActive(arg_7_0._items[iter_7_2], false)
	end
end

function var_0_0._onClickRemoveInfo(arg_8_0, arg_8_1)
	table.remove(arg_8_0._infos, arg_8_1)
	arg_8_0:_updateItems()
end

function var_0_0._onClickStart(arg_9_0)
	if not arg_9_0._infos or #arg_9_0._infos == 0 then
		GameFacade.showToast(ToastEnum.IconId, "未添加技能")

		return
	end

	FightDataHelper.stateMgr:setAutoState(arg_9_0._toggleParallel.isOn)

	if arg_9_0._toggleNoSpeedUp.isOn then
		-- block empty
	else
		FightDataHelper.stateMgr.isReplay = true

		FightModel.instance:setUserSpeed(FightModel.instance:getUserSpeed())
		FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	end

	local var_9_0 = FightRoundData.New(FightDef_pb.FightRound())

	FightDataHelper.roundMgr:setRoundData(var_9_0)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._infos) do
		local var_9_1 = iter_9_1.skillId
		local var_9_2 = FightDataHelper.entityMgr:getByPosId(iter_9_1.side, iter_9_1.stancePos)

		if var_9_2 then
			local var_9_3 = var_9_2.id
			local var_9_4 = iter_9_1.targetId
			local var_9_5 = iter_9_1.side

			if var_9_5 ~= FightEnum.EntitySide.MySide or not FightEnum.EntitySide.EnemySide then
				local var_9_6 = FightEnum.EntitySide.MySide
			end

			local var_9_7 = FightHelper.getTargetLimits(var_9_5, var_9_1)

			if var_9_7 and #var_9_7 > 0 and not tabletool.indexOf(var_9_7, var_9_4) then
				var_9_4 = var_9_7[1]
			end

			local var_9_8 = SkillEditorStepBuilder.buildFightStepDataList(var_9_1, var_9_3, var_9_4)

			tabletool.addValues(var_9_0.fightStep, var_9_8)
		end
	end

	local var_9_9 = arg_9_0._inputDelay:GetText()
	local var_9_10

	var_9_10 = tonumber(var_9_9) or 0
	arg_9_0._playSkillsFlow = FlowSequence.New()

	if arg_9_0._toggleDelay.isOn and var_9_10 > 0 then
		arg_9_0._playSkillsFlow:addWork(WorkWaitSeconds.New(var_9_10))
	end

	local var_9_11, var_9_12 = FightStepBuilder.buildStepWorkList(var_9_0.fightStep)

	for iter_9_2, iter_9_3 in ipairs(var_9_11) do
		arg_9_0._playSkillsFlow:addWork(iter_9_3)
	end

	if arg_9_0._toggleDelay.isOn and var_9_10 > 0 then
		arg_9_0._playSkillsFlow:addWork(WorkWaitSeconds.New(var_9_10))
	end

	arg_9_0._playSkillsFlow:registerDoneListener(arg_9_0._onPlaySkillsEnd, arg_9_0)
	arg_9_0._playSkillsFlow:start()
	gohelper.setActive(arg_9_0.viewGO, false)

	if arg_9_0._toggleHideAllUI.isOn then
		arg_9_0:hideAllUI()
	end
end

function var_0_0.hideAllUI(arg_10_0)
	arg_10_0:setNameUIActive(false)
	arg_10_0:setViewActive(false)
	arg_10_0:setFrameActive(false)
end

function var_0_0.showAllUI(arg_11_0)
	arg_11_0:setNameUIActive(true)
	arg_11_0:setViewActive(true)
	arg_11_0:setFrameActive(true)
end

function var_0_0.setNameUIActive(arg_12_0, arg_12_1)
	local var_12_0 = GameSceneMgr.instance:getCurScene().entityMgr._tagUnitDict

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		for iter_12_2, iter_12_3 in pairs(iter_12_1) do
			local var_12_1 = iter_12_3.nameUI

			if var_12_1 then
				gohelper.setActive(var_12_1:getGO(), arg_12_1)
			end
		end
	end
end

function var_0_0.setViewActive(arg_13_0, arg_13_1)
	local var_13_0 = ViewMgr.instance:getContainer(ViewName.SkillEffectStatView)

	if var_13_0 then
		gohelper.setActive(var_13_0.viewGO, arg_13_1)
	end
end

function var_0_0.setFrameActive(arg_14_0, arg_14_1)
	local var_14_0 = ViewMgr.instance:getUIRoot()
	local var_14_1 = gohelper.findChild(var_14_0, "Text")

	gohelper.setActive(var_14_1, arg_14_1)
end

function var_0_0._onPlaySkillsEnd(arg_15_0)
	arg_15_0._playSkillsFlow:unregisterDoneListener(arg_15_0._onPlaySkillsEnd, arg_15_0)
	gohelper.setActive(arg_15_0.viewGO, true)

	FightDataHelper.stateMgr.isReplay = false

	FightModel.instance:setUserSpeed(FightModel.instance:getUserSpeed())
	FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	arg_15_0:showAllUI()
end

return var_0_0
