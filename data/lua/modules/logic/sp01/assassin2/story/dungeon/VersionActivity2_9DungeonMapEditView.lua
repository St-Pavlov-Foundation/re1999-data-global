module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapEditView", package.seeall)

local var_0_0 = class("VersionActivity2_9DungeonMapEditView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._mapScene = arg_1_0.viewContainer.mapScene
	arg_1_0._isEditMode = false

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.frameHandle = UpdateBeat:CreateListener(arg_2_0.onFrame, arg_2_0)

	UpdateBeat:AddListener(arg_2_0.frameHandle)
end

function var_0_0.removeEvents(arg_3_0)
	if arg_3_0.frameHandle then
		UpdateBeat:RemoveListener(arg_3_0.frameHandle)
	end
end

function var_0_0.onFrame(arg_4_0)
	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.Q) then
		arg_4_0._isEditMode = not arg_4_0._isEditMode

		if arg_4_0._isEditMode then
			GameFacade.showToastString("EnterEditMode")
		else
			GameFacade.showToastString("ExitEditMode")
		end
	end

	if not arg_4_0._isEditMode then
		return
	end

	if not arg_4_0._mapScene then
		return
	end

	arg_4_0._mapScene:_brocastAllNodePos()
end

return var_0_0
