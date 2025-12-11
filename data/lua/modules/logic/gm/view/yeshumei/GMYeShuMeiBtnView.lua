module("modules.logic.gm.view.yeshumei.GMYeShuMeiBtnView", package.seeall)

local var_0_0 = class("GMYeShuMeiBtnView", GMSubViewBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.tabName = "野树莓"
end

function var_0_0.addLineIndex(arg_2_0)
	arg_2_0.lineIndex = arg_2_0.lineIndex + 1
end

function var_0_0.getLineGroup(arg_3_0)
	return "L" .. arg_3_0.lineIndex
end

function var_0_0.initViewContent(arg_4_0)
	if arg_4_0._inited then
		return
	end

	GMSubViewBase.initViewContent(arg_4_0)
	arg_4_0:addButton("L1", "打开野树莓编辑器", arg_4_0._openGMYeShuMeiView, arg_4_0)

	arg_4_0._act211EpisodeId = arg_4_0:addInputText("L2", nil, "关卡ID")

	arg_4_0:addButton("L2", "打开指定关卡", arg_4_0._openGame, arg_4_0)
	arg_4_0:addButton("L3", "打开选关界面", arg_4_0._openLevelView, arg_4_0)
	arg_4_0:addButton("L4", "完成当前关卡", arg_4_0._finishCurrentGame, arg_4_0)
end

function var_0_0._openGMYeShuMeiView(arg_5_0)
	GMYeShuMeiModel.instance:clearData()
	YeShuMeiConfig.instance:_initYeShuMeiLevelData()
	ViewMgr.instance:openView(ViewName.GMYeShuMeiView)
	ViewMgr.instance:closeView(ViewName.GMToolView)
end

function var_0_0._openGame(arg_6_0)
	local var_6_0 = tonumber(arg_6_0._act211EpisodeId:GetText())
	local var_6_1 = YeShuMeiConfig.instance:getYeShuMeiEpisodeConfigById(VersionActivity3_1Enum.ActivityId.YeShuMei, var_6_0)

	if not var_6_1 then
		GameFacade.showToastString("关卡配置不存在")

		return
	end

	if var_6_1.gameId == 0 then
		GameFacade.showToastString("不是游戏关卡")

		return
	end

	YeShuMeiGameController.instance:enterGame(var_6_0)
end

function var_0_0._openLevelView(arg_7_0)
	YeShuMeiController.instance:enterLevelView()
end

function var_0_0._finishCurrentGame(arg_8_0)
	local var_8_0 = YeShuMeiModel.instance:getCurEpisode()

	YeShuMeiController.instance:_onGameFinished(VersionActivity3_1Enum.ActivityId.YeShuMei, var_8_0)
end

return var_0_0
