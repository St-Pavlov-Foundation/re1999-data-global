module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeCalibrationView", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicFreeCalibrationView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocalibrationlist = gohelper.findChild(arg_1_0.viewGO, "root/#go_calibrationlist")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onClickModalMask(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._itemList = arg_6_0:getUserDataTb_()

	for iter_6_0 = 1, 3 do
		arg_6_0:_addItem(iter_6_0):onUpdateMO(iter_6_0)
	end
end

function var_0_0._addItem(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.viewContainer:getSetting().otherRes[1]
	local var_7_1 = arg_7_0:getResInst(var_7_0, arg_7_0._gocalibrationlist)
	local var_7_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, VersionActivity2_4MusicFreeCalibrationItem)

	arg_7_0._itemList[arg_7_1] = var_7_2

	return var_7_2
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	return
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
