module("modules.logic.versionactivity2_2.act173.view.Activity173TaskItem", package.seeall)

local var_0_0 = class("Activity173TaskItem", LuaCompBase)
local var_0_1 = "#392E0F"
local var_0_2 = 0.5
local var_0_3 = "#392E0F"
local var_0_4 = 1
local var_0_5 = "#A5471B"
local var_0_6 = "#392E0F"

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0.go = arg_1_1
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.go, "Title/#txt_Title")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.go, "#txt_Descr")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.go, "image_NumBG/txt_Num")
	arg_1_0._txtProgress = gohelper.findChildText(arg_1_0.go, "#txt_Num")
	arg_1_0._goClaim = gohelper.findChild(arg_1_0.go, "#go_Claim")
	arg_1_0._goGet = gohelper.findChild(arg_1_0.go, "#go_Get")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.go, "#btn_click")
	arg_1_0._simageHeadIcon = gohelper.findChildSingleImage(arg_1_0.go, "#simage_HeadIcon")
	arg_1_0._btnjump = gohelper.findChildButtonWithAudio(arg_1_0.go, "#btn_jump")

	arg_1_0:addEvents()
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._config = arg_2_1

	arg_2_0:initTaskDesc()
	arg_2_0:initReward()
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnclick:AddClickListener(arg_3_0._btnclickOnClick, arg_3_0)
	arg_3_0._btnjump:AddClickListener(arg_3_0._btnjumpOnClick, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnclick:RemoveClickListener()
	arg_4_0._btnjump:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_5_0)
	if arg_5_0._config and arg_5_0._canGetReward then
		TaskRpc.instance:sendFinishTaskRequest(arg_5_0._config.id, arg_5_0._onFinishedTask, arg_5_0)

		return
	end

	if not arg_5_0._bonus or #arg_5_0._bonus <= 0 then
		local var_5_0 = arg_5_0._config and arg_5_0._config.id

		logError("打开物品详情界面失败:缺少奖励配置 任务Id = " .. tostring(var_5_0))

		return
	end

	MaterialTipController.instance:showMaterialInfo(arg_5_0._bonus[1], arg_5_0._bonus[2])
end

function var_0_0._btnjumpOnClick(arg_6_0)
	if arg_6_0._config and arg_6_0._config.jumpId ~= 0 then
		JumpController.instance:jump(arg_6_0._config.jumpId)
	end
end

function var_0_0.initTaskDesc(arg_7_0)
	arg_7_0._txtDescr.text = arg_7_0._config.desc
	arg_7_0._txtTitle.text = arg_7_0._config.name
end

function var_0_0.initReward(arg_8_0)
	arg_8_0._bonus = string.splitToNumber(arg_8_0._config.bonus, "#")

	local var_8_0 = arg_8_0._bonus[3] or 0

	arg_8_0._txtNum.text = luaLang("multiple") .. var_8_0

	arg_8_0:initOrRefreshProgress()

	if arg_8_0:checkIsPortraitReward(arg_8_0._bonus) and arg_8_0._simageHeadIcon then
		if not arg_8_0._liveHeadIcon then
			arg_8_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_8_0._simageHeadIcon)
		end

		arg_8_0._liveHeadIcon:setLiveHead(tonumber(arg_8_0._bonus[2]))
	end
end

function var_0_0.refresh(arg_9_0)
	arg_9_0._taskMo = TaskModel.instance:getTaskById(arg_9_0._config.id)

	local var_9_0 = arg_9_0._taskMo and arg_9_0._taskMo.finishCount > 0
	local var_9_1 = arg_9_0._taskMo and arg_9_0._taskMo.progress or 0

	arg_9_0._canGetReward = arg_9_0._taskMo and var_9_1 >= arg_9_0._config.maxProgress and arg_9_0._taskMo.finishCount <= 0

	gohelper.setActive(arg_9_0._goClaim, arg_9_0._canGetReward)
	gohelper.setActive(arg_9_0._goGet, var_9_0)
	gohelper.setActive(arg_9_0._btnjump.gameObject, not var_9_0)
	arg_9_0:initOrRefreshTaskContentColor(var_9_0)
	arg_9_0:initOrRefreshProgress(var_9_0, var_9_1)
end

function var_0_0.initOrRefreshTaskContentColor(arg_10_0, arg_10_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._txtDescr, arg_10_1 and var_0_1 or var_0_3)
	ZProj.UGUIHelper.SetColorAlpha(arg_10_0._txtDescr, arg_10_1 and var_0_2 or var_0_4)
end

function var_0_0.initOrRefreshProgress(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2 = Activity173Controller.numberDisplay(arg_11_2 or 0)

	local var_11_0 = Activity173Controller.numberDisplay(arg_11_0._config.maxProgress)
	local var_11_1 = arg_11_1 and var_0_6 or var_0_5

	arg_11_0._txtProgress.text = string.format("<%s>%s</color>/%s", var_11_1, arg_11_2, var_11_0)

	SLFramework.UGUI.GuiHelper.SetColor(arg_11_0._txtProgress, arg_11_1 and var_0_1 or var_0_3)
	ZProj.UGUIHelper.SetColorAlpha(arg_11_0._txtProgress, arg_11_1 and var_0_2 or var_0_4)
end

function var_0_0.checkIsPortraitReward(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1[1]
	local var_12_1 = arg_12_1[2]

	if var_12_0 == MaterialEnum.MaterialType.Item then
		local var_12_2 = ItemModel.instance:getItemConfig(var_12_0, var_12_1)

		if var_12_2 and var_12_2.subType == ItemEnum.SubType.Portrait then
			return true
		end
	end
end

function var_0_0._onFinishedTask(arg_13_0)
	arg_13_0:refresh()
end

function var_0_0.destroy(arg_14_0)
	arg_14_0:removeEvents()
end

return var_0_0
