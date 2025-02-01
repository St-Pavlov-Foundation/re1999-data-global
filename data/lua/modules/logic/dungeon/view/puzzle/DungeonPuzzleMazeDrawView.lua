module("modules.logic.dungeon.view.puzzle.DungeonPuzzleMazeDrawView", package.seeall)

slot0 = class("DungeonPuzzleMazeDrawView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._simagemap = gohelper.findChildSingleImage(slot0.viewGO, "#simage_map")
	slot0._simagedecorate = gohelper.findChildSingleImage(slot0.viewGO, "forbidentips/#simage_decorate")
	slot0._simagetipsbg = gohelper.findChildSingleImage(slot0.viewGO, "tips/#simage_tipsbg")
	slot0._gomap = gohelper.findChild(slot0.viewGO, "#go_map")
	slot0._goconnect = gohelper.findChild(slot0.viewGO, "#go_connect")
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
	slot0._simagemap:LoadImage(ResUrl.getDungeonPuzzleBg("bg_ditubeijing"))
	slot0._simagedecorate:LoadImage(ResUrl.getDungeonPuzzleBg("bg_tishiyemian"))
	slot0._simagetipsbg:LoadImage(ResUrl.getDungeonPuzzleBg("bg_tishiyemian_1"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(DungeonPuzzleMazeDrawController.instance, DungeonPuzzleEvent.MazeDrawGameClear, slot0.onGameClear, slot0)
end

function slot0.onGameClear(slot0)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_character)
	gohelper.setActive(slot0._gofinish, true)
	GameFacade.showToast(ToastEnum.DungeonPuzzle2)
	DungeonRpc.instance:sendPuzzleFinishRequest(DungeonPuzzleMazeDrawModel.instance:getElementCo().id)
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if DungeonPuzzleMazeDrawModel.instance:getElementCo() and DungeonMapModel.instance:hasMapPuzzleStatus(slot1.id) then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, slot1.id)
	end

	DungeonPuzzleMazeDrawController.instance:release()
	DungeonPuzzleMazeDrawModel.instance:release()
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagemap:UnLoadImage()
	slot0._simagedecorate:UnLoadImage()
	slot0._simagetipsbg:UnLoadImage()
end

return slot0
