module("modules.logic.dungeon.view.DungeonWeekWalk_2View", package.seeall)

local var_0_0 = class("DungeonWeekWalk_2View", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnenterbtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/shallowbox/#btn_enterbtn")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/shallowbox/#btn_reward")
	arg_1_0._golingqu = gohelper.findChild(arg_1_0.viewGO, "anim/shallowbox/#btn_reward/#go_lingqu")
	arg_1_0._gorewardredpoint = gohelper.findChild(arg_1_0.viewGO, "anim/shallowbox/#btn_reward/#go_rewardredpoint")
	arg_1_0._txttaskprogress = gohelper.findChildText(arg_1_0.viewGO, "anim/shallowbox/#btn_reward/#txt_taskprogress")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/deepbox/#btn_start")
	arg_1_0._goeasy = gohelper.findChild(arg_1_0.viewGO, "anim/deepbox/map/scenetype/#go_easy")
	arg_1_0._gohard = gohelper.findChild(arg_1_0.viewGO, "anim/deepbox/map/scenetype/#go_hard")
	arg_1_0._txtscenetype = gohelper.findChildText(arg_1_0.viewGO, "anim/deepbox/map/scenetype/#txt_scenetype")
	arg_1_0._txtcurprogress = gohelper.findChildText(arg_1_0.viewGO, "anim/deepbox/map/#txt_curprogress")
	arg_1_0._txtcurrency1 = gohelper.findChildText(arg_1_0.viewGO, "anim/deepbox/rewardPreview/#txt_currency1")
	arg_1_0._txttotal1 = gohelper.findChildText(arg_1_0.viewGO, "anim/deepbox/rewardPreview/#txt_currency1/#txt_total1")
	arg_1_0._gonormal1 = gohelper.findChild(arg_1_0.viewGO, "anim/deepbox/rewardPreview/#txt_currency1/btn/normal")
	arg_1_0._gocanget1 = gohelper.findChild(arg_1_0.viewGO, "anim/deepbox/rewardPreview/#txt_currency1/btn/#go_canget1")
	arg_1_0._gohasget1 = gohelper.findChild(arg_1_0.viewGO, "anim/deepbox/rewardPreview/#txt_currency1/btn/#go_hasget1")
	arg_1_0._btnclick1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/deepbox/rewardPreview/#txt_currency1/btn/#btn_click1")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "anim/deepbox/limittime/#txt_time")
	arg_1_0._txtmaptaskprogress = gohelper.findChildText(arg_1_0.viewGO, "anim/deepbox/#txt_maptaskprogress")
	arg_1_0._gomapprogressitem = gohelper.findChild(arg_1_0.viewGO, "anim/deepbox/mapprogresslist/#go_mapprogressitem")
	arg_1_0._btnstart2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/heartbox/#btn_start_2")
	arg_1_0._goeasy2 = gohelper.findChild(arg_1_0.viewGO, "anim/heartbox/map/scenetype/#go_easy2")
	arg_1_0._gohard2 = gohelper.findChild(arg_1_0.viewGO, "anim/heartbox/map/scenetype/#go_hard2")
	arg_1_0._txtscenetype2 = gohelper.findChildText(arg_1_0.viewGO, "anim/heartbox/map/scenetype/#txt_scenetype2")
	arg_1_0._txtcurprogress2 = gohelper.findChildText(arg_1_0.viewGO, "anim/heartbox/map/#txt_curprogress2")
	arg_1_0._btnreward2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/heartbox/map/#btn_reward2")
	arg_1_0._gobubble = gohelper.findChild(arg_1_0.viewGO, "anim/heartbox/map/#btn_reward2/#go_bubble")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/heartbox/map/#btn_reward2/#go_bubble/#simage_icon")
	arg_1_0._gomapprogressitem2 = gohelper.findChild(arg_1_0.viewGO, "anim/heartbox/mapprogresslist/#go_mapprogressitem2")
	arg_1_0._txtcurrency2 = gohelper.findChildText(arg_1_0.viewGO, "anim/heartbox/rewardPreview/#txt_currency2")
	arg_1_0._txttotal2 = gohelper.findChildText(arg_1_0.viewGO, "anim/heartbox/rewardPreview/#txt_currency2/#txt_total2")
	arg_1_0._gonormal2 = gohelper.findChild(arg_1_0.viewGO, "anim/heartbox/rewardPreview/#txt_currency2/btn/normal")
	arg_1_0._gocanget2 = gohelper.findChild(arg_1_0.viewGO, "anim/heartbox/rewardPreview/#txt_currency2/btn/#go_canget2")
	arg_1_0._gohasget2 = gohelper.findChild(arg_1_0.viewGO, "anim/heartbox/rewardPreview/#txt_currency2/btn/#go_hasget2")
	arg_1_0._btnclick2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/heartbox/rewardPreview/#txt_currency2/btn/#btn_click2")
	arg_1_0._txttime2 = gohelper.findChildText(arg_1_0.viewGO, "anim/heartbox/limittime/#txt_time2")
	arg_1_0._goitem1 = gohelper.findChild(arg_1_0.viewGO, "anim/heartbox/badgelist/1/badgelayout/#go_item_1")
	arg_1_0._goitem2 = gohelper.findChild(arg_1_0.viewGO, "anim/heartbox/badgelist/2/badgelayout/#go_item_2")
	arg_1_0._btnshop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/#btn_shop")
	arg_1_0._simagebgimgnext = gohelper.findChildSingleImage(arg_1_0.viewGO, "transition/ani/#simage_bgimg_next")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnenterbtn:AddClickListener(arg_2_0._btnenterbtnOnClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btnclick1:AddClickListener(arg_2_0._btnclick1OnClick, arg_2_0)
	arg_2_0._btnstart2:AddClickListener(arg_2_0._btnstart2OnClick, arg_2_0)
	arg_2_0._btnreward2:AddClickListener(arg_2_0._btnreward2OnClick, arg_2_0)
	arg_2_0._btnclick2:AddClickListener(arg_2_0._btnclick2OnClick, arg_2_0)
	arg_2_0._btnshop:AddClickListener(arg_2_0._btnshopOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnenterbtn:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnclick1:RemoveClickListener()
	arg_3_0._btnstart2:RemoveClickListener()
	arg_3_0._btnreward2:RemoveClickListener()
	arg_3_0._btnclick2:RemoveClickListener()
	arg_3_0._btnshop:RemoveClickListener()
end

function var_0_0._btnclick1OnClick(arg_4_0)
	if not arg_4_0._openMapId1 then
		return
	end

	local var_4_0 = arg_4_0:_getLastMapId1()

	if var_4_0 then
		WeekWalkController.instance:openWeekWalkLayerRewardView({
			mapId = var_4_0
		})

		return
	end

	WeekWalkController.instance:openWeekWalkLayerRewardView({
		mapId = arg_4_0._openMapId1
	})
end

function var_0_0._getLastMapId1(arg_5_0)
	local var_5_0 = WeekWalkModel.instance:getInfo()
	local var_5_1 = WeekWalkConfig.instance:getDeepLayer(var_5_0.issueId)
	local var_5_2 = ResSplitConfig.instance:getMaxWeekWalkLayer()

	if var_5_1 then
		for iter_5_0, iter_5_1 in ipairs(var_5_1) do
			local var_5_3 = iter_5_1.id
			local var_5_4 = WeekWalkRewardView.getTaskType(var_5_3)
			local var_5_5, var_5_6 = WeekWalkTaskListModel.instance:canGetRewardNum(var_5_4, var_5_3)

			if not (not (var_5_5 > 0) and var_5_6 <= 0) or iter_5_0 == #var_5_1 then
				return var_5_3
			end
		end
	end
end

function var_0_0._btnclick2OnClick(arg_6_0)
	if not arg_6_0._openMapId2 then
		return
	end

	local var_6_0 = arg_6_0:_getLastMapId2()

	if var_6_0 then
		WeekWalk_2Controller.instance:openWeekWalk_2LayerRewardView({
			mapId = var_6_0
		})

		return
	end

	WeekWalk_2Controller.instance:openWeekWalk_2LayerRewardView({
		mapId = arg_6_0._openMapId2
	})
end

function var_0_0._getLastMapId2(arg_7_0)
	local var_7_0 = WeekWalk_2Model.instance:getInfo()

	for iter_7_0 = 1, WeekWalk_2Enum.MaxLayer do
		local var_7_1 = var_7_0:getLayerInfoByLayerIndex(iter_7_0).id
		local var_7_2 = WeekWalk_2Enum.TaskType.Season
		local var_7_3, var_7_4 = WeekWalk_2TaskListModel.instance:canGetRewardNum(var_7_2, var_7_1)

		if not (not (var_7_3 > 0) and var_7_4 <= 0) or iter_7_0 == WeekWalk_2Enum.MaxLayer then
			return var_7_1
		end
	end
end

function var_0_0._btnreward2OnClick(arg_8_0)
	WeekWalk_2Controller.instance:openWeekWalk_2LayerRewardView({
		mapId = 0
	})
end

function var_0_0._btnstart2OnClick(arg_9_0)
	WeekWalk_2Controller.instance:openWeekWalk_2HeartLayerView()
end

function var_0_0._btnenterbtnOnClick(arg_10_0)
	module_views_preloader.WeekWalkLayerViewPreload(function()
		WeekWalkController.instance:openWeekWalkLayerView({
			layerId = 10
		})
	end)
end

function var_0_0._btnrewardOnClick(arg_12_0)
	WeekWalkController.instance:openWeekWalkRewardView()
end

function var_0_0._btnshopOnClick(arg_13_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Bank) then
		arg_13_0:_openStoreView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Bank))
	end
end

function var_0_0._updateTaskStatus(arg_14_0)
	local var_14_0 = WeekWalkTaskListModel.instance:canGetReward(WeekWalkEnum.TaskType.Week)

	gohelper.setActive(arg_14_0._golingqu, var_14_0)
	gohelper.setActive(arg_14_0._gorewardredpoint, var_14_0)
end

function var_0_0._openStoreView(arg_15_0)
	StoreController.instance:openStoreView(StoreEnum.StoreId.WeekWalk)
end

function var_0_0._btnstartOnClick(arg_16_0)
	arg_16_0:openWeekWalkView()
end

function var_0_0._initImgs(arg_17_0)
	arg_17_0._simagexingdian1 = gohelper.findChildSingleImage(arg_17_0.viewGO, "bg/#xingdian1")
	arg_17_0._simagelefttopglow = gohelper.findChildSingleImage(arg_17_0.viewGO, "bg/#lefttop_glow")
	arg_17_0._simagelefttopglow2 = gohelper.findChildSingleImage(arg_17_0.viewGO, "bg/#lefttop_glow2")
	arg_17_0._simageleftdownglow = gohelper.findChildSingleImage(arg_17_0.viewGO, "bg/#leftdown_glow")
	arg_17_0._simagerihtttopglow = gohelper.findChildSingleImage(arg_17_0.viewGO, "bg/#rihtttop_glow")
	arg_17_0._simagerihtttopblack = gohelper.findChildSingleImage(arg_17_0.viewGO, "bg/#rihtttop_black")
	arg_17_0._simagecenterdown = gohelper.findChildSingleImage(arg_17_0.viewGO, "bg/#centerdown")

	arg_17_0._simagexingdian1:LoadImage(ResUrl.getWeekWalkBg("xingdian.png"))
	arg_17_0._simagelefttopglow:LoadImage(ResUrl.getWeekWalkBg("lefttop_glow.png"))
	arg_17_0._simagelefttopglow2:LoadImage(ResUrl.getWeekWalkBg("lefttop_glow2.png"))
	arg_17_0._simageleftdownglow:LoadImage(ResUrl.getWeekWalkBg("leftdown_glow.png"))
	arg_17_0._simagerihtttopglow:LoadImage(ResUrl.getWeekWalkBg("righttop_glow.png"))
	arg_17_0._simagerihtttopblack:LoadImage(ResUrl.getWeekWalkBg("leftdown_black.png"))
	arg_17_0._simagecenterdown:LoadImage(ResUrl.getWeekWalkBg("centerdown.png"))
end

function var_0_0._editableInitView(arg_18_0)
	WeekWalkController.instance:requestTask()
	arg_18_0:_showBonus()
	arg_18_0:_updateTaskStatus()
	arg_18_0:_onWeekwalk_2TaskUpdate()
	arg_18_0:_showDeadline()
	WeekWalkController.instance:startCheckTime()
	arg_18_0:_initImgs()

	arg_18_0._viewAnim = arg_18_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_18_0:_showProgress()
	arg_18_0:_showProgress2()
	gohelper.addUIClickAudio(arg_18_0._btnstart.gameObject, AudioEnum.WeekWalk.play_artificial_ui_entrance)
	gohelper.addUIClickAudio(arg_18_0._btnreward.gameObject, AudioEnum.WeekWalk.play_artificial_ui_taskopen)
	gohelper.addUIClickAudio(arg_18_0._btnshop.gameObject, AudioEnum.UI.play_ui_checkpoint_sources_open)
	arg_18_0:_initOnOpen()
end

function var_0_0._updateDegrade(arg_19_0)
	local var_19_0 = WeekWalkModel.instance:getLevel()
	local var_19_1 = WeekWalkModel.instance:getChangeLevel()

	gohelper.setActive(arg_19_0._btndegrade.gameObject, var_19_0 >= 2 and var_19_1 <= 0)
end

function var_0_0._showProgress2(arg_20_0)
	local var_20_0 = WeekWalk_2Model.instance:getInfo()
	local var_20_1, var_20_2 = var_20_0:getNotFinishedMap()

	if not var_20_1 then
		logError("DungeonWeekWalk_2View _showProgress2 map is nil")

		return
	end

	local var_20_3 = var_20_1.sceneConfig

	arg_20_0._txtcurprogress2.text = formatLuaLang("DungeonWeekWalkView_txtcurprogress_battleName", var_20_3.battleName)
	arg_20_0._txtscenetype2.text = GameUtil.getSubPlaceholderLuaLang(luaLang("DungeonWeekWalkView_txtscenetype_typeName_name"), {
		var_20_3.typeName,
		var_20_3.name
	})
	arg_20_0._mapFinishItemTab2 = arg_20_0._mapFinishItemTab2 or arg_20_0:getUserDataTb_()

	for iter_20_0, iter_20_1 in pairs(arg_20_0._mapFinishItemTab2) do
		gohelper.setActive(iter_20_1, false)
	end

	for iter_20_2 = 1, WeekWalk_2Enum.MaxLayer do
		local var_20_4 = arg_20_0._mapFinishItemTab2[iter_20_2]

		if not var_20_4 then
			var_20_4 = gohelper.cloneInPlace(arg_20_0._gomapprogressitem2, "item_" .. iter_20_2)
			arg_20_0._mapFinishItemTab2[iter_20_2] = var_20_4
		end

		gohelper.setActive(var_20_4, true)

		local var_20_5 = gohelper.findChild(var_20_4, "finish")
		local var_20_6 = gohelper.findChild(var_20_4, "unfinish")
		local var_20_7 = var_20_0:getLayerInfoByLayerIndex(iter_20_2)
		local var_20_8 = var_20_7 and var_20_7.finished

		gohelper.setActive(var_20_5, var_20_8)
		gohelper.setActive(var_20_6, not var_20_8)
		gohelper.setActive(gohelper.findChild(var_20_4, "finish_light_deepdream01"), var_20_8)
	end

	arg_20_0._battleStar1List = arg_20_0._battleStar1List or arg_20_0:getUserDataTb_()
	arg_20_0._battleStar2List = arg_20_0._battleStar2List or arg_20_0:getUserDataTb_()

	arg_20_0:_showBattleInfo(arg_20_0._battleStar1List, arg_20_0._goitem1, var_20_1:getBattleInfoByIndex(WeekWalk_2Enum.BattleIndex.First))
	arg_20_0:_showBattleInfo(arg_20_0._battleStar2List, arg_20_0._goitem2, var_20_1:getBattleInfoByIndex(WeekWalk_2Enum.BattleIndex.Second))

	local var_20_9, var_20_10, var_20_11, var_20_12 = WeekWalk_2TaskListModel.instance:getAllTaskInfo()

	arg_20_0._openMapId2 = var_20_12
	arg_20_0._txtcurrency2.text = var_20_9
	arg_20_0._txttotal2.text = var_20_10

	local var_20_13 = #var_20_11 > 0

	gohelper.setActive(arg_20_0._gonormal2, not var_20_13)
	gohelper.setActive(arg_20_0._gocanget2, var_20_13)
	gohelper.setActive(arg_20_0._gohasget2, var_20_9 == var_20_10)
end

function var_0_0._showBattleInfo(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	gohelper.setActive(arg_21_2, false)

	for iter_21_0 = 1, WeekWalk_2Enum.MaxStar do
		local var_21_0 = arg_21_1[iter_21_0]

		if not var_21_0 then
			local var_21_1 = gohelper.cloneInPlace(arg_21_2)
			local var_21_2 = gohelper.findChildImage(var_21_1, "1")

			gohelper.setActive(var_21_1, true)

			var_21_2.enabled = false
			var_21_0 = arg_21_0.viewContainer:getResInst(arg_21_0.viewContainer._viewSetting.otherRes.weekwalkheart_star, var_21_2.gameObject)
			arg_21_1[iter_21_0] = var_21_0
		end

		local var_21_3 = arg_21_3:getCupInfo(iter_21_0)
		local var_21_4 = var_21_3 and var_21_3.result or 0

		WeekWalk_2Helper.setCupEffectByResult(var_21_0, var_21_4)
	end
end

function var_0_0._showProgress(arg_22_0)
	local var_22_0 = WeekWalkModel.instance:getInfo()
	local var_22_1, var_22_2 = var_22_0:getNotFinishedMap()
	local var_22_3 = lua_weekwalk_scene.configDict[var_22_1.sceneId]

	arg_22_0._txtcurprogress.text = formatLuaLang("DungeonWeekWalkView_txtcurprogress_battleName", var_22_3.battleName)
	arg_22_0._txtscenetype.text = GameUtil.getSubPlaceholderLuaLang(luaLang("DungeonWeekWalkView_txtscenetype_typeName_name"), {
		var_22_3.typeName,
		var_22_3.name
	})

	if var_22_1 then
		local var_22_4, var_22_5 = var_22_1:getCurStarInfo()

		arg_22_0._txtmaptaskprogress.text = string.format("%s/%s", var_22_4, var_22_5)
	else
		arg_22_0._txtmaptaskprogress.text = "0/10"
	end

	local var_22_6 = WeekWalkModel.isShallowMap(var_22_1.sceneId)

	gohelper.setActive(arg_22_0._goeasy, var_22_6)
	gohelper.setActive(arg_22_0._gohard, not var_22_6)

	arg_22_0._mapFinishItemTab = arg_22_0._mapFinishItemTab or arg_22_0:getUserDataTb_()

	local var_22_7 = var_22_0:getMapInfoLayer()
	local var_22_8 = 1
	local var_22_9 = 10

	if not var_22_6 then
		local var_22_10 = WeekWalkModel.instance:getInfo()
		local var_22_11 = WeekWalkConfig.instance:getDeepLayer(var_22_10.issueId)

		var_22_8 = 11
		var_22_9 = var_22_8 + #var_22_11 - 1
	end

	for iter_22_0, iter_22_1 in pairs(arg_22_0._mapFinishItemTab) do
		gohelper.setActive(iter_22_1, false)
	end

	for iter_22_2 = var_22_8, var_22_9 do
		local var_22_12 = arg_22_0._mapFinishItemTab[iter_22_2]

		if not var_22_12 then
			var_22_12 = gohelper.cloneInPlace(arg_22_0._gomapprogressitem, "item_" .. iter_22_2)
			arg_22_0._mapFinishItemTab[iter_22_2] = var_22_12
		end

		gohelper.setActive(var_22_12, true)

		local var_22_13 = gohelper.findChild(var_22_12, "finish")
		local var_22_14 = var_22_7[iter_22_2]
		local var_22_15 = var_22_14 and var_22_14.isFinished > 0

		gohelper.setActive(var_22_13, var_22_15)

		local var_22_16 = gohelper.findChildImage(var_22_12, "unfinish")
		local var_22_17 = gohelper.findChildImage(var_22_12, "finish")

		if not UISpriteSetMgr.instance:getWeekWalkSpriteSetUnit() then
			arg_22_0:_setImgAlpha(var_22_16, 0)
			arg_22_0:_setImgAlpha(var_22_17, 0)
		end

		UISpriteSetMgr.instance:setWeekWalkSprite(var_22_16, var_22_6 and "btn_dian2" or "btn_dian4", true, 1)
		UISpriteSetMgr.instance:setWeekWalkSprite(var_22_17, var_22_6 and "btn_dian1" or "btn_dian3", true, 1)
		gohelper.setActive(gohelper.findChild(var_22_12, "finish_light_deepdream01"), not var_22_6 and var_22_15)
		gohelper.setActive(gohelper.findChild(var_22_12, "finish_light"), var_22_6 and var_22_15)
	end

	local var_22_18, var_22_19, var_22_20, var_22_21 = WeekWalkTaskListModel.instance:getAllDeepTaskInfo()

	arg_22_0._openMapId1 = var_22_21
	arg_22_0._txtcurrency1.text = var_22_18
	arg_22_0._txttotal1.text = var_22_19

	local var_22_22 = #var_22_20 > 0

	gohelper.setActive(arg_22_0._gonormal1, not var_22_22)
	gohelper.setActive(arg_22_0._gocanget1, var_22_22)
	gohelper.setActive(arg_22_0._gohasget1, var_22_18 == var_22_19)
end

function var_0_0._setImgAlpha(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_1.color

	var_23_0.a = arg_23_2
	arg_23_1.color = var_23_0
end

function var_0_0.getWeekTaskProgress()
	local var_24_0 = 0
	local var_24_1 = 0
	local var_24_2 = {}

	WeekWalkTaskListModel.instance:showTaskList(WeekWalkEnum.TaskType.Week)

	local var_24_3 = WeekWalkTaskListModel.instance:getList()

	for iter_24_0, iter_24_1 in ipairs(var_24_3) do
		local var_24_4 = WeekWalkTaskListModel.instance:getTaskMo(iter_24_1.id)

		if var_24_4 and (var_24_4.finishCount > 0 or var_24_4.hasFinished) then
			local var_24_5 = GameUtil.splitString2(iter_24_1.bonus, true, "|", "#")

			for iter_24_2, iter_24_3 in ipairs(var_24_5) do
				local var_24_6 = iter_24_3[1]
				local var_24_7 = iter_24_3[2]
				local var_24_8 = iter_24_3[3]
				local var_24_9 = string.format("%s_%s", var_24_6, var_24_7)
				local var_24_10 = var_24_2[var_24_9]

				if not var_24_10 then
					var_24_2[var_24_9] = iter_24_3
				else
					var_24_10[3] = var_24_10[3] + var_24_8
					var_24_2[var_24_9] = var_24_10
				end
			end
		end

		if var_24_4 then
			var_24_0 = math.max(var_24_4.progress or 0, var_24_0)
		end

		local var_24_11 = lua_task_weekwalk.configDict[iter_24_1.id]

		if var_24_11 then
			var_24_1 = math.max(var_24_11.maxProgress or 0, var_24_1)
		end
	end

	local var_24_12 = {}

	for iter_24_4, iter_24_5 in pairs(var_24_2) do
		table.insert(var_24_12, iter_24_5)
	end

	table.sort(var_24_12, var_0_0._sort)

	return var_24_0, var_24_1, var_24_12
end

function var_0_0._sort(arg_25_0, arg_25_1)
	local var_25_0 = ItemModel.instance:getItemConfig(arg_25_0[1], arg_25_0[2])
	local var_25_1 = ItemModel.instance:getItemConfig(arg_25_1[1], arg_25_1[2])

	if var_25_0.rare ~= var_25_1.rare then
		return var_25_0.rare > var_25_1.rare
	end

	return arg_25_0[3] > arg_25_1[3]
end

function var_0_0._showBonus(arg_26_0)
	if not WeekWalkTaskListModel.instance:hasTaskList() then
		return
	end

	local var_26_0, var_26_1, var_26_2 = var_0_0.getWeekTaskProgress()

	arg_26_0._txttaskprogress.text = string.format("%s/%s", var_26_0, var_26_1)

	if arg_26_0._gorewards then
		gohelper.destroyAllChildren(arg_26_0._gorewards)

		for iter_26_0, iter_26_1 in ipairs(var_26_2) do
			local var_26_3 = IconMgr.instance:getCommonItemIcon(arg_26_0._gorewards)

			var_26_3:setMOValue(iter_26_1[1], iter_26_1[2], iter_26_1[3])
			var_26_3:isShowCount(true)
			var_26_3:setCountFontSize(31)
		end
	end

	local var_26_4 = #var_26_2 > 0

	gohelper.setActive(arg_26_0._goempty, not var_26_4)
	gohelper.setActive(arg_26_0._gohasrewards, var_26_4)
end

function var_0_0.onUpdateParam(arg_27_0)
	arg_27_0._viewAnim:Play("dungeonweekwalk_in", 0, 0)
end

function var_0_0.onShow(arg_28_0)
	arg_28_0.viewContainer:setNavigateButtonViewHelpId()
	arg_28_0:_showWeekWalkSettlementView()

	if arg_28_0._bgmId then
		return
	end
end

function var_0_0._onFinishGuide(arg_29_0, arg_29_1)
	if arg_29_1 == 501 then
		arg_29_0:_showWeekWalkSettlementView()
	end
end

function var_0_0._showWeekWalkSettlementView(arg_30_0)
	local var_30_0 = GameGlobalMgr.instance:getLoadingState()

	if var_30_0 and var_30_0:getLoadingViewName() then
		return
	end

	if WeekWalkModel.instance:getSkipShowSettlementView() then
		WeekWalkModel.instance:setSkipShowSettlementView(false)

		return
	end

	if GuideController.instance:isGuiding() then
		return
	end

	local var_30_1 = WeekWalkModel.instance:getInfo()

	if var_30_1.isPopShallowSettle then
		WeekWalkController.instance:openWeekWalkShallowSettlementView()

		return
	end

	if var_30_1.isPopDeepSettle then
		WeekWalkController.instance:checkOpenWeekWalkDeepLayerNoticeView()

		return
	end

	WeekWalk_2Controller.instance:checkOpenWeekWalk_2DeepLayerNoticeView()
end

function var_0_0.onHide(arg_31_0)
	arg_31_0.viewContainer:resetNavigateButtonViewHelpId()
end

function var_0_0.onOpen(arg_32_0)
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, arg_32_0._refreshHelpFunc, arg_32_0._refreshTarget)
	arg_32_0:onShow()
end

function var_0_0.onOpenFinish(arg_33_0)
	arg_33_0.viewContainer:destoryTab(DungeonEnum.DungeonViewTabEnum.WeekWalk)
end

function var_0_0._showDeadline(arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._onRefreshDeadline, arg_34_0)

	arg_34_0._endTaskTime = WeekWalkController.getTaskEndTime(WeekWalkEnum.TaskType.Week)
	arg_34_0._endTime = WeekWalkModel.instance:getInfo().endTime
	arg_34_0._heartEndTime = WeekWalk_2Model.instance:getInfo().endTime

	TaskDispatcher.runRepeat(arg_34_0._onRefreshDeadline, arg_34_0, 1)
	arg_34_0:_onRefreshDeadline()
end

function var_0_0._onRefreshDeadline(arg_35_0)
	if arg_35_0._endTaskTime and arg_35_0._endTaskTime - ServerTime.now() <= 0 then
		arg_35_0._endTaskTime = nil

		WeekWalkController.instance:requestTask(true)
	end

	local var_35_0 = luaLang("p_dungeonweekwalkview_device")

	if arg_35_0._endTime then
		local var_35_1 = arg_35_0._endTime - ServerTime.now()

		if var_35_1 <= 0 then
			arg_35_0._endTime = nil

			TaskDispatcher.cancelTask(arg_35_0._onRefreshDeadline, arg_35_0)
		end

		local var_35_2, var_35_3 = TimeUtil.secondToRoughTime2(math.floor(var_35_1))

		arg_35_0._txttime.text = var_35_0 .. var_35_2 .. var_35_3
	end

	if arg_35_0._heartEndTime then
		local var_35_4 = arg_35_0._heartEndTime - ServerTime.now()

		if var_35_4 <= 0 then
			arg_35_0._heartEndTime = nil

			TaskDispatcher.cancelTask(arg_35_0._onRefreshDeadline, arg_35_0)
		end

		local var_35_5, var_35_6 = TimeUtil.secondToRoughTime2(math.floor(var_35_4))

		arg_35_0._txttime2.text = var_35_0 .. var_35_5 .. var_35_6
	end
end

function var_0_0._onGetInfo(arg_36_0)
	arg_36_0:_showDeadline()
end

function var_0_0._onWeekwalkTaskUpdate(arg_37_0)
	if ViewMgr.instance:isOpen(ViewName.WeekWalkRewardView) or ViewMgr.instance:isOpen(ViewName.WeekWalkLayerRewardView) then
		return
	end

	arg_37_0:_updateTaskStatus()
	arg_37_0:_showBonus()
	arg_37_0:_showDeadline()
end

function var_0_0._onWeekwalk_2TaskUpdate(arg_38_0)
	local var_38_0 = WeekWalk_2Enum.TaskType.Once
	local var_38_1, var_38_2 = WeekWalk_2TaskListModel.instance:canGetRewardNum(var_38_0)
	local var_38_3 = var_38_1 > 0

	gohelper.setActive(arg_38_0._gobubble, true)

	arg_38_0._gobubbleReddot = arg_38_0._gobubbleReddot or gohelper.findChild(arg_38_0.viewGO, "anim/heartbox/map/#btn_reward2/reddot")

	gohelper.setActive(arg_38_0._gobubbleReddot, var_38_3)

	arg_38_0._rewardAnimator = arg_38_0._rewardAnimator or arg_38_0._btnreward2.gameObject:GetComponent(typeof(UnityEngine.Animator))

	if arg_38_0._rewardAnimator then
		arg_38_0._rewardAnimator:Play(var_38_3 and "reward" or "idle")
	end

	if var_38_1 == 0 and var_38_2 == 0 then
		gohelper.setActive(arg_38_0._btnreward2, false)
	end

	arg_38_0:_showProgress()
	arg_38_0:_showProgress2()
end

function var_0_0._initOnOpen(arg_39_0)
	local var_39_0 = arg_39_0.viewContainer._navigateButtonView

	arg_39_0._refreshHelpFunc = var_39_0.showHelpBtnIcon
	arg_39_0._refreshTarget = var_39_0

	arg_39_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnSelectLevel, arg_39_0._OnSelectLevel, arg_39_0)
	arg_39_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_39_0._onCloseView, arg_39_0, LuaEventSystem.Low)
	arg_39_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_39_0._onOpenView, arg_39_0, LuaEventSystem.Low)
	arg_39_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_39_0._onOpenViewFinish, arg_39_0, LuaEventSystem.Low)
	arg_39_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, arg_39_0._onWeekwalkTaskUpdate, arg_39_0)
	arg_39_0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, arg_39_0._onWeekwalk_2TaskUpdate, arg_39_0)
	arg_39_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetInfo, arg_39_0._onGetInfo, arg_39_0)
	arg_39_0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnGetInfo, arg_39_0._onGetInfo, arg_39_0)
end

function var_0_0._OnSelectLevel(arg_40_0)
	arg_40_0._dropLevel.dropDown.enabled = false

	if WeekWalkModel.instance:getChangeLevel() > 0 then
		return
	end

	arg_40_0:openWeekWalkView()
end

function var_0_0.openWeekWalkView(arg_41_0)
	module_views_preloader.WeekWalkLayerViewPreload(function()
		arg_41_0:delayOpenWeekWalkView()
	end)
end

function var_0_0.delayOpenWeekWalkView(arg_43_0)
	WeekWalkController.instance:openWeekWalkLayerView()
end

function var_0_0._onOpenViewFinish(arg_44_0, arg_44_1)
	if arg_44_1 == ViewName.WeekWalkLayerView or arg_44_1 == ViewName.WeekWalk_2HeartLayerView or arg_44_1 == ViewName.StoreView then
		local var_44_0 = ViewMgr.instance:getContainer(ViewName.DungeonView)
		local var_44_1 = gohelper.findChild(var_44_0.viewGO, "top_left")

		gohelper.setActive(var_44_1, true)
	end
end

function var_0_0._onOpenView(arg_45_0, arg_45_1)
	if arg_45_1 == ViewName.WeekWalkLayerView then
		-- block empty
	end

	if arg_45_1 == ViewName.WeekWalkLayerView or arg_45_1 == ViewName.WeekWalk_2HeartLayerView or arg_45_1 == ViewName.StoreView then
		if arg_45_1 == ViewName.WeekWalk_2HeartLayerView then
			if ViewMgr.instance:isOpen(ViewName.WeekWalk_2HeartView) then
				return
			end

			arg_45_0._viewAnim:Play("dungeonweekwalk_out2", 0, 0)
		else
			arg_45_0._viewAnim:Play("dungeonweekwalk_out", 0, 0)
		end

		local var_45_0 = ViewMgr.instance:getContainer(ViewName.DungeonView)

		gohelper.setAsLastSibling(var_45_0.viewGO)

		local var_45_1 = gohelper.findChild(var_45_0.viewGO, "top_left")

		gohelper.setActive(var_45_1, false)
	end
end

function var_0_0._onCloseView(arg_46_0, arg_46_1)
	if arg_46_1 == ViewName.WeekWalkLayerView then
		arg_46_0:_showProgress()
		arg_46_0:_showWeekWalkSettlementView()
		arg_46_0._viewAnim:Play("dungeonweekwalk_in", 0, 0)
	elseif arg_46_1 == ViewName.StoreView then
		arg_46_0._viewAnim:Play("dungeonweekwalk_in", 0, 0)
	elseif arg_46_1 == ViewName.WeekWalkRewardView then
		arg_46_0:_onWeekwalkTaskUpdate()
	elseif arg_46_1 == ViewName.WeekWalk_2HeartLayerView then
		arg_46_0:_showProgress2()
		arg_46_0._viewAnim:Play("dungeonweekwalk_in", 0, 0)
	end
end

function var_0_0.onClose(arg_47_0)
	arg_47_0:onHide()
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, arg_47_0._refreshHelpFunc, arg_47_0._refreshTarget)
end

function var_0_0._clearOnDestroy(arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0.delayOpenWeekWalkView, arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0._openStoreView, arg_48_0)
	arg_48_0:removeEventCb(WeekWalkController.instance, WeekWalkEvent.OnSelectLevel, arg_48_0._OnSelectLevel, arg_48_0)
	arg_48_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_48_0._onCloseView, arg_48_0, LuaEventSystem.Low)
	arg_48_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_48_0._onOpenView, arg_48_0, LuaEventSystem.Low)
	arg_48_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_48_0._onOpenViewFinish, arg_48_0, LuaEventSystem.Low)
	arg_48_0:removeEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, arg_48_0._onWeekwalkTaskUpdate, arg_48_0)
	arg_48_0:removeEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetInfo, arg_48_0._onGetInfo, arg_48_0)
	arg_48_0:removeEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnGetInfo, arg_48_0._onGetInfo, arg_48_0)
	arg_48_0:removeEventCb(GuideController.instance, GuideEvent.FinishGuide, arg_48_0._onFinishGuide, arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0._onRefreshDeadline, arg_48_0)
end

function var_0_0.onDestroyView(arg_49_0)
	arg_49_0:_clearOnDestroy()
	arg_49_0._simagexingdian1:UnLoadImage()
	arg_49_0._simagelefttopglow:UnLoadImage()
	arg_49_0._simagelefttopglow2:UnLoadImage()
	arg_49_0._simageleftdownglow:UnLoadImage()
	arg_49_0._simagerihtttopglow:UnLoadImage()
	arg_49_0._simagerihtttopblack:UnLoadImage()
	arg_49_0._simagecenterdown:UnLoadImage()
end

return var_0_0
