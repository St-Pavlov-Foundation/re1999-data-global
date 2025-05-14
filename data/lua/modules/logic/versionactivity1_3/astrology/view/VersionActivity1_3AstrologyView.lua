module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologyView", package.seeall)

local var_0_0 = class("VersionActivity1_3AstrologyView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageFullBGCut = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBGCut")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Title")
	arg_1_0._goRight = gohelper.findChild(arg_1_0.viewGO, "#go_Right")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")
	arg_1_0._goplate = gohelper.findChild(arg_1_0.viewGO, "#go_plate")

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
	arg_4_0._simageFullBG:LoadImage(ResUrl.getV1a3AstrologySinglebg("v1a3_astrology_fullbg2"))
	VersionActivity1_3AstrologyModel.instance:initData()
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:_updateResultBg()
	arg_6_0:addEventCb(Activity126Controller.instance, Activity126Event.onUpdateProgressReply, arg_6_0._onUpdateProgressReply, arg_6_0, LuaEventSystem.High)
	arg_6_0:addEventCb(VersionActivity1_3AstrologyController.instance, VersionActivity1_3AstrologyEvent.adjustPreviewAngle, arg_6_0._adjustPreviewAngle, arg_6_0)
	arg_6_0:addEventCb(Activity126Controller.instance, Activity126Event.onResetProgressReply, arg_6_0._onResetProgressReply, arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_astrology_open)
end

function var_0_0._onResetProgressReply(arg_7_0)
	arg_7_0:_updateResultBg()
end

function var_0_0._adjustPreviewAngle(arg_8_0)
	arg_8_0:_updateResultBg()
end

function var_0_0._updateResultBg(arg_9_0)
	local var_9_0 = VersionActivity1_3AstrologyModel.instance:getQuadrantResult()
	local var_9_1 = Activity126Config.instance:getHoroscopeConfig(VersionActivity1_3Enum.ActivityId.Act310, var_9_0)

	if not var_9_1 then
		return
	end

	arg_9_0._simageFullBGCut:LoadImage(string.format("singlebg/v1a3_astrology_singlebg/%s.png", var_9_1.resultIcon))
end

function var_0_0._onUpdateProgressReply(arg_10_0)
	VersionActivity1_3AstrologyModel.instance:initData()
end

function var_0_0.onClose(arg_11_0)
	arg_11_0._simageFullBGCut:UnLoadImage()
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simageFullBG:UnLoadImage()
end

return var_0_0
