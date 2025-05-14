module("modules.logic.rouge.map.view.map.RougeMapNodeRightView", package.seeall)

local var_0_0 = class("RougeMapNodeRightView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtChapterName = gohelper.findChildText(arg_1_0.viewGO, "#go_node_right/Title/#txt_ChapterName")
	arg_1_0._txtChapterNameEn = gohelper.findChildText(arg_1_0.viewGO, "#go_node_right/Title/#txt_ChapterNameEn")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_node_right/#txt_Desc")
	arg_1_0._btnMoveBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_node_right/#btn_MoveBtn")
	arg_1_0._gocareer = gohelper.findChild(arg_1_0.viewGO, "#go_node_right/#go_career")
	arg_1_0._gocareeritem = gohelper.findChild(arg_1_0.viewGO, "#go_node_right/#go_career/bg/go_careeritem")
	arg_1_0._simageDefaultPic = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_node_right/#go_DefaultPic")
	arg_1_0._simageMonsterMaskPic = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_node_right/#go_MonsterMaskPic")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnMoveBtn:AddClickListener(arg_2_0._btnMoveBtnOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnMoveBtn:RemoveClickListener()
end

function var_0_0._btnMoveBtnOnClick(arg_4_0)
	if arg_4_0.nodeMo.arriveStatus == RougeMapEnum.Arrive.CanArrive then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onBeforeSendMoveRpc)
		RougeRpc.instance:sendRougeRoundMoveRequest(arg_4_0.nodeMo.nodeId)

		return
	end

	RougeMapChoiceEventHelper.triggerEventHandle(arg_4_0.nodeMo)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.goDefaultPic = arg_5_0._simageDefaultPic.gameObject
	arg_5_0.goMonsterMaskPic = arg_5_0._simageMonsterMaskPic.gameObject
	arg_5_0.goNodeRight = gohelper.findChild(arg_5_0.viewGO, "#go_node_right")
	arg_5_0.rightAnimator = arg_5_0.goNodeRight:GetComponent(gohelper.Type_Animator)
	arg_5_0.txtBtn = gohelper.findChildText(arg_5_0.viewGO, "#go_node_right/#btn_MoveBtn/txt_Move")
	arg_5_0.txtBtnEn = gohelper.findChildText(arg_5_0.viewGO, "#go_node_right/#btn_MoveBtn/txt_MoveEn")

	arg_5_0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectNode, arg_5_0.onSelectNode, arg_5_0)
	arg_5_0:addEventCb(RougeMapController.instance, RougeMapEvent.onNormalActorBeforeMove, arg_5_0.onNormalActorBeforeMove, arg_5_0)
	arg_5_0:addEventCb(RougeMapController.instance, RougeMapEvent.onActorMovingDone, arg_5_0.onActorMovingDone, arg_5_0)
	arg_5_0:addEventCb(RougeMapController.instance, RougeMapEvent.onChangeMapInfo, arg_5_0.onChangeMapInfo, arg_5_0)
	arg_5_0:addEventCb(RougeMapController.instance, RougeMapEvent.onShowContinueFight, arg_5_0.onShowContinueFight, arg_5_0)
	arg_5_0:addEventCb(RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, arg_5_0.onUpdateMapInfo, arg_5_0)
	arg_5_0:addEventCb(RougeMapController.instance, RougeMapEvent.onPopViewDone, arg_5_0.onPopViewDone, arg_5_0)
	arg_5_0:addEventCb(RougeMapController.instance, RougeMapEvent.onClearInteract, arg_5_0.onClearInteract, arg_5_0)

	arg_5_0.goCareerList = arg_5_0:getUserDataTb_()
	arg_5_0.careerList = {}

	table.insert(arg_5_0.goCareerList, arg_5_0._gocareeritem)
	arg_5_0:hideDescContainer()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:autoContinueEvent()
end

function var_0_0.autoContinueEvent(arg_7_0)
	local var_7_0 = RougeMapModel.instance:getCurNode()

	if var_7_0 and var_7_0:isStartedEvent() then
		arg_7_0:_triggerHandle()
	end
end

function var_0_0.onUpdateMapInfo(arg_8_0)
	if not arg_8_0.nodeMo then
		return
	end

	if arg_8_0.nodeMo.eventId == arg_8_0.eventId then
		return
	end

	arg_8_0:updateData(arg_8_0.nodeMo)
	arg_8_0:refreshRight()
end

function var_0_0.onChangeMapInfo(arg_9_0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectNode, nil)
end

function var_0_0.onSelectNode(arg_10_0, arg_10_1)
	if not arg_10_1 then
		arg_10_0:updateData()
		arg_10_0:hideDescContainer()

		return
	end

	if arg_10_1 == arg_10_0.nodeMo then
		return
	end

	arg_10_0:updateData(arg_10_1)

	if arg_10_0.nodeMo.arriveStatus == RougeMapEnum.Arrive.CanArrive then
		arg_10_0:switchNode()
	else
		RougeMapChoiceEventHelper.triggerContinueEventHandle(arg_10_0.nodeMo)
	end
end

function var_0_0.switchNode(arg_11_0)
	arg_11_0.rightAnimator:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(arg_11_0.refreshRight, arg_11_0)
	TaskDispatcher.runDelay(arg_11_0.refreshRight, arg_11_0, RougeMapEnum.WaitMapRightRefreshTime)
end

function var_0_0.onShowContinueFight(arg_12_0)
	arg_12_0:refreshRight(true)
end

function var_0_0.updateData(arg_13_0, arg_13_1)
	if not arg_13_1 then
		arg_13_0.nodeMo = nil
		arg_13_0.eventCo = nil
		arg_13_0.eventMo = nil
		arg_13_0.eventId = nil

		return
	end

	arg_13_0.nodeMo = arg_13_1
	arg_13_0.eventCo = arg_13_0.nodeMo:getEventCo()
	arg_13_0.eventMo = arg_13_0.nodeMo.eventMo
	arg_13_0.eventId = arg_13_0.nodeMo.eventId
end

function var_0_0.refreshRight(arg_14_0, arg_14_1)
	if not arg_14_0.eventCo then
		return
	end

	arg_14_0._txtChapterName.text = arg_14_0.eventCo.name
	arg_14_0._txtChapterNameEn.text = arg_14_0.eventCo.nameEn
	arg_14_0._txtDesc.text = arg_14_0.eventCo.desc

	arg_14_0:showDescContainer()
	arg_14_0:refreshBtn(arg_14_1)
	arg_14_0:refreshCareer()
	arg_14_0:refreshPic()
end

function var_0_0.refreshCareer(arg_15_0)
	local var_15_0 = arg_15_0.eventCo.type

	if not var_15_0 then
		gohelper.setActive(arg_15_0._gocareer, false)
	end

	local var_15_1 = RougeMapHelper.isFightEvent(var_15_0)

	gohelper.setActive(arg_15_0._gocareer, var_15_1)

	if var_15_1 then
		local var_15_2 = arg_15_0:getCareerList(arg_15_0.eventId)

		for iter_15_0, iter_15_1 in ipairs(var_15_2) do
			local var_15_3 = arg_15_0.goCareerList[iter_15_0]

			if not var_15_3 then
				var_15_3 = gohelper.cloneInPlace(arg_15_0._gocareeritem)

				table.insert(arg_15_0.goCareerList, var_15_3)
			end

			gohelper.setActive(var_15_3, true)

			local var_15_4 = var_15_3:GetComponent(gohelper.Type_Image)

			UISpriteSetMgr.instance:setRougeSprite(var_15_4, "rouge_map_career_" .. iter_15_1)
		end

		for iter_15_2 = #var_15_2 + 1, #arg_15_0.goCareerList do
			gohelper.setActive(arg_15_0.goCareerList[iter_15_2], false)
		end
	end
end

function var_0_0.getCareerList(arg_16_0, arg_16_1)
	tabletool.clear(arg_16_0.careerList)

	local var_16_0 = RougeMapConfig.instance:getFightEvent(arg_16_1)

	if not var_16_0 then
		return arg_16_0.careerList
	end

	local var_16_1 = DungeonConfig.instance:getEpisodeCO(var_16_0.episodeId)

	if not var_16_1 then
		return arg_16_0.careerList
	end

	local var_16_2 = lua_battle.configDict[var_16_1.battleId]

	if not var_16_2 then
		return arg_16_0.careerList
	end

	local var_16_3 = string.splitToNumber(var_16_2.monsterGroupIds, "#")

	for iter_16_0, iter_16_1 in ipairs(var_16_3) do
		local var_16_4 = lua_monster_group.configDict[iter_16_1]
		local var_16_5 = string.splitToNumber(var_16_4.monster, "#")

		for iter_16_2, iter_16_3 in ipairs(var_16_5) do
			local var_16_6 = lua_monster.configDict[iter_16_3].career

			if not tabletool.indexOf(arg_16_0.careerList, var_16_6) then
				table.insert(arg_16_0.careerList, var_16_6)
			end
		end
	end

	return arg_16_0.careerList
end

function var_0_0.refreshPic(arg_17_0)
	local var_17_0 = arg_17_0.eventCo.type
	local var_17_1 = RougeMapEffectHelper.checkHadEffect(RougeMapEnum.EffectType.UnlockShowPassFightMask, var_17_0)
	local var_17_2 = RougeOutsideModel.instance:passedEventId(arg_17_0.eventId)

	if var_17_1 and var_17_2 then
		arg_17_0:refreshMonsterPic()
	else
		arg_17_0:refreshDefaultPic()
	end
end

function var_0_0.refreshDefaultPic(arg_18_0)
	gohelper.setActive(arg_18_0.goDefaultPic, true)
	gohelper.setActive(arg_18_0.goMonsterMaskPic, false)

	local var_18_0 = arg_18_0.eventCo.type
	local var_18_1 = RougeMapEnum.EventDefaultPic[var_18_0]

	if not var_18_1 then
		logError("event type not config default pic " .. tostring(var_18_0))

		return
	end

	arg_18_0._simageDefaultPic:LoadImage(string.format(RougeMapEnum.PicFormat, var_18_1))
end

function var_0_0.refreshMonsterPic(arg_19_0)
	gohelper.setActive(arg_19_0.goDefaultPic, false)
	gohelper.setActive(arg_19_0.goMonsterMaskPic, true)

	local var_19_0 = RougeMapConfig.instance:getFightEvent(arg_19_0.eventId)
	local var_19_1 = var_19_0 and var_19_0.monsterMask

	if string.nilorempty(var_19_1) then
		arg_19_0:refreshDefaultPic()

		return
	end

	arg_19_0._simageMonsterMaskPic:LoadImage(string.format(RougeMapEnum.RougeMapEnum.MonsterMaskFormat, var_19_1))
end

function var_0_0.onNormalActorBeforeMove(arg_20_0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectNode, nil)
end

function var_0_0.onActorMovingDone(arg_21_0)
	if not RougeMapModel.instance:isNormalLayer() then
		return
	end

	arg_21_0:_triggerHandle()
end

function var_0_0._triggerHandle(arg_22_0)
	if RougePopController.instance:hadPopView() then
		arg_22_0.waitPopDone = true

		return
	end

	if RougeMapModel.instance:isInteractiving() then
		arg_22_0.waitInteract = true

		return
	end

	arg_22_0.waitPopDone = nil
	arg_22_0.waitInteract = nil

	local var_22_0 = RougeMapModel.instance:getCurNode()

	RougeMapChoiceEventHelper.triggerEventHandle(var_22_0)
end

function var_0_0.onClearInteract(arg_23_0)
	if not arg_23_0.waitInteract then
		return
	end

	arg_23_0:_triggerHandle()
end

function var_0_0.onPopViewDone(arg_24_0)
	if not arg_24_0.waitPopDone then
		return
	end

	arg_24_0:_triggerHandle()
end

function var_0_0.showDescContainer(arg_25_0)
	gohelper.setActive(arg_25_0.goNodeRight, true)
end

function var_0_0.refreshBtn(arg_26_0, arg_26_1)
	local var_26_0
	local var_26_1
	local var_26_2

	if arg_26_1 then
		var_26_0 = luaLang("rougemapview_txt_Fight")
		var_26_2 = "FIGHT"
	else
		var_26_0 = luaLang("rougemapview_txt_Move")
		var_26_2 = "MOVE"
	end

	arg_26_0.txtBtn.text = var_26_0
	arg_26_0.txtBtnEn.text = var_26_2
end

function var_0_0.hideDescContainer(arg_27_0)
	gohelper.setActive(arg_27_0.goNodeRight, false)
end

function var_0_0.onClose(arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0.refreshRight, arg_28_0)
end

function var_0_0.onDestroyView(arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0.refreshRight, arg_29_0)
	arg_29_0._simageDefaultPic:UnLoadImage()
	arg_29_0._simageMonsterMaskPic:UnLoadImage()
end

return var_0_0
