module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationDungeonMapHoleView", package.seeall)

local var_0_0 = class("HeroInvitationDungeonMapHoleView", DungeonMapHoleView)

function var_0_0.refreshHoles(arg_1_0)
	if not arg_1_0.loadSceneDone or gohelper.isNil(arg_1_0.mat) then
		return
	end

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in pairs(arg_1_0.holdCoList) do
		local var_1_1 = iter_1_1[4]
		local var_1_2 = iter_1_1[1] + arg_1_0.sceneWorldPosX - arg_1_0.defaultSceneWorldPosX
		local var_1_3 = iter_1_1[2] + arg_1_0.sceneWorldPosY - arg_1_0.defaultSceneWorldPosY
		local var_1_4 = math.abs(iter_1_1[3])
		local var_1_5 = math.sqrt((arg_1_0.mainCameraPosX - var_1_2)^2)
		local var_1_6 = math.sqrt((arg_1_0.mainCameraPosY - var_1_3)^2)

		if var_1_5 <= arg_1_0._mapHalfWidth + var_1_4 and var_1_6 <= arg_1_0._mapHalfHeight + var_1_4 then
			local var_1_7 = {
				finish = 0,
				distance = -(var_1_5 * var_1_5 + var_1_6 * var_1_6),
				pos = {
					var_1_2,
					var_1_3,
					iter_1_1[3]
				},
				id = var_1_1 or 0
			}

			if var_1_1 and var_1_1 > 0 then
				var_1_7.finish = DungeonMapModel.instance:elementIsFinished(var_1_1) and 0 or 1
			end

			table.insert(var_1_0, var_1_7)
		end
	end

	if #var_1_0 > 1 then
		table.sort(var_1_0, SortUtil.tableKeyUpper({
			"finish",
			"distance",
			"id"
		}))
	end

	for iter_1_2 = 1, 5 do
		local var_1_8 = var_1_0[iter_1_2]

		if var_1_8 then
			arg_1_0.tempVector4:Set(var_1_8.pos[1], var_1_8.pos[2], var_1_8.pos[3])
			arg_1_0.mat:SetVector(arg_1_0.shaderParamList[iter_1_2], arg_1_0.tempVector4)
		else
			arg_1_0.tempVector4:Set(0, 0, 0)
			arg_1_0.mat:SetVector(arg_1_0.shaderParamList[iter_1_2], arg_1_0.tempVector4)
		end
	end
end

return var_0_0
