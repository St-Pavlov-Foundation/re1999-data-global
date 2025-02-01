module("modules.logic.explore.controller.ExploreStepController", package.seeall)

slot0 = class("ExploreStepController", BaseController)

function slot0.initMap(slot0)
	if slot0._map then
		return
	end

	slot0._map = ExploreController.instance:getMap()
	slot0._hero = slot0._map:getHero()
	slot0._mapId = ExploreModel.instance:getMapId()
	slot1, slot2 = ExploreMapModel.instance:getHeroPos()
	slot0._cachePos = {
		x = slot1,
		y = slot2
	}
	slot0._stepList = {}
end

function slot0.onExploreStepPush(slot0, slot1)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Explore then
		return
	end

	slot0:initMap()

	for slot5, slot6 in ipairs(slot1.steps) do
		slot7 = cjson.decode(slot6.param)
		slot8 = #slot0._stepList

		while slot0._stepList[slot8] do
			if slot0._stepList[slot8].alwaysLast then
				slot8 = slot8 - 1
			else
				break
			end
		end

		if slot7.stepType == ExploreEnum.StepType.UpdateUnit or slot7.stepType == ExploreEnum.StepType.DelUnit then
			slot7.interact = cjson.decode(slot7.interact)
		end

		if slot7.stepType == ExploreEnum.StepType.UpdateUnit then
			for slot12 = #slot0._stepList, 1, -1 do
				if slot0._stepList[slot12].stepType == ExploreEnum.StepType.UpdateUnit then
					if slot13.interact.id == slot7.interact.id then
						table.remove(slot0._stepList, slot12)

						slot8 = slot8 - 1

						break
					end
				else
					break
				end
			end
		end

		table.insert(slot0._stepList, slot8 + 1, slot7)

		if slot7.stepType == ExploreEnum.StepType.RoleMove then
			ExploreMapModel.instance:updatHeroPos(slot7.x, slot7.y, slot7.direction)

			slot0._cachePos = slot7
		end
	end

	slot0:startStep()
end

function slot0.insertClientStep(slot0, slot1, slot2)
	slot0:initMap()

	if slot2 then
		table.insert(slot0._stepList, slot2, slot1)
	else
		table.insert(slot0._stepList, slot1)
	end
end

function slot0.forceAsyncPos(slot0)
	slot0:initMap()
	slot0._hero:stopMoving(true)
	slot0._hero:setPosByNode(slot0._cachePos, true)
	slot0._hero:setBool(ExploreAnimEnum.RoleAnimKey.IsIce, false)
	slot0._hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)
	ExploreModel.instance:setHeroControl(true)
end

function slot0.startStep(slot0)
	if slot0._curRunStep then
		return
	end

	if ExploreModel.instance:getStepPause() then
		return
	end

	if not slot0._stepList then
		return
	end

	if #slot0._stepList <= 0 then
		slot0:onStepAllDone()

		return
	end

	if _G[string.format("Explore%sStep", ExploreEnum.StepTypeToName[table.remove(slot0._stepList, 1).stepType] or "")] then
		slot0._curRunStep = slot4.New(slot1)
	else
		logError("未处理步骤类型" .. tostring(slot2))

		slot0._curRunStep = ExploreStepBase.New(slot1)
	end

	return slot0._curRunStep:onStart()
end

function slot0.onStepEnd(slot0)
	slot0._curRunStep = nil

	slot0:startStep()
end

function slot0.onStepAllDone(slot0)
end

function slot0.getCurStepType(slot0)
	if not slot0._curRunStep then
		return
	end

	return slot0._curRunStep._data.stepType
end

function slot0.getStepIndex(slot0, slot1)
	if slot0._curRunStep and slot0._curRunStep._data.stepType == slot1 then
		return 0
	end

	if not slot0._stepList then
		return -1
	end

	for slot5, slot6 in ipairs(slot0._stepList) do
		if slot6.stepType == slot1 then
			return slot5
		end
	end

	return -1
end

function slot0.clear(slot0)
	slot0._map = nil
	slot0._hero = nil

	if slot0._curRunStep then
		slot0._curRunStep:onDestory()

		slot0._curRunStep = nil
	end

	slot0._stepList = {}

	if slot0._stepList then
		for slot5, slot6 in pairs(slot1) do
			if ExploreEnum.MustDoStep[slot6.stepType] then
				_G[string.format("Explore%sStep", ExploreEnum.StepTypeToName[slot6.stepType] or "")].New(slot6):onStart()
			end
		end
	end
end

slot0.instance = slot0.New()

return slot0
