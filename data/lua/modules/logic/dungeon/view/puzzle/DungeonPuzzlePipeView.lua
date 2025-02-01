module("modules.logic.dungeon.view.puzzle.DungeonPuzzlePipeView", package.seeall)

slot0 = class("DungeonPuzzlePipeView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._simagemap = gohelper.findChildSingleImage(slot0.viewGO, "#simage_map")
	slot0._gomap = gohelper.findChild(slot0.viewGO, "#go_map")
	slot0._gocell1 = gohelper.findChild(slot0.viewGO, "#go_map/#go_cell_1")
	slot0._gocell2 = gohelper.findChild(slot0.viewGO, "#go_map/#go_cell_2")
	slot0._gocell3 = gohelper.findChild(slot0.viewGO, "#go_map/#go_cell_3")
	slot0._goflag = gohelper.findChild(slot0.viewGO, "#go_map/#go_flag")
	slot0._gofinish = gohelper.findChild(slot0.viewGO, "#go_finish")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getDungeonPuzzleBg("full/bg_jiemi_beijigntu"))
	slot0._simagemap:LoadImage(ResUrl.getDungeonPuzzleBg("bg_jiemi_zhizhang_2"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(DungeonPuzzlePipeController.instance, DungeonPuzzleEvent.PipeGameClear, slot0._onGameClear, slot0)
end

function slot0._onGameClear(slot0)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_achievement)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_character)
	gohelper.setActive(slot0._gofinish, true)
	GameFacade.showToast(ToastEnum.DungeonPuzzle2)
	DungeonRpc.instance:sendPuzzleFinishRequest(DungeonPuzzlePipeModel.instance:getElementCo().id)
end

function slot0.onCloseFinish(slot0)
	if DungeonPuzzlePipeModel.instance:getElementCo() and DungeonMapModel.instance:hasMapPuzzleStatus(slot1.id) then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, slot1.id)
	end

	DungeonPuzzlePipeModel.instance:release()
	DungeonPuzzlePipeController.instance:release()
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagemap:UnLoadImage()
end

return slot0
