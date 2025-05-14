module("modules.logic.versionactivity2_5.autochess.view.AutoChessLevelView", package.seeall)

local var_0_0 = class("AutoChessLevelView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goStageRoot = gohelper.findChild(arg_1_0.viewGO, "#go_StageRoot")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	return
end

function var_0_0.onOpen(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_copy_enter)

	arg_3_0.levelItemDic = arg_3_0:getUserDataTb_()

	for iter_3_0 = 1, 6 do
		local var_3_0 = lua_auto_chess_episode.configList[iter_3_0]
		local var_3_1 = gohelper.findChild(arg_3_0._goStageRoot, "go_Stage" .. iter_3_0)
		local var_3_2 = arg_3_0:getResInst(AutoChessEnum.LevelItemPath, var_3_1, "stage" .. iter_3_0)
		local var_3_3

		var_3_3.goArrow, var_3_3 = gohelper.findChild(var_3_1, "go_Arrow" .. iter_3_0), MonoHelper.addNoUpdateLuaComOnceToGo(var_3_2, AutoChessLevelItem, arg_3_0)

		var_3_3:setData(var_3_0)

		local var_3_4, var_3_5, var_3_6 = transformhelper.getLocalRotation(var_3_1.transform)

		transformhelper.setLocalRotation(var_3_3._goRewardTips.transform, 0, 0, -var_3_6)

		arg_3_0.levelItemDic[var_3_0.id] = var_3_3
	end
end

function var_0_0.onClickItem(arg_4_0, arg_4_1)
	if arg_4_0.openRewardId then
		arg_4_0.levelItemDic[arg_4_0.openRewardId]:closeReward()

		arg_4_0.openRewardId = nil
	else
		arg_4_0.levelItemDic[arg_4_1]:enterLevel()
	end
end

function var_0_0.onOpenItemReward(arg_5_0, arg_5_1)
	if arg_5_0.openRewardId then
		arg_5_0.levelItemDic[arg_5_0.openRewardId]:closeReward()

		arg_5_0.openRewardId = nil
	else
		arg_5_0.levelItemDic[arg_5_1]:openReward()

		arg_5_0.openRewardId = arg_5_1
	end
end

function var_0_0.onCloseItemReward(arg_6_0, arg_6_1)
	arg_6_0.levelItemDic[arg_6_1]:closeReward()

	arg_6_0.openRewardId = nil
end

function var_0_0.onGiveUpGame(arg_7_0, arg_7_1)
	if arg_7_0.openRewardId then
		arg_7_0.levelItemDic[arg_7_0.openRewardId]:closeReward()

		arg_7_0.openRewardId = nil
	else
		GameFacade.showOptionMessageBox(MessageBoxIdDefine.AutoChessGiveUpGame, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, function()
			AutoChessRpc.instance:sendAutoChessGiveUpRequest(AutoChessEnum.ModuleId.PVE)
		end)
	end
end

return var_0_0
