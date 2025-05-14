module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicBeatResultComboItem", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicBeatResultComboItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gostate1 = gohelper.findChild(arg_1_0.viewGO, "image_state/#go_state1")
	arg_1_0._gostate2 = gohelper.findChild(arg_1_0.viewGO, "image_state/#go_state2")
	arg_1_0._gostate3 = gohelper.findChild(arg_1_0.viewGO, "image_state/#go_state3")
	arg_1_0._txtcombonum = gohelper.findChildText(arg_1_0.viewGO, "#txt_combonum")
	arg_1_0._txtscorenum = gohelper.findChildText(arg_1_0.viewGO, "#txt_scorenum")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	for iter_4_0 = 1, 3 do
		gohelper.setActive(arg_4_0["_gostate" .. iter_4_0], false)
	end
end

function var_0_0._editableAddEvents(arg_5_0)
	return
end

function var_0_0._editableRemoveEvents(arg_6_0)
	return
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	gohelper.setActive(arg_7_0["_gostate" .. arg_7_1], true)

	arg_7_0._txtcombonum.text = VersionActivity2_4MusicEnum.times_sign .. arg_7_2
	arg_7_0._txtscorenum.text = arg_7_3
end

function var_0_0.onSelect(arg_8_0, arg_8_1)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
