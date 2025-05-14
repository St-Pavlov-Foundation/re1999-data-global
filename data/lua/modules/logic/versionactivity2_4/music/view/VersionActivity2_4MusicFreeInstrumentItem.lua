module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeInstrumentItem", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicFreeInstrumentItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#image_icon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._imagecir = gohelper.findChildImage(arg_1_0.viewGO, "#image_cir")
	arg_1_0._goclick = gohelper.findChild(arg_1_0.viewGO, "#go_click")

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
	arg_4_0._clickEffect = gohelper.findChild(arg_4_0.viewGO, "#click")

	MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._goclick, VersionActivity2_4MusicTouchComp, {
		callback = arg_4_0._onClickDown,
		callbackTarget = arg_4_0
	})
end

function var_0_0._onClickDown(arg_5_0)
	local var_5_0 = arg_5_0:getNoteAudioId(1)

	if var_5_0 == nil then
		return
	end

	AudioMgr.instance:trigger(var_5_0)
	gohelper.setActive(arg_5_0._clickEffect, false)
	gohelper.setActive(arg_5_0._clickEffect, true)

	if not VersionActivity2_4MusicFreeModel.instance:isRecording() then
		return
	end

	VersionActivity2_4MusicFreeModel.instance:addNote(var_5_0)
end

function var_0_0.getNoteAudioId(arg_6_0, arg_6_1)
	local var_6_0 = Activity179Config.instance:getNoteConfig(arg_6_0._mo.id, arg_6_1)

	return var_6_0 and var_6_0.resource
end

function var_0_0._editableAddEvents(arg_7_0)
	return
end

function var_0_0._editableRemoveEvents(arg_8_0)
	return
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._mo = arg_9_1
	arg_9_0._txtname.text = arg_9_1.name

	UISpriteSetMgr.instance:setMusicSprite(arg_9_0._imagecir, "v2a4_bakaluoer_freeinstrument_dianji_" .. arg_9_1.icon)
	UISpriteSetMgr.instance:setMusicSprite(arg_9_0._imageicon, "v2a4_bakaluoer_freeinstrument_" .. arg_9_1.icon)
end

function var_0_0.onSelect(arg_10_0, arg_10_1)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
