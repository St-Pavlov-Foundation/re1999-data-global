module("modules.logic.necrologiststory.view.item.NecrologistStoryDialogItem", package.seeall)

local var_0_0 = class("NecrologistStoryDialogItem", NecrologistStoryBaseItem)

function var_0_0.onInit(arg_1_0)
	arg_1_0.heroBg = gohelper.findChild(arg_1_0.viewGO, "descer/herobg")
	arg_1_0.npcBg = gohelper.findChild(arg_1_0.viewGO, "descer/npcbg")
	arg_1_0.txtDescer = gohelper.findChildTextMesh(arg_1_0.viewGO, "descer/txtDescer")
	arg_1_0.txtContent = gohelper.findChildTextMesh(arg_1_0.viewGO, "content/txtContent")
	arg_1_0.txtComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.txtContent.gameObject, NecrologistStoryTextComp)
	arg_1_0.space = 62
end

function var_0_0.onPlayStory(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:getStoryConfig()
	local var_2_1, var_2_2 = NecrologistStoryHelper.getDialogName(var_2_0)

	arg_2_0.txtDescer.text = var_2_2

	gohelper.setActive(arg_2_0.heroBg, var_2_1)
	gohelper.setActive(arg_2_0.npcBg, not var_2_1)

	local var_2_3, var_2_4 = NecrologistStoryHelper.getDescByConfig(var_2_0)

	arg_2_0.hasLink = var_2_4
	arg_2_0.txtContent.raycastTarget = var_2_4

	if arg_2_0.hasLink and not GuideController.instance:isForbidGuides() and not GuideModel.instance:isGuideFinish(GuideEnum.GuideId.NecrologistStoryLinkText) then
		arg_2_1 = false

		NecrologistStoryModel.instance:getCurStoryMO():setIsAuto(false)
	end

	if arg_2_1 then
		arg_2_0.txtComp:setTextNormal(var_2_3)
	else
		arg_2_0.txtComp:setTextWithTypewriter(var_2_3, arg_2_0.refreshHeight, arg_2_0.onTextFinish, arg_2_0)
	end
end

function var_0_0.onTextFinish(arg_3_0)
	if arg_3_0.hasLink then
		NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnLinkText)
	end

	arg_3_0:onPlayFinish()
end

function var_0_0.caleHeight(arg_4_0)
	return arg_4_0.txtContent.preferredHeight + arg_4_0.space
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
	return "ui/viewres/dungeon/rolestory/necrologiststorydialogitem.prefab"
end

return var_0_0
