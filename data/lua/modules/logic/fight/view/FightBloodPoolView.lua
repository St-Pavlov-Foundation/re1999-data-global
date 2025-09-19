module("modules.logic.fight.view.FightBloodPoolView", package.seeall)

local var_0_0 = class("FightBloodPoolView", FightBaseView)

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.teamType = arg_1_1
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0.root = gohelper.findChild(arg_2_0.viewGO, "root")
	arg_2_0.goPreTxt = gohelper.findChild(arg_2_0.viewGO, "root/num/bottom/txt_preparation")
	arg_2_0.bottomNumTxt = gohelper.findChildText(arg_2_0.viewGO, "root/num/bottom/#txt_num")
	arg_2_0.bottomPreNumTxt = gohelper.findChildText(arg_2_0.viewGO, "root/num/bottom/txt_preparation/#txt_preparation")
	arg_2_0.bottomNumAnimator = gohelper.findChildComponent(arg_2_0.viewGO, "root/num/bottom", gohelper.Type_Animator)
	arg_2_0.goLeft = gohelper.findChild(arg_2_0.viewGO, "root/num/left")
	arg_2_0.leftMaxTxt = gohelper.findChildText(arg_2_0.viewGO, "root/num/left/#txt_num1")
	arg_2_0.leftCurTxt = gohelper.findChildText(arg_2_0.viewGO, "root/num/left/#txt_num1/#txt_num2")
	arg_2_0.leftEffMaxTxt = gohelper.findChildText(arg_2_0.viewGO, "root/num/left/#txt_num1eff")
	arg_2_0.leftEffCurTxt = gohelper.findChildText(arg_2_0.viewGO, "root/num/left/#txt_num1eff/#txt_num2")
	arg_2_0.heartAnimator = gohelper.findChildComponent(arg_2_0.viewGO, "root/heart", gohelper.Type_Animator)
	arg_2_0.imageHeart = gohelper.findChildImage(arg_2_0.viewGO, "root/heart/unbroken/#image_heart")
	arg_2_0.imageHeartPre = gohelper.findChildImage(arg_2_0.viewGO, "root/heart/unbroken/#image_heart_broken")
	arg_2_0.imageHeartMat = arg_2_0.imageHeart.material
	arg_2_0.imageHeartPreMat = arg_2_0.imageHeartPre.material
	arg_2_0.heightPropertyId = UnityEngine.Shader.PropertyToID("_LerpOffset")

	local var_2_0 = gohelper.findChild(arg_2_0.viewGO, "root/#btn_click")

	arg_2_0.longPress = SLFramework.UGUI.UILongPressListener.Get(var_2_0)

	arg_2_0.longPress:SetLongPressTime({
		0.5,
		99999
	})

	arg_2_0.preCostBloodValue = 0
	arg_2_0.bloodPoolSkillId = FightHelper.getBloodPoolSkillId()

	gohelper.setActive(arg_2_0.goPreTxt, false)
end

var_0_0.HeartTweenDuration = 0.5

function var_0_0.addEvents(arg_3_0)
	arg_3_0:com_registFightEvent(FightEvent.BloodPool_MaxValueChange, arg_3_0.onMaxValueChange)
	arg_3_0:com_registFightEvent(FightEvent.BloodPool_ValueChange, arg_3_0.onValueChange)
	arg_3_0:com_registFightEvent(FightEvent.BloodPool_OnPlayCard, arg_3_0.onPlayBloodCard)
	arg_3_0:com_registFightEvent(FightEvent.BloodPool_OnCancelPlayCard, arg_3_0.onCancelPlayBloodCard)
	arg_3_0:com_registFightEvent(FightEvent.RespBeginRound, arg_3_0.onRespBeginRound)
	arg_3_0:com_registFightEvent(FightEvent.BeforePlayHandCard, arg_3_0.onPlayHandCard)
	arg_3_0.longPress:AddClickListener(arg_3_0.onClickBlood, arg_3_0)
	arg_3_0.longPress:AddLongPressListener(arg_3_0.onLongPressBlood, arg_3_0)
end

function var_0_0.onPlayHandCard(arg_4_0, arg_4_1)
	local var_4_0 = FightDataHelper.handCardMgr.handCard
	local var_4_1 = var_4_0 and var_4_0[arg_4_1]

	if not var_4_1 then
		return
	end

	arg_4_0:calculateSkillPreCostBloodValue(var_4_1.skillId)
	arg_4_0:refreshPreCostBloodValue()
end

var_0_0.BloodValueChangeBehaviorId = 60191

function var_0_0.calculateSkillPreCostBloodValue(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1 and lua_skill.configDict[arg_5_1]

	if not var_5_0 then
		return
	end

	local var_5_1 = lua_skill_effect.configDict[var_5_0.skillEffect]

	if not var_5_1 then
		return
	end

	for iter_5_0 = 1, FightEnum.MaxBehavior do
		local var_5_2 = var_5_1["behavior" .. iter_5_0]

		if not string.nilorempty(var_5_2) then
			local var_5_3 = FightStrUtil.instance:getSplitString2Cache(var_5_2, true)

			for iter_5_1, iter_5_2 in ipairs(var_5_3) do
				if iter_5_2[1] == var_0_0.BloodValueChangeBehaviorId then
					arg_5_0.preCostBloodValue = arg_5_0.preCostBloodValue + iter_5_2[2]
				end
			end
		end
	end
end

function var_0_0.refreshPreCostBloodValue(arg_6_0)
	local var_6_0 = FightDataHelper.getBloodPool(arg_6_0.teamType)
	local var_6_1 = var_6_0.max
	local var_6_2 = var_6_0.value + arg_6_0.preCostBloodValue
	local var_6_3 = math.max(math.min(var_6_1, var_6_2), 0)
	local var_6_4 = string.format("%s/%s", var_6_3, var_6_1)

	arg_6_0.bottomNumTxt.text = var_6_4
	arg_6_0.bottomPreNumTxt.text = var_6_4
	arg_6_0.leftCurTxt.text = var_6_3
	arg_6_0.leftEffCurTxt.text = var_6_3

	arg_6_0.imageHeartPreMat:SetFloat(arg_6_0.heightPropertyId, var_6_3 / var_6_1)
	arg_6_0:refreshPreTxtActive()
end

function var_0_0.refreshPreTxtActive(arg_7_0)
	gohelper.setActive(arg_7_0.goPreTxt, arg_7_0.preCostBloodValue ~= 0)
end

function var_0_0.onPlayBloodCard(arg_8_0)
	arg_8_0.heartAnimator:Play("click", 0, 0)
	arg_8_0:calculateSkillPreCostBloodValue(arg_8_0.bloodPoolSkillId)
	arg_8_0:refreshPreCostBloodValue()
end

function var_0_0.onCancelPlayBloodCard(arg_9_0)
	arg_9_0.heartAnimator:Play("idle", 0, 0)

	arg_9_0.preCostBloodValue = 0

	arg_9_0:directSetBloodValue()
end

function var_0_0.onRespBeginRound(arg_10_0)
	FightDataHelper.bloodPoolDataMgr:onCancelOperation()
end

function var_0_0.onClickBlood(arg_11_0)
	if FightModel.instance:getCurStage() == FightEnum.Stage.AutoCard then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightViewHandCard.blockOperate then
		return
	end

	local var_11_0 = FightDataHelper.getBloodPool(arg_11_0.teamType)

	if not var_11_0 then
		return
	end

	if var_11_0.value < 1 then
		GameFacade.showToast(ToastEnum.NotEnoughBlood)

		return
	end

	if FightDataHelper.bloodPoolDataMgr:checkPlayedCard() then
		return
	end

	local var_11_1 = FightDataHelper.operationDataMgr:newOperation()

	var_11_1:playBloodPoolCard(arg_11_0.bloodPoolSkillId)
	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, var_11_1)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, var_11_1)
	FightController.instance:dispatchEvent(FightEvent.OnPlayAssistBossCardFlowDone, var_11_1)
	FightDataHelper.bloodPoolDataMgr:playBloodPoolCard()
	AudioMgr.instance:trigger(20270004)
end

function var_0_0.onLongPressBlood(arg_12_0)
	if FightModel.instance:getCurStage() == FightEnum.Stage.AutoCard then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightViewHandCard.blockOperate then
		return
	end

	if not FightDataHelper.getBloodPool(arg_12_0.teamType) then
		return
	end

	ViewMgr.instance:openView(ViewName.FightBloodPoolTipView)
end

function var_0_0.onMaxValueChange(arg_13_0, arg_13_1)
	if arg_13_1 ~= arg_13_0.teamType then
		return
	end

	arg_13_0:refreshTxt()
end

function var_0_0.onValueChange(arg_14_0, arg_14_1)
	if arg_14_1 ~= arg_14_0.teamType then
		return
	end

	arg_14_0:refreshTxt()
end

function var_0_0.onOpen(arg_15_0)
	AudioMgr.instance:trigger(20270005)
	arg_15_0:refreshTxt()
	arg_15_0:showBengFaView()
end

function var_0_0.recordPreValue(arg_16_0)
	local var_16_0 = FightDataHelper.getBloodPool(arg_16_0.teamType)
	local var_16_1 = var_16_0.value

	arg_16_0.preMaxValue, arg_16_0.preValue = var_16_0.max, var_16_1
end

function var_0_0.refreshTxt(arg_17_0)
	if not arg_17_0.inited then
		arg_17_0:directSetBloodValue()
		arg_17_0:recordPreValue()
		arg_17_0.heartAnimator:Play("add", 0, 0)

		arg_17_0.inited = true

		return
	end

	arg_17_0:cleanHeartImageTween()

	local var_17_0 = FightDataHelper.getBloodPool(arg_17_0.teamType)
	local var_17_1 = var_17_0.value
	local var_17_2 = var_17_0.max

	arg_17_0.valueChangeLen = var_17_1 - arg_17_0.preValue
	arg_17_0.maxValueChangeLen = var_17_2 - arg_17_0.preMaxValue
	arg_17_0.startValue = arg_17_0.preValue
	arg_17_0.startMaxValue = arg_17_0.preMaxValue

	arg_17_0:recordPreValue()

	arg_17_0.heartTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, var_0_0.HeartTweenDuration, arg_17_0.onHeartTweenFrame, arg_17_0.onHeartTweenDone, arg_17_0)

	arg_17_0.bottomNumAnimator:Play("add", 0, 0)
	AudioMgr.instance:trigger(20270006)
	gohelper.setActive(arg_17_0.goLeft, false)
	gohelper.setActive(arg_17_0.goLeft, true)
end

function var_0_0.cleanHeartImageTween(arg_18_0)
	if arg_18_0.heartTweenId then
		ZProj.TweenHelper.KillById(arg_18_0.heartTweenId)

		arg_18_0.heartTweenId = nil
	end
end

function var_0_0.onHeartTweenFrame(arg_19_0, arg_19_1)
	local var_19_0 = math.floor(LuaTween.linear(arg_19_1, arg_19_0.startValue, arg_19_0.valueChangeLen, 1))
	local var_19_1 = math.floor(LuaTween.linear(arg_19_1, arg_19_0.startMaxValue, arg_19_0.maxValueChangeLen, 1))

	arg_19_0:setNumAndImage(var_19_0, var_19_1)
end

function var_0_0.onHeartTweenDone(arg_20_0)
	arg_20_0:directSetBloodValue()
	arg_20_0:recordPreValue()

	arg_20_0.heartTweenId = nil
end

function var_0_0.directSetBloodValue(arg_21_0)
	local var_21_0 = FightDataHelper.getBloodPool(arg_21_0.teamType)
	local var_21_1 = var_21_0.value
	local var_21_2 = var_21_0.max

	arg_21_0:setNumAndImage(var_21_1, var_21_2)
end

function var_0_0.setNumAndImage(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = string.format("%s/%s", arg_22_1, arg_22_2)

	arg_22_0.bottomNumTxt.text = var_22_0
	arg_22_0.bottomPreNumTxt.text = var_22_0
	arg_22_0.leftMaxTxt.text = arg_22_2
	arg_22_0.leftCurTxt.text = arg_22_1
	arg_22_0.leftEffMaxTxt.text = arg_22_2
	arg_22_0.leftEffCurTxt.text = arg_22_1

	local var_22_1 = arg_22_1 / arg_22_2

	arg_22_0.imageHeartMat:SetFloat(arg_22_0.heightPropertyId, var_22_1)
	arg_22_0.imageHeartPreMat:SetFloat(arg_22_0.heightPropertyId, var_22_1)
	arg_22_0:refreshPreTxtActive()
end

function var_0_0.showBengFaView(arg_23_0)
	arg_23_0:newClass(FightBengFaView, arg_23_0)
end

function var_0_0.onDestroyView(arg_24_0)
	arg_24_0:cleanHeartImageTween()
	arg_24_0.longPress:RemoveClickListener()
	arg_24_0.longPress:RemoveLongPressListener()

	arg_24_0.longPress = nil
end

return var_0_0
