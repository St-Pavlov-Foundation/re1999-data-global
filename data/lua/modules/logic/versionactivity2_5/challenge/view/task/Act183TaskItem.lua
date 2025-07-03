module("modules.logic.versionactivity2_5.challenge.view.task.Act183TaskItem", package.seeall)

local var_0_0 = class("Act183TaskItem", Act183TaskBaseItem)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.go, "txt_desc")
	arg_1_0._imagepoint = gohelper.findChildImage(arg_1_0.go, "image_point")
	arg_1_0._btncanget = gohelper.findChildButtonWithAudio(arg_1_0.go, "btn_canget")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.go, "go_hasget")
	arg_1_0._btnjump = gohelper.findChildButtonWithAudio(arg_1_0.go, "btn_jump")
	arg_1_0._goscrollcontent = gohelper.findChild(arg_1_0.go, "scroll_reward/Viewport/Content")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.go, "scroll_reward/Viewport/Content/go_rewarditem")
end

function var_0_0.addEventListeners(arg_2_0)
	var_0_0.super.addEventListeners(arg_2_0)
	arg_2_0._btncanget:AddClickListener(arg_2_0._btncangetOnClick, arg_2_0)
	arg_2_0._btnjump:AddClickListener(arg_2_0._btnjumpOnClick, arg_2_0)
	arg_2_0:addEventCb(Act183Controller.instance, Act183Event.ClickToGetReward, arg_2_0._onReceiveGetRewardInfo, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	var_0_0.super.removeEventListeners(arg_3_0)
	arg_3_0._btncanget:RemoveClickListener()
	arg_3_0._btnjump:RemoveClickListener()
end

function var_0_0._btncangetOnClick(arg_4_0)
	if not arg_4_0._canGet then
		return
	end

	arg_4_0:setBlock(true)
	arg_4_0._animatorPlayer:Play("finish", arg_4_0._sendRpcToFinishTask, arg_4_0)
end

function var_0_0._sendRpcToFinishTask(arg_5_0)
	local var_5_0 = arg_5_0._taskId

	TaskRpc.instance:sendFinishTaskRequest(arg_5_0._taskId, function(arg_6_0, arg_6_1)
		if arg_6_1 ~= 0 then
			return
		end

		Act183Helper.showToastWhileGetTaskRewards({
			var_5_0
		})
	end)
	arg_5_0:setBlock(false)
end

function var_0_0._btnjumpOnClick(arg_7_0)
	GameFacade.jump(arg_7_0._config.jumpId)
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	var_0_0.super.onUpdateMO(arg_8_0, arg_8_1, arg_8_2, arg_8_3)

	arg_8_0._taskMo = arg_8_1.data
	arg_8_0._config = arg_8_1.data and arg_8_1.data.config
	arg_8_0._taskId = arg_8_1.data and arg_8_1.data.id
	arg_8_0._canGet = Act183Helper.isTaskCanGetReward(arg_8_0._taskId)
	arg_8_0._hasGet = Act183Helper.isTaskHasGetReward(arg_8_0._taskId)

	arg_8_0:refresh()
end

function var_0_0.refresh(arg_9_0)
	arg_9_0._txtdesc.text = arg_9_0._config.desc

	gohelper.setActive(arg_9_0._btncanget.gameObject, arg_9_0._canGet)
	gohelper.setActive(arg_9_0._btnjump.gameObject, not arg_9_0._canGet and not arg_9_0._hasGet)
	gohelper.setActive(arg_9_0._gohasget, arg_9_0._hasGet)

	if not string.nilorempty(arg_9_0._config.bonus) then
		local var_9_0 = DungeonConfig.instance:getRewardItems(tonumber(arg_9_0._config.bonus))
		local var_9_1 = {}
		local var_9_2 = arg_9_0:_generateBadgeItemConfig()

		table.insert(var_9_1, var_9_2)

		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			table.insert(var_9_1, {
				isIcon = true,
				materilType = iter_9_1[1],
				materilId = iter_9_1[2],
				quantity = iter_9_1[3]
			})
		end

		IconMgr.instance:getCommonPropItemIconList(arg_9_0, arg_9_0._onItemShow, var_9_1, arg_9_0._goscrollcontent)
	else
		logError(string.format("任务缺少奖励配置 taskId = %s", arg_9_0._config.id))
	end
end

function var_0_0._generateBadgeItemConfig(arg_10_0)
	if arg_10_0._config.badgeNum > 0 then
		local var_10_0, var_10_1 = Act183Helper.getBadgeItemConfig()

		if var_10_0 and var_10_1 then
			arg_10_0._badgeMaterilType = var_10_0
			arg_10_0._badgeMaterilId = var_10_1

			return {
				isIcon = true,
				materilType = var_10_0,
				materilId = var_10_1,
				quantity = arg_10_0._config.badgeNum
			}
		end
	end
end

function var_0_0._onItemShow(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_1:onUpdateMO(arg_11_2)
	arg_11_1:setConsume(true)
	arg_11_1:showStackableNum2()
	arg_11_1:isShowEffect(true)
	arg_11_1:isShowQuality(true)
	arg_11_1:setAutoPlay(true)
	arg_11_1:setCountFontSize(48)
	arg_11_1:customOnClickCallback(function()
		if arg_11_2.materilType == arg_11_0._badgeMaterilType and arg_11_2.materilId == arg_11_0._badgeMaterilId then
			return
		end

		MaterialTipController.instance:showMaterialInfo(tonumber(arg_11_2.materilType), arg_11_2.materilId)
	end)
end

function var_0_0._onReceiveGetRewardInfo(arg_13_0, arg_13_1)
	if arg_13_0._taskId ~= arg_13_1 or not arg_13_0.go.activeInHierarchy then
		return
	end

	arg_13_0._animatorPlayer:Play("finish", function()
		return
	end, arg_13_0)
end

return var_0_0
