module("modules.logic.seasonver.act123.view1_8.Season123_1_8TaskMapItem", package.seeall)

local var_0_0 = class("Season123_1_8TaskMapItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.param = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0:__onInit()

	arg_2_0.go = arg_2_1
	arg_2_0.stage = arg_2_0.param.stage
	arg_2_0.actId = arg_2_0.param.actId
	arg_2_0._goroot = gohelper.findChild(arg_2_0.go, "root")
	arg_2_0._simageicon = gohelper.findChildSingleImage(arg_2_0.go, "root/#simage_icon")
	arg_2_0._txtname = gohelper.findChildText(arg_2_0.go, "root/#txt_name")
	arg_2_0._imagechapternum = gohelper.findChildImage(arg_2_0.go, "root/#image_chapternum")
	arg_2_0._goprogress = gohelper.findChild(arg_2_0.go, "root/#go_progress")
	arg_2_0._gofinish = gohelper.findChild(arg_2_0.go, "root/#image_finish")
	arg_2_0._txttime = gohelper.findChildText(arg_2_0.go, "root/#image_finish/#txt_time")
	arg_2_0._canvasGroup = arg_2_0.go:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_2_0.progressItemList = arg_2_0:getUserDataTb_()

	for iter_2_0 = 1, 5 do
		local var_2_0 = {
			progressGO = gohelper.findChild(arg_2_0._goprogress, "#go_progress" .. iter_2_0)
		}

		var_2_0.darkIcon = gohelper.findChild(var_2_0.progressGO, "dark")
		var_2_0.lightIcon = gohelper.findChild(var_2_0.progressGO, "light")
		var_2_0.redIcon = gohelper.findChild(var_2_0.progressGO, "red")

		table.insert(arg_2_0.progressItemList, var_2_0)
	end

	arg_2_0.goreddot = gohelper.findChild(arg_2_0.go, "root/#go_reddot")

	RedDotController.instance:addRedDot(arg_2_0.goreddot, RedDotEnum.DotNode.Season123StageReward, arg_2_0.stage)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addEventCb(Season123Controller.instance, Season123Event.clickTaskMapItem, arg_3_0.setScale, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0:removeEventCb(Season123Controller.instance, Season123Event.clickTaskMapItem, arg_4_0.setScale, arg_4_0)
end

function var_0_0.onMapItemClick(arg_5_0)
	if Season123TaskModel.instance.curStage == arg_5_0.stage then
		return
	end

	Season123TaskModel.instance.curStage = arg_5_0.stage

	local var_5_0 = Season123TaskModel.instance.curTaskType

	if var_5_0 == Activity123Enum.TaskRewardViewType then
		Season123TaskModel.instance:refreshList(var_5_0)
	end

	Season123Controller.instance:dispatchEvent(Season123Event.clickTaskMapItem)
end

function var_0_0.refreshUI(arg_6_0)
	local var_6_0 = Season123Config.instance:getStageCos(arg_6_0.actId)[arg_6_0.stage]
	local var_6_1 = Season123Model.instance:getActInfo(arg_6_0.actId)
	local var_6_2, var_6_3 = var_6_1:getStageRewardCount(arg_6_0.stage)

	UISpriteSetMgr.instance:setSeason123Sprite(arg_6_0._imagechapternum, "v1a7_season_num_" .. arg_6_0.stage, true)

	arg_6_0._txtname.text = var_6_0.name

	local var_6_4 = var_6_1.stageMap[arg_6_0.stage]

	if var_6_4 then
		local var_6_5 = var_6_4.minRound

		arg_6_0._txttime.text = tostring(var_6_5)

		gohelper.setActive(arg_6_0._gofinish, var_6_5 > 0)
	else
		gohelper.setActive(arg_6_0._gofinish, false)
	end

	for iter_6_0 = 1, var_6_3 do
		gohelper.setActive(arg_6_0.progressItemList[iter_6_0].progressGO, true)
		gohelper.setActive(arg_6_0.progressItemList[iter_6_0].lightIcon, iter_6_0 <= var_6_2 and iter_6_0 ~= var_6_3)
		gohelper.setActive(arg_6_0.progressItemList[iter_6_0].darkIcon, var_6_2 < iter_6_0 and var_6_2 < var_6_3)
		gohelper.setActive(arg_6_0.progressItemList[iter_6_0].redIcon, iter_6_0 == var_6_2 and iter_6_0 == var_6_3)
	end

	for iter_6_1 = var_6_3 + 1, #arg_6_0.progressItemList do
		gohelper.setActive(arg_6_0.progressItemList[iter_6_1].progressGO, false)
	end

	arg_6_0._canvasGroup.alpha = Season123TaskModel.instance.curStage == arg_6_0.stage and 1 or 0.5

	local var_6_6 = Season123TaskModel.instance.curStage == arg_6_0.stage and 1 or 0.7

	transformhelper.setLocalScale(arg_6_0._goroot.transform, var_6_6, var_6_6, var_6_6)
end

function var_0_0.setScale(arg_7_0)
	if Season123TaskModel.instance.curStage == arg_7_0.stage then
		arg_7_0.scaleTweenId = ZProj.TweenHelper.DOScale(arg_7_0._goroot.transform, 1, 1, 1, 0.5)
		arg_7_0.canvasTweenId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_7_0.go, arg_7_0._canvasGroup.alpha, 1, 0.5)
	else
		arg_7_0.scaleTweenId = ZProj.TweenHelper.DOScale(arg_7_0._goroot.transform, 0.7, 0.7, 0.7, 0.5)
		arg_7_0.canvasTweenId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_7_0.go, arg_7_0._canvasGroup.alpha, 0.5, 0.5)
	end
end

function var_0_0.onDestroy(arg_8_0)
	arg_8_0:__onDispose()

	if arg_8_0.scaleTweenId then
		ZProj.TweenHelper.KillById(arg_8_0.scaleTweenId)
	end

	if arg_8_0.canvasTweenId then
		ZProj.TweenHelper.KillById(arg_8_0.canvasTweenId)
	end
end

return var_0_0
