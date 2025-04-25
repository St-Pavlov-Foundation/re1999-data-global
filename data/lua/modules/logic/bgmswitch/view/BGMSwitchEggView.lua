module("modules.logic.bgmswitch.view.BGMSwitchEggView", package.seeall)

slot0 = class("BGMSwitchEggView", BaseView)

function slot0.onInitView(slot0)
	slot0._gointerface = gohelper.findChild(slot0.viewGO, "#go_mechine/#go_interference")
	slot0._btnbeatmechine = gohelper.findChildButton(slot0.viewGO, "#go_mechine/#btn_beatmechine")
	slot0._slidercontrol = gohelper.findChildSlider(slot0.viewGO, "#go_mechine/#slider_control")
	slot0._txtNum1 = gohelper.findChildText(slot0.viewGO, "#go_mechine/#slider_control/Fill Area/#txt_Num1")
	slot0._txtNum2 = gohelper.findChildText(slot0.viewGO, "#go_mechine/#slider_control/Fill Area/#txt_Num2")
	slot0._txtNum3 = gohelper.findChildText(slot0.viewGO, "#go_mechine/#slider_control/Fill Area/#txt_Num3")
	slot0._txtNum4 = gohelper.findChildText(slot0.viewGO, "#go_mechine/#slider_control/Fill Area/#txt_Num4")
	slot0._txtNum5 = gohelper.findChildText(slot0.viewGO, "#go_mechine/#slider_control/Fill Area/#txt_Num5")
	slot0._txtNum6 = gohelper.findChildText(slot0.viewGO, "#go_mechine/#slider_control/Fill Area/#txt_Num6")
	slot0._txtNum7 = gohelper.findChildText(slot0.viewGO, "#go_mechine/#slider_control/Fill Area/#txt_Num7")
	slot0._goppt = gohelper.findChild(slot0.viewGO, "#go_mechine/#go_ppt")
	slot0._controlHandleAni = gohelper.findChild(slot0._slidercontrol.gameObject, "Handle"):GetComponent(typeof(UnityEngine.Animator))
	slot0._pptAni = slot0._goppt:GetComponent(typeof(UnityEngine.Animator))
	slot4 = UnityEngine.Animator
	slot0._viewAni = slot0.viewGO:GetComponent(typeof(slot4))
	slot0._simagepptpic1 = gohelper.findChildSingleImage(slot0._goppt, "#simage_pic1")
	slot0._simagepptpic2 = gohelper.findChildSingleImage(slot0._goppt, "#simage_pic2")
	slot0._imagepptpic1 = gohelper.findChildImage(slot0._goppt, "#simage_pic1")
	slot0._imagepptpic2 = gohelper.findChildImage(slot0._goppt, "#simage_pic2")
	slot0._egg2Items = {}

	for slot4 = 1, 4 do
		if not slot0._egg2Items[slot4] then
			slot0._egg2Items[slot4] = {}
		end

		slot0._egg2Items[slot4].go = gohelper.findChild(slot0.viewGO, "#go_mechine/#btn_control/btn0" .. tostring(slot4))
		slot0._egg2Items[slot4].btn = gohelper.findChildButton(slot0.viewGO, "#go_mechine/#btn_control/btn0" .. tostring(slot4))

		slot0._egg2Items[slot4].btn:AddClickListener(slot0._egg2itemBtnOnclick, slot0, slot4)

		slot0._egg2Items[slot4].goup = gohelper.findChild(slot0._egg2Items[slot4].go, "up")
		slot0._egg2Items[slot4].godown = gohelper.findChild(slot0._egg2Items[slot4].go, "down")
	end
end

function slot0.addEvents(slot0)
	slot0._btnbeatmechine:AddClickListener(slot0._btnbeatmechineOnClick, slot0)
	slot0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.SelectPlayGear, slot0._onSelectPlayGear, slot0)
	slot0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.RandomFinished, slot0._refreshBottomEggBtns, slot0)
	slot0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.ItemSelected, slot0._onBgmItemSelected, slot0)
	slot0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmSwitched, slot0._onBgmSwitched, slot0)
	slot0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmFavorite, slot0._onBgmSwitched, slot0)
	slot0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.PlayShakingAni, slot0._playShakingAniByGuide, slot0)
	slot0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.SlideValueUpdate, slot0._sliderValueUpdate, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbeatmechine:RemoveClickListener()
	slot0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.SelectPlayGear, slot0._onSelectPlayGear, slot0)
	slot0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.RandomFinished, slot0._refreshBottomEggBtns, slot0)
	slot0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.ItemSelected, slot0._onBgmItemSelected, slot0)
	slot0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmSwitched, slot0._onBgmSwitched, slot0)
	slot0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmFavorite, slot0._onBgmSwitched, slot0)
	slot0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.PlayShakingAni, slot0._playShakingAniByGuide, slot0)
	slot0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.SlideValueUpdate, slot0._sliderValueUpdate, slot0)
	TaskDispatcher.cancelTask(slot0._refreshBottomEggBtns, slot0)
end

function slot0._onSliderValueChanged(slot0, slot1)
	slot0.selectIndex = slot1
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._gointerface, false)
	slot0:checkTrigger()

	if not BGMSwitchModel.instance:getEggHideState() then
		slot0:_startCheckEasterEgg()
	end

	BGMSwitchModel.instance:setEggHideState(false)
	slot0:_updateEggBtnsAndShowPpt()
end

function slot0._onBgmSwitched(slot0)
	slot0:_onBgmItemSelected(BGMSwitchModel.instance:getCurBgm())
end

function slot0._sliderValueUpdate(slot0)
	if not BGMSwitchModel.instance:getEggIsTrigger() then
		return
	end

	slot0:_checkAndShowPpt()
end

function slot0._onSelectPlayGear(slot0)
	slot0:checkTrigger()
	slot0:_hideEasterEggType1()
	slot0:_updateEggBtnsAndShowPpt()
end

function slot0.checkTrigger(slot0)
	if BGMSwitchModel.instance:getEggIsTrigger() then
		for slot4 = 1, 4 do
			BGMSwitchModel.instance:setEggType2State(slot4, false)
		end

		BGMSwitchModel.instance:setEggIsTrigger(false)
		BGMSwitchModel.instance:setPPtEffectEgg2Id(nil)
		slot0._controlHandleAni:Play("flashing", 0, 1)
	end
end

function slot0._updateEggBtnsAndShowPpt(slot0)
	if BGMSwitchModel.instance:getMechineGear() == BGMSwitchEnum.Gear.OFF then
		slot0._controlHandleAni:Play("flashing", 0, 1)
	else
		slot0:_startCheckEasterEgg()
	end

	slot0:_checkAndShowPpt()
	slot0:_refreshBottomEggBtns()
end

function slot0._onBgmItemSelected(slot0, slot1)
	if BGMSwitchModel.instance:getMechineGear() ~= BGMSwitchEnum.Gear.On1 then
		return
	end

	if BGMSwitchModel.instance:isValidBgmId(BGMSwitchModel.instance:getCurBgm()) then
		TaskDispatcher.runDelay(slot0._refreshBottomEggBtns, slot0, 0.67)
	else
		slot0:_refreshBottomEggBtns()
	end
end

function slot0._egg2itemBtnOnclick(slot0, slot1)
	if BGMSwitchModel.instance:getEggIsTrigger() and slot0:_isHaveEggShowConfig(BGMSwitchModel.instance:getPPtEffectEgg2Id()) then
		GameFacade.showToast(ToastEnum.KeepStableNoEggControl)

		return
	end

	if BGMSwitchModel.instance:getMechineGear() ~= BGMSwitchEnum.Gear.OFF then
		slot0._controlHandleAni:Play("flashing", 0, 0)
	end

	BGMSwitchModel.instance:setEggType2State(slot1, not BGMSwitchModel.instance:getEggType2SateByIndex(slot1))
	slot0:_refreshBottomEggBtns()
	slot0:_startCheckEasterEggType2()
	BGMSwitchAudioTrigger.play_ui_replay_buttonegg()
end

function slot0._btnbeatmechineOnClick(slot0)
	BGMSwitchAudioTrigger.play_ui_replay_flap()

	if not slot0._beatTime then
		slot0._beatTime = 0
	end

	slot0._beatTime = slot0._beatTime + 1

	slot0._viewAni:Play("shaking", 0, 0)

	if tonumber(BGMSwitchConfig.instance:getBgmEasterEggCo(slot0._eggType1Id).param2) <= slot0._beatTime then
		if not slot0._triggerEggType1Id or slot0._triggerEggType1Id == 0 then
			if GuideModel.instance:isGuideRunning(BGMSwitchEnum.BGMGuideId) then
				return
			end

			slot0._beatTime = 0

			if BGMSwitchModel.instance:getMechineGear() == BGMSwitchEnum.Gear.OFF then
				GameFacade.showToast(ToastEnum.MachineNoRun)
			end

			if slot3 == BGMSwitchEnum.Gear.On1 or BGMSwitchModel.instance:getEggIsTrigger() then
				GameFacade.showToast(ToastEnum.MachineIsOkNoBeat)
			end

			if BGMSwitchModel.instance:machineGearIsInSnowflakeScene() and not BGMSwitchModel.instance:getEggIsTrigger() then
				GameFacade.showToast(ToastEnum.MachineNotShowView)
			end
		else
			slot0:_hideEasterEggType1()
		end
	end
end

function slot0._startCheckEasterEgg(slot0)
	for slot6, slot7 in pairs(BGMSwitchConfig.instance:getBgmEasterEggCos()) do
		if slot7.type == BGMSwitchEnum.EasterEggType.Beat then
			slot0._eggType1Id = slot7.id

			if BGMSwitchModel.instance:getMechineGear() ~= BGMSwitchEnum.Gear.OFF and BGMSwitchModel.instance:getPPtEffectEgg2Id() == nil then
				slot0:_startCheckEasterEggType1(slot7.id)
			end
		elseif slot7.type == BGMSwitchEnum.EasterEggType.Ppt and slot1 ~= BGMSwitchEnum.Gear.OFF and slot0._triggerEggType1Id == nil then
			slot0:_startCheckEasterEggType2(slot7.id)
		end
	end
end

function slot0._startCheckEasterEggType1(slot0, slot1)
	slot2 = BGMSwitchConfig.instance:getBgmEasterEggCo(slot1)
	slot3 = math.random(1, 1000)

	if slot0._lasttriggerEggType1Id then
		slot0._lasttriggerEggType1Id = nil

		return
	end

	if slot3 < tonumber(slot2.param1) and slot0:needCheckRandomNum() then
		slot0._triggerEggType1Id = slot1
		slot0._lasttriggerEggType1Id = slot1

		slot0:_showEasterEggType1()
	end
end

function slot0.needCheckRandomNum(slot0)
	return slot0._lasttriggerEggType1Id == nil
end

function slot0._showEasterEggType1(slot0)
	slot0._beatTime = 0

	gohelper.setActive(slot0._gointerface, true)

	if GuideModel.instance:isGuideRunning(BGMSwitchEnum.BGMGuideId) then
		return
	end

	TaskDispatcher.runDelay(slot0._hideEasterEggType1, slot0, Mathf.Floor(tonumber(BGMSwitchConfig.instance:getBgmEasterEggCo(slot0._eggType1Id).param3) / 1000))
end

function slot0._hideEasterEggType1(slot0)
	TaskDispatcher.cancelTask(slot0._hideEasterEggType1, slot0)
	gohelper.setActive(slot0._gointerface, false)

	slot0._triggerEggType1Id = nil
	slot0._beatTime = 0
end

function slot0._startCheckEasterEggType2(slot0, slot1)
	gohelper.setActive(slot0._goppt, false)

	for slot7 = 2, 4 do
		slot3 = (BGMSwitchModel.instance:getEggType2Sates()[1] and "2" or "1") .. (slot2[slot7] and "#2" or "#1")
	end

	if slot1 then
		if BGMSwitchConfig.instance:getBgmEasterEggCo(slot1).param1 == slot3 then
			slot0:_startEgg2Effect(slot1)
		end

		return
	end

	for slot8, slot9 in pairs(BGMSwitchConfig.instance:getBgmEasterEggCosByType(BGMSwitchEnum.EasterEggType.Ppt)) do
		if slot9.param1 == slot3 then
			slot0:_startEgg2Effect(slot9.id)

			return
		end
	end

	BGMSwitchModel.instance:setPPtEffectEgg2Id(nil)
end

function slot0._startEgg2Effect(slot0, slot1)
	if slot0:_isHaveEggShowConfig(slot1) then
		BGMSwitchModel.instance:setPPtEffectEgg2Id(slot1)

		if BGMSwitchModel.instance:getMechineGear() ~= BGMSwitchEnum.Gear.OFF then
			slot0._controlHandleAni:Play("marquee", 0, 0)
		end

		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ToggleEggForGuide)
	else
		BGMSwitchModel.instance:setPPtEffectEgg2Id(nil)

		if slot2 ~= BGMSwitchEnum.Gear.OFF then
			slot0._controlHandleAni:Play("loop", 0, 0)
		end
	end
end

function slot0._isHaveEggShowConfig(slot0, slot1, slot2)
	if BGMSwitchConfig.instance:getBgmEasterEggCo(slot1) then
		slot4 = string.split(slot3.param2, "|")

		if slot2 then
			return slot4[slot2] and slot4[slot2] ~= ""
		end

		return slot3.param2 ~= "" and slot3.param3 ~= ""
	end

	return false
end

function slot0._checkAndShowPpt(slot0)
	TaskDispatcher.cancelTask(slot0._pptUpdate, slot0)

	slot0._pptRepeatCount = 0

	if not BGMSwitchModel.instance:getPPtEffectEgg2Id() or not BGMSwitchModel.instance:machineGearIsInSnowflakeScene() then
		gohelper.setActive(slot0._goppt, false)

		return
	end

	BGMSwitchModel.instance:setEggIsTrigger(true)

	if not slot0:_isHaveEggShowConfig(slot1, BGMSwitchModel.instance:getAudioCurShowType()) then
		gohelper.setActive(slot0._goppt, false)

		return
	end

	slot2 = BGMSwitchConfig.instance:getBgmEasterEggCo(BGMSwitchModel.instance:getPPtEffectEgg2Id())
	slot4 = string.split(string.split(slot2.param2, "|")[BGMSwitchModel.instance:getAudioCurShowType()], "#")

	slot0._simagepptpic1:LoadImage(ResUrl.getBgmEggIcon(slot4[1]))
	slot0._simagepptpic2:LoadImage(ResUrl.getBgmEggIcon(slot4[1]))
	TaskDispatcher.runRepeat(slot0._pptUpdate, slot0, tonumber(slot2.param3) / 1000)
	gohelper.setActive(slot0._goppt, true)
end

function slot0._pptUpdate(slot0)
	slot0._pptAni:Play("swicth", 0, 0)

	slot0._pptRepeatCount = slot0._pptRepeatCount + 1
	slot3 = string.split(string.split(BGMSwitchConfig.instance:getBgmEasterEggCo(BGMSwitchModel.instance:getPPtEffectEgg2Id()).param2, "|")[BGMSwitchModel.instance:getAudioCurShowType()], "#")
	slot0._imagepptpic1.sprite = slot0._imagepptpic2.sprite

	slot0._simagepptpic2:LoadImage(ResUrl.getBgmEggIcon(slot3[slot0._pptRepeatCount % #slot3 + 1]))
end

function slot0._refreshBottomEggBtns(slot0)
	slot1 = BGMSwitchModel.instance:getEggType2Sates()

	for slot5 = 1, 4 do
		gohelper.setActive(slot0._egg2Items[slot5].goup, not slot1[slot5])
		gohelper.setActive(slot0._egg2Items[slot5].godown, slot1[slot5])
	end
end

function slot0._playShakingAniByGuide(slot0)
	slot0._viewAni:Play("shaking", 0, 0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._pptUpdate, slot0)

	if slot0._egg2Items then
		for slot4, slot5 in pairs(slot0._egg2Items) do
			slot5.btn:RemoveClickListener()
		end

		slot0._egg2Items = nil
	end
end

return slot0
