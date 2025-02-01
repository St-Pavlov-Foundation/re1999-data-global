module("modules.logic.main.view.MainHeroNoInteractive", package.seeall)

slot0 = class("MainHeroNoInteractive", BaseView)

function slot0.onInitView(slot0)
	slot0._txtanacn = gohelper.findChildText(slot0.viewGO, "bottom/#txt_ana_cn")
	slot0._txtanaen = gohelper.findChildText(slot0.viewGO, "bottom/#txt_ana_en")
	slot0._gocontentbg = gohelper.findChild(slot0.viewGO, "bottom/#go_contentbg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.init(slot0)
	slot0._heroView = slot0.viewContainer:getMainHeroView()
	slot0._heroId = slot0._heroView._heroId
	slot0._skinId = slot0._heroView._skinId

	slot0:_initNoInteraction()
	slot0:_initSpecialIdle()

	if not slot0._touchEventMgr then
		slot0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(slot0.viewGO)

		slot0._touchEventMgr:SetIgnoreUI(true)
		slot0._touchEventMgr:SetOnlyTouch(true)
		slot0._touchEventMgr:SetOnTouchUp(slot0.touchUpHandler, slot0)
		slot0:addEventCb(MainController.instance, MainEvent.ClickDown, slot0.touchDownHandler, slot0)
	end

	TaskDispatcher.runRepeat(slot0._checkNoInteraction, slot0, 1)
end

function slot0._clearSpecialIdleVars(slot0)
	slot0._inSpecialIdle = nil
	slot0._playSpecialIdle1 = nil
	slot0._specialIdleStartTime = nil
	slot0._specialCDStartTime = nil
end

function slot0._initSpecialIdle(slot0)
	slot0:_clearSpecialIdleVars()

	slot0._specialIdleTime = nil
	slot0._specialIdleCD = nil
	slot0._specialIdle1 = nil
	slot0._specialIdle2 = nil

	if not HeroModel.instance:getVoiceConfig(slot0._heroId, CharacterEnum.VoiceType.SpecialIdle1, nil, slot0._skinId) or #slot1 <= 0 then
		return
	end

	slot0._specialIdleStartTime = Time.time
	slot2 = slot1[1]
	slot3 = string.split(slot2.param, "#")
	slot0._specialIdleTime = tonumber(slot3[1])
	slot0._specialIdleCD = tonumber(slot3[2])
	slot0._specialIdle1 = slot2
	slot0._specialIdle2 = HeroModel.instance:getVoiceConfig(slot0._heroId, CharacterEnum.VoiceType.SpecialIdle2, nil, slot0._skinId)
end

function slot0._initNoInteraction(slot0)
	slot0._interactionStartTime = Time.time

	if slot0:_getNoInteractionVoice() then
		slot2 = string.split(slot1.param, "#")
		slot0._noInteractionTime = tonumber(slot2[1])
		slot0._noInteractionCD = tonumber(slot2[2])
		slot0._noInteractionConfig = slot1
	else
		slot0._noInteractionTime = nil
		slot0._noInteractionCD = nil
	end
end

function slot0._getNoInteractionVoice(slot0)
	if HeroModel.instance:getVoiceConfig(slot0._heroId, CharacterEnum.VoiceType.MainViewNoInteraction, nil, slot0._skinId) and #slot1 > 0 then
		return slot1[1]
	end
end

function slot0._checkNoInteraction(slot0)
	slot0:_checkMainViewNoInteraction()
	slot0:_checkSpecialIdle()
end

function slot0._checkSpecialIdle(slot0)
	if not slot0._heroView:isShowInScene() then
		slot0._inSpecialIdle = nil

		return
	end

	if not slot0._specialIdleTime or not slot0._specialIdleStartTime then
		slot0._inSpecialIdle = nil

		return
	end

	if slot0:isPlayingVoice() then
		return
	end

	slot0._inSpecialIdle = nil

	if #ViewMgr.instance:getOpenViewNameList() - (ViewMgr.instance:isOpen(ViewName.ToastView) and 1 or 0) - (ViewMgr.instance:isOpen(ViewName.WaterMarkView) and 1 or 0) - (ViewMgr.instance:isOpen(ViewName.PlayerIdView) and 1 or 0) > 1 then
		return
	end

	if Time.time - slot0._specialIdleStartTime < slot0._specialIdleTime then
		return
	end

	slot0._inSpecialIdle = true

	if not slot0._playSpecialIdle1 then
		slot0._playSpecialIdle1 = true

		slot0:playVoice(slot0._specialIdle1)

		slot0._specialCDStartTime = Time.time

		return
	end

	if slot0._specialCDStartTime and Time.time - slot0._specialCDStartTime < slot0._specialIdleCD then
		return
	end

	slot3 = #slot0._specialIdle2

	while true do
		if math.random(slot3) ~= slot0._specialRandomIndex or slot3 <= 0 + 1 then
			slot0._specialRandomIndex = slot4

			slot0:playVoice(slot0._specialIdle2[slot4])

			break
		end
	end

	slot0._specialCDStartTime = Time.time
end

function slot0._checkMainViewNoInteraction(slot0)
	if not slot0._noInteractionTime or not slot0._interactionStartTime or not slot0._noInteractionConfig then
		return
	end

	if Time.time - slot0._interactionStartTime < slot0._noInteractionTime then
		return
	end

	if slot0._interactionCDStartTime and Time.time - slot0._interactionCDStartTime < slot0._noInteractionCD then
		return
	end

	if slot0._heroView:getLightSpine() and slot1:getPlayVoiceStartTime() and Time.time - slot2 < 10 then
		return
	end

	if #ViewMgr.instance:getOpenViewNameList() - (ViewMgr.instance:isOpen(ViewName.ToastView) and 1 or 0) > 1 then
		return
	end

	slot0._noInteractionConfig = slot0:_getNoInteractionVoice()

	if not slot0._noInteractionConfig then
		return
	end

	slot0:playVoice(slot0._noInteractionConfig)

	slot0._interactionCDStartTime = Time.time
end

function slot0.touchUpHandler(slot0)
	slot0._interactionStartTime = Time.time
	slot0._specialIdleStartTime = Time.time
end

function slot0.touchDownHandler(slot0)
	slot0._interactionStartTime = nil

	if slot0._inSpecialIdle then
		slot0._inSpecialIdle = nil

		if slot0._heroView:getLightSpine() then
			slot1:stopVoice()
		end
	end

	slot0:_clearSpecialIdleVars()
end

function slot0.isPlayingVoice(slot0)
	return slot0._heroView:isPlayingVoice()
end

function slot0.playVoice(slot0, slot1)
	if not slot0._heroView:getLightSpine() then
		return
	end

	slot2:playVoice(slot1, nil, slot0._txtanacn, slot0._txtanaen, slot0._gocontentbg)
end

function slot0.onClose(slot0)
	if slot0._touchEventMgr then
		TouchEventMgrHepler.remove(slot0._touchEventMgr)

		slot0._touchEventMgr = nil
	end

	TaskDispatcher.cancelTask(slot0._checkNoInteraction, slot0)
end

return slot0
