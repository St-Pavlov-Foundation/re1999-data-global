module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicTouchComp", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicTouchComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._callback = arg_1_1.callback
	arg_1_0._callbackTarget = arg_1_1.callbackTarget
	arg_1_0._isCanTouch = true
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1

	if VersionActivity2_4MultiTouchController.isMobilePlayer() then
		VersionActivity2_4MultiTouchController.instance:addTouch(arg_2_0)
	else
		arg_2_0._uiclick = SLFramework.UGUI.UIClickListener.Get(arg_2_0.go)

		arg_2_0._uiclick:AddClickDownListener(arg_2_0._onClickDown, arg_2_0)
	end
end

function var_0_0.canTouch(arg_3_0)
	return arg_3_0._isCanTouch
end

function var_0_0.setTouchEnabled(arg_4_0, arg_4_1)
	arg_4_0._isCanTouch = arg_4_1
end

function var_0_0._onClickDown(arg_5_0)
	arg_5_0:touchDown()
end

function var_0_0.touchDown(arg_6_0)
	arg_6_0.touchDownFrame = Time.frameCount

	if arg_6_0._callback then
		arg_6_0._callback(arg_6_0._callbackTarget)
	end
end

function var_0_0.onDestroy(arg_7_0)
	if arg_7_0._uiclick then
		arg_7_0._uiclick:RemoveClickDownListener()

		arg_7_0._uiclick = nil
	end

	arg_7_0.go = nil
	arg_7_0._callback = nil
	arg_7_0._callbackTarget = nil
end

return var_0_0
