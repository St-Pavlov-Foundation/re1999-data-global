module("modules.logic.versionactivity2_5.autochess.view.AutoChessLevelView", package.seeall)

slot0 = class("AutoChessLevelView", BaseView)

function slot0.onInitView(slot0)
	slot0._goStageRoot = gohelper.findChild(slot0.viewGO, "#go_StageRoot")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_copy_enter)

	slot0.levelItemDic = slot0:getUserDataTb_()

	for slot4 = 1, 6 do
		slot5 = lua_auto_chess_episode.configList[slot4]
		slot6 = gohelper.findChild(slot0._goStageRoot, "go_Stage" .. slot4)
		slot9 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(AutoChessEnum.LevelItemPath, slot6, "stage" .. slot4), AutoChessLevelItem, slot0)
		slot9.goArrow = gohelper.findChild(slot6, "go_Arrow" .. slot4)

		slot9:setData(slot5)

		slot10, slot11, slot12 = transformhelper.getLocalRotation(slot6.transform)

		transformhelper.setLocalRotation(slot9._goRewardTips.transform, 0, 0, -slot12)

		slot0.levelItemDic[slot5.id] = slot9
	end
end

function slot0.onClickItem(slot0, slot1)
	if slot0.openRewardId then
		slot0.levelItemDic[slot0.openRewardId]:closeReward()

		slot0.openRewardId = nil
	else
		slot0.levelItemDic[slot1]:enterLevel()
	end
end

function slot0.onOpenItemReward(slot0, slot1)
	if slot0.openRewardId then
		slot0.levelItemDic[slot0.openRewardId]:closeReward()

		slot0.openRewardId = nil
	else
		slot0.levelItemDic[slot1]:openReward()

		slot0.openRewardId = slot1
	end
end

function slot0.onCloseItemReward(slot0, slot1)
	slot0.levelItemDic[slot1]:closeReward()

	slot0.openRewardId = nil
end

function slot0.onGiveUpGame(slot0, slot1)
	if slot0.openRewardId then
		slot0.levelItemDic[slot0.openRewardId]:closeReward()

		slot0.openRewardId = nil
	else
		GameFacade.showOptionMessageBox(MessageBoxIdDefine.AutoChessGiveUpGame, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, function ()
			AutoChessRpc.instance:sendAutoChessGiveUpRequest(AutoChessEnum.ModuleId.PVE)
		end)
	end
end

return slot0
