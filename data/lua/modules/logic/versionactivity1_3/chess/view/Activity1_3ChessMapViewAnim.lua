module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessMapViewAnim", package.seeall)

slot0 = class("Activity1_3ChessMapViewAnim", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.ShowPassEpisodeEffect, slot0.playPathAnim, slot0)
	slot0:addEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.SetNodePathEffectToPassNode, slot0.refreshPathToPassNode, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._path1Mterials = slot0:_findUIMeshMaterIals("Map/Path1/path_go")
	slot0._path2Mterials = slot0:_findUIMeshMaterIals("Map/Path2/path_go")
	slot0._pathMaterialDict = {
		slot0._path1Mterials,
		slot0._path2Mterials
	}

	slot0:_initPathAnimParams()
end

function slot0._findUIMeshMaterIals(slot0, slot1)
	slot4 = slot0:getUserDataTb_()

	RoomHelper.cArrayToLuaTable(gohelper.findChild(slot0.viewGO, slot1):GetComponentsInChildren(typeof(UIMesh), true), slot4)

	slot5 = slot0:getUserDataTb_()

	for slot9, slot10 in ipairs(slot4) do
		if slot10.material then
			slot5[#slot5 + 1] = slot11
		end
	end

	return slot5
end

slot1 = {
	{
		{
			1,
			0.89
		},
		{
			0.89,
			0.78
		},
		{
			0.78,
			0.54
		},
		{
			0.54,
			0.27
		},
		{
			0.27,
			0
		}
	},
	{
		{
			1,
			0.89
		},
		{
			0.89,
			0.74
		},
		{
			0.74,
			0.52
		},
		{
			0.52,
			0.24
		},
		{
			0.24,
			0
		}
	}
}

function slot0._initPathAnimParams(slot0)
	slot0._pathConsDict = {}
	slot1 = Va3ChessEnum.ActivityId.Act122
	slot2 = Activity122Config.instance

	for slot6, slot7 in pairs(uv0) do
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

function slot0.onOpen(slot0)
	if not slot0._pathToPassNode then
		slot0:refreshPathToOpenNode()
	end
end

function slot0.onSetVisible(slot0, slot1)
	if slot1 then
		-- Nothing
	end
end

function slot0.onDestroyView(slot0)
	if slot0._pathTweenId then
		ZProj.TweenHelper.KillById(slot0._pathTweenId)

		slot0._pathTweenId = nil
	end
end

function slot0.refreshPathToOpenNode(slot0)
	for slot4, slot5 in pairs(slot0._pathMaterialDict) do
		slot6, slot7 = slot0:_getPathPatams(slot4)

		if slot6 and slot7 > 0 then
			slot0:_setPathMaterialsValue(slot5, slot6[2])
		else
			slot0:_setPathMaterialsValue(slot5, 1)
		end
	end
end

function slot0.refreshPathToPassNode(slot0)
	slot0._pathToPassNode = true

	for slot4, slot5 in pairs(slot0._pathMaterialDict) do
		slot6, slot7 = slot0:_getPathPatams(slot4)

		if slot6 and slot7 > 0 then
			slot0:_setPathMaterialsValue(slot5, slot6[1])
		else
			slot0:_setPathMaterialsValue(slot5, 1)
		end
	end
end

function slot0.playPathAnim(slot0)
	slot0._pathToPassNode = false

	if Activity122Config.instance:getEpisodeCo(Va3ChessEnum.ActivityId.Act122, Activity122Model.instance:getCurEpisodeId()) then
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
	slot0._pathTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 2, slot0._onPathFrame, slot0._onPathFinish, slot0, nil, EaseType.Linear)
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

	for slot7, slot8 in ipairs(slot1) do
		slot8:SetVector("_DissolveControl", Vector4.New(slot2, 0.01, 0, slot7))
	end
end

function slot0._getPathPatams(slot0, slot1)
	slot3 = 0
	slot4 = nil

	if slot0._pathConsDict[slot1] then
		for slot8, slot9 in ipairs(slot2) do
			if slot9.isEpisode and Activity122Model.instance:isEpisodeOpen(slot9.episodeCfg.id) or not slot9.isEpisode and Activity1_3ChessController.instance:isChapterOpen(slot9.episodeCfg.chapterId) then
				slot3 = slot8
				slot4 = slot9
			end
		end
	end

	if slot4 then
		return slot4.pathParams, slot3
	end

	return nil, slot3
end

return slot0
