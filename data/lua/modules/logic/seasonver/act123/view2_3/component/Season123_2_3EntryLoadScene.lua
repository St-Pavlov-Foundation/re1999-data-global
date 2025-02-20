module("modules.logic.seasonver.act123.view2_3.component.Season123_2_3EntryLoadScene", package.seeall)

slot0 = class("Season123_2_3EntryLoadScene", UserDataDispose)

function slot0.init(slot0)
	slot0:__onInit()

	slot0._prefabDict = {}
	slot0._containerDict = slot0:getUserDataTb_()
	slot0._retailPrefabDict = {}
	slot0._retailContainerDict = slot0:getUserDataTb_()
	slot0._retailPosXDict = {}
	slot0._retailPosYDict = {}
	slot0._animDict = slot0:getUserDataTb_()
end

function slot0.dispose(slot0)
	slot0:__onDispose()
	slot0:releaseRes()
end

function slot0.createSceneRoot(slot0)
	slot0._sceneRoot = UnityEngine.GameObject.New("Season123_2_3EntryScene")
	slot3, slot4, slot5 = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)

	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0, slot4, 0)

	slot0._sceneOffsetY = slot4

	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)

	return slot0._sceneRoot
end

function slot0.disposeSceneRoot(slot0)
	if slot0._sceneRoot then
		gohelper.destroy(slot0._sceneRoot)

		slot0._sceneRoot = nil
	end
end

slot0.BLOCK_LOAD_RES_KEY = "Season123_2_3EntrySceneLoadRes"

function slot0.loadRes(slot0, slot1, slot2)
	slot0._callback = slot1
	slot0._callbackObj = slot2

	UIBlockMgr.instance:startBlock(uv0.BLOCK_LOAD_RES_KEY)

	slot0._loader = MultiAbLoader.New()

	slot0._loader:addPath(slot0:getSceneBackgroundUrl())
	slot0._loader:startLoad(slot0.onLoadResCompleted, slot0)
end

function slot0.releaseRes(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	UIBlockMgr.instance:endBlock(uv0.BLOCK_LOAD_RES_KEY)

	if slot0._prefabDict then
		for slot4, slot5 in pairs(slot0._prefabDict) do
			slot5:dispose()
		end

		slot0._prefabDict = nil
	end

	if slot0._retailPrefabDict then
		for slot4, slot5 in pairs(slot0._retailPrefabDict) do
			slot5:dispose()
		end

		slot0._retailPrefabDict = nil
	end
end

function slot0.getSceneBackgroundUrl(slot0)
	return ResUrl.getSeason123Scene(slot0:getSceneFolderPath(), slot0:getDefaultBackgroundPrefab())
end

function slot0.onLoadResCompleted(slot0, slot1)
	if not slot0._loader then
		return
	end

	if slot1:getAssetItem(slot0:getSceneBackgroundUrl()) then
		slot0._sceneGo = gohelper.clone(slot2:GetResource(), slot0._sceneRoot, "scene")
		slot0._sceneRetailRoot = gohelper.findChild(slot0._sceneGo, "root")
	end

	UIBlockMgr.instance:endBlock(uv0.BLOCK_LOAD_RES_KEY)

	if slot0._callback then
		if slot0._callbackObj then
			slot0._callback(slot0._callbackObj, slot0._sceneGo)
		else
			slot0._callback(slot0._sceneGo)
		end
	end
end

function slot0.showStageRes(slot0, slot1, slot2, slot3)
	if not Season123Config.instance:getStageCo(Season123EntryModel.instance.activityId, slot1) then
		return
	end

	for slot9, slot10 in pairs(slot0._containerDict) do
		gohelper.setActive(slot10, slot9 == slot1)
	end

	if not slot0._containerDict[slot1] then
		slot0:createPrefabInst(slot1, slot5, slot2, slot3)
	elseif slot2 then
		slot0:playAnim(slot1, Activity123Enum.StageSceneAnim.Open)
	end
end

function slot0.hideAllStage(slot0)
	for slot4, slot5 in pairs(slot0._containerDict) do
		gohelper.setActive(slot5, false)
	end
end

function slot0.showRetailRes(slot0, slot1)
	slot2, slot3 = Season123EntryModel.getRandomRetailRes(slot1)

	for slot7, slot8 in pairs(slot0._retailContainerDict) do
		gohelper.setActive(slot8, slot7 == slot2)
	end

	if not slot0._retailContainerDict[slot2] then
		slot0:createRetailPrefabInst(slot1)
	end
end

function slot0.hideAllRetail(slot0)
	for slot4, slot5 in pairs(slot0._retailContainerDict) do
		gohelper.setActive(slot5, false)
	end
end

function slot0.createPrefabInst(slot0, slot1, slot2, slot3, slot4)
	if string.nilorempty(slot2.res) then
		return
	end

	slot5 = UnityEngine.GameObject.New("stage_" .. tostring(slot1))

	gohelper.addChild(slot0._sceneRoot, slot5)

	slot0._containerDict[slot1] = slot5

	if not string.nilorempty(slot2.initPos) then
		slot7 = string.splitToNumber(slot6, "#")

		transformhelper.setLocalPos(slot5.transform, slot7[1], slot7[2], 0)
	else
		transformhelper.setLocalPos(slot5.transform, 0, 0, 0)
	end

	if not string.nilorempty(slot2.initScale) then
		slot8 = string.splitToNumber(slot7, "#")

		transformhelper.setLocalScale(slot5.transform, slot8[1], slot8[2], 1)
	else
		transformhelper.setLocalScale(slot5.transform, 1, 1, 1)
	end

	slot0._prefabDict[slot1] = PrefabInstantiate.Create(slot5)
	slot0.tempStage = slot1
	slot0.isOpen = slot3
	slot0.jumpId = slot4 and slot4.jumpId

	slot8:startLoad(ResUrl.getSeason123Scene(slot0:getSceneFolderPath(), slot2.res), slot0.loadCallback, slot0)
end

function slot0.loadCallback(slot0, slot1)
	if slot0.tempStage then
		slot0._animDict[slot0.tempStage] = slot1:getInstGO():GetComponent(gohelper.Type_Animator)

		if slot0.isOpen then
			slot0:playAnim(slot0.tempStage, Activity123Enum.StageSceneAnim.Open)

			if slot0.jumpId then
				slot0:jumpLoadHandle()
			end

			slot0.isOpen = nil
			slot0.jumpId = nil
		end

		slot0.tempStage = nil
	end
end

function slot0.jumpLoadHandle(slot0)
	if (slot0.jumpId == Activity123Enum.JumpId.Market or slot0.jumpId == Activity123Enum.JumpId.MarketNoResult) and slot0._containerDict[slot0.tempStage] and slot0.tempStage and slot0.tempStage > 0 then
		slot2 = Season123Config.instance:getStageCo(Season123EntryModel.instance.activityId, slot0.tempStage)
		slot5 = string.splitToNumber(slot2.finalPos, "#")

		transformhelper.setLocalPosXY(slot1.transform, slot5[1], slot5[2])

		slot6 = string.splitToNumber(slot2.finalScale, "#")

		transformhelper.setLocalScale(slot1.transform, slot6[1], slot6[2], 1)
	end
end

slot1 = {
	"v1a7_s15_yisuoerde_a",
	"v1a7_s15_makusi_a",
	"v1a7_s15_kakaniya_a"
}

function slot0.createRetailPrefabInst(slot0, slot1)
	slot2, slot3 = Season123EntryModel.getRandomRetailRes(slot1)
	slot5 = UnityEngine.GameObject.New("retail_" .. tostring(slot2))

	gohelper.addChild(slot0._sceneRetailRoot, slot5)
	transformhelper.setLocalPos(slot5.transform, 0, 0, 0)
	transformhelper.setLocalScale(slot5.transform, 1, 1, 1)

	slot6 = PrefabInstantiate.Create(slot5)
	slot0._retailContainerDict[slot2] = slot5
	slot0._retailPrefabDict[slot2] = slot6

	slot6:startLoad(ResUrl.getSeason123RetailPrefab(slot0:getSceneFolderPath(), string.format("%s%s", Activity123Enum.SeasonResourcePrefix[Season123EntryModel.instance.activityId], slot3)), slot0.onLoadRetailCompleted, slot0)
end

function slot0.onLoadRetailCompleted(slot0, slot1)
	if slot0:getIndexByRetailInst(slot1) and slot1:getInstGO() and slot3.transform:GetChild(0) then
		slot5, slot6 = transformhelper.getLocalPos(slot4)
		slot0._retailPosXDict[slot2] = -slot5
		slot0._retailPosYDict[slot2] = -slot6

		Season123EntryController.instance:dispatchEvent(Season123Event.RetailObjLoaded, slot2)
	end
end

function slot0.getIndexByRetailInst(slot0, slot1)
	if not slot0._retailPrefabDict then
		return
	end

	for slot5, slot6 in pairs(slot0._retailPrefabDict) do
		if slot6 == slot1 then
			return slot5
		end
	end
end

function slot0.getRetailPosByIndex(slot0, slot1)
	return slot0._retailPosXDict[slot1], slot0._retailPosYDict[slot1]
end

function slot0.playAnim(slot0, slot1, slot2)
	if not slot0._animDict[slot1] then
		return
	end

	if slot0.jumpId and slot0.jumpId > 0 then
		slot0._animDict[slot1]:Play(slot2, 0, 1)
	else
		slot0._animDict[slot1]:Play(slot2, 0, 0)
	end
end

function slot0.tweenStage(slot0, slot1, slot2)
	if not slot0._containerDict[slot1] then
		logError("gameObject is empty:stage" .. slot1)

		return
	end

	slot3 = slot0._containerDict[slot1].transform
	slot4 = Season123Config.instance:getStageCo(Season123EntryModel.instance.activityId, slot1)
	slot5, slot6 = nil

	if slot2 then
		slot5 = slot4.finalPos
		slot6 = slot4.finalScale
	else
		slot5 = slot4.initPos
		slot6 = slot4.initScale
	end

	AudioMgr.instance:trigger(AudioEnum.UI.season123_map_scale)

	slot7 = string.splitToNumber(slot5, "#")

	ZProj.TweenHelper.DOLocalMove(slot3, slot7[1], slot7[2], 0, 0.7)

	slot8 = string.splitToNumber(slot6, "#")

	ZProj.TweenHelper.DOScale(slot3, slot8[1], slot8[2], 1, 0.7)
end

function slot0.getSceneFolderPath(slot0)
	return string.format("%s%s", Activity123Enum.SeasonResourcePrefix[Season123EntryModel.instance.activityId or Season123Model.instance:getCurSeasonId()], Activity123Enum.SceneFolderPath)
end

function slot0.getDefaultBackgroundPrefab(slot0)
	return string.format("%s%s", Activity123Enum.SeasonResourcePrefix[Season123EntryModel.instance.activityId or Season123Model.instance:getCurSeasonId()], Activity123Enum.DefaultBackgroundPrefab)
end

return slot0
