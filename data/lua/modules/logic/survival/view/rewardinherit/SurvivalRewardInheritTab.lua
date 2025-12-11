module("modules.logic.survival.view.rewardinherit.SurvivalRewardInheritTab", package.seeall)

local var_0_0 = class("SurvivalRewardInheritTab", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.btnClick = gohelper.findButtonWithAudio(arg_1_1)
	arg_1_0.image_Line = gohelper.findChild(arg_1_1, "image_Line")
	arg_1_0.txt_Common = gohelper.findChildTextMesh(arg_1_1, "txt_Common")
	arg_1_0.image_Icon = gohelper.findChildImage(arg_1_1, "txt_Common/image_Icon")
	arg_1_0.go_Selected = gohelper.findChild(arg_1_1, "#go_Selected")
	arg_1_0.select_txt_Common = gohelper.findChildTextMesh(arg_1_0.go_Selected, "txt_Common")
	arg_1_0.select_image_Icon = gohelper.findChildImage(arg_1_0.go_Selected, "txt_Common/image_Icon")
	arg_1_0.go_num = gohelper.findChild(arg_1_1, "#go_num")
	arg_1_0.textRedDot = gohelper.findChildTextMesh(arg_1_1, "#go_num/#txt_num")
	arg_1_0.image_Line = gohelper.findChild(arg_1_1, "image_Line")

	arg_1_0:setSelect(false)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClick, arg_2_0.onClickBtnClick, arg_2_0)
end

function var_0_0.setData(arg_3_0, arg_3_1)
	if arg_3_1 == nil then
		return
	end

	arg_3_0.index = arg_3_1.index
	arg_3_0.handbookType = arg_3_1.handbookType
	arg_3_0.subType = arg_3_1.subType
	arg_3_0.onClickTabCallBack = arg_3_1.onClickTabCallBack
	arg_3_0.onClickTabContext = arg_3_1.onClickTabContext
	arg_3_0.isLast = arg_3_1.isLast
	arg_3_0.isTransflective = arg_3_1.isTransflective

	gohelper.setActive(arg_3_0.image_Line, not arg_3_0.isLast)

	arg_3_0.txt_Common.text = SurvivalHandbookModel.instance:getTabTitleBySubType(arg_3_0.handbookType, arg_3_0.subType)
	arg_3_0.select_txt_Common.text = SurvivalHandbookModel.instance:getTabTitleBySubType(arg_3_0.handbookType, arg_3_0.subType)

	local var_3_0 = SurvivalHandbookModel.instance:getTabImageBySubType(arg_3_0.handbookType, arg_3_0.subType)

	UISpriteSetMgr.instance:setSurvivalSprite(arg_3_0.image_Icon, var_3_0)
	UISpriteSetMgr.instance:setSurvivalSprite(arg_3_0.select_image_Icon, var_3_0)
	arg_3_0:refreshAmount()

	local var_3_1 = arg_3_0.image_Icon.color
	local var_3_2 = arg_3_0.txt_Common.color

	if arg_3_0.isTransflective then
		arg_3_0.image_Icon.color = Color.New(var_3_1.r, var_3_1.g, var_3_1.b, 0.5)
		arg_3_0.txt_Common.color = Color.New(var_3_2.r, var_3_2.g, var_3_2.b, 0.5)
	else
		arg_3_0.image_Icon.color = Color.New(var_3_1.r, var_3_1.g, var_3_1.b, 1)
		arg_3_0.txt_Common.color = Color.New(var_3_2.r, var_3_2.g, var_3_2.b, 1)
	end
end

function var_0_0.refreshAmount(arg_4_0)
	local var_4_0 = SurvivalRewardInheritModel.instance:getSelectNum(arg_4_0.handbookType, arg_4_0.subType)

	if var_4_0 > 0 then
		gohelper.setActive(arg_4_0.go_num, true)

		arg_4_0.textRedDot.text = var_4_0
	else
		gohelper.setActive(arg_4_0.go_num, false)
	end
end

function var_0_0.onClickBtnClick(arg_5_0)
	if arg_5_0.onClickTabCallBack then
		arg_5_0.onClickTabCallBack(arg_5_0.onClickTabContext, arg_5_0)
	end
end

function var_0_0.setSelect(arg_6_0, arg_6_1)
	arg_6_0.isSelect = arg_6_1

	gohelper.setActive(arg_6_0.go_Selected, arg_6_0.isSelect)
end

return var_0_0
