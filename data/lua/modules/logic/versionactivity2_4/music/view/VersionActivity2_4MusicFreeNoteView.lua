module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeNoteView", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicFreeNoteView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomusic1 = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_music1")
	arg_1_0._gomusic2 = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_music2")
	arg_1_0._goinstruments = gohelper.findChild(arg_1_0.viewGO, "root/right/bottom/#go_instruments")

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
	return
end

function var_0_0._initNoteList(arg_5_0)
	arg_5_0._noteList = arg_5_0:getUserDataTb_()

	for iter_5_0 = 1, 2 do
		arg_5_0:_addNoteListItem(iter_5_0)
	end

	arg_5_0:_updateNoteListItem()
end

function var_0_0._addNoteListItem(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.viewContainer:getSetting().otherRes[2]
	local var_6_1 = arg_6_0:getResInst(var_6_0, arg_6_0["_gomusic" .. arg_6_1], "note_" .. tostring(arg_6_1))
	local var_6_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_1, VersionActivity2_4MusicFreeNoteListItem)

	table.insert(arg_6_0._noteList, arg_6_1, var_6_2)
	var_6_2:initNoteItemList(arg_6_0._addNoteItem, arg_6_0)
end

function var_0_0._updateNoteListItem(arg_7_0)
	local var_7_0 = VersionActivity2_4MusicFreeModel.instance:getInstrumentIndexList()

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._noteList) do
		iter_7_1:onUpdateMO(var_7_0[iter_7_0])
	end
end

function var_0_0._addNoteItem(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.viewContainer:getSetting().otherRes[3]
	local var_8_1 = arg_8_0:getResInst(var_8_0, arg_8_1)

	return (MonoHelper.addNoUpdateLuaComOnceToGo(var_8_1, VersionActivity2_4MusicFreeNoteItem))
end

function var_0_0._initInstruments(arg_9_0)
	arg_9_0._instrumentList = arg_9_0:getUserDataTb_()

	local var_9_0 = Activity179Config.instance:getInstrumentNoSwitchList()

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		arg_9_0:_addInstrumentItem(iter_9_0):onUpdateMO(iter_9_1)
	end
end

function var_0_0._addInstrumentItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.viewContainer:getSetting().otherRes[4]
	local var_10_1 = arg_10_0:getResInst(var_10_0, arg_10_0._goinstruments, "instrument_" .. tostring(arg_10_1))
	local var_10_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_1, VersionActivity2_4MusicFreeInstrumentItem)

	table.insert(arg_10_0._instrumentList, arg_10_1, var_10_2)

	return var_10_2
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.InstrumentSelectChange, arg_12_0._onInstrumentSelectChange, arg_12_0)
	arg_12_0:_initNoteList()
	arg_12_0:_initInstruments()
end

function var_0_0._onInstrumentSelectChange(arg_13_0)
	arg_13_0:_updateNoteListItem()
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
