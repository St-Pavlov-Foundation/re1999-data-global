module("modules.logic.seasonver.act123.view2_0.Season123_2_0EpisodeListCenter", package.seeall)

local var_0_0 = class("Season123_2_0EpisodeListCenter", UserDataDispose)

function var_0_0.ctor(arg_1_0)
	arg_1_0:__onInit()
end

function var_0_0.dispose(arg_2_0)
	arg_2_0:__onDispose()
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.viewGO = arg_3_1

	arg_3_0:initComponent()
end

function var_0_0.initComponent(arg_4_0)
	arg_4_0._txtpassround = gohelper.findChildText(arg_4_0.viewGO, "#go_time/#txt_time")
	arg_4_0._txtmapname = gohelper.findChildText(arg_4_0.viewGO, "#txt_mapname")
	arg_4_0._gotime = gohelper.findChild(arg_4_0.viewGO, "#go_time")
	arg_4_0._tftime = arg_4_0._gotime.transform
	arg_4_0._goprogress = gohelper.findChild(arg_4_0.viewGO, "progress")
	arg_4_0._progressActives = arg_4_0:getUserDataTb_()
	arg_4_0._progressDeactives = arg_4_0:getUserDataTb_()
	arg_4_0._progressHard = arg_4_0:getUserDataTb_()

	for iter_4_0 = 1, Activity123Enum.SeasonStageStepCount do
		arg_4_0._progressActives[iter_4_0] = gohelper.findChild(arg_4_0.viewGO, string.format("progress/#go_progress%s/light", iter_4_0))
		arg_4_0._progressDeactives[iter_4_0] = gohelper.findChild(arg_4_0.viewGO, string.format("progress/#go_progress%s/dark", iter_4_0))
		arg_4_0._progressHard[iter_4_0] = gohelper.findChild(arg_4_0.viewGO, string.format("progress/#go_progress%s/red", iter_4_0))
	end
end

function var_0_0.initData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._actId = arg_5_1
	arg_5_0._stageId = arg_5_2
end

function var_0_0.refreshUI(arg_6_0)
	if not arg_6_0._stageId then
		return
	end

	local var_6_0 = Season123Config.instance:getStageCo(arg_6_0._actId, arg_6_0._stageId)

	if var_6_0 then
		arg_6_0._txtmapname.text = var_6_0.name
	end

	arg_6_0:refreshRound()
	arg_6_0:refreshProgress()
end

function var_0_0.refreshRound(arg_7_0)
	local var_7_0 = Season123Model.instance:getActInfo(arg_7_0._actId)

	if var_7_0 then
		if var_7_0:getStageMO(arg_7_0._stageId) then
			local var_7_1 = var_7_0:getTotalRound(arg_7_0._stageId)

			gohelper.setActive(arg_7_0._gotime, true)

			arg_7_0._txtpassround.text = tostring(var_7_1)
		else
			gohelper.setActive(arg_7_0._gotime, false)
		end
	else
		gohelper.setActive(arg_7_0._gotime, false)
	end
end

var_0_0.NoStarTimeAnchorY = -176
var_0_0.WithStarTimeAnchorY = -86

function var_0_0.refreshProgress(arg_8_0)
	local var_8_0 = Season123EpisodeListModel.instance:stageIsPassed()

	gohelper.setActive(arg_8_0._goprogress, var_8_0)

	local var_8_1 = var_8_0

	if var_8_0 then
		local var_8_2, var_8_3 = Season123ProgressUtils.getStageProgressStep(arg_8_0._actId, arg_8_0._stageId)

		var_8_1 = var_8_1 and var_8_3 > 0

		for iter_8_0 = 1, Activity123Enum.SeasonStageStepCount do
			local var_8_4 = iter_8_0 <= var_8_2
			local var_8_5 = iter_8_0 <= var_8_3

			gohelper.setActive(arg_8_0._progressActives[iter_8_0], var_8_4 and iter_8_0 < var_8_3)
			gohelper.setActive(arg_8_0._progressDeactives[iter_8_0], not var_8_4 and var_8_5)
			gohelper.setActive(arg_8_0._progressHard[iter_8_0], iter_8_0 == var_8_3 and var_8_2 == var_8_3)
		end
	end

	if var_8_1 then
		recthelper.setAnchorY(arg_8_0._tftime, var_0_0.WithStarTimeAnchorY)
	else
		recthelper.setAnchorY(arg_8_0._tftime, var_0_0.NoStarTimeAnchorY)
	end
end

return var_0_0
