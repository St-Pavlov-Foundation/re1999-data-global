module("modules.logic.dungeon.view.puzzle.DungeonPuzzleMazeDrawView", package.seeall)

local var_0_0 = class("DungeonPuzzleMazeDrawView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._simagemap = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_map")
	arg_1_0._simagedecorate = gohelper.findChildSingleImage(arg_1_0.viewGO, "forbidentips/#simage_decorate")
	arg_1_0._simagetipsbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "tips/#simage_tipsbg")
	arg_1_0._gomap = gohelper.findChild(arg_1_0.viewGO, "#go_map")
	arg_1_0._goconnect = gohelper.findChild(arg_1_0.viewGO, "#go_connect")
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
	arg_4_0._simagemap:LoadImage(ResUrl.getDungeonPuzzleBg("bg_ditubeijing"))
	arg_4_0._simagedecorate:LoadImage(ResUrl.getDungeonPuzzleBg("bg_tishiyemian"))
	arg_4_0._simagetipsbg:LoadImage(ResUrl.getDungeonPuzzleBg("bg_tishiyemian_1"))
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(DungeonPuzzleMazeDrawController.instance, DungeonPuzzleEvent.MazeDrawGameClear, arg_6_0.onGameClear, arg_6_0)
end

function var_0_0.onGameClear(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_character)
	gohelper.setActive(arg_7_0._gofinish, true)
	GameFacade.showToast(ToastEnum.DungeonPuzzle2)

	local var_7_0 = DungeonPuzzleMazeDrawModel.instance:getElementCo()

	DungeonRpc.instance:sendPuzzleFinishRequest(var_7_0.id)
end

function var_0_0.onClose(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local var_8_0 = DungeonPuzzleMazeDrawModel.instance:getElementCo()

	if var_8_0 and DungeonMapModel.instance:hasMapPuzzleStatus(var_8_0.id) then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, var_8_0.id)
	end

	DungeonPuzzleMazeDrawController.instance:release()
	DungeonPuzzleMazeDrawModel.instance:release()
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0._simagebg:UnLoadImage()
	arg_9_0._simagemap:UnLoadImage()
	arg_9_0._simagedecorate:UnLoadImage()
	arg_9_0._simagetipsbg:UnLoadImage()
end

return var_0_0
