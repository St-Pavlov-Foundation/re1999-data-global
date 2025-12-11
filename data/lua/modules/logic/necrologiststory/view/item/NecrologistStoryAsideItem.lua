module("modules.logic.necrologiststory.view.item.NecrologistStoryAsideItem", package.seeall)

local var_0_0 = class("NecrologistStoryAsideItem", NecrologistStoryBaseItem)

function var_0_0.onInit(arg_1_0)
	arg_1_0.txtContent = gohelper.findChildTextMesh(arg_1_0.viewGO, "content/txtContent")
	arg_1_0.txtComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.txtContent.gameObject, NecrologistStoryTextComp)
end

function var_0_0.onPlayStory(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:getStoryConfig()
	local var_2_1, var_2_2 = NecrologistStoryHelper.getDescByConfig(var_2_0)

	arg_2_0.hasLink = var_2_2
	arg_2_0.txtContent.raycastTarget = var_2_2

	if arg_2_0.hasLink and not GuideController.instance:isForbidGuides() and not GuideModel.instance:isGuideFinish(GuideEnum.GuideId.NecrologistStoryLinkText) then
		arg_2_1 = false

		NecrologistStoryModel.instance:getCurStoryMO():setIsAuto(false)
	end

	if arg_2_1 then
		arg_2_0.txtComp:setTextNormal(var_2_1)
	else
		arg_2_0.txtComp:setTextWithTypewriter(var_2_1, arg_2_0.refreshHeight, arg_2_0.onTextFinish, arg_2_0)
	end
end

function var_0_0.onTextFinish(arg_3_0)
	if arg_3_0.hasLink then
		NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnLinkText)
	end

	arg_3_0:onPlayFinish()
end

function var_0_0.caleHeight(arg_4_0)
	return arg_4_0.txtContent.preferredHeight
end

function var_0_0.isDone(arg_5_0)
	return arg_5_0.txtComp:isDone()
end

function var_0_0.justDone(arg_6_0)
	if arg_6_0.hasLink and not GuideModel.instance:isGuideFinish(GuideEnum.GuideId.NecrologistStoryLinkText) then
		return
	end

	arg_6_0.txtComp:onTextFinish()
end

function var_0_0.getTextStr(arg_7_0)
	return arg_7_0.txtComp and arg_7_0.txtComp:getTextStr()
end

function var_0_0.getResPath()
	return "ui/viewres/dungeon/rolestory/necrologiststoryasideitem.prefab"
end

return var_0_0
