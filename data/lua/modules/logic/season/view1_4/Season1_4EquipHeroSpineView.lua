module("modules.logic.season.view1_4.Season1_4EquipHeroSpineView", package.seeall)

local var_0_0 = class("Season1_4EquipHeroSpineView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "#go_normal/left/#go_herocontainer/dynamiccontainer/#go_spine")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._uiSpine = GuiSpine.Create(arg_4_0._gospine, true)

	arg_4_0:createSpine()
end

function var_0_0.onDestroyView(arg_5_0)
	if arg_5_0._uiSpine then
		arg_5_0._uiSpine:onDestroy()

		arg_5_0._uiSpine = nil
	end
end

function var_0_0.onOpen(arg_6_0)
	return
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.createSpine(arg_8_0)
	local var_8_0 = ResUrl.getRolesCgStory(Activity104Enum.MainRoleSkinPath)

	arg_8_0._uiSpine:setResPath(var_8_0, arg_8_0.onSpineLoaded, arg_8_0)
end

function var_0_0.onSpineLoaded(arg_9_0)
	arg_9_0._spineLoaded = true

	if arg_9_0._uiSpine then
		arg_9_0._uiSpine:changeLookDir(SpineLookDir.Left)
		arg_9_0._uiSpine:SetAnimation(BaseSpine.FaceTrackIndex, "idle", true, 0)
	end
end

return var_0_0
