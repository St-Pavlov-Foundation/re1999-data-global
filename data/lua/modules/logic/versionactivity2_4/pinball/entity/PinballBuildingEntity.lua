module("modules.logic.versionactivity2_4.pinball.entity.PinballBuildingEntity", package.seeall)

local var_0_0 = class("PinballBuildingEntity", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.trans = arg_1_1.transform
	arg_1_0._effect = gohelper.create3d(arg_1_1, "effect")

	gohelper.setActive(arg_1_0._effect, false)
	PrefabInstantiate.Create(arg_1_0._effect):startLoad("scenes/v2a4_m_s12_ttsz_jshd/prefab/vx_building.prefab")
end

function var_0_0.initCo(arg_2_0, arg_2_1)
	arg_2_0.co = arg_2_1

	local var_2_0 = string.splitToNumber(arg_2_0.co.pos, "#") or {}

	transformhelper.setLocalPosXY(arg_2_0.trans, var_2_0[1] or 0, var_2_0[2] or 0)
	arg_2_0:checkLoadRes(true)
end

function var_0_0.setUI(arg_3_0, arg_3_1)
	arg_3_0.ui = arg_3_1

	local var_3_0 = CameraMgr.instance:getMainCamera()
	local var_3_1 = CameraMgr.instance:getUICamera()
	local var_3_2 = ViewMgr.instance:getUIRoot().transform

	arg_3_0._uiFollower = gohelper.onceAddComponent(arg_3_1, typeof(ZProj.UIFollower))

	arg_3_0._uiFollower:Set(var_3_0, var_3_1, var_3_2, arg_3_0.trans, 0, 0, 0, 0, 0)
	arg_3_0._uiFollower:SetEnable(true)

	arg_3_0._gonormal = gohelper.findChild(arg_3_1, "#go_normal")
	arg_3_0._gomain = gohelper.findChild(arg_3_1, "#go_main")
	arg_3_0._goopers = gohelper.findChild(arg_3_1, "#go_opers")
	arg_3_0._gocanupgrade = gohelper.findChild(arg_3_1, "#go_normal/#go_arrow")
	arg_3_0._gocanupgrade2 = gohelper.findChild(arg_3_1, "#go_opers/#btn_upgrade/go_reddot")
	arg_3_0._gotalentred = gohelper.findChild(arg_3_1, "#go_opers/#btn_talent/go_reddot")
	arg_3_0._btnRemove = gohelper.findChildButtonWithAudio(arg_3_1, "#go_opers/#btn_remove")
	arg_3_0._btnUpgrade = gohelper.findChildButtonWithAudio(arg_3_1, "#go_opers/#btn_upgrade")
	arg_3_0._btnUpgradeMax = gohelper.findChildButtonWithAudio(arg_3_1, "#go_opers/#btn_check")
	arg_3_0._btnTalent = gohelper.findChildButtonWithAudio(arg_3_1, "#go_opers/#btn_talent")
	arg_3_0._btnClickThis = gohelper.findChildButtonWithAudio(arg_3_1, "")
	arg_3_0._gooperbigbg = gohelper.findChild(arg_3_1, "#go_opers/circle_big")
	arg_3_0._goopersmallbg = gohelper.findChild(arg_3_1, "#go_opers/circle_small")
	arg_3_0._normalLv = gohelper.findChildTextMesh(arg_3_1, "#go_normal/#txt_lv")
	arg_3_0._mainCityLv = gohelper.findChildTextMesh(arg_3_1, "#go_main/#txt_lv")
	arg_3_0._mainCityNum = gohelper.findChildTextMesh(arg_3_1, "#go_main/#txt_num")
	arg_3_0._mainCitySlider0 = gohelper.findChildImage(arg_3_1, "#go_main/#go_slider/#go_slider0")
	arg_3_0._mainCitySlider1 = gohelper.findChildImage(arg_3_1, "#go_main/#go_slider/#go_slider1")
	arg_3_0._mainCitySlider2 = gohelper.findChildImage(arg_3_1, "#go_main/#go_slider/#go_slider2")
	arg_3_0._mainCitySlider3 = gohelper.findChildImage(arg_3_1, "#go_main/#go_slider/#go_slider3")
	arg_3_0._mainCitySlider4 = gohelper.findChildImage(arg_3_1, "#go_main/#go_slider/#go_slider4")
	arg_3_0._goFood = gohelper.findChildAnim(arg_3_1, "#go_food")
	arg_3_0._txtFoodNum = gohelper.findChildTextMesh(arg_3_1, "#go_food/#txt_num")
	arg_3_0._goDialog = gohelper.findChild(arg_3_1, "#go_dialog")
	arg_3_0._txtunlock = gohelper.findChildTextMesh(arg_3_1, "#txt_unlock")

	arg_3_0:addClickCb(arg_3_0._btnRemove, arg_3_0._onRemoveClick, arg_3_0)
	arg_3_0:addClickCb(arg_3_0._btnUpgrade, arg_3_0._onUpgradeClick, arg_3_0)
	arg_3_0:addClickCb(arg_3_0._btnUpgradeMax, arg_3_0._onUpgradeClick, arg_3_0)
	arg_3_0:addClickCb(arg_3_0._btnTalent, arg_3_0._onTalentClick, arg_3_0)
	arg_3_0:addClickCb(arg_3_0._btnClickThis, arg_3_0._guideClick, arg_3_0)
	gohelper.setActive(arg_3_0._gooperbigbg, arg_3_0.co.size == 4)
	gohelper.setActive(arg_3_0._goopersmallbg, arg_3_0.co.size == 1)
	recthelper.setAnchorY(arg_3_0._txtunlock.transform, arg_3_0.co.size == 1 and -50 or -78)
	arg_3_0:_refreshUI()
	arg_3_0:_onTalentRedChange()
end

function var_0_0._guideClick(arg_4_0)
	local var_4_0 = arg_4_0:_realClick()

	if var_4_0 then
		PinballController.instance:dispatchEvent(PinballEvent.OnClickBuilding, var_4_0)
	end
end

function var_0_0.setUIScale(arg_5_0, arg_5_1)
	transformhelper.setLocalScale(arg_5_0.ui.transform, arg_5_1, arg_5_1, arg_5_1)
end

function var_0_0.addEventListeners(arg_6_0)
	PinballController.instance:registerCallback(PinballEvent.OnClickBuilding, arg_6_0._onClickBuilding, arg_6_0)
	PinballController.instance:registerCallback(PinballEvent.AddBuilding, arg_6_0._buildingUpdate, arg_6_0)
	PinballController.instance:registerCallback(PinballEvent.UpgradeBuilding, arg_6_0._buildingUpdate, arg_6_0)
	PinballController.instance:registerCallback(PinballEvent.RemoveBuilding, arg_6_0._buildingUpdate, arg_6_0)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, arg_6_0._refreshMainCityUI, arg_6_0)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, arg_6_0._refreshCanUpgrade, arg_6_0)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, arg_6_0._refreshHoleLock, arg_6_0)
	PinballController.instance:registerCallback(PinballEvent.EndRound, arg_6_0._refreshUI, arg_6_0)
	PinballController.instance:registerCallback(PinballEvent.GetReward, arg_6_0._onGetReward, arg_6_0)
	PinballController.instance:registerCallback(PinballEvent.TalentRedChange, arg_6_0._onTalentRedChange, arg_6_0)
end

function var_0_0.removeEventListeners(arg_7_0)
	PinballController.instance:unregisterCallback(PinballEvent.OnClickBuilding, arg_7_0._onClickBuilding, arg_7_0)
	PinballController.instance:unregisterCallback(PinballEvent.AddBuilding, arg_7_0._buildingUpdate, arg_7_0)
	PinballController.instance:unregisterCallback(PinballEvent.UpgradeBuilding, arg_7_0._buildingUpdate, arg_7_0)
	PinballController.instance:unregisterCallback(PinballEvent.RemoveBuilding, arg_7_0._buildingUpdate, arg_7_0)
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, arg_7_0._refreshMainCityUI, arg_7_0)
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, arg_7_0._refreshCanUpgrade, arg_7_0)
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, arg_7_0._refreshHoleLock, arg_7_0)
	PinballController.instance:unregisterCallback(PinballEvent.EndRound, arg_7_0._refreshUI, arg_7_0)
	PinballController.instance:unregisterCallback(PinballEvent.GetReward, arg_7_0._onGetReward, arg_7_0)
	PinballController.instance:unregisterCallback(PinballEvent.TalentRedChange, arg_7_0._onTalentRedChange, arg_7_0)
end

function var_0_0._buildingUpdate(arg_8_0, arg_8_1)
	if arg_8_1 ~= arg_8_0.co.index then
		return
	end

	arg_8_0:_refreshUI()
	arg_8_0:checkLoadRes()
end

function var_0_0._refreshUI(arg_9_0)
	gohelper.setActive(arg_9_0._gomain, arg_9_0:isMainCity())
	gohelper.setActive(arg_9_0._gonormal, not arg_9_0:isEmpty() and not arg_9_0:isMainCity())
	gohelper.setActive(arg_9_0._btnTalent, arg_9_0:isTalent())
	gohelper.setActive(arg_9_0._goopers, false)

	local var_9_0 = arg_9_0:getInfo()

	if var_9_0 then
		if arg_9_0:isMainCity() then
			arg_9_0:_refreshMainCityUI()
		else
			arg_9_0._normalLv.text = var_9_0.level
		end

		local var_9_1 = var_9_0.baseCo.uiOffset
		local var_9_2 = GameUtil.splitString2(var_9_1, true) or {}

		recthelper.setAnchor(arg_9_0._gonormal.transform, var_9_2[1][1], var_9_2[1][2])
		recthelper.setAnchor(arg_9_0._goopers.transform, var_9_2[2][1], var_9_2[2][2])
		recthelper.setAnchor(arg_9_0._goFood.transform, var_9_2[3][1], var_9_2[3][2])
		recthelper.setAnchor(arg_9_0._goDialog.transform, var_9_2[3][1], var_9_2[3][2])
		gohelper.setActive(arg_9_0._btnRemove, var_9_0.co.destory)
		gohelper.setActive(arg_9_0._goFood, var_9_0.food > 0)
		gohelper.setActive(arg_9_0._goDialog, var_9_0.interact > 0)
		gohelper.setActive(arg_9_0._btnUpgrade, var_9_0.nextCo)
		gohelper.setActive(arg_9_0._btnUpgradeMax, not var_9_0.nextCo)

		if var_9_0.food > 0 then
			arg_9_0._txtFoodNum.text = var_9_0.food
		end
	else
		gohelper.setActive(arg_9_0._btnRemove, false)
		gohelper.setActive(arg_9_0._goFood, false)
		gohelper.setActive(arg_9_0._goDialog, false)
	end

	arg_9_0:_refreshCanUpgrade()
	arg_9_0:_refreshHoleLock()
end

function var_0_0._refreshCanUpgrade(arg_10_0)
	local var_10_0 = true
	local var_10_1 = arg_10_0:getInfo()
	local var_10_2 = var_10_1 and var_10_1.nextCo

	if var_10_2 then
		local var_10_3 = var_10_2.condition

		if not string.nilorempty(var_10_3) then
			local var_10_4 = GameUtil.splitString2(var_10_3, true)

			for iter_10_0, iter_10_1 in pairs(var_10_4) do
				local var_10_5 = iter_10_1[1]

				if var_10_5 == PinballEnum.ConditionType.Talent then
					local var_10_6 = iter_10_1[2]

					if not PinballModel.instance:getTalentMo(var_10_6) then
						var_10_0 = false

						break
					end
				elseif var_10_5 == PinballEnum.ConditionType.Score and iter_10_1[2] > PinballModel.instance.maxProsperity then
					var_10_0 = false

					break
				end
			end
		end

		if var_10_0 then
			local var_10_7 = var_10_2.cost

			if not string.nilorempty(var_10_7) then
				local var_10_8 = GameUtil.splitString2(var_10_7, true)

				for iter_10_2, iter_10_3 in pairs(var_10_8) do
					if iter_10_3[2] > PinballModel.instance:getResNum(iter_10_3[1]) then
						var_10_0 = false

						break
					end
				end
			end
		end
	else
		var_10_0 = false
	end

	gohelper.setActive(arg_10_0._gocanupgrade, var_10_0)
	gohelper.setActive(arg_10_0._gocanupgrade2, var_10_0)
end

function var_0_0._onTalentRedChange(arg_11_0)
	if not arg_11_0:isTalent() then
		return
	end

	gohelper.setActive(arg_11_0._gotalentred, PinballModel.instance:getTalentRed(arg_11_0:getInfo().baseCo.id))
end

function var_0_0._refreshHoleLock(arg_12_0)
	local var_12_0

	if arg_12_0:isEmpty() then
		local var_12_1 = arg_12_0.co.condition

		if var_12_1 > PinballModel.instance.maxProsperity then
			var_12_0 = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, var_12_1)
		end
	end

	gohelper.setActive(arg_12_0._txtunlock, var_12_0)

	if var_12_0 then
		arg_12_0._txtunlock.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("pinball_unlock"), var_12_0)
	end

	if arg_12_0:isEmpty() then
		arg_12_0:checkLoadRes(true)
	end
end

function var_0_0.getEmptyPath(arg_13_0)
	local var_13_0

	return arg_13_0.co.condition > PinballModel.instance.maxProsperity and (arg_13_0.co.size == 1 and "scenes/v2a4_m_s12_ttsz_jshd/prefab/img_jianzaodikuai_3.prefab" or "scenes/v2a4_m_s12_ttsz_jshd/prefab/img_jianzaodikuai_4.prefab") or arg_13_0.co.size == 1 and "scenes/v2a4_m_s12_ttsz_jshd/prefab/img_jianzaodikuai_1.prefab" or "scenes/v2a4_m_s12_ttsz_jshd/prefab/img_jianzaodikuai_2.prefab"
end

function var_0_0._refreshMainCityUI(arg_14_0)
	local var_14_0, var_14_1, var_14_2 = PinballModel.instance:getScoreLevel()
	local var_14_3, var_14_4 = PinballModel.instance:getResNum(PinballEnum.ResType.Score)

	arg_14_0._mainCityLv.text = var_14_0

	local var_14_5 = 0
	local var_14_6 = 0
	local var_14_7 = 0

	if var_14_4 == var_14_3 then
		arg_14_0._mainCityNum.text = string.format("%d/%d", var_14_3, var_14_2)

		if var_14_2 == var_14_1 then
			var_14_6 = 1
		else
			var_14_6 = (var_14_3 - var_14_1) / (var_14_2 - var_14_1)
		end
	else
		arg_14_0._mainCityNum.text = string.format("%d<color=%s>(%+d)</color>/%d", var_14_3, var_14_3 < var_14_4 and "#BCFF85" or "#FC8A6A", var_14_4 - var_14_3, var_14_2)

		if var_14_3 < var_14_4 then
			if var_14_2 == var_14_1 then
				var_14_6 = 1
			else
				var_14_5 = (var_14_4 - var_14_1) / (var_14_2 - var_14_1)
				var_14_6 = (var_14_3 - var_14_1) / (var_14_2 - var_14_1)

				if var_14_2 < var_14_4 then
					local var_14_8, var_14_9, var_14_10 = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, var_14_4)

					var_14_7 = (var_14_4 - var_14_9) / (var_14_10 - var_14_9)
				end
			end
		elseif var_14_1 <= var_14_4 then
			var_14_5 = (var_14_3 - var_14_1) / (var_14_2 - var_14_1)
			var_14_6 = (var_14_4 - var_14_1) / (var_14_2 - var_14_1)
		else
			local var_14_11, var_14_12, var_14_13 = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, var_14_4)

			var_14_5 = 1
			var_14_6 = (var_14_4 - var_14_12) / (var_14_13 - var_14_12)
			var_14_7 = (var_14_3 - var_14_1) / (var_14_2 - var_14_1)
		end
	end

	arg_14_0._mainCitySlider0.fillAmount = var_14_5
	arg_14_0._mainCitySlider1.fillAmount = var_14_5
	arg_14_0._mainCitySlider2.fillAmount = var_14_6
	arg_14_0._mainCitySlider3.fillAmount = var_14_7
	arg_14_0._mainCitySlider4.fillAmount = var_14_7

	gohelper.setActive(arg_14_0._mainCitySlider0, var_14_4 < var_14_3)
	gohelper.setActive(arg_14_0._mainCitySlider4, var_14_4 < var_14_3)
	gohelper.setActive(arg_14_0._mainCitySlider1, var_14_3 < var_14_4)
	gohelper.setActive(arg_14_0._mainCitySlider3, var_14_3 < var_14_4)
end

function var_0_0.checkLoadRes(arg_15_0, arg_15_1)
	local var_15_0 = PrefabInstantiate.Create(arg_15_0.go)
	local var_15_1 = ""

	if not arg_15_0:isEmpty() then
		var_15_1 = string.format("scenes/v2a4_m_s12_ttsz_jshd/prefab/%s.prefab", arg_15_0:getInfo().baseCo.res)
	else
		var_15_1 = arg_15_0:getEmptyPath()
	end

	if var_15_0:getPath() == var_15_1 then
		return
	end

	var_15_0:dispose()
	var_15_0:startLoad(var_15_1)

	if not arg_15_0:isEmpty() and not arg_15_1 then
		gohelper.setActive(arg_15_0._effect, false)
		gohelper.setActive(arg_15_0._effect, true)
		TaskDispatcher.cancelTask(arg_15_0._hideEffect, arg_15_0)
		TaskDispatcher.runDelay(arg_15_0._hideEffect, arg_15_0, 3)
		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio4)

		PinballModel.instance.guideHole = arg_15_0.co.index

		if arg_15_0:isTalent() then
			PinballController.instance:dispatchEvent(PinballEvent.GuideBuildTalent)
		else
			PinballController.instance:dispatchEvent(PinballEvent.GuideBuildHouse)
		end
	end
end

function var_0_0._hideEffect(arg_16_0)
	gohelper.setActive(arg_16_0._effect, false)
end

function var_0_0._onClickBuilding(arg_17_0, arg_17_1)
	gohelper.setActive(arg_17_0._goopers, arg_17_1 == arg_17_0.co.index)

	if arg_17_1 == arg_17_0.co.index then
		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio2)
	end
end

function var_0_0.isMainCity(arg_18_0)
	local var_18_0 = arg_18_0:getInfo()

	return var_18_0 and var_18_0:isMainCity()
end

function var_0_0.isTalent(arg_19_0)
	local var_19_0 = arg_19_0:getInfo()

	return var_19_0 and var_19_0:isTalent()
end

function var_0_0.isEmpty(arg_20_0)
	return not arg_20_0:getInfo()
end

function var_0_0._onRemoveClick(arg_21_0)
	PinballController.instance:removeBuilding(arg_21_0.co.index)
end

function var_0_0._onUpgradeClick(arg_22_0)
	ViewMgr.instance:openView(ViewName.PinballUpgradeView, {
		index = arg_22_0.co.index
	})
end

function var_0_0._onTalentClick(arg_23_0)
	if not arg_23_0:getInfo() then
		return
	end

	ViewMgr.instance:openView(ViewName.PinballTalentView, {
		index = arg_23_0.co.index,
		info = arg_23_0:getInfo()
	})
end

function var_0_0._onFoodClick(arg_24_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	Activity178Rpc.instance:sendAct178GetReward(VersionActivity2_4Enum.ActivityId.Pinball, 0)
end

function var_0_0._onGetReward(arg_25_0, arg_25_1)
	if arg_25_1 == 0 or arg_25_1 == arg_25_0.co.index then
		arg_25_0._goFood:Play("click", 0, 0)
		TaskDispatcher.cancelTask(arg_25_0._refreshUI, arg_25_0)
		TaskDispatcher.runDelay(arg_25_0._refreshUI, arg_25_0, 1.167)
	end
end

function var_0_0._onDialogClick(arg_26_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	Activity178Rpc.instance:sendAct178Interact(VersionActivity2_4Enum.ActivityId.Pinball, arg_26_0.co.index, arg_26_0.triggerDialog, arg_26_0)
end

function var_0_0.triggerDialog(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if arg_27_2 ~= 0 then
		return
	end

	local var_27_0 = arg_27_0:getInfo()

	if not var_27_0 then
		return
	end

	TipDialogController.instance:openTipDialogView(var_27_0.interact)

	var_27_0.interact = 0

	arg_27_0:_refreshUI()
end

function var_0_0.getInfo(arg_28_0)
	return PinballModel.instance:getBuildingInfo(arg_28_0.co.index)
end

function var_0_0.tryClick(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0.trans.position - arg_29_1
	local var_29_1 = 2

	if arg_29_0.co.size == 4 then
		var_29_1 = 4
	end

	local var_29_2 = var_29_1 * arg_29_2

	if var_29_2 > math.abs(var_29_0.x) and var_29_2 > math.abs(var_29_0.y) then
		return arg_29_0:_realClick()
	end
end

function var_0_0._realClick(arg_30_0)
	local var_30_0 = arg_30_0:getInfo()

	if arg_30_0:isMainCity() then
		if var_30_0.interact > 0 then
			arg_30_0:_onDialogClick()
		end

		return
	end

	if arg_30_0:isEmpty() then
		local var_30_1 = arg_30_0.co.condition

		if var_30_1 > PinballModel.instance.maxProsperity then
			local var_30_2 = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, var_30_1)

			GameFacade.showToast(ToastEnum.Act178ScoreCondition, var_30_2)

			return
		end

		ViewMgr.instance:openView(ViewName.PinballBuildView, {
			index = arg_30_0.co.index,
			size = arg_30_0.co.size
		})
	else
		local var_30_3

		if var_30_0.food > 0 then
			arg_30_0:_onFoodClick()
		elseif var_30_0.interact > 0 then
			arg_30_0:_onDialogClick()
		elseif not arg_30_0._goopers.activeSelf then
			var_30_3 = arg_30_0.co.index
		end

		return var_30_3
	end
end

function var_0_0.onDestroy(arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0._hideEffect, arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0._refreshUI, arg_31_0)
end

return var_0_0
