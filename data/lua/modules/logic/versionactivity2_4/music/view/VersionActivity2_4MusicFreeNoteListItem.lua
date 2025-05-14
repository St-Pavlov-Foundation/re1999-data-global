module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeNoteListItem", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicFreeNoteListItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnchangebtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_changebtn")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#btn_changebtn/#image_icon")
	arg_1_0._imagenullicon = gohelper.findChildImage(arg_1_0.viewGO, "#btn_changebtn/#image_nullicon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#btn_changebtn/#txt_name")
	arg_1_0._scrollmusiclist1 = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_musiclist1")
	arg_1_0._goimageFrame = gohelper.findChild(arg_1_0.viewGO, "#scroll_musiclist1/viewport/#go_image_Frame")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_musiclist1/viewport/#go_content")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#scroll_musiclist1/#go_empty")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnchangebtn:AddClickListener(arg_2_0._btnchangebtnOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnchangebtn:RemoveClickListener()
end

function var_0_0._btnchangebtnOnClick(arg_4_0)
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicFreeInstrumentSetView()
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

function var_0_0.initNoteItemList(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._addNoteItem = arg_8_1
	arg_8_0._noteView = arg_8_2

	for iter_8_0 = 1, 7 do
		arg_8_0._addNoteItem(arg_8_0._noteView, arg_8_0._gocontent):onUpdateMO(iter_8_0, arg_8_0)
	end
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._instrumentId = arg_9_1
	arg_9_0._instrumentConfig = arg_9_0._instrumentId and lua_activity179_instrument.configDict[arg_9_0._instrumentId] or nil
	arg_9_0._txtname.text = arg_9_0._instrumentConfig and arg_9_0._instrumentConfig.name or luaLang("MusicFreeNoInstrument")

	gohelper.setActive(arg_9_0._gocontent, arg_9_0._instrumentConfig ~= nil)
	gohelper.setActive(arg_9_0._imageicon, arg_9_0._instrumentConfig ~= nil)
	gohelper.setActive(arg_9_0._goempty, arg_9_0._instrumentConfig == nil)
	gohelper.setActive(arg_9_0._goimageFrame, arg_9_0._instrumentConfig ~= nil)
	gohelper.setActive(arg_9_0._imagenullicon, arg_9_0._instrumentConfig == nil)

	if arg_9_0._instrumentConfig then
		UISpriteSetMgr.instance:setMusicSprite(arg_9_0._imageicon, "v2a4_bakaluoer_freeinstrument_" .. arg_9_0._instrumentConfig.icon)
	end
end

function var_0_0.getNoteAudioId(arg_10_0, arg_10_1)
	if arg_10_0._instrumentId == 0 then
		return
	end

	local var_10_0 = Activity179Config.instance:getNoteConfig(arg_10_0._instrumentId, arg_10_1)

	return var_10_0 and var_10_0.resource
end

function var_0_0.onSelect(arg_11_0, arg_11_1)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
