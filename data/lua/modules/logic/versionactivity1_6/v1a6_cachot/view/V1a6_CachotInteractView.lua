module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotInteractView", package.seeall)

local var_0_0 = class("V1a6_CachotInteractView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnFullScreen = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_fullscreen")
	arg_1_0._goChoiceItemParent = gohelper.findChild(arg_1_0.viewGO, "choices/#go_choicelist")
	arg_1_0._goChoiceItem = gohelper.findChild(arg_1_0.viewGO, "choices/#go_choicelist/#go_choiceitem")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnFullScreen:AddClickListener(arg_2_0._clickFull, arg_2_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.ShowHideChoice, arg_2_0.showHideChoice, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnFullScreen:RemoveClickListener()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.ShowHideChoice, arg_3_0.showHideChoice, arg_3_0)
end

function var_0_0._clickFull(arg_4_0)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.SelectChoice, -1)
end

function var_0_0.onOpen(arg_5_0)
	gohelper.setActive(arg_5_0._goChoiceItemParent, false)
end

function var_0_0.showHideChoice(arg_6_0, arg_6_1)
	if arg_6_1 then
		gohelper.setActive(arg_6_0._goChoiceItemParent, true)
		gohelper.CreateObjList(arg_6_0, arg_6_0._createItem, arg_6_1, arg_6_0._goChoiceItemParent, arg_6_0._goChoiceItem, V1a6_CachotInteractChoiceItem)
	else
		gohelper.setActive(arg_6_0._goChoiceItemParent, false)
	end
end

function var_0_0._createItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_1:updateMo(arg_7_2, arg_7_3)
end

function var_0_0.onClose(arg_8_0)
	return
end

return var_0_0
