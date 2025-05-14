module("modules.logic.versionactivity1_2.jiexika.view.Activity114GetPhotoView", package.seeall)

local var_0_0 = class("Activity114GetPhotoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg2")
	arg_1_0._simagebg3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg3")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simagephoto = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_photo")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_name")
	arg_1_0._txtnameen = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_name/#txt_nameen")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.showNext, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_reward_ending)

	arg_4_0._index = 0

	arg_4_0._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))
	arg_4_0._simagebg3:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("photo/img_huode_bg.png"))
	arg_4_0:showNext()
end

function var_0_0.onClose(arg_5_0)
	arg_5_0._simagebg1:UnLoadImage()
	arg_5_0._simagebg3:UnLoadImage()
	arg_5_0._simagephoto:UnLoadImage()
end

function var_0_0.showNext(arg_6_0)
	arg_6_0._index = arg_6_0._index + 1

	if arg_6_0._index > #Activity114Model.instance.newPhotos then
		Activity114Model.instance.newPhotos = {}

		arg_6_0:closeThis()

		return
	end

	local var_6_0 = Activity114Model.instance.newPhotos[arg_6_0._index]
	local var_6_1 = Activity114Config.instance:getPhotoCoList(Activity114Model.instance.id)
	local var_6_2 = var_6_1[var_6_0]

	arg_6_0._simagephoto:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("photo/" .. var_6_1[var_6_0].bigCg .. ".png"))

	arg_6_0._txtname.text = var_6_2.name
	arg_6_0._txtnameen.text = var_6_2.nameEn
end

return var_0_0
