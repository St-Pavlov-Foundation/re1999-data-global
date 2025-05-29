module("modules.logic.weekwalk_2.view.WeekWalk_2HeartView", package.seeall)

local var_0_0 = class("WeekWalk_2HeartView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "#go_finish")
	arg_1_0._scrollnull = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_finish/weekwalkending/#scroll_null")
	arg_1_0._gostartemplate = gohelper.findChild(arg_1_0.viewGO, "#go_finish/weekwalkending/#scroll_null/starlist/#go_star_template")
	arg_1_0._simagefinishbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_finish/#simage_finishbg")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "GameObject/#btn_reward")
	arg_1_0._gorewardredpoint = gohelper.findChild(arg_1_0.viewGO, "GameObject/#btn_reward/#go_rewardredpoint")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "GameObject/#btn_detail")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "GameObject/#btn_reset")
	arg_1_0._simagebgimgnext = gohelper.findChildSingleImage(arg_1_0.viewGO, "transition/ani/#simage_bgimg_next")
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "#go_info")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.viewGO, "#go_info/title/#txt_index")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_info/title/#txt_nameen")
	arg_1_0._simagestage = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_info/title/#simage_stage")
	arg_1_0._txtbattlename = gohelper.findChildText(arg_1_0.viewGO, "#go_info/title/#txt_battlename")
	arg_1_0._btndetail2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/title/#txt_battlename/#btn_detail2")
	arg_1_0._txtnameen2 = gohelper.findChildText(arg_1_0.viewGO, "#go_info/title/#txt_nameen2")
	arg_1_0._gochapter1 = gohelper.findChild(arg_1_0.viewGO, "#go_info/#go_chapter1")
	arg_1_0._imageIcon11 = gohelper.findChildImage(arg_1_0.viewGO, "#go_info/#go_chapter1/badge/go/#image_Icon11")
	arg_1_0._imageIcon12 = gohelper.findChildImage(arg_1_0.viewGO, "#go_info/#go_chapter1/badge/go/#image_Icon12")
	arg_1_0._imageIcon13 = gohelper.findChildImage(arg_1_0.viewGO, "#go_info/#go_chapter1/badge/go/#image_Icon13")
	arg_1_0._txtchapternum1 = gohelper.findChildText(arg_1_0.viewGO, "#go_info/#go_chapter1/#txt_chapternum1")
	arg_1_0._btnchapter1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/#go_chapter1/#btn_chapter1")
	arg_1_0._gochapter2 = gohelper.findChild(arg_1_0.viewGO, "#go_info/#go_chapter2")
	arg_1_0._imageIcon21 = gohelper.findChildImage(arg_1_0.viewGO, "#go_info/#go_chapter2/badge/go/#image_Icon21")
	arg_1_0._imageIcon22 = gohelper.findChildImage(arg_1_0.viewGO, "#go_info/#go_chapter2/badge/go/#image_Icon22")
	arg_1_0._imageIcon23 = gohelper.findChildImage(arg_1_0.viewGO, "#go_info/#go_chapter2/badge/go/#image_Icon23")
	arg_1_0._txtchapternum2 = gohelper.findChildText(arg_1_0.viewGO, "#go_info/#go_chapter2/#txt_chapternum2")
	arg_1_0._btnchapter2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/#go_chapter2/#btn_chapter2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btndetail2:AddClickListener(arg_2_0._btndetail2OnClick, arg_2_0)
	arg_2_0._btnchapter1:AddClickListener(arg_2_0._btnchapter1OnClick, arg_2_0)
	arg_2_0._btnchapter2:AddClickListener(arg_2_0._btnchapter2OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btndetail:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btndetail2:RemoveClickListener()
	arg_3_0._btnchapter1:RemoveClickListener()
	arg_3_0._btnchapter2:RemoveClickListener()
end

function var_0_0._btnchapter1OnClick(arg_4_0)
	if arg_4_0._battle1Finished then
		return
	end

	arg_4_0:enterWeekwalk_2Fight(WeekWalk_2Enum.BattleIndex.First)
end

function var_0_0._btnchapter2OnClick(arg_5_0)
	if not arg_5_0._battle1Finished or arg_5_0._battle2Finished then
		return
	end

	arg_5_0:enterWeekwalk_2Fight(WeekWalk_2Enum.BattleIndex.Second)
end

function var_0_0.enterWeekwalk_2Fight(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._layerInfo:getBattleInfo(arg_6_1)
	local var_6_1 = var_6_0.battleId
	local var_6_2 = var_6_0.elementId

	WeekWalk_2Controller.instance:enterWeekwalk_2Fight(var_6_2, var_6_1)
end

function var_0_0._btndetail2OnClick(arg_7_0)
	return
end

function var_0_0._btnrewardOnClick(arg_8_0)
	WeekWalk_2Controller.instance:openWeekWalk_2LayerRewardView({
		mapId = arg_8_0._layerInfo.id
	})
end

function var_0_0._btndetailOnClick(arg_9_0)
	EnemyInfoController.instance:openWeekWalk_2EnemyInfoView(arg_9_0._layerInfo.id)
end

function var_0_0._btnresetOnClick(arg_10_0)
	WeekWalk_2Controller.instance:openWeekWalk_2ResetView()
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0._viewAnim = arg_11_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_11_0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkResetLayer, arg_11_0._onWeekwalkResetLayer, arg_11_0)
	arg_11_0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, arg_11_0._onWeekwalkTaskUpdate, arg_11_0)
end

function var_0_0._updateChess(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._chess1 = arg_12_0._chess1 or gohelper.findChildImage(arg_12_0._gochapter1, "chess")
	arg_12_0._chess2 = arg_12_0._chess2 or gohelper.findChildImage(arg_12_0._gochapter2, "chess")

	local var_12_0 = lua_weekwalk_ver2.configDict[arg_12_0._mapId]
	local var_12_1 = var_12_0.resIdFront
	local var_12_2 = var_12_0.resIdRear
	local var_12_3 = lua_weekwalk_ver2_element_res.configDict[var_12_1]
	local var_12_4 = lua_weekwalk_ver2_element_res.configDict[var_12_2]

	if var_12_3 then
		UISpriteSetMgr.instance:setWeekWalkSprite(arg_12_0._chess1, var_12_3.res .. (not arg_12_1 and "_1" or "_0"))
	end

	if var_12_4 then
		UISpriteSetMgr.instance:setWeekWalkSprite(arg_12_0._chess2, var_12_4.res .. (not arg_12_2 and "_1" or "_0"))
	end
end

function var_0_0._onWeekwalkTaskUpdate(arg_13_0)
	arg_13_0:_updateReward()
end

function var_0_0._onWeekwalkResetLayer(arg_14_0)
	arg_14_0._mapInfo = WeekWalk_2Model.instance:getLayerInfo(arg_14_0._mapId)
	arg_14_0._viewAnim.enabled = true

	arg_14_0._viewAnim:Play("transition", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_ui_artificial_mist)
	arg_14_0:_updateBattleStatus()
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0._mapId = arg_15_0.viewParam.mapId
	arg_15_0._layerInfo = WeekWalk_2Model.instance:getLayerInfo(arg_15_0._mapId)
	arg_15_0._layerSceneConfig = arg_15_0._layerInfo.sceneConfig
	arg_15_0._index = arg_15_0._layerInfo:getLayer()
	arg_15_0._txtindex.text = tostring(arg_15_0._index)
	arg_15_0._txtbattlename.text = arg_15_0._layerSceneConfig.battleName
	arg_15_0._txtnameen.text = arg_15_0._layerSceneConfig.name_en

	local var_15_0 = string.format("weekwalkheart_stage%s", arg_15_0._layerInfo.config.layer)

	arg_15_0._simagestage:LoadImage(ResUrl.getWeekWalkLayerIcon(var_15_0))
	arg_15_0:_updateBattleStatus()
	arg_15_0:_updateReward()
end

function var_0_0._updateReward(arg_16_0)
	local var_16_0 = arg_16_0._mapId
	local var_16_1 = WeekWalk_2Enum.TaskType.Season
	local var_16_2, var_16_3 = WeekWalk_2TaskListModel.instance:canGetRewardNum(var_16_1, var_16_0)
	local var_16_4 = var_16_2 > 0

	gohelper.setActive(arg_16_0._gorewardredpoint, var_16_4)
end

function var_0_0._updateBattleStatus(arg_17_0)
	local var_17_0 = arg_17_0._layerInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.First)
	local var_17_1 = arg_17_0._layerInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.Second)

	arg_17_0._battle1Finished = var_17_0.status == WeekWalk_2Enum.BattleStatus.Finished
	arg_17_0._battle2Finished = var_17_1.status == WeekWalk_2Enum.BattleStatus.Finished

	local var_17_2 = gohelper.findChild(arg_17_0._gochapter1, "finished")
	local var_17_3 = gohelper.findChild(arg_17_0._gochapter2, "finished")

	gohelper.setActive(var_17_2, not arg_17_0._battle1Finished)
	gohelper.setActive(var_17_3, not arg_17_0._battle2Finished)
	gohelper.setActive(arg_17_0._gochapter2, arg_17_0._battle1Finished)
	arg_17_0:_updateStarList(WeekWalk_2Enum.BattleIndex.First)

	if arg_17_0._battle1Finished then
		arg_17_0:_updateStarList(WeekWalk_2Enum.BattleIndex.Second)
	end

	arg_17_0:_updateChess(arg_17_0._battle1Finished, arg_17_0._battle2Finished)
end

function var_0_0._updateStarList(arg_18_0, arg_18_1)
	arg_18_0._iconEffectStatus = arg_18_0._iconEffectStatus or arg_18_0:getUserDataTb_()

	local var_18_0 = arg_18_0._layerInfo:getBattleInfo(arg_18_1)

	for iter_18_0 = 1, WeekWalk_2Enum.MaxStar do
		local var_18_1 = arg_18_0["_imageIcon" .. arg_18_1 .. iter_18_0]

		if not arg_18_0._iconEffectStatus[var_18_1] then
			var_18_1.enabled = false

			local var_18_2 = arg_18_0:getResInst(arg_18_0.viewContainer._viewSetting.otherRes.weekwalkheart_star, var_18_1.gameObject)

			arg_18_0._iconEffectStatus[var_18_1] = var_18_2
		end

		local var_18_3 = var_18_0:getCupInfo(iter_18_0)
		local var_18_4 = var_18_3 and var_18_3.result or 0

		WeekWalk_2Helper.setCupEffectByResult(arg_18_0._iconEffectStatus[var_18_1], var_18_4)
	end
end

function var_0_0.onClose(arg_19_0)
	return
end

function var_0_0.onDestroyView(arg_20_0)
	return
end

return var_0_0
