module("modules.logic.versionactivity1_2.jiexika.view.Activity114PhotoView", package.seeall)

local var_0_0 = class("Activity114PhotoView", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._path = arg_1_1
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0.go = arg_2_0.viewGO

	if arg_2_0._path then
		arg_2_0.go = gohelper.findChild(arg_2_0.viewGO, arg_2_0._path)
		arg_2_0._simagebg = gohelper.findChildSingleImage(arg_2_0.viewGO, "#simage_bg")

		arg_2_0._simagebg:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("photo/bg.png"))
	end

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:addEventCb(Activity114Controller.instance, Activity114Event.OnCGUpdate, arg_3_0.updatePhotos, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0:removeEventCb(Activity114Controller.instance, Activity114Event.OnCGUpdate, arg_4_0.updatePhotos, arg_4_0)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._photos = arg_5_0:getUserDataTb_()
	arg_5_0._photosEmpty = arg_5_0:getUserDataTb_()

	local var_5_0 = Activity114Config.instance:getPhotoCoList(Activity114Model.instance.id)

	for iter_5_0 = 1, 9 do
		arg_5_0._photos[iter_5_0] = gohelper.findChildSingleImage(arg_5_0.go, tostring(iter_5_0))
		arg_5_0._photosEmpty[iter_5_0] = gohelper.findChild(arg_5_0.go, "empty/" .. tostring(iter_5_0))

		arg_5_0._photos[iter_5_0]:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("photo/" .. var_5_0[iter_5_0].bigCg .. ".png"))
		arg_5_0:addClickCb(gohelper.findChildButtonWithAudio(arg_5_0.go, "btn_click" .. iter_5_0), arg_5_0.clickPhoto, arg_5_0, iter_5_0)
	end

	arg_5_0:updatePhotos()

	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.ActivityJieXiKaPhoto, 0) then
		Activity114Rpc.instance:markPhotoRed(Activity114Model.instance.id)
	end
end

function var_0_0.clickPhoto(arg_6_0, arg_6_1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_open)
	ViewMgr.instance:openView(ViewName.Activity114FullPhotoView, arg_6_1)
end

function var_0_0.updatePhotos(arg_7_0)
	for iter_7_0 = 1, 9 do
		gohelper.setActive(arg_7_0._photos[iter_7_0].gameObject, Activity114Model.instance.unLockPhotoDict[iter_7_0])
		gohelper.setActive(arg_7_0._photosEmpty[iter_7_0], not Activity114Model.instance.unLockPhotoDict[iter_7_0])
	end
end

function var_0_0.onOpen(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_detailed_tabs_click)
end

function var_0_0.onClose(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_Insight_close)
end

function var_0_0.onDestroyView(arg_10_0)
	for iter_10_0 = 1, 9 do
		arg_10_0._photos[iter_10_0]:UnLoadImage()
	end

	if arg_10_0._simagebg then
		arg_10_0._simagebg:UnLoadImage()
	end
end

return var_0_0
