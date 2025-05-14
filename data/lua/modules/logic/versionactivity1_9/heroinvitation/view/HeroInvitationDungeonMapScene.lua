module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationDungeonMapScene", package.seeall)

local var_0_0 = class("HeroInvitationDungeonMapScene", DungeonMapScene)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#go_arrow")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._setInitPos(arg_2_0, arg_2_1)
	if not arg_2_0._mapCfg then
		return
	end

	local var_2_0 = arg_2_0.viewContainer.mapSceneElements

	if var_2_0._inRemoveElement then
		return
	end

	local var_2_1 = var_2_0._inRemoveElementId

	if not var_2_1 then
		local var_2_2 = DungeonConfig.instance:getMapElements(arg_2_0._mapCfg.id)

		if var_2_2 then
			for iter_2_0, iter_2_1 in ipairs(var_2_2) do
				local var_2_3 = HeroInvitationModel.instance:getInvitationStateByElementId(iter_2_1.id)

				if var_2_3 ~= HeroInvitationEnum.InvitationState.TimeLocked and var_2_3 ~= HeroInvitationEnum.InvitationState.ElementLocked and DungeonMapModel.instance:getElementById(iter_2_1.id) then
					var_2_1 = iter_2_1.id

					break
				end
			end
		end
	end

	if var_2_1 then
		DungeonMapModel.instance.directFocusElement = true

		arg_2_0:_focusElementById(var_2_1)

		DungeonMapModel.instance.directFocusElement = false
	else
		local var_2_4 = string.splitToNumber(arg_2_0._mapCfg.initPos, "#")

		arg_2_0:setScenePosSafety(Vector3(var_2_4[1], var_2_4[2], 0), arg_2_1)
	end
end

function var_0_0._onOpenView(arg_3_0, arg_3_1)
	return
end

function var_0_0._onCloseView(arg_4_0, arg_4_1)
	return
end

return var_0_0
