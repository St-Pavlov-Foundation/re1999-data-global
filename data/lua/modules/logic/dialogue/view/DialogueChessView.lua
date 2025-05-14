module("modules.logic.dialogue.view.DialogueChessView", package.seeall)

local var_0_0 = class("DialogueChessView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gochesscontainer = gohelper.findChild(arg_1_0.viewGO, "#go_chesscontainer")
	arg_1_0._gochessitem = gohelper.findChild(arg_1_0.viewGO, "#go_chesscontainer/#go_chessitem")

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
	gohelper.setActive(arg_4_0._gochessitem, false)

	arg_4_0.chessItemList = {}

	arg_4_0:addEventCb(DialogueController.instance, DialogueEvent.BeforePlayStep, arg_4_0.onBeforePlayStep, arg_4_0)
end

function var_0_0.onOpenFinish(arg_5_0)
	arg_5_0.openFinishDone = true

	arg_5_0:onBeforePlayStep(arg_5_0.tempStepCo)

	arg_5_0.tempStepCo = nil
end

function var_0_0.initChessItem(arg_6_0)
	if arg_6_0.dialogueId then
		return
	end

	arg_6_0.dialogueId = arg_6_0.viewContainer.viewParam.dialogueId

	local var_6_0 = DialogueConfig.instance:getChessCoList(arg_6_0.dialogueId)

	if not var_6_0 then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		arg_6_0:createChessItem(iter_6_1)
	end
end

function var_0_0.onBeforePlayStep(arg_7_0, arg_7_1)
	arg_7_0:initChessItem()

	if not arg_7_0.openFinishDone then
		arg_7_0.tempStepCo = arg_7_1

		return
	end

	local var_7_0 = arg_7_1.chessId

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.chessItemList) do
		local var_7_1 = iter_7_1.chessCo.id == var_7_0

		gohelper.setActive(iter_7_1.goTalking, var_7_1)
		gohelper.setActive(iter_7_1.goFootShadow, var_7_1)

		if var_7_1 then
			iter_7_1.animator:Play("jump", 0, 0)
		end
	end
end

function var_0_0.createChessItem(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getUserDataTb_()

	var_8_0.go = gohelper.cloneInPlace(arg_8_0._gochessitem, arg_8_1.id)

	gohelper.setActive(var_8_0.go, true)

	var_8_0.animator = var_8_0.go:GetComponent(gohelper.Type_Animator)
	var_8_0.imageChess = gohelper.findChildSingleImage(var_8_0.go, "#chess")

	var_8_0.imageChess:LoadImage(ResUrl.getChessDialogueSingleBg(arg_8_1.res))

	var_8_0.goTalking = gohelper.findChild(var_8_0.go, "#go_talking")
	var_8_0.goFootShadow = gohelper.findChild(var_8_0.go, "light2")

	gohelper.setActive(var_8_0.goTalking, false)
	gohelper.setActive(var_8_0.goFootShadow, false)

	var_8_0.chessCo = arg_8_1

	table.insert(arg_8_0.chessItemList, var_8_0)

	local var_8_1 = string.splitToNumber(arg_8_1.pos, "#")

	recthelper.setAnchor(var_8_0.go.transform, var_8_1[1], var_8_1[2])

	return var_8_0
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.chessItemList) do
		iter_10_1.imageChess:UnLoadImage()
	end
end

return var_0_0
