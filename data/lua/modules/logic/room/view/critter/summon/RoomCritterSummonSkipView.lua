module("modules.logic.room.view.critter.summon.RoomCritterSummonSkipView", package.seeall)

local var_0_0 = class("RoomCritterSummonSkipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._btnskip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_skip")
	arg_1_0._imageskip = gohelper.findChildImage(arg_1_0.viewGO, "#btn_skip/#image_skip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnskip:AddClickListener(arg_2_0._btnskipOnClick, arg_2_0)
	arg_2_0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onDragEnd, arg_2_0.onDragEnd, arg_2_0)
	arg_2_0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onOpenEgg, arg_2_0._closeSkip, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnskip:RemoveClickListener()
	arg_3_0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onDragEnd, arg_3_0.onDragEnd, arg_3_0)
	arg_3_0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onOpenEgg, arg_3_0._closeSkip, arg_3_0)
end

function var_0_0._btnskipOnClick(arg_4_0)
	arg_4_0:_closeSkip()
	CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onSummonSkip)
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onDragEnd(arg_7_0)
	return
end

function var_0_0._closeSkip(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0.onOpen(arg_9_0)
	gohelper.setActive(arg_9_0._btnskip.gameObject, true)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
