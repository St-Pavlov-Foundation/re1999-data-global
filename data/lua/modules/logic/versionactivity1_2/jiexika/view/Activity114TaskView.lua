module("modules.logic.versionactivity1_2.jiexika.view.Activity114TaskView", package.seeall)

local var_0_0 = class("Activity114TaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagetxtbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_info/#simage_txtbg")
	arg_1_0._viewAnim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

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
	local var_4_0 = ListScrollParam.New()

	var_4_0.scrollGOPath = "#scroll"
	var_4_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_4_0.prefabUrl = "#scroll/item"
	var_4_0.cellClass = Activity114TaskItem
	var_4_0.scrollDir = ScrollEnum.ScrollDirV
	var_4_0.lineCount = 1
	var_4_0.cellWidth = 1150
	var_4_0.cellHeight = 168
	var_4_0.cellSpaceH = 0
	var_4_0.cellSpaceV = 10.5
	var_4_0.startSpace = 5
	var_4_0.frameUpdateMs = 100

	local var_4_1 = {}

	for iter_4_0 = 1, 6 do
		var_4_1[iter_4_0] = iter_4_0 * 0.06
	end

	arg_4_0._csListView = SLFramework.UGUI.ListScrollView.Get(gohelper.findChild(arg_4_0.viewGO, "#scroll"))
	arg_4_0._scrollView = LuaListScrollViewWithAnimator.New(Activity114TaskModel.instance, var_4_0, var_4_1)

	arg_4_0:addChildView(arg_4_0._scrollView)
	arg_4_0._simagetxtbg:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("task/bg_heidi.png"))
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._csListView.VerticalScrollPixel = 0

	arg_5_0._viewAnim:Play("open", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function var_0_0.onOpenFinish(arg_6_0)
	arg_6_0._viewAnim.enabled = true
end

function var_0_0.onClose(arg_7_0)
	arg_7_0._viewAnim:Play("close", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mission_close)
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0._simagetxtbg:UnLoadImage()
end

return var_0_0
