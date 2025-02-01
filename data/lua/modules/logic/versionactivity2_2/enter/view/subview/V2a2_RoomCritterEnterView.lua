module("modules.logic.versionactivity2_2.enter.view.subview.V2a2_RoomCritterEnterView", package.seeall)

slot0 = class("V2a2_RoomCritterEnterView", VersionActivityEnterBaseSubView)

function slot0.onInitView(slot0)
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_start")
	slot0._imagereddot = gohelper.findChildImage(slot0.viewGO, "#btn_start/#image_reddot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstart:RemoveClickListener()
end

function slot0._btnstartOnClick(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Room) then
		RoomController.instance:enterRoom(RoomEnum.GameMode.Ob)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Room))
	end
end

function slot0._editableInitView(slot0)
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "Right/txt_dec")
	slot0.actId = VersionActivity2_2Enum.ActivityId.RoomCritter
	slot0.actCo = ActivityConfig.instance:getActivityCo(slot0.actId)

	if slot0.actCo and slot0._txtdesc then
		slot0._txtdesc.text = slot0.actCo.actDesc
	end
end

return slot0
