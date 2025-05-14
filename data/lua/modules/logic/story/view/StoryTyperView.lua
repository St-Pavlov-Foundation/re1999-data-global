module("modules.logic.story.view.StoryTyperView", package.seeall)

local var_0_0 = class("StoryTyperView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "#go_bg")
	arg_1_0._gotyper1 = gohelper.findChild(arg_1_0.viewGO, "#go_typer1")
	arg_1_0._gologo = gohelper.findChild(arg_1_0.viewGO, "#go_typer1/#go_logo")
	arg_1_0._txttyper1 = gohelper.findChildText(arg_1_0.viewGO, "#go_typer1/#txt_typer1")
	arg_1_0._gotyper2 = gohelper.findChild(arg_1_0.viewGO, "#go_typer2")
	arg_1_0._txttyper2 = gohelper.findChildText(arg_1_0.viewGO, "#go_typer2/#txt_typer2")

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

local var_0_1 = 0.05
local var_0_2 = 0.2
local var_0_3 = 0.3
local var_0_4 = 0.1
local var_0_5 = 0.8
local var_0_6 = 0

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_4_0.viewGO)
	arg_4_0._singleBg = gohelper.getSingleImage(arg_4_0._gobg)

	arg_4_0._singleBg:LoadImage(ResUrl.getStoryBg("typerbg.png"))
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._type = arg_5_0.viewParam.type

	local var_5_0 = arg_5_0._type == 1 and arg_5_0._txttyper1.text or arg_5_0._txttyper2.text

	var_5_0 = arg_5_0.viewParam.content and arg_5_0.viewParam.content or var_5_0
	arg_5_0._txttyper1.text = ""
	arg_5_0._txttyper2.text = ""

	if arg_5_0._type == 1 then
		local var_5_1 = "start1"
		local var_5_2 = 1
		local var_5_3 = arg_5_0._txttyper1
		local var_5_4 = "end1"
		local var_5_5 = arg_5_0._type1End

		arg_5_0:_playTyper(var_5_1, var_5_4, var_5_3, var_5_0, var_5_5)
	elseif arg_5_0._type == 2 then
		local var_5_6 = "start2"
		local var_5_7 = 1
		local var_5_8 = arg_5_0._txttyper2
		local var_5_9 = "end2"
		local var_5_10 = arg_5_0._type2End

		arg_5_0:_playTyper(var_5_6, var_5_9, var_5_8, var_5_0, var_5_10)
	end
end

function var_0_0._playTyper(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	arg_6_0._typerStartAnim = arg_6_1
	arg_6_0._typerEndAnim = arg_6_2
	arg_6_0._text = arg_6_3
	arg_6_0._content = arg_6_4
	arg_6_0._callback = arg_6_5

	if not string.nilorempty(arg_6_0._typerStartAnim) then
		arg_6_0._animatorPlayer:Play(arg_6_0._typerStartAnim, arg_6_0._delayStart, arg_6_0)
	else
		arg_6_0:_delayStart()
	end
end

function var_0_0._delayStart(arg_7_0)
	arg_7_0._delayList = {}

	local var_7_0 = string.len(arg_7_0._content)

	for iter_7_0 = 1, var_7_0 do
		local var_7_1 = string.sub(arg_7_0._content, iter_7_0, iter_7_0)

		if var_7_1 == "\n" then
			local var_7_2 = var_0_5 + math.random() * var_0_6

			table.insert(arg_7_0._delayList, var_7_2)
		elseif var_7_1 == " " then
			local var_7_3 = var_0_3 + math.random() * var_0_4

			table.insert(arg_7_0._delayList, var_7_3)
		else
			local var_7_4 = var_0_1 + math.random() * var_0_2

			table.insert(arg_7_0._delayList, var_7_4)
		end
	end

	arg_7_0._LetterIndex = 0

	arg_7_0:_printLetter()
end

function var_0_0._printLetter(arg_8_0)
	arg_8_0._LetterIndex = arg_8_0._LetterIndex + 1

	local var_8_0 = string.sub(arg_8_0._content, 1, arg_8_0._LetterIndex)

	arg_8_0._text.text = var_8_0

	if arg_8_0._LetterIndex < string.len(arg_8_0._content) then
		local var_8_1 = arg_8_0._delayList[arg_8_0._LetterIndex]

		if var_8_1 > 0 then
			TaskDispatcher.runDelay(arg_8_0._printLetter, arg_8_0, var_8_1)
		else
			arg_8_0:_printLetter()
		end
	elseif not string.nilorempty(arg_8_0._typerEndAnim) then
		arg_8_0._animatorPlayer:Play(arg_8_0._typerEndAnim, arg_8_0._delayEnd, arg_8_0)
	else
		arg_8_0:_delayEnd()
	end
end

function var_0_0._delayEnd(arg_9_0)
	if arg_9_0._callback then
		arg_9_0._callback(arg_9_0)
	else
		arg_9_0:closeThis()
	end
end

function var_0_0._type1End(arg_10_0)
	arg_10_0:closeThis()
end

function var_0_0._type2End(arg_11_0)
	arg_11_0:closeThis()
end

function var_0_0.onClose(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._printLetter, arg_12_0)
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0._singleBg:UnLoadImage()
end

return var_0_0
