module("modules.logic.dungeon.view.puzzle.DungeonPuzzlePipeView", package.seeall)

local var_0_0 = class("DungeonPuzzlePipeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._simagemap = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_map")
	arg_1_0._gomap = gohelper.findChild(arg_1_0.viewGO, "#go_map")
	arg_1_0._gocell1 = gohelper.findChild(arg_1_0.viewGO, "#go_map/#go_cell_1")
	arg_1_0._gocell2 = gohelper.findChild(arg_1_0.viewGO, "#go_map/#go_cell_2")
	arg_1_0._gocell3 = gohelper.findChild(arg_1_0.viewGO, "#go_map/#go_cell_3")
	arg_1_0._goflag = gohelper.findChild(arg_1_0.viewGO, "#go_map/#go_flag")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "#go_finish")

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
	arg_4_0._simagebg:LoadImage(ResUrl.getDungeonPuzzleBg("full/bg_jiemi_beijigntu"))
	arg_4_0._simagemap:LoadImage(ResUrl.getDungeonPuzzleBg("bg_jiemi_zhizhang_2"))
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(DungeonPuzzlePipeController.instance, DungeonPuzzleEvent.PipeGameClear, arg_6_0._onGameClear, arg_6_0)
end

function var_0_0._onGameClear(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_achievement)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_character)
	gohelper.setActive(arg_7_0._gofinish, true)
	GameFacade.showToast(ToastEnum.DungeonPuzzle2)

	local var_7_0 = DungeonPuzzlePipeModel.instance:getElementCo()

	DungeonRpc.instance:sendPuzzleFinishRequest(var_7_0.id)
end

function var_0_0.onCloseFinish(arg_8_0)
	local var_8_0 = DungeonPuzzlePipeModel.instance:getElementCo()

	if var_8_0 and DungeonMapModel.instance:hasMapPuzzleStatus(var_8_0.id) then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, var_8_0.id)
	end

	DungeonPuzzlePipeModel.instance:release()
	DungeonPuzzlePipeController.instance:release()
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0._simagebg:UnLoadImage()
	arg_9_0._simagemap:UnLoadImage()
end

return var_0_0
