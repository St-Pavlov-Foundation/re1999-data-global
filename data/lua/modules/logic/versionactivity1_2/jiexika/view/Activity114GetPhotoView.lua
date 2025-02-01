module("modules.logic.versionactivity1_2.jiexika.view.Activity114GetPhotoView", package.seeall)

slot0 = class("Activity114GetPhotoView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg2")
	slot0._simagebg3 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg3")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simagephoto = gohelper.findChildSingleImage(slot0.viewGO, "#simage_photo")
	slot0._txtname = gohelper.findChildTextMesh(slot0.viewGO, "#txt_name")
	slot0._txtnameen = gohelper.findChildTextMesh(slot0.viewGO, "#txt_name/#txt_nameen")
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0.showNext, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_reward_ending)

	slot0._index = 0

	slot0._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))
	slot0._simagebg3:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("photo/img_huode_bg.png"))
	slot0:showNext()
end

function slot0.onClose(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simagebg3:UnLoadImage()
	slot0._simagephoto:UnLoadImage()
end

function slot0.showNext(slot0)
	slot0._index = slot0._index + 1

	if slot0._index > #Activity114Model.instance.newPhotos then
		Activity114Model.instance.newPhotos = {}

		slot0:closeThis()

		return
	end

	slot1 = Activity114Model.instance.newPhotos[slot0._index]
	slot2 = Activity114Config.instance:getPhotoCoList(Activity114Model.instance.id)
	slot3 = slot2[slot1]

	slot0._simagephoto:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("photo/" .. slot2[slot1].bigCg .. ".png"))

	slot0._txtname.text = slot3.name
	slot0._txtnameen.text = slot3.nameEn
end

return slot0
