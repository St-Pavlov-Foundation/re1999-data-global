module("modules.logic.fight.view.FightProgress500MView", package.seeall)

local var_0_0 = class("FightProgress500MView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.imageBg = gohelper.findChildImage(arg_1_0.viewGO, "slider/#image_bg")
	arg_1_0.imageIconBg = gohelper.findChildImage(arg_1_0.viewGO, "slider/#image_iconbg")
	arg_1_0.imageIconVxDict = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, 5 do
		arg_1_0.imageIconVxDict[iter_1_0] = gohelper.findChild(arg_1_0.viewGO, "slider/#iconbg_loop/#" .. iter_1_0)
	end

	arg_1_0.imageIcon = gohelper.findChildImage(arg_1_0.viewGO, "slider/#image_icon")
	arg_1_0.imageSliderBg = gohelper.findChildImage(arg_1_0.viewGO, "slider/#image_sliderbg")
	arg_1_0.imageSlider = gohelper.findChildImage(arg_1_0.viewGO, "slider/#image_sliderbg/#image_sliderfg")

	local var_1_0 = arg_1_0.imageSlider:GetComponent(gohelper.Type_RectTransform)

	arg_1_0.progressWidth = recthelper.getWidth(var_1_0)
	arg_1_0.goLoopAnim = gohelper.findChild(arg_1_0.viewGO, "slider/#image_sliderbg/#sliderfg_loop")
	arg_1_0.loopAnimRectTr = gohelper.findChildComponent(arg_1_0.goLoopAnim, "sliderfg_light", gohelper.Type_RectTransform)

	gohelper.setActive(arg_1_0.goLoopAnim, true)

	arg_1_0.pointGo = gohelper.findChild(arg_1_0.viewGO, "slider/#image_sliderbg/pointLayout/#image_point")

	gohelper.setActive(arg_1_0.pointGo, false)

	arg_1_0.txtProgress = gohelper.findChildText(arg_1_0.viewGO, "slider/#txt_progress")
	arg_1_0.txtTitle = gohelper.findChildText(arg_1_0.viewGO, "slider/txt_title")
	arg_1_0.btnClick = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "btn")
	arg_1_0.animPlayer = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0.commonTipViewPosTr = gohelper.findChild(arg_1_0.viewGO, "commontipview_pos"):GetComponent(gohelper.Type_RectTransform)
	arg_1_0.tweenProgress = 0

	arg_1_0:initThreshold()
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registClick(arg_2_0.btnClick, arg_2_0.onClickProgress)
	arg_2_0:com_registMsg(FightMsgId.NewProgressValueChange, arg_2_0.onProgressValueChange)
	arg_2_0:com_registFightEvent(FightEvent.OnMonsterChange, arg_2_0.onMonsterChange)
end

function var_0_0.initThreshold(arg_3_0)
	local var_3_0 = lua_fight_const.configDict[55]
	local var_3_1 = var_3_0 and var_3_0.value

	if string.nilorempty(var_3_1) then
		logError("密思海500m最终boss的蓄力条 阈值配置不存在")

		arg_3_0.threshold = {
			0.25,
			0.5,
			0.75,
			1
		}
	else
		arg_3_0.threshold = string.splitToNumber(var_3_1, "#")

		for iter_3_0, iter_3_1 in ipairs(arg_3_0.threshold) do
			arg_3_0.threshold[iter_3_0] = iter_3_1 / 100
		end
	end
end

function var_0_0.onMonsterChange(arg_4_0)
	arg_4_0:refreshUI()
	arg_4_0.animPlayer:Play("switch", 0, 0)
	AudioMgr.instance:trigger(310010)
end

var_0_0.TweenDuration = 0.5

function var_0_0.onProgressValueChange(arg_5_0)
	arg_5_0:clearTween()

	arg_5_0.curProgress = arg_5_0:getCurProgress()
	arg_5_0.tweenId = ZProj.TweenHelper.DOTweenFloat(arg_5_0.tweenProgress, arg_5_0.curProgress, var_0_0.TweenDuration, arg_5_0.frameCallback, arg_5_0.doneCallback, arg_5_0)
end

function var_0_0.frameCallback(arg_6_0, arg_6_1)
	arg_6_0:directSetProgress(arg_6_1)
end

function var_0_0.doneCallback(arg_7_0)
	arg_7_0:directSetProgress(arg_7_0.curProgress)

	arg_7_0.tweenId = nil
end

function var_0_0.onClickProgress(arg_8_0)
	local var_8_0 = recthelper.uiPosToScreenPos(arg_8_0.commonTipViewPosTr)
	local var_8_1 = luaLang("pata_500M_pogress_title")
	local var_8_2 = luaLang("pata_500M_pogress_desc")

	FightCommonTipController.instance:openCommonView(var_8_1, var_8_2, var_8_0)
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0.curProgress = arg_9_0:getCurProgress()

	arg_9_0:initPoint()
	arg_9_0:refreshUI()
end

function var_0_0.initPoint(arg_10_0)
	arg_10_0.thresholdPointList = {}
	arg_10_0.playedThresholdIndexDict = {}

	local var_10_0 = arg_10_0.pointGo.transform.parent
	local var_10_1 = recthelper.getWidth(var_10_0)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.threshold) do
		local var_10_2 = arg_10_0:getUserDataTb_()

		var_10_2.go = gohelper.cloneInPlace(arg_10_0.pointGo)

		table.insert(arg_10_0.thresholdPointList, var_10_2)

		var_10_2.image = var_10_2.go:GetComponent(gohelper.Type_Image)
		var_10_2.animLight = var_10_2.go:GetComponent(gohelper.Type_Animation)

		local var_10_3 = var_10_2.go:GetComponent(gohelper.Type_RectTransform)

		recthelper.setAnchorX(var_10_3, iter_10_1 * var_10_1)

		if iter_10_1 <= arg_10_0.curProgress then
			gohelper.setActive(var_10_2.go, false)

			arg_10_0.playedThresholdIndexDict[iter_10_0] = true
		else
			gohelper.setActive(var_10_2.go, true)
		end
	end
end

function var_0_0.refreshUI(arg_11_0)
	arg_11_0.curStageCo = FightHelper.getBossCurStageCo_500M()

	arg_11_0:refreshPoint()
	arg_11_0:refreshImageIconVx()
	UISpriteSetMgr.instance:setFightTowerSprite(arg_11_0.imageBg, arg_11_0.curStageCo.param4)
	UISpriteSetMgr.instance:setFightTowerSprite(arg_11_0.imageIconBg, arg_11_0.curStageCo.param5)
	UISpriteSetMgr.instance:setFightTowerSprite(arg_11_0.imageIcon, arg_11_0.curStageCo.param6)
	UISpriteSetMgr.instance:setFightTowerSprite(arg_11_0.imageSliderBg, arg_11_0.curStageCo.param7)
	UISpriteSetMgr.instance:setFightTowerSprite(arg_11_0.imageSlider, arg_11_0.curStageCo.param8)
	arg_11_0:clearTween()

	arg_11_0.curProgress = arg_11_0:getCurProgress()

	arg_11_0:directSetProgress(arg_11_0.curProgress)
end

function var_0_0.directSetProgress(arg_12_0, arg_12_1)
	arg_12_0.tweenProgress = arg_12_1
	arg_12_0.txtProgress.text = string.format("%s%%", math.floor(arg_12_0.tweenProgress * 100))
	arg_12_0.imageSlider.fillAmount = arg_12_0.tweenProgress

	recthelper.setWidth(arg_12_0.loopAnimRectTr, arg_12_0.progressWidth * arg_12_0.tweenProgress)
end

function var_0_0.cancelRefreshPointTask(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0.hidePlayedPoint, arg_13_0)
end

var_0_0.AnimLightLen = 1

function var_0_0.refreshPoint(arg_14_0)
	arg_14_0:cancelRefreshPointTask()

	local var_14_0 = arg_14_0.curStageCo and arg_14_0.curStageCo.param9 or ""

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.threshold) do
		local var_14_1 = arg_14_0.thresholdPointList[iter_14_0]

		if iter_14_1 <= arg_14_0.curProgress then
			UISpriteSetMgr.instance:setFightTowerSprite(var_14_1.image, var_14_0)
			gohelper.setActive(var_14_1.go, not arg_14_0.playedThresholdIndexDict[iter_14_0])

			if not arg_14_0.playedThresholdIndexDict[iter_14_0] then
				arg_14_0.playedThresholdIndexDict[iter_14_0] = true

				var_14_1.animLight:Play()
				arg_14_0:cancelRefreshPointTask()
				TaskDispatcher.runDelay(arg_14_0.hidePlayedPoint, arg_14_0, var_0_0.AnimLightLen)
			end
		else
			UISpriteSetMgr.instance:setFightTowerSprite(var_14_1.image, "fight_tower_point_0")
		end
	end
end

function var_0_0.hidePlayedPoint(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.playedThresholdIndexDict) do
		local var_15_0 = arg_15_0.thresholdPointList[iter_15_0]

		if var_15_0 then
			gohelper.setActive(var_15_0.go, false)
		end
	end
end

function var_0_0.refreshImageIconVx(arg_16_0)
	local var_16_0 = arg_16_0.curStageCo.level

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.imageIconVxDict) do
		gohelper.setActive(iter_16_1, iter_16_0 == var_16_0)
	end
end

function var_0_0.getCurProgress(arg_17_0)
	local var_17_0 = FightDataHelper.fieldMgr.progressDic
	local var_17_1 = var_17_0 and var_17_0:getDataByShowId(FightEnum.ProgressId.Progress_500M)

	if not var_17_1 then
		return 0
	end

	return var_17_1.value / var_17_1.max
end

function var_0_0.clearTween(arg_18_0)
	if arg_18_0.tweenId then
		ZProj.TweenHelper.KillById(arg_18_0.tweenId)

		arg_18_0.tweenId = nil
	end
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0:clearTween()
	arg_19_0:cancelRefreshPointTask()
end

return var_0_0
