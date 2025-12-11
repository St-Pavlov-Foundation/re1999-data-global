module("modules.logic.versionactivity2_7.act191.view.Act191StageView", package.seeall)

local var_0_0 = class("Act191StageView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goNodeList = gohelper.findChild(arg_1_0.viewGO, "#go_NodeList")
	arg_1_0._goNormalStage = gohelper.findChild(arg_1_0.viewGO, "#go_NormalStage")
	arg_1_0._goFightStage = gohelper.findChild(arg_1_0.viewGO, "#go_FightStage")
	arg_1_0._goTeam = gohelper.findChild(arg_1_0.viewGO, "#go_Team")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Enter")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._txtCoin = gohelper.findChildText(arg_1_0.viewGO, "go_topright/Coin/#txt_Coin")
	arg_1_0._txtScore = gohelper.findChildText(arg_1_0.viewGO, "go_topright/Score/#txt_Score")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._btnEnterOnClick, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0.onCloseView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnter:RemoveClickListener()
end

function var_0_0._btnEnterOnClick(arg_4_0)
	if not arg_4_0.selectIndex then
		return
	end

	Activity191Rpc.instance:sendSelect191NodeRequest(arg_4_0.actId, arg_4_0.selectIndex - 1, arg_4_0.onSelectNode, arg_4_0)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.actId = Activity191Model.instance:getCurActId()

	gohelper.setActive(arg_5_0._btnEnter, false)

	local var_5_0 = arg_5_0:getResInst(Activity191Enum.PrefabPath.TeamComp, arg_5_0._goTeam)

	MonoHelper.addNoUpdateLuaComOnceToGo(var_5_0, Act191TeamComp, arg_5_0)

	local var_5_1 = arg_5_0:getResInst(Activity191Enum.PrefabPath.NodeListItem, arg_5_0._goNodeList)

	arg_5_0.nodeListComp = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_1, Act191NodeListItem, arg_5_0)
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_pmgressbar_unfold)

	local var_6_0 = Activity191Model.instance:getActInfo():getGameInfo()

	arg_6_0._txtScore.text = var_6_0.score
	arg_6_0._txtCoin.text = var_6_0.coin

	local var_6_1 = Activity191Helper.matchKeyInArray(var_6_0.nodeInfo, var_6_0.curNode, "nodeId")
	local var_6_2 = #var_6_1.selectNodeStr

	arg_6_0.stageItemList = {}
	arg_6_0.nodeDetailMoList = arg_6_0:getUserDataTb_()

	for iter_6_0 = 1, 3 do
		local var_6_3 = var_6_2 == 1 and 2 or iter_6_0
		local var_6_4 = gohelper.findChild(arg_6_0.viewGO, "stageList/StageItem" .. var_6_3)

		if iter_6_0 <= var_6_2 then
			if var_6_2 == 2 then
				local var_6_5 = iter_6_0 == 1 and -350 or 350

				recthelper.setAnchor(var_6_4.transform, var_6_5, 170)
			end

			local var_6_6 = Act191NodeDetailMO.New()
			local var_6_7 = var_6_1.selectNodeStr[iter_6_0]

			if var_6_7 ~= "null" then
				var_6_6:init(var_6_7)

				arg_6_0.nodeDetailMoList[iter_6_0] = var_6_6

				local var_6_8 = arg_6_0:getUserDataTb_()
				local var_6_9 = Activity191Helper.isPveBattle(var_6_6.type)
				local var_6_10 = Activity191Helper.isPvpBattle(var_6_6.type)

				if var_6_9 or var_6_10 then
					local var_6_11 = gohelper.clone(arg_6_0._goFightStage, var_6_4)

					var_6_8.canvasGroup = var_6_11:GetComponent(gohelper.Type_CanvasGroup)

					local var_6_12 = gohelper.findChildButton(var_6_11, "")

					arg_6_0:addClickCb(var_6_12, arg_6_0.clickStage, arg_6_0, iter_6_0)

					local var_6_13 = gohelper.findChildButtonWithAudio(var_6_11, "btn_Check")

					arg_6_0:addClickCb(var_6_13, arg_6_0.clickCheck, arg_6_0, iter_6_0)
					gohelper.setActive(var_6_13, var_6_9)

					local var_6_14 = gohelper.findChild(var_6_11, "stage/go_Spine")

					var_6_8.goMask = gohelper.findChild(var_6_11, "stage/go_mask")

					local var_6_15 = gohelper.findChild(var_6_11, "stage/go_Unknown")

					var_6_8.goSelect = gohelper.findChild(var_6_11, "go_Select")

					local var_6_16 = gohelper.findChildImage(var_6_11, "image_NodeNum")
					local var_6_17 = gohelper.findChildImage(var_6_11, "info/image_Level")
					local var_6_18 = gohelper.findChild(var_6_11, "info/go_attribute")
					local var_6_19 = gohelper.findChild(var_6_11, "reward")

					gohelper.setActive(var_6_14, var_6_9)
					gohelper.setActive(var_6_15, var_6_10)
					UISpriteSetMgr.instance:setAct174Sprite(var_6_16, "act174_stage_num_0" .. iter_6_0)

					local var_6_20

					if var_6_9 then
						local var_6_21 = lua_activity191_fight_event.configDict[var_6_6.fightEventId]
						local var_6_22 = var_6_21.fightLevel

						UISpriteSetMgr.instance:setAct174Sprite(var_6_17, "act191_level_" .. string.lower(var_6_22))
						arg_6_0:createSpine(var_6_14, var_6_21)

						var_6_20 = GameUtil.splitString2(var_6_21.rewardView, true)

						gohelper.setActive(var_6_18, false)
					else
						local var_6_23 = lua_activity191_match_rank.configDict[var_6_6.matchInfo.rank].fightLevel

						UISpriteSetMgr.instance:setAct174Sprite(var_6_17, "act191_level_" .. string.lower(var_6_23))

						local var_6_24 = Activity191Enum.NodeType2Key[var_6_6.type]
						local var_6_25 = lua_activity191_pvp_match.configDict[var_6_24]

						var_6_20 = GameUtil.splitString2(var_6_25.rewardView, true)

						local var_6_26 = GameUtil.splitString2(var_6_25.attribute, true)

						if var_6_26 then
							for iter_6_1 = 1, 2 do
								local var_6_27 = gohelper.findChild(var_6_18, iter_6_1)

								if var_6_26[iter_6_1] then
									local var_6_28 = var_6_26[iter_6_1][1]
									local var_6_29 = var_6_26[iter_6_1][2]

									if var_6_29 > 0 then
										var_6_29 = string.format("+%s%%", var_6_29 / 10)
									else
										var_6_29 = string.format("%s%%", var_6_29 / 10)
									end

									local var_6_30 = gohelper.findChildImage(var_6_27, "icon")

									UISpriteSetMgr.instance:setCommonSprite(var_6_30, "icon_att_" .. var_6_28)

									gohelper.findChildText(var_6_27, "txt_attribute").text = var_6_29
								end

								gohelper.setActive(var_6_27, var_6_26[iter_6_1])
							end
						end

						gohelper.setActive(var_6_18, var_6_26)
					end

					for iter_6_2, iter_6_3 in ipairs(var_6_20) do
						local var_6_31 = arg_6_0:getResInst(Activity191Enum.PrefabPath.RewardItem, var_6_19)
						local var_6_32 = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_31, Act191RewardItem)

						var_6_32:setData(iter_6_3[1], iter_6_3[2])

						local var_6_33 = {
							index = iter_6_2,
							fromView = arg_6_0.viewName
						}

						var_6_32:setExtraParam(var_6_33)
					end
				else
					local var_6_34 = gohelper.clone(arg_6_0._goNormalStage, var_6_4)

					var_6_8.canvasGroup = var_6_34:GetComponent(gohelper.Type_CanvasGroup)

					local var_6_35 = gohelper.findChildButton(var_6_34, "")

					arg_6_0:addClickCb(var_6_35, arg_6_0.clickStage, arg_6_0, iter_6_0)

					local var_6_36 = gohelper.findChildSingleImage(var_6_34, "stage/simage_Stage")

					var_6_8.goSelect = gohelper.findChild(var_6_34, "go_Select")

					local var_6_37 = gohelper.findChildImage(var_6_34, "image_NodeNum")
					local var_6_38 = gohelper.findChildText(var_6_34, "info/txt_Name")
					local var_6_39 = gohelper.findChildText(var_6_34, "detail/scroll_desc/Viewport/Content/txt_Desc")
					local var_6_40 = gohelper.findChild(var_6_34, "tag")
					local var_6_41 = gohelper.findChildText(var_6_34, "tag/txt_Tag")

					UISpriteSetMgr.instance:setAct174Sprite(var_6_37, "act174_stage_num_0" .. iter_6_0)

					local var_6_42 = Activity191Helper.isShopNode(var_6_6.type)
					local var_6_43

					if var_6_42 then
						local var_6_44 = lua_activity191_shop.configDict[arg_6_0.actId][var_6_6.shopId]

						if var_6_6.type == Activity191Enum.NodeType.RoleShop then
							var_6_41.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.RoleTag].value2
						elseif var_6_6.type == Activity191Enum.NodeType.CollectionShop then
							var_6_41.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.CollectionTag].value2
						elseif tabletool.indexOf(Activity191Enum.TagShopField, var_6_6.type) then
							var_6_41.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.FetterTag].value2
						end

						var_6_38.text = var_6_44.name
						var_6_39.text = var_6_44.desc
						var_6_43 = ResUrl.getAct191SingleBg("stage/act191_stage_mode_3")
					elseif var_6_6.type == Activity191Enum.NodeType.Enhance then
						var_6_38.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.EnhanceTitle].value2
						var_6_39.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.EnhanceDesc].value2
						var_6_43 = ResUrl.getAct191SingleBg("stage/act191_stage_mode_2")
					elseif var_6_6.type == Activity191Enum.NodeType.BattleEvent or var_6_6.type == Activity191Enum.NodeType.RewardEvent then
						local var_6_45 = lua_activity191_event.configDict[var_6_6.eventId]

						var_6_38.text = var_6_45.title
						var_6_39.text = var_6_45.outDesc
						var_6_43 = ResUrl.getAct191SingleBg("stage/act191_stage_mode_1")
					elseif var_6_6.type == Activity191Enum.NodeType.ReplaceEvent then
						var_6_41.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.ReplaceTag].value2
						var_6_38.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.ReplaceTitle].value2
						var_6_39.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.ReplaceDesc].value2
						var_6_43 = ResUrl.getAct191SingleBg("stage/act191_stage_mode_4")
					elseif var_6_6.type == Activity191Enum.NodeType.UpgradeEvent then
						var_6_41.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.UpgradeTag].value2
						var_6_38.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.UpgradeTitle].value2
						var_6_39.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.UpgradeDesc].value2
						var_6_43 = ResUrl.getAct191SingleBg("stage/act191_stage_mode_4")
					end

					local var_6_46 = var_6_42 and var_6_6.type ~= Activity191Enum.NodeType.MixStore or var_6_6.type == Activity191Enum.NodeType.ReplaceEvent or var_6_6.type == Activity191Enum.NodeType.UpgradeEvent

					gohelper.setActive(var_6_40, var_6_46)

					if var_6_43 then
						var_6_36:LoadImage(var_6_43)
					end
				end

				gohelper.setActive(var_6_4, true)

				arg_6_0.stageItemList[iter_6_0] = var_6_8
			end
		end
	end

	gohelper.setActive(arg_6_0._goFightStage, false)
	gohelper.setActive(arg_6_0._goNormalStage, false)

	for iter_6_4, iter_6_5 in ipairs(arg_6_0.nodeDetailMoList) do
		if arg_6_0.eventTypeStr then
			arg_6_0.eventTypeStr = string.format("%s#%s", arg_6_0.eventTypeStr, tostring(iter_6_5.type))
		else
			arg_6_0.eventTypeStr = tostring(iter_6_5.type)
		end
	end

	arg_6_0.statViewName = string.format("%s_%s", arg_6_0.viewName, arg_6_0.eventTypeStr)

	Act191StatController.instance:onViewOpen(arg_6_0.statViewName)
end

function var_0_0.onClose(arg_7_0)
	local var_7_0 = arg_7_0.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(arg_7_0.statViewName, var_7_0)
end

function var_0_0.onDestroyView(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.playSalaryAnim, arg_8_0)
end

function var_0_0.clickStage(arg_9_0, arg_9_1)
	if not arg_9_0.selectIndex then
		gohelper.setActive(arg_9_0._btnEnter, true)
	end

	if arg_9_0.selectIndex == arg_9_1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_fire_interface)

	arg_9_0.selectIndex = arg_9_1

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.stageItemList) do
		local var_9_0 = iter_9_0 == arg_9_1 and 1 or 0.5

		iter_9_1.canvasGroup.alpha = var_9_0

		gohelper.setActive(iter_9_1.goSelect, iter_9_0 == arg_9_1)
		gohelper.setActive(iter_9_1.goMask, iter_9_0 ~= arg_9_1)
	end
end

function var_0_0.clickCheck(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.nodeDetailMoList[arg_10_1]

	if var_10_0 then
		local var_10_1 = lua_activity191_fight_event.configDict[var_10_0.fightEventId].episodeId
		local var_10_2 = DungeonConfig.instance:getEpisodeCO(var_10_1)

		EnemyInfoController.instance:openAct191EnemyInfoView(var_10_2.battleId)
		Act191StatController.instance:statButtonClick(arg_10_0.viewName, string.format("clickCheck_%s_%s", arg_10_1, var_10_0.fightEventId))
	end
end

function var_0_0.onSelectNode(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2 == 0 then
		Activity191Controller.instance:nextStep()
		ViewMgr.instance:closeView(arg_11_0.viewName)
	end
end

function var_0_0.createSpine(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = GuiSpine.Create(arg_12_1, false)
	local var_12_1 = FightConfig.instance:getSkinCO(arg_12_2.skinId)

	var_12_0:setResPath(ResUrl.getSpineUIPrefab(var_12_1.spine), nil, nil, true)

	if not string.nilorempty(arg_12_2.offset) then
		local var_12_2 = string.splitToNumber(arg_12_2.offset, "#")

		recthelper.setAnchor(arg_12_1.transform, var_12_2[1], var_12_2[2])

		if var_12_2[3] then
			transformhelper.setLocalScale(arg_12_1.transform, var_12_2[3], var_12_2[3], 1)
		end
	end
end

function var_0_0.onCloseView(arg_13_0, arg_13_1)
	if arg_13_1 == ViewName.Act191SwitchView and arg_13_0.nodeListComp.firstNode then
		arg_13_0.nodeListComp:showSalary()
		TaskDispatcher.runDelay(arg_13_0.playSalaryAnim, arg_13_0, 0.5)
	end
end

function var_0_0.playSalaryAnim(arg_14_0)
	arg_14_0.nodeListComp:playSalaryAnim(arg_14_0._txtCoin.gameObject, arg_14_0._txtScore.gameObject)
end

return var_0_0
