module("modules.common.global.GameGlobalMgr", package.seeall)

slot0 = class("GameGlobalMgr")

function slot0.ctor(slot0)
	LuaEventSystem.addEventMechanism(slot0)
end

function slot0.initLangFont(slot0)
	slot0._langFont = GameLangFont.New()
end

function slot0.init(slot0)
	slot0._screenState = GameScreenState.New()
	slot0._loadingState = GameLoadingState.New()
	slot0._fullViewState = GameFullViewState.New()
	slot0._msgTooOfterCheck = GameMsgTooOftenCheck.New()
	slot0._msgLockState = GameMsgLockState.New()
	slot0._screenBrightness = GameScreenBrightness.New()
	slot0._screenTouch = GameScreenTouch.New()

	if slot0._langFont == nil then
		slot0._langFont = GameLangFont.New()
	end

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

function slot0.getScreenState(slot0)
	return slot0._screenState
end

function slot0.getFullViewState(slot0)
	return slot0._fullViewState
end

function slot0.getLoadingState(slot0)
	return slot0._loadingState
end

function slot0.getLangFont(slot0)
	return slot0._langFont
end

function slot0.getMsgLockState(slot0)
	return slot0._msgLockState
end

function slot0.playTouchEffect(slot0, slot1)
	slot0._screenTouch:playTouchEffect(slot1)
end

slot0.instance = slot0.New()

return slot0
