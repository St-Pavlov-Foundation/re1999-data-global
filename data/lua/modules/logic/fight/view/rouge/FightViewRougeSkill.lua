module("modules.logic.fight.view.rouge.FightViewRougeSkill", package.seeall)

local var_0_0 = class("FightViewRougeSkill", BaseViewExtended)
local var_0_1 = {
	Expanding = 3,
	Simple = 1,
	Shrinking = 4,
	Detail = 2
}

var_0_0.SkillSimpleItemWidth = 72
var_0_0.BaseWidth = 156

function var_0_0.onInitView(arg_1_0)
	arg_1_0._rougeStyleIcon = gohelper.findChildImage(arg_1_0.viewGO, "heroSkill/#go_simple/faction/#image_faction")
	arg_1_0._rougeStyleIconDetail = gohelper.findChildImage(arg_1_0.viewGO, "heroSkill/#go_detail/faction/#image_faction")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "heroSkill/#go_simple/skillicon/#txt_simpleCurCount")
	arg_1_0._txtNum1 = gohelper.findChildText(arg_1_0.viewGO, "heroSkill/#go_detail/#txt_detailCurCount")
	arg_1_0._txtmax = gohelper.findChildText(arg_1_0.viewGO, "heroSkill/#go_simple/skillicon/max/txtmax")
	arg_1_0._heroSkillGO = gohelper.findChild(arg_1_0.viewGO, "heroSkill")
	arg_1_0._state = var_0_1.Simple

	local var_1_0 = gohelper.findChild(arg_1_0._heroSkillGO, "#go_simple")

	arg_1_0._click = gohelper.getClick(var_1_0)
	arg_1_0._animator = arg_1_0._heroSkillGO:GetComponent(typeof(UnityEngine.Animator))

	arg_1_0:_onUpdateSpeed()

	arg_1_0._detailClick = {}

	table.insert(arg_1_0._detailClick, gohelper.getClick(gohelper.findChild(arg_1_0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem1")))
	table.insert(arg_1_0._detailClick, gohelper.getClick(gohelper.findChild(arg_1_0._heroSkillGO, "#go_detail/skillDescContent/#go_skillDescItem2")))

	arg_1_0._maxGO = gohelper.findChild(arg_1_0.viewGO, "heroSkill/#go_simple/skillicon/max")
	arg_1_0.rectTrSimpleBg = gohelper.findChildComponent(arg_1_0.viewGO, "heroSkill/#go_simple/bg", gohelper.Type_RectTransform)
	arg_1_0.goSimpleItem = gohelper.findChild(arg_1_0.viewGO, "heroSkill/#go_simple/skillContent/skillitem")
	arg_1_0.goDetailItem = gohelper.findChild(arg_1_0.viewGO, "heroSkill/#go_detail/skillDescContent/detailitem")

	gohelper.setActive(arg_1_0.goSimpleItem, false)
	gohelper.setActive(arg_1_0.goDetailItem, false)

	arg_1_0.skillItemList = {}
end

function var_0_0.addEvents(arg_2_0)
	if not FightDataHelper.stateMgr.isReplay then
		arg_2_0._click:AddClickListener(arg_2_0._onClick, arg_2_0)
		arg_2_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, arg_2_0._onTouch, arg_2_0)
	end

	arg_2_0:addEventCb(FightController.instance, FightEvent.StartPlayClothSkill, arg_2_0._onStartPlayClothSkill, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_2_0._onStartSequenceFinish, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_2_0._onRoundSequenceFinish, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, arg_2_0._onClothSkillRoundSequenceFinish, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.SimulateClickClothSkillIcon, arg_2_0._simulateClickClothSkillIcon, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.StartReplay, arg_2_0._checkStartReplay, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnUpdateSpeed, arg_2_0._onUpdateSpeed, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.RougeCoinChange, arg_2_0._onRougeCoinChange, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.RougeMagicChange, arg_2_0._onRougeMagicChange, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.RougeMagicLimitChange, arg_2_0._onRougeMagicLimitChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._delayDealTouch, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._sendUseClothSkillRequest, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._setState, arg_3_0)
	arg_3_0._click:RemoveClickListener()

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.skillItemList) do
		iter_3_1.detailItem.click:RemoveClickListener()
	end
end

function var_0_0.getSkillItem(arg_4_0, arg_4_1)
	if arg_4_1 <= #arg_4_0.skillItemList then
		return arg_4_0.skillItemList[arg_4_1]
	end

	return arg_4_0:createSkillItem(arg_4_1)
end

function var_0_0.createSkillItem(arg_5_0, arg_5_1)
	local var_5_0 = {
		simpleItem = arg_5_0:createSimpleItem(),
		detailItem = arg_5_0:createDetailItem(arg_5_1)
	}

	table.insert(arg_5_0.skillItemList, var_5_0)

	return var_5_0
end

function var_0_0.createSimpleItem(arg_6_0)
	local var_6_0 = arg_6_0:getUserDataTb_()

	var_6_0.go = gohelper.cloneInPlace(arg_6_0.goSimpleItem)
	var_6_0.imageNotCost = gohelper.findChildImage(var_6_0.go, "notcost")
	var_6_0.imageCanCost = gohelper.findChildImage(var_6_0.go, "cancost")
	var_6_0.goNotCost = var_6_0.imageNotCost.gameObject
	var_6_0.goCanCost = var_6_0.imageCanCost.gameObject

	gohelper.setActive(var_6_0.go, true)

	return var_6_0
end

function var_0_0.createDetailItem(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getUserDataTb_()

	var_7_0.go = gohelper.cloneInPlace(arg_7_0.goDetailItem)
	var_7_0.txtDesc = gohelper.findChildText(var_7_0.go, "desc")
	var_7_0.imageNotCost = gohelper.findChildImage(var_7_0.go, "skill/notcost")
	var_7_0.imageCanCost = gohelper.findChildImage(var_7_0.go, "skill/cancost")
	var_7_0.goNotCost = var_7_0.imageNotCost.gameObject
	var_7_0.goCanCost = var_7_0.imageCanCost.gameObject
	var_7_0.click = gohelper.getClickWithDefaultAudio(var_7_0.go)

	gohelper.setActive(var_7_0.go, true)
	var_7_0.click:AddClickListener(arg_7_0._onClickSkillIcon, arg_7_0, arg_7_1)

	return var_7_0
end

function var_0_0._onStartSequenceFinish(arg_8_0)
	arg_8_0:_updateUI()
	arg_8_0:_checkPlayPowerMaxAudio()
	arg_8_0:_shrinkDetailUI()
end

function var_0_0._onRougeCoinChange(arg_9_0)
	arg_9_0:_updateUI()
end

function var_0_0._onRougeMagicChange(arg_10_0)
	arg_10_0:_updateUI()
end

function var_0_0._onRougeMagicLimitChange(arg_11_0)
	arg_11_0:_updateUI()
end

function var_0_0._onClick(arg_12_0)
	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if arg_12_0._state == var_0_1.Simple then
		arg_12_0._animator:Play("fight_heroskill_tips", 0, 0)
		arg_12_0._animator:Update(0)

		arg_12_0._state = var_0_1.Expanding

		TaskDispatcher.runDelay(arg_12_0._setState, arg_12_0, 0.533)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_shuffle_unfold)
		FightController.instance:dispatchEvent(FightEvent.OnClothSkillExpand)
	end
end

function var_0_0._setState(arg_13_0)
	if arg_13_0._state == var_0_1.Expanding then
		arg_13_0._state = var_0_1.Detail
	elseif arg_13_0._state == var_0_1.Shrinking then
		arg_13_0._state = var_0_1.Simple
	end
end

function var_0_0._onTouch(arg_14_0)
	if arg_14_0._state == var_0_1.Detail then
		TaskDispatcher.runDelay(arg_14_0._delayDealTouch, arg_14_0, 0.01)
	end
end

function var_0_0._delayDealTouch(arg_15_0)
	if not arg_15_0._hasClickDetailIcon then
		arg_15_0:_shrinkDetailUI()
	end

	arg_15_0._hasClickDetailIcon = nil
end

function var_0_0._shrinkDetailUI(arg_16_0)
	arg_16_0._animator:Play("fight_heroskill_out", 0, 0)
	arg_16_0._animator:Update(0)

	arg_16_0._state = var_0_1.Shrinking

	TaskDispatcher.runDelay(arg_16_0._setState, arg_16_0, 0.533)
	FightController.instance:dispatchEvent(FightEvent.OnClothSkillShrink)
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0:_updateUI()
	arg_17_0:_checkStartReplay()
end

function var_0_0._onUpdateSpeed(arg_18_0)
	arg_18_0._animator.speed = FightModel.instance:getUISpeed()
end

function var_0_0._checkStartReplay(arg_19_0)
	if FightDataHelper.stateMgr.isReplay then
		arg_19_0._click:RemoveClickListener()

		for iter_19_0, iter_19_1 in ipairs(arg_19_0._detailClick) do
			iter_19_1:RemoveClickListener()
		end

		arg_19_0:removeEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_19_0._onTouch, arg_19_0)
	end
end

function var_0_0._getClothLevelCO(arg_20_0)
	local var_20_0 = RougeModel.instance:getRougeInfo()

	if not var_20_0 then
		return
	end

	local var_20_1 = FightModel.instance.clothId

	if not var_20_1 then
		return
	end

	return lua_rouge_style.configDict[var_20_0.season] and lua_rouge_style.configDict[var_20_0.season][var_20_1]
end

function var_0_0._onStartPlayClothSkill(arg_21_0)
	gohelper.setActive(arg_21_0.viewGO, false)
end

function var_0_0._onRoundSequenceFinish(arg_22_0)
	arg_22_0:_onClothSkillRoundSequenceFinish()
end

function var_0_0._onClothSkillRoundSequenceFinish(arg_23_0)
	gohelper.setActive(arg_23_0.viewGO, true)
	arg_23_0:_updateUI()
	arg_23_0:_checkPlayPowerMaxAudio()
	arg_23_0:_shrinkDetailUI()
end

function var_0_0._canUseAnySkill(arg_24_0)
	local var_24_0 = FightModel.instance:getClothSkillList()

	for iter_24_0 = 1, 2 do
		local var_24_1 = var_24_0 and var_24_0[iter_24_0]

		if var_24_1 then
			return arg_24_0:_canUseSkill(var_24_1)
		end
	end
end

function var_0_0._canUseSkill(arg_25_0, arg_25_1)
	local var_25_0 = lua_rouge_active_skill.configDict[arg_25_1.skillId]

	if var_25_0 then
		local var_25_1 = true

		if arg_25_1.cd > 0 then
			var_25_1 = false
		end

		if arg_25_0:_getMagic() < var_25_0.powerCost then
			var_25_1 = false
		end

		if arg_25_0:_getCoint() < var_25_0.coinCost then
			var_25_1 = false
		end

		return var_25_1
	end
end

function var_0_0._getMagic(arg_26_0)
	return FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.Magic)
end

function var_0_0._getCoint(arg_27_0)
	return FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.Coin)
end

function var_0_0._updateUI(arg_28_0)
	local var_28_0 = FightModel.instance:getClothSkillList()

	if not var_28_0 or #var_28_0 < 1 then
		gohelper.setActive(arg_28_0.viewGO, false)

		return
	end

	gohelper.setActive(arg_28_0.viewGO, true)

	local var_28_1 = lua_rouge_style.configDict[RougeModel.instance:getSeason()]

	var_28_1 = var_28_1 and var_28_1[FightModel.instance.clothId]

	if var_28_1 then
		UISpriteSetMgr.instance:setRouge2Sprite(arg_28_0._rougeStyleIcon, var_28_1.icon .. "_light")
		UISpriteSetMgr.instance:setRouge2Sprite(arg_28_0._rougeStyleIconDetail, var_28_1.icon .. "_light")
	end

	for iter_28_0, iter_28_1 in ipairs(var_28_0) do
		local var_28_2 = lua_rouge_active_skill.configDict[iter_28_1.skillId]

		if var_28_2 then
			local var_28_3 = arg_28_0:getSkillItem(iter_28_0)
			local var_28_4 = var_28_2.icon

			UISpriteSetMgr.instance:setRouge2Sprite(var_28_3.simpleItem.imageNotCost, var_28_4)
			UISpriteSetMgr.instance:setRouge2Sprite(var_28_3.simpleItem.imageCanCost, var_28_4)
			UISpriteSetMgr.instance:setRouge2Sprite(var_28_3.detailItem.imageNotCost, var_28_4)
			UISpriteSetMgr.instance:setRouge2Sprite(var_28_3.detailItem.imageCanCost, var_28_4)

			local var_28_5 = arg_28_0:_canUseSkill(iter_28_1)

			gohelper.setActive(var_28_3.simpleItem.goNotCost, not var_28_5)
			gohelper.setActive(var_28_3.simpleItem.goCanCost, var_28_5)
			gohelper.setActive(var_28_3.detailItem.goNotCost, not var_28_5)
			gohelper.setActive(var_28_3.detailItem.goCanCost, var_28_5)

			local var_28_6 = var_28_2.desc

			var_28_3.detailItem.txtDesc.text = var_28_6 .. "\nCOST<color=#FFA500>-" .. var_28_2.powerCost .. "</color>"
		else
			logError("流派技能配置不存在,技能id = " .. iter_28_1.skillId)
		end
	end

	local var_28_7 = var_0_0.BaseWidth + #var_28_0 * var_0_0.SkillSimpleItemWidth

	recthelper.setWidth(arg_28_0.rectTrSimpleBg, var_28_7)

	local var_28_8 = arg_28_0:_getMagic()
	local var_28_9 = arg_28_0:_getClothLevelCO()

	if var_28_9 then
		local var_28_10 = var_28_9.powerLimit

		arg_28_0._txtNum.text = var_28_8
		arg_28_0._txtNum1.text = var_28_8
		arg_28_0._txtmax.text = var_28_10

		gohelper.setActive(arg_28_0._maxGO, var_28_8 > 0 and var_28_8 == var_28_10)
	else
		arg_28_0._txtNum.text = var_28_8
		arg_28_0._txtNum1.text = var_28_8
		arg_28_0._txtmax.text = ""

		gohelper.setActive(arg_28_0._maxGO, false)
	end
end

function var_0_0._checkPlayPowerMaxAudio(arg_29_0)
	local var_29_0 = arg_29_0._prevPower or 0
	local var_29_1 = arg_29_0:_getClothLevelCO()
	local var_29_2 = arg_29_0:_getMagic()
	local var_29_3 = var_29_1 and var_29_1.powerLimit or 0
	local var_29_4 = Mathf.Clamp(var_29_2, 0, var_29_3)

	if var_29_0 < var_29_3 and var_29_4 > 0 and var_29_4 == var_29_3 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_clothskill_power_max)
	end

	arg_29_0._prevPower = var_29_4
end

function var_0_0._onClickSkillIcon(arg_30_0, arg_30_1, arg_30_2)
	if FightDataHelper.lockOperateMgr:isLock() and not arg_30_2 then
		return
	end

	arg_30_0._hasClickDetailIcon = true

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightViewHandCard.blockOperate or FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() ~= FightStageMgr.StageType.Operate then
		return
	end

	if #FightDataHelper.operationDataMgr:getOpList() > 0 then
		GameFacade.showToast(ToastEnum.RougeSkillNeedCancelOperation)

		return
	end

	local var_30_0 = FightModel.instance:getClothSkillList()
	local var_30_1 = arg_30_0:_getMagic()
	local var_30_2 = var_30_0 and var_30_0[arg_30_1]

	arg_30_0._toUseSkillId = var_30_2 and var_30_2.skillId

	if var_30_2.cd > 0 then
		GameFacade.showToast(ToastEnum.UseSkill2)

		return
	end

	local var_30_3 = lua_rouge_active_skill.configDict[var_30_2.skillId]

	if not arg_30_0._toUseSkillId or var_30_1 < var_30_3.powerCost then
		GameFacade.showToast(ToastEnum.RougeSkillMagicNotEnough)

		return
	end

	local var_30_4 = arg_30_0:_getCoint()

	if not arg_30_0._toUseSkillId or var_30_4 < var_30_3.coinCost then
		GameFacade.showToast(ToastEnum.RougeSkillCoinNotEnough)

		return
	end

	local var_30_5 = lua_skill.configDict[arg_30_0._toUseSkillId]

	if var_30_5 and FightEnum.ShowLogicTargetView[var_30_5.logicTarget] and var_30_5.targetLimit == FightEnum.TargetLimit.MySide then
		ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
			skillId = arg_30_0._toUseSkillId,
			callback = arg_30_0._selectCallback,
			callbackObj = arg_30_0
		})
	else
		arg_30_0._fromId = nil
		arg_30_0._toId = FightDataHelper.operationDataMgr.curSelectEntityId

		arg_30_0:_sendUseClothSkill()
	end
end

function var_0_0._selectCallback(arg_31_0, arg_31_1)
	arg_31_0._state = var_0_1.Simple
	arg_31_0._fromId = nil
	arg_31_0._toId = arg_31_1

	arg_31_0:_sendUseClothSkill()
end

function var_0_0._sendUseClothSkill(arg_32_0)
	TaskDispatcher.runDelay(arg_32_0._sendUseClothSkillRequest, arg_32_0, 0.33)
	arg_32_0:_blockClick()
end

function var_0_0._sendUseClothSkillRequest(arg_33_0)
	FightRpc.instance:sendUseClothSkillRequest(arg_33_0._toUseSkillId, arg_33_0._fromId, arg_33_0._toId, FightEnum.ClothSkillType.Rouge)
end

function var_0_0._blockClick(arg_34_0)
	UIBlockMgr.instance:endAll()

	UIBlockMgrExtend.CircleMvDelay = 10

	UIBlockMgr.instance:startBlock(UIBlockKey.PlayClothSkill)
	arg_34_0:addEventCb(FightController.instance, FightEvent.RespUseClothSkillFail, arg_34_0._cancelBlock, arg_34_0)
	arg_34_0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, arg_34_0._cancelBlock, arg_34_0)
end

function var_0_0._cancelBlock(arg_35_0)
	arg_35_0:removeEventCb(FightController.instance, FightEvent.RespUseClothSkillFail, arg_35_0._cancelBlock, arg_35_0)
	arg_35_0:removeEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, arg_35_0._cancelBlock, arg_35_0)

	UIBlockMgrExtend.CircleMvDelay = nil

	UIBlockMgr.instance:endBlock(UIBlockKey.PlayClothSkill)
end

function var_0_0._simulateClickClothSkillIcon(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_1 and arg_36_1.skillId

	if var_36_0 then
		local var_36_1 = FightModel.instance:getClothSkillList()

		for iter_36_0, iter_36_1 in ipairs(var_36_1) do
			if iter_36_1.skillId == var_36_0 then
				arg_36_0:_onClickSkillIcon(iter_36_0, true)

				return
			end
		end

		logError("主角技能不存在：" .. var_36_0 .. ", " .. cjson.encode(var_36_1))
	end
end

return var_0_0
