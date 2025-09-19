module("modules.logic.weekwalk.view.WeekWalkLayerPageItem", package.seeall)

local var_0_0 = class("WeekWalkLayerPageItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtbattlename = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_battlename")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "info/#txt_battlename/#btn_detail")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_name")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_index")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_index/#txt_nameen")
	arg_1_0._txtprogress = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_progress")
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.viewGO, "#go_unlock")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_unlock/#btn_click")
	arg_1_0._simagemapicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_unlock/#btn_click/#simage_mapicon")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_unlock/#btn_click/#simage_icon")
	arg_1_0._gohardmode = gohelper.findChild(arg_1_0.viewGO, "#go_unlock/#btn_click/#go_hardmode")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#go_lock")
	arg_1_0._btnlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_lock/#btn_lock")
	arg_1_0._simagelockicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_lock/#btn_lock/#simage_lockicon")
	arg_1_0._golockhardmode = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_lock/#btn_lock/#go_hardmode")
	arg_1_0._gomapfinish = gohelper.findChild(arg_1_0.viewGO, "#go_mapfinish")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reward")
	arg_1_0._gorewardIcon = gohelper.findChild(arg_1_0.viewGO, "#btn_reward/#go_rewardIcon")
	arg_1_0._gonormalIcon = gohelper.findChild(arg_1_0.viewGO, "#btn_reward/#go_normalIcon")
	arg_1_0._gorewardfinish = gohelper.findChild(arg_1_0.viewGO, "#btn_reward/#go_rewardfinish")
	arg_1_0._goline = gohelper.findChildImage(arg_1_0.viewGO, "#go_mapfinish/clearancegraphics_01_mask/clearancegraphics_01")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnlock:AddClickListener(arg_2_0._btnlockOnClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndetail:RemoveClickListener()
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnlock:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
end

function var_0_0._btnlockOnClick(arg_4_0)
	local var_4_0 = WeekWalkModel.instance:getInfo()

	if not WeekWalkModel.isShallowLayer(arg_4_0._config.layer) and not var_4_0.isOpenDeep then
		GameFacade.showToast(ToastEnum.WeekWalkIsShallowLayer)

		return
	end

	local var_4_1 = arg_4_0._config.preId

	if var_4_1 > 0 then
		local var_4_2 = WeekWalkModel.instance:getMapInfo(var_4_1)

		if var_4_2 and not var_4_2:getNoStarBattleInfo() then
			GameFacade.showToast(ToastEnum.WeekWalkNotFinishStory)

			return
		end
	end

	GameFacade.showToast(ToastEnum.WeekWalkLayerPage)
end

function var_0_0._btnrewardOnClick(arg_5_0)
	WeekWalkController.instance:openWeekWalkLayerRewardView({
		mapId = arg_5_0._config.id
	})
end

function var_0_0._btndetailOnClick(arg_6_0)
	EnemyInfoController.instance:openWeekWalkEnemyInfoView(arg_6_0._config.id)
end

function var_0_0._btnclickOnClick(arg_7_0)
	WeekWalkController.instance:openWeekWalkView({
		mapId = arg_7_0._config.id
	})
end

function var_0_0.ctor(arg_8_0, arg_8_1)
	arg_8_0._config = arg_8_1[1]
	arg_8_0._pageIndex = arg_8_1[2]
	arg_8_0._layerPage = arg_8_1[3]
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._animator = arg_9_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if WeekWalkModel.isShallowLayer(arg_9_0._config.layer) then
		arg_9_0._simageicon:LoadImage(ResUrl.getWeekWalkLayerIcon("shallow"))
		arg_9_0._simagelockicon:LoadImage(ResUrl.getWeekWalkLayerIcon("shallow_unknown"))
	else
		local var_9_0 = arg_9_0._config.layer == WeekWalkEnum.HardDeepLayerId

		gohelper.setActive(arg_9_0._gohardmode, var_9_0)
		gohelper.setActive(arg_9_0._simageicon, not var_9_0)
		gohelper.setActive(arg_9_0._golockhardmode, var_9_0)
		gohelper.setActive(arg_9_0._simagelockicon, not var_9_0)

		if not var_9_0 then
			arg_9_0._simageicon:LoadImage(ResUrl.getWeekWalkLayerIcon("deep"))
			arg_9_0._simagelockicon:LoadImage(ResUrl.getWeekWalkLayerIcon("deep_unknown"))
		end
	end

	gohelper.setActive(arg_9_0._btndetail.gameObject, false)
	gohelper.addUIClickAudio(arg_9_0._btndetail.gameObject, AudioEnum.UI.play_ui_action_explore)
	gohelper.addUIClickAudio(arg_9_0._btnclick.gameObject, AudioEnum.WeekWalk.play_artificial_ui_mapopen)
	gohelper.addUIClickAudio(arg_9_0._btnreward.gameObject, AudioEnum.WeekWalk.play_artificial_ui_rewardpoints)
	WeekWalkController.instance:registerCallback(WeekWalkEvent.OnScrollPage, arg_9_0._setEdgFadeStrengthen, arg_9_0)

	arg_9_0._goline.material = UnityEngine.GameObject.Instantiate(arg_9_0._goline.material)

	arg_9_0._goline.material:EnableKeyword("_EDGE_GRADUAL")
	arg_9_0._goline.material:SetFloat(ShaderPropertyId.Scroll_LeftRamp, 1)
	arg_9_0:openEdgFadeEffect()
end

function var_0_0._setEdgFadeStrengthen(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0._pageIndex ~= arg_10_2 then
		return
	end

	for iter_10_0, iter_10_1 in pairs(arg_10_0._graphics) do
		if iter_10_1.gameObject:GetComponent(gohelper.Type_TextMesh) then
			iter_10_1.fontMaterial:SetFloat(ShaderPropertyId.Scroll_LeftRamp, arg_10_1)
		else
			iter_10_1.material:SetFloat(ShaderPropertyId.Scroll_LeftRamp, arg_10_1)
		end
	end
end

function var_0_0._playAnim(arg_11_0, arg_11_1)
	arg_11_0._animator.enabled = true

	arg_11_0._animator:Play(arg_11_1)
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:_updateStatus()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_12_0._onCloseViewFinish, arg_12_0, LuaEventSystem.Low)
	WeekWalkController.instance:registerCallback(WeekWalkEvent.OnGetInfo, arg_12_0._onGetInfo, arg_12_0)
	arg_12_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, arg_12_0._onWeekwalkTaskUpdate, arg_12_0)
end

local var_0_1 = {}

function var_0_0.openEdgFadeEffect(arg_13_0)
	arg_13_0._graphics = arg_13_0._graphics or arg_13_0:getUserDataTb_()

	local var_13_0 = arg_13_0.viewGO:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic), true):GetEnumerator()
	local var_13_1

	while var_13_0:MoveNext() do
		local var_13_2 = var_13_0.Current

		if var_13_2:GetComponent(gohelper.Type_TextMesh) then
			local var_13_3 = var_13_2.font.name .. "_edgefade"
			local var_13_4 = var_0_1[var_13_3]

			if not var_13_4 then
				var_13_4 = UnityEngine.GameObject.Instantiate(var_13_2.fontSharedMaterial)
				var_13_4.name = var_13_3

				var_13_4:EnableKeyword("_EDGE_GRADUAL")

				var_0_1[var_13_3] = var_13_4
			end

			var_13_2.fontSharedMaterial = var_13_4
		elseif var_13_2.material.name == "edgfade" then
			if not var_0_1.imgMat then
				var_0_1.imgMat = UnityEngine.GameObject.Instantiate(var_13_2.material)
				var_0_1.imgMat.name = "img_edgefade"

				var_0_1.imgMat:EnableKeyword("_EDGE_GRADUAL")
			end

			var_13_2.material = var_0_1.imgMat
		end

		if var_13_2 ~= arg_13_0._goline then
			table.insert(arg_13_0._graphics, var_13_0.Current)
		end
	end
end

function var_0_0.onClose(arg_14_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_14_0._onCloseViewFinish, arg_14_0)
	WeekWalkController.instance:unregisterCallback(WeekWalkEvent.OnGetInfo, arg_14_0._onGetInfo, arg_14_0)
	arg_14_0:removeEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, arg_14_0._onWeekwalkTaskUpdate, arg_14_0)
	WeekWalkController.instance:unregisterCallback(WeekWalkEvent.OnScrollPage, arg_14_0._setEdgFadeStrengthen, arg_14_0)
end

function var_0_0._onWeekwalkTaskUpdate(arg_15_0)
	if ViewMgr.instance:isOpen(ViewName.WeekWalkView) then
		return
	end

	arg_15_0:_updateStatus()
end

function var_0_0._updateDeepConfig(arg_16_0)
	if WeekWalkModel.isShallowLayer(arg_16_0._config.layer) then
		return
	end

	local var_16_0 = WeekWalkModel.instance:getInfo()
	local var_16_1 = WeekWalkConfig.instance:getDeepLayer(var_16_0.issueId)

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		if iter_16_1.layer == arg_16_0._config.layer then
			arg_16_0._config = iter_16_1

			return
		end
	end
end

function var_0_0._onGetInfo(arg_17_0)
	arg_17_0:_updateDeepConfig()

	local var_17_0 = WeekWalkModel.instance:getInfo()

	if not WeekWalkModel.isShallowLayer(arg_17_0._config.layer) and var_17_0.isOpenDeep and arg_17_0._layerPage:getVisible() and not arg_17_0._mapInfo and WeekWalkModel.instance:getMapInfo(arg_17_0._config.id) then
		arg_17_0._showUnlockAnim = true
	end

	arg_17_0:_updateStatus()

	arg_17_0._showUnlockAnim = nil
end

function var_0_0._onCloseViewFinish(arg_18_0, arg_18_1)
	if arg_18_1 == ViewName.WeekWalkView then
		arg_18_0:_updateStatus()
	end
end

function var_0_0._updateProgress(arg_19_0)
	local var_19_0 = TaskConfig.instance:getWeekWalkRewardList(arg_19_0._config.layer)
	local var_19_1 = 0
	local var_19_2 = 0

	if var_19_0 then
		for iter_19_0, iter_19_1 in pairs(var_19_0) do
			local var_19_3 = lua_task_weekwalk.configDict[iter_19_0]

			if var_19_3 and WeekWalkTaskListModel.instance:checkPeriods(var_19_3) then
				var_19_2 = var_19_2 + iter_19_1

				local var_19_4 = WeekWalkTaskListModel.instance:getTaskMo(iter_19_0)
				local var_19_5 = lua_task_weekwalk.configDict[iter_19_0]

				if var_19_4 and var_19_4.finishCount >= var_19_5.maxFinishCount then
					var_19_1 = var_19_1 + iter_19_1
				end
			end
		end
	end

	arg_19_0._txtprogress.text = string.format("%s/%s", var_19_1, var_19_2)
	arg_19_0._txtprogress.alpha = var_19_2 <= var_19_1 and 0.45 or 1
end

function var_0_0.updateUnlockStatus(arg_20_0)
	if not arg_20_0._layerPage:getVisible() then
		return
	end

	local var_20_0 = WeekWalkModel.instance:getFinishMapId()

	if var_20_0 and var_20_0 < arg_20_0._config.id then
		arg_20_0:_updateStatus()
	end
end

function var_0_0._updateStatus(arg_21_0)
	arg_21_0._mapInfo = WeekWalkModel.instance:getMapInfo(arg_21_0._config.id)

	local var_21_0 = lua_weekwalk_scene.configDict[arg_21_0._mapInfo and arg_21_0._mapInfo.sceneId or arg_21_0._config.sceneId]

	arg_21_0._txtname.text = var_21_0.name
	arg_21_0._txtbattlename.text = arg_21_0._mapInfo and var_21_0.battleName or luaLang("weekwalklayerpageitem_unknowdream")
	arg_21_0._txtnameen.text = arg_21_0._mapInfo and var_21_0.name_en or "Dream To Be Dreamed"
	arg_21_0._txtindex.text = arg_21_0._config.layer

	arg_21_0._simagemapicon:LoadImage(ResUrl.getWeekWalkLayerIcon("img_" .. var_21_0.icon))
	arg_21_0:_updateProgress()

	if not arg_21_0._mapInfo then
		gohelper.setActive(arg_21_0._gorewardIcon, false)
		gohelper.setActive(arg_21_0._gorewardfinish, false)
		gohelper.setActive(arg_21_0._gonormalIcon, true)
		gohelper.setActive(arg_21_0._gomapfinish, false)
		gohelper.setActive(arg_21_0._gounlock, arg_21_0._mapInfo)
		gohelper.setActive(arg_21_0._golock, not arg_21_0._mapInfo)

		return
	end

	local var_21_1 = arg_21_0._mapInfo
	local var_21_2 = WeekWalkModel.instance:getFinishMapId()
	local var_21_3 = arg_21_0._layerPage:getVisible() and var_21_2 and var_21_2 < arg_21_0._config.id

	if var_21_3 or arg_21_0._showUnlockAnim then
		WeekWalkModel.instance:setFinishMapId(nil)

		if arg_21_0._mapInfo.isFinish ~= 1 then
			arg_21_0:_playAnim("weekwalklayerpageitem_unlock_in")
			AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_unlockdream)
		end
	else
		if not arg_21_0._layerPage:getVisible() and var_21_2 and var_21_2 < arg_21_0._config.id then
			var_21_1 = false
		end

		gohelper.setActive(arg_21_0._gounlock, var_21_1)
		gohelper.setActive(arg_21_0._golock, not var_21_1)
	end

	local var_21_4 = arg_21_0._config.id
	local var_21_5 = WeekWalkRewardView.getTaskType(var_21_4)
	local var_21_6, var_21_7 = WeekWalkTaskListModel.instance:canGetRewardNum(var_21_5, var_21_4)
	local var_21_8 = var_21_6 > 0

	gohelper.setActive(arg_21_0._gorewardIcon, var_21_8)
	gohelper.setActive(arg_21_0._gorewardfinish, not var_21_8 and var_21_7 <= 0)
	gohelper.setActive(arg_21_0._gonormalIcon, not var_21_8 and var_21_7 > 0)
	gohelper.setActive(arg_21_0._gomapfinish, arg_21_0._mapInfo.isFinished > 0)

	if (var_21_8 or arg_21_0._mapInfo.isFinished > 0) and not var_21_1 then
		logError(string.format("WeekWalkLayerPageItem error unlock mapId:%s canGetReward:%s isUnlock:%s showUnlockAnim:%s self._showUnlockAnim:%s finishMapId:%s pageVisible:%s isFinished:%s", var_21_4, var_21_8, var_21_1, var_21_3, arg_21_0._showUnlockAnim, var_21_2, arg_21_0._layerPage:getVisible(), arg_21_0._mapInfo.isFinished))
	end
end

function var_0_0.onDestroyView(arg_22_0)
	return
end

function var_0_0.disableKeyword(arg_23_0)
	if not arg_23_0._graphics then
		return
	end

	for iter_23_0, iter_23_1 in pairs(arg_23_0._graphics) do
		iter_23_1.material:DisableKeyword("_EDGE_GRADUAL")
	end
end

function var_0_0.init(arg_24_0, arg_24_1)
	arg_24_0.viewGO = arg_24_1

	arg_24_0:onInitView()
	arg_24_0:addEvents()
	arg_24_0:onOpen()
end

function var_0_0.onDestroy(arg_25_0)
	arg_25_0._simageicon:UnLoadImage()
	arg_25_0._simagelockicon:UnLoadImage()
	arg_25_0._simagemapicon:UnLoadImage()
	arg_25_0:onClose()
	arg_25_0:removeEvents()
	arg_25_0:disableKeyword()
	arg_25_0:onDestroyView()

	if var_0_1 then
		for iter_25_0, iter_25_1 in pairs(var_0_1) do
			gohelper.destroy(iter_25_1)

			var_0_1[iter_25_0] = nil
		end

		var_0_1 = {}
	end
end

return var_0_0
