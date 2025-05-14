module("modules.logic.summon.view.SummonEquipFloatView", package.seeall)

local var_0_0 = class("SummonEquipFloatView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goresult = gohelper.findChild(arg_1_0.viewGO, "#go_result")
	arg_1_0._goresultitem = gohelper.findChild(arg_1_0.viewGO, "#go_result/resultcontent/#go_resultitem")
	arg_1_0._btnopenall = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_result/#btn_openall")
	arg_1_0._btnreturn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_result/#btn_return")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnopenall:AddClickListener(arg_2_0._btnopenallOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnopenall:RemoveClickListener()
end

function var_0_0._btnopenallOnClick(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_click)

	for iter_4_0 = 1, 10 do
		arg_4_0:openSummonResult(iter_4_0, true)
	end

	SummonController.instance:nextSummonPopupParam()
end

function var_0_0.handleSkip(arg_5_0)
	if not arg_5_0._isDrawing or not arg_5_0.summonResult then
		return
	end

	SummonController.instance:clearSummonPopupList()

	local var_5_0 = #arg_5_0.summonResult

	if var_5_0 == 1 then
		local var_5_1, var_5_2 = SummonModel.instance:openSummonEquipResult(1)

		if var_5_1 then
			local var_5_3 = var_5_1.equipId

			ViewMgr.instance:openView(ViewName.SummonEquipGainView, {
				skipVideo = true,
				equipId = var_5_3,
				summonResultMo = var_5_1
			})
		end
	elseif var_5_0 >= 10 then
		for iter_5_0 = 1, 10 do
			SummonModel.instance:openSummonResult(iter_5_0)
		end

		local var_5_4 = SummonController.instance:getLastPoolId()

		if not var_5_4 then
			return
		end

		local var_5_5 = SummonConfig.instance:getSummonPool(var_5_4)

		if not var_5_5 then
			return
		end

		ViewMgr.instance:openView(ViewName.SummonResultView, {
			summonResultList = arg_5_0.summonResult,
			curPool = var_5_5
		})
	end
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._goresultitem, false)

	arg_6_0._resultitems = {}
	arg_6_0._summonUIEffects = arg_6_0:getUserDataTb_()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_7_0.startDraw, arg_7_0)
	arg_7_0:addEventCb(SummonController.instance, SummonEvent.onSummonAnimRareEffect, arg_7_0.handleSummonAnimRareEffect, arg_7_0)
	arg_7_0:addEventCb(SummonController.instance, SummonEvent.onSummonAnimEnd, arg_7_0.handleSummonAnimEnd, arg_7_0)
	arg_7_0:addEventCb(SummonController.instance, SummonEvent.onSummonEquipEnd, arg_7_0.handleSummonEnd, arg_7_0)
	arg_7_0:addEventCb(SummonController.instance, SummonEvent.onSummonSkip, arg_7_0.handleSkip, arg_7_0)
	arg_7_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_7_0.handleCloseView, arg_7_0)
	arg_7_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_7_0.handleOpenView, arg_7_0)
end

function var_0_0.onClose(arg_8_0)
	arg_8_0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_8_0.startDraw, arg_8_0)
	arg_8_0:removeEventCb(SummonController.instance, SummonEvent.onSummonAnimRareEffect, arg_8_0.handleSummonAnimRareEffect, arg_8_0)
	arg_8_0:removeEventCb(SummonController.instance, SummonEvent.onSummonAnimEnd, arg_8_0.handleSummonAnimEnd, arg_8_0)
	arg_8_0:removeEventCb(SummonController.instance, SummonEvent.onSummonEquipEnd, arg_8_0.handleSummonEnd, arg_8_0)
	arg_8_0:removeEventCb(SummonController.instance, SummonEvent.onSummonSkip, arg_8_0.handleSkip, arg_8_0)
	arg_8_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_8_0.handleCloseView, arg_8_0)
	arg_8_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_8_0.handleOpenView, arg_8_0)
end

function var_0_0.startDraw(arg_9_0)
	SummonController.instance:clearSummonPopupList()

	arg_9_0.summonResult = SummonModel.instance:getSummonResult(true)

	arg_9_0:recycleEffect()

	arg_9_0._isDrawing = true
end

function var_0_0.handleSummonAnimEnd(arg_10_0)
	arg_10_0:initSummonResult()
end

function var_0_0.handleSummonEnd(arg_11_0)
	arg_11_0:recycleEffect()
end

function var_0_0.handleSummonAnimRareEffect(arg_12_0)
	local var_12_0

	if #arg_12_0.summonResult > 1 then
		var_12_0 = SummonController.instance:getUINodes()
	else
		var_12_0 = SummonController.instance:getOnlyUINode()
	end

	for iter_12_0 = 1, #arg_12_0.summonResult do
		local var_12_1 = arg_12_0.summonResult[iter_12_0]
		local var_12_2 = EquipConfig.instance:getEquipCo(var_12_1.equipId)
		local var_12_3 = ""
		local var_12_4 = ""

		if var_12_2.rare <= 2 then
			var_12_3 = SummonEnum.SummonPreloadPath.EquipUIN
		elseif var_12_2.rare == 3 then
			var_12_3 = SummonEnum.SummonPreloadPath.EquipUIR
		elseif var_12_2.rare == 4 then
			var_12_3 = SummonEnum.SummonPreloadPath.EquipUISR
		else
			var_12_3 = SummonEnum.SummonPreloadPath.EquipUISSR
		end

		local var_12_5 = SummonEnum.AnimationName[var_12_3]
		local var_12_6 = SummonEffectPool.getEffect(var_12_3, var_12_0[iter_12_0])

		var_12_6:setAnimationName(var_12_5)
		var_12_6:play()
		var_12_6:loadEquipWaitingClick()
		var_12_6:setEquipFrame(false)
		table.insert(arg_12_0._summonUIEffects, var_12_6)
	end
end

function var_0_0.initSummonResult(arg_13_0)
	arg_13_0._waitEffectList = {}
	arg_13_0._waitNormalEffectList = {}

	local var_13_0

	if #arg_13_0.summonResult > 1 then
		var_13_0 = SummonController.instance:getUINodes()
	else
		var_13_0 = SummonController.instance:getOnlyUINode()
	end

	for iter_13_0 = 1, #arg_13_0.summonResult do
		local var_13_1 = arg_13_0.summonResult[iter_13_0]
		local var_13_2 = arg_13_0._resultitems[iter_13_0]

		if not var_13_2 then
			var_13_2 = arg_13_0:getUserDataTb_()
			var_13_2.go = gohelper.cloneInPlace(arg_13_0._goresultitem, "item" .. iter_13_0)
			var_13_2.index = iter_13_0
			var_13_2.btnopen = gohelper.findChildButtonWithAudio(var_13_2.go, "btn_open")

			var_13_2.btnopen:AddClickListener(arg_13_0.onClickItem, arg_13_0, var_13_2)
			table.insert(arg_13_0._resultitems, var_13_2)
		end

		local var_13_3 = var_13_0[iter_13_0]

		if var_13_3 then
			local var_13_4 = gohelper.findChild(var_13_3, "btn/btnTopLeft")
			local var_13_5 = gohelper.findChild(var_13_3, "btn/btnBottomRight")
			local var_13_6 = recthelper.worldPosToAnchorPos(var_13_4.transform.position, arg_13_0.viewGO.transform)
			local var_13_7 = recthelper.worldPosToAnchorPos(var_13_5.transform.position, arg_13_0.viewGO.transform)

			recthelper.setAnchor(var_13_2.go.transform, (var_13_6.x + var_13_7.x) / 2, (var_13_6.y + var_13_7.y) / 2)
			recthelper.setHeight(var_13_2.go.transform, math.abs(var_13_6.y - var_13_7.y))
			recthelper.setWidth(var_13_2.go.transform, math.abs(var_13_7.x - var_13_6.x))
		end

		gohelper.setActive(var_13_2.btnopen.gameObject, true)
		gohelper.setActive(var_13_2.go, true)
	end

	for iter_13_1 = #arg_13_0.summonResult + 1, #arg_13_0._resultitems do
		gohelper.setActive(arg_13_0._resultitems[iter_13_1].go, false)
	end
end

function var_0_0.onClickItem(arg_14_0, arg_14_1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_click)
	arg_14_0:openSummonResult(arg_14_1.index)
	SummonController.instance:nextSummonPopupParam()
end

function var_0_0.openSummonResult(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0, var_15_1 = SummonModel.instance:openSummonEquipResult(arg_15_1)
	local var_15_2 = arg_15_0.summonResult
	local var_15_3 = #var_15_2 >= 10

	if var_15_0 then
		local var_15_4 = var_15_0.equipId
		local var_15_5 = EquipConfig.instance:getEquipCo(var_15_4)

		if not arg_15_2 then
			logNormal(string.format("获得心相:%s", var_15_5.name))
		end

		if arg_15_0._resultitems[arg_15_1] then
			gohelper.setActive(arg_15_0._resultitems[arg_15_1].btnopen.gameObject, false)
		end

		if not var_15_3 or not arg_15_2 or var_15_5.rare >= 5 then
			table.insert(arg_15_0._waitEffectList, {
				index = arg_15_1,
				equipId = var_15_4
			})
			SummonController.instance:insertSummonPopupList(PopupEnum.PriorityType.GainCharacterView, ViewName.SummonEquipGainView, {
				equipId = var_15_4,
				summonResultMo = var_15_0,
				isSummonTen = var_15_3
			})
		elseif not arg_15_2 then
			local var_15_6 = arg_15_0._summonUIEffects[arg_15_1]

			var_15_6:setEquipFrame(true)
			var_15_6:loadEquipIcon(var_15_4)
		else
			table.insert(arg_15_0._waitNormalEffectList, {
				index = arg_15_1,
				equipId = var_15_4
			})
		end

		if SummonModel.instance:isAllOpened() then
			gohelper.setActive(arg_15_0._btnopenall.gameObject, false)

			if not var_15_3 then
				gohelper.setActive(arg_15_0._btnreturn.gameObject, true)
			else
				local var_15_7 = SummonController.instance:getLastPoolId()

				if not var_15_7 then
					return
				end

				local var_15_8 = SummonConfig.instance:getSummonPool(var_15_7)

				if not var_15_8 then
					return
				end

				SummonController.instance:insertSummonPopupList(PopupEnum.PriorityType.SummonResultView, ViewName.SummonResultView, {
					summonResultList = var_15_2,
					curPool = var_15_8
				})
			end
		end
	end
end

function var_0_0._refreshIcons(arg_16_0)
	if (not arg_16_0._waitEffectList or #arg_16_0._waitEffectList <= 1) and arg_16_0._waitNormalEffectList and #arg_16_0._waitNormalEffectList > 0 then
		for iter_16_0, iter_16_1 in ipairs(arg_16_0._waitNormalEffectList) do
			local var_16_0 = iter_16_1.index
			local var_16_1 = iter_16_1.equipId
			local var_16_2 = arg_16_0._summonUIEffects[var_16_0]

			if var_16_2 then
				var_16_2:setEquipFrame(true)
				var_16_2:loadEquipIcon(var_16_1)
			end
		end
	end

	if not arg_16_0._waitEffectList or #arg_16_0._waitEffectList <= 0 then
		return
	end

	local var_16_3 = arg_16_0._waitEffectList[1]

	table.remove(arg_16_0._waitEffectList, 1)

	local var_16_4 = var_16_3.index
	local var_16_5 = var_16_3.equipId
	local var_16_6 = arg_16_0._summonUIEffects[var_16_4]

	if not var_16_6 then
		return
	end

	var_16_6:setEquipFrame(true)
	var_16_6:loadEquipIcon(var_16_5)
end

function var_0_0.handleCloseView(arg_17_0, arg_17_1)
	if arg_17_1 == ViewName.SummonEquipGainView then
		arg_17_0:_refreshIcons()
	end
end

function var_0_0.handleOpenView(arg_18_0, arg_18_1)
	if arg_18_1 == ViewName.SummonResultView then
		arg_18_0:_refreshIcons()
	end
end

function var_0_0.recycleEffect(arg_19_0)
	if arg_19_0._summonUIEffects then
		for iter_19_0 = 1, #arg_19_0._summonUIEffects do
			local var_19_0 = arg_19_0._summonUIEffects[iter_19_0]

			SummonEffectPool.returnEffect(var_19_0)

			arg_19_0._summonUIEffects[iter_19_0] = nil
		end
	end
end

function var_0_0.onDestroyView(arg_20_0)
	for iter_20_0 = 1, #arg_20_0._resultitems do
		arg_20_0._resultitems[iter_20_0].btnopen:RemoveClickListener()
	end
end

return var_0_0
