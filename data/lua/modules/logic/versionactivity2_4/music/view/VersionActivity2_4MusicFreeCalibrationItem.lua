module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeCalibrationItem", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicFreeCalibrationItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnnote = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_note")
	arg_1_0._imageopen = gohelper.findChild(arg_1_0.viewGO, "#btn_note/#image_open")
	arg_1_0._imageicon1 = gohelper.findChildImage(arg_1_0.viewGO, "#btn_note/#image_open/#image_icon1")
	arg_1_0._txtname1 = gohelper.findChildText(arg_1_0.viewGO, "#btn_note/#image_open/#txt_name1")
	arg_1_0._imageclose = gohelper.findChildImage(arg_1_0.viewGO, "#btn_note/#image_close")
	arg_1_0._imageicon2 = gohelper.findChildImage(arg_1_0.viewGO, "#btn_note/#image_close/#image_icon2")
	arg_1_0._txtname2 = gohelper.findChildText(arg_1_0.viewGO, "#btn_note/#image_close/#txt_name2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnote:AddClickListener(arg_2_0._btnnoteOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnote:RemoveClickListener()
end

function var_0_0._btnnoteOnClick(arg_4_0)
	arg_4_0._isOpen = not arg_4_0._isOpen

	arg_4_0:_updateStatus()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._id = arg_8_1
	arg_8_0._isOpen = VersionActivity2_4MusicFreeModel.instance:getAccompany(arg_8_1) == VersionActivity2_4MusicEnum.AccompanyStatus.Open

	local var_8_0 = arg_8_0:_getName()

	arg_8_0._txtname1.text = var_8_0
	arg_8_0._txtname2.text = var_8_0

	local var_8_1 = VersionActivity2_4MusicFreeModel.instance:getAccompanyIcon(arg_8_1)

	UISpriteSetMgr.instance:setMusicSprite(arg_8_0._imageicon1, var_8_1)
	UISpriteSetMgr.instance:setMusicSprite(arg_8_0._imageicon2, var_8_1)
	arg_8_0:_updateStatus()
end

function var_0_0._updateStatus(arg_9_0)
	gohelper.setActive(arg_9_0._imageopen, arg_9_0._isOpen)
	gohelper.setActive(arg_9_0._imageclose, not arg_9_0._isOpen)

	local var_9_0 = arg_9_0._isOpen and VersionActivity2_4MusicEnum.AccompanyStatus.Open or VersionActivity2_4MusicEnum.AccompanyStatus.Close

	VersionActivity2_4MusicFreeModel.instance:setAccompany(arg_9_0._id, var_9_0)
	AudioMgr.instance:setRTPCValue(VersionActivity2_4MusicEnum.AccompanyTypeName[arg_9_0._id], var_9_0)
end

function var_0_0._getName(arg_10_0)
	return luaLang("MusicAccompany" .. arg_10_0._id)
end

function var_0_0.onSelect(arg_11_0, arg_11_1)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
