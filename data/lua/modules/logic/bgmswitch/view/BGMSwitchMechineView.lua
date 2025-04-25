module("modules.logic.bgmswitch.view.BGMSwitchMechineView", package.seeall)

slot0 = class("BGMSwitchMechineView", BaseView)

function slot0.onInitView(slot0)
	slot0._gomechine = gohelper.findChild(slot0.viewGO, "#go_mechine")
	slot0._mechineAni = slot0._gomechine:GetComponent(typeof(UnityEngine.Animator))
	slot0._simagemechine = gohelper.findChildSingleImage(slot0.viewGO, "#go_mechine/#simage_mechine")
	slot0._btnoff = gohelper.findChildButton(slot0.viewGO, "#go_mechine/#simage_mechine/#btn_off")
	slot0._btnon1 = gohelper.findChildButton(slot0.viewGO, "#go_mechine/#simage_mechine/#btn_on1")
	slot0._btnon2 = gohelper.findChildButton(slot0.viewGO, "#go_mechine/#simage_mechine/#btn_on2")
	slot0._btnon3 = gohelper.findChildButton(slot0.viewGO, "#go_mechine/#simage_mechine/#btn_on3")
	slot0._btnmid = gohelper.findChildButton(slot0.viewGO, "#go_mechine/#simage_mechine/#btn_mid")
	slot0._goturnOn = gohelper.findChild(slot0.viewGO, "#go_mechine/#go_turnOn")
	slot0._gochatwindow = gohelper.findChild(slot0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow")
	slot0._goplay = gohelper.findChild(slot0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play")
	slot0._playAni = slot0._goplay:GetComponent(typeof(UnityEngine.Animator))
	slot0._txtplaytitle = gohelper.findChildText(slot0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#txt_playtitle")
	slot0._goplayname = gohelper.findChild(slot0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#go_playname")
	slot0._txtplayname = gohelper.findChildText(slot0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#go_playname/#txt_playname")
	slot0._txtplaynameen = gohelper.findChildText(slot0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#go_playname/#txt_playname/#txt_playnameen")
	slot0._sliderplay = gohelper.findChildSlider(slot0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#slider_play")
	slot0._imgEffect = gohelper.findChildImage(slot0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#playeffect")
	slot0._txtplayprogresstime = gohelper.findChildText(slot0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#slider_play/#txt_playprogresstime")
	slot0._txtplayprogresslength = gohelper.findChildText(slot0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_play/#slider_play/#txt_playprogresslength")
	slot0._golike = gohelper.findChild(slot0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/like/#go_playlike")
	slot0._golikeBg = gohelper.findChild(slot0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/like/image_LikeBG")
	slot0._godesc = gohelper.findChild(slot0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_desc")
	slot0._descAni = slot0._godesc:GetComponent(typeof(UnityEngine.Animator))
	slot0._txtdesctitle = gohelper.findChildText(slot0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_desc/#txt_desctitle")
	slot0._txtdescname = gohelper.findChildText(slot0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_desc/#txt_descname")
	slot0._txtdescnameen = gohelper.findChildText(slot0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_desc/#txt_descname/#txt_descnameen")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_desc/#scroll_desc")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_desc/#scroll_desc/Viewport/#txt_Descr")
	slot0._gocomment = gohelper.findChild(slot0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_comment")
	slot0._commentAni = slot0._gocomment:GetComponent(typeof(UnityEngine.Animator))
	slot0._scrollcomment = gohelper.findChildScrollRect(slot0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_comment/#scroll_comment")
	slot0._gocommentItem = gohelper.findChild(slot0.viewGO, "#go_mechine/#go_turnOn/#go_chatwindow/#go_comment/#scroll_comment/Viewport/commentitem")
	slot0._goxuehuaping = gohelper.findChild(slot0.viewGO, "#go_mechine/#go_xuehuaping")
	slot0._gointerface = gohelper.findChild(slot0.viewGO, "#go_mechine/#go_interference")
	slot0._goturnOnEffect = gohelper.findChild(slot0.viewGO, "#go_mechine/turnon_effect")
	slot0._gocontrol = gohelper.findChild(slot0.viewGO, "#go_mechine/#go_control")
	slot0._gopowerlight = gohelper.findChild(slot0.viewGO, "#go_mechine/#btn_power/light")
	slot0._gochannelbtns = gohelper.findChild(slot0.viewGO, "#go_mechine/#go_channelbtns")
	slot0._sliderChannel = gohelper.findChildSlider(slot0.viewGO, "#go_mechine/#slider_Channel")
	slot0._goswtichbtns = gohelper.findChild(slot0.viewGO, "#go_mechine/#go_swtichbtns")
	slot0._btnswitchleft = gohelper.findChildButton(slot0.viewGO, "#go_mechine/#go_swtichbtns/#btn_switchleft")
	slot0._goswitchleftselected = gohelper.findChild(slot0.viewGO, "#go_mechine/#go_swtichbtns/#btn_switchleft/#go_switchleftselected")
	slot0._goswitchleftunselected = gohelper.findChild(slot0.viewGO, "#go_mechine/#go_swtichbtns/#btn_switchleft/#go_switchleftunselected")
	slot0._btnswitchright = gohelper.findChildButton(slot0.viewGO, "#go_mechine/#go_swtichbtns/#btn_switchright")
	slot0._goswitchrightselected = gohelper.findChild(slot0.viewGO, "#go_mechine/#go_swtichbtns/#btn_switchright/#go_switchrightselected")
	slot0._goswitchrightunselected = gohelper.findChild(slot0.viewGO, "#go_mechine/#go_swtichbtns/#btn_switchright/#go_switchrightunselected")
	slot0._gotap = gohelper.findChild(slot0.viewGO, "#go_mechine/#go_tap")
	slot0._tapAni = slot0._gotap:GetComponent(typeof(UnityEngine.Animator))
	slot0._gotapicon = gohelper.findChild(slot0.viewGO, "#go_mechine/#go_tap/#go_tapicon")
	slot0._imagetape1 = gohelper.findChildImage(slot0.viewGO, "#go_mechine/#go_tap/#go_tapicon/#image_tap1")
	slot0._imagetape2 = gohelper.findChildImage(slot0.viewGO, "#go_mechine/#go_tap/#go_tapicon/#image_tap2")
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._sliderChannel.gameObject)
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0._sliderChannel.gameObject)
	slot0._controlAni = slot0._gocontrol:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnoff:AddClickListener(slot0._btnoffOnClick, slot0)
	slot0._btnon1:AddClickListener(slot0._btnon1OnClick, slot0)
	slot0._btnon2:AddClickListener(slot0._btnon2OnClick, slot0)
	slot0._btnon3:AddClickListener(slot0._btnon3OnClick, slot0)
	slot0._btnmid:AddClickListener(slot0._btnmidOnClick, slot0)
	slot0._btnswitchleft:AddClickListener(slot0._btnswitchleftOnClick, slot0)
	slot0._btnswitchright:AddClickListener(slot0._btnswitchrightOnClick, slot0)
	slot0._drag:AddDragEndListener(slot0._onSliderEnd, slot0)
	slot0._click:AddClickUpListener(slot0._onSlideClick, slot0)
	slot0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmDevicePlayNoise, slot0._showNoiseViewByGuide, slot0)
	slot0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.BGMDeviceShowNormalView, slot0._showNormalViewByGuide, slot0)
	slot0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.ItemSelected, slot0._onBgmItemSelected, slot0)
	slot0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmProgressEnd, slot0._progressFinished, slot0)
	slot0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmSwitched, slot0._onBgmSwitched, slot0)
	slot0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmFavorite, slot0._onBgmFavorite, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnoff:RemoveClickListener()
	slot0._btnon1:RemoveClickListener()
	slot0._btnon2:RemoveClickListener()
	slot0._btnon3:RemoveClickListener()
	slot0._btnmid:RemoveClickListener()
	slot0._btnswitchleft:RemoveClickListener()
	slot0._btnswitchright:RemoveClickListener()
	slot0._drag:RemoveDragEndListener()
	slot0._click:RemoveClickUpListener()
	slot0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmDevicePlayNoise, slot0._showNoiseViewByGuide, slot0)
	slot0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.BGMDeviceShowNormalView, slot0._showNormalViewByGuide, slot0)
	slot0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.ItemSelected, slot0._onBgmItemSelected, slot0)
	slot0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmProgressEnd, slot0._progressFinished, slot0)
	slot0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmSwitched, slot0._onBgmSwitched, slot0)
	slot0:removeEventCb(BGMSwitchController.instance, BGMSwitchEvent.BgmFavorite, slot0._onBgmFavorite, slot0)
end

slot1 = {
	0.15,
	0.5,
	0.85
}

function slot0._btnoffOnClick(slot0)
	if BGMSwitchModel.instance:getMechineGear() == BGMSwitchEnum.Gear.OFF then
		return
	end

	slot0:_switchGearTo(slot1, BGMSwitchEnum.Gear.OFF)
	BGMSwitchModel.instance:setMechineGear(BGMSwitchEnum.Gear.OFF)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("gearswitch")
	TaskDispatcher.runDelay(slot0._switchGearAniFinished, slot0, 0.267 * (BGMSwitchEnum.Gear.OFF + 4 - slot1))
end

function slot0._btnon1OnClick(slot0)
	if BGMSwitchModel.instance:getMechineGear() == BGMSwitchEnum.Gear.On1 then
		return
	end

	slot0._beforeGear = slot1

	slot0:_switchGearTo(slot1, BGMSwitchEnum.Gear.On1)
	BGMSwitchModel.instance:setMechineGear(BGMSwitchEnum.Gear.On1)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("gearswitch")
	TaskDispatcher.runDelay(slot0._switchGearAniFinished, slot0, slot1 < BGMSwitchEnum.Gear.On1 and 0.267 * (BGMSwitchEnum.Gear.On1 - slot1) or 0.267 * (BGMSwitchEnum.Gear.On1 + 4 - slot1))
end

function slot0._btnon2OnClick(slot0)
	if BGMSwitchModel.instance:getMechineGear() == BGMSwitchEnum.Gear.On2 then
		return
	end

	slot0._beforeGear = slot1

	slot0:_switchGearTo(slot1, BGMSwitchEnum.Gear.On2)
	BGMSwitchModel.instance:setMechineGear(BGMSwitchEnum.Gear.On2)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("gearswitch")
	TaskDispatcher.runDelay(slot0._switchGearAniFinished, slot0, slot1 < BGMSwitchEnum.Gear.On2 and 0.267 * (BGMSwitchEnum.Gear.On2 - slot1) or 0.267 * (BGMSwitchEnum.Gear.On2 + 4 - slot1))
end

function slot0._btnon3OnClick(slot0)
	if BGMSwitchModel.instance:getMechineGear() == BGMSwitchEnum.Gear.On3 then
		return
	end

	slot0._beforeGear = slot1

	slot0:_switchGearTo(slot1, BGMSwitchEnum.Gear.On3)
	BGMSwitchModel.instance:setMechineGear(BGMSwitchEnum.Gear.On3)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("gearswitch")
	TaskDispatcher.runDelay(slot0._switchGearAniFinished, slot0, 0.267 * (BGMSwitchEnum.Gear.On3 - slot1))
end

function slot0._btnmidOnClick(slot0)
	if GuideModel.instance:isGuideRunning(BGMSwitchEnum.BGMGuideId) then
		slot0._bgmCo = BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(BGMSwitchController.instance:getBgmAudioId())
	end

	slot2 = BGMSwitchModel.instance:getMechineGear()
	slot0._beforeGear = slot2
	slot3 = BGMSwitchEnum.Gear.On3 <= slot2 and BGMSwitchEnum.Gear.OFF or slot2 + 1

	slot0:_switchGearTo(slot2, slot3)
	BGMSwitchModel.instance:setMechineGear(slot3)
	UIBlockMgrExtend.setNeedCircleMv(false)

	if slot1 then
		return
	end

	UIBlockMgr.instance:startBlock("gearswitch")
	TaskDispatcher.runDelay(slot0._switchGearAniFinished, slot0, 0.267)
end

function slot0._switchGearAniFinished(slot0)
	if slot0._beforeGear == BGMSwitchEnum.Gear.OFF then
		slot0._mechineAni:Play("turnon")
	end

	slot0._beforeGear = nil

	UIBlockMgr.instance:endBlock("gearswitch")

	if BGMSwitchModel.instance:getMechineGear() == BGMSwitchEnum.Gear.OFF then
		slot0._mechineAni:Play("turnoff")
	end

	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.SelectPlayGear)
	slot0:setOnlyUpdateInfo(false)
	slot0:_refreshView()
end

function slot0._switchGearTo(slot0, slot1, slot2)
	if slot1 == slot2 then
		return
	end

	if not GuideModel.instance:isGuideRunning(BGMSwitchEnum.BGMGuideId) then
		StatController.instance:track(StatEnum.EventName.Tuning, {
			[StatEnum.EventProperties.AudioId] = tostring(slot0._bgmCo.id),
			[StatEnum.EventProperties.AudioName] = slot0._bgmCo.audioName,
			[StatEnum.EventProperties.BeforeGearPosition] = tostring(slot1),
			[StatEnum.EventProperties.AfterGearPosition] = tostring(slot2),
			[StatEnum.EventProperties.PlayMode] = BGMSwitchModel.instance:isRandomMode() and "Random" or "LoopOne",
			[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(BGMSwitchModel.instance:getUnfilteredAllBgmsSorted())
		})
	end

	if slot1 == BGMSwitchEnum.Gear.OFF then
		slot0._controlAni:Play("left")
	elseif slot1 == BGMSwitchEnum.Gear.On1 then
		slot0._controlAni:Play("up")
	elseif slot1 == BGMSwitchEnum.Gear.On2 then
		slot0._controlAni:Play("right")
	elseif slot1 == BGMSwitchEnum.Gear.On3 then
		slot0._controlAni:Play("down")
	end

	if slot2 == BGMSwitchEnum.Gear.On1 then
		slot0._tapAni:Play("idle", 0, 0)
		slot0:resetBgmProgressShow()
	else
		slot0:_stopProgressTask()
	end

	if slot1 < slot2 then
		for slot8 = 1, 4 do
			if slot1 < slot8 and slot8 <= slot2 then
				slot0._controlAni:SetBool("unlock" .. tostring(slot8), true)
			else
				slot0._controlAni:SetBool("unlock" .. tostring(slot8), false)
			end
		end
	else
		for slot8 = 1, 4 do
			if slot8 <= slot2 or slot1 < slot8 then
				slot0._controlAni:SetBool("unlock" .. tostring(slot8), true)
			else
				slot0._controlAni:SetBool("unlock" .. tostring(slot8), false)
			end
		end
	end

	BGMSwitchAudioTrigger.switchGearTo(slot1, slot2)
end

function slot0._btnswitchleftOnClick(slot0)
	slot1 = BGMSwitchModel.instance:getCurBgm()

	BGMSwitchModel.instance:nextBgm(-1, false)
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ItemSelected, slot1)
	StatController.instance:track(StatEnum.EventName.SwitchBGM, {
		[StatEnum.EventProperties.AudioId] = tostring(slot0._bgmCo.id),
		[StatEnum.EventProperties.AudioName] = slot0._bgmCo.audioName,
		[StatEnum.EventProperties.BeforeSwitchAudio] = BGMSwitchConfig.instance:getBgmName(slot1),
		[StatEnum.EventProperties.OperationType] = "click Last",
		[StatEnum.EventProperties.PlayMode] = BGMSwitchModel.instance:isRandomMode() and "Random" or "LoopOne",
		[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(BGMSwitchModel.instance:getCurrentUsingBgmList())
	})
	BGMSwitchAudioTrigger.play_ui_replay_buttoncut()
	BGMSwitchAudioTrigger.play_ui_replay_tapswitch()
end

function slot0._btnswitchrightOnClick(slot0)
	slot1 = BGMSwitchModel.instance:getCurBgm()

	BGMSwitchModel.instance:nextBgm(1, false)
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ItemSelected, slot1)
	StatController.instance:track(StatEnum.EventName.SwitchBGM, {
		[StatEnum.EventProperties.AudioId] = tostring(slot0._bgmCo.id),
		[StatEnum.EventProperties.AudioName] = slot0._bgmCo.audioName,
		[StatEnum.EventProperties.BeforeSwitchAudio] = BGMSwitchConfig.instance:getBgmName(slot1),
		[StatEnum.EventProperties.OperationType] = "click Next",
		[StatEnum.EventProperties.PlayMode] = BGMSwitchModel.instance:isRandomMode() and "Random" or "LoopOne",
		[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(BGMSwitchModel.instance:getCurrentUsingBgmList())
	})
	BGMSwitchAudioTrigger.play_ui_replay_buttoncut()
	BGMSwitchAudioTrigger.play_ui_replay_tapswitch()
end

function slot0.setOnlyUpdateInfo(slot0, slot1)
	slot0._onlyUpdateInfo = slot1
end

function slot0.getOnlyUpdateInfo(slot0)
	return slot0._onlyUpdateInfo
end

function slot0._onBgmSwitched(slot0, slot1)
	if slot1 and slot0._bgmCo and slot1 ~= slot0._bgmCo.id then
		return
	end

	slot0:_refreshView()
end

function slot0._onBgmFavorite(slot0, slot1)
	if slot1 == slot0._bgmCo.id then
		slot0:_refreshView()
	end
end

function slot0._onBgmItemSelected(slot0, slot1)
	slot0:setOnlyUpdateInfo(false)

	slot2 = BGMSwitchModel.instance:getCurBgm()

	if BGMSwitchModel.instance:getMechineGear() ~= BGMSwitchEnum.Gear.On1 then
		slot0._bgmCo = BGMSwitchConfig.instance:getBGMSwitchCO(slot2)

		slot0:_refreshBottom()

		return
	end

	if BGMSwitchModel.instance:isValidBgmId(slot2) then
		slot0._bgmCo = BGMSwitchConfig.instance:getBGMSwitchCO(slot2)

		UISpriteSetMgr.instance:setBgmSwitchToggleSprite(slot0._imagetape2, slot0._bgmCo.audioicon)

		if slot1 then
			slot0._tapAni:Play("switch", 0, 0)
		else
			slot0._tapAni:Play("loop", 0, 0)
		end

		slot0:_stopProgressTask()
		TaskDispatcher.runDelay(slot0._refreshView, slot0, 0.67)
	elseif BGMSwitchModel.instance:isValidBgmId(BGMSwitchModel.instance:getNextBgm(1, false)) then
		slot0._bgmCo = BGMSwitchConfig.instance:getBGMSwitchCO(slot2)

		slot0:_refreshView()
	end
end

function slot0._onSlideClick(slot0)
	if BGMSwitchModel.instance:getMechineGear() == BGMSwitchEnum.Gear.OFF then
		return
	end

	slot0:calAndSetShowTypeBySliderProgress()
end

function slot0._onSliderEnd(slot0)
	if BGMSwitchModel.instance:getMechineGear() == BGMSwitchEnum.Gear.OFF then
		return
	end

	slot0:calAndSetShowTypeBySliderProgress()
end

function slot0.calAndSetShowTypeBySliderProgress(slot0)
	slot1 = BGMSwitchEnum.BGMDetailShowType.Progress

	BGMSwitchModel.instance:setAudioCurShowType((slot0._sliderChannel:GetValue() >= uv0[BGMSwitchEnum.BGMDetailShowType.Progress] + 0.5 * (uv0[BGMSwitchEnum.BGMDetailShowType.Introduce] - uv0[BGMSwitchEnum.BGMDetailShowType.Progress]) or BGMSwitchEnum.BGMDetailShowType.Progress) and (slot2 >= uv0[BGMSwitchEnum.BGMDetailShowType.Introduce] + 0.5 * (uv0[BGMSwitchEnum.BGMDetailShowType.Comment] - uv0[BGMSwitchEnum.BGMDetailShowType.Introduce]) or BGMSwitchEnum.BGMDetailShowType.Introduce) and BGMSwitchEnum.BGMDetailShowType.Comment)
	slot0:updateSliderChannelByShowType()

	if BGMSwitchModel.instance:machineGearIsInSnowflakeScene() then
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.SlideValueUpdate)
	end

	BGMSwitchAudioTrigger.play_ui_replay_buttonsilp()

	if not BGMSwitchModel.instance:machineGearIsNeedPlayBgm() then
		return
	end

	gohelper.setActive(slot0._goturnOn, slot1 ~= BGMSwitchEnum.BGMDetailShowType.None)
	gohelper.setActive(slot0._goplay, slot1 == BGMSwitchEnum.BGMDetailShowType.Progress)
	gohelper.setActive(slot0._godesc, slot1 == BGMSwitchEnum.BGMDetailShowType.Introduce)
	gohelper.setActive(slot0._gocomment, slot1 == BGMSwitchEnum.BGMDetailShowType.Comment)
end

function slot0.onOpen(slot0)
	if BGMSwitchModel.instance:getMechineGear() == BGMSwitchEnum.Gear.OFF then
		slot0._controlAni:Play("left")
	elseif slot1 == BGMSwitchEnum.Gear.On1 then
		slot0._controlAni:Play("up")
	elseif slot1 == BGMSwitchEnum.Gear.On2 then
		slot0._controlAni:Play("right")
	elseif slot1 == BGMSwitchEnum.Gear.On3 then
		slot0._controlAni:Play("down")
	end

	BGMSwitchModel.instance:setAudioCurShowType(BGMSwitchEnum.BGMDetailShowType.Progress)

	slot0._bgmCo = BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(BGMSwitchController.instance:getMainBgmAudioId())

	slot0:setOnlyUpdateInfo(true)
	slot0:_refreshView()
end

function slot0._refreshView(slot0)
	slot0._commentAni:Play("switch", 0, 0)
	slot0._descAni:Play("switch", 0, 0)
	slot0._playAni:Play("switch", 0, 0)
	slot0:_refreshTop()
	slot0:_refreshBottom()
end

function slot0._refreshTop(slot0)
	slot0._commentCount = 0

	gohelper.setActive(slot0._goturnOnEffect, true)

	if BGMSwitchModel.instance:getMechineGear() == BGMSwitchEnum.Gear.OFF then
		slot0:_showGearOff()
	elseif slot1 == BGMSwitchEnum.Gear.On1 then
		slot0:_showGearOn1()
	elseif slot1 == BGMSwitchEnum.Gear.On2 then
		slot0:_showGearOn2()
	elseif slot1 == BGMSwitchEnum.Gear.On3 then
		slot0:_showGearOn3()
	end

	slot0:updateSliderChannelByShowType()
end

function slot0._showGearOff(slot0)
	slot0:_stopBgm()
	gohelper.setActive(slot0._goturnOn, false)
	gohelper.setActive(slot0._goxuehuaping, false)
end

function slot0._showGearOn1(slot0)
	if slot0._bgmCo then
		slot0._lastBgmId = slot0._bgmCo.id
	end

	gohelper.setActive(slot0._goxuehuaping, false)
	slot0:_showAudioProgress()
	slot0:_showAudioIntroduce()
	slot0:_showAudioComment()
	slot0:_showAudioLike()
	gohelper.setActive(slot0._goturnOn, BGMSwitchModel.instance:getAudioCurShowType() ~= BGMSwitchEnum.BGMDetailShowType.None)
	gohelper.setActive(slot0._goplay, slot1 == BGMSwitchEnum.BGMDetailShowType.Progress)
	gohelper.setActive(slot0._godesc, slot1 == BGMSwitchEnum.BGMDetailShowType.Introduce)
	gohelper.setActive(slot0._gocomment, slot1 == BGMSwitchEnum.BGMDetailShowType.Comment)
end

function slot0.updateSliderChannelByShowType(slot0)
	slot0._sliderChannel:SetValue(uv0[BGMSwitchModel.instance:getAudioCurShowType()])
end

function slot0._showAudioProgress(slot0)
	if BGMSwitchModel.instance:isRandomMode() then
		slot0._txtplaytitle.text = BGMSwitchModel.instance:isRandomBgmId(BGMSwitchModel.instance:getUsedBgmIdFromServer()) and luaLang("bgmswitchview_randomplay") or luaLang("bgmswitchview_randomplisten")
	else
		slot0._txtplaytitle.text = slot0._bgmCo.id == slot2 and luaLang("bgmswitchview_play") or luaLang("bgmswitchview_listentest")
	end

	slot0:_playNameAnim()

	if not slot0:getOnlyUpdateInfo() then
		slot0:setOnlyUpdateInfo(true)
		slot0:_forcePlayBgm()
	end

	slot3 = BGMSwitchModel.instance:getReportBgmAudioLength(slot0._bgmCo)

	slot0:_processUpdate(0)

	slot0._txtplayprogresslength.text = string.format("%d:%02d", Mathf.Floor(slot3 / 60), Mathf.Floor(slot3 % 60))

	slot0:_stopProgressTask()
	TaskDispatcher.runRepeat(slot0._progressUpdate, slot0, 0.03)
end

function slot0._playNameAnim(slot0)
	slot0._txtplayname.text = slot0._bgmCo.audioName
	slot0._txtplaynameen.text = slot0._bgmCo.audioNameEn

	if slot0._moveTweenId then
		ZProj.TweenHelper.KillById(slot0._moveTweenId)

		slot0._moveTweenId = nil
	end

	TaskDispatcher.cancelTask(slot0._playNameAnimOnce, slot0)
	TaskDispatcher.runDelay(slot0._playNameAnimOnce, slot0, 0.01)
end

function slot0._playNameAnimOnce(slot0)
	slot3, slot4, slot5 = transformhelper.getLocalPos(slot0._txtplayname.transform)

	if recthelper.getWidth(slot0._goplayname.transform) <= recthelper.getWidth(slot0._txtplayname.transform) then
		slot6 = 0.5 * (slot1 + slot2)
		slot7 = -0.5 * (slot1 + slot2)

		transformhelper.setLocalPos(slot0._txtplayname.transform, slot6, slot4, 0)

		slot0._moveTweenId = ZProj.TweenHelper.DOLocalMoveX(slot0._txtplayname.transform, slot7, 0.01 * (slot6 - slot7), slot0._playNameAnimFinished, slot0, nil, EaseType.Linear)
	else
		transformhelper.setLocalPos(slot0._txtplayname.transform, 0, slot4, 0)
	end
end

function slot0._playNameAnimFinished(slot0)
	TaskDispatcher.runDelay(slot0._playNameAnimOnce, slot0, 0.5)
end

function slot0.resetBgmProgressShow(slot0)
	slot0:_processUpdate(0)

	slot0._txtplayprogresstime.text = string.format("%d:%02d", 0, 0)
end

function slot0._processUpdate(slot0, slot1)
	slot0._sliderplay:SetValue(slot1)

	slot0._imgEffect.fillAmount = slot1
end

function slot0._progressUpdate(slot0)
	if BGMSwitchController.instance:getProgress() and slot1 >= 0 then
		slot0:_processUpdate(slot1 / BGMSwitchModel.instance:getReportBgmAudioLength(slot0._bgmCo))

		slot0._txtplayprogresstime.text = string.format("%d:%02d", Mathf.Floor(slot1 / 60), Mathf.Floor(slot1 % 60))
	else
		slot0._txtplayprogresstime.text = string.format("%d:%02d", 0, 0)
	end
end

function slot0._stopBgm(slot0)
	BGMSwitchController.instance:stopMainBgm()
end

function slot0._pauseBgm(slot0)
	BGMSwitchController.instance:pauseMainBgm()
end

function slot0._playBgm(slot0, slot1)
	BGMSwitchController.instance:playMainBgm(slot0._bgmCo.audio, false, slot1)
end

function slot0._forcePlayBgm(slot0)
	BGMSwitchController.instance:playMainBgm(slot0._bgmCo.audio, true, true)
end

function slot0._progressFinished(slot0)
	if BGMSwitchModel.instance:isRandomMode() then
		slot0._bgmCo = BGMSwitchConfig.instance:getBGMSwitchCO(BGMSwitchModel.instance:nextBgm(1, false))

		slot0:_playBgm(true)
		slot0:_refreshView()
		BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.RandomFinished)
		StatController.instance:track(StatEnum.EventName.SwitchBGM, {
			[StatEnum.EventProperties.AudioId] = tostring(slot0._bgmCo.id),
			[StatEnum.EventProperties.AudioName] = slot0._bgmCo.audioName,
			[StatEnum.EventProperties.BeforeSwitchAudio] = BGMSwitchConfig.instance:getBgmName(BGMSwitchModel.instance:getCurBgm()),
			[StatEnum.EventProperties.OperationType] = "playing complete, auto next",
			[StatEnum.EventProperties.PlayMode] = BGMSwitchModel.instance:isRandomMode() and "Random" or "LoopOne",
			[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(BGMSwitchModel.instance:getCurrentUsingBgmList())
		})
	end
end

function slot0._showAudioIntroduce(slot0)
	slot0._txtdescname.text = slot0._bgmCo.audioName
	slot0._txtdescnameen.text = slot0._bgmCo.audioNameEn
	slot0._txtDescr.text = slot0._bgmCo.audioIntroduce
end

function slot0._showAudioLike(slot0)
	slot1 = BGMSwitchModel.instance:isBgmFavorite(slot0._bgmCo.id)

	gohelper.setActive(slot0._golike, slot1)
	gohelper.setActive(slot0._golikeBg, not slot1)
end

function slot0._showAudioComment(slot0)
	if not slot0._commentItems then
		slot0._commentItems = {}
	end

	slot1 = string.split(slot0._bgmCo.audioEvaluates, "|")

	for slot5, slot6 in pairs(slot0._commentItems) do
		gohelper.setActive(slot6.go, false)
	end

	for slot5, slot6 in ipairs(slot1) do
		slot7 = string.split(slot6, "#")

		if not slot0._commentItems[slot5] then
			slot8 = {
				go = gohelper.cloneInPlace(slot0._gocommentItem, slot5)
			}
			slot8.txtName = gohelper.findChildText(slot8.go, "name")
			slot8.txtDesc = gohelper.findChildText(slot8.go, "desc")
			slot0._commentItems[slot5] = slot8
		end

		gohelper.setActive(slot0._commentItems[slot5].go, true)

		slot0._commentItems[slot5].txtName.text = slot7[1]
		slot0._commentItems[slot5].txtDesc.text = slot7[2]
	end
end

function slot0._showGearOn2(slot0)
	slot0:_stopBgm()
	gohelper.setActive(slot0._goturnOn, false)
	gohelper.setActive(slot0._goxuehuaping, true)
end

function slot0._showGearOn3(slot0)
	slot0:_stopBgm()
	gohelper.setActive(slot0._goturnOn, false)
	gohelper.setActive(slot0._goxuehuaping, true)
end

function slot0._showNormalViewByGuide(slot0)
	slot0._bgmCo = BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(BGMSwitchController.instance:getBgmAudioId())
	slot2 = BGMSwitchModel.instance:getMechineGear()

	slot0:_switchGearTo(slot2, BGMSwitchEnum.Gear.On1)
	BGMSwitchModel.instance:setMechineGear(BGMSwitchEnum.Gear.On1)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("gearswitch")
	TaskDispatcher.runDelay(slot0._switchGearAniFinished, slot0, slot2 < BGMSwitchEnum.Gear.On2 and 0.267 * (BGMSwitchEnum.Gear.On2 - slot2) or 0.267 * (BGMSwitchEnum.Gear.On2 + 4 - slot2))
end

function slot0._showNoiseViewByGuide(slot0)
	slot0:_pauseBgm()
	gohelper.setActive(slot0._goturnOn, false)
	gohelper.setActive(slot0._goxuehuaping, false)
	gohelper.setActive(slot0._gointerface, true)
end

function slot0._refreshBottom(slot0)
	gohelper.setActive(slot0._gopowerlight, BGMSwitchModel.instance:getMechineGear() ~= BGMSwitchEnum.Gear.OFF)

	if not slot0:getOnlyUpdateInfo() then
		if slot1 == BGMSwitchEnum.Gear.On1 and slot0._bgmCo then
			slot0._tapAni:Play("loop", 0, 0)
		else
			slot0._tapAni:Play("idle", 0, 0)
		end
	end

	if slot0._bgmCo then
		gohelper.setActive(slot0._gotapicon, true)
		UISpriteSetMgr.instance:setBgmSwitchToggleSprite(slot0._imagetape1, slot0._bgmCo.audioicon)
		UISpriteSetMgr.instance:setBgmSwitchToggleSprite(slot0._imagetape2, slot0._bgmCo.audioicon)
	else
		gohelper.setActive(slot0._gotap, false)
	end
end

function slot0.onClose(slot0)
	BGMSwitchController.instance:backMainBgm()
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.BGMSwitchClose)
	TaskDispatcher.cancelTask(slot0._refreshView, slot0)
	TaskDispatcher.cancelTask(slot0._switchGearAniFinished, slot0)
	slot0:_stopProgressTask()
end

function slot0._stopProgressTask(slot0)
	TaskDispatcher.cancelTask(slot0._progressUpdate, slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._beforeBgm then
		slot0._beforeBgm = nil
	end
end

return slot0
