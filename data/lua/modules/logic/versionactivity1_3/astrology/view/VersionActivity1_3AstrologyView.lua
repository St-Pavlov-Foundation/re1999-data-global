module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologyView", package.seeall)

slot0 = class("VersionActivity1_3AstrologyView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageFullBGCut = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBGCut")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "#simage_Title")
	slot0._goRight = gohelper.findChild(slot0.viewGO, "#go_Right")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")
	slot0._goplate = gohelper.findChild(slot0.viewGO, "#go_plate")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._simageFullBG:LoadImage(ResUrl.getV1a3AstrologySinglebg("v1a3_astrology_fullbg2"))
	VersionActivity1_3AstrologyModel.instance:initData()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_updateResultBg()
	slot0:addEventCb(Activity126Controller.instance, Activity126Event.onUpdateProgressReply, slot0._onUpdateProgressReply, slot0, LuaEventSystem.High)
	slot0:addEventCb(VersionActivity1_3AstrologyController.instance, VersionActivity1_3AstrologyEvent.adjustPreviewAngle, slot0._adjustPreviewAngle, slot0)
	slot0:addEventCb(Activity126Controller.instance, Activity126Event.onResetProgressReply, slot0._onResetProgressReply, slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_astrology_open)
end

function slot0._onResetProgressReply(slot0)
	slot0:_updateResultBg()
end

function slot0._adjustPreviewAngle(slot0)
	slot0:_updateResultBg()
end

function slot0._updateResultBg(slot0)
	if not Activity126Config.instance:getHoroscopeConfig(VersionActivity1_3Enum.ActivityId.Act310, VersionActivity1_3AstrologyModel.instance:getQuadrantResult()) then
		return
	end

	slot0._simageFullBGCut:LoadImage(string.format("singlebg/v1a3_astrology_singlebg/%s.png", slot2.resultIcon))
end

function slot0._onUpdateProgressReply(slot0)
	VersionActivity1_3AstrologyModel.instance:initData()
end

function slot0.onClose(slot0)
	slot0._simageFullBGCut:UnLoadImage()
end

function slot0.onDestroyView(slot0)
	slot0._simageFullBG:UnLoadImage()
end

return slot0
