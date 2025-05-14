module("modules.logic.weekwalk.view.WeekWalkRewardItem", package.seeall)

local var_0_0 = class("WeekWalkRewardItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_bg")
	arg_1_0._txttaskdes = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_taskdes")
	arg_1_0._imageprogress = gohelper.findChildImage(arg_1_0.viewGO, "#go_normal/progressbar/#image_progress")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_rewards")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_rewards/#go_rewarditem")
	arg_1_0._gonotget = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_notget")
	arg_1_0._btnnotfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#go_notget/#btn_notfinishbg")
	arg_1_0._btnfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#go_notget/#btn_finishbg")
	arg_1_0._goblackmask = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_blackmask")
	arg_1_0._goget = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_get")
	arg_1_0._gogetall = gohelper.findChild(arg_1_0.viewGO, "#go_getall")
	arg_1_0._simagegetallbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_getall/#simage_getallbg")
	arg_1_0._btncollectall = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_getall/go_getall/#btn_collectall")
	arg_1_0._gofullprogress = gohelper.findChild(arg_1_0.viewGO, "#go_normal/progressbar/#go_fullprogress")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_index")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnotfinishbg:AddClickListener(arg_2_0._btnnotfinishbgOnClick, arg_2_0)
	arg_2_0._btnfinishbg:AddClickListener(arg_2_0._btnfinishbgOnClick, arg_2_0)
	arg_2_0._btncollectall:AddClickListener(arg_2_0._btncollectallOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnotfinishbg:RemoveClickListener()
	arg_3_0._btnfinishbg:RemoveClickListener()
	arg_3_0._btncollectall:RemoveClickListener()
end

function var_0_0._btncollectallOnClick(arg_4_0)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnGetTaskReward, arg_4_0)
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.WeekWalk, arg_4_0._mo.minTypeId)
end

function var_0_0._btnnotfinishbgOnClick(arg_5_0)
	local var_5_0 = string.split(arg_5_0._mo.listenerParam, "#")[1]

	WeekWalkController.instance:openWeekWalkLayerView({
		mapId = tonumber(var_5_0)
	})
end

function var_0_0._btnfinishbgOnClick(arg_6_0)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnGetTaskReward, arg_6_0)
	TaskRpc.instance:sendFinishTaskRequest(arg_6_0._mo.id)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._rewardItems = arg_7_0:getUserDataTb_()
	arg_7_0._canvasgroup = arg_7_0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_7_0._animator = SLFramework.AnimatorPlayer.Get(arg_7_0.viewGO)

	arg_7_0:_getGraphicMats()
	gohelper.setActive(arg_7_0.viewGO, false)
	arg_7_0._simagegetallbg:LoadImage(ResUrl.getWeekWalkBg("btn_yijiandi.png"))
end

function var_0_0._editableAddEvents(arg_8_0)
	gohelper.addUIClickAudio(arg_8_0._btnnotfinishbg.gameObject, AudioEnum.UI.play_ui_activity_jump)
	gohelper.addUIClickAudio(arg_8_0._btnfinishbg.gameObject, AudioEnum.WeekWalk.play_artificial_ui_taskreceive)
	gohelper.addUIClickAudio(arg_8_0._btncollectall.gameObject, AudioEnum.WeekWalk.play_artificial_ui_taskreceive)
end

function var_0_0._editableRemoveEvents(arg_9_0)
	return
end

function var_0_0._playAnim(arg_10_0)
	if arg_10_0._firstPlayAnim then
		return
	end

	arg_10_0._firstPlayAnim = true

	local var_10_0 = WeekWalkTaskListModel.instance.openRewardTime

	if Time.time - var_10_0 >= 0.5 then
		gohelper.setActive(arg_10_0.viewGO, true)

		return
	end

	local var_10_1 = (arg_10_0._index - 1) * 0.07

	TaskDispatcher.runDelay(arg_10_0._delayPlayAnim, arg_10_0, var_10_1)
end

function var_0_0._delayPlayAnim(arg_11_0)
	arg_11_0:_playAnimName(UIAnimationName.Open)
end

function var_0_0._playAnimName(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	gohelper.setActive(arg_12_0.viewGO, true)

	if arg_12_0.viewGO.activeInHierarchy then
		arg_12_0._animator:Play(arg_12_1, arg_12_0._playAnimDone, arg_12_0)
	end
end

function var_0_0._playAnimDone(arg_13_0)
	return
end

function var_0_0.playOutAnim(arg_14_0)
	gohelper.setActive(arg_14_0._goblackmask, true)
	arg_14_0:_playAnimName("out")
end

function var_0_0.onUpdateMO(arg_15_0, arg_15_1)
	arg_15_0._canvasgroup.alpha = arg_15_1.isDirtyData and 0 or 1
	arg_15_0._canvasgroup.interactable = not arg_15_1.isDirtyData
	arg_15_0._canvasgroup.blocksRaycasts = not arg_15_1.isDirtyData
	arg_15_0._canGet = false

	if arg_15_1.isDirtyData then
		return
	end

	arg_15_0._mo = arg_15_1

	gohelper.setActive(arg_15_0._gonormal, not arg_15_1.isGetAll)
	gohelper.setActive(arg_15_0._gogetall, arg_15_1.isGetAll)

	if arg_15_1.isGetAll then
		arg_15_0._canGet = true

		arg_15_0:_playAnim()

		return
	end

	arg_15_0._config = lua_task_weekwalk.configDict[arg_15_1.id]

	local var_15_0 = tonumber(arg_15_1.layerId)

	if var_15_0 and var_15_0 > 0 then
		local var_15_1 = WeekWalkModel.instance:getMapInfo(var_15_0)
		local var_15_2 = lua_weekwalk.configDict[var_15_0]
		local var_15_3 = var_15_1 and var_15_1.sceneId or var_15_2.sceneId
		local var_15_4 = lua_weekwalk_scene.configDict[var_15_3]
		local var_15_5 = string.format(arg_15_1.desc, var_15_4.battleName)

		arg_15_0._txttaskdes.text = var_15_5
	else
		arg_15_0._txttaskdes.text = arg_15_1.desc
	end

	arg_15_0._txtindex.text = string.format("%02d", arg_15_0._mo.id - 71000)

	arg_15_0:_addRewards()
	arg_15_0:_updateStatus()
	arg_15_0:_setMaterialAndOpenEdgFade()
	arg_15_0:_playAnim()
end

local var_0_1

function var_0_0._getGraphicMats(arg_16_0)
	local var_16_0 = ViewMgr.instance:getContainer(ViewName.WeekWalkRewardView)
	local var_16_1 = var_16_0:getSetting().otherRes[2]
	local var_16_2 = var_16_0._abLoader:getAssetItem(var_16_1):GetResource()

	var_0_1 = var_0_1 or arg_16_0:getUserDataTb_()
	var_0_1.imgMat = var_16_2

	arg_16_0:_setMaterialAndOpenEdgFade()
end

local var_0_2 = UnityEngine.Shader.PropertyToID("_BottomGradualCtrl")
local var_0_3 = Color.New(7.6, -3.44, 0, 0)

function var_0_0._setMaterialAndOpenEdgFade(arg_17_0)
	local var_17_0 = arg_17_0.viewGO:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic), true):GetEnumerator()
	local var_17_1

	while var_17_0:MoveNext() do
		local var_17_2 = var_17_0.Current

		if var_17_2:GetComponent(gohelper.Type_TextMesh) then
			local var_17_3 = var_17_2.font.name .. "_edgefade"
			local var_17_4 = var_0_1[var_17_3]

			if not var_17_4 then
				var_17_4 = UnityEngine.GameObject.Instantiate(var_17_2.fontSharedMaterial)
				var_17_4.name = var_17_3

				var_17_4:SetColor(var_0_2, var_0_3)

				var_0_1[var_17_3] = var_17_4
			end

			var_17_2.fontSharedMaterial = var_17_4
		else
			var_17_2.material = var_0_1 and var_0_1.imgMat
		end
	end

	for iter_17_0, iter_17_1 in pairs(var_0_1) do
		iter_17_1:EnableKeyword("_BOTTOM_GRADUAL")
	end
end

function var_0_0._updateStatus(arg_18_0)
	arg_18_0._taskMo = WeekWalkTaskListModel.instance:getTaskMo(arg_18_0._mo.id)

	if not arg_18_0._taskMo then
		return
	end

	arg_18_0._imageprogress.fillAmount = arg_18_0._taskMo.progress / arg_18_0._config.maxProgress

	gohelper.setActive(arg_18_0._gofullprogress, arg_18_0._taskMo.progress >= arg_18_0._config.maxProgress)

	local var_18_0 = arg_18_0._taskMo.finishCount >= arg_18_0._config.maxFinishCount

	gohelper.setActive(arg_18_0._gonotget, not var_18_0)
	gohelper.setActive(arg_18_0._goget, var_18_0)
	gohelper.setActive(arg_18_0._goblackmask, var_18_0)

	if not var_18_0 then
		local var_18_1 = arg_18_0._taskMo.hasFinished

		gohelper.setActive(arg_18_0._btnnotfinishbg.gameObject, not var_18_1)
		gohelper.setActive(arg_18_0._btnfinishbg.gameObject, var_18_1)

		arg_18_0._canGet = var_18_1
	end

	local var_18_2 = not var_18_0 and arg_18_0._taskMo.hasFinished and "img_bg_claim_hl.png" or "img_bg_claim_nor.png"

	arg_18_0._simagebg:LoadImage(ResUrl.getWeekWalkBg(var_18_2))
end

function var_0_0._addRewards(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0._rewardItems) do
		gohelper.destroy(iter_19_1.itemIcon.go)
		gohelper.destroy(iter_19_1.parentGo)
		iter_19_1.itemIcon:onDestroy()
	end

	arg_19_0._rewardItems = arg_19_0:getUserDataTb_()

	local var_19_0 = string.split(arg_19_0._mo.bonus, "|")

	for iter_19_2 = 1, #var_19_0 do
		local var_19_1 = {
			parentGo = gohelper.cloneInPlace(arg_19_0._gorewarditem)
		}

		gohelper.setActive(var_19_1.parentGo, true)

		local var_19_2 = string.splitToNumber(var_19_0[iter_19_2], "#")

		var_19_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(var_19_1.parentGo)

		var_19_1.itemIcon:setMOValue(var_19_2[1], var_19_2[2], var_19_2[3], nil, true)
		var_19_1.itemIcon:isShowCount(var_19_2[1] ~= MaterialEnum.MaterialType.Hero)
		var_19_1.itemIcon:setCountFontSize(40)
		var_19_1.itemIcon:showStackableNum2()
		var_19_1.itemIcon:setHideLvAndBreakFlag(true)
		var_19_1.itemIcon:hideEquipLvAndBreak(true)
		table.insert(arg_19_0._rewardItems, var_19_1)
	end

	if not arg_19_0.viewGO.activeInHierarchy then
		gohelper.setActive(arg_19_0.viewGO, true)
		gohelper.setActive(arg_19_0.viewGO, false)
	end
end

function var_0_0.onSelect(arg_20_0, arg_20_1)
	return
end

function var_0_0.onDestroyView(arg_21_0)
	for iter_21_0, iter_21_1 in pairs(arg_21_0._rewardItems) do
		gohelper.destroy(iter_21_1.itemIcon.go)
		gohelper.destroy(iter_21_1.parentGo)
		iter_21_1.itemIcon:onDestroy()
	end

	arg_21_0._rewardItems = nil

	arg_21_0._simagebg:UnLoadImage()
	arg_21_0._simagegetallbg:UnLoadImage()

	if arg_21_0._matLoader then
		arg_21_0._matLoader:dispose()

		arg_21_0._matLoader = nil
	end

	if var_0_1 then
		for iter_21_2, iter_21_3 in pairs(var_0_1) do
			iter_21_3:DisableKeyword("_BOTTOM_GRADUAL")

			if iter_21_2 ~= "imgMat" then
				gohelper.destroy(iter_21_3)
			end

			var_0_1[iter_21_2] = nil
		end

		var_0_1 = nil
	end

	TaskDispatcher.cancelTask(arg_21_0._delayPlayAnim, arg_21_0)
end

return var_0_0
