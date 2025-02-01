module("modules.logic.versionactivity1_8.dungeon.view.factory.repairgame.VersionActivity1_8FactoryRepairView", package.seeall)

slot0 = class("VersionActivity1_8FactoryRepairView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtTips = gohelper.findChildText(slot0.viewGO, "#txt_Tips")
	slot0._gofinish = gohelper.findChild(slot0.viewGO, "#go_finish")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.PipeGameClear, slot0._onGameClear, slot0)
	slot0:addEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.ResetGameRefresh, slot0._onResetGame, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.PipeGameClear, slot0._onGameClear, slot0)
	slot0:removeEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.ResetGameRefresh, slot0._onResetGame, slot0)
end

function slot0._onGameClear(slot0)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_achievement)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_character)
	gohelper.setActive(slot0._gofinish, true)
	Activity157Rpc.instance:sendAct157UnlockComponentRequest(slot0.actId, slot0.curComponentId)
end

function slot0._onResetGame(slot0)
	gohelper.setActive(slot0._gofinish, false)
end

function slot0._editableInitView(slot0)
	slot0.actId = Activity157Model.instance:getActId()
	slot0.curComponentId = Activity157RepairGameModel.instance:getCurComponentId()

	gohelper.setActive(slot0._gofinish, false)
end

function slot0.onOpen(slot0)
	slot0._txtTips.text = Activity157Config.instance:getAct157RepairMapTitleTip(slot0.actId, slot0.curComponentId)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
