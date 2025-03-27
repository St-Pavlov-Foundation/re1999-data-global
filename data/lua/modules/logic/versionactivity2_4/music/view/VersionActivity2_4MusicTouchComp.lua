module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicTouchComp", package.seeall)

slot0 = class("VersionActivity2_4MusicTouchComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._callback = slot1.callback
	slot0._callbackTarget = slot1.callbackTarget
	slot0._isCanTouch = true
end

function slot0.init(slot0, slot1)
	slot0.go = slot1

	if VersionActivity2_4MultiTouchController.isMobilePlayer() then
		VersionActivity2_4MultiTouchController.instance:addTouch(slot0)
	else
		slot0._uiclick = SLFramework.UGUI.UIClickListener.Get(slot0.go)

		slot0._uiclick:AddClickDownListener(slot0._onClickDown, slot0)
	end
end

function slot0.canTouch(slot0)
	return slot0._isCanTouch
end

function slot0.setTouchEnabled(slot0, slot1)
	slot0._isCanTouch = slot1
end

function slot0._onClickDown(slot0)
	slot0:touchDown()
end

function slot0.touchDown(slot0)
	slot0.touchDownFrame = Time.frameCount

	if slot0._callback then
		slot0._callback(slot0._callbackTarget)
	end
end

function slot0.onDestroy(slot0)
	if slot0._uiclick then
		slot0._uiclick:RemoveClickDownListener()

		slot0._uiclick = nil
	end

	slot0.go = nil
	slot0._callback = nil
	slot0._callbackTarget = nil
end

return slot0
