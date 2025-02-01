module("modules.logic.versionactivity1_2.jiexika.view.Activity114PhotoView", package.seeall)

slot0 = class("Activity114PhotoView", BaseView)

function slot0.ctor(slot0, slot1)
	slot0._path = slot1
end

function slot0.onInitView(slot0)
	slot0.go = slot0.viewGO

	if slot0._path then
		slot0.go = gohelper.findChild(slot0.viewGO, slot0._path)
		slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")

		slot0._simagebg:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("photo/bg.png"))
	end

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Activity114Controller.instance, Activity114Event.OnCGUpdate, slot0.updatePhotos, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(Activity114Controller.instance, Activity114Event.OnCGUpdate, slot0.updatePhotos, slot0)
end

function slot0._editableInitView(slot0)
	slot0._photos = slot0:getUserDataTb_()
	slot0._photosEmpty = slot0:getUserDataTb_()

	for slot5 = 1, 9 do
		slot0._photos[slot5] = gohelper.findChildSingleImage(slot0.go, tostring(slot5))
		slot0._photosEmpty[slot5] = gohelper.findChild(slot0.go, "empty/" .. tostring(slot5))

		slot0._photos[slot5]:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("photo/" .. Activity114Config.instance:getPhotoCoList(Activity114Model.instance.id)[slot5].bigCg .. ".png"))
		slot0:addClickCb(gohelper.findChildButtonWithAudio(slot0.go, "btn_click" .. slot5), slot0.clickPhoto, slot0, slot5)
	end

	slot0:updatePhotos()

	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.ActivityJieXiKaPhoto, 0) then
		Activity114Rpc.instance:markPhotoRed(Activity114Model.instance.id)
	end
end

function slot0.clickPhoto(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_open)
	ViewMgr.instance:openView(ViewName.Activity114FullPhotoView, slot1)
end

function slot0.updatePhotos(slot0)
	for slot4 = 1, 9 do
		gohelper.setActive(slot0._photos[slot4].gameObject, Activity114Model.instance.unLockPhotoDict[slot4])
		gohelper.setActive(slot0._photosEmpty[slot4], not Activity114Model.instance.unLockPhotoDict[slot4])
	end
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_detailed_tabs_click)
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_Insight_close)
end

function slot0.onDestroyView(slot0)
	for slot4 = 1, 9 do
		slot0._photos[slot4]:UnLoadImage()
	end

	if slot0._simagebg then
		slot0._simagebg:UnLoadImage()
	end
end

return slot0
