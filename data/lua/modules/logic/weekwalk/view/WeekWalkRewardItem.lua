module("modules.logic.weekwalk.view.WeekWalkRewardItem", package.seeall)

slot0 = class("WeekWalkRewardItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_normal/#simage_bg")
	slot0._txttaskdes = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_taskdes")
	slot0._imageprogress = gohelper.findChildImage(slot0.viewGO, "#go_normal/progressbar/#image_progress")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "#go_normal/#go_rewards")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "#go_normal/#go_rewards/#go_rewarditem")
	slot0._gonotget = gohelper.findChild(slot0.viewGO, "#go_normal/#go_notget")
	slot0._btnnotfinishbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#go_notget/#btn_notfinishbg")
	slot0._btnfinishbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#go_notget/#btn_finishbg")
	slot0._goblackmask = gohelper.findChild(slot0.viewGO, "#go_normal/#go_blackmask")
	slot0._goget = gohelper.findChild(slot0.viewGO, "#go_normal/#go_get")
	slot0._gogetall = gohelper.findChild(slot0.viewGO, "#go_getall")
	slot0._simagegetallbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_getall/#simage_getallbg")
	slot0._btncollectall = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_getall/go_getall/#btn_collectall")
	slot0._gofullprogress = gohelper.findChild(slot0.viewGO, "#go_normal/progressbar/#go_fullprogress")
	slot0._txtindex = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_index")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnotfinishbg:AddClickListener(slot0._btnnotfinishbgOnClick, slot0)
	slot0._btnfinishbg:AddClickListener(slot0._btnfinishbgOnClick, slot0)
	slot0._btncollectall:AddClickListener(slot0._btncollectallOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnotfinishbg:RemoveClickListener()
	slot0._btnfinishbg:RemoveClickListener()
	slot0._btncollectall:RemoveClickListener()
end

function slot0._btncollectallOnClick(slot0)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnGetTaskReward, slot0)
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.WeekWalk, slot0._mo.minTypeId)
end

function slot0._btnnotfinishbgOnClick(slot0)
	WeekWalkController.instance:openWeekWalkLayerView({
		mapId = tonumber(string.split(slot0._mo.listenerParam, "#")[1])
	})
end

function slot0._btnfinishbgOnClick(slot0)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnGetTaskReward, slot0)
	TaskRpc.instance:sendFinishTaskRequest(slot0._mo.id)
end

function slot0._editableInitView(slot0)
	slot0._rewardItems = slot0:getUserDataTb_()
	slot0._canvasgroup = slot0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._animator = SLFramework.AnimatorPlayer.Get(slot0.viewGO)

	slot0:_getGraphicMats()
	gohelper.setActive(slot0.viewGO, false)
	slot0._simagegetallbg:LoadImage(ResUrl.getWeekWalkBg("btn_yijiandi.png"))
end

function slot0._editableAddEvents(slot0)
	gohelper.addUIClickAudio(slot0._btnnotfinishbg.gameObject, AudioEnum.UI.play_ui_activity_jump)
	gohelper.addUIClickAudio(slot0._btnfinishbg.gameObject, AudioEnum.WeekWalk.play_artificial_ui_taskreceive)
	gohelper.addUIClickAudio(slot0._btncollectall.gameObject, AudioEnum.WeekWalk.play_artificial_ui_taskreceive)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0._playAnim(slot0)
	if slot0._firstPlayAnim then
		return
	end

	slot0._firstPlayAnim = true

	if Time.time - WeekWalkTaskListModel.instance.openRewardTime >= 0.5 then
		gohelper.setActive(slot0.viewGO, true)

		return
	end

	TaskDispatcher.runDelay(slot0._delayPlayAnim, slot0, (slot0._index - 1) * 0.07)
end

function slot0._delayPlayAnim(slot0)
	slot0:_playAnimName(UIAnimationName.Open)
end

function slot0._playAnimName(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot0.viewGO, true)

	if slot0.viewGO.activeInHierarchy then
		slot0._animator:Play(slot1, slot0._playAnimDone, slot0)
	end
end

function slot0._playAnimDone(slot0)
end

function slot0.playOutAnim(slot0)
	gohelper.setActive(slot0._goblackmask, true)
	slot0:_playAnimName("out")
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._canvasgroup.alpha = slot1.isDirtyData and 0 or 1
	slot0._canvasgroup.interactable = not slot1.isDirtyData
	slot0._canvasgroup.blocksRaycasts = not slot1.isDirtyData
	slot0._canGet = false

	if slot1.isDirtyData then
		return
	end

	slot0._mo = slot1

	gohelper.setActive(slot0._gonormal, not slot1.isGetAll)
	gohelper.setActive(slot0._gogetall, slot1.isGetAll)

	if slot1.isGetAll then
		slot0._canGet = true

		slot0:_playAnim()

		return
	end

	slot0._config = lua_task_weekwalk.configDict[slot1.id]

	if tonumber(slot1.layerId) and slot2 > 0 then
		slot0._txttaskdes.text = string.format(slot1.desc, lua_weekwalk_scene.configDict[WeekWalkModel.instance:getMapInfo(slot2) and slot3.sceneId or lua_weekwalk.configDict[slot2].sceneId].battleName)
	else
		slot0._txttaskdes.text = slot1.desc
	end

	slot0._txtindex.text = string.format("%02d", slot0._mo.id - 71000)

	slot0:_addRewards()
	slot0:_updateStatus()
	slot0:_setMaterialAndOpenEdgFade()
	slot0:_playAnim()
end

slot1 = nil

function slot0._getGraphicMats(slot0)
	slot1 = ViewMgr.instance:getContainer(ViewName.WeekWalkRewardView)
	uv0 = uv0 or slot0:getUserDataTb_()
	uv0.imgMat = slot1._abLoader:getAssetItem(slot1:getSetting().otherRes[2]):GetResource()

	slot0:_setMaterialAndOpenEdgFade()
end

slot2 = UnityEngine.Shader.PropertyToID("_BottomGradualCtrl")
slot3 = Color.New(7.6, -3.44, 0, 0)

function slot0._setMaterialAndOpenEdgFade(slot0)
	slot2 = slot0.viewGO:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic), true):GetEnumerator()
	slot3 = nil

	while slot2:MoveNext() do
		if slot2.Current:GetComponent(gohelper.Type_TextMesh) then
			if not uv0[slot4.font.name .. "_edgefade"] then
				slot3 = UnityEngine.GameObject.Instantiate(slot4.fontSharedMaterial)
				slot3.name = slot5

				slot3:SetColor(uv1, uv2)

				uv0[slot5] = slot3
			end

			slot4.fontSharedMaterial = slot3
		else
			slot4.material = uv0 and uv0.imgMat
		end
	end

	for slot7, slot8 in pairs(uv0) do
		slot8:EnableKeyword("_BOTTOM_GRADUAL")
	end
end

function slot0._updateStatus(slot0)
	slot0._taskMo = WeekWalkTaskListModel.instance:getTaskMo(slot0._mo.id)

	if not slot0._taskMo then
		return
	end

	slot0._imageprogress.fillAmount = slot0._taskMo.progress / slot0._config.maxProgress

	gohelper.setActive(slot0._gofullprogress, slot0._config.maxProgress <= slot0._taskMo.progress)

	slot1 = slot0._config.maxFinishCount <= slot0._taskMo.finishCount

	gohelper.setActive(slot0._gonotget, not slot1)
	gohelper.setActive(slot0._goget, slot1)
	gohelper.setActive(slot0._goblackmask, slot1)

	if not slot1 then
		slot2 = slot0._taskMo.hasFinished

		gohelper.setActive(slot0._btnnotfinishbg.gameObject, not slot2)
		gohelper.setActive(slot0._btnfinishbg.gameObject, slot2)

		slot0._canGet = slot2
	end

	slot0._simagebg:LoadImage(ResUrl.getWeekWalkBg(not slot1 and slot0._taskMo.hasFinished and "img_bg_claim_hl.png" or "img_bg_claim_nor.png"))
end

function slot0._addRewards(slot0)
	for slot4, slot5 in pairs(slot0._rewardItems) do
		gohelper.destroy(slot5.itemIcon.go)
		gohelper.destroy(slot5.parentGo)
		slot5.itemIcon:onDestroy()
	end

	slot0._rewardItems = slot0:getUserDataTb_()

	for slot5 = 1, #string.split(slot0._mo.bonus, "|") do
		slot6 = {
			parentGo = gohelper.cloneInPlace(slot0._gorewarditem)
		}

		gohelper.setActive(slot6.parentGo, true)

		slot7 = string.splitToNumber(slot1[slot5], "#")
		slot6.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot6.parentGo)

		slot6.itemIcon:setMOValue(slot7[1], slot7[2], slot7[3], nil, true)
		slot6.itemIcon:isShowCount(slot7[1] ~= MaterialEnum.MaterialType.Hero)
		slot6.itemIcon:setCountFontSize(40)
		slot6.itemIcon:showStackableNum2()
		slot6.itemIcon:setHideLvAndBreakFlag(true)
		slot6.itemIcon:hideEquipLvAndBreak(true)
		table.insert(slot0._rewardItems, slot6)
	end

	if not slot0.viewGO.activeInHierarchy then
		gohelper.setActive(slot0.viewGO, true)
		gohelper.setActive(slot0.viewGO, false)
	end
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._rewardItems) do
		gohelper.destroy(slot5.itemIcon.go)
		gohelper.destroy(slot5.parentGo)
		slot5.itemIcon:onDestroy()
	end

	slot0._rewardItems = nil

	slot0._simagebg:UnLoadImage()
	slot0._simagegetallbg:UnLoadImage()

	if slot0._matLoader then
		slot0._matLoader:dispose()

		slot0._matLoader = nil
	end

	if uv0 then
		for slot4, slot5 in pairs(uv0) do
			slot5:DisableKeyword("_BOTTOM_GRADUAL")

			if slot4 ~= "imgMat" then
				gohelper.destroy(slot5)
			end

			uv0[slot4] = nil
		end

		uv0 = nil
	end

	TaskDispatcher.cancelTask(slot0._delayPlayAnim, slot0)
end

return slot0
