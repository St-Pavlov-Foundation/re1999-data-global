module("modules.logic.survival.view.map.SurvivalShrinkView", package.seeall)

local var_0_0 = class("SurvivalShrinkView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtCountDown = gohelper.findChild(arg_1_0.viewGO, "Top/#go_countdown/#txt_countdown")
	arg_1_0._goprocess = gohelper.findChild(arg_1_0.viewGO, "Top/#go_process")
	arg_1_0._goprocessitem = gohelper.findChild(arg_1_0.viewGO, "Top/#go_process/#go_slider")
	arg_1_0._goicon1 = gohelper.findChild(arg_1_0.viewGO, "Top/#go_process/#go_icon1")
	arg_1_0._goicon2 = gohelper.findChild(arg_1_0.viewGO, "Top/#go_process/#go_icon2")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "Top/#go_tips")
	arg_1_0._btntips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Top/#btn_tips")
	arg_1_0._goshrinkTips = gohelper.findChildAnim(arg_1_0.viewGO, "Top/#go_tips/#go_restTips")
	arg_1_0._txtshrinkTips = gohelper.findChildTextMesh(arg_1_0.viewGO, "Top/#go_tips/#go_restTips/#txt_restTips")
	arg_1_0._goshrinkArrow = gohelper.findChild(arg_1_0.viewGO, "Top/#go_tips/#go_restTips/arrow")
	arg_1_0._gorestTips = gohelper.findChildAnim(arg_1_0.viewGO, "Top/#go_tips/#go_shrinkTips")
	arg_1_0._txtrestTips = gohelper.findChildTextMesh(arg_1_0.viewGO, "Top/#go_tips/#go_shrinkTips/#txt_shrinkTips")
	arg_1_0._gorestArrow = gohelper.findChild(arg_1_0.viewGO, "Top/#go_tips/#go_shrinkTips/arrow")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntips:AddClickListener(arg_2_0._showHideTips, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnShrinkInfoUpdate, arg_2_0._refreshGameTime, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapGameTimeUpdate, arg_2_0._refreshGameTime, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapCostTimeUpdate, arg_2_0._onCostTimeUpdate, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntips:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnShrinkInfoUpdate, arg_3_0._refreshGameTime, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapGameTimeUpdate, arg_3_0._refreshGameTime, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapCostTimeUpdate, arg_3_0._onCostTimeUpdate, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	if arg_4_0._flashTxtComp then
		return
	end

	arg_4_0._flashTxtComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._txtCountDown, SurvivalFlashTxtComp)
	arg_4_0._processWidth = recthelper.getWidth(arg_4_0._goprocess.transform)
	arg_4_0._icon1Width = recthelper.getWidth(arg_4_0._goicon1.transform)
	arg_4_0._icon2Width = recthelper.getWidth(arg_4_0._goicon2.transform)
	arg_4_0._isShowTips = true
	arg_4_0._goshrinkTips.keepAnimatorControllerStateOnDisable = true
	arg_4_0._gorestTips.keepAnimatorControllerStateOnDisable = true

	gohelper.setActive(arg_4_0._gotips, true)
	gohelper.setActive(arg_4_0._goicon1, false)
	gohelper.setActive(arg_4_0._goicon2, false)
	gohelper.setActive(arg_4_0._goprocessitem, false)

	arg_4_0._icon1Pool = arg_4_0:getUserDataTb_()
	arg_4_0._icon2Pool = arg_4_0:getUserDataTb_()
	arg_4_0._sliderPool = arg_4_0:getUserDataTb_()
	arg_4_0._icon1Inst = arg_4_0:getUserDataTb_()
	arg_4_0._icon2Inst = arg_4_0:getUserDataTb_()
	arg_4_0._sliderInst = arg_4_0:getUserDataTb_()

	arg_4_0:_refreshGameTime()
end

function var_0_0._showHideTips(arg_5_0)
	arg_5_0._isShowTips = not arg_5_0._isShowTips

	if arg_5_0._isShowTips then
		if arg_5_0._curIsSafe then
			arg_5_0._gorestTips:Play("open", 0, 0)
		else
			arg_5_0._goshrinkTips:Play("open", 0, 0)
		end
	else
		TaskDispatcher.cancelTask(arg_5_0._delayPlayTipsOpen, arg_5_0)

		if arg_5_0._curIsSafe then
			arg_5_0._gorestTips:Play("close", 0, 0)
		else
			arg_5_0._goshrinkTips:Play("close", 0, 0)
		end
	end
end

function var_0_0._refreshGameTime(arg_6_0)
	local var_6_0 = SurvivalMapModel.instance:getSceneMo()
	local var_6_1 = var_6_0.currMaxGameTime - var_6_0.gameTime
	local var_6_2 = math.floor(var_6_1 / 60)
	local var_6_3 = math.fmod(var_6_1, 60)

	arg_6_0._flashTxtComp:setNormalTxt(string.format("%d:%02d", var_6_2, var_6_3))

	local var_6_4 = {}
	local var_6_5 = var_6_0.addTime

	for iter_6_0, iter_6_1 in ipairs(var_6_0.safeZone) do
		if var_6_5 < iter_6_1.startTime then
			table.insert(var_6_4, {
				isSafe = true,
				startTime = var_6_5,
				endTime = iter_6_1.startTime
			})
		end

		table.insert(var_6_4, {
			startTime = iter_6_1.startTime,
			endTime = iter_6_1.endTime
		})

		var_6_5 = iter_6_1.endTime
	end

	if var_6_5 < var_6_0.currMaxGameTime then
		table.insert(var_6_4, {
			isSafe = true,
			startTime = var_6_5,
			endTime = var_6_0.currMaxGameTime
		})
	end

	tabletool.revert(var_6_4)

	local var_6_6 = arg_6_0._processWidth

	for iter_6_2, iter_6_3 in ipairs(var_6_4) do
		iter_6_3.startTime, iter_6_3.endTime = var_6_0.currMaxGameTime - iter_6_3.endTime, var_6_0.currMaxGameTime - iter_6_3.startTime

		if iter_6_2 ~= 1 then
			if iter_6_3.isSafe then
				var_6_6 = var_6_6 - arg_6_0._icon2Width
			else
				var_6_6 = var_6_6 - arg_6_0._icon1Width
			end
		end
	end

	arg_6_0:inPoolAllItems()

	local var_6_7 = false
	local var_6_8
	local var_6_9 = 0

	arg_6_0._totalSliderWidth = var_6_6
	arg_6_0._sliderDatas = var_6_4
	arg_6_0._sliderGos = arg_6_0._sliderGos or arg_6_0:getUserDataTb_()

	for iter_6_4, iter_6_5 in ipairs(var_6_4) do
		local var_6_10

		if iter_6_4 ~= 1 then
			if iter_6_5.isSafe then
				var_6_10 = arg_6_0:createItem(arg_6_0._icon2Pool, arg_6_0._icon2Inst, arg_6_0._goicon2)
			else
				var_6_10 = arg_6_0:createItem(arg_6_0._icon1Pool, arg_6_0._icon1Inst, arg_6_0._goicon1)
			end
		end

		local var_6_11 = arg_6_0:createItem(arg_6_0._sliderPool, arg_6_0._sliderInst, arg_6_0._goprocessitem)

		arg_6_0:setSlider(var_6_11, var_6_6, iter_6_5)

		arg_6_0._sliderGos[iter_6_4] = var_6_11

		if var_6_1 > iter_6_5.startTime and var_6_1 <= iter_6_5.endTime then
			var_6_7 = iter_6_5.isSafe or false
			var_6_9 = iter_6_5.startTime
			var_6_8 = var_6_10
		end
	end

	if arg_6_0._curIsSafe == nil then
		arg_6_0._gorestTips:Play(var_6_7 and "open" or "close", 0, 1)
		arg_6_0._goshrinkTips:Play(not var_6_7 and "open" or "close", 0, 1)
	elseif arg_6_0._curIsSafe ~= var_6_7 then
		TaskDispatcher.cancelTask(arg_6_0._delayPlayTipsOpen, arg_6_0)

		if arg_6_0._isShowTips then
			if var_6_7 then
				arg_6_0._goshrinkTips:Play("close", 0, 0)
				arg_6_0._gorestTips:Play("close", 0, 1)
			else
				arg_6_0._gorestTips:Play("close", 0, 0)
				arg_6_0._goshrinkTips:Play("close", 0, 1)
			end

			TaskDispatcher.runDelay(arg_6_0._delayPlayTipsOpen, arg_6_0, 0.167)
		end
	end

	arg_6_0._curIsSafe = var_6_7

	local var_6_12 = var_6_0.safeZone[1]
	local var_6_13 = "danger"

	if var_6_12 and var_6_12.round == 1 and var_6_12.startTime > var_6_0.gameTime then
		var_6_13 = "explore"
	end

	AudioMgr.instance:setState(AudioMgr.instance:getIdFromString("dl_music"), AudioMgr.instance:getIdFromString(var_6_13))

	local var_6_14 = math.floor(var_6_9 / 60)
	local var_6_15 = math.fmod(var_6_9, 60)

	if var_6_7 then
		arg_6_0._txtrestTips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_mainview_beginshrink"), string.format("%d:%02d", var_6_14, var_6_15))
	elseif var_6_8 then
		arg_6_0._txtshrinkTips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_mainview_endshrink"), string.format("%d:%02d", var_6_14, var_6_15))
	else
		arg_6_0._txtshrinkTips.text = luaLang("survival_mainview_lastshrink")
	end

	gohelper.setActive(arg_6_0._gorestArrow, var_6_8 and true or false)
	gohelper.setActive(arg_6_0._goshrinkArrow, var_6_8 and true or false)

	if var_6_8 then
		ZProj.UGUIHelper.RebuildLayout(arg_6_0._goprocess.transform)
		arg_6_0:setTransY(arg_6_0._gorestArrow.transform, var_6_8)
		arg_6_0:setTransY(arg_6_0._goshrinkArrow.transform, var_6_8)
	end
end

function var_0_0._delayPlayTipsOpen(arg_7_0)
	if not arg_7_0._isShowTips then
		return
	end

	if arg_7_0._curIsSafe then
		arg_7_0._gorestTips:Play("open", 0, 0)
	else
		arg_7_0._goshrinkTips:Play("open", 0, 0)
	end
end

function var_0_0.setTransY(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1.parent:InverseTransformPoint(arg_8_2.transform.position)
	local var_8_1, var_8_2, var_8_3 = transformhelper.getLocalPos(arg_8_1)

	transformhelper.setLocalPos(arg_8_1, var_8_0.x, var_8_2, var_8_3)
end

function var_0_0.inPoolAllItems(arg_9_0)
	arg_9_0:inPoolItem(arg_9_0._icon1Pool, arg_9_0._icon1Inst)
	arg_9_0:inPoolItem(arg_9_0._icon2Pool, arg_9_0._icon2Inst)
	arg_9_0:inPoolItem(arg_9_0._sliderPool, arg_9_0._sliderInst)
end

function var_0_0.inPoolItem(arg_10_0, arg_10_1, arg_10_2)
	for iter_10_0 = #arg_10_2, 1, -1 do
		table.insert(arg_10_1, arg_10_2[iter_10_0])
		gohelper.setActive(arg_10_2[iter_10_0], false)

		arg_10_2[iter_10_0] = nil
	end
end

function var_0_0.createItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = table.remove(arg_11_1) or gohelper.cloneInPlace(arg_11_3)

	gohelper.setActive(var_11_0, true)
	gohelper.setAsLastSibling(var_11_0)
	table.insert(arg_11_2, var_11_0)

	return var_11_0
end

function var_0_0._onCostTimeUpdate(arg_12_0)
	if not arg_12_0._totalSliderWidth then
		return
	end

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._sliderDatas) do
		arg_12_0:setSlider(arg_12_0._sliderGos[iter_12_0], arg_12_0._totalSliderWidth, iter_12_1)
	end

	if SurvivalMapModel.instance.showCostTime == 0 then
		arg_12_0._flashTxtComp:setFlashTxt()
	else
		local var_12_0 = SurvivalMapModel.instance:getSceneMo()
		local var_12_1 = var_12_0.currMaxGameTime - var_12_0.gameTime - SurvivalMapModel.instance.showCostTime

		if var_12_1 < 0 then
			var_12_1 = 0
		end

		local var_12_2 = math.floor(var_12_1 / 60)
		local var_12_3 = math.fmod(var_12_1, 60)

		arg_12_0._flashTxtComp:setFlashTxt(string.format("%d:%02d", var_12_2, var_12_3))
	end
end

function var_0_0.setSlider(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = gohelper.findChildImage(arg_13_1, "#image_slider")
	local var_13_1 = gohelper.findChildImage(arg_13_1, "#image_cost")
	local var_13_2 = SurvivalMapModel.instance:getSceneMo()
	local var_13_3 = (arg_13_3.endTime - arg_13_3.startTime) / (var_13_2.currMaxGameTime - var_13_2.addTime) * arg_13_2

	recthelper.setWidth(arg_13_1.transform, var_13_3)

	local var_13_4 = var_13_2.currMaxGameTime - var_13_2.gameTime
	local var_13_5 = var_13_4 - SurvivalMapModel.instance.showCostTime

	if var_13_4 >= arg_13_3.endTime then
		var_13_0.fillAmount = 1
	elseif var_13_4 <= arg_13_3.startTime then
		var_13_0.fillAmount = 0
	else
		var_13_0.fillAmount = (var_13_4 - arg_13_3.startTime) / (arg_13_3.endTime - arg_13_3.startTime)
	end

	local var_13_6 = 0
	local var_13_7 = 0

	if var_13_5 < arg_13_3.endTime and var_13_4 > arg_13_3.startTime and var_13_5 ~= var_13_4 then
		var_13_6 = (math.min(arg_13_3.endTime, var_13_4) - math.max(arg_13_3.startTime, var_13_5)) / (arg_13_3.endTime - arg_13_3.startTime) * var_13_3
		var_13_7 = (math.max(arg_13_3.startTime, var_13_5) - arg_13_3.startTime) / (arg_13_3.endTime - arg_13_3.startTime) * var_13_3
	end

	recthelper.setWidth(var_13_1.transform, var_13_6)
	recthelper.setAnchorX(var_13_1.transform, var_13_7)
end

function var_0_0.onClose(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._delayPlayTipsOpen, arg_14_0)
end

return var_0_0
