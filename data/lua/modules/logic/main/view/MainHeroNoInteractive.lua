module("modules.logic.main.view.MainHeroNoInteractive", package.seeall)

local var_0_0 = class("MainHeroNoInteractive", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtanacn = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_ana_cn")
	arg_1_0._txtanaen = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_ana_en")
	arg_1_0._gocontentbg = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_contentbg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.init(arg_4_0)
	arg_4_0._heroView = arg_4_0.viewContainer:getMainHeroView()
	arg_4_0._heroId = arg_4_0._heroView._heroId
	arg_4_0._skinId = arg_4_0._heroView._skinId

	arg_4_0:_initNoInteraction()
	arg_4_0:_initSpecialIdle()

	if not arg_4_0._touchEventMgr then
		arg_4_0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(arg_4_0.viewGO)

		arg_4_0._touchEventMgr:SetIgnoreUI(true)
		arg_4_0._touchEventMgr:SetOnlyTouch(true)
		arg_4_0._touchEventMgr:SetOnTouchUp(arg_4_0.touchUpHandler, arg_4_0)
		arg_4_0:addEventCb(MainController.instance, MainEvent.ClickDown, arg_4_0.touchDownHandler, arg_4_0)
	end

	TaskDispatcher.runRepeat(arg_4_0._checkNoInteraction, arg_4_0, 1)
end

function var_0_0._clearSpecialIdleVars(arg_5_0)
	arg_5_0._inSpecialIdle = nil
	arg_5_0._playSpecialIdle1 = nil
	arg_5_0._specialIdleStartTime = nil
	arg_5_0._specialCDStartTime = nil
end

function var_0_0._initSpecialIdle(arg_6_0)
	arg_6_0:_clearSpecialIdleVars()

	arg_6_0._specialIdleTime = nil
	arg_6_0._specialIdleCD = nil
	arg_6_0._specialIdle1 = nil
	arg_6_0._specialIdle2 = nil

	local var_6_0 = HeroModel.instance:getVoiceConfig(arg_6_0._heroId, CharacterEnum.VoiceType.SpecialIdle1, nil, arg_6_0._skinId)

	if not var_6_0 or #var_6_0 <= 0 then
		return
	end

	arg_6_0._specialIdleStartTime = Time.time

	local var_6_1 = var_6_0[1]
	local var_6_2 = string.split(var_6_1.param, "#")

	arg_6_0._specialIdleTime = tonumber(var_6_2[1])
	arg_6_0._specialIdleCD = tonumber(var_6_2[2])
	arg_6_0._specialIdle1 = var_6_1
	arg_6_0._specialIdle2 = HeroModel.instance:getVoiceConfig(arg_6_0._heroId, CharacterEnum.VoiceType.SpecialIdle2, nil, arg_6_0._skinId)
end

function var_0_0._initNoInteraction(arg_7_0)
	arg_7_0._interactionStartTime = Time.time

	local var_7_0 = arg_7_0:_getNoInteractionVoice()

	if var_7_0 then
		local var_7_1 = string.split(var_7_0.param, "#")

		arg_7_0._noInteractionTime = tonumber(var_7_1[1])
		arg_7_0._noInteractionCD = tonumber(var_7_1[2])
		arg_7_0._noInteractionConfig = var_7_0
	else
		arg_7_0._noInteractionTime = nil
		arg_7_0._noInteractionCD = nil
	end
end

function var_0_0._getNoInteractionVoice(arg_8_0)
	local var_8_0 = HeroModel.instance:getVoiceConfig(arg_8_0._heroId, CharacterEnum.VoiceType.MainViewNoInteraction, nil, arg_8_0._skinId)

	if var_8_0 and #var_8_0 > 0 then
		return var_8_0[1]
	end
end

function var_0_0._checkNoInteraction(arg_9_0)
	arg_9_0:_checkMainViewNoInteraction()
	arg_9_0:_checkSpecialIdle()
end

function var_0_0._checkSpecialIdle(arg_10_0)
	if not arg_10_0._heroView:isShowInScene() then
		arg_10_0._inSpecialIdle = nil

		return
	end

	if not arg_10_0._specialIdleTime or not arg_10_0._specialIdleStartTime then
		arg_10_0._inSpecialIdle = nil

		return
	end

	if arg_10_0:isPlayingVoice() then
		return
	end

	arg_10_0._inSpecialIdle = nil

	if #ViewMgr.instance:getOpenViewNameList() - (ViewMgr.instance:isOpen(ViewName.ToastView) and 1 or 0) - (ViewMgr.instance:isOpen(ViewName.WaterMarkView) and 1 or 0) - (ViewMgr.instance:isOpen(ViewName.PlayerIdView) and 1 or 0) > 1 then
		return
	end

	if Time.time - arg_10_0._specialIdleStartTime < arg_10_0._specialIdleTime then
		return
	end

	arg_10_0._inSpecialIdle = true

	if not arg_10_0._playSpecialIdle1 then
		arg_10_0._playSpecialIdle1 = true

		arg_10_0:playVoice(arg_10_0._specialIdle1)

		arg_10_0._specialCDStartTime = Time.time

		return
	end

	if arg_10_0._specialCDStartTime and Time.time - arg_10_0._specialCDStartTime < arg_10_0._specialIdleCD then
		return
	end

	local var_10_0 = 0
	local var_10_1 = #arg_10_0._specialIdle2

	while true do
		var_10_0 = var_10_0 + 1

		local var_10_2 = math.random(var_10_1)

		if var_10_2 ~= arg_10_0._specialRandomIndex or var_10_1 <= var_10_0 then
			arg_10_0._specialRandomIndex = var_10_2

			local var_10_3 = arg_10_0._specialIdle2[var_10_2]

			arg_10_0:playVoice(var_10_3)

			break
		end
	end

	arg_10_0._specialCDStartTime = Time.time
end

function var_0_0._checkMainViewNoInteraction(arg_11_0)
	if not arg_11_0._noInteractionTime or not arg_11_0._interactionStartTime or not arg_11_0._noInteractionConfig then
		return
	end

	if Time.time - arg_11_0._interactionStartTime < arg_11_0._noInteractionTime then
		return
	end

	if arg_11_0._interactionCDStartTime and Time.time - arg_11_0._interactionCDStartTime < arg_11_0._noInteractionCD then
		return
	end

	local var_11_0 = arg_11_0._heroView:getLightSpine()
	local var_11_1 = var_11_0 and var_11_0:getPlayVoiceStartTime()

	if var_11_1 and Time.time - var_11_1 < 10 then
		return
	end

	if #ViewMgr.instance:getOpenViewNameList() - (ViewMgr.instance:isOpen(ViewName.ToastView) and 1 or 0) > 1 then
		return
	end

	arg_11_0._noInteractionConfig = arg_11_0:_getNoInteractionVoice()

	if not arg_11_0._noInteractionConfig then
		return
	end

	arg_11_0:playVoice(arg_11_0._noInteractionConfig)

	arg_11_0._interactionCDStartTime = Time.time
end

function var_0_0.touchUpHandler(arg_12_0)
	arg_12_0._interactionStartTime = Time.time
	arg_12_0._specialIdleStartTime = Time.time
end

function var_0_0.touchDownHandler(arg_13_0)
	arg_13_0._interactionStartTime = nil

	if arg_13_0._inSpecialIdle then
		arg_13_0._inSpecialIdle = nil

		local var_13_0 = arg_13_0._heroView:getLightSpine()

		if var_13_0 then
			var_13_0:stopVoice()
		end
	end

	arg_13_0:_clearSpecialIdleVars()
end

function var_0_0.isPlayingVoice(arg_14_0)
	return arg_14_0._heroView:isPlayingVoice()
end

function var_0_0.playVoice(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._heroView:getLightSpine()

	if not var_15_0 then
		return
	end

	var_15_0:playVoice(arg_15_1, nil, arg_15_0._txtanacn, arg_15_0._txtanaen, arg_15_0._gocontentbg)
end

function var_0_0.onClose(arg_16_0)
	if arg_16_0._touchEventMgr then
		TouchEventMgrHepler.remove(arg_16_0._touchEventMgr)

		arg_16_0._touchEventMgr = nil
	end

	TaskDispatcher.cancelTask(arg_16_0._checkNoInteraction, arg_16_0)
end

return var_0_0
