﻿module("modules.logic.handbook.view.HandbookView", package.seeall)

local var_0_0 = class("HandbookView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._btncharacter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/#btn_character")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/#btn_equip")
	arg_1_0._btnstory = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/#btn_story")
	arg_1_0._btnweekWalk = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/#btn_weekWalk")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncharacter:AddClickListener(arg_2_0._btncharacterOnClick, arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._btnequipOnClick, arg_2_0)
	arg_2_0._btnstory:AddClickListener(arg_2_0._btnstoryOnClick, arg_2_0)
	arg_2_0._btnweekWalk:AddClickListener(arg_2_0._btnweekWalkOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncharacter:RemoveClickListener()
	arg_3_0._btnequip:RemoveClickListener()
	arg_3_0._btnstory:RemoveClickListener()
	arg_3_0._btnweekWalk:RemoveClickListener()
end

function var_0_0._btnweekWalkOnClick(arg_4_0)
	HandbookController.instance:openHandbookWeekWalkMapView()
end

function var_0_0._btncharacterOnClick(arg_5_0)
	HandbookController.instance:openCharacterView()
end

function var_0_0._btnequipOnClick(arg_6_0)
	HandbookController.instance:openEquipView()
end

function var_0_0._btnstoryOnClick(arg_7_0)
	HandbookController.instance:openStoryView()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._simagebg:LoadImage(ResUrl.getHandbookBg("full/bg"))
	gohelper.setActive(arg_8_0._btnweekWalk.gameObject, false)
end

function var_0_0.onOpen(arg_9_0)
	gohelper.addUIClickAudio(arg_9_0._btncharacter.gameObject, AudioEnum.UI.play_ui_screenplay_photo_open)
	gohelper.addUIClickAudio(arg_9_0._btnstory.gameObject, AudioEnum.UI.play_ui_screenplay_photo_open)
	gohelper.addUIClickAudio(arg_9_0._btnequip.gameObject, AudioEnum.UI.play_ui_screenplay_photo_open)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simagebg:UnLoadImage()
end

return var_0_0
