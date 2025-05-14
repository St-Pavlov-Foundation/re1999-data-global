module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandBubbleTalkItem", package.seeall)

local var_0_0 = class("FairyLandBubbleTalkItem", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0._go = arg_1_1
	arg_1_0.bubbleView = arg_1_2
	arg_1_0.transform = arg_1_1.transform
	arg_1_0.parent = arg_1_0.transform.parent
	arg_1_0.goRoot = gohelper.findChild(arg_1_0._go, "root")
	arg_1_0.goBubble = gohelper.findChild(arg_1_0.goRoot, "image_Bubble")
	arg_1_0.trsBubble = arg_1_0.goBubble.transform
	arg_1_0.goText = gohelper.findChild(arg_1_0.goRoot, "image_Bubble/Scroll View/Viewport/#txt_Descr")
	arg_1_0.textFade = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.goText, FairyLandTextFade)
	arg_1_0.goArrow = gohelper.findChild(arg_1_0.goRoot, "image_Bubble/Scroll View/image_Arrow")
end

function var_0_0.showBubble(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	gohelper.setActive(arg_2_0._go, true)

	local var_2_0 = {
		content = arg_2_1,
		tween = arg_2_2,
		layoutCallback = arg_2_0.layoutBubble,
		callback = arg_2_0.onTextPlayFinish,
		callbackObj = arg_2_0
	}

	arg_2_0.textFade:setText(var_2_0)
	gohelper.setActive(arg_2_0.goArrow, arg_2_3)
	arg_2_0:addUpdate()
end

function var_0_0.addUpdate(arg_3_0)
	if not arg_3_0.addFlag then
		arg_3_0.addFlag = true

		LateUpdateBeat:Add(arg_3_0._forceUpdatePos, arg_3_0)
	end
end

function var_0_0.layoutBubble(arg_4_0, arg_4_1)
	recthelper.setHeight(arg_4_0.trsBubble, arg_4_1 + 215)
end

function var_0_0.onTextPlayFinish(arg_5_0)
	arg_5_0.bubbleView:onTextPlayFinish()
end

function var_0_0.setTargetGO(arg_6_0, arg_6_1)
	arg_6_0.targetGO = arg_6_1
end

function var_0_0._forceUpdatePos(arg_7_0)
	if gohelper.isNil(arg_7_0.targetGO) then
		return
	end

	local var_7_0, var_7_1 = recthelper.rectToRelativeAnchorPos2(arg_7_0.targetGO.transform.position, arg_7_0.parent)

	recthelper.setAnchor(arg_7_0.transform, var_7_0, var_7_1)
end

function var_0_0.hide(arg_8_0)
	gohelper.setActive(arg_8_0._go, false)

	if arg_8_0.addFlag then
		LateUpdateBeat:Remove(arg_8_0._forceUpdatePos, arg_8_0)

		arg_8_0.addFlag = false
	end

	if arg_8_0.textFade then
		arg_8_0.textFade:killTween()
	end
end

function var_0_0.dispose(arg_9_0)
	if arg_9_0.addFlag then
		LateUpdateBeat:Remove(arg_9_0._forceUpdatePos, arg_9_0)

		arg_9_0.addFlag = false
	end

	if arg_9_0.textFade then
		arg_9_0.textFade:onDestroy()
	end

	arg_9_0:__onDispose()
end

return var_0_0
