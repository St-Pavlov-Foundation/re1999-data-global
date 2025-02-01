module("modules.logic.weekwalk.view.WeekWalkLayerPageItem", package.seeall)

slot0 = class("WeekWalkLayerPageItem", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._txtbattlename = gohelper.findChildText(slot0.viewGO, "info/#txt_battlename")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "info/#txt_battlename/#btn_detail")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "info/#txt_name")
	slot0._txtindex = gohelper.findChildText(slot0.viewGO, "info/#txt_index")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "info/#txt_index/#txt_nameen")
	slot0._txtprogress = gohelper.findChildText(slot0.viewGO, "info/#txt_progress")
	slot0._gounlock = gohelper.findChild(slot0.viewGO, "#go_unlock")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_unlock/#btn_click")
	slot0._simagemapicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_unlock/#btn_click/#simage_mapicon")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_unlock/#btn_click/#simage_icon")
	slot0._golock = gohelper.findChild(slot0.viewGO, "#go_lock")
	slot0._btnlock = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_lock/#btn_lock")
	slot0._simagelockicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_lock/#btn_lock/#simage_lockicon")
	slot0._gomapfinish = gohelper.findChild(slot0.viewGO, "#go_mapfinish")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reward")
	slot0._gorewardIcon = gohelper.findChild(slot0.viewGO, "#btn_reward/#go_rewardIcon")
	slot0._gonormalIcon = gohelper.findChild(slot0.viewGO, "#btn_reward/#go_normalIcon")
	slot0._gorewardfinish = gohelper.findChild(slot0.viewGO, "#btn_reward/#go_rewardfinish")
	slot0._goline = gohelper.findChildImage(slot0.viewGO, "#go_mapfinish/clearancegraphics_01_mask/clearancegraphics_01")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btnlock:AddClickListener(slot0._btnlockOnClick, slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btndetail:RemoveClickListener()
	slot0._btnclick:RemoveClickListener()
	slot0._btnlock:RemoveClickListener()
	slot0._btnreward:RemoveClickListener()
end

function slot0._btnlockOnClick(slot0)
	if not WeekWalkModel.isShallowLayer(slot0._config.layer) and not WeekWalkModel.instance:getInfo().isOpenDeep then
		GameFacade.showToast(ToastEnum.WeekWalkIsShallowLayer)

		return
	end

	if slot0._config.preId > 0 and WeekWalkModel.instance:getMapInfo(slot2) and not slot3:getNoStarBattleInfo() then
		GameFacade.showToast(ToastEnum.WeekWalkNotFinishStory)

		return
	end

	GameFacade.showToast(ToastEnum.WeekWalkLayerPage)
end

function slot0._btnrewardOnClick(slot0)
	WeekWalkController.instance:openWeekWalkLayerRewardView({
		mapId = slot0._config.id
	})
end

function slot0._btndetailOnClick(slot0)
	EnemyInfoController.instance:openWeekWalkEnemyInfoView(slot0._config.id)
end

function slot0._btnclickOnClick(slot0)
	WeekWalkController.instance:openWeekWalkView({
		mapId = slot0._config.id
	})
end

function slot0.ctor(slot0, slot1)
	slot0._config = slot1[1]
	slot0._pageIndex = slot1[2]
	slot0._layerPage = slot1[3]
end

function slot0._editableInitView(slot0)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if WeekWalkModel.isShallowLayer(slot0._config.layer) then
		slot0._simageicon:LoadImage(ResUrl.getWeekWalkLayerIcon("shallow"))
		slot0._simagelockicon:LoadImage(ResUrl.getWeekWalkLayerIcon("shallow_unknown"))
	else
		slot0._simageicon:LoadImage(ResUrl.getWeekWalkLayerIcon("deep"))
		slot0._simagelockicon:LoadImage(ResUrl.getWeekWalkLayerIcon("deep_unknown"))
	end

	gohelper.setActive(slot0._btndetail.gameObject, false)
	gohelper.addUIClickAudio(slot0._btndetail.gameObject, AudioEnum.UI.play_ui_action_explore)
	gohelper.addUIClickAudio(slot0._btnclick.gameObject, AudioEnum.WeekWalk.play_artificial_ui_mapopen)
	gohelper.addUIClickAudio(slot0._btnreward.gameObject, AudioEnum.WeekWalk.play_artificial_ui_rewardpoints)
	WeekWalkController.instance:registerCallback(WeekWalkEvent.OnScrollPage, slot0._setEdgFadeStrengthen, slot0)

	slot0._goline.material = UnityEngine.GameObject.Instantiate(slot0._goline.material)

	slot0._goline.material:EnableKeyword("_EDGE_GRADUAL")
	slot0._goline.material:SetFloat(ShaderPropertyId.Scroll_LeftRamp, 1)
	slot0:openEdgFadeEffect()
end

function slot0._setEdgFadeStrengthen(slot0, slot1, slot2)
	if slot0._pageIndex ~= slot2 then
		return
	end

	for slot6, slot7 in pairs(slot0._graphics) do
		if slot7.gameObject:GetComponent(gohelper.Type_TextMesh) then
			slot7.fontMaterial:SetFloat(ShaderPropertyId.Scroll_LeftRamp, slot1)
		else
			slot7.material:SetFloat(ShaderPropertyId.Scroll_LeftRamp, slot1)
		end
	end
end

function slot0._playAnim(slot0, slot1)
	slot0._animator.enabled = true

	slot0._animator:Play(slot1)
end

function slot0.onOpen(slot0)
	slot0:_updateStatus()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0, LuaEventSystem.Low)
	WeekWalkController.instance:registerCallback(WeekWalkEvent.OnGetInfo, slot0._onGetInfo, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, slot0._onWeekwalkTaskUpdate, slot0)
end

slot1 = {}

function slot0.openEdgFadeEffect(slot0)
	slot0._graphics = slot0._graphics or slot0:getUserDataTb_()
	slot2 = slot0.viewGO:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic), true):GetEnumerator()
	slot3 = nil

	while slot2:MoveNext() do
		if slot2.Current:GetComponent(gohelper.Type_TextMesh) then
			if not uv0[slot4.font.name .. "_edgefade"] then
				slot3 = UnityEngine.GameObject.Instantiate(slot4.fontSharedMaterial)
				slot3.name = slot5

				slot3:EnableKeyword("_EDGE_GRADUAL")

				uv0[slot5] = slot3
			end

			slot4.fontSharedMaterial = slot3
		elseif slot4.material.name == "edgfade" then
			if not uv0.imgMat then
				uv0.imgMat = UnityEngine.GameObject.Instantiate(slot4.material)
				uv0.imgMat.name = "img_edgefade"

				uv0.imgMat:EnableKeyword("_EDGE_GRADUAL")
			end

			slot4.material = uv0.imgMat
		end

		if slot4 ~= slot0._goline then
			table.insert(slot0._graphics, slot2.Current)
		end
	end
end

function slot0.onClose(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	WeekWalkController.instance:unregisterCallback(WeekWalkEvent.OnGetInfo, slot0._onGetInfo, slot0)
	slot0:removeEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, slot0._onWeekwalkTaskUpdate, slot0)
	WeekWalkController.instance:unregisterCallback(WeekWalkEvent.OnScrollPage, slot0._setEdgFadeStrengthen, slot0)
end

function slot0._onWeekwalkTaskUpdate(slot0)
	if ViewMgr.instance:isOpen(ViewName.WeekWalkView) then
		return
	end

	slot0:_updateStatus()
end

function slot0._updateDeepConfig(slot0)
	if WeekWalkModel.isShallowLayer(slot0._config.layer) then
		return
	end

	for slot6, slot7 in ipairs(WeekWalkConfig.instance:getDeepLayer(WeekWalkModel.instance:getInfo().issueId)) do
		if slot7.layer == slot0._config.layer then
			slot0._config = slot7

			return
		end
	end
end

function slot0._onGetInfo(slot0)
	slot0:_updateDeepConfig()

	if not WeekWalkModel.isShallowLayer(slot0._config.layer) and WeekWalkModel.instance:getInfo().isOpenDeep and slot0._layerPage:getVisible() and not slot0._mapInfo and WeekWalkModel.instance:getMapInfo(slot0._config.id) then
		slot0._showUnlockAnim = true
	end

	slot0:_updateStatus()

	slot0._showUnlockAnim = nil
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.WeekWalkView then
		slot0:_updateStatus()
	end
end

function slot0._updateProgress(slot0)
	slot2 = 0
	slot3 = 0

	if TaskConfig.instance:getWeekWalkRewardList(slot0._config.layer) then
		for slot7, slot8 in pairs(slot1) do
			if lua_task_weekwalk.configDict[slot7] and WeekWalkTaskListModel.instance:checkPeriods(slot9) then
				slot3 = slot3 + slot8

				if WeekWalkTaskListModel.instance:getTaskMo(slot7) and lua_task_weekwalk.configDict[slot7].maxFinishCount <= slot10.finishCount then
					slot2 = slot2 + slot8
				end
			end
		end
	end

	slot0._txtprogress.text = string.format("%s/%s", slot2, slot3)
	slot0._txtprogress.alpha = slot3 <= slot2 and 0.45 or 1
end

function slot0.updateUnlockStatus(slot0)
	if not slot0._layerPage:getVisible() then
		return
	end

	if WeekWalkModel.instance:getFinishMapId() and slot1 < slot0._config.id then
		slot0:_updateStatus()
	end
end

function slot0._updateStatus(slot0)
	slot0._mapInfo = WeekWalkModel.instance:getMapInfo(slot0._config.id)
	slot0._txtname.text = lua_weekwalk_scene.configDict[slot0._mapInfo and slot0._mapInfo.sceneId or slot0._config.sceneId].name
	slot0._txtbattlename.text = slot0._mapInfo and slot1.battleName or luaLang("weekwalklayerpageitem_unknowdream")
	slot0._txtnameen.text = slot0._mapInfo and slot1.name_en or "Dream To Be Dreamed"
	slot0._txtindex.text = slot0._config.layer

	slot0._simagemapicon:LoadImage(ResUrl.getWeekWalkLayerIcon("img_" .. slot1.icon))
	slot0:_updateProgress()

	if not slot0._mapInfo then
		gohelper.setActive(slot0._gorewardIcon, false)
		gohelper.setActive(slot0._gorewardfinish, false)
		gohelper.setActive(slot0._gonormalIcon, true)
		gohelper.setActive(slot0._gomapfinish, false)
		gohelper.setActive(slot0._gounlock, slot0._mapInfo)
		gohelper.setActive(slot0._golock, not slot0._mapInfo)

		return
	end

	slot2 = WeekWalkModel.instance:getFinishMapId()

	if slot0._layerPage:getVisible() and slot2 and slot2 < slot0._config.id or slot0._showUnlockAnim then
		WeekWalkModel.instance:setFinishMapId(nil)
		slot0:_playAnim("weekwalklayerpageitem_unlock_in")
		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_unlockdream)
	else
		slot4 = slot0._mapInfo

		if not slot0._layerPage:getVisible() and slot2 and slot2 < slot0._config.id then
			slot4 = false
		end

		gohelper.setActive(slot0._gounlock, slot4)
		gohelper.setActive(slot0._golock, not slot4)
	end

	slot4 = slot0._config.id
	slot6, slot7 = WeekWalkTaskListModel.instance:canGetRewardNum(WeekWalkRewardView.getTaskType(slot4), slot4)
	slot8 = slot6 > 0

	gohelper.setActive(slot0._gorewardIcon, slot8)
	gohelper.setActive(slot0._gorewardfinish, not slot8 and slot7 <= 0)
	gohelper.setActive(slot0._gonormalIcon, not slot8 and slot7 > 0)
	gohelper.setActive(slot0._gomapfinish, slot0._mapInfo.isFinished > 0)
end

function slot0.onDestroyView(slot0)
end

function slot0.disableKeyword(slot0)
	if not slot0._graphics then
		return
	end

	for slot4, slot5 in pairs(slot0._graphics) do
		slot5.material:DisableKeyword("_EDGE_GRADUAL")
	end
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()
	slot0:addEvents()
	slot0:onOpen()
end

function slot0.onDestroy(slot0)
	slot0._simageicon:UnLoadImage()
	slot0._simagelockicon:UnLoadImage()
	slot0._simagemapicon:UnLoadImage()
	slot0:onClose()
	slot0:removeEvents()
	slot0:disableKeyword()
	slot0:onDestroyView()

	if uv0 then
		for slot4, slot5 in pairs(uv0) do
			gohelper.destroy(slot5)

			uv0[slot4] = nil
		end

		uv0 = {}
	end
end

return slot0
