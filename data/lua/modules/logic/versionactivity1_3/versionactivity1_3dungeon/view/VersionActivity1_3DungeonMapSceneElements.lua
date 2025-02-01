module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonMapSceneElements", package.seeall)

slot0 = class("VersionActivity1_3DungeonMapSceneElements", DungeonMapSceneElements)

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0._dailyElementList = slot0:getUserDataTb_()
	slot0._dailyElementMats = slot0:getUserDataTb_()
	slot0._tweenList = {}
	slot0._matKey = UnityEngine.Shader.PropertyToID("_MainCol")
end

function slot0.onOpen(slot0)
	slot0.activityDungeonMo = slot0.viewContainer.versionActivityDungeonBaseMo

	uv0.super.onOpen(slot0)
	slot0:addEventCb(VersionActivity1_3DungeonController.instance, VersionActivity1_3DungeonEvent.SelectChangeDaily, slot0._onSelectChangeDaily, slot0)
	slot0:addEventCb(VersionActivity1_3DungeonController.instance, VersionActivity1_3DungeonEvent.LoadSameScene, slot0._onLoadSameScene, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnInitElements, slot0._initElements, slot0)
end

function slot0._onLoadSameScene(slot0)
	slot0:_checkTryFocusDaily()
end

function slot0._onSelectChangeDaily(slot0, slot1)
	for slot5, slot6 in pairs(slot0._tweenList) do
		if slot6.tweenId then
			ZProj.TweenHelper.KillById(slot6.tweenId)

			slot6.tweenId = nil
		end

		if slot6.to == 0 then
			slot6.comp:hide()
		end
	end

	slot2, slot3 = nil

	for slot7, slot8 in pairs(slot0._dailyElementList) do
		if slot8:getVisible() then
			slot2 = slot8
		end

		slot8:setWenHaoGoVisible(false)

		if slot7 == slot1 then
			slot8:show()

			slot3 = slot8
		else
			slot8:hide()
		end
	end

	if not slot2 or not slot3 or slot2 == slot3 then
		return
	end

	slot0:_tweenAlpha(slot2, 1, 0)
	slot0:_tweenAlpha(slot3, 0, 1)
end

function slot0._tweenAlpha(slot0, slot1, slot2, slot3)
	slot1:show()

	if not slot0._tweenList[slot1] then
		slot0:_cloneMats(slot1)

		slot4 = {}
		slot0._tweenList[slot1] = slot4
		slot4.comp = slot1
		slot4.mats = slot0._dailyElementMats[slot1]
		slot4.color = Color.white
	end

	slot4.from = slot2
	slot4.to = slot3
	slot4.tweenId = ZProj.TweenHelper.DOTweenFloat(slot4.color.a, slot3, 0.5, slot0._tweenFrame, slot0._tweenFinish, slot0, slot4, EaseType.Linear)
end

function slot0._tweenFrame(slot0, slot1, slot2)
	slot2.color.a = slot1

	if not slot2.mats then
		return
	end

	for slot7, slot8 in pairs(slot3) do
		slot8:SetColor(slot0._matKey, slot2.color)
	end
end

function slot0._tweenFinish(slot0, slot1)
	slot1.color.a = slot1.to

	if slot1.to == 0 then
		slot1.comp:hide()
	end

	if not slot1.mats then
		return
	end

	for slot7, slot8 in pairs(slot3) do
		slot8:SetColor(slot0._matKey, slot1.color)
	end
end

function slot0._cloneMats(slot0, slot1)
	if gohelper.isNil(slot1:getItemGo()) then
		return
	end

	if slot0._dailyElementMats[slot1] then
		return
	end

	slot3 = {}

	for slot8 = 0, slot2:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer)).Length - 1 do
		slot10 = UnityEngine.Object.Instantiate(slot4[slot8].material)
		slot4[slot8].material = slot10

		table.insert(slot3, slot10)
	end

	slot0._dailyElementMats[slot1] = slot3
end

function slot0._setEpisodeListVisible(slot0, slot1)
	uv0.super._setEpisodeListVisible(slot0, slot1)

	slot2, slot3 = Activity126Model.instance:getRemainNum()

	for slot7, slot8 in pairs(slot0._dailyElementList) do
		if slot8:getVisible() then
			slot8:setWenHaoGoVisible(slot2 > 0)
		end
	end
end

function slot0._getElements(slot0, slot1)
	if slot0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		return {}
	end

	for slot7, slot8 in pairs(DungeonMapModel.instance:getAllElements()) do
		slot9 = DungeonConfig.instance:getChapterMapElement(slot8)

		if slot0.activityDungeonMo.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard and slot9.type == DungeonEnum.ElementType.DailyEpisode and slot9.mapId <= slot1 and slot0.activityDungeonMo.episodeId ~= VersionActivity1_3DungeonEnum.ExtraEpisodeId then
			if tonumber(slot9.param) and lua_activity126_episode_daily.configDict[slot10] then
				table.insert(slot2, slot9)
			end
		elseif slot9.mapId == slot1 then
			table.insert(slot2, slot9)
		end
	end

	return slot2
end

function slot0._showElements(slot0, slot1)
	if not slot0._sceneGo or slot0._lockShowElementAnim then
		return
	end

	if VersionActivity1_3DungeonController.instance.directFocusDaily then
		slot0._skipShowElementAnim = true
	end

	slot3 = DungeonMapModel.instance:getNewElements()
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in ipairs(slot0:_getElements(slot1)) do
		if slot10.type ~= DungeonEnum.ElementType.DailyEpisode then
			if slot10.showCamera == 1 and not slot0._skipShowElementAnim and (slot3 and tabletool.indexOf(slot3, slot10.id) or slot0._forceShowElementAnim) then
				table.insert(slot4, slot10.id)
			else
				table.insert(slot5, slot10)
			end
		end
	end

	slot0:_showElementAnim(slot4, slot5)
	DungeonMapModel.instance:clearNewElements()
end

function slot0._addElement(slot0, slot1)
	if slot0._elementList[slot1.id] then
		return
	end

	slot2 = UnityEngine.GameObject.New(tostring(slot1.id))

	gohelper.addChild(slot0._elementRoot, slot2)

	slot0._elementList[slot1.id] = MonoHelper.addLuaComOnceToGo(slot2, DungeonMapElement, {
		slot1,
		slot0._mapScene,
		slot0
	})

	if slot1.type == DungeonEnum.ElementType.DailyEpisode then
		slot0._dailyElementList[tonumber(slot1.param)] = slot3

		slot3:hide()
	end

	if slot3:showArrow() then
		slot5 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[5], slot0._goarrow)
		slot6 = gohelper.findChild(slot5, "mesh")
		slot7, slot8, slot9 = transformhelper.getLocalRotation(slot6.transform)
		slot10 = gohelper.getClick(gohelper.findChild(slot5, "click"))

		slot10:AddClickListener(slot0._arrowClick, slot0, slot1.id)

		slot0._arrowList[slot1.id] = {
			go = slot5,
			rotationTrans = slot6.transform,
			initRotation = {
				slot7,
				slot8,
				slot9
			},
			arrowClick = slot10
		}

		slot0:_updateArrow(slot3)
	end
end

function slot0._onAddAnimElementDone(slot0)
	if slot0._dailyElementList[Activity126Model.instance:getShowDailyId()] then
		slot2:show()

		slot3, slot4 = Activity126Model.instance:getRemainNum()

		slot2:setWenHaoGoVisible(slot3 > 0)
	end

	if not ViewMgr.instance:isOpen(ViewName.VersionActivity1_3DungeonChangeView) then
		slot0:_checkTryFocusDaily()
	end
end

function slot0._checkTryFocusDaily(slot0)
	if slot0._tryFocusDaily then
		slot0:focusDaily()

		slot0._tryFocusDaily = nil
	end
end

function slot0.focusDaily(slot0)
	slot0._tryFocusDaily = true

	if slot0.viewContainer.viewParam and slot0.viewContainer.viewParam.showDaily then
		return
	end

	for slot4, slot5 in pairs(slot0._dailyElementList) do
		if slot5:getVisible() then
			slot0._tryFocusDaily = nil

			slot0:clickElement(slot5:getElementId())

			return
		end
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.VersionActivity1_3DungeonChangeView then
		slot0:_checkTryFocusDaily()
	end
end

function slot0.onClose(slot0)
	for slot4, slot5 in pairs(slot0._tweenList) do
		if slot5.tweenId then
			ZProj.TweenHelper.KillById(slot5.tweenId)

			slot5.tweenId = nil
		end
	end
end

return slot0
