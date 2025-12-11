module("modules.logic.necrologiststory.view.item.NecrologistStoryLocationItem", package.seeall)

local var_0_0 = class("NecrologistStoryLocationItem", NecrologistStoryBaseItem)

function var_0_0.onInit(arg_1_0)
	arg_1_0.txtContent = gohelper.findChildTextMesh(arg_1_0.viewGO, "content/txtContent")
end

function var_0_0.onPlayStory(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:getStoryConfig()
	local var_2_1, var_2_2 = NecrologistStoryHelper.getDescByConfig(var_2_0)

	arg_2_0.txtContent.raycastTarget = var_2_2
	arg_2_0.txtContent.text = var_2_1

	arg_2_0:onTextFinish()

	if not arg_2_1 then
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_poltsfx_landmark)
	end
end

function var_0_0.onTextFinish(arg_3_0)
	arg_3_0:onPlayFinish()
end

function var_0_0.isDone(arg_4_0)
	return true
end

function var_0_0.justDone(arg_5_0)
	return
end

function var_0_0.caleHeight(arg_6_0)
	return 60
end

function var_0_0.getTextStr(arg_7_0)
	return arg_7_0.txtContent.text
end

function var_0_0.getResPath()
	return "ui/viewres/dungeon/rolestory/necrologiststorylocationitem.prefab"
end

return var_0_0
