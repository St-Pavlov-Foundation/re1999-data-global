module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonMapScene", package.seeall)

slot0 = class("VersionActivity1_2DungeonMapScene", VersionActivity1_2DungeonMapBaseScene)

function slot0.onInitView(slot0)
	slot0._gotaskitem = gohelper.findChildClickWithAudio(slot0.viewGO, "#go_tasklist/#go_taskitem", AudioEnum.UI.play_ui_main_shield)
	slot0._focusBtnStateOff = gohelper.findChild(slot0.viewGO, "#btn_4/icon/#go_off")
	slot0._focusBtnStateOn = gohelper.findChild(slot0.viewGO, "#btn_4/icon/#go_on")
	slot0._btn4 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_4")

	uv0.super.onInitView(slot0)
end

function slot0.onOpen(slot0)
	slot0._btn4:AddClickListener(slot0._onClickBtn4, slot0)
	slot0:addClickCb(slot0._gotaskitem, slot0._onClickDaily, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveGet116InfosReply, slot0._onReceiveGet116InfosReply, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.addElementItem, slot0._onAddElementItem, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceivePutTrapReply, slot0._onReceivePutTrapReply, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveUpgradeElementReply, slot0._onReceiveUpgradeElementReply, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.focusMap, slot0._onFocusMap, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.selectEpisodeItem, slot0._selectEpisodeItem, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.clickDailyEpisode, slot0._clickDailyEpisode, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, slot0._OnRemoveElement, slot0)
	uv0.super.onOpen(slot0)
	slot0:_showDailyBtn()
	slot0:_showFocusBtn()
end

function slot0._onReceiveGet116InfosReply(slot0)
	if slot0.viewContainer.mapSceneElement and slot1._elementList then
		for slot6, slot7 in pairs(slot2) do
			if slot7._config and slot8.type == DungeonEnum.ElementType.Activity1_2Building_Upgrade then
				slot0:_onReceiveUpgradeElementReply(slot8.id)
			end
		end
	end
end

function slot0._clickDailyEpisode(slot0, slot1)
	if slot0._dailyEpisodeItems then
		for slot5, slot6 in ipairs(slot0._dailyEpisodeItems) do
			if slot6.viewGO.activeInHierarchy and slot6._elementConfig.type == DungeonEnum.ElementType.DailyEpisode and slot1 == slot6._elementConfig.id then
				slot6:_onClick()

				break
			end
		end
	end
end

function slot0.reopenViewParamPrecessed(slot0)
	if slot0.viewParam.focusCamp then
		slot0:_onClickBtn4()
	end
end

function slot0.getFocusBtnUnlockAniState()
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2FocusBtnUnlockAni, 0)
end

function slot0.setFocusBtnUnlockAniState(slot0)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2FocusBtnUnlockAni, slot0 or 1)
end

function slot0._showFocusBtn(slot0)
	slot1 = DungeonMapModel.instance:getElementById(12101021)

	gohelper.setActive(slot0._btn4.gameObject, slot1)

	if slot1 and uv0.getFocusBtnUnlockAniState() == 0 then
		uv0.setFocusBtnUnlockAniState(1)
		gohelper.onceAddComponent(slot0._btn4.gameObject, typeof(UnityEngine.Animator)):Play("unlock")
	end
end

function slot0._showFocusBtnState(slot0)
	if slot0._sceneGo then
		slot1, slot2 = transformhelper.getLocalPos(slot0._sceneGo.transform)
		slot3 = true

		if math.abs(-88 - slot1) >= 10 or math.abs(24 - slot2) >= 7 then
			slot3 = false
		end

		gohelper.setActive(slot0._focusBtnStateOn, slot3)
		gohelper.setActive(slot0._focusBtnStateOff, not slot3)

		slot0._focusing = slot3
	end
end

function slot0._onLoadSceneFinish(slot0)
	MainCameraMgr.instance:addView(ViewName.VersionActivity1_2DungeonView, slot0._initCamera, nil, slot0)
end

function slot0._onFocusMap(slot0, slot1)
	slot0:setScenePosSafety(slot1, true)
end

function slot0._disposeScene(slot0)
	slot0:_closeAllDailyEpisode()
	uv0.super._disposeScene(slot0)
end

function slot0._showDailyBtn(slot0)
	slot0._curDailyItem = nil
	slot1 = false

	if slot0._dailyEpisodeItems then
		slot5 = uv0.sortDailyEpisode

		table.sort(slot0._dailyEpisodeItems, slot5)

		for slot5, slot6 in ipairs(slot0._dailyEpisodeItems) do
			if slot6.viewGO.activeInHierarchy then
				slot1 = true
				gohelper.findChildText(slot0._gotaskitem.gameObject, "bg/info").text = formatLuaLang("versionactivity_1_2_daily_episode_btn", slot6._episodeConfig.name)
				slot8 = gohelper.findChildImage(slot0._gotaskitem.gameObject, "bg/icon")
				slot9 = nil

				if slot6._elementConfig.type == DungeonEnum.ElementType.DailyEpisode then
					slot9 = "zhuxianditu_renwuicon_1020"

					if TimeUtil.getDayFirstLoginRed("act1_2DailySpEpisode" .. slot6._elementConfig.id) then
						TimeUtil.setDayFirstLoginRed("act1_2DailySpEpisode" .. slot6._elementConfig.id)

						slot10 = string.splitToNumber(slot6._elementConfig.pos, "#")

						VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.focusMap, Vector3(-slot10[1], -slot10[2] - 3, 0))
					end
				else
					slot9 = "zhuxianditu_renwuicon_20"
				end

				UISpriteSetMgr.instance:setUiFBSprite(slot8, slot9)

				slot0._curDailyItem = slot6

				break
			end
		end
	end

	gohelper.setActive(slot0._gotaskitem.gameObject, slot1)
end

function slot0.sortDailyEpisode(slot0, slot1)
	if slot0._elementConfig.type == DungeonEnum.ElementType.Activity1_2Fight and slot1._elementConfig.type == DungeonEnum.ElementType.Activity1_2Fight then
		return slot0._elementConfig.id < slot1._elementConfig.id
	elseif slot2 == DungeonEnum.ElementType.Activity1_2Fight and slot3 == DungeonEnum.ElementType.DailyEpisode then
		return true
	elseif slot2 == DungeonEnum.ElementType.DailyEpisode and slot3 == DungeonEnum.ElementType.Activity1_2Fight then
		return false
	else
		return lua_activity116_episode_sp.configDict[slot0._episodeConfig.id].refreshDay < lua_activity116_episode_sp.configDict[slot1._episodeConfig.id].refreshDay
	end
end

function slot0._onClickDaily(slot0)
	if slot0._curDailyItem then
		slot0._curDailyItem:_onClick()
	end
end

function slot0._onAddElementItem(slot0, slot1)
	slot2 = gohelper.findChild(slot0._sceneGo, "elementRoot/" .. slot1)

	slot0:_detectElementNeedSetPos(slot1)

	if lua_chapter_map_element.configDict[slot1].type == DungeonEnum.ElementType.DailyEpisode or slot3.type == DungeonEnum.ElementType.Activity1_2Fight then
		if not slot0._dailyEpisodeItems then
			slot0._dailyEpisodeItems = {}
		end

		slot5 = nil

		if slot3.type == DungeonEnum.ElementType.DailyEpisode then
			table.insert(slot0._dailyEpisodeItems, slot0:openSubView(VersionActivity_1_2_MapElementItem, gohelper.findChild(slot2, "effect1/root"), nil, slot1))
		else
			table.insert(slot0._dailyEpisodeItems, 1, slot0:openSubView(VersionActivity_1_2_MapElement105Item, slot4, nil, slot1))
		end

		slot0:_showDailyBtn()
	elseif slot3.type == DungeonEnum.ElementType.Activity1_2Building_Trap then
		slot0:_showTrapObj()
	elseif slot3.type == DungeonEnum.ElementType.Activity1_2Building_Upgrade then
		slot0:_onReceiveUpgradeElementReply(slot1)
	end

	if slot1 == 12101021 then
		slot0:_showFocusBtn()
	end

	slot4, slot5, slot6 = transformhelper.getLocalPos(slot2.transform)

	transformhelper.setLocalPos(slot2.transform, slot4, slot5, -20)
end

function slot0._onReceivePutTrapReply(slot0)
	slot0:_showTrapObj()
end

function slot0._onReceiveUpgradeElementReply(slot0, slot1)
	slot0:_setElementShowState(slot1, VersionActivity1_2DungeonModel.instance:haveNextLevel(slot1) and 1 or 2)
end

function slot0._reBuildElement(slot0, slot1)
	slot0.viewContainer.mapSceneElement:_removeElement(slot1)
	slot0.viewContainer.mapSceneElement:_addElementById(slot1)
end

function slot0._selectEpisodeItem(slot0, slot1)
	slot0._curSelectconfig = slot1
end

function slot0._onRemoveTrapAniDone(slot0)
	if slot0._curTrap then
		gohelper.destroy(slot0._curTrap)

		slot0._curTrap = nil
	end
end

function slot0._showTrapObj(slot0)
	if slot0._curTrap then
		if not VersionActivity1_2DungeonModel.instance:getTrapPutting() then
			gohelper.onceAddComponent(slot0._curTrap, typeof(UnityEngine.Animator)):Play("close")
			TaskDispatcher.runDelay(slot0._onRemoveTrapAniDone, slot0, 1)

			slot0._lastTrapId = nil
		else
			TaskDispatcher.cancelTask(slot0._onRemoveTrapAniDone, slot0)
			gohelper.destroy(slot0._curTrap)

			slot0._curTrap = nil
		end
	end

	if slot1 then
		if slot1 == 10301 then
			slot0:com_loadAsset("scenes/m_s14_hddt_hd02/prefab/hddt_front_xianjing_b.prefab", slot0._onTrapLoaded)
		elseif slot1 == 10302 then
			slot0:com_loadAsset("scenes/m_s14_hddt_hd02/prefab/hddt_front_xianjing_c.prefab", slot0._onTrapLoaded)
		elseif slot1 == 10303 then
			slot0:com_loadAsset("scenes/m_s14_hddt_hd02/prefab/hddt_front_xianjing_a.prefab", slot0._onTrapLoaded)
		end
	end

	if gohelper.findChild(slot0._sceneGo, "elementRoot/" .. 12101051) then
		slot0:_setElementShowState(12101051, slot1 and 2 or 1)
	end
end

function slot0._setElementShowState(slot0, slot1, slot2)
	if not gohelper.isNil(gohelper.findChild(slot0._sceneGo, "elementRoot/" .. slot1)) then
		slot4 = gohelper.findChild(slot3, "effect1")
		slot5 = gohelper.findChild(slot3, "effect2")

		if not gohelper.isNil(slot3) and not gohelper.isNil(slot3) then
			if slot2 == 1 then
				if not gohelper.isNil(slot4) then
					transformhelper.setLocalPos(slot4.transform, 0, 0, 0)
				end

				if not gohelper.isNil(slot5) then
					transformhelper.setLocalPos(slot5.transform, 40000, 0, 0)
				end
			else
				if not gohelper.isNil(slot4) then
					transformhelper.setLocalPos(slot4.transform, 40000, 0, 0)
				end

				if not gohelper.isNil(slot5) then
					transformhelper.setLocalPos(slot5.transform, 0, 0, 0)
				end
			end

			if lua_chapter_map_element.configDict[slot1] and slot6.type == DungeonEnum.ElementType.Activity1_2Building_Upgrade then
				slot7 = VersionActivity1_2DungeonModel.instance:getElementData(slot1)

				slot0:_setUpgradeBuildingData(slot7, slot4)
				slot0:_setUpgradeBuildingData(slot7, slot5)
			end
		end
	end
end

function slot0._setUpgradeBuildingData(slot0, slot1, slot2)
	for slot6 = 1, 2 do
		if gohelper.findChild(slot2, string.format("root/ani/icon%d/anim/txt_lv", slot6)) then
			slot8 = slot7:GetComponent(typeof(TMPro.TextMeshPro))

			if slot1 then
				slot8.text = "Lv. " .. slot1.level

				if not VersionActivity1_2DungeonModel.instance:haveNextLevel(slot1.elementId) then
					slot8.text = "Lv. Max"
				end
			else
				slot8.text = "Lv. 0"
			end
		end
	end
end

function slot0._onTrapLoaded(slot0, slot1)
	slot4 = gohelper.clone(slot1:GetResource(), gohelper.findChild(slot0._sceneGo, "elementRoot"))

	if gohelper.findChild(slot0._sceneGo, "elementRoot/" .. lua_activity116_building.configDict[VersionActivity1_2DungeonModel.instance:getTrapPutting()].elementId) then
		slot8, slot9, slot10 = transformhelper.getLocalPos(slot7.transform)

		transformhelper.setLocalPos(slot4.transform, slot8, slot9 - 1, -40)
	end

	slot0._curTrap = slot4

	if slot0._lastTrapId ~= slot5 then
		gohelper.onceAddComponent(slot4, typeof(UnityEngine.Animator)):Play("open")
	else
		gohelper.onceAddComponent(slot4, typeof(UnityEngine.Animator)):Play("idle")
	end

	slot0._lastTrapId = slot5
end

function slot0._loadSceneFinish(slot0)
	slot0:_closeAllDailyEpisode()
	uv0.super._loadSceneFinish(slot0)
	slot0:showBridge()
	slot0:_showElementLightBg()
	slot0:_showTentState()
	slot0:_showTower()
	slot0:_hideCar()
	slot0:_showFocusBtnState()
end

function slot0._showTower(slot0)
	if not slot0._curSelectconfig then
		return
	end

	slot1 = slot0._curSelectconfig.id == 1210113 or slot0._curSelectconfig.id == 1210114

	gohelper.setActive(gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/diffuse/s08_hddt_hd_Obj_p"), slot1)
	gohelper.setActive(gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/diffuse/s08_hddt_hd_zhedang_dt"), slot1)
end

function slot0._hideCar(slot0)
	if not slot0._curSelectconfig then
		return
	end

	if slot0._curSelectconfig.id == 1210106 then
		slot3 = DungeonModel.instance:hasPassLevelAndStory(1210106)

		gohelper.setActive(gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/diffuse/s08_hddt_hd_Obj_u"), slot3)
		gohelper.setActive(gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/diffuse/s08_hddt_hd_Obj_k"), not slot3)
	end
end

function slot0._showTentState(slot0)
	gohelper.setActive(gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/diffuse/s08_hddt_hd_Obj_t"), not DungeonMapModel.instance:elementIsFinished(12101101))
end

function slot0._showElementLightBg(slot0)
	slot0._lightBgDic = slot0:getUserDataTb_()
	slot1 = {}

	table.insert(slot1, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_gaoliang_a.prefab")
	table.insert(slot1, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_gaoliang_b.prefab")
	table.insert(slot1, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_gaoliang_c.prefab")
	table.insert(slot1, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_gaoliang_d.prefab")
	table.insert(slot1, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_gaoliang_e.prefab")
	table.insert(slot1, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_gaoliang_f.prefab")
	table.insert(slot1, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_gaoliang_g.prefab")
	slot0:com_loadListAsset(slot1, slot0._onLightBgLoaded, slot0._onLightBgLoadFinish)
end

function slot0._onLightBgLoaded(slot0, slot1)
	slot4 = gohelper.clone(slot1:GetResource(), gohelper.findChild(slot0._sceneGo, "elementRoot"))

	gohelper.setActive(slot4, false)
	transformhelper.setLocalPos(slot4.transform, 0, 0, -4)

	slot0._lightBgDic[slot1.ResPath] = slot4
end

function slot0._onLightBgLoadFinish(slot0)
	slot0:_addMapLight()
end

function slot0._detectElementNeedSetPos(slot0, slot1)
	if VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(slot1) then
		for slot6, slot7 in pairs(slot2) do
			if not string.nilorempty(slot7.lightBgUrl) and slot0._lightBgDic[slot7.lightBgUrl] then
				for slot12, slot13 in ipairs(string.splitToNumber(slot7.filterEpisode, "#")) do
					if slot13 == slot0._curSelectconfig.id then
						return
					end
				end

				gohelper.setActive(slot0._lightBgDic[slot7.lightBgUrl], true)

				if gohelper.findChild(slot0._sceneGo, "elementRoot/" .. slot1) then
					slot10, slot11, slot12 = transformhelper.getLocalPos(slot9.transform)

					transformhelper.setLocalPos(slot9.transform, slot10, slot11, -20)
				end

				return
			end
		end
	end
end

function slot0._closeAllDailyEpisode(slot0)
	if slot0._dailyEpisodeItems then
		for slot4, slot5 in ipairs(slot0._dailyEpisodeItems) do
			slot0:destroySubView(slot5)
		end

		slot0._dailyEpisodeItems = {}
	end
end

function slot0.showBridge(slot0)
	gohelper.setActive(gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/diffuse/s08_hddt_hd_Obj_o"), DungeonMapModel.instance:elementIsFinished(12101011))
	gohelper.setActive(gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/diffuse/s08_hddt_hd_Obj_f"), true)
end

function slot0._OnRemoveElement(slot0, slot1)
	if slot1 == 12101011 then
		slot0:showBridge()
	end

	if slot0._dailyEpisodeItems then
		for slot5, slot6 in ipairs(slot0._dailyEpisodeItems) do
			if slot6._elementConfig.type == DungeonEnum.ElementType.Activity1_2Fight and slot7.id == slot1 then
				slot8 = table.remove(slot0._dailyEpisodeItems, slot5)

				break
			end
		end
	end

	slot0:_showDailyBtn()
end

function slot0.getInteractiveItem(slot0)
	return slot0.viewContainer.mapView:openMapInteractiveItem()
end

function slot0.createInteractiveItem(slot0)
	slot0._uiGo = gohelper.clone(slot0._itemPrefab, slot0._sceneCanvasGo)
	slot0._interactiveItem = MonoHelper.addLuaComOnceToGo(slot0._uiGo, DungeonMapInteractiveItem)

	slot0._interactiveItem:setBtnClosePosZ(-5)
	gohelper.setActive(slot0._uiGo, false)
end

function slot0.buildLoadRes(slot0, slot1, slot2)
	table.insert(slot1, "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab")
	table.insert(slot1, "ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem.prefab")
	table.insert(slot1, ResUrl.getDungeonMapRes(slot2.res))
	table.insert(slot1, "scenes/m_s14_hddt_hd02/scene_prefab/activity1_2dungeon_map_audio.prefab")
	table.insert(slot1, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	table.insert(slot1, "scenes/m_s14_hddt_hd02/prefab/s08_hddt_hd_fog.prefab")
end

function slot0._onClickBtn4(slot0)
	if slot0._focusing then
		GameFacade.showToast(ToastEnum.Activity1_2FocusBtnClick)

		return
	end

	slot0._focusing = true

	gohelper.setActive(slot0._focusBtnStateOn, true)
	gohelper.setActive(slot0._focusBtnStateOff, false)
	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.focusMap, Vector3(-85, 25, 0))
end

function slot0.onClose(slot0)
	slot0._btn4:RemoveClickListener()
	TaskDispatcher.cancelTask(slot0._onRemoveTrapAniDone, slot0)
	uv0.super.onClose(slot0)
end

return slot0
