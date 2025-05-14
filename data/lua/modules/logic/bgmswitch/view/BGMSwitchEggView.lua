module("modules.logic.bgmswitch.view.BGMSwitchEggView", package.seeall)

local var_0_0 = class("BGMSwitchEggView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gointerface = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#go_interference")
	arg_1_0._btnbeatmechine = gohelper.findChildButton(arg_1_0.viewGO, "#go_mechine/#btn_beatmechine")
	arg_1_0._slidercontrol = gohelper.findChildSlider(arg_1_0.viewGO, "#go_mechine/#slider_control")
	arg_1_0._txtNum1 = gohelper.findChildText(arg_1_0.viewGO, "#go_mechine/#slider_control/Fill Area/#txt_Num1")
	arg_1_0._txtNum2 = gohelper.findChildText(arg_1_0.viewGO, "#go_mechine/#slider_control/Fill Area/#txt_Num2")
	arg_1_0._txtNum3 = gohelper.findChildText(arg_1_0.viewGO, "#go_mechine/#slider_control/Fill Area/#txt_Num3")
	arg_1_0._txtNum4 = gohelper.findChildText(arg_1_0.viewGO, "#go_mechine/#slider_control/Fill Area/#txt_Num4")
	arg_1_0._txtNum5 = gohelper.findChildText(arg_1_0.viewGO, "#go_mechine/#slider_control/Fill Area/#txt_Num5")
	arg_1_0._txtNum6 = gohelper.findChildText(arg_1_0.viewGO, "#go_mechine/#slider_control/Fill Area/#txt_Num6")
	arg_1_0._txtNum7 = gohelper.findChildText(arg_1_0.viewGO, "#go_mechine/#slider_control/Fill Area/#txt_Num7")
	arg_1_0._goppt = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#go_ppt")
	arg_1_0._controlHandleAni = gohelper.findChild(arg_1_0._slidercontrol.gameObject, "Handle"):GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._pptAni = arg_1_0._goppt:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._viewAni = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._simagepptpic1 = gohelper.findChildSingleImage(arg_1_0._goppt, "#simage_pic1")
	arg_1_0._simagepptpic2 = gohelper.findChildSingleImage(arg_1_0._goppt, "#simage_pic2")
	arg_1_0._imagepptpic1 = gohelper.findChildImage(arg_1_0._goppt, "#simage_pic1")
	arg_1_0._imagepptpic2 = gohelper.findChildImage(arg_1_0._goppt, "#simage_pic2")
	arg_1_0._egg2Items = {}

	for iter_1_0 = 1, 4 do
		if not arg_1_0._egg2Items[iter_1_0] then
			arg_1_0._egg2Items[iter_1_0] = {}
		end

		arg_1_0._egg2Items[iter_1_0].go = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#btn_control/btn0" .. tostring(iter_1_0))
		arg_1_0._egg2Items[iter_1_0].btn = gohelper.findChildButton(arg_1_0.viewGO, "#go_mechine/#btn_control/btn0" .. tostring(iter_1_0))

		arg_1_0._egg2Items[iter_1_0].btn:AddClickListener(arg_1_0._egg2itemBtnOnclick, arg_1_0, iter_1_0)

		arg_1_0._egg2Items[iter_1_0].goup = gohelper.findChild(arg_1_0._egg2Items[iter_1_0].go, "up")
		arg_1_0._egg2Items[iter_1_0].godown = gohelper.findChild(arg_1_0._egg2Items[iter_1_0].go, "down")
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbeatmechine:AddClickListener(arg_2_0._btnbeatmechineOnClick, arg_2_0)
	arg_2_0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.SelectPlayGear, arg_2_0._onSelectPlayGear, arg_2_0)
	arg_2_0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.RandomFinished, arg_2_0._refreshBottomEggBtns, arg_2_0)
	arg_2_0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.ItemSelected, arg_2_0._onBgmItemSelected, arg_2_0)
	arg_2_0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmSwitched, arg_2_0._onBgmSwitched, arg_2_0)
	arg_2_0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmFavorite, arg_2_0._onBgmSwitched, arg_2_0)
	arg_2_0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.PlayShakingAni, arg_2_0._playShakingAniByGuide, arg_2_0)
	arg_2_0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.SlideValueUpdate, arg_2_0._sliderValueUpdate, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbeatmechine:RemoveClickListener()
	arg_3_0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.SelectPlayGear, arg_3_0._onSelectPlayGear, arg_3_0)
	arg_3_0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.RandomFinished, arg_3_0._refreshBottomEggBtns, arg_3_0)
	arg_3_0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.ItemSelected, arg_3_0._onBgmItemSelected, arg_3_0)
	arg_3_0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmSwitched, arg_3_0._onBgmSwitched, arg_3_0)
	arg_3_0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmFavorite, arg_3_0._onBgmSwitched, arg_3_0)
	arg_3_0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.PlayShakingAni, arg_3_0._playShakingAniByGuide, arg_3_0)
	arg_3_0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.SlideValueUpdate, arg_3_0._sliderValueUpdate, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._refreshBottomEggBtns, arg_3_0)
end

function var_0_0._onSliderValueChanged(arg_4_0, arg_4_1)
	arg_4_0.selectIndex = arg_4_1
end

function var_0_0.onOpen(arg_5_0)
	gohelper.setActive(arg_5_0._gointerface, false)
	arg_5_0:checkTrigger()

	if not BGMSwitchModel.instance:getEggHideState() then
		arg_5_0:_startCheckEasterEgg()
	end

	BGMSwitchModel.instance:setEggHideState(false)
	arg_5_0:_updateEggBtnsAndShowPpt()
end

function var_0_0._onBgmSwitched(arg_6_0)
	arg_6_0:_onBgmItemSelected(BGMSwitchModel.instance:getCurBgm())
end

function var_0_0._sliderValueUpdate(arg_7_0)
	if not BGMSwitchModel.instance:getEggIsTrigger() then
		return
	end

	arg_7_0:_checkAndShowPpt()
end

function var_0_0._onSelectPlayGear(arg_8_0)
	arg_8_0:checkTrigger()
	arg_8_0:_hideEasterEggType1()
	arg_8_0:_updateEggBtnsAndShowPpt()
end

function var_0_0.checkTrigger(arg_9_0)
	if BGMSwitchModel.instance:getEggIsTrigger() then
		for iter_9_0 = 1, 4 do
			BGMSwitchModel.instance:setEggType2State(iter_9_0, false)
		end

		BGMSwitchModel.instance:setEggIsTrigger(false)
		BGMSwitchModel.instance:setPPtEffectEgg2Id(nil)
		arg_9_0._controlHandleAni:Play("flashing", 0, 1)
	end
end

function var_0_0._updateEggBtnsAndShowPpt(arg_10_0)
	if BGMSwitchModel.instance:getMechineGear() == BGMSwitchEnum.Gear.OFF then
		arg_10_0._controlHandleAni:Play("flashing", 0, 1)
	else
		arg_10_0:_startCheckEasterEgg()
	end

	arg_10_0:_checkAndShowPpt()
	arg_10_0:_refreshBottomEggBtns()
end

function var_0_0._onBgmItemSelected(arg_11_0, arg_11_1)
	if BGMSwitchModel.instance:getMechineGear() ~= BGMSwitchEnum.Gear.On1 then
		return
	end

	local var_11_0 = BGMSwitchModel.instance:getCurBgm()

	if BGMSwitchModel.instance:isValidBgmId(var_11_0) then
		TaskDispatcher.runDelay(arg_11_0._refreshBottomEggBtns, arg_11_0, 0.67)
	else
		arg_11_0:_refreshBottomEggBtns()
	end
end

function var_0_0._egg2itemBtnOnclick(arg_12_0, arg_12_1)
	if BGMSwitchModel.instance:getEggIsTrigger() and arg_12_0:_isHaveEggShowConfig(BGMSwitchModel.instance:getPPtEffectEgg2Id()) then
		GameFacade.showToast(ToastEnum.KeepStableNoEggControl)

		return
	end

	if BGMSwitchModel.instance:getMechineGear() ~= BGMSwitchEnum.Gear.OFF then
		arg_12_0._controlHandleAni:Play("flashing", 0, 0)
	end

	local var_12_0 = BGMSwitchModel.instance:getEggType2SateByIndex(arg_12_1)

	BGMSwitchModel.instance:setEggType2State(arg_12_1, not var_12_0)
	arg_12_0:_refreshBottomEggBtns()
	arg_12_0:_startCheckEasterEggType2()
	BGMSwitchAudioTrigger.play_ui_replay_buttonegg()
end

function var_0_0._btnbeatmechineOnClick(arg_13_0)
	BGMSwitchAudioTrigger.play_ui_replay_flap()

	if not arg_13_0._beatTime then
		arg_13_0._beatTime = 0
	end

	arg_13_0._beatTime = arg_13_0._beatTime + 1

	arg_13_0._viewAni:Play("shaking", 0, 0)

	local var_13_0 = BGMSwitchConfig.instance:getBgmEasterEggCo(arg_13_0._eggType1Id)

	if arg_13_0._beatTime >= tonumber(var_13_0.param2) then
		if not arg_13_0._triggerEggType1Id or arg_13_0._triggerEggType1Id == 0 then
			if GuideModel.instance:isGuideRunning(BGMSwitchEnum.BGMGuideId) then
				return
			end

			arg_13_0._beatTime = 0

			local var_13_1 = BGMSwitchModel.instance:getMechineGear()

			if var_13_1 == BGMSwitchEnum.Gear.OFF then
				GameFacade.showToast(ToastEnum.MachineNoRun)
			end

			if var_13_1 == BGMSwitchEnum.Gear.On1 or BGMSwitchModel.instance:getEggIsTrigger() then
				GameFacade.showToast(ToastEnum.MachineIsOkNoBeat)
			end

			if BGMSwitchModel.instance:machineGearIsInSnowflakeScene() and not BGMSwitchModel.instance:getEggIsTrigger() then
				GameFacade.showToast(ToastEnum.MachineNotShowView)
			end
		else
			arg_13_0:_hideEasterEggType1()
		end
	end
end

function var_0_0._startCheckEasterEgg(arg_14_0)
	local var_14_0 = BGMSwitchModel.instance:getMechineGear()
	local var_14_1 = BGMSwitchConfig.instance:getBgmEasterEggCos()

	for iter_14_0, iter_14_1 in pairs(var_14_1) do
		if iter_14_1.type == BGMSwitchEnum.EasterEggType.Beat then
			arg_14_0._eggType1Id = iter_14_1.id

			if var_14_0 ~= BGMSwitchEnum.Gear.OFF and BGMSwitchModel.instance:getPPtEffectEgg2Id() == nil then
				arg_14_0:_startCheckEasterEggType1(iter_14_1.id)
			end
		elseif iter_14_1.type == BGMSwitchEnum.EasterEggType.Ppt and var_14_0 ~= BGMSwitchEnum.Gear.OFF and arg_14_0._triggerEggType1Id == nil then
			arg_14_0:_startCheckEasterEggType2(iter_14_1.id)
		end
	end
end

function var_0_0._startCheckEasterEggType1(arg_15_0, arg_15_1)
	local var_15_0 = BGMSwitchConfig.instance:getBgmEasterEggCo(arg_15_1)
	local var_15_1 = math.random(1, 1000)

	if arg_15_0._lasttriggerEggType1Id then
		arg_15_0._lasttriggerEggType1Id = nil

		return
	end

	if var_15_1 < tonumber(var_15_0.param1) and arg_15_0:needCheckRandomNum() then
		arg_15_0._triggerEggType1Id = arg_15_1
		arg_15_0._lasttriggerEggType1Id = arg_15_1

		arg_15_0:_showEasterEggType1()
	end
end

function var_0_0.needCheckRandomNum(arg_16_0)
	return arg_16_0._lasttriggerEggType1Id == nil
end

function var_0_0._showEasterEggType1(arg_17_0)
	arg_17_0._beatTime = 0

	gohelper.setActive(arg_17_0._gointerface, true)

	if GuideModel.instance:isGuideRunning(BGMSwitchEnum.BGMGuideId) then
		return
	end

	local var_17_0 = BGMSwitchConfig.instance:getBgmEasterEggCo(arg_17_0._eggType1Id)
	local var_17_1 = Mathf.Floor(tonumber(var_17_0.param3) / 1000)

	TaskDispatcher.runDelay(arg_17_0._hideEasterEggType1, arg_17_0, var_17_1)
end

function var_0_0._hideEasterEggType1(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._hideEasterEggType1, arg_18_0)
	gohelper.setActive(arg_18_0._gointerface, false)

	arg_18_0._triggerEggType1Id = nil
	arg_18_0._beatTime = 0
end

function var_0_0._startCheckEasterEggType2(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0._goppt, false)

	local var_19_0 = BGMSwitchModel.instance:getEggType2Sates()
	local var_19_1 = var_19_0[1] and "2" or "1"

	for iter_19_0 = 2, 4 do
		local var_19_2 = var_19_0[iter_19_0] and "#2" or "#1"

		var_19_1 = var_19_1 .. var_19_2
	end

	if arg_19_1 then
		if BGMSwitchConfig.instance:getBgmEasterEggCo(arg_19_1).param1 == var_19_1 then
			arg_19_0:_startEgg2Effect(arg_19_1)
		end

		return
	end

	local var_19_3 = BGMSwitchConfig.instance:getBgmEasterEggCosByType(BGMSwitchEnum.EasterEggType.Ppt)

	for iter_19_1, iter_19_2 in pairs(var_19_3) do
		if iter_19_2.param1 == var_19_1 then
			arg_19_0:_startEgg2Effect(iter_19_2.id)

			return
		end
	end

	BGMSwitchModel.instance:setPPtEffectEgg2Id(nil)
end

function var_0_0._startEgg2Effect(arg_20_0, arg_20_1)
	local var_20_0 = BGMSwitchModel.instance:getMechineGear()

	if arg_20_0:_isHaveEggShowConfig(arg_20_1) then
		BGMSwitchModel.instance:setPPtEffectEgg2Id(arg_20_1)

		if var_20_0 ~= BGMSwitchEnum.Gear.OFF then
			arg_20_0._controlHandleAni:Play("marquee", 0, 0)
		end

		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ToggleEggForGuide)
	else
		BGMSwitchModel.instance:setPPtEffectEgg2Id(nil)

		if var_20_0 ~= BGMSwitchEnum.Gear.OFF then
			arg_20_0._controlHandleAni:Play("loop", 0, 0)
		end
	end
end

function var_0_0._isHaveEggShowConfig(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = BGMSwitchConfig.instance:getBgmEasterEggCo(arg_21_1)

	if var_21_0 then
		local var_21_1 = string.split(var_21_0.param2, "|")

		if arg_21_2 then
			return var_21_1[arg_21_2] and var_21_1[arg_21_2] ~= ""
		end

		return var_21_0.param2 ~= "" and var_21_0.param3 ~= ""
	end

	return false
end

function var_0_0._checkAndShowPpt(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._pptUpdate, arg_22_0)

	local var_22_0 = BGMSwitchModel.instance:getPPtEffectEgg2Id()

	arg_22_0._pptRepeatCount = 0

	if not var_22_0 or not BGMSwitchModel.instance:machineGearIsInSnowflakeScene() then
		gohelper.setActive(arg_22_0._goppt, false)

		return
	end

	BGMSwitchModel.instance:setEggIsTrigger(true)

	if not arg_22_0:_isHaveEggShowConfig(var_22_0, BGMSwitchModel.instance:getAudioCurShowType()) then
		gohelper.setActive(arg_22_0._goppt, false)

		return
	end

	local var_22_1 = BGMSwitchConfig.instance:getBgmEasterEggCo(BGMSwitchModel.instance:getPPtEffectEgg2Id())
	local var_22_2 = BGMSwitchModel.instance:getAudioCurShowType()
	local var_22_3 = string.split(string.split(var_22_1.param2, "|")[var_22_2], "#")

	arg_22_0._simagepptpic1:LoadImage(ResUrl.getBgmEggIcon(var_22_3[1]))
	arg_22_0._simagepptpic2:LoadImage(ResUrl.getBgmEggIcon(var_22_3[1]))
	TaskDispatcher.runRepeat(arg_22_0._pptUpdate, arg_22_0, tonumber(var_22_1.param3) / 1000)
	gohelper.setActive(arg_22_0._goppt, true)
end

function var_0_0._pptUpdate(arg_23_0)
	arg_23_0._pptAni:Play("swicth", 0, 0)

	arg_23_0._pptRepeatCount = arg_23_0._pptRepeatCount + 1

	local var_23_0 = BGMSwitchConfig.instance:getBgmEasterEggCo(BGMSwitchModel.instance:getPPtEffectEgg2Id())
	local var_23_1 = BGMSwitchModel.instance:getAudioCurShowType()
	local var_23_2 = string.split(string.split(var_23_0.param2, "|")[var_23_1], "#")
	local var_23_3 = var_23_2[arg_23_0._pptRepeatCount % #var_23_2 + 1]

	arg_23_0._imagepptpic1.sprite = arg_23_0._imagepptpic2.sprite

	arg_23_0._simagepptpic2:LoadImage(ResUrl.getBgmEggIcon(var_23_3))
end

function var_0_0._refreshBottomEggBtns(arg_24_0)
	local var_24_0 = BGMSwitchModel.instance:getEggType2Sates()

	for iter_24_0 = 1, 4 do
		gohelper.setActive(arg_24_0._egg2Items[iter_24_0].goup, not var_24_0[iter_24_0])
		gohelper.setActive(arg_24_0._egg2Items[iter_24_0].godown, var_24_0[iter_24_0])
	end
end

function var_0_0._playShakingAniByGuide(arg_25_0)
	arg_25_0._viewAni:Play("shaking", 0, 0)
end

function var_0_0.onDestroyView(arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0._pptUpdate, arg_26_0)

	if arg_26_0._egg2Items then
		for iter_26_0, iter_26_1 in pairs(arg_26_0._egg2Items) do
			iter_26_1.btn:RemoveClickListener()
		end

		arg_26_0._egg2Items = nil
	end
end

return var_0_0
