module("modules.logic.fight.view.preview.SkillEditorPlayTimelineWork", package.seeall)

local var_0_0 = class("SkillEditorPlayTimelineWork", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0)
	SkillEditorMgr.instance:registerCallback(SkillEditorMgr._StopAutoPlayFlow1, arg_2_0._stopFlow, arg_2_0)

	arg_2_0._completeList = {}
	arg_2_0._skillCount = 0

	local var_2_0 = false

	arg_2_0.flow = FlowSequence.New()

	local var_2_1 = FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.MySide)
	local var_2_2 = GameSceneMgr.instance:getCurScene().entityMgr

	if var_2_1 and #var_2_1 > 0 then
		for iter_2_0, iter_2_1 in ipairs(var_2_1) do
			local var_2_3 = arg_2_0:_getEntitySkillCOList(iter_2_1)

			if #var_2_3 > 0 then
				for iter_2_2, iter_2_3 in ipairs(var_2_3) do
					local var_2_4 = iter_2_1.id
					local var_2_5 = var_2_2:getEntityByPosId(SceneTag.UnitMonster, SkillEditorView.selectPosId[FightEnum.EntitySide.EnemySide]).id
					local var_2_6 = FightEnum.EntitySide.MySide
					local var_2_7 = FightHelper.getTargetLimits(var_2_6, iter_2_3)

					if var_2_7 and #var_2_7 > 0 and not tabletool.indexOf(var_2_7, var_2_5) then
						var_2_5 = var_2_7[1]
					end

					local var_2_8 = SkillEditorStepBuilder.buildFightStepDataList(iter_2_3, var_2_4, var_2_5)

					for iter_2_4, iter_2_5 in ipairs(var_2_8) do
						arg_2_0.flow:addWork(FunctionWork.New(function()
							local var_3_0 = lua_skill.configDict[iter_2_3].name
							local var_3_1 = iter_2_3 .. "\n" .. string.format("当前技能\n%s\n剩余技能%s/%s", var_3_0, #var_2_3 - iter_2_2, #var_2_3)

							SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._onSwitchEnityOrSkill, {
								skillstr = var_3_1
							})
						end, arg_2_0))
						arg_2_0.flow:addWork(FightSkillEditorFlow.New(iter_2_5))
					end

					arg_2_0.flow:addWork(FunctionWork.New(function()
						arg_2_0._skillCount = arg_2_0._skillCount + 1
					end, arg_2_0))
					arg_2_0.flow:addWork(FunctionWork.New(arg_2_0._checkSkillDone, arg_2_0, {
						count = #var_2_3,
						id = iter_2_1.id
					}))
				end

				var_2_0 = true

				arg_2_0.flow:addWork(FunctionWork.New(arg_2_0._checkSkillDone, arg_2_0, {
					count = #var_2_1
				}))
			end
		end

		if var_2_0 then
			arg_2_0.flow:start()
		else
			arg_2_0:onDone(true)
		end
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0._getEntitySkillCOList(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.skillIds) do
		local var_5_2 = FightConfig.instance:getSkinSkillTimeline(arg_5_1.skin, iter_5_1)
		local var_5_3 = string.split(var_5_2, "_")

		if iter_5_1 and not string.nilorempty(var_5_2) and not var_5_1[var_5_3[#var_5_3]] then
			var_5_1[var_5_3[#var_5_3]] = true

			table.insert(var_5_0, iter_5_1)
		end
	end

	local var_5_4 = tostring(arg_5_1.modelId)

	for iter_5_2, iter_5_3 in ipairs(lua_skill.configList) do
		local var_5_5 = tostring(iter_5_3.id)
		local var_5_6 = iter_5_3.timeline

		if string.find(var_5_5, var_5_4) == 1 and not string.nilorempty(var_5_6) then
			local var_5_7 = string.split(var_5_6, "_")

			if iter_5_3.id and not string.nilorempty(var_5_6) and not var_5_1[var_5_7[#var_5_7]] then
				var_5_1[var_5_7[#var_5_7]] = true

				table.insert(var_5_0, iter_5_3.id)
			end
		end
	end

	return var_5_0
end

function var_0_0._stopFlow(arg_6_0)
	if arg_6_0.flow and arg_6_0.flow.status == WorkStatus.Running then
		local var_6_0 = arg_6_0.flow:getWorkList()

		for iter_6_0 = arg_6_0.flow._curIndex, #var_6_0 do
			var_6_0[iter_6_0]:onDone(true)
		end

		SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._StopAutoPlayFlow2, arg_6_0)
		arg_6_0:onDone(true)
	end
end

function var_0_0._checkSkillDone(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.count
	local var_7_1 = arg_7_1.id

	if not var_7_1 then
		if #arg_7_0._completeList == var_7_0 then
			arg_7_0:onDone(true)
		end
	elseif arg_7_0._skillCount == var_7_0 then
		table.insert(arg_7_0._completeList, var_7_1)

		arg_7_0._skillCount = 0
	end
end

function var_0_0.clearWork(arg_8_0)
	SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr._StopAutoPlayFlow1, arg_8_0._stopFlow, arg_8_0)
end

return var_0_0
