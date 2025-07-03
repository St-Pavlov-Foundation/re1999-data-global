module("modules.logic.fight.view.FightViewClothSkill", package.seeall)

local var_0_0 = class("FightViewClothSkill", BaseView)
local var_0_1 = {
	Expanding = 3,
	Simple = 1,
	Shrinking = 4,
	Detail = 2
}
local var_0_2 = 60004
local var_0_3 = {
	[var_0_2] = true
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "root/heroSkill/#go_simple/skillicon/#txt_simpleCurCount")
	arg_1_0._txtNum1 = gohelper.findChildText(arg_1_0.viewGO, "root/heroSkill/#go_detail/#txt_detailCurCount")
	arg_1_0._txtmax = gohelper.findChildText(arg_1_0.viewGO, "root/heroSkill/#go_simple/skillicon/max/txtmax")
	arg_1_0._heroSkillGO = gohelper.findChild(arg_1_0.viewGO, "root/heroSkill")
	arg_1_0._pcSkillGO = gohelper.findChild(arg_1_0.viewGO, "root/heroSkill/#go_pcbtn")
	arg_1_0._pcSkill1 = gohelper.findChild(arg_1_0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem1/#go_pcbtn1")
	arg_1_0._pcSkill2 = gohelper.findChild(arg_1_0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem2/#go_pcbtn2")
	arg_1_0._pcSkillDetail = gohelper.findChild(arg_1_0.viewGO, "root/heroSkill/#go_detail/#go_pcbtn3")
	arg_1_0._simpleNotCost = arg_1_0:getUserDataTb_()
	arg_1_0._simpleCanCost = arg_1_0:getUserDataTb_()
	arg_1_0._detailNotCost = arg_1_0:getUserDataTb_()
	arg_1_0._detailCanCost = arg_1_0:getUserDataTb_()
	arg_1_0._detailTxtDesc = arg_1_0:getUserDataTb_()

	table.insert(arg_1_0._simpleNotCost, gohelper.findChild(arg_1_0._heroSkillGO, "#go_simple/skillContent/skill1/notcost1"))
	table.insert(arg_1_0._simpleNotCost, gohelper.findChild(arg_1_0._heroSkillGO, "#go_simple/skillContent/skill2/notcost2"))
	table.insert(arg_1_0._simpleCanCost, gohelper.findChild(arg_1_0._heroSkillGO, "#go_simple/skillContent/skill1/cancost1"))
	table.insert(arg_1_0._simpleCanCost, gohelper.findChild(arg_1_0._heroSkillGO, "#go_simple/skillContent/skill2/cancost2"))
	table.insert(arg_1_0._detailNotCost, gohelper.findChild(arg_1_0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem1/skill1/notcost1"))
	table.insert(arg_1_0._detailNotCost, gohelper.findChild(arg_1_0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem2/skill2/notcost2"))
	table.insert(arg_1_0._detailCanCost, gohelper.findChild(arg_1_0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem1/skill1/cancost1"))
	table.insert(arg_1_0._detailCanCost, gohelper.findChild(arg_1_0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem2/skill2/cancost2"))
	table.insert(arg_1_0._detailTxtDesc, gohelper.findChildText(arg_1_0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem1/desc1"))
	table.insert(arg_1_0._detailTxtDesc, gohelper.findChildText(arg_1_0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem2/desc2"))

	arg_1_0._state = var_0_1.Simple

	local var_1_0 = gohelper.findChild(arg_1_0._heroSkillGO, "#go_simple")

	arg_1_0._click = gohelper.getClick(var_1_0)
	arg_1_0._animator = arg_1_0._heroSkillGO:GetComponent(typeof(UnityEngine.Animator))

	arg_1_0:_onUpdateSpeed()

	arg_1_0._detailClick = {}

	table.insert(arg_1_0._detailClick, gohelper.getClick(gohelper.findChild(arg_1_0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem1")))
	table.insert(arg_1_0._detailClick, gohelper.getClick(gohelper.findChild(arg_1_0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem2")))

	arg_1_0._cardOpAddPower = 0

	local var_1_1 = gohelper.findChild(arg_1_0.viewGO, "root/heroSkill/#go_simple/skilliconnew")
	local var_1_2 = arg_1_0:getResInst(arg_1_0.viewContainer:getSetting().otherRes[2], var_1_1)

	for iter_1_0, iter_1_1 in ipairs(lua_cloth.configList) do
		local var_1_3 = gohelper.findChild(var_1_2, tostring(iter_1_1.id))

		if not gohelper.isNil(var_1_3) then
			gohelper.setActive(var_1_3, iter_1_1.id == FightModel.instance.clothId)

			if iter_1_1.id == FightModel.instance.clothId then
				arg_1_0._dnaAnim = var_1_3:GetComponent(typeof(UnityEngine.Animator))
			end
		end
	end

	arg_1_0._maxGO = gohelper.findChild(arg_1_0.viewGO, "root/heroSkill/#go_simple/skillicon/max")

	arg_1_0:showKeyTips()
end

function var_0_0.addEvents(arg_2_0)
	if not FightReplayModel.instance:isReplay() then
		arg_2_0._click:AddClickListener(arg_2_0._onClick, arg_2_0)

		for iter_2_0, iter_2_1 in ipairs(arg_2_0._detailClick) do
			iter_2_1:AddClickListener(arg_2_0._onClickSkillIcon, arg_2_0, iter_2_0)
		end

		arg_2_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, arg_2_0._onTouch, arg_2_0)
	end

	arg_2_0:addEventCb(FightController.instance, FightEvent.DistributeCards, arg_2_0._updateUI, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnPlayHandCard, arg_2_0._onPlayHandCard, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnMoveHandCard, arg_2_0._onMoveHandCard, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnCombineOneCard, arg_2_0._onCombineOneCard, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.StartPlayClothSkill, arg_2_0._onStartPlayClothSkill, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.AfterPlayClothSkill, arg_2_0._onAfterPlayClothSkill, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.CancelOperation, arg_2_0._onCancelOperation, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_2_0._onRoundSequenceFinish, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.SimulateClickClothSkillIcon, arg_2_0._simulateClickClothSkillIcon, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.StartReplay, arg_2_0._checkStartReplay, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnUpdateSpeed, arg_2_0._onUpdateSpeed, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.MasterPowerChange, arg_2_0._onMasterPowerChange, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_2_0._onStartSequenceFinish, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSkillOpen, arg_2_0._onSkillKeyClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSkillIndex, arg_2_0._onSkillSelect, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._delayDealTouch, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._sendChangeSubRequest, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._sendUseClothSkillRequest, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._setState, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._checkAnyKey, arg_3_0)
	arg_3_0._click:RemoveClickListener()

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._detailClick) do
		iter_3_1:RemoveClickListener()
	end

	arg_3_0:removeEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, arg_3_0._onTouch, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.DistributeCards, arg_3_0._updateUI, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnPlayHandCard, arg_3_0._onPlayHandCard, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnMoveHandCard, arg_3_0._onMoveHandCard, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnCombineOneCard, arg_3_0._onCombineOneCard, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.StartPlayClothSkill, arg_3_0._onStartPlayClothSkill, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.AfterPlayClothSkill, arg_3_0._onAfterPlayClothSkill, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.CancelOperation, arg_3_0._onCancelOperation, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_3_0._onRoundSequenceFinish, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.SimulateClickClothSkillIcon, arg_3_0._simulateClickClothSkillIcon, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.StartReplay, arg_3_0._checkStartReplay, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnUpdateSpeed, arg_3_0._onUpdateSpeed, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.MasterPowerChange, arg_3_0._onMasterPowerChange, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_3_0._onStartSequenceFinish, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.RespUseClothSkillFail, arg_3_0._cancelBlock, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, arg_3_0._cancelBlock, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSkillOpen, arg_3_0._onSkillKeyClick, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSkillIndex, arg_3_0._onSkillSelect, arg_3_0)
end

function var_0_0._onClick(arg_4_0)
	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if not FightDataHelper.stageMgr:isEmptyOperateState() then
		return
	end

	if arg_4_0._state == var_0_1.Simple then
		arg_4_0._animator:Play("fight_heroskill_tips", 0, 0)
		arg_4_0._animator:Update(0)

		arg_4_0._state = var_0_1.Expanding

		TaskDispatcher.runDelay(arg_4_0._setState, arg_4_0, 0.533)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_shuffle_unfold)
		FightController.instance:dispatchEvent(FightEvent.OnClothSkillExpand)
		arg_4_0._pcSkillGO:SetActive(false)
		arg_4_0._pcSkillDetail:SetActive(true)

		if PCInputController.instance:getIsUse() then
			TaskDispatcher.runRepeat(arg_4_0._checkAnyKey, arg_4_0, 0.01)
		end
	end
end

function var_0_0.checkSkillKey(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(BattleActivityAdapter.skillSelectKey) do
		if PCInputController.instance:getActivityFunPress(PCInputModel.Activity.battle, iter_5_1) then
			return true
		end
	end

	return false
end

function var_0_0._checkAnyKey(arg_6_0)
	if UnityEngine.Input.anyKeyDown and not UnityEngine.Input.GetMouseButton(0) and not arg_6_0:checkSkillKey() and arg_6_0._state == var_0_1.Detail then
		logNormal("FightViewClothSkill:_checkAnyKey()" .. tostring(UnityEngine.Input.anyKeyDown))
		TaskDispatcher.cancelTask(arg_6_0._checkAnyKey, arg_6_0)

		arg_6_0._hasClickDetailIcon = nil

		arg_6_0:_onSkillKeyClick()
	end
end

function var_0_0._onSkillKeyClick(arg_7_0)
	if not FightReplayModel.instance:isReplay() then
		if arg_7_0._state == var_0_1.Detail then
			arg_7_0:_onTouch()
		elseif arg_7_0._state == var_0_1.Simple then
			arg_7_0:_onClick()
		end
	end
end

function var_0_0._onSkillSelect(arg_8_0, arg_8_1)
	if not FightReplayModel.instance:isReplay() then
		local var_8_0 = arg_8_0._detailClick[arg_8_1]

		if var_8_0 and var_8_0.gameObject.activeInHierarchy then
			arg_8_0:_onClickSkillIcon(arg_8_1)
		end
	end
end

function var_0_0._setState(arg_9_0)
	if arg_9_0._state == var_0_1.Expanding then
		arg_9_0._state = var_0_1.Detail
	elseif arg_9_0._state == var_0_1.Shrinking then
		arg_9_0._state = var_0_1.Simple
	end
end

function var_0_0._onTouch(arg_10_0)
	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		local var_10_0 = GuideViewMgr.instance.viewParam
		local var_10_1 = var_10_0 and var_10_0.goPath
		local var_10_2 = gohelper.find(var_10_1)

		if var_10_2 then
			for iter_10_0, iter_10_1 in ipairs(arg_10_0._detailClick) do
				if iter_10_1.gameObject == var_10_2 then
					arg_10_0._hasClickDetailIcon = nil

					return
				end
			end
		end
	end

	if arg_10_0._state == var_0_1.Detail then
		local var_10_3 = Time.timeScale

		TaskDispatcher.runDelay(arg_10_0._delayDealTouch, arg_10_0, 0.01)
	end
end

function var_0_0._delayDealTouch(arg_11_0)
	if not arg_11_0._hasClickDetailIcon then
		arg_11_0:_shrinkDetailUI()
	end

	arg_11_0._hasClickDetailIcon = nil
end

function var_0_0.showKeyTips(arg_12_0)
	PCInputController.instance:showkeyTips(arg_12_0._pcSkillGO, PCInputModel.Activity.battle, PCInputModel.battleActivityFun.showSkill)
	PCInputController.instance:showkeyTips(arg_12_0._pcSkillDetail, PCInputModel.Activity.battle, PCInputModel.battleActivityFun.showSkill)
	PCInputController.instance:showkeyTips(arg_12_0._pcSkill1, PCInputModel.Activity.battle, PCInputModel.battleActivityFun.skillUp)
	PCInputController.instance:showkeyTips(arg_12_0._pcSkill2, PCInputModel.Activity.battle, PCInputModel.battleActivityFun.skillDown)
end

function var_0_0._shrinkDetailUI(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._checkAnyKey, arg_13_0)
	arg_13_0._animator:Play("fight_heroskill_out", 0, 0)
	arg_13_0._animator:Update(0)

	arg_13_0._state = var_0_1.Shrinking

	TaskDispatcher.runDelay(arg_13_0._setState, arg_13_0, 0.533)
	FightController.instance:dispatchEvent(FightEvent.OnClothSkillShrink)
	arg_13_0._pcSkillGO:SetActive(true)
	arg_13_0._pcSkillDetail:SetActive(false)
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:_updateUI()
	arg_14_0:_checkStartReplay()
end

function var_0_0._onUpdateSpeed(arg_15_0)
	arg_15_0._animator.speed = FightModel.instance:getUISpeed()
end

function var_0_0._checkStartReplay(arg_16_0)
	if FightReplayModel.instance:isReplay() then
		arg_16_0._click:RemoveClickListener()

		for iter_16_0, iter_16_1 in ipairs(arg_16_0._detailClick) do
			iter_16_1:RemoveClickListener()
		end

		arg_16_0:removeEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_16_0._onTouch, arg_16_0)
	end
end

function var_0_0._getClothLevelCO(arg_17_0)
	local var_17_0 = FightModel.instance.clothId

	if not var_17_0 then
		return
	end

	local var_17_1 = PlayerClothModel.instance:getById(var_17_0)

	if not var_17_1 then
		return
	end

	local var_17_2 = lua_cloth_level.configDict[var_17_0]

	if not var_17_2 then
		return
	end

	return var_17_2[var_17_1.level]
end

function var_0_0._onPlayHandCard(arg_18_0, arg_18_1)
	if not arg_18_1.playCanAddExpoint then
		return
	end

	local var_18_0 = arg_18_0:_getClothLevelCO()

	if var_18_0 then
		arg_18_0._cardOpAddPower = arg_18_0._cardOpAddPower + var_18_0.use

		arg_18_0:_updateUI()
		arg_18_0:_checkPlayPowerMaxAudio(arg_18_0._cardOpAddPower)
	end
end

function var_0_0._onMoveHandCard(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_1.moveCanAddExpoint then
		return
	end

	if FightEnum.UniversalCard[arg_19_2.skillId] then
		return
	end

	local var_19_0 = arg_19_0:_getClothLevelCO()

	if var_19_0 then
		arg_19_0._cardOpAddPower = arg_19_0._cardOpAddPower + var_19_0.move

		arg_19_0:_updateUI()
		arg_19_0:_checkPlayPowerMaxAudio(arg_19_0._cardOpAddPower)
	end
end

function var_0_0._onCombineOneCard(arg_20_0, arg_20_1, arg_20_2)
	if not arg_20_1.combineCanAddExpoint then
		return
	end

	if arg_20_2 then
		return
	end

	local var_20_0 = arg_20_0:_getClothLevelCO()

	if var_20_0 then
		arg_20_0._cardOpAddPower = arg_20_0._cardOpAddPower + var_20_0.compose

		arg_20_0:_updateUI()
		arg_20_0:_checkPlayPowerMaxAudio(arg_20_0._cardOpAddPower)
	end
end

function var_0_0._onMasterPowerChange(arg_21_0)
	if arg_21_0:_getClothLevelCO() then
		arg_21_0:_updateUI()
		arg_21_0:_checkPlayPowerMaxAudio(arg_21_0._cardOpAddPower)
	end
end

function var_0_0._onStartPlayClothSkill(arg_22_0)
	arg_22_0._lockSimulation = true
	arg_22_0._cardOpAddPower = 0

	arg_22_0:_updateUI()
	arg_22_0:_checkPlayPowerMaxAudio()
	arg_22_0:_shrinkDetailUI()
end

function var_0_0._onAfterPlayClothSkill(arg_23_0)
	arg_23_0._lockSimulation = false
	arg_23_0._cardOpAddPower = 0
end

function var_0_0._onCancelOperation(arg_24_0)
	arg_24_0._cardOpAddPower = 0

	arg_24_0:_updateUI()
	arg_24_0:_checkPlayPowerMaxAudio()
end

function var_0_0._onRoundSequenceFinish(arg_25_0)
	arg_25_0._cardOpAddPower = 0

	arg_25_0:_updateUI()
	arg_25_0:_checkPlayPowerMaxAudio()
end

function var_0_0._getClothSkillList(arg_26_0)
	local var_26_0 = tabletool.copy(FightModel.instance:getClothSkillList() or {})

	for iter_26_0 = #var_26_0, 1, -1 do
		if var_26_0[iter_26_0].type ~= FightEnum.ClothSkillPerformanceType.Normal then
			table.remove(var_26_0, iter_26_0)
		end
	end

	return var_26_0
end

function var_0_0._canUseAnySkill(arg_27_0)
	local var_27_0 = FightModel.instance.power
	local var_27_1 = arg_27_0:_getClothSkillList()

	for iter_27_0 = 1, 2 do
		local var_27_2 = var_27_1 and var_27_1[iter_27_0]

		if var_27_2 and lua_skill.configDict[var_27_2.skillId] and var_27_2.cd <= 0 and var_27_0 >= var_27_2.needPower then
			return true
		end
	end
end

function var_0_0._updateUI(arg_28_0)
	local var_28_0 = arg_28_0:_getClothSkillList()
	local var_28_1 = FightModel.instance.power
	local var_28_2 = {
		arg_28_0._pcSkill1,
		arg_28_0._pcSkill2
	}

	for iter_28_0 = 1, 2 do
		local var_28_3 = var_28_0 and var_28_0[iter_28_0]

		if var_28_3 then
			local var_28_4 = lua_skill.configDict[var_28_3.skillId]

			if var_28_4 then
				local var_28_5 = var_28_3.cd <= 0 and var_28_1 >= var_28_3.needPower

				gohelper.setActive(arg_28_0._simpleNotCost[iter_28_0], not var_28_5)
				gohelper.setActive(arg_28_0._simpleCanCost[iter_28_0], var_28_5)
				gohelper.setActive(arg_28_0._detailNotCost[iter_28_0], not var_28_5)
				gohelper.setActive(arg_28_0._detailCanCost[iter_28_0], var_28_5)
				gohelper.setActive(var_28_2[iter_28_0], var_28_5)

				local var_28_6 = FightConfig.instance:getSkillEffectDesc(nil, var_28_4)

				arg_28_0._detailTxtDesc[iter_28_0].text = var_28_6 .. "\nCOST<color=#FFA500>-" .. var_28_3.needPower .. "</color>"
			else
				logError("主角技能配置不存在，技能id = " .. var_28_3.skillId)
			end
		end
	end

	local var_28_7 = arg_28_0:_getClothLevelCO()

	if var_28_7 then
		local var_28_8 = var_28_1

		if not arg_28_0._lockSimulation then
			var_28_8 = var_28_8 + arg_28_0._cardOpAddPower
		end

		local var_28_9 = var_28_7.maxPower
		local var_28_10 = Mathf.Clamp(var_28_8, 0, var_28_9)

		if not tonumber(arg_28_0._txtNum.text) then
			local var_28_11 = 0
		end

		arg_28_0._txtNum.text = var_28_10
		arg_28_0._txtNum1.text = var_28_10
		arg_28_0._txtmax.text = var_28_9

		gohelper.setActive(arg_28_0._maxGO, var_28_10 > 0 and var_28_10 == var_28_9)
	else
		arg_28_0._txtNum.text = var_28_1
		arg_28_0._txtNum1.text = var_28_1
		arg_28_0._txtmax.text = ""

		gohelper.setActive(arg_28_0._maxGO, false)
	end
end

function var_0_0._onStartSequenceFinish(arg_29_0)
	local var_29_0 = arg_29_0:_getClothLevelCO()

	if var_29_0 then
		local var_29_1 = FightModel.instance.power

		if not arg_29_0._lockSimulation then
			var_29_1 = var_29_1 + arg_29_0._cardOpAddPower
		end

		local var_29_2 = var_29_0.maxPower
		local var_29_3 = Mathf.Clamp(var_29_1, 0, var_29_2)

		arg_29_0._cardOpAddPower = 0
		FightModel.instance.power = var_29_3

		arg_29_0:_updateUI()
	end
end

function var_0_0._checkPlayPowerMaxAudio(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0._prevPower or 0
	local var_30_1 = arg_30_0:_getClothLevelCO()
	local var_30_2 = FightModel.instance.power + (arg_30_1 or 0)
	local var_30_3 = var_30_1 and var_30_1.maxPower or 0
	local var_30_4 = Mathf.Clamp(var_30_2, 0, var_30_3)

	if var_30_0 < var_30_3 and var_30_4 > 0 and var_30_4 == var_30_3 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_clothskill_power_max)
	end

	arg_30_0._prevPower = var_30_4
end

function var_0_0._onClickSkillIcon(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0._clothSkillOp

	arg_31_0._clothSkillOp = nil
	arg_31_0._hasClickDetailIcon = true

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightViewHandCard.blockOperate or FightModel.instance:isAuto() then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if #FightDataHelper.operationDataMgr:getOpList() > 0 then
		GameFacade.showToast(ToastEnum.FightCardOps)

		return
	end

	local var_31_1 = arg_31_0:_getClothSkillList()
	local var_31_2 = FightModel.instance.power
	local var_31_3 = var_31_1 and var_31_1[arg_31_1]

	arg_31_0._toUseSkillId = var_31_3 and var_31_3.skillId

	if var_31_3.cd > 0 then
		GameFacade.showToast(ToastEnum.UseSkill2)

		return
	end

	if not arg_31_0._toUseSkillId or var_31_2 < var_31_3.needPower then
		GameFacade.showToast(ToastEnum.UseSkill1)

		return
	end

	local var_31_4 = lua_skill.configDict[arg_31_0._toUseSkillId]
	local var_31_5 = arg_31_0:_checkSelectSkillTarget()

	if var_31_5 and var_31_5 == var_0_2 then
		if var_31_0 then
			arg_31_0._fromId = var_31_0.fromId
			arg_31_0._toId = var_31_0.toId

			arg_31_0:_sendChangeSubRequest()
		else
			arg_31_0:_selectChangeSub()
		end
	elseif var_31_4 and FightEnum.ShowLogicTargetView[var_31_4.logicTarget] and var_31_4.targetLimit == FightEnum.TargetLimit.MySide then
		if var_31_0 then
			arg_31_0:_selectCallback(var_31_0.toId)
		else
			ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
				skillId = arg_31_0._toUseSkillId,
				callback = arg_31_0._selectCallback,
				callbackObj = arg_31_0
			})
		end
	else
		arg_31_0:_sendUseClothSkill()
	end
end

function var_0_0._selectCallback(arg_32_0, arg_32_1)
	arg_32_0._fromId = nil
	arg_32_0._toId = arg_32_1

	arg_32_0:_useSkillAfterSelect()
end

function var_0_0._useSkillAfterSelect(arg_33_0)
	if arg_33_0._dnaAnim then
		arg_33_0._dnaAnim:Play("fight_heroskill_icon_click", 0, 0)
		arg_33_0._dnaAnim:Update(0)
	end

	TaskDispatcher.runDelay(arg_33_0._useSkillAfterPerformance, arg_33_0, 0.33)
	arg_33_0:_blockClick()
end

function var_0_0._useSkillAfterPerformance(arg_34_0)
	FightRpc.instance:sendUseClothSkillRequest(arg_34_0._toUseSkillId, arg_34_0._fromId, arg_34_0._toId)
end

function var_0_0._checkSelectSkillTarget(arg_35_0)
	local var_35_0 = lua_skill.configDict[arg_35_0._toUseSkillId]
	local var_35_1 = lua_skill_effect.configDict[var_35_0.skillEffect]

	if var_35_1 then
		for iter_35_0 = 1, FightEnum.MaxBehavior do
			local var_35_2 = tonumber(var_35_1["behavior" .. iter_35_0])

			if var_35_2 and var_0_3[var_35_2] then
				return var_35_2
			end
		end
	end
end

function var_0_0._selectChangeSub(arg_36_0)
	local var_36_0 = FightDataHelper.entityMgr:getMyNormalList()
	local var_36_1 = FightDataHelper.entityMgr:getMySubList()
	local var_36_2 = {}
	local var_36_3 = {}

	for iter_36_0, iter_36_1 in ipairs(var_36_0) do
		table.insert(var_36_2, iter_36_1.id)
	end

	for iter_36_2, iter_36_3 in ipairs(var_36_1) do
		table.insert(var_36_3, iter_36_3.id)
	end

	if #var_36_3 == 0 then
		GameFacade.showToast(ToastEnum.ChangeSubIsNull)

		return
	end

	arg_36_0:_changeSubSelect1(var_36_2, var_36_3)
end

function var_0_0._changeSubSelect1(arg_37_0, arg_37_1, arg_37_2)
	if #arg_37_1 <= 1 then
		arg_37_0._fromId = arg_37_1[1]

		arg_37_0:_changeSubSelect2(arg_37_2)
	else
		ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
			callback = function(arg_38_0)
				arg_37_0._fromId = arg_38_0

				arg_37_0:_changeSubSelect2(arg_37_2)
			end,
			targetLimit = arg_37_1,
			desc = luaLang("fight_select_change")
		})
	end
end

function var_0_0._changeSubSelect2(arg_39_0, arg_39_1)
	if #arg_39_1 == 1 then
		arg_39_0._toId = arg_39_1[1]

		arg_39_0:_sendChangeSubEntity()
	else
		ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
			callback = function(arg_40_0)
				arg_39_0._toId = arg_40_0

				arg_39_0:_sendChangeSubEntity()
			end,
			targetLimit = arg_39_1,
			desc = luaLang("fight_select_change_sub")
		})
	end
end

function var_0_0._sendUseClothSkill(arg_41_0)
	if arg_41_0._dnaAnim then
		arg_41_0._dnaAnim:Play("fight_heroskill_icon_click", 0, 0)
		arg_41_0._dnaAnim:Update(0)
	end

	TaskDispatcher.runDelay(arg_41_0._sendUseClothSkillRequest, arg_41_0, 0.33)
	arg_41_0:_blockClick()
end

function var_0_0._sendUseClothSkillRequest(arg_42_0)
	FightRpc.instance:sendUseClothSkillRequest(arg_42_0._toUseSkillId, nil, FightDataHelper.operationDataMgr.curSelectEntityId)
end

function var_0_0._sendChangeSubEntity(arg_43_0)
	if arg_43_0._dnaAnim then
		arg_43_0._dnaAnim:Play("fight_heroskill_icon_click", 0, 0)
		arg_43_0._dnaAnim:Update(0)
	end

	TaskDispatcher.runDelay(arg_43_0._sendChangeSubRequest, arg_43_0, 0.33)
	arg_43_0:_blockClick()
end

function var_0_0._sendChangeSubRequest(arg_44_0)
	FightRpc.instance:sendUseClothSkillRequest(arg_44_0._toUseSkillId, arg_44_0._fromId, arg_44_0._toId)
end

function var_0_0._blockClick(arg_45_0)
	UIBlockMgr.instance:endAll()

	UIBlockMgrExtend.CircleMvDelay = 10

	UIBlockMgr.instance:startBlock(UIBlockKey.PlayClothSkill)
	arg_45_0:addEventCb(FightController.instance, FightEvent.RespUseClothSkillFail, arg_45_0._cancelBlock, arg_45_0)
	arg_45_0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, arg_45_0._cancelBlock, arg_45_0)
end

function var_0_0._cancelBlock(arg_46_0)
	arg_46_0:removeEventCb(FightController.instance, FightEvent.RespUseClothSkillFail, arg_46_0._cancelBlock, arg_46_0)
	arg_46_0:removeEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, arg_46_0._cancelBlock, arg_46_0)

	UIBlockMgrExtend.CircleMvDelay = nil

	UIBlockMgr.instance:endBlock(UIBlockKey.PlayClothSkill)
end

function var_0_0._simulateClickClothSkillIcon(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_1 and arg_47_1.skillId

	if var_47_0 then
		local var_47_1 = arg_47_0:_getClothSkillList()

		for iter_47_0, iter_47_1 in ipairs(var_47_1) do
			if iter_47_1.skillId == var_47_0 then
				arg_47_0._clothSkillOp = arg_47_1

				arg_47_0:_onClickSkillIcon(iter_47_0)

				return
			end
		end

		logError("主角技能不存在：" .. var_47_0 .. ", " .. cjson.encode(var_47_1))
	end
end

return var_0_0
