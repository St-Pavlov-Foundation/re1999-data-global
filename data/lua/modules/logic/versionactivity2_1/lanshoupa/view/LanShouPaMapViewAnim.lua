module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaMapViewAnim", package.seeall)

slot0 = class("LanShouPaMapViewAnim", BaseView)

function slot0.onInitView(slot0)
	slot0._goexcessive = gohelper.findChild(slot0.viewGO, "#go_excessive")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._checkTaskMO = Activity164TaskMO.New()
	slot0._viewAnimator = slot0.viewGO:GetComponent(LanShouPaEnum.ComponentType.Animator)
	slot0._rewardAnimator = slot0:_findAnimator("RightTop/ani")
	slot0._swicthSceneAnimator = slot0:_findAnimator("#go_excessive")
	slot0._path1Mterials = slot0:_findUIMeshMaterIals("Map/Path1/path_go1")
	slot0._path2Mterials = slot0:_findUIMeshMaterIals("Map/Path2/path_go1")
	slot0._pathMaterialDict = {
		[LanShouPaEnum.Chapter.One] = slot0._path1Mterials,
		[LanShouPaEnum.Chapter.Two] = slot0._path2Mterials
	}
	slot0._propertyBlock = UnityEngine.MaterialPropertyBlock.New()

	slot0:_initPathAnimParams()
end

function slot0._findAnimator(slot0, slot1)
	return gohelper.findChild(slot0.viewGO, slot1):GetComponent(LanShouPaEnum.ComponentType.Animator)
end

function slot0._findUIMeshMaterIals(slot0, slot1)
	slot4 = slot0:getUserDataTb_()

	RoomHelper.cArrayToLuaTable(gohelper.findChild(slot0.viewGO, slot1):GetComponentsInChildren(LanShouPaEnum.ComponentType.UIMesh, true), slot4)

	slot5 = slot0:getUserDataTb_()

	for slot9, slot10 in ipairs(slot4) do
		if slot10.material then
			table.insert(slot5, slot11)
		end
	end

	return slot5
end

function slot0.onOpen(slot0)
	slot0:addEventCb(LanShouPaController.instance, LanShouPaEvent.SelectEpisode, slot0._onSelectEpisode, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0._refreshRewardAnim, slot0)
	slot0:_refreshUI()
	slot0:refreshPathPoin()
	slot0._viewAnimator:Play(UIAnimationName.Open)
end

function slot0._onSelectEpisode(slot0)
	slot0:_refreshRewardAnim()
end

function slot0._refreshUI(slot0)
	slot0:_refreshRewardAnim()
end

function slot0._refreshRewardAnim(slot0)
	if slot0._lastIsHasReward ~= slot0:_isHasReward() then
		slot0._lastIsHasReward = slot1

		slot0._rewardAnimator:Play(slot1 and "loop" or "idle")
	end
end

function slot0.onClose(slot0)
end

function slot0.playViewAnimator(slot0, slot1)
	slot0._viewAnimator:Play(slot1, 0, 0)
end

function slot0.onDestroyView(slot0)
	if slot0._pathTweenId then
		ZProj.TweenHelper.KillById(slot0._pathTweenId)

		slot0._pathTweenId = nil
	end
end

function slot0._isHasReward(slot0)
	if TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity164) ~= nil then
		slot3 = slot0._checkTaskMO

		for slot7, slot8 in ipairs(Activity164Config.instance:getTaskByActId(ChessGameEnum.ActivityId.Act164)) do
			slot3:init(slot8, slot1[slot8.id])

			if slot3:alreadyGotReward() then
				return true
			end
		end
	end

	return false
end

slot0.SWIRCH_SCENE_BLOCK_KEY = "LanShouPaMapViewAnim_switchScene_Key"

function slot0.switchScene(slot0, slot1)
	if slot0._isLastSwitchStart ~= (slot1 == true) then
		slot0._isLastSwitchStart = slot2

		gohelper.setActive(slot0._goexcessive, true)
		slot0._swicthSceneAnimator:Play(slot2 and "story" or "hard")

		if not slot0._isSwitchSceneStartBlock then
			slot0._isSwitchSceneStartBlock = true

			UIBlockMgr.instance:startBlock(uv0.SWIRCH_SCENE_BLOCK_KEY)
		else
			TaskDispatcher.cancelTask(slot0._onHideSwitchScene, slot0)
		end

		TaskDispatcher.runDelay(slot0._onHideSwitchScene, slot0, 1)
	end
end

function slot0._onHideSwitchScene(slot0)
	slot0._isSwitchSceneStartBlock = false

	UIBlockMgr.instance:endBlock(uv0.SWIRCH_SCENE_BLOCK_KEY)
end

function slot0._initPathAnimParams(slot0)
	slot0._pathConsDict = {}
	slot1 = ChessGameEnum.ActivityId.Act164
	slot2 = Activity164Config.instance

	for slot6, slot7 in pairs(LanShouPaEnum.ChapterPathAnimParam) do
		if slot2:getChapterEpisodeList(slot1, slot6) then
			slot10 = slot2:getChapterEpisodeList(slot1, slot6 + 1)
			slot0._pathConsDict[slot6] = {}

			if slot2:getChapterEpisodeList(slot1, slot6 - 1) and #slot9 > 0 then
				slot0:_addPathAnimParams(slot11, slot7, slot9[#slot9], false)
			end

			for slot15, slot16 in ipairs(slot8) do
				slot0:_addPathAnimParams(slot11, slot7, slot16, true)
			end

			if slot10 and #slot10 > 0 then
				slot0:_addPathAnimParams(slot11, slot7, slot10[1], false)
			end
		end
	end
end

function slot0._addPathAnimParams(slot0, slot1, slot2, slot3, slot4)
	if #slot1 + 1 <= #slot2 then
		table.insert(slot1, {
			pathParams = slot2[slot5],
			isEpisode = slot4,
			episodeCfg = slot3
		})
	end
end

function slot0._getPathPatams(slot0, slot1)
	slot3 = 0
	slot4 = nil

	if slot0._pathConsDict[slot1] then
		slot5 = Activity164Model.instance

		for slot9, slot10 in ipairs(slot2) do
			if slot5:isEpisodeClear(slot10.episodeCfg.id) or slot10.episodeCfg.preEpisode == 0 or slot5:isEpisodeClear(slot10.episodeCfg.preEpisode) and LanShouPaHelper.isOpenChapterDay(slot10.episodeCfg.chapterId) then
				slot3 = slot9
				slot4 = slot10
			end
		end
	end

	if slot4 then
		return slot4.pathParams, slot3
	end

	return nil, slot3
end

function slot0.refreshPathPoin(slot0)
	for slot4, slot5 in pairs(slot0._pathMaterialDict) do
		slot6, slot7 = slot0:_getPathPatams(slot4)

		if slot6 and slot7 > 0 then
			slot0:_setPathMaterialsValue(slot5, slot6[2])
		else
			slot0:_setPathMaterialsValue(slot5, 1)
		end
	end
end

function slot0.playPathAnim(slot0)
	if Activity164Config.instance:getEpisodeCo(ChessGameEnum.ActivityId.Act164, Activity164Model.instance:getCurEpisodeId()) then
		slot4, slot5 = slot0:_getPathPatams(slot3.chapterId)

		if slot4 and slot5 > 0 then
			slot0:_playPathAnim(slot0._pathMaterialDict[slot3.chapterId], slot4)
		end
	end
end

function slot0._playPathAnim(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return
	end

	if slot0._tweenMaterials and slot0._tweenParams then
		slot0:_onPathFinish()
	end

	if slot0._pathTweenId then
		ZProj.TweenHelper.KillById(slot0._pathTweenId)

		slot0._pathTweenId = nil
	end

	slot0._tweenMaterials = slot1
	slot0._tweenParams = slot2
	slot0._pathTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, LanShouPaEnum.AnimatorTime.ChapterPath or 1, slot0._onPathFrame, slot0._onPathFinish, slot0, nil, EaseType.Linear)
end

function slot0._onPathFrame(slot0, slot1)
	slot0:_setPathMaterialsValue(slot0._tweenMaterials, slot0._tweenParams[1] + (slot0._tweenParams[2] - slot0._tweenParams[1]) * slot1)
end

function slot0._onPathFinish(slot0)
	slot0._tweenMaterials = nil
	slot0._tweenParams = nil

	slot0:_setPathMaterialsValue(slot0._tweenMaterials, slot0._tweenParams[2])
end

function slot0._setPathMaterialsValue(slot0, slot1, slot2)
	slot7 = 0
	slot8 = 0

	for slot7, slot8 in ipairs(slot1) do
		slot8:SetVector("_DissolveControl", Vector4.New(slot2, 0.01, slot7, slot8))
	end
end

return slot0
