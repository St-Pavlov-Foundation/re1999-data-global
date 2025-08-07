module("modules.common.global.GameGlobalMgr", package.seeall)

local var_0_0 = class("GameGlobalMgr")

function var_0_0.ctor(arg_1_0)
	LuaEventSystem.addEventMechanism(arg_1_0)
end

function var_0_0.initLangFont(arg_2_0)
	if arg_2_0._langFont == nil then
		arg_2_0._langFont = GameLangFont.New()
	end
end

function var_0_0.init(arg_3_0)
	arg_3_0._screenState = GameScreenState.New()
	arg_3_0._loadingState = GameLoadingState.New()
	arg_3_0._fullViewState = GameFullViewState.New()
	arg_3_0._msgTooOfterCheck = GameMsgTooOftenCheck.New()
	arg_3_0._msgLockState = GameMsgLockState.New()
	arg_3_0._screenBrightness = GameScreenBrightness.New()
	arg_3_0._screenTouch = GameScreenTouch.New()

	arg_3_0:initLangFont()
	GoHelperExtend.activateExtend()
	StringExtend.activateExtend()
	LuaMixScrollViewExtended.activateExtend()
	CustomAnimContainer.activateCustom()
	GameStateMgr.instance:init()
	GameTimeMgr.instance:init()
	GameGCMgr.instance:init()

	if GameAdaptionBgMgr and GameAdaptionBgMgr.instance then
		GameAdaptionBgMgr.instance:tryAddEvents()
	end
end

function var_0_0.getScreenState(arg_4_0)
	return arg_4_0._screenState
end

function var_0_0.getFullViewState(arg_5_0)
	return arg_5_0._fullViewState
end

function var_0_0.getLoadingState(arg_6_0)
	return arg_6_0._loadingState
end

function var_0_0.getLangFont(arg_7_0)
	return arg_7_0._langFont
end

function var_0_0.getMsgLockState(arg_8_0)
	return arg_8_0._msgLockState
end

function var_0_0.playTouchEffect(arg_9_0, arg_9_1)
	arg_9_0._screenTouch:playTouchEffect(arg_9_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
