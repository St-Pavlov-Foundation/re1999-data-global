module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonMapScene", package.seeall)

local var_0_0 = class("VersionActivity1_2DungeonMapScene", VersionActivity1_2DungeonMapBaseScene)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotaskitem = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "#go_tasklist/#go_taskitem", AudioEnum.UI.play_ui_main_shield)
	arg_1_0._focusBtnStateOff = gohelper.findChild(arg_1_0.viewGO, "#btn_4/icon/#go_off")
	arg_1_0._focusBtnStateOn = gohelper.findChild(arg_1_0.viewGO, "#btn_4/icon/#go_on")
	arg_1_0._btn4 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_4")

	var_0_0.super.onInitView(arg_1_0)
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0._btn4:AddClickListener(arg_2_0._onClickBtn4, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._gotaskitem, arg_2_0._onClickDaily, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveGet116InfosReply, arg_2_0._onReceiveGet116InfosReply, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.addElementItem, arg_2_0._onAddElementItem, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceivePutTrapReply, arg_2_0._onReceivePutTrapReply, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveUpgradeElementReply, arg_2_0._onReceiveUpgradeElementReply, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.focusMap, arg_2_0._onFocusMap, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.selectEpisodeItem, arg_2_0._selectEpisodeItem, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.clickDailyEpisode, arg_2_0._clickDailyEpisode, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_2_0._OnRemoveElement, arg_2_0)
	var_0_0.super.onOpen(arg_2_0)
	arg_2_0:_showDailyBtn()
	arg_2_0:_showFocusBtn()
end

function var_0_0._onReceiveGet116InfosReply(arg_3_0)
	local var_3_0 = arg_3_0.viewContainer.mapSceneElement
	local var_3_1 = var_3_0 and var_3_0._elementList

	if var_3_1 then
		for iter_3_0, iter_3_1 in pairs(var_3_1) do
			local var_3_2 = iter_3_1._config

			if var_3_2 and var_3_2.type == DungeonEnum.ElementType.Activity1_2Building_Upgrade then
				arg_3_0:_onReceiveUpgradeElementReply(var_3_2.id)
			end
		end
	end
end

function var_0_0._clickDailyEpisode(arg_4_0, arg_4_1)
	if arg_4_0._dailyEpisodeItems then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0._dailyEpisodeItems) do
			if iter_4_1.viewGO.activeInHierarchy and iter_4_1._elementConfig.type == DungeonEnum.ElementType.DailyEpisode and arg_4_1 == iter_4_1._elementConfig.id then
				iter_4_1:_onClick()

				break
			end
		end
	end
end

function var_0_0.reopenViewParamPrecessed(arg_5_0)
	if arg_5_0.viewParam.focusCamp then
		arg_5_0:_onClickBtn4()
	end
end

function var_0_0.getFocusBtnUnlockAniState()
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2FocusBtnUnlockAni, 0)
end

function var_0_0.setFocusBtnUnlockAniState(arg_7_0)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2FocusBtnUnlockAni, arg_7_0 or 1)
end

function var_0_0._showFocusBtn(arg_8_0)
	local var_8_0 = DungeonMapModel.instance:getElementById(12101021)

	gohelper.setActive(arg_8_0._btn4.gameObject, var_8_0)

	if var_8_0 and var_0_0.getFocusBtnUnlockAniState() == 0 then
		var_0_0.setFocusBtnUnlockAniState(1)
		gohelper.onceAddComponent(arg_8_0._btn4.gameObject, typeof(UnityEngine.Animator)):Play("unlock")
	end
end

function var_0_0._showFocusBtnState(arg_9_0)
	if arg_9_0._sceneGo then
		local var_9_0, var_9_1 = transformhelper.getLocalPos(arg_9_0._sceneGo.transform)
		local var_9_2 = true

		if math.abs(-88 - var_9_0) >= 10 or math.abs(24 - var_9_1) >= 7 then
			var_9_2 = false
		end

		gohelper.setActive(arg_9_0._focusBtnStateOn, var_9_2)
		gohelper.setActive(arg_9_0._focusBtnStateOff, not var_9_2)

		arg_9_0._focusing = var_9_2
	end
end

function var_0_0._onLoadSceneFinish(arg_10_0)
	MainCameraMgr.instance:addView(ViewName.VersionActivity1_2DungeonView, arg_10_0._initCamera, nil, arg_10_0)
end

function var_0_0._onFocusMap(arg_11_0, arg_11_1)
	arg_11_0:setScenePosSafety(arg_11_1, true)
end

function var_0_0._disposeScene(arg_12_0)
	arg_12_0:_closeAllDailyEpisode()
	var_0_0.super._disposeScene(arg_12_0)
end

function var_0_0._showDailyBtn(arg_13_0)
	arg_13_0._curDailyItem = nil

	local var_13_0 = false

	if arg_13_0._dailyEpisodeItems then
		table.sort(arg_13_0._dailyEpisodeItems, var_0_0.sortDailyEpisode)

		for iter_13_0, iter_13_1 in ipairs(arg_13_0._dailyEpisodeItems) do
			if iter_13_1.viewGO.activeInHierarchy then
				var_13_0 = true
				gohelper.findChildText(arg_13_0._gotaskitem.gameObject, "bg/info").text = formatLuaLang("versionactivity_1_2_daily_episode_btn", iter_13_1._episodeConfig.name)

				local var_13_1 = gohelper.findChildImage(arg_13_0._gotaskitem.gameObject, "bg/icon")
				local var_13_2

				if iter_13_1._elementConfig.type == DungeonEnum.ElementType.DailyEpisode then
					var_13_2 = "zhuxianditu_renwuicon_1020"

					if TimeUtil.getDayFirstLoginRed("act1_2DailySpEpisode" .. iter_13_1._elementConfig.id) then
						TimeUtil.setDayFirstLoginRed("act1_2DailySpEpisode" .. iter_13_1._elementConfig.id)

						local var_13_3 = string.splitToNumber(iter_13_1._elementConfig.pos, "#")
						local var_13_4 = Vector3(-var_13_3[1], -var_13_3[2] - 3, 0)

						VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.focusMap, var_13_4)
					end
				else
					var_13_2 = "zhuxianditu_renwuicon_20"
				end

				UISpriteSetMgr.instance:setUiFBSprite(var_13_1, var_13_2)

				arg_13_0._curDailyItem = iter_13_1

				break
			end
		end
	end

	gohelper.setActive(arg_13_0._gotaskitem.gameObject, var_13_0)
end

function var_0_0.sortDailyEpisode(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._elementConfig.type
	local var_14_1 = arg_14_1._elementConfig.type

	if var_14_0 == DungeonEnum.ElementType.Activity1_2Fight and var_14_1 == DungeonEnum.ElementType.Activity1_2Fight then
		return arg_14_0._elementConfig.id < arg_14_1._elementConfig.id
	elseif var_14_0 == DungeonEnum.ElementType.Activity1_2Fight and var_14_1 == DungeonEnum.ElementType.DailyEpisode then
		return true
	elseif var_14_0 == DungeonEnum.ElementType.DailyEpisode and var_14_1 == DungeonEnum.ElementType.Activity1_2Fight then
		return false
	else
		local var_14_2 = lua_activity116_episode_sp.configDict[arg_14_0._episodeConfig.id]
		local var_14_3 = lua_activity116_episode_sp.configDict[arg_14_1._episodeConfig.id]

		return var_14_2.refreshDay < var_14_3.refreshDay
	end
end

function var_0_0._onClickDaily(arg_15_0)
	if arg_15_0._curDailyItem then
		arg_15_0._curDailyItem:_onClick()
	end
end

function var_0_0._onAddElementItem(arg_16_0, arg_16_1)
	local var_16_0 = gohelper.findChild(arg_16_0._sceneGo, "elementRoot/" .. arg_16_1)

	arg_16_0:_detectElementNeedSetPos(arg_16_1)

	local var_16_1 = lua_chapter_map_element.configDict[arg_16_1]

	if var_16_1.type == DungeonEnum.ElementType.DailyEpisode or var_16_1.type == DungeonEnum.ElementType.Activity1_2Fight then
		if not arg_16_0._dailyEpisodeItems then
			arg_16_0._dailyEpisodeItems = {}
		end

		local var_16_2 = gohelper.findChild(var_16_0, "effect1/root")
		local var_16_3

		if var_16_1.type == DungeonEnum.ElementType.DailyEpisode then
			local var_16_4 = arg_16_0:openSubView(VersionActivity_1_2_MapElementItem, var_16_2, nil, arg_16_1)

			table.insert(arg_16_0._dailyEpisodeItems, var_16_4)
		else
			local var_16_5 = arg_16_0:openSubView(VersionActivity_1_2_MapElement105Item, var_16_2, nil, arg_16_1)

			table.insert(arg_16_0._dailyEpisodeItems, 1, var_16_5)
		end

		arg_16_0:_showDailyBtn()
	elseif var_16_1.type == DungeonEnum.ElementType.Activity1_2Building_Trap then
		arg_16_0:_showTrapObj()
	elseif var_16_1.type == DungeonEnum.ElementType.Activity1_2Building_Upgrade then
		arg_16_0:_onReceiveUpgradeElementReply(arg_16_1)
	end

	if arg_16_1 == 12101021 then
		arg_16_0:_showFocusBtn()
	end

	local var_16_6, var_16_7, var_16_8 = transformhelper.getLocalPos(var_16_0.transform)

	transformhelper.setLocalPos(var_16_0.transform, var_16_6, var_16_7, -20)
end

function var_0_0._onReceivePutTrapReply(arg_17_0)
	arg_17_0:_showTrapObj()
end

function var_0_0._onReceiveUpgradeElementReply(arg_18_0, arg_18_1)
	local var_18_0 = VersionActivity1_2DungeonModel.instance:haveNextLevel(arg_18_1)

	arg_18_0:_setElementShowState(arg_18_1, var_18_0 and 1 or 2)
end

function var_0_0._reBuildElement(arg_19_0, arg_19_1)
	arg_19_0.viewContainer.mapSceneElement:_removeElement(arg_19_1)
	arg_19_0.viewContainer.mapSceneElement:_addElementById(arg_19_1)
end

function var_0_0._selectEpisodeItem(arg_20_0, arg_20_1)
	arg_20_0._curSelectconfig = arg_20_1
end

function var_0_0._onRemoveTrapAniDone(arg_21_0)
	if arg_21_0._curTrap then
		gohelper.destroy(arg_21_0._curTrap)

		arg_21_0._curTrap = nil
	end
end

function var_0_0._showTrapObj(arg_22_0)
	local var_22_0 = VersionActivity1_2DungeonModel.instance:getTrapPutting()

	if arg_22_0._curTrap then
		if not var_22_0 then
			gohelper.onceAddComponent(arg_22_0._curTrap, typeof(UnityEngine.Animator)):Play("close")
			TaskDispatcher.runDelay(arg_22_0._onRemoveTrapAniDone, arg_22_0, 1)

			arg_22_0._lastTrapId = nil
		else
			TaskDispatcher.cancelTask(arg_22_0._onRemoveTrapAniDone, arg_22_0)
			gohelper.destroy(arg_22_0._curTrap)

			arg_22_0._curTrap = nil
		end
	end

	if var_22_0 then
		if var_22_0 == 10301 then
			local var_22_1 = "scenes/m_s14_hddt_hd02/prefab/hddt_front_xianjing_b.prefab"

			arg_22_0:com_loadAsset(var_22_1, arg_22_0._onTrapLoaded)
		elseif var_22_0 == 10302 then
			local var_22_2 = "scenes/m_s14_hddt_hd02/prefab/hddt_front_xianjing_c.prefab"

			arg_22_0:com_loadAsset(var_22_2, arg_22_0._onTrapLoaded)
		elseif var_22_0 == 10303 then
			local var_22_3 = "scenes/m_s14_hddt_hd02/prefab/hddt_front_xianjing_a.prefab"

			arg_22_0:com_loadAsset(var_22_3, arg_22_0._onTrapLoaded)
		end
	end

	if gohelper.findChild(arg_22_0._sceneGo, "elementRoot/" .. 12101051) then
		arg_22_0:_setElementShowState(12101051, var_22_0 and 2 or 1)
	end
end

function var_0_0._setElementShowState(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = gohelper.findChild(arg_23_0._sceneGo, "elementRoot/" .. arg_23_1)

	if not gohelper.isNil(var_23_0) then
		local var_23_1 = gohelper.findChild(var_23_0, "effect1")
		local var_23_2 = gohelper.findChild(var_23_0, "effect2")

		if not gohelper.isNil(var_23_0) and not gohelper.isNil(var_23_0) then
			if arg_23_2 == 1 then
				if not gohelper.isNil(var_23_1) then
					transformhelper.setLocalPos(var_23_1.transform, 0, 0, 0)
				end

				if not gohelper.isNil(var_23_2) then
					transformhelper.setLocalPos(var_23_2.transform, 40000, 0, 0)
				end
			else
				if not gohelper.isNil(var_23_1) then
					transformhelper.setLocalPos(var_23_1.transform, 40000, 0, 0)
				end

				if not gohelper.isNil(var_23_2) then
					transformhelper.setLocalPos(var_23_2.transform, 0, 0, 0)
				end
			end

			local var_23_3 = lua_chapter_map_element.configDict[arg_23_1]

			if var_23_3 and var_23_3.type == DungeonEnum.ElementType.Activity1_2Building_Upgrade then
				local var_23_4 = VersionActivity1_2DungeonModel.instance:getElementData(arg_23_1)

				arg_23_0:_setUpgradeBuildingData(var_23_4, var_23_1)
				arg_23_0:_setUpgradeBuildingData(var_23_4, var_23_2)
			end
		end
	end
end

function var_0_0._setUpgradeBuildingData(arg_24_0, arg_24_1, arg_24_2)
	for iter_24_0 = 1, 2 do
		local var_24_0 = gohelper.findChild(arg_24_2, string.format("root/ani/icon%d/anim/txt_lv", iter_24_0))

		if var_24_0 then
			local var_24_1 = var_24_0:GetComponent(typeof(TMPro.TextMeshPro))

			if arg_24_1 then
				var_24_1.text = "Lv. " .. arg_24_1.level

				if not VersionActivity1_2DungeonModel.instance:haveNextLevel(arg_24_1.elementId) then
					var_24_1.text = "Lv. Max"
				end
			else
				var_24_1.text = "Lv. 0"
			end
		end
	end
end

function var_0_0._onTrapLoaded(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1:GetResource()
	local var_25_1 = gohelper.findChild(arg_25_0._sceneGo, "elementRoot")
	local var_25_2 = gohelper.clone(var_25_0, var_25_1)
	local var_25_3 = VersionActivity1_2DungeonModel.instance:getTrapPutting()
	local var_25_4 = lua_activity116_building.configDict[var_25_3]
	local var_25_5 = gohelper.findChild(arg_25_0._sceneGo, "elementRoot/" .. var_25_4.elementId)

	if var_25_5 then
		local var_25_6, var_25_7, var_25_8 = transformhelper.getLocalPos(var_25_5.transform)

		transformhelper.setLocalPos(var_25_2.transform, var_25_6, var_25_7 - 1, -40)
	end

	arg_25_0._curTrap = var_25_2

	if arg_25_0._lastTrapId ~= var_25_3 then
		gohelper.onceAddComponent(var_25_2, typeof(UnityEngine.Animator)):Play("open")
	else
		gohelper.onceAddComponent(var_25_2, typeof(UnityEngine.Animator)):Play("idle")
	end

	arg_25_0._lastTrapId = var_25_3
end

function var_0_0._loadSceneFinish(arg_26_0)
	arg_26_0:_closeAllDailyEpisode()
	var_0_0.super._loadSceneFinish(arg_26_0)
	arg_26_0:showBridge()
	arg_26_0:_showElementLightBg()
	arg_26_0:_showTentState()
	arg_26_0:_showTower()
	arg_26_0:_hideCar()
	arg_26_0:_showFocusBtnState()
end

function var_0_0._showTower(arg_27_0)
	if not arg_27_0._curSelectconfig then
		return
	end

	local var_27_0 = arg_27_0._curSelectconfig.id == 1210113 or arg_27_0._curSelectconfig.id == 1210114
	local var_27_1 = gohelper.findChild(arg_27_0._sceneGo, "Obj-Plant/all/diffuse/s08_hddt_hd_Obj_p")
	local var_27_2 = gohelper.findChild(arg_27_0._sceneGo, "Obj-Plant/all/diffuse/s08_hddt_hd_zhedang_dt")

	gohelper.setActive(var_27_1, var_27_0)
	gohelper.setActive(var_27_2, var_27_0)
end

function var_0_0._hideCar(arg_28_0)
	if not arg_28_0._curSelectconfig then
		return
	end

	if arg_28_0._curSelectconfig.id == 1210106 then
		local var_28_0 = gohelper.findChild(arg_28_0._sceneGo, "Obj-Plant/all/diffuse/s08_hddt_hd_Obj_u")
		local var_28_1 = gohelper.findChild(arg_28_0._sceneGo, "Obj-Plant/all/diffuse/s08_hddt_hd_Obj_k")
		local var_28_2 = DungeonModel.instance:hasPassLevelAndStory(1210106)

		gohelper.setActive(var_28_0, var_28_2)
		gohelper.setActive(var_28_1, not var_28_2)
	end
end

function var_0_0._showTentState(arg_29_0)
	local var_29_0 = gohelper.findChild(arg_29_0._sceneGo, "Obj-Plant/all/diffuse/s08_hddt_hd_Obj_t")

	gohelper.setActive(var_29_0, not DungeonMapModel.instance:elementIsFinished(12101101))
end

function var_0_0._showElementLightBg(arg_30_0)
	arg_30_0._lightBgDic = arg_30_0:getUserDataTb_()

	local var_30_0 = {}

	table.insert(var_30_0, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_gaoliang_a.prefab")
	table.insert(var_30_0, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_gaoliang_b.prefab")
	table.insert(var_30_0, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_gaoliang_c.prefab")
	table.insert(var_30_0, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_gaoliang_d.prefab")
	table.insert(var_30_0, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_gaoliang_e.prefab")
	table.insert(var_30_0, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_gaoliang_f.prefab")
	table.insert(var_30_0, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_gaoliang_g.prefab")
	arg_30_0:com_loadListAsset(var_30_0, arg_30_0._onLightBgLoaded, arg_30_0._onLightBgLoadFinish)
end

function var_0_0._onLightBgLoaded(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_1:GetResource()
	local var_31_1 = gohelper.findChild(arg_31_0._sceneGo, "elementRoot")
	local var_31_2 = gohelper.clone(var_31_0, var_31_1)

	gohelper.setActive(var_31_2, false)
	transformhelper.setLocalPos(var_31_2.transform, 0, 0, -4)

	arg_31_0._lightBgDic[arg_31_1.ResPath] = var_31_2
end

function var_0_0._onLightBgLoadFinish(arg_32_0)
	arg_32_0:_addMapLight()
end

function var_0_0._detectElementNeedSetPos(arg_33_0, arg_33_1)
	local var_33_0 = VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(arg_33_1)

	if var_33_0 then
		for iter_33_0, iter_33_1 in pairs(var_33_0) do
			if not string.nilorempty(iter_33_1.lightBgUrl) and arg_33_0._lightBgDic[iter_33_1.lightBgUrl] then
				local var_33_1 = string.splitToNumber(iter_33_1.filterEpisode, "#")

				for iter_33_2, iter_33_3 in ipairs(var_33_1) do
					if iter_33_3 == arg_33_0._curSelectconfig.id then
						return
					end
				end

				gohelper.setActive(arg_33_0._lightBgDic[iter_33_1.lightBgUrl], true)

				local var_33_2 = gohelper.findChild(arg_33_0._sceneGo, "elementRoot/" .. arg_33_1)

				if var_33_2 then
					local var_33_3, var_33_4, var_33_5 = transformhelper.getLocalPos(var_33_2.transform)

					transformhelper.setLocalPos(var_33_2.transform, var_33_3, var_33_4, -20)
				end

				return
			end
		end
	end
end

function var_0_0._closeAllDailyEpisode(arg_34_0)
	if arg_34_0._dailyEpisodeItems then
		for iter_34_0, iter_34_1 in ipairs(arg_34_0._dailyEpisodeItems) do
			arg_34_0:destroySubView(iter_34_1)
		end

		arg_34_0._dailyEpisodeItems = {}
	end
end

function var_0_0.showBridge(arg_35_0)
	local var_35_0 = gohelper.findChild(arg_35_0._sceneGo, "Obj-Plant/all/diffuse/s08_hddt_hd_Obj_o")

	gohelper.setActive(var_35_0, DungeonMapModel.instance:elementIsFinished(12101011))

	local var_35_1 = gohelper.findChild(arg_35_0._sceneGo, "Obj-Plant/all/diffuse/s08_hddt_hd_Obj_f")

	gohelper.setActive(var_35_1, true)
end

function var_0_0._OnRemoveElement(arg_36_0, arg_36_1)
	if arg_36_1 == 12101011 then
		arg_36_0:showBridge()
	end

	if arg_36_0._dailyEpisodeItems then
		for iter_36_0, iter_36_1 in ipairs(arg_36_0._dailyEpisodeItems) do
			local var_36_0 = iter_36_1._elementConfig

			if var_36_0.type == DungeonEnum.ElementType.Activity1_2Fight and var_36_0.id == arg_36_1 then
				local var_36_1 = table.remove(arg_36_0._dailyEpisodeItems, iter_36_0)

				break
			end
		end
	end

	arg_36_0:_showDailyBtn()
end

function var_0_0.getInteractiveItem(arg_37_0)
	return arg_37_0.viewContainer.mapView:openMapInteractiveItem()
end

function var_0_0.createInteractiveItem(arg_38_0)
	arg_38_0._uiGo = gohelper.clone(arg_38_0._itemPrefab, arg_38_0._sceneCanvasGo)
	arg_38_0._interactiveItem = MonoHelper.addLuaComOnceToGo(arg_38_0._uiGo, DungeonMapInteractiveItem)

	arg_38_0._interactiveItem:setBtnClosePosZ(-5)
	gohelper.setActive(arg_38_0._uiGo, false)
end

function var_0_0.buildLoadRes(arg_39_0, arg_39_1, arg_39_2)
	table.insert(arg_39_1, "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab")
	table.insert(arg_39_1, "ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem.prefab")

	local var_39_0 = ResUrl.getDungeonMapRes(arg_39_2.res)

	table.insert(arg_39_1, var_39_0)
	table.insert(arg_39_1, "scenes/m_s14_hddt_hd02/scene_prefab/activity1_2dungeon_map_audio.prefab")
	table.insert(arg_39_1, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	table.insert(arg_39_1, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_fog.prefab")
end

function var_0_0._onClickBtn4(arg_40_0)
	if arg_40_0._focusing then
		GameFacade.showToast(ToastEnum.Activity1_2FocusBtnClick)

		return
	end

	arg_40_0._focusing = true

	gohelper.setActive(arg_40_0._focusBtnStateOn, true)
	gohelper.setActive(arg_40_0._focusBtnStateOff, false)
	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.focusMap, Vector3(-85, 25, 0))
end

function var_0_0.onClose(arg_41_0)
	arg_41_0._btn4:RemoveClickListener()
	TaskDispatcher.cancelTask(arg_41_0._onRemoveTrapAniDone, arg_41_0)
	var_0_0.super.onClose(arg_41_0)
end

return var_0_0
