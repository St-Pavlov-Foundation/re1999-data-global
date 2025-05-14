module("modules.logic.versionactivity1_4.act136.view.Activity136ChoiceView", package.seeall)

local var_0_0 = class("Activity136ChoiceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bg/#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/bg/#simage_bg2")
	arg_1_0._scrollitem = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#scroll_item")
	arg_1_0._btnok = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_ok")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnok:AddClickListener(arg_2_0._btnokOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(Activity136Controller.instance, Activity136Event.SelectCharacter, arg_2_0._onSelectCharacter, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnok:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0:removeEventCb(Activity136Controller.instance, Activity136Event.SelectCharacter, arg_3_0._onSelectCharacter, arg_3_0)
end

function var_0_0._btnokOnClick(arg_4_0)
	Activity136Controller.instance:receiveCharacter(arg_4_0._selectCharacterId)
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._onSelectCharacter(arg_6_0, arg_6_1)
	arg_6_0._selectCharacterId = arg_6_1

	arg_6_0:refreshReceiveBtn()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._selectCharacterId = nil
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:refreshReceiveBtn()
	Activity136ChoiceViewListModel.instance:setSelfSelectedCharacterList()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_culture_open)
end

function var_0_0.refreshReceiveBtn(arg_10_0)
	local var_10_0 = true

	if not Activity136Model.instance:hasReceivedCharacter() then
		var_10_0 = not arg_10_0._selectCharacterId
	end

	ZProj.UGUIHelper.SetGrayscale(arg_10_0._btnok.gameObject, var_10_0)
end

function var_0_0.onClose(arg_11_0)
	arg_11_0._selectCharacterId = nil
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
