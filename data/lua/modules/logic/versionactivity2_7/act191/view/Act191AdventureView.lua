module("modules.logic.versionactivity2_7.act191.view.Act191AdventureView", package.seeall)

local var_0_0 = class("Act191AdventureView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goLive2d = gohelper.findChild(arg_1_0.viewGO, "live2dcontainer/#go_Live2d")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "#txt_Title")
	arg_1_0._btnEnemyInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#txt_Title/#btn_EnemyInfo")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_Desc")
	arg_1_0._txtTarget = gohelper.findChildText(arg_1_0.viewGO, "#txt_Target")
	arg_1_0._goReward = gohelper.findChild(arg_1_0.viewGO, "#go_Reward")
	arg_1_0._btnNext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Next")
	arg_1_0._txtNext = gohelper.findChildText(arg_1_0.viewGO, "#btn_Next/#txt_Next")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEnemyInfo:AddClickListener(arg_2_0._btnEnemyInfoOnClick, arg_2_0)
	arg_2_0._btnNext:AddClickListener(arg_2_0._btnNextOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnemyInfo:RemoveClickListener()
	arg_3_0._btnNext:RemoveClickListener()
end

function var_0_0._btnEnemyInfoOnClick(arg_4_0)
	if arg_4_0.battleId then
		EnemyInfoController.instance:openAct191EnemyInfoView(arg_4_0.battleId)
	end
end

function var_0_0._btnNextOnClick(arg_5_0)
	if arg_5_0.nodeDetailMo.type == Activity191Enum.NodeType.RewardEvent then
		local var_5_0 = Activity191Model.instance:getCurActId()

		Activity191Rpc.instance:sendGain191RewardEventRequest(var_5_0, arg_5_0.onGainRewardReply, arg_5_0)
	elseif arg_5_0.nodeDetailMo.type == Activity191Enum.NodeType.BattleEvent then
		Activity191Controller.instance:enterFightScene(arg_5_0.nodeDetailMo)
	end
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	Act191StatController.instance:onViewOpen(arg_7_0.viewName)

	arg_7_0.nodeDetailMo = arg_7_0.viewParam
	arg_7_0.eventCo = lua_activity191_event.configDict[arg_7_0.nodeDetailMo.eventId]
	arg_7_0._txtTitle.text = GameUtil.setFirstStrSize(arg_7_0.eventCo.title, 62)
	arg_7_0._txtDesc.text = arg_7_0.eventCo.desc
	arg_7_0._txtTarget.text = arg_7_0.eventCo.task

	if arg_7_0.nodeDetailMo.type == Activity191Enum.NodeType.RewardEvent then
		arg_7_0._txtNext.text = luaLang("act191adventureview_gainreward")

		gohelper.setActive(arg_7_0._btnEnemyInfo, false)
	elseif arg_7_0.nodeDetailMo.type == Activity191Enum.NodeType.BattleEvent then
		arg_7_0._txtNext.text = luaLang("act191adventureview_start")

		gohelper.setActive(arg_7_0._btnEnemyInfo, true)

		local var_7_0 = arg_7_0.nodeDetailMo.fightEventId
		local var_7_1 = lua_activity191_fight_event.configDict[var_7_0].episodeId
		local var_7_2 = DungeonConfig.instance:getEpisodeCO(var_7_1)

		arg_7_0.battleId = var_7_2 and var_7_2.battleId
	end

	arg_7_0._uiSpine = GuiModelAgent.Create(arg_7_0._goLive2d, true)

	local var_7_3 = FightConfig.instance:getSkinCO(arg_7_0.eventCo.skinId)

	if var_7_3 then
		arg_7_0._uiSpine:setResPath(var_7_3, function()
			arg_7_0._uiSpine:setLayer(UnityLayer.Unit)
		end, arg_7_0)

		if not string.nilorempty(arg_7_0.eventCo.offset) then
			local var_7_4 = string.splitToNumber(arg_7_0.eventCo.offset, "#")

			recthelper.setAnchor(arg_7_0._goLive2d.transform, var_7_4[1], var_7_4[2])

			local var_7_5 = var_7_4[3]

			if var_7_5 then
				transformhelper.setLocalScale(arg_7_0._goLive2d.transform, var_7_5, var_7_5, 1)
			end
		end
	end

	local var_7_6 = GameUtil.splitString2(arg_7_0.eventCo.rewardView, true)

	for iter_7_0, iter_7_1 in ipairs(var_7_6) do
		local var_7_7 = arg_7_0:getResInst(Activity191Enum.PrefabPath.RewardItem, arg_7_0._goReward)

		MonoHelper.addNoUpdateLuaComOnceToGo(var_7_7, Act191RewardItem):setData(iter_7_1[1], iter_7_1[2])
	end
end

function var_0_0.onClose(arg_9_0)
	local var_9_0 = arg_9_0.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(arg_9_0.viewName, var_9_0)
end

function var_0_0.onGainRewardReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 == 0 then
		ViewMgr.instance:closeView(arg_10_0.viewName)

		if not Activity191Controller.instance:checkOpenGetView() then
			Activity191Controller.instance:nextStep()
		end
	end
end

return var_0_0
