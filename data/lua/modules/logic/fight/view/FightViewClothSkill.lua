module("modules.logic.fight.view.FightViewClothSkill", package.seeall)

slot0 = class("FightViewClothSkill", BaseView)
slot1 = {
	Expanding = 3,
	Simple = 1,
	Shrinking = 4,
	Detail = 2
}
slot3 = {
	[60004] = true
}

function slot0.onInitView(slot0)
	slot0._txtNum = gohelper.findChildText(slot0.viewGO, "root/heroSkill/#go_simple/skillicon/#txt_simpleCurCount")
	slot0._txtNum1 = gohelper.findChildText(slot0.viewGO, "root/heroSkill/#go_detail/#txt_detailCurCount")
	slot0._txtmax = gohelper.findChildText(slot0.viewGO, "root/heroSkill/#go_simple/skillicon/max/txtmax")
	slot0._heroSkillGO = gohelper.findChild(slot0.viewGO, "root/heroSkill")
	slot0._pcSkillGO = gohelper.findChild(slot0.viewGO, "root/heroSkill/#go_pcbtn")
	slot0._pcSkill1 = gohelper.findChild(slot0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem1/#go_pcbtn1")
	slot0._pcSkill2 = gohelper.findChild(slot0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem2/#go_pcbtn2")
	slot0._pcSkillDetail = gohelper.findChild(slot0.viewGO, "root/heroSkill/#go_detail/#go_pcbtn3")
	slot0._simpleNotCost = slot0:getUserDataTb_()
	slot0._simpleCanCost = slot0:getUserDataTb_()
	slot0._detailNotCost = slot0:getUserDataTb_()
	slot0._detailCanCost = slot0:getUserDataTb_()
	slot0._detailTxtDesc = slot0:getUserDataTb_()

	table.insert(slot0._simpleNotCost, gohelper.findChild(slot0._heroSkillGO, "#go_simple/skillContent/skill1/notcost1"))
	table.insert(slot0._simpleNotCost, gohelper.findChild(slot0._heroSkillGO, "#go_simple/skillContent/skill2/notcost2"))
	table.insert(slot0._simpleCanCost, gohelper.findChild(slot0._heroSkillGO, "#go_simple/skillContent/skill1/cancost1"))
	table.insert(slot0._simpleCanCost, gohelper.findChild(slot0._heroSkillGO, "#go_simple/skillContent/skill2/cancost2"))
	table.insert(slot0._detailNotCost, gohelper.findChild(slot0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem1/skill1/notcost1"))
	table.insert(slot0._detailNotCost, gohelper.findChild(slot0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem2/skill2/notcost2"))
	table.insert(slot0._detailCanCost, gohelper.findChild(slot0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem1/skill1/cancost1"))
	table.insert(slot0._detailCanCost, gohelper.findChild(slot0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem2/skill2/cancost2"))
	table.insert(slot0._detailTxtDesc, gohelper.findChildText(slot0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem1/desc1"))
	table.insert(slot0._detailTxtDesc, gohelper.findChildText(slot0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem2/desc2"))

	slot0._state = uv0.Simple
	slot0._click = gohelper.getClick(gohelper.findChild(slot0._heroSkillGO, "#go_simple"))
	slot0._animator = slot0._heroSkillGO:GetComponent(typeof(UnityEngine.Animator))

	slot0:_onUpdateSpeed()

	slot0._detailClick = {}

	table.insert(slot0._detailClick, gohelper.getClick(gohelper.findChild(slot0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem1")))

	slot7 = "#go_detail/skillDescContent/#go_skillDescItem2"

	table.insert(slot0._detailClick, gohelper.getClick(gohelper.findChild(slot0._heroSkillGO, slot7)))

	slot0._cardOpAddPower = 0

	for slot7, slot8 in ipairs(lua_cloth.configList) do
		if not gohelper.isNil(gohelper.findChild(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], gohelper.findChild(slot0.viewGO, "root/heroSkill/#go_simple/skilliconnew")), tostring(slot8.id))) then
			gohelper.setActive(slot9, slot8.id == FightModel.instance.clothId)

			if slot8.id == FightModel.instance.clothId then
				slot0._dnaAnim = slot9:GetComponent(typeof(UnityEngine.Animator))
			end
		end
	end

	slot0._maxGO = gohelper.findChild(slot0.viewGO, "root/heroSkill/#go_simple/skillicon/max")

	slot0:showKeyTips()
end

function slot0.addEvents(slot0)
	if not FightReplayModel.instance:isReplay() then
		slot4 = slot0

		slot0._click:AddClickListener(slot0._onClick, slot4)

		for slot4, slot5 in ipairs(slot0._detailClick) do
			slot5:AddClickListener(slot0._onClickSkillIcon, slot0, slot4)
		end

		slot0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, slot0._onTouch, slot0)
	end

	slot0:addEventCb(FightController.instance, FightEvent.DistributeCards, slot0._updateUI, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnPlayHandCard, slot0._onPlayHandCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnMoveHandCard, slot0._onMoveHandCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnCombineOneCard, slot0._onCombineOneCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.StartPlayClothSkill, slot0._onStartPlayClothSkill, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.AfterPlayClothSkill, slot0._onAfterPlayClothSkill, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.CancelOperation, slot0._onCancelOperation, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SimulateClickClothSkillIcon, slot0._simulateClickClothSkillIcon, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.StartReplay, slot0._checkStartReplay, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnUpdateSpeed, slot0._onUpdateSpeed, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.MasterPowerChange, slot0._onMasterPowerChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, slot0._onStartSequenceFinish, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSkillOpen, slot0._onSkillKeyClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSkillIndex, slot0._onSkillSelect, slot0)
end

function slot0.removeEvents(slot0)
	TaskDispatcher.cancelTask(slot0._delayDealTouch, slot0)
	TaskDispatcher.cancelTask(slot0._sendChangeSubRequest, slot0)
	TaskDispatcher.cancelTask(slot0._sendUseClothSkillRequest, slot0)
	TaskDispatcher.cancelTask(slot0._setState, slot0)
	TaskDispatcher.cancelTask(slot0._checkAnyKey, slot0)
	slot0._click:RemoveClickListener()

	for slot4, slot5 in ipairs(slot0._detailClick) do
		slot5:RemoveClickListener()
	end

	slot0:removeEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, slot0._onTouch, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.DistributeCards, slot0._updateUI, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnPlayHandCard, slot0._onPlayHandCard, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnMoveHandCard, slot0._onMoveHandCard, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnCombineOneCard, slot0._onCombineOneCard, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.StartPlayClothSkill, slot0._onStartPlayClothSkill, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.AfterPlayClothSkill, slot0._onAfterPlayClothSkill, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.CancelOperation, slot0._onCancelOperation, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.SimulateClickClothSkillIcon, slot0._simulateClickClothSkillIcon, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.StartReplay, slot0._checkStartReplay, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnUpdateSpeed, slot0._onUpdateSpeed, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.MasterPowerChange, slot0._onMasterPowerChange, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, slot0._onStartSequenceFinish, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.RespUseClothSkillFail, slot0._cancelBlock, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, slot0._cancelBlock, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSkillOpen, slot0._onSkillKeyClick, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSkillIndex, slot0._onSkillSelect, slot0)
end

function slot0._onClick(slot0)
	if FightCardModel.instance:isCardOpEnd() then
		return
	end

	if not FightDataHelper.stageMgr:isEmptyOperateState() then
		return
	end

	if slot0._state == uv0.Simple then
		slot0._animator:Play("fight_heroskill_tips", 0, 0)
		slot0._animator:Update(0)

		slot0._state = uv0.Expanding

		TaskDispatcher.runDelay(slot0._setState, slot0, 0.533)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_shuffle_unfold)
		FightController.instance:dispatchEvent(FightEvent.OnClothSkillExpand)
		slot0._pcSkillGO:SetActive(false)
		slot0._pcSkillDetail:SetActive(true)

		if PCInputController.instance:getIsUse() then
			TaskDispatcher.runRepeat(slot0._checkAnyKey, slot0, 0.01)
		end
	end
end

function slot0.checkSkillKey(slot0)
	for slot4, slot5 in ipairs(BattleActivityAdapter.skillSelectKey) do
		if PCInputController.instance:getActivityFunPress(PCInputModel.Activity.battle, slot5) then
			return true
		end
	end

	return false
end

function slot0._checkAnyKey(slot0)
	if UnityEngine.Input.anyKeyDown and not UnityEngine.Input.GetMouseButton(0) and not slot0:checkSkillKey() and slot0._state == uv0.Detail then
		logNormal("FightViewClothSkill:_checkAnyKey()" .. tostring(UnityEngine.Input.anyKeyDown))
		TaskDispatcher.cancelTask(slot0._checkAnyKey, slot0)

		slot0._hasClickDetailIcon = nil

		slot0:_onSkillKeyClick()
	end
end

function slot0._onSkillKeyClick(slot0)
	if not FightReplayModel.instance:isReplay() then
		if slot0._state == uv0.Detail then
			slot0:_onTouch()
		elseif slot0._state == uv0.Simple then
			slot0:_onClick()
		end
	end
end

function slot0._onSkillSelect(slot0, slot1)
	if not FightReplayModel.instance:isReplay() and slot0._detailClick[slot1] and slot2.gameObject.activeInHierarchy then
		slot0:_onClickSkillIcon(slot1)
	end
end

function slot0._setState(slot0)
	if slot0._state == uv0.Expanding then
		slot0._state = uv0.Detail
	elseif slot0._state == uv0.Shrinking then
		slot0._state = uv0.Simple
	end
end

function slot0._onTouch(slot0)
	if ViewMgr.instance:isOpen(ViewName.GuideView) and gohelper.find(GuideViewMgr.instance.viewParam and slot1.goPath) then
		for slot7, slot8 in ipairs(slot0._detailClick) do
			if slot8.gameObject == slot3 then
				slot0._hasClickDetailIcon = nil

				return
			end
		end
	end

	if slot0._state == uv0.Detail then
		slot1 = Time.timeScale

		TaskDispatcher.runDelay(slot0._delayDealTouch, slot0, 0.01)
	end
end

function slot0._delayDealTouch(slot0)
	if not slot0._hasClickDetailIcon then
		slot0:_shrinkDetailUI()
	end

	slot0._hasClickDetailIcon = nil
end

function slot0.showKeyTips(slot0)
	PCInputController.instance:showkeyTips(slot0._pcSkillGO, PCInputModel.Activity.battle, PCInputModel.battleActivityFun.showSkill)
	PCInputController.instance:showkeyTips(slot0._pcSkillDetail, PCInputModel.Activity.battle, PCInputModel.battleActivityFun.showSkill)
	PCInputController.instance:showkeyTips(slot0._pcSkill1, PCInputModel.Activity.battle, PCInputModel.battleActivityFun.skillUp)
	PCInputController.instance:showkeyTips(slot0._pcSkill2, PCInputModel.Activity.battle, PCInputModel.battleActivityFun.skillDown)
end

function slot0._shrinkDetailUI(slot0)
	TaskDispatcher.cancelTask(slot0._checkAnyKey, slot0)
	slot0._animator:Play("fight_heroskill_out", 0, 0)
	slot0._animator:Update(0)

	slot0._state = uv0.Shrinking

	TaskDispatcher.runDelay(slot0._setState, slot0, 0.533)
	FightController.instance:dispatchEvent(FightEvent.OnClothSkillShrink)
	slot0._pcSkillGO:SetActive(true)
	slot0._pcSkillDetail:SetActive(false)
end

function slot0.onOpen(slot0)
	slot0:_updateUI()
	slot0:_checkStartReplay()
end

function slot0._onUpdateSpeed(slot0)
	slot0._animator.speed = FightModel.instance:getUISpeed()
end

function slot0._checkStartReplay(slot0)
	if FightReplayModel.instance:isReplay() then
		slot0._click:RemoveClickListener()

		for slot4, slot5 in ipairs(slot0._detailClick) do
			slot5:RemoveClickListener()
		end

		slot0:removeEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, slot0._onTouch, slot0)
	end
end

function slot0._getClothLevelCO(slot0)
	if not FightModel.instance.clothId then
		return
	end

	if not PlayerClothModel.instance:getById(slot1) then
		return
	end

	if not lua_cloth_level.configDict[slot1] then
		return
	end

	return slot3[slot2.level]
end

function slot0._onPlayHandCard(slot0, slot1)
	if not slot1.playCanAddExpoint then
		return
	end

	if slot0:_getClothLevelCO() then
		slot0._cardOpAddPower = slot0._cardOpAddPower + slot2.use

		slot0:_updateUI()
		slot0:_checkPlayPowerMaxAudio(slot0._cardOpAddPower)
	end
end

function slot0._onMoveHandCard(slot0, slot1, slot2, slot3)
	if slot2 == slot3 then
		return
	end

	if not slot1.moveCanAddExpoint then
		return
	end

	if FightEnum.UniversalCard[slot1.skillId] then
		return
	end

	if slot0:_getClothLevelCO() then
		slot0._cardOpAddPower = slot0._cardOpAddPower + slot4.move

		slot0:_updateUI()
		slot0:_checkPlayPowerMaxAudio(slot0._cardOpAddPower)
	end
end

function slot0._onCombineOneCard(slot0, slot1, slot2)
	if not slot1.combineCanAddExpoint then
		return
	end

	if slot2 then
		return
	end

	if slot0:_getClothLevelCO() then
		slot0._cardOpAddPower = slot0._cardOpAddPower + slot3.compose

		slot0:_updateUI()
		slot0:_checkPlayPowerMaxAudio(slot0._cardOpAddPower)
	end
end

function slot0._onMasterPowerChange(slot0)
	if slot0:_getClothLevelCO() then
		slot0:_updateUI()
		slot0:_checkPlayPowerMaxAudio(slot0._cardOpAddPower)
	end
end

function slot0._onStartPlayClothSkill(slot0)
	slot0._lockSimulation = true
	slot0._cardOpAddPower = 0

	slot0:_updateUI()
	slot0:_checkPlayPowerMaxAudio()
	slot0:_shrinkDetailUI()
end

function slot0._onAfterPlayClothSkill(slot0)
	slot0._lockSimulation = false
	slot0._cardOpAddPower = 0
end

function slot0._onCancelOperation(slot0)
	slot0._cardOpAddPower = 0

	slot0:_updateUI()
	slot0:_checkPlayPowerMaxAudio()
end

function slot0._onRoundSequenceFinish(slot0)
	slot0._cardOpAddPower = 0

	slot0:_updateUI()
	slot0:_checkPlayPowerMaxAudio()
end

function slot0._getClothSkillList(slot0)
	slot1 = tabletool.copy

	for slot5 = #slot1(FightModel.instance:getClothSkillList() or {}), 1, -1 do
		if slot1[slot5].type ~= FightEnum.ClothSkillPerformanceType.Normal then
			table.remove(slot1, slot5)
		end
	end

	return slot1
end

function slot0._canUseAnySkill(slot0)
	slot2 = slot0:_getClothSkillList()

	for slot6 = 1, 2 do
		if slot2 and slot2[slot6] and lua_skill.configDict[slot7.skillId] and slot7.cd <= 0 and slot7.needPower <= FightModel.instance.power then
			return true
		end
	end
end

function slot0._updateUI(slot0)
	slot1 = slot0:_getClothSkillList()

	for slot7 = 1, 2 do
		if slot1 and slot1[slot7] then
			if lua_skill.configDict[slot8.skillId] then
				slot10 = slot8.cd <= 0 and slot8.needPower <= FightModel.instance.power

				gohelper.setActive(slot0._simpleNotCost[slot7], not slot10)
				gohelper.setActive(slot0._simpleCanCost[slot7], slot10)
				gohelper.setActive(slot0._detailNotCost[slot7], not slot10)
				gohelper.setActive(slot0._detailCanCost[slot7], slot10)
				gohelper.setActive(({
					slot0._pcSkill1,
					slot0._pcSkill2
				})[slot7], slot10)

				slot0._detailTxtDesc[slot7].text = FightConfig.instance:getSkillEffectDesc(nil, slot9) .. "\nCOST<color=#FFA500>-" .. slot8.needPower .. "</color>"
			else
				logError("主角技能配置不存在，技能id = " .. slot8.skillId)
			end
		end
	end

	if slot0:_getClothLevelCO() then
		if not slot0._lockSimulation then
			slot5 = slot2 + slot0._cardOpAddPower
		end

		slot5 = Mathf.Clamp(slot5, 0, slot4.maxPower)
		slot7 = tonumber(slot0._txtNum.text) or 0
		slot0._txtNum.text = slot5
		slot0._txtNum1.text = slot5
		slot0._txtmax.text = slot6

		gohelper.setActive(slot0._maxGO, slot5 > 0 and slot5 == slot6)
	else
		slot0._txtNum.text = slot2
		slot0._txtNum1.text = slot2
		slot0._txtmax.text = ""

		gohelper.setActive(slot0._maxGO, false)
	end
end

function slot0._onStartSequenceFinish(slot0)
	if slot0:_getClothLevelCO() then
		if not slot0._lockSimulation then
			slot2 = FightModel.instance.power + slot0._cardOpAddPower
		end

		slot0._cardOpAddPower = 0
		FightModel.instance.power = Mathf.Clamp(slot2, 0, slot1.maxPower)

		slot0:_updateUI()
	end
end

function slot0._checkPlayPowerMaxAudio(slot0, slot1)
	slot3 = slot0:_getClothLevelCO()
	slot5 = slot1 or 0
	slot5 = slot3 and slot3.maxPower or 0
	slot4 = Mathf.Clamp(FightModel.instance.power + slot5, 0, slot5)

	if (slot0._prevPower or 0) < slot5 and slot4 > 0 and slot4 == slot5 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_clothskill_power_max)
	end

	slot0._prevPower = slot4
end

function slot0._onClickSkillIcon(slot0, slot1)
	slot2 = slot0._clothSkillOp
	slot0._clothSkillOp = nil
	slot0._hasClickDetailIcon = true

	if FightCardModel.instance:isCardOpEnd() then
		return
	end

	if FightViewHandCard.blockOperate or FightModel.instance:isAuto() then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if #FightCardModel.instance:getCardOps() > 0 then
		GameFacade.showToast(ToastEnum.FightCardOps)

		return
	end

	slot5 = FightModel.instance.power
	slot6 = slot0:_getClothSkillList() and slot4[slot1]
	slot0._toUseSkillId = slot6 and slot6.skillId

	if slot6.cd > 0 then
		GameFacade.showToast(ToastEnum.UseSkill2)

		return
	end

	if not slot0._toUseSkillId or slot5 < slot6.needPower then
		GameFacade.showToast(ToastEnum.UseSkill1)

		return
	end

	slot7 = lua_skill.configDict[slot0._toUseSkillId]

	if slot0:_checkSelectSkillTarget() and slot8 == uv0 then
		if slot2 then
			slot0._fromId = slot2.fromId
			slot0._toId = slot2.toId

			slot0:_sendChangeSubRequest()
		else
			slot0:_selectChangeSub()
		end
	elseif slot7 and FightEnum.ShowLogicTargetView[slot7.logicTarget] and slot7.targetLimit == FightEnum.TargetLimit.MySide then
		if slot2 then
			slot0:_selectCallback(slot2.toId)
		else
			ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
				skillId = slot0._toUseSkillId,
				callback = slot0._selectCallback,
				callbackObj = slot0
			})
		end
	else
		slot0:_sendUseClothSkill()
	end
end

function slot0._selectCallback(slot0, slot1)
	slot0._fromId = nil
	slot0._toId = slot1

	slot0:_useSkillAfterSelect()
end

function slot0._useSkillAfterSelect(slot0)
	if slot0._dnaAnim then
		slot0._dnaAnim:Play("fight_heroskill_icon_click", 0, 0)
		slot0._dnaAnim:Update(0)
	end

	TaskDispatcher.runDelay(slot0._useSkillAfterPerformance, slot0, 0.33)
	slot0:_blockClick()
end

function slot0._useSkillAfterPerformance(slot0)
	FightRpc.instance:sendUseClothSkillRequest(slot0._toUseSkillId, slot0._fromId, slot0._toId)
end

function slot0._checkSelectSkillTarget(slot0)
	if lua_skill_effect.configDict[lua_skill.configDict[slot0._toUseSkillId].skillEffect] then
		for slot6 = 1, FightEnum.MaxBehavior do
			if tonumber(slot2["behavior" .. slot6]) and uv0[slot7] then
				return slot7
			end
		end
	end
end

function slot0._selectChangeSub(slot0)
	slot2 = FightDataHelper.entityMgr:getMySubList()
	slot4 = {}

	for slot8, slot9 in ipairs(FightDataHelper.entityMgr:getMyNormalList()) do
		table.insert({}, slot9.id)
	end

	for slot8, slot9 in ipairs(slot2) do
		table.insert(slot4, slot9.id)
	end

	if #slot4 == 0 then
		GameFacade.showToast(ToastEnum.ChangeSubIsNull)

		return
	end

	slot0:_changeSubSelect1(slot3, slot4)
end

function slot0._changeSubSelect1(slot0, slot1, slot2)
	if #slot1 <= 1 then
		slot0._fromId = slot1[1]

		slot0:_changeSubSelect2(slot2)
	else
		ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
			callback = function (slot0)
				uv0._fromId = slot0

				uv0:_changeSubSelect2(uv1)
			end,
			targetLimit = slot1,
			desc = luaLang("fight_select_change")
		})
	end
end

function slot0._changeSubSelect2(slot0, slot1)
	if #slot1 == 1 then
		slot0._toId = slot1[1]

		slot0:_sendChangeSubEntity()
	else
		ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
			callback = function (slot0)
				uv0._toId = slot0

				uv0:_sendChangeSubEntity()
			end,
			targetLimit = slot1,
			desc = luaLang("fight_select_change_sub")
		})
	end
end

function slot0._sendUseClothSkill(slot0)
	if slot0._dnaAnim then
		slot0._dnaAnim:Play("fight_heroskill_icon_click", 0, 0)
		slot0._dnaAnim:Update(0)
	end

	TaskDispatcher.runDelay(slot0._sendUseClothSkillRequest, slot0, 0.33)
	slot0:_blockClick()
end

function slot0._sendUseClothSkillRequest(slot0)
	FightRpc.instance:sendUseClothSkillRequest(slot0._toUseSkillId, nil, FightCardModel.instance.curSelectEntityId)
end

function slot0._sendChangeSubEntity(slot0)
	if slot0._dnaAnim then
		slot0._dnaAnim:Play("fight_heroskill_icon_click", 0, 0)
		slot0._dnaAnim:Update(0)
	end

	TaskDispatcher.runDelay(slot0._sendChangeSubRequest, slot0, 0.33)
	slot0:_blockClick()
end

function slot0._sendChangeSubRequest(slot0)
	FightRpc.instance:sendUseClothSkillRequest(slot0._toUseSkillId, slot0._fromId, slot0._toId)
end

function slot0._blockClick(slot0)
	UIBlockMgr.instance:endAll()

	UIBlockMgrExtend.CircleMvDelay = 10

	UIBlockMgr.instance:startBlock(UIBlockKey.PlayClothSkill)
	slot0:addEventCb(FightController.instance, FightEvent.RespUseClothSkillFail, slot0._cancelBlock, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, slot0._cancelBlock, slot0)
end

function slot0._cancelBlock(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.RespUseClothSkillFail, slot0._cancelBlock, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, slot0._cancelBlock, slot0)

	UIBlockMgrExtend.CircleMvDelay = nil

	UIBlockMgr.instance:endBlock(UIBlockKey.PlayClothSkill)
end

function slot0._simulateClickClothSkillIcon(slot0, slot1)
	if slot1 and slot1.skillId then
		for slot7, slot8 in ipairs(slot0:_getClothSkillList()) do
			if slot8.skillId == slot2 then
				slot0._clothSkillOp = slot1

				slot0:_onClickSkillIcon(slot7)

				return
			end
		end

		logError("主角技能不存在：" .. slot2 .. ", " .. cjson.encode(slot3))
	end
end

return slot0
