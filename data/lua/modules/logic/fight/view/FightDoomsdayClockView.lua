module("modules.logic.fight.view.FightDoomsdayClockView", package.seeall)

local var_0_0 = class("FightDoomsdayClockView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.animator = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0.goBroken = gohelper.findChild(arg_1_0.viewGO, "root/clock/broken")
	arg_1_0.goZhiZhen = gohelper.findChild(arg_1_0.viewGO, "root/clock/unbroken/#image_zhizhen")
	arg_1_0.trZhiZhen = arg_1_0.goZhiZhen:GetComponent(gohelper.Type_Transform)
	arg_1_0.areaTransform = gohelper.findChildComponent(arg_1_0.viewGO, "root/clock/unbroken/#go_area", gohelper.Type_Transform)
	arg_1_0.imageOrange = gohelper.findChildImage(arg_1_0.viewGO, "root/clock/unbroken/#go_area/#image_orange")
	arg_1_0.imageYellow = gohelper.findChildImage(arg_1_0.viewGO, "root/clock/unbroken/#go_area/#image_yellow")
	arg_1_0.imageRed = gohelper.findChildImage(arg_1_0.viewGO, "root/clock/unbroken/#go_area/#image_red")
	arg_1_0.imageGreen = gohelper.findChildImage(arg_1_0.viewGO, "root/clock/unbroken/#go_area/#image_green")
	arg_1_0.btnClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_click")
	arg_1_0.timeValueAnimator = gohelper.findChildComponent(arg_1_0.viewGO, "root/timevalue", gohelper.Type_Animator)
	arg_1_0.timeValueBg = gohelper.findChildComponent(arg_1_0.viewGO, "root/timevalue/bg", gohelper.Type_Image)
	arg_1_0.timeValueBgGlow = gohelper.findChildComponent(arg_1_0.viewGO, "root/timevalue/bg_glow", gohelper.Type_Image)
	arg_1_0.rectAnimRoot = gohelper.findChildComponent(arg_1_0.viewGO, "root/timevalue/scroll/animroot", gohelper.Type_RectTransform)
	arg_1_0.txtTimeList = {}
	arg_1_0.goTimeList = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, 5 do
		local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "root/timevalue/scroll/animroot/#go_time_" .. iter_1_0)

		table.insert(arg_1_0.goTimeList, var_1_0)

		local var_1_1 = arg_1_0:getUserDataTb_()

		arg_1_0.txtTimeList[iter_1_0] = var_1_1
		var_1_1[FightParamData.ParamKey.DoomsdayClock_Range1] = gohelper.findChildText(var_1_0, "#txt_time_orange")
		var_1_1[FightParamData.ParamKey.DoomsdayClock_Range2] = gohelper.findChildText(var_1_0, "#txt_time_yellow")
		var_1_1[FightParamData.ParamKey.DoomsdayClock_Range3] = gohelper.findChildText(var_1_0, "#txt_time_red")
		var_1_1[FightParamData.ParamKey.DoomsdayClock_Range4] = gohelper.findChildText(var_1_0, "#txt_time_green")
	end

	arg_1_0.key2Image = arg_1_0:getUserDataTb_()
	arg_1_0.key2Image[FightParamData.ParamKey.DoomsdayClock_Range1] = arg_1_0.imageOrange
	arg_1_0.key2Image[FightParamData.ParamKey.DoomsdayClock_Range2] = arg_1_0.imageYellow
	arg_1_0.key2Image[FightParamData.ParamKey.DoomsdayClock_Range3] = arg_1_0.imageRed
	arg_1_0.key2Image[FightParamData.ParamKey.DoomsdayClock_Range4] = arg_1_0.imageGreen
	arg_1_0.key2ImageLine = arg_1_0:getUserDataTb_()
	arg_1_0.key2ImageLine[FightParamData.ParamKey.DoomsdayClock_Range1] = gohelper.findChildComponent(arg_1_0.viewGO, "root/clock/unbroken/#go_area/line1", gohelper.Type_RectTransform)
	arg_1_0.key2ImageLine[FightParamData.ParamKey.DoomsdayClock_Range2] = gohelper.findChildComponent(arg_1_0.viewGO, "root/clock/unbroken/#go_area/line2", gohelper.Type_RectTransform)
	arg_1_0.key2ImageLine[FightParamData.ParamKey.DoomsdayClock_Range3] = gohelper.findChildComponent(arg_1_0.viewGO, "root/clock/unbroken/#go_area/line3", gohelper.Type_RectTransform)
	arg_1_0.key2ImageLine[FightParamData.ParamKey.DoomsdayClock_Range4] = gohelper.findChildComponent(arg_1_0.viewGO, "root/clock/unbroken/#go_area/line4", gohelper.Type_RectTransform)
	arg_1_0.key2Transform = arg_1_0:getUserDataTb_()
	arg_1_0.key2ImageEffect = arg_1_0:getUserDataTb_()

	for iter_1_1, iter_1_2 in pairs(arg_1_0.key2Image) do
		arg_1_0.key2Transform[iter_1_1] = iter_1_2:GetComponent(gohelper.Type_RectTransform)
		arg_1_0.key2ImageEffect[iter_1_1] = gohelper.findChild(iter_1_2.gameObject, "#glow")
	end

	arg_1_0.goAdd = gohelper.findChild(arg_1_0.viewGO, "root/num/add")
	arg_1_0.txtAdd = gohelper.findChildText(arg_1_0.viewGO, "root/num/add/#txt_add")
	arg_1_0.goReduce = gohelper.findChild(arg_1_0.viewGO, "root/num/reduce")
	arg_1_0.txtReduce = gohelper.findChildText(arg_1_0.viewGO, "root/num/reduce/#txt_reduce")
	arg_1_0.indicatorValue = FightDataHelper.fieldMgr:getIndicatorNum(FightEnum.IndicatorId.DoomsdayClock) or 0

	arg_1_0:setTimeValueActive(false)
	gohelper.setActive(arg_1_0.goBroken, false)

	arg_1_0.keyList = {
		FightParamData.ParamKey.DoomsdayClock_Range1,
		FightParamData.ParamKey.DoomsdayClock_Range2,
		FightParamData.ParamKey.DoomsdayClock_Range3,
		FightParamData.ParamKey.DoomsdayClock_Range4
	}
end

var_0_0.AreaId2Color = {
	[FightParamData.ParamKey.DoomsdayClock_Range1] = "#e56745",
	[FightParamData.ParamKey.DoomsdayClock_Range2] = "#4c7bff",
	[FightParamData.ParamKey.DoomsdayClock_Range3] = "#e54550",
	[FightParamData.ParamKey.DoomsdayClock_Range4] = "#60cace"
}
var_0_0.ZhiZhenTweenDuration = 0.5

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registFightEvent(FightEvent.DoomsdayClock_OnValueChange, arg_2_0.onValueChange)
	arg_2_0:com_registFightEvent(FightEvent.DoomsdayClock_OnAreaChange, arg_2_0.onAreaChange)
	arg_2_0:com_registFightEvent(FightEvent.DoomsdayClock_OnBroken, arg_2_0.onBroken)
	arg_2_0:com_registFightEvent(FightEvent.OnIndicatorChange, arg_2_0.onIndicatorChange)
	arg_2_0:com_registFightEvent(FightEvent.DoomsdayClock_OnClear, arg_2_0.onClear)
	arg_2_0.btnClick:AddClickListener(arg_2_0.onClickClock, arg_2_0)
end

function var_0_0.onClickClock(arg_3_0)
	HelpController.instance:showHelp(HelpEnum.HelpId.V2A7_boss)
end

function var_0_0.onClear(arg_4_0)
	arg_4_0:refreshHighlightArea()
end

function var_0_0.refreshHighlightArea(arg_5_0)
	local var_5_0 = arg_5_0:getParamValue(FightParamData.ParamKey.DoomsdayClock_Offset)
	local var_5_1 = arg_5_0:getParamValue(FightParamData.ParamKey.DoomsdayClock_Value)
	local var_5_2 = arg_5_0:formatValue(var_5_1 + var_5_0)
	local var_5_3 = FightParamData.ParamKey.DoomsdayClock_Range1

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.keyList) do
		if var_5_2 < arg_5_0:getParamValue(iter_5_1) then
			var_5_3 = iter_5_1

			break
		end
	end

	local var_5_4 = arg_5_0.AreaId2Color[var_5_3] or "#ffd84c"

	for iter_5_2, iter_5_3 in pairs(arg_5_0.key2ImageEffect) do
		gohelper.setActive(iter_5_3, false)

		if iter_5_2 == var_5_3 then
			gohelper.setActive(iter_5_3, true)
		end
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_5_0.timeValueBgGlow, var_5_4)
	arg_5_0:refreshTxtColor(var_5_3)
	arg_5_0.timeValueAnimator:Play("switch", 0, 0)
end

function var_0_0.refreshTxtColor(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.txtTimeList) do
		for iter_6_2, iter_6_3 in pairs(iter_6_1) do
			gohelper.setActive(iter_6_3.gameObject, iter_6_2 == arg_6_1)
		end
	end
end

function var_0_0.formatValue(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getParamValue(FightParamData.ParamKey.DoomsdayClock_Range4)

	while arg_7_1 < 0 do
		arg_7_1 = arg_7_1 + var_7_0
	end

	while var_7_0 <= arg_7_1 do
		arg_7_1 = arg_7_1 - var_7_0
	end

	return arg_7_1
end

function var_0_0.onBroken(arg_8_0)
	gohelper.setActive(arg_8_0.goBroken, true)
	AudioMgr.instance:trigger(20270057)
end

var_0_0.ItemHeight = 25
var_0_0.ItemCount = 5
var_0_0.ScrollCenterCount = 3
var_0_0.ScrollDuration = 1

function var_0_0.onIndicatorChange(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 ~= FightEnum.IndicatorId.DoomsdayClock then
		return
	end

	if not arg_9_2 or arg_9_2 == 0 then
		return
	end

	FightModel.instance:setWaitIndicatorAnimation(true)

	arg_9_0.startValue = arg_9_0.indicatorValue
	arg_9_0.endValue = arg_9_0.indicatorValue + arg_9_2
	arg_9_0.indicatorValue = arg_9_0.endValue
	arg_9_0.totalOffset = math.abs(arg_9_2)
	arg_9_0.offsetSymbol = arg_9_2 / arg_9_0.totalOffset
	arg_9_0.scrollLen = arg_9_2 * var_0_0.ItemHeight

	local var_9_0 = var_0_0.ScrollDuration

	if math.abs(arg_9_2) <= 2 then
		var_9_0 = var_9_0 / 2
	end

	arg_9_0.speed = arg_9_0.scrollLen / var_9_0
	arg_9_0.scrolledAnchorY = 0
	arg_9_0.scrolledOffset = 0

	arg_9_0:setTimeValueTxt(arg_9_0.startValue)
	arg_9_0:setTimeValueActive(true)
	recthelper.setAnchorY(arg_9_0.rectAnimRoot, 0)

	arg_9_0.startScrollAnim = true
end

function var_0_0._onFrame(arg_10_0)
	if not arg_10_0.startScrollAnim then
		return
	end

	local var_10_0 = Time.deltaTime
	local var_10_1 = recthelper.getAnchorY(arg_10_0.rectAnimRoot)
	local var_10_2 = var_10_0 * arg_10_0.speed

	arg_10_0.scrolledAnchorY = arg_10_0.scrolledAnchorY + var_10_2

	local var_10_3 = var_10_1 + var_10_2

	recthelper.setAnchorY(arg_10_0.rectAnimRoot, var_10_3)

	if math.abs(arg_10_0.scrolledAnchorY) >= var_0_0.ItemHeight then
		arg_10_0:onScrolledOneItemHeight()
	end
end

function var_0_0.onScrolledOneItemHeight(arg_11_0)
	arg_11_0.scrolledOffset = arg_11_0.scrolledOffset + 1
	arg_11_0.scrolledAnchorY = 0

	recthelper.setAnchorY(arg_11_0.rectAnimRoot, 0)

	local var_11_0 = arg_11_0.startValue + arg_11_0.scrolledOffset * arg_11_0.offsetSymbol

	arg_11_0:setTimeValueTxt(var_11_0)

	if arg_11_0.scrolledOffset == arg_11_0.totalOffset then
		arg_11_0:onScrollAnimDone()
	end
end

function var_0_0.setTimeValueTxt(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.txtTimeList) do
		for iter_12_2, iter_12_3 in pairs(iter_12_1) do
			iter_12_3.text = arg_12_1 - var_0_0.ScrollCenterCount + iter_12_0
		end
	end
end

function var_0_0.setTimeValueActive(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.goTimeList) do
		gohelper.setActive(iter_13_1, arg_13_1 or iter_13_0 == var_0_0.ScrollCenterCount)
	end
end

function var_0_0.onScrollAnimDone(arg_14_0)
	arg_14_0.startScrollAnim = false

	arg_14_0:setTimeValueTxt(arg_14_0.indicatorValue)
	arg_14_0:setTimeValueActive(false)
	FightController.instance:dispatchEvent(FightEvent.OnIndicatorAnimationDone)
end

function var_0_0.onValueChange(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0:tweenZhiZhen(arg_15_3)
	arg_15_0:showFloat(arg_15_3)
	arg_15_0.timeValueAnimator:Play("fit", 0, 0)
end

function var_0_0.onAreaChange(arg_16_0)
	arg_16_0:refreshArea()
	arg_16_0:tweenZhiZhen()
end

function var_0_0.getParamValue(arg_17_0, arg_17_1)
	local var_17_0 = FightDataHelper.fieldMgr.param

	return var_17_0 and var_17_0:getKey(arg_17_1) or 0
end

function var_0_0.onOpen(arg_18_0)
	arg_18_0.animator:Play("open")
	arg_18_0:setTimeValueTxt(arg_18_0.indicatorValue)
	arg_18_0:refreshHighlightArea()
	arg_18_0:refreshArea()
	arg_18_0:directSetZhiZhenPos()
	arg_18_0:initUpdateBeat()
end

function var_0_0.initUpdateBeat(arg_19_0)
	arg_19_0.updateHandle = UpdateBeat:CreateListener(arg_19_0._onFrame, arg_19_0)

	UpdateBeat:AddListener(arg_19_0.updateHandle)
end

function var_0_0.tweenZhiZhen(arg_20_0, arg_20_1)
	arg_20_0:clearZhiZhenTween()

	if not arg_20_1 then
		arg_20_0:directSetZhiZhenPos()

		return
	end

	local var_20_0 = arg_20_0:getParamValue(FightParamData.ParamKey.DoomsdayClock_Value)
	local var_20_1 = var_20_0 - arg_20_1

	arg_20_0.zhiZhenTweenId = ZProj.TweenHelper.DOTweenFloat(var_20_1, var_20_0, var_0_0.ZhiZhenTweenDuration, arg_20_0.tweenFrame, arg_20_0.directSetZhiZhenPos, arg_20_0)

	AudioMgr.instance:trigger(20270055)
end

function var_0_0.tweenFrame(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1 / arg_21_0:getParamValue(FightParamData.ParamKey.DoomsdayClock_Range4) * 360

	transformhelper.setLocalRotation(arg_21_0.trZhiZhen, 0, 0, -var_21_0)
end

function var_0_0.directSetZhiZhenPos(arg_22_0)
	local var_22_0 = arg_22_0:getZhiZhenCurRotation()

	transformhelper.setLocalRotation(arg_22_0.trZhiZhen, 0, 0, var_22_0)
end

function var_0_0.getZhiZhenCurRotation(arg_23_0)
	return -(arg_23_0:getParamValue(FightParamData.ParamKey.DoomsdayClock_Value) / arg_23_0:getParamValue(FightParamData.ParamKey.DoomsdayClock_Range4) * 360)
end

var_0_0.RotateCircleAngle = 1800
var_0_0.RotateDuration = 1
var_0_0.RotateEaseType = EaseType.OutCirc

function var_0_0.refreshArea(arg_24_0)
	local var_24_0 = arg_24_0:getParamValue(FightParamData.ParamKey.DoomsdayClock_Offset)
	local var_24_1 = arg_24_0:getParamValue(FightParamData.ParamKey.DoomsdayClock_Range4)
	local var_24_2 = var_24_0 / var_24_1 * 360
	local var_24_3 = 0

	for iter_24_0, iter_24_1 in pairs(arg_24_0.key2Image) do
		local var_24_4 = arg_24_0:getParamValue(iter_24_0) - var_24_3

		iter_24_1.fillAmount = var_24_4 / var_24_1

		local var_24_5 = var_24_3 / var_24_1 * 360

		transformhelper.setLocalRotation(arg_24_0.key2Transform[iter_24_0], 0, 0, -var_24_5 + var_24_2)
		transformhelper.setLocalRotation(arg_24_0.key2ImageLine[iter_24_0], 0, 0, -var_24_5 + var_24_2 - 180)

		var_24_3 = var_24_3 + var_24_4
	end

	arg_24_0:clearRotationTween()

	arg_24_0.tweenRotationId = ZProj.TweenHelper.DOTweenFloat(0, var_0_0.RotateCircleAngle, var_0_0.RotateDuration, arg_24_0.onRotateFrameCallback, arg_24_0.onRotateDoneCallback, arg_24_0, nil, var_0_0.RotateEaseType)

	AudioMgr.instance:trigger(20270056)
end

function var_0_0.onRotateFrameCallback(arg_25_0, arg_25_1)
	transformhelper.setLocalRotation(arg_25_0.areaTransform, 0, 0, arg_25_1)
end

function var_0_0.onRotateDoneCallback(arg_26_0)
	transformhelper.setLocalRotation(arg_26_0.areaTransform, 0, 0, 0)

	arg_26_0.tweenRotationId = nil
end

function var_0_0.showFloat(arg_27_0, arg_27_1)
	arg_27_0:hideFloat()
	TaskDispatcher.cancelTask(arg_27_0.hideFloat, arg_27_0)

	if arg_27_1 > 0 then
		gohelper.setActive(arg_27_0.goAdd, true)

		arg_27_0.txtAdd.text = string.format("%+d", arg_27_1)
	else
		gohelper.setActive(arg_27_0.goReduce, true)

		arg_27_0.txtReduce.text = string.format("%+d", arg_27_1)
	end

	TaskDispatcher.runDelay(arg_27_0.hideFloat, arg_27_0, 1)
end

function var_0_0.hideFloat(arg_28_0)
	gohelper.setActive(arg_28_0.goAdd, false)
	gohelper.setActive(arg_28_0.goReduce, false)
end

function var_0_0.clearZhiZhenTween(arg_29_0)
	if arg_29_0.zhiZhenTweenId then
		ZProj.TweenHelper.KillById(arg_29_0.zhiZhenTweenId)

		arg_29_0.zhiZhenTweenId = nil
	end
end

function var_0_0.clearRotationTween(arg_30_0)
	if arg_30_0.tweenRotationId then
		ZProj.TweenHelper.KillById(arg_30_0.tweenRotationId)

		arg_30_0.tweenRotationId = nil
	end
end

function var_0_0.onDestroyView(arg_31_0)
	if arg_31_0.updateHandle then
		UpdateBeat:RemoveListener(arg_31_0.updateHandle)
	end

	if arg_31_0.btnClick then
		arg_31_0.btnClick:RemoveClickListener()

		arg_31_0.btnClick = nil
	end

	arg_31_0:clearZhiZhenTween()
	arg_31_0:clearRotationTween()
	TaskDispatcher.cancelTask(arg_31_0.hideFloat, arg_31_0)
end

return var_0_0
