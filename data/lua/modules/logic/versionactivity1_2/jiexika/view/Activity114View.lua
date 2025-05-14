module("modules.logic.versionactivity1_2.jiexika.view.Activity114View", package.seeall)

local var_0_0 = class("Activity114View", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg/#simage_rightbg")
	arg_1_0._simagemirror = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_mirror")
	arg_1_0._simagemirrorlight2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_mirrorlight2")
	arg_1_0._simagespinemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_spinemask")
	arg_1_0._simageframe = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_spinemask/#simage_frame")
	arg_1_0._simagemirrorlight1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_mirrorlight1")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._simagebg:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("main/img_bg.png"))
	arg_2_0._simagerightbg:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("main/img_bg2.png"))
	arg_2_0._simagemirror:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("bg_jingzi.png"))
	arg_2_0._simagespinemask:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("zz_jingzi.png"))
	arg_2_0._simageframe:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("bg_jingkuang.png"))
	arg_2_0._simagemirrorlight2:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("img_jingzi_fangaung2.png"))
	arg_2_0._simagemirrorlight1:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("img_jingzi_fangaung1.png"))

	arg_2_0._viewAnim = arg_2_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:addEventCb(arg_3_0.viewContainer, ViewEvent.ToSwitchTab, arg_3_0.onTabChange, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0:removeEventCb(arg_4_0.viewContainer, ViewEvent.ToSwitchTab, arg_4_0.onTabChange, arg_4_0)
end

function var_0_0.onTabChange(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_1 ~= 2 then
		return
	end

	if arg_5_2 == Activity114Enum.TabIndex.MainView then
		arg_5_0._viewAnim:Play("start_open", 0, 0)

		arg_5_0._lastOpenView = arg_5_2
	elseif arg_5_2 == Activity114Enum.TabIndex.TaskView then
		arg_5_0._viewAnim:Play("quest_open", 0, 0)

		arg_5_0._lastOpenView = arg_5_2
	elseif arg_5_3 == Activity114Enum.TabIndex.MainView then
		arg_5_0._viewAnim:Play("start_close", 0, 0)
	elseif arg_5_3 == Activity114Enum.TabIndex.TaskView then
		arg_5_0._viewAnim:Play("quest_close", 0, 0)
	else
		arg_5_0._viewAnim:Play("open", 0, 0)
	end
end

function var_0_0.onOpenFinish(arg_6_0)
	arg_6_0._viewAnim.enabled = true
end

function var_0_0.onDestroyView(arg_7_0)
	arg_7_0._simagebg:UnLoadImage()
	arg_7_0._simagerightbg:UnLoadImage()
	arg_7_0._simagespinemask:UnLoadImage()
	arg_7_0._simagemirror:UnLoadImage()
	arg_7_0._simageframe:UnLoadImage()
	arg_7_0._simagemirrorlight2:UnLoadImage()
	arg_7_0._simagemirrorlight1:UnLoadImage()
end

return var_0_0
