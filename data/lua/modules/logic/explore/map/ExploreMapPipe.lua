module("modules.logic.explore.map.ExploreMapPipe", package.seeall)

slot0 = class("ExploreMapPipe")
slot1 = ExploreEnum.PipeColor

GameUtil.setDefaultValue({
	[slot1.Color1] = slot1.Color1,
	[slot1.Color2] = slot1.Color2,
	[slot1.Color3] = slot1.Color3,
	[bit.bor(slot1.Color1, slot1.Color2)] = slot1.Color3,
	[bit.bor(slot1.Color3, slot1.Color2)] = slot1.Color1,
	[bit.bor(slot1.Color1, slot1.Color3)] = slot1.Color2
}, slot1.None)

function slot0.loadMap(slot0)
end

function slot0.init(slot0)
	if #ExploreController.instance:getMap():getUnitsByTypeDict(ExploreEnum.PipeTypes) <= 0 then
		return
	end

	slot0._allPipeMos = {}
	slot0._allPipeComps = {}

	for slot6, slot7 in pairs(slot2) do
		slot8 = ExploreHelper.getKey(slot7.mo.nodePos)
		slot0._allPipeMos[slot8] = slot7.mo
		slot0._allPipeComps[slot8] = slot7.pipeComp
	end

	slot0:initColors(true)

	slot0._tweenId = nil
end

function slot0.sortUnitById(slot0, slot1)
	return slot0.id < slot1.id
end

function slot0.initColors(slot0, slot1, slot2, slot3)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	if #(slot3 or {}) > 50 then
		slot4 = ""

		if isDebugBuild then
			for slot8, slot9 in pairs(slot0._allPipeMos) do
				slot4 = string.format("%s\n[%s,%s,%s]", slot4, slot9.id, slot9:getColor(0), slot9:isInteractActiveState())
			end
		end

		logError("密室管道死循环了？？？" .. slot4)

		return
	end

	slot0._all = nil
	slot0._allOutColor = nil
	slot5 = {
		[slot12.id] = slot13
	}
	slot0._cacheActiveSensor = slot2 or {}

	table.sort(ExploreController.instance:getMap():getUnitsByType(ExploreEnum.ItemType.PipeEntrance), uv0.sortUnitById)

	for slot11, slot12 in ipairs(slot7) do
		if slot12.mo:getColor() ~= ExploreEnum.PipeColor.None then
			slot0:calcRelation(slot12.mo, slot12.id, {}, nil, slot12.mo:getPipeOutDir())
		end
	end

	slot8 = slot6:getUnitsByType(ExploreEnum.ItemType.PipeSensor)

	table.sort(slot8, uv0.sortUnitById)

	for slot12, slot13 in ipairs(slot8) do
		if slot13.mo:getColor() ~= ExploreEnum.PipeColor.None then
			slot5[slot13.id] = slot14

			slot0:calcRelation(slot13.mo, slot13.id, slot4, nil, slot13.mo:getPipeOutDir())
		end
	end

	slot9 = slot6:getUnitsByType(ExploreEnum.ItemType.PipeMemory)

	table.sort(slot9, uv0.sortUnitById)

	for slot13, slot14 in ipairs(slot9) do
		if slot14.mo:getColor() ~= ExploreEnum.PipeColor.None then
			slot5[slot14.id] = slot15

			slot0:calcRelation(slot14.mo, slot14.id, slot4, nil, slot14.mo:getPipeOutDir())
		end
	end

	slot0:delUnUseDir(slot4)

	slot10 = {}
	slot11 = {}

	for slot15, slot16 in ipairs(slot4) do
		if slot16.isDivisive then
			if not slot10[slot16.toId] then
				slot10[slot16.toId] = {
					[slot16.fromId] = true
				}
			else
				slot10[slot16.toId][slot16.fromId] = true
			end

			if slot16.noOutDivisive then
				slot11[slot16.toId] = true
			end
		end
	end

	while true do
		slot12 = false

		for slot16, slot17 in pairs(slot10) do
			for slot22 in pairs(slot17) do
				if slot22 ~= slot16 then
					if slot5[slot22] then
						slot18 = bit.bor(uv1.None, slot5[slot22])
					else
						slot18 = nil

						break
					end
				end
			end

			if slot18 then
				slot19 = uv2[slot18]

				if slot11[slot16] and not slot0:haveValue(uv1, slot18) then
					slot19 = uv1.None
				end

				slot5[slot16] = slot19
				slot12 = true
				slot10[slot16] = nil
			end
		end

		if not slot12 and next(slot10) then
			for slot16, slot17 in pairs(slot10) do
				for slot22 in pairs(slot17) do
					if slot22 ~= slot16 then
						if slot5[slot22] then
							slot18 = bit.bor(uv1.None, slot5[slot22])
						elseif not slot0:isRound({}, slot16, slot22, slot10) then
							slot18 = nil

							break
						end
					end
				end

				if slot18 ~= uv1.None and slot18 then
					slot19 = uv2[slot18]

					if slot11[slot16] and not slot0:haveValue(uv1, slot18) then
						slot19 = uv1.None
					end

					slot5[slot16] = slot19
					slot12 = true
					slot10[slot16] = nil

					break
				end
			end
		end
	end

	slot13 = {
		[slot18.id] = 1
	}

	for slot17, slot18 in ipairs(slot8) do
		if not slot2[slot18.id] and slot18.mo:getColor() == ExploreEnum.PipeColor.None then
			slot20 = ExploreHelper.dirToXY(slot18.mo.unitDir)

			if slot0._allPipeMos[ExploreHelper.getKeyXY(slot18.mo.nodePos.x + slot20.x, slot18.mo.nodePos.y + slot20.y)] and slot0:getOutDirColor(slot4, slot5, ExploreHelper.getDir(slot18.mo.unitDir + 180), slot22.id, ExploreEnum.PipeDirMatchMode.Single) == slot18.mo:getNeedColor() then
				slot2[slot18.id] = true
			end
		end
	end

	for slot17, slot18 in ipairs(slot9) do
		slot20 = ExploreHelper.dirToXY(slot18.mo.unitDir)

		if (slot0._allPipeMos[ExploreHelper.getKeyXY(slot18.mo.nodePos.x + slot20.x, slot18.mo.nodePos.y + slot20.y)] and slot0:getOutDirColor(slot4, slot5, ExploreHelper.getDir(slot18.mo.unitDir + 180), slot22.id, ExploreEnum.PipeDirMatchMode.Single) or ExploreEnum.PipeColor.None) ~= slot18.mo:getColor() and slot23 ~= ExploreEnum.PipeColor.None then
			slot18.mo:setCacheColor(slot23)

			slot13[slot18.id] = slot23
		end
	end

	if not slot0:haveHistory(slot3, slot13) then
		table.insert(slot3, slot13)

		return slot0:initColors(slot1, slot2, slot3)
	end

	slot0._all = slot4
	slot0._allOutColor = slot5

	if slot1 then
		slot0._initDone = true
	end

	for slot17, slot18 in pairs(slot0._allPipeComps) do
		slot18:applyColor(slot1)
	end

	if not slot1 then
		ExploreModel.instance:setStepPause(true)
		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Pipe)

		slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.4, slot0._frameCall, slot0._finishCall, slot0, nil, EaseType.Linear)
	end
end

function slot0.haveHistory(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot1) do
		if tabletool.len(slot7) == tabletool.len(slot2) then
			slot8 = true

			for slot12, slot13 in pairs(slot7) do
				if slot2[slot12] ~= slot13 then
					slot8 = false

					break
				end
			end

			if slot8 then
				return true
			end
		end
	end

	return false
end

function slot0.isRound(slot0, slot1, slot2, slot3, slot4)
	if slot2 == slot3 then
		return true
	end

	if slot1[slot3 or slot2] then
		return
	end

	slot1[slot3] = true

	if slot4[slot3] then
		for slot9 in pairs(slot4) do
			if slot0:isRound(slot1, slot2, slot9, slot4) then
				return true
			end
		end
	end
end

function slot0.haveValue(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot1) do
		if slot7 == slot2 then
			return true
		end
	end

	return false
end

function slot0.isCacheActive(slot0, slot1)
	if not slot0._cacheActiveSensor then
		return
	end

	return slot0._cacheActiveSensor[slot1]
end

function slot0._frameCall(slot0, slot1)
	for slot5, slot6 in pairs(slot0._allPipeComps) do
		slot6:tweenColor(slot1)
	end
end

function slot0._finishCall(slot0)
	ExploreModel.instance:setStepPause(false)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Pipe)
end

function slot0.getDirColor(slot0, slot1, slot2)
	slot3 = slot0._all
	slot4 = slot0._allOutColor

	if ExploreController.instance:getMap():getUnit(slot1).mo:isDivisive() then
		slot6 = nil

		for slot10, slot11 in ipairs(slot3) do
			if slot11.toId == slot1 and slot2 == slot11.inDir then
				slot6 = slot11

				break
			end
		end

		if slot6 then
			return slot6 and slot4[slot6.fromId] or slot0:getOutDirColor(slot3, slot4, slot2, slot1, ExploreEnum.PipeDirMatchMode.Single)
		end
	end

	return slot0:getOutDirColor(slot3, slot4, slot2, slot1, ExploreEnum.PipeDirMatchMode.Both)
end

function slot0.getCenterColor(slot0, slot1)
	return slot0:getOutDirColor(nil, , , slot1, ExploreEnum.PipeDirMatchMode.All)
end

function slot0.getOutDirColor(slot0, slot1, slot2, slot3, slot4, slot5)
	slot2 = slot2 or slot0._allOutColor

	if not (slot1 or slot0._all) then
		return ExploreEnum.PipeColor.None
	end

	if slot2[slot4] then
		if not ExploreMapModel.instance:getUnitMO(slot4) then
			return ExploreEnum.PipeColor.None
		end

		if slot3 and not slot6:isOutDir(slot3) then
			return ExploreEnum.PipeColor.None
		end

		return slot2[slot4]
	end

	slot6 = nil

	for slot10, slot11 in ipairs(slot1) do
		slot12 = false

		if slot5 == ExploreEnum.PipeDirMatchMode.Single then
			slot12 = slot3 == slot11.outDir
		elseif slot5 == ExploreEnum.PipeDirMatchMode.Both then
			slot12 = slot3 == slot11.outDir or slot3 == slot11.inDir
		elseif slot5 == ExploreEnum.PipeDirMatchMode.All then
			slot12 = true
		end

		if slot11.toId == slot4 and slot12 then
			slot6 = slot11

			break
		end
	end

	return slot6 and slot2[slot6.fromId] or ExploreEnum.PipeColor.None
end

function slot0.delUnUseDir(slot0, slot1)
	while true do
		slot2 = false

		for slot6, slot7 in ipairs(slot1) do
			if slot7.isDivisive then
				slot8 = {}

				for slot12, slot13 in ipairs(slot1) do
					if slot13.fromId == slot7.toId and slot7.inDir == slot13.fromDir or slot13.toId == slot7.toId and slot7.inDir == slot13.outDir then
						table.insert(slot8, slot12)
					end
				end

				for slot12 = #slot8, 1, -1 do
					table.remove(slot1, slot8[slot12])

					slot2 = true
				end
			end

			if slot2 then
				break
			end
		end
	end

	for slot6 = #slot1, 1, -1 do
		slot7 = slot1[slot6]

		for slot11 = slot6 - 1, 1, -1 do
			slot12 = slot1[slot11]

			if not slot7.isDivisive and slot7.toId == slot12.toId and slot7.inDir == slot12.outDir then
				table.remove(slot1, slot6)

				break
			end
		end
	end
end

function slot0.calcRelation(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6, slot7, slot8 = slot1:getPipeOutDir(slot4)

	slot0:calcRelationDir(slot6, slot1, slot2, slot3, slot4, slot5)
	slot0:calcRelationDir(slot7, slot1, slot2, slot3, slot4, slot5)
	slot0:calcRelationDir(slot8, slot1, slot2, slot3, slot4, slot5)
end

function slot0.calcRelationDir(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if not slot1 then
		return
	end

	for slot10, slot11 in ipairs(slot4) do
		if slot11.inDir == slot5 and slot11.toId == slot2.id and slot11.outDir == slot1 then
			return
		end
	end

	table.insert(slot4, {
		fromId = slot3,
		inDir = slot5,
		toId = slot2.id,
		outDir = slot1,
		fromDir = slot6,
		isDivisive = slot2:isDivisive(),
		noOutDivisive = slot2:isDivisive() and not slot2:haveOutDir()
	})

	slot7 = ExploreHelper.dirToXY(slot1)

	if not slot0._allPipeMos[ExploreHelper.getKeyXY(slot2.nodePos.x + slot7.x, slot2.nodePos.y + slot7.y)] or slot9.type ~= ExploreEnum.ItemType.Pipe then
		return
	end

	if slot2:isDivisive() then
		slot3 = slot2.id
		slot6 = slot1
	end

	return slot0:calcRelation(slot9, slot3, slot4, ExploreHelper.getDir(slot1 + 180), slot6)
end

function slot0.isInitDone(slot0)
	return slot0._initDone
end

function slot0.unloadMap(slot0)
	slot0:destroy()
end

function slot0.destroy(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot0._initDone = false
	slot0._allPipeMos = {}
	slot0._allPipeComps = {}
	slot0._all = nil
	slot0._allOutColor = nil
	slot0._cacheActiveSensor = nil
end

return slot0
