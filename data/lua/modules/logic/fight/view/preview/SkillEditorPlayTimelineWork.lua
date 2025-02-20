module("modules.logic.fight.view.preview.SkillEditorPlayTimelineWork", package.seeall)

slot0 = class("SkillEditorPlayTimelineWork", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0)
	SkillEditorMgr.instance:registerCallback(SkillEditorMgr._StopAutoPlayFlow1, slot0._stopFlow, slot0)

	slot0._completeList = {}
	slot0._skillCount = 0
	slot1 = false
	slot0.flow = FlowSequence.New()
	slot3 = GameSceneMgr.instance:getCurScene().entityMgr

	if FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.MySide) and #slot2 > 0 then
		for slot7, slot8 in ipairs(slot2) do
			if #slot0:_getEntitySkillCOList(slot8) > 0 then
				for slot13, slot14 in ipairs(slot9) do
					slot15 = slot8.id

					if FightHelper.getTargetLimits(FightEnum.EntitySide.MySide, slot14) and #slot18 > 0 and not tabletool.indexOf(slot18, slot3:getEntityByPosId(SceneTag.UnitMonster, SkillEditorView.selectPosId[FightEnum.EntitySide.EnemySide]).id) then
						slot16 = slot18[1]
					end

					slot23 = slot16

					for slot23, slot24 in ipairs(SkillEditorStepBuilder.buildStepMOs(slot14, slot15, slot23)) do
						slot0.flow:addWork(FunctionWork.New(function ()
							SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._onSwitchEnityOrSkill, {
								skillstr = uv0 .. "\n" .. string.format("当前技能\n%s\n剩余技能%s/%s", lua_skill.configDict[uv0].name, #uv1 - uv2, #uv1)
							})
						end, slot0))
						slot0.flow:addWork(FightSkillEditorFlow.New(slot24))
					end

					slot0.flow:addWork(FunctionWork.New(function ()
						uv0._skillCount = uv0._skillCount + 1
					end, slot0))
					slot0.flow:addWork(FunctionWork.New(slot0._checkSkillDone, slot0, {
						count = #slot9,
						id = slot8.id
					}))
				end

				slot1 = true

				slot0.flow:addWork(FunctionWork.New(slot0._checkSkillDone, slot0, {
					count = #slot2
				}))
			end
		end

		if slot1 then
			slot0.flow:start()
		else
			slot0:onDone(true)
		end
	else
		slot0:onDone(true)
	end
end

function slot0._getEntitySkillCOList(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(slot1.skillIds) do
		slot10 = string.split(FightConfig.instance:getSkinSkillTimeline(slot1.skin, slot8), "_")

		if slot8 and not string.nilorempty(slot9) and not slot3[slot10[#slot10]] then
			slot3[slot10[#slot10]] = true

			table.insert({}, slot8)
		end
	end

	for slot8, slot9 in ipairs(lua_skill.configList) do
		slot11 = slot9.timeline

		if string.find(tostring(slot9.id), tostring(slot1.modelId)) == 1 and not string.nilorempty(slot11) then
			slot12 = string.split(slot11, "_")

			if slot9.id and not string.nilorempty(slot11) and not slot3[slot12[#slot12]] then
				slot3[slot12[#slot12]] = true

				table.insert(slot2, slot9.id)
			end
		end
	end

	return slot2
end

function slot0._stopFlow(slot0)
	if slot0.flow and slot0.flow.status == WorkStatus.Running then
		for slot6 = slot0.flow._curIndex, #slot0.flow:getWorkList() do
			slot1[slot6]:onDone(true)
		end

		SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._StopAutoPlayFlow2, slot0)
		slot0:onDone(true)
	end
end

function slot0._checkSkillDone(slot0, slot1)
	if not slot1.id then
		if #slot0._completeList == slot1.count then
			slot0:onDone(true)
		end
	elseif slot0._skillCount == slot2 then
		table.insert(slot0._completeList, slot3)

		slot0._skillCount = 0
	end
end

function slot0.clearWork(slot0)
	SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr._StopAutoPlayFlow1, slot0._stopFlow, slot0)
end

return slot0
