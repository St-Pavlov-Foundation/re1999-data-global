module("modules.logic.necrologiststory.view.item.NecrologistStoryOptionsItem", package.seeall)

local var_0_0 = class("NecrologistStoryOptionsItem", NecrologistStoryBaseItem)

function var_0_0.onInit(arg_1_0)
	arg_1_0.goContent = gohelper.findChild(arg_1_0.viewGO, "content")
	arg_1_0.rectTrContent = arg_1_0.goContent.transform
	arg_1_0.goOption = gohelper.findChild(arg_1_0.viewGO, "content/optionItem")

	gohelper.setActive(arg_1_0.goOption, false)

	arg_1_0.itemList = {}
end

function var_0_0.onClickOption(arg_2_0, arg_2_1)
	if arg_2_0:isDone() then
		return
	end

	arg_2_0.selectSection = arg_2_1.section

	arg_2_0:refreshOptionList()
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnSelectSection, arg_2_0.selectSection)
end

function var_0_0.onPlayStory(arg_3_0)
	arg_3_0.selectSection = nil

	arg_3_0:refreshOptionList()
end

function var_0_0.refreshOptionList(arg_4_0)
	local var_4_0 = arg_4_0:getStoryConfig()
	local var_4_1 = string.splitToNumber(var_4_0.param, "#")
	local var_4_2 = string.split(NecrologistStoryHelper.getDescByConfig(var_4_0), "#")

	for iter_4_0 = 1, math.max(#var_4_1, #arg_4_0.itemList) do
		local var_4_3 = arg_4_0:getOptionItem(iter_4_0)

		arg_4_0:updateOptionItem(var_4_3, var_4_1[iter_4_0], var_4_2[iter_4_0])
	end

	ZProj.UGUIHelper.RebuildLayout(arg_4_0.rectTrContent)
end

function var_0_0.updateOptionItem(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_2 then
		gohelper.setActive(arg_5_1.go, false)

		return
	end

	arg_5_1.section = arg_5_2

	gohelper.setActive(arg_5_1.go, true)

	local var_5_0 = arg_5_0.selectSection ~= nil

	if var_5_0 then
		gohelper.setActive(arg_5_1.goCanClick, false)

		local var_5_1 = arg_5_0.selectSection == arg_5_2

		gohelper.setActive(arg_5_1.goSelect, var_5_1)
		gohelper.setActive(arg_5_1.goUnSelect, not var_5_1)
	else
		gohelper.setActive(arg_5_1.goCanClick, true)
		gohelper.setActive(arg_5_1.goSelect, false)
		gohelper.setActive(arg_5_1.goUnSelect, false)
	end

	arg_5_1.txtContent.text = arg_5_3
	arg_5_1.btn.button.interactable = not var_5_0

	gohelper.setActive(arg_5_1.goRaycast, not var_5_0)
end

function var_0_0.getOptionItem(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.itemList[arg_6_1]

	if not var_6_0 then
		var_6_0 = arg_6_0:getUserDataTb_()

		local var_6_1 = gohelper.cloneInPlace(arg_6_0.goOption, tostring(arg_6_1))

		var_6_0.go = var_6_1
		var_6_0.goRaycast = gohelper.findChild(var_6_1, "raycast")
		var_6_0.goCanClick = gohelper.findChild(var_6_1, "canclick")
		var_6_0.goUnSelect = gohelper.findChild(var_6_1, "unselect")
		var_6_0.goSelect = gohelper.findChild(var_6_1, "select")
		var_6_0.txtContent = gohelper.findChildTextMesh(var_6_1, "#txt_choice")
		var_6_0.btn = gohelper.findButtonWithAudio(var_6_1)

		var_6_0.btn:AddClickListener(arg_6_0.onClickOption, arg_6_0, var_6_0)

		arg_6_0.itemList[arg_6_1] = var_6_0
	end

	return var_6_0
end

function var_0_0.caleHeight(arg_7_0)
	return (recthelper.getHeight(arg_7_0.rectTrContent))
end

function var_0_0.isDone(arg_8_0)
	return arg_8_0.selectSection ~= nil
end

function var_0_0.onDestroy(arg_9_0)
	if arg_9_0.itemList then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0.itemList) do
			iter_9_1.btn:RemoveClickListener()
		end
	end
end

function var_0_0.getResPath()
	return "ui/viewres/dungeon/rolestory/necrologiststoryoptionsitem.prefab"
end

return var_0_0
