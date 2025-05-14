module("modules.logic.versionactivity1_4.act132.view.Activity132CollectItem", package.seeall)

local var_0_0 = class("Activity132CollectItem", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0._viewGO = arg_1_1
	arg_1_0._goSelect = gohelper.findChild(arg_1_1, "beselected")
	arg_1_0._goUnSelected = gohelper.findChild(arg_1_1, "unselected")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_1, "btnclick")
	arg_1_0._selectNameTxt = gohelper.findChildTextMesh(arg_1_0._goSelect, "chapternamecn")
	arg_1_0._selectNameEnTxt = gohelper.findChildTextMesh(arg_1_0._goSelect, "chapternameen")
	arg_1_0._unselectNameTxt = gohelper.findChildTextMesh(arg_1_0._goUnSelected, "chapternamecn")
	arg_1_0._unselectNameEnTxt = gohelper.findChildTextMesh(arg_1_0._goUnSelected, "chapternameen")
	arg_1_0.goRedDot = gohelper.findChild(arg_1_1, "#go_reddot")

	arg_1_0:addClickCb(arg_1_0._btnclick, arg_1_0.onClickBtn, arg_1_0)
end

function var_0_0.onClickBtn(arg_2_0)
	if not arg_2_0.data or arg_2_0.isSelect then
		return
	end

	Activity132Model.instance:setSelectCollectId(arg_2_0.data.activityId, arg_2_0.data.collectId)
end

function var_0_0.setData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.data = arg_3_1

	if not arg_3_1 then
		gohelper.setActive(arg_3_0._viewGO, false)

		if arg_3_0._redDot then
			arg_3_0._redDot:setId()
			arg_3_0._redDot:refreshDot()
		end

		return
	end

	gohelper.setActive(arg_3_0._viewGO, true)

	local var_3_0 = arg_3_1:getName()
	local var_3_1 = GameUtil.utf8sub(var_3_0, 1, 1)
	local var_3_2 = ""
	local var_3_3 = GameUtil.utf8len(var_3_0)

	if var_3_3 >= 2 then
		var_3_2 = GameUtil.utf8sub(var_3_0, 2, var_3_3 - 1)
	end

	local var_3_4 = string.format("<size=46>%s</size>%s", var_3_1, var_3_2)

	arg_3_0._selectNameTxt.text = var_3_4
	arg_3_0._selectNameEnTxt.text = arg_3_1.nameEn
	arg_3_0._unselectNameTxt.text = var_3_4
	arg_3_0._unselectNameEnTxt.text = arg_3_1.nameEn

	arg_3_0:setSelectId(arg_3_2)

	if not arg_3_0._redDot then
		arg_3_0._redDot = RedDotController.instance:addRedDot(arg_3_0.goRedDot, 1081, arg_3_1.collectId)
	else
		arg_3_0._redDot:setId(1081, arg_3_1.collectId)
		arg_3_0._redDot:refreshDot()
	end
end

function var_0_0.setSelectId(arg_4_0, arg_4_1)
	if not arg_4_0.data then
		return
	end

	local var_4_0 = arg_4_1 == arg_4_0.data.collectId

	arg_4_0.isSelect = var_4_0

	gohelper.setActive(arg_4_0._goSelect, var_4_0)
	gohelper.setActive(arg_4_0._goUnSelected, not var_4_0)
end

function var_0_0.destroy(arg_5_0)
	arg_5_0:__onDispose()
end

return var_0_0
