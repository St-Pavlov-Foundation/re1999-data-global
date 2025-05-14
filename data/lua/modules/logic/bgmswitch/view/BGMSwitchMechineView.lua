module("modules.logic.bgmswitch.view.BGMSwitchMechineView", package.seeall)

local var_0_0 = class("BGMSwitchMechineView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomechine = gohelper.findChild(arg_1_0.viewGO, "#go_mechine")
	arg_1_0._mechineAni = arg_1_0._gomechine:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._simagemechine = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_mechine/#simage_mechine")
	arg_1_0._btnoff = gohelper.findChildButton(arg_1_0.viewGO, "#go_mechine/#simage_mechine/#btn_off")
	arg_1_0._btnon1 = gohelper.findChildButton(arg_1_0.viewGO, "#go_mechine/#simage_mechine/#btn_on1")
	arg_1_0._btnon2 = gohelper.findChildButton(arg_1_0.viewGO, "#go_mechine/#simage_mechine/#btn_on2")
	arg_1_0._btnon3 = gohelper.findChildButton(arg_1_0.viewGO, "#go_mechine/#simage_mechine/#btn_on3")
	arg_1_0._btnmid = gohelper.findChildButton(arg_1_0.viewGO, "#go_mechine/#simage_mechine/#btn_mid")
	arg_1_0._goturnOn = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#go_turnOn")
	arg_1_0._gochatwindow = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow")
	arg_1_0._goplay = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play")
	arg_1_0._playAni = arg_1_0._goplay:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._txtplaytitle = gohelper.findChildText(arg_1_0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#txt_playtitle")
	arg_1_0._goplayname = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#go_playname")
	arg_1_0._txtplayname = gohelper.findChildText(arg_1_0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#go_playname/#txt_playname")
	arg_1_0._txtplaynameen = gohelper.findChildText(arg_1_0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#go_playname/#txt_playname/#txt_playnameen")
	arg_1_0._sliderplay = gohelper.findChildSlider(arg_1_0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#slider_play")
	arg_1_0._imgEffect = gohelper.findChildImage(arg_1_0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#playeffect")
	arg_1_0._txtplayprogresstime = gohelper.findChildText(arg_1_0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#slider_play/#txt_playprogresstime")
	arg_1_0._txtplayprogresslength = gohelper.findChildText(arg_1_0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#slider_play/#txt_playprogresslength")
	arg_1_0._golike = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/like/#go_playlike")
	arg_1_0._golikeBg = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/like/image_LikeBG")
	arg_1_0._godesc = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_desc")
	arg_1_0._descAni = arg_1_0._godesc:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._txtdesctitle = gohelper.findChildText(arg_1_0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_desc/#txt_desctitle")
	arg_1_0._txtdescname = gohelper.findChildText(arg_1_0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_desc/#txt_descname")
	arg_1_0._txtdescnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_desc/#txt_descname/#txt_descnameen")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_desc/#scroll_desc")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_desc/#scroll_desc/Viewport/#txt_Descr")
	arg_1_0._gocomment = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_comment")
	arg_1_0._commentAni = arg_1_0._gocomment:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._scrollcomment = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_comment/#scroll_comment")
	arg_1_0._gocommentItem = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_comment/#scroll_comment/Viewport/commentitem")
	arg_1_0._goxuehuaping = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#go_xuehuaping")
	arg_1_0._gointerface = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#go_interference")
	arg_1_0._goturnOnEffect = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/turnon_effect")
	arg_1_0._gocontrol = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#go_control")
	arg_1_0._gopowerlight = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#btn_power/light")
	arg_1_0._gochannelbtns = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#go_channelbtns")
	arg_1_0._sliderChannel = gohelper.findChildSlider(arg_1_0.viewGO, "#go_mechine/#slider_Channel")
	arg_1_0._goswtichbtns = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#go_swtichbtns")
	arg_1_0._btnswitchleft = gohelper.findChildButton(arg_1_0.viewGO, "#go_mechine/#go_swtichbtns/#btn_switchleft")
	arg_1_0._goswitchleftselected = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#go_swtichbtns/#btn_switchleft/#go_switchleftselected")
	arg_1_0._goswitchleftunselected = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#go_swtichbtns/#btn_switchleft/#go_switchleftunselected")
	arg_1_0._btnswitchright = gohelper.findChildButton(arg_1_0.viewGO, "#go_mechine/#go_swtichbtns/#btn_switchright")
	arg_1_0._goswitchrightselected = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#go_swtichbtns/#btn_switchright/#go_switchrightselected")
	arg_1_0._goswitchrightunselected = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#go_swtichbtns/#btn_switchright/#go_switchrightunselected")
	arg_1_0._gotap = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#go_tap")
	arg_1_0._tapAni = arg_1_0._gotap:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._gotapicon = gohelper.findChild(arg_1_0.viewGO, "#go_mechine/#go_tap/#go_tapicon")
	arg_1_0._imagetape1 = gohelper.findChildImage(arg_1_0.viewGO, "#go_mechine/#go_tap/#go_tapicon/#image_tap1")
	arg_1_0._imagetape2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_mechine/#go_tap/#go_tapicon/#image_tap2")
	arg_1_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_1_0._sliderChannel.gameObject)
	arg_1_0._click = SLFramework.UGUI.UIClickListener.Get(arg_1_0._sliderChannel.gameObject)
	arg_1_0._controlAni = arg_1_0._gocontrol:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnoff:AddClickListener(arg_2_0._btnoffOnClick, arg_2_0)
	arg_2_0._btnon1:AddClickListener(arg_2_0._btnon1OnClick, arg_2_0)
	arg_2_0._btnon2:AddClickListener(arg_2_0._btnon2OnClick, arg_2_0)
	arg_2_0._btnon3:AddClickListener(arg_2_0._btnon3OnClick, arg_2_0)
	arg_2_0._btnmid:AddClickListener(arg_2_0._btnmidOnClick, arg_2_0)
	arg_2_0._btnswitchleft:AddClickListener(arg_2_0._btnswitchleftOnClick, arg_2_0)
	arg_2_0._btnswitchright:AddClickListener(arg_2_0._btnswitchrightOnClick, arg_2_0)
	arg_2_0._drag:AddDragEndListener(arg_2_0._onSliderEnd, arg_2_0)
	arg_2_0._click:AddClickUpListener(arg_2_0._onSlideClick, arg_2_0)
	arg_2_0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmDevicePlayNoise, arg_2_0._showNoiseViewByGuide, arg_2_0)
	arg_2_0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.BGMDeviceShowNormalView, arg_2_0._showNormalViewByGuide, arg_2_0)
	arg_2_0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.ItemSelected, arg_2_0._onBgmItemSelected, arg_2_0)
	arg_2_0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmProgressEnd, arg_2_0._progressFinished, arg_2_0)
	arg_2_0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmSwitched, arg_2_0._onBgmSwitched, arg_2_0)
	arg_2_0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmFavorite, arg_2_0._onBgmFavorite, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnoff:RemoveClickListener()
	arg_3_0._btnon1:RemoveClickListener()
	arg_3_0._btnon2:RemoveClickListener()
	arg_3_0._btnon3:RemoveClickListener()
	arg_3_0._btnmid:RemoveClickListener()
	arg_3_0._btnswitchleft:RemoveClickListener()
	arg_3_0._btnswitchright:RemoveClickListener()
	arg_3_0._drag:RemoveDragEndListener()
	arg_3_0._click:RemoveClickUpListener()
	arg_3_0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmDevicePlayNoise, arg_3_0._showNoiseViewByGuide, arg_3_0)
	arg_3_0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.BGMDeviceShowNormalView, arg_3_0._showNormalViewByGuide, arg_3_0)
	arg_3_0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.ItemSelected, arg_3_0._onBgmItemSelected, arg_3_0)
	arg_3_0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmProgressEnd, arg_3_0._progressFinished, arg_3_0)
	arg_3_0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmSwitched, arg_3_0._onBgmSwitched, arg_3_0)
	arg_3_0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmFavorite, arg_3_0._onBgmFavorite, arg_3_0)
end

local var_0_1 = {
	0.15,
	0.5,
	0.85
}

function var_0_0._btnoffOnClick(arg_4_0)
	local var_4_0 = BGMSwitchModel.instance:getMechineGear()

	if var_4_0 == BGMSwitchEnum.Gear.OFF then
		return
	end

	arg_4_0:_switchGearTo(var_4_0, BGMSwitchEnum.Gear.OFF)
	BGMSwitchModel.instance:setMechineGear(BGMSwitchEnum.Gear.OFF)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("gearswitch")

	local var_4_1 = 0.267 * (BGMSwitchEnum.Gear.OFF + (4 - var_4_0))

	TaskDispatcher.runDelay(arg_4_0._switchGearAniFinished, arg_4_0, var_4_1)
end

function var_0_0._btnon1OnClick(arg_5_0)
	local var_5_0 = BGMSwitchModel.instance:getMechineGear()

	if var_5_0 == BGMSwitchEnum.Gear.On1 then
		return
	end

	arg_5_0._beforeGear = var_5_0

	arg_5_0:_switchGearTo(var_5_0, BGMSwitchEnum.Gear.On1)
	BGMSwitchModel.instance:setMechineGear(BGMSwitchEnum.Gear.On1)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("gearswitch")

	local var_5_1 = var_5_0 < BGMSwitchEnum.Gear.On1 and 0.267 * (BGMSwitchEnum.Gear.On1 - var_5_0) or 0.267 * (BGMSwitchEnum.Gear.On1 + (4 - var_5_0))

	TaskDispatcher.runDelay(arg_5_0._switchGearAniFinished, arg_5_0, var_5_1)
end

function var_0_0._btnon2OnClick(arg_6_0)
	local var_6_0 = BGMSwitchModel.instance:getMechineGear()

	if var_6_0 == BGMSwitchEnum.Gear.On2 then
		return
	end

	arg_6_0._beforeGear = var_6_0

	arg_6_0:_switchGearTo(var_6_0, BGMSwitchEnum.Gear.On2)
	BGMSwitchModel.instance:setMechineGear(BGMSwitchEnum.Gear.On2)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("gearswitch")

	local var_6_1 = var_6_0 < BGMSwitchEnum.Gear.On2 and 0.267 * (BGMSwitchEnum.Gear.On2 - var_6_0) or 0.267 * (BGMSwitchEnum.Gear.On2 + (4 - var_6_0))

	TaskDispatcher.runDelay(arg_6_0._switchGearAniFinished, arg_6_0, var_6_1)
end

function var_0_0._btnon3OnClick(arg_7_0)
	local var_7_0 = BGMSwitchModel.instance:getMechineGear()

	if var_7_0 == BGMSwitchEnum.Gear.On3 then
		return
	end

	arg_7_0._beforeGear = var_7_0

	arg_7_0:_switchGearTo(var_7_0, BGMSwitchEnum.Gear.On3)
	BGMSwitchModel.instance:setMechineGear(BGMSwitchEnum.Gear.On3)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("gearswitch")

	local var_7_1 = 0.267 * (BGMSwitchEnum.Gear.On3 - var_7_0)

	TaskDispatcher.runDelay(arg_7_0._switchGearAniFinished, arg_7_0, var_7_1)
end

function var_0_0._btnmidOnClick(arg_8_0)
	local var_8_0 = GuideModel.instance:isGuideRunning(BGMSwitchEnum.BGMGuideId)

	if var_8_0 then
		local var_8_1 = BGMSwitchController.instance:getBgmAudioId()

		arg_8_0._bgmCo = BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(var_8_1)
	end

	local var_8_2 = BGMSwitchModel.instance:getMechineGear()

	arg_8_0._beforeGear = var_8_2

	local var_8_3 = var_8_2 >= BGMSwitchEnum.Gear.On3 and BGMSwitchEnum.Gear.OFF or var_8_2 + 1

	arg_8_0:_switchGearTo(var_8_2, var_8_3)
	BGMSwitchModel.instance:setMechineGear(var_8_3)
	UIBlockMgrExtend.setNeedCircleMv(false)

	if var_8_0 then
		return
	end

	UIBlockMgr.instance:startBlock("gearswitch")
	TaskDispatcher.runDelay(arg_8_0._switchGearAniFinished, arg_8_0, 0.267)
end

function var_0_0._switchGearAniFinished(arg_9_0)
	if arg_9_0._beforeGear == BGMSwitchEnum.Gear.OFF then
		arg_9_0._mechineAni:Play("turnon")
	end

	arg_9_0._beforeGear = nil

	UIBlockMgr.instance:endBlock("gearswitch")

	if BGMSwitchModel.instance:getMechineGear() == BGMSwitchEnum.Gear.OFF then
		arg_9_0._mechineAni:Play("turnoff")
	end

	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.SelectPlayGear)
	arg_9_0:setOnlyUpdateInfo(false)
	arg_9_0:_refreshView()
end

function var_0_0._switchGearTo(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == arg_10_2 then
		return
	end

	local var_10_0 = BGMSwitchModel.instance:isRandomMode()

	if not GuideModel.instance:isGuideRunning(BGMSwitchEnum.BGMGuideId) then
		StatController.instance:track(StatEnum.EventName.Tuning, {
			[StatEnum.EventProperties.AudioId] = tostring(arg_10_0._bgmCo.id),
			[StatEnum.EventProperties.AudioName] = arg_10_0._bgmCo.audioName,
			[StatEnum.EventProperties.BeforeGearPosition] = tostring(arg_10_1),
			[StatEnum.EventProperties.AfterGearPosition] = tostring(arg_10_2),
			[StatEnum.EventProperties.PlayMode] = var_10_0 and "Random" or "LoopOne",
			[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(BGMSwitchModel.instance:getUnfilteredAllBgmsSorted())
		})
	end

	if arg_10_1 == BGMSwitchEnum.Gear.OFF then
		arg_10_0._controlAni:Play("left")
	elseif arg_10_1 == BGMSwitchEnum.Gear.On1 then
		arg_10_0._controlAni:Play("up")
	elseif arg_10_1 == BGMSwitchEnum.Gear.On2 then
		arg_10_0._controlAni:Play("right")
	elseif arg_10_1 == BGMSwitchEnum.Gear.On3 then
		arg_10_0._controlAni:Play("down")
	end

	if arg_10_2 == BGMSwitchEnum.Gear.On1 then
		arg_10_0._tapAni:Play("idle", 0, 0)
		arg_10_0:resetBgmProgressShow()
	else
		arg_10_0:_stopProgressTask()
	end

	if arg_10_1 < arg_10_2 then
		for iter_10_0 = 1, 4 do
			if arg_10_1 < iter_10_0 and iter_10_0 <= arg_10_2 then
				arg_10_0._controlAni:SetBool("unlock" .. tostring(iter_10_0), true)
			else
				arg_10_0._controlAni:SetBool("unlock" .. tostring(iter_10_0), false)
			end
		end
	else
		for iter_10_1 = 1, 4 do
			if iter_10_1 <= arg_10_2 or arg_10_1 < iter_10_1 then
				arg_10_0._controlAni:SetBool("unlock" .. tostring(iter_10_1), true)
			else
				arg_10_0._controlAni:SetBool("unlock" .. tostring(iter_10_1), false)
			end
		end
	end

	BGMSwitchAudioTrigger.switchGearTo(arg_10_1, arg_10_2)
end

function var_0_0._btnswitchleftOnClick(arg_11_0)
	local var_11_0 = BGMSwitchModel.instance:getCurBgm()

	BGMSwitchModel.instance:nextBgm(-1, false)
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ItemSelected, var_11_0)

	local var_11_1 = BGMSwitchModel.instance:isRandomMode()
	local var_11_2 = BGMSwitchModel.instance:getCurrentUsingBgmList()

	StatController.instance:track(StatEnum.EventName.SwitchBGM, {
		[StatEnum.EventProperties.AudioId] = tostring(arg_11_0._bgmCo.id),
		[StatEnum.EventProperties.AudioName] = arg_11_0._bgmCo.audioName,
		[StatEnum.EventProperties.BeforeSwitchAudio] = BGMSwitchConfig.instance:getBgmName(var_11_0),
		[StatEnum.EventProperties.OperationType] = "click Last",
		[StatEnum.EventProperties.PlayMode] = var_11_1 and "Random" or "LoopOne",
		[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(var_11_2)
	})
	BGMSwitchAudioTrigger.play_ui_replay_buttoncut()
	BGMSwitchAudioTrigger.play_ui_replay_tapswitch()
end

function var_0_0._btnswitchrightOnClick(arg_12_0)
	local var_12_0 = BGMSwitchModel.instance:getCurBgm()

	BGMSwitchModel.instance:nextBgm(1, false)
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ItemSelected, var_12_0)

	local var_12_1 = BGMSwitchModel.instance:isRandomMode()
	local var_12_2 = BGMSwitchModel.instance:getCurrentUsingBgmList()

	StatController.instance:track(StatEnum.EventName.SwitchBGM, {
		[StatEnum.EventProperties.AudioId] = tostring(arg_12_0._bgmCo.id),
		[StatEnum.EventProperties.AudioName] = arg_12_0._bgmCo.audioName,
		[StatEnum.EventProperties.BeforeSwitchAudio] = BGMSwitchConfig.instance:getBgmName(var_12_0),
		[StatEnum.EventProperties.OperationType] = "click Next",
		[StatEnum.EventProperties.PlayMode] = var_12_1 and "Random" or "LoopOne",
		[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(var_12_2)
	})
	BGMSwitchAudioTrigger.play_ui_replay_buttoncut()
	BGMSwitchAudioTrigger.play_ui_replay_tapswitch()
end

function var_0_0.setOnlyUpdateInfo(arg_13_0, arg_13_1)
	arg_13_0._onlyUpdateInfo = arg_13_1
end

function var_0_0.getOnlyUpdateInfo(arg_14_0)
	return arg_14_0._onlyUpdateInfo
end

function var_0_0._onBgmSwitched(arg_15_0, arg_15_1)
	if arg_15_1 and arg_15_0._bgmCo and arg_15_1 ~= arg_15_0._bgmCo.id then
		return
	end

	arg_15_0:_refreshView()
end

function var_0_0._onBgmFavorite(arg_16_0, arg_16_1)
	if arg_16_1 == arg_16_0._bgmCo.id then
		arg_16_0:_refreshView()
	end
end

function var_0_0._onBgmItemSelected(arg_17_0, arg_17_1)
	arg_17_0:setOnlyUpdateInfo(false)

	local var_17_0 = BGMSwitchModel.instance:getCurBgm()

	if BGMSwitchModel.instance:getMechineGear() ~= BGMSwitchEnum.Gear.On1 then
		arg_17_0._bgmCo = BGMSwitchConfig.instance:getBGMSwitchCO(var_17_0)

		arg_17_0:_refreshBottom()

		return
	end

	if BGMSwitchModel.instance:isValidBgmId(var_17_0) then
		arg_17_0._bgmCo = BGMSwitchConfig.instance:getBGMSwitchCO(var_17_0)

		UISpriteSetMgr.instance:setBgmSwitchToggleSprite(arg_17_0._imagetape2, arg_17_0._bgmCo.audioicon)

		if arg_17_1 then
			arg_17_0._tapAni:Play("switch", 0, 0)
		else
			arg_17_0._tapAni:Play("loop", 0, 0)
		end

		arg_17_0:_stopProgressTask()
		TaskDispatcher.runDelay(arg_17_0._refreshView, arg_17_0, 0.67)
	else
		local var_17_1 = BGMSwitchModel.instance:getNextBgm(1, false)

		if BGMSwitchModel.instance:isValidBgmId(var_17_1) then
			arg_17_0._bgmCo = BGMSwitchConfig.instance:getBGMSwitchCO(var_17_1)

			arg_17_0:_refreshView()
		end
	end
end

function var_0_0._onSlideClick(arg_18_0)
	if BGMSwitchModel.instance:getMechineGear() == BGMSwitchEnum.Gear.OFF then
		return
	end

	arg_18_0:calAndSetShowTypeBySliderProgress()
end

function var_0_0._onSliderEnd(arg_19_0)
	if BGMSwitchModel.instance:getMechineGear() == BGMSwitchEnum.Gear.OFF then
		return
	end

	arg_19_0:calAndSetShowTypeBySliderProgress()
end

function var_0_0.calAndSetShowTypeBySliderProgress(arg_20_0)
	local var_20_0 = BGMSwitchEnum.BGMDetailShowType.Progress
	local var_20_1 = arg_20_0._sliderChannel:GetValue()

	if var_20_1 < var_0_1[BGMSwitchEnum.BGMDetailShowType.Progress] + 0.5 * (var_0_1[BGMSwitchEnum.BGMDetailShowType.Introduce] - var_0_1[BGMSwitchEnum.BGMDetailShowType.Progress]) then
		var_20_0 = BGMSwitchEnum.BGMDetailShowType.Progress
	elseif var_20_1 < var_0_1[BGMSwitchEnum.BGMDetailShowType.Introduce] + 0.5 * (var_0_1[BGMSwitchEnum.BGMDetailShowType.Comment] - var_0_1[BGMSwitchEnum.BGMDetailShowType.Introduce]) then
		var_20_0 = BGMSwitchEnum.BGMDetailShowType.Introduce
	else
		var_20_0 = BGMSwitchEnum.BGMDetailShowType.Comment
	end

	BGMSwitchModel.instance:setAudioCurShowType(var_20_0)
	arg_20_0:updateSliderChannelByShowType()

	if BGMSwitchModel.instance:machineGearIsInSnowflakeScene() then
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.SlideValueUpdate)
	end

	BGMSwitchAudioTrigger.play_ui_replay_buttonsilp()

	if not BGMSwitchModel.instance:machineGearIsNeedPlayBgm() then
		return
	end

	gohelper.setActive(arg_20_0._goturnOn, var_20_0 ~= BGMSwitchEnum.BGMDetailShowType.None)
	gohelper.setActive(arg_20_0._goplay, var_20_0 == BGMSwitchEnum.BGMDetailShowType.Progress)
	gohelper.setActive(arg_20_0._godesc, var_20_0 == BGMSwitchEnum.BGMDetailShowType.Introduce)
	gohelper.setActive(arg_20_0._gocomment, var_20_0 == BGMSwitchEnum.BGMDetailShowType.Comment)
end

function var_0_0.onOpen(arg_21_0)
	local var_21_0 = BGMSwitchModel.instance:getMechineGear()

	if var_21_0 == BGMSwitchEnum.Gear.OFF then
		arg_21_0._controlAni:Play("left")
	elseif var_21_0 == BGMSwitchEnum.Gear.On1 then
		arg_21_0._controlAni:Play("up")
	elseif var_21_0 == BGMSwitchEnum.Gear.On2 then
		arg_21_0._controlAni:Play("right")
	elseif var_21_0 == BGMSwitchEnum.Gear.On3 then
		arg_21_0._controlAni:Play("down")
	end

	local var_21_1 = BGMSwitchEnum.BGMDetailShowType.Progress

	BGMSwitchModel.instance:setAudioCurShowType(var_21_1)

	local var_21_2 = BGMSwitchController.instance:getMainBgmAudioId()

	arg_21_0._bgmCo = BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(var_21_2)

	arg_21_0:setOnlyUpdateInfo(true)
	arg_21_0:_refreshView()
end

function var_0_0._refreshView(arg_22_0)
	arg_22_0._commentAni:Play("switch", 0, 0)
	arg_22_0._descAni:Play("switch", 0, 0)
	arg_22_0._playAni:Play("switch", 0, 0)
	arg_22_0:_refreshTop()
	arg_22_0:_refreshBottom()
end

function var_0_0._refreshTop(arg_23_0)
	arg_23_0._commentCount = 0

	local var_23_0 = BGMSwitchModel.instance:getMechineGear()

	gohelper.setActive(arg_23_0._goturnOnEffect, true)

	if var_23_0 == BGMSwitchEnum.Gear.OFF then
		arg_23_0:_showGearOff()
	elseif var_23_0 == BGMSwitchEnum.Gear.On1 then
		arg_23_0:_showGearOn1()
	elseif var_23_0 == BGMSwitchEnum.Gear.On2 then
		arg_23_0:_showGearOn2()
	elseif var_23_0 == BGMSwitchEnum.Gear.On3 then
		arg_23_0:_showGearOn3()
	end

	arg_23_0:updateSliderChannelByShowType()
end

function var_0_0._showGearOff(arg_24_0)
	arg_24_0:_stopBgm()
	gohelper.setActive(arg_24_0._goturnOn, false)
	gohelper.setActive(arg_24_0._goxuehuaping, false)
end

function var_0_0._showGearOn1(arg_25_0)
	if arg_25_0._bgmCo then
		arg_25_0._lastBgmId = arg_25_0._bgmCo.id
	end

	local var_25_0 = BGMSwitchModel.instance:getAudioCurShowType()

	gohelper.setActive(arg_25_0._goxuehuaping, false)
	arg_25_0:_showAudioProgress()
	arg_25_0:_showAudioIntroduce()
	arg_25_0:_showAudioComment()
	arg_25_0:_showAudioLike()
	gohelper.setActive(arg_25_0._goturnOn, var_25_0 ~= BGMSwitchEnum.BGMDetailShowType.None)
	gohelper.setActive(arg_25_0._goplay, var_25_0 == BGMSwitchEnum.BGMDetailShowType.Progress)
	gohelper.setActive(arg_25_0._godesc, var_25_0 == BGMSwitchEnum.BGMDetailShowType.Introduce)
	gohelper.setActive(arg_25_0._gocomment, var_25_0 == BGMSwitchEnum.BGMDetailShowType.Comment)
end

function var_0_0.updateSliderChannelByShowType(arg_26_0)
	arg_26_0._sliderChannel:SetValue(var_0_1[BGMSwitchModel.instance:getAudioCurShowType()])
end

function var_0_0._showAudioProgress(arg_27_0)
	local var_27_0 = BGMSwitchModel.instance:isRandomMode()
	local var_27_1 = BGMSwitchModel.instance:getUsedBgmIdFromServer()

	if var_27_0 then
		arg_27_0._txtplaytitle.text = BGMSwitchModel.instance:isRandomBgmId(var_27_1) and luaLang("bgmswitchview_randomplay") or luaLang("bgmswitchview_randomplisten")
	else
		arg_27_0._txtplaytitle.text = arg_27_0._bgmCo.id == var_27_1 and luaLang("bgmswitchview_play") or luaLang("bgmswitchview_listentest")
	end

	arg_27_0:_playNameAnim()

	if not arg_27_0:getOnlyUpdateInfo() then
		arg_27_0:setOnlyUpdateInfo(true)
		arg_27_0:_forcePlayBgm()
	end

	local var_27_2 = BGMSwitchModel.instance:getReportBgmAudioLength(arg_27_0._bgmCo)
	local var_27_3 = Mathf.Floor(var_27_2 / 60)
	local var_27_4 = Mathf.Floor(var_27_2 % 60)

	arg_27_0:_processUpdate(0)

	arg_27_0._txtplayprogresslength.text = string.format("%d:%02d", var_27_3, var_27_4)

	arg_27_0:_stopProgressTask()
	TaskDispatcher.runRepeat(arg_27_0._progressUpdate, arg_27_0, 0.03)
end

function var_0_0._playNameAnim(arg_28_0)
	arg_28_0._txtplayname.text = arg_28_0._bgmCo.audioName
	arg_28_0._txtplaynameen.text = arg_28_0._bgmCo.audioNameEn

	if arg_28_0._moveTweenId then
		ZProj.TweenHelper.KillById(arg_28_0._moveTweenId)

		arg_28_0._moveTweenId = nil
	end

	TaskDispatcher.cancelTask(arg_28_0._playNameAnimOnce, arg_28_0)
	TaskDispatcher.runDelay(arg_28_0._playNameAnimOnce, arg_28_0, 0.01)
end

function var_0_0._playNameAnimOnce(arg_29_0)
	local var_29_0 = recthelper.getWidth(arg_29_0._txtplayname.transform)
	local var_29_1 = recthelper.getWidth(arg_29_0._goplayname.transform)
	local var_29_2, var_29_3, var_29_4 = transformhelper.getLocalPos(arg_29_0._txtplayname.transform)

	if var_29_1 <= var_29_0 then
		local var_29_5 = 0.5 * (var_29_0 + var_29_1)
		local var_29_6 = -0.5 * (var_29_0 + var_29_1)
		local var_29_7 = 0.01 * (var_29_5 - var_29_6)

		transformhelper.setLocalPos(arg_29_0._txtplayname.transform, var_29_5, var_29_3, 0)

		arg_29_0._moveTweenId = ZProj.TweenHelper.DOLocalMoveX(arg_29_0._txtplayname.transform, var_29_6, var_29_7, arg_29_0._playNameAnimFinished, arg_29_0, nil, EaseType.Linear)
	else
		transformhelper.setLocalPos(arg_29_0._txtplayname.transform, 0, var_29_3, 0)
	end
end

function var_0_0._playNameAnimFinished(arg_30_0)
	TaskDispatcher.runDelay(arg_30_0._playNameAnimOnce, arg_30_0, 0.5)
end

function var_0_0.resetBgmProgressShow(arg_31_0)
	arg_31_0:_processUpdate(0)

	arg_31_0._txtplayprogresstime.text = string.format("%d:%02d", 0, 0)
end

function var_0_0._processUpdate(arg_32_0, arg_32_1)
	arg_32_0._sliderplay:SetValue(arg_32_1)

	arg_32_0._imgEffect.fillAmount = arg_32_1
end

function var_0_0._progressUpdate(arg_33_0)
	local var_33_0 = BGMSwitchController.instance:getProgress()

	if var_33_0 and var_33_0 >= 0 then
		local var_33_1 = var_33_0 / BGMSwitchModel.instance:getReportBgmAudioLength(arg_33_0._bgmCo)

		arg_33_0:_processUpdate(var_33_1)

		local var_33_2 = Mathf.Floor(var_33_0 / 60)
		local var_33_3 = Mathf.Floor(var_33_0 % 60)

		arg_33_0._txtplayprogresstime.text = string.format("%d:%02d", var_33_2, var_33_3)
	else
		arg_33_0._txtplayprogresstime.text = string.format("%d:%02d", 0, 0)
	end
end

function var_0_0._stopBgm(arg_34_0)
	BGMSwitchController.instance:stopMainBgm()
end

function var_0_0._pauseBgm(arg_35_0)
	BGMSwitchController.instance:pauseMainBgm()
end

function var_0_0._playBgm(arg_36_0, arg_36_1)
	BGMSwitchController.instance:playMainBgm(arg_36_0._bgmCo.audio, false, arg_36_1)
end

function var_0_0._forcePlayBgm(arg_37_0)
	BGMSwitchController.instance:playMainBgm(arg_37_0._bgmCo.audio, true, true)
end

function var_0_0._progressFinished(arg_38_0)
	if BGMSwitchModel.instance:isRandomMode() then
		local var_38_0 = BGMSwitchModel.instance:getCurBgm()
		local var_38_1 = BGMSwitchModel.instance:nextBgm(1, false)

		arg_38_0._bgmCo = BGMSwitchConfig.instance:getBGMSwitchCO(var_38_1)

		arg_38_0:_playBgm(true)
		arg_38_0:_refreshView()
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.RandomFinished)

		local var_38_2 = BGMSwitchModel.instance:isRandomMode()
		local var_38_3 = BGMSwitchModel.instance:getCurrentUsingBgmList()

		StatController.instance:track(StatEnum.EventName.SwitchBGM, {
			[StatEnum.EventProperties.AudioId] = tostring(arg_38_0._bgmCo.id),
			[StatEnum.EventProperties.AudioName] = arg_38_0._bgmCo.audioName,
			[StatEnum.EventProperties.BeforeSwitchAudio] = BGMSwitchConfig.instance:getBgmName(var_38_0),
			[StatEnum.EventProperties.OperationType] = "playing complete, auto next",
			[StatEnum.EventProperties.PlayMode] = var_38_2 and "Random" or "LoopOne",
			[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(var_38_3)
		})
	end
end

function var_0_0._showAudioIntroduce(arg_39_0)
	arg_39_0._txtdescname.text = arg_39_0._bgmCo.audioName
	arg_39_0._txtdescnameen.text = arg_39_0._bgmCo.audioNameEn
	arg_39_0._txtDescr.text = arg_39_0._bgmCo.audioIntroduce
end

function var_0_0._showAudioLike(arg_40_0)
	local var_40_0 = BGMSwitchModel.instance:isBgmFavorite(arg_40_0._bgmCo.id)

	gohelper.setActive(arg_40_0._golike, var_40_0)
	gohelper.setActive(arg_40_0._golikeBg, not var_40_0)
end

function var_0_0._showAudioComment(arg_41_0)
	if not arg_41_0._commentItems then
		arg_41_0._commentItems = {}
	end

	local var_41_0 = string.split(arg_41_0._bgmCo.audioEvaluates, "|")

	for iter_41_0, iter_41_1 in pairs(arg_41_0._commentItems) do
		gohelper.setActive(iter_41_1.go, false)
	end

	for iter_41_2, iter_41_3 in ipairs(var_41_0) do
		local var_41_1 = string.split(iter_41_3, "#")

		if not arg_41_0._commentItems[iter_41_2] then
			local var_41_2 = {
				go = gohelper.cloneInPlace(arg_41_0._gocommentItem, iter_41_2)
			}

			var_41_2.txtName = gohelper.findChildText(var_41_2.go, "name")
			var_41_2.txtDesc = gohelper.findChildText(var_41_2.go, "desc")
			arg_41_0._commentItems[iter_41_2] = var_41_2
		end

		gohelper.setActive(arg_41_0._commentItems[iter_41_2].go, true)

		arg_41_0._commentItems[iter_41_2].txtName.text = var_41_1[1]
		arg_41_0._commentItems[iter_41_2].txtDesc.text = var_41_1[2]
	end
end

function var_0_0._showGearOn2(arg_42_0)
	arg_42_0:_stopBgm()
	gohelper.setActive(arg_42_0._goturnOn, false)
	gohelper.setActive(arg_42_0._goxuehuaping, true)
end

function var_0_0._showGearOn3(arg_43_0)
	arg_43_0:_stopBgm()
	gohelper.setActive(arg_43_0._goturnOn, false)
	gohelper.setActive(arg_43_0._goxuehuaping, true)
end

function var_0_0._showNormalViewByGuide(arg_44_0)
	local var_44_0 = BGMSwitchController.instance:getBgmAudioId()

	arg_44_0._bgmCo = BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(var_44_0)

	local var_44_1 = BGMSwitchModel.instance:getMechineGear()

	arg_44_0:_switchGearTo(var_44_1, BGMSwitchEnum.Gear.On1)
	BGMSwitchModel.instance:setMechineGear(BGMSwitchEnum.Gear.On1)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("gearswitch")

	local var_44_2 = var_44_1 < BGMSwitchEnum.Gear.On2 and 0.267 * (BGMSwitchEnum.Gear.On2 - var_44_1) or 0.267 * (BGMSwitchEnum.Gear.On2 + (4 - var_44_1))

	TaskDispatcher.runDelay(arg_44_0._switchGearAniFinished, arg_44_0, var_44_2)
end

function var_0_0._showNoiseViewByGuide(arg_45_0)
	arg_45_0:_pauseBgm()
	gohelper.setActive(arg_45_0._goturnOn, false)
	gohelper.setActive(arg_45_0._goxuehuaping, false)
	gohelper.setActive(arg_45_0._gointerface, true)
end

function var_0_0._refreshBottom(arg_46_0)
	local var_46_0 = BGMSwitchModel.instance:getMechineGear()

	gohelper.setActive(arg_46_0._gopowerlight, var_46_0 ~= BGMSwitchEnum.Gear.OFF)

	if not arg_46_0:getOnlyUpdateInfo() then
		if var_46_0 == BGMSwitchEnum.Gear.On1 and arg_46_0._bgmCo then
			arg_46_0._tapAni:Play("loop", 0, 0)
		else
			arg_46_0._tapAni:Play("idle", 0, 0)
		end
	end

	if arg_46_0._bgmCo then
		gohelper.setActive(arg_46_0._gotapicon, true)
		UISpriteSetMgr.instance:setBgmSwitchToggleSprite(arg_46_0._imagetape1, arg_46_0._bgmCo.audioicon)
		UISpriteSetMgr.instance:setBgmSwitchToggleSprite(arg_46_0._imagetape2, arg_46_0._bgmCo.audioicon)
	else
		gohelper.setActive(arg_46_0._gotap, false)
	end
end

function var_0_0.onClose(arg_47_0)
	BGMSwitchController.instance:backMainBgm()
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.BGMSwitchClose)
	TaskDispatcher.cancelTask(arg_47_0._refreshView, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._switchGearAniFinished, arg_47_0)
	arg_47_0:_stopProgressTask()
end

function var_0_0._stopProgressTask(arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0._progressUpdate, arg_48_0)
end

function var_0_0.onDestroyView(arg_49_0)
	if arg_49_0._beforeBgm then
		arg_49_0._beforeBgm = nil
	end
end

return var_0_0
