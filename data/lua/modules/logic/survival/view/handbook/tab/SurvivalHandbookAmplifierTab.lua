module("modules.logic.survival.view.handbook.tab.SurvivalHandbookAmplifierTab", package.seeall)

local var_0_0 = class("SurvivalHandbookAmplifierTab", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.btnClick = gohelper.findButtonWithAudio(arg_1_1)
	arg_1_0.image_Line = gohelper.findChild(arg_1_1, "image_Line")
	arg_1_0.txt_Common = gohelper.findChildTextMesh(arg_1_1, "txt_Common")
	arg_1_0.image_Icon = gohelper.findChildImage(arg_1_1, "txt_Common/image_Icon")
	arg_1_0.go_Selected = gohelper.findChild(arg_1_1, "#go_Selected")
	arg_1_0.select_txt_Common = gohelper.findChildTextMesh(arg_1_0.go_Selected, "txt_Common")
	arg_1_0.select_image_Icon = gohelper.findChildImage(arg_1_0.go_Selected, "txt_Common/image_Icon")
	arg_1_0.go_Selected = gohelper.findChild(arg_1_1, "#go_Selected")
	arg_1_0.go_redDot = gohelper.findChild(arg_1_1, "#go_redDot")

	arg_1_0:setSelect(false)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClick, arg_2_0.onClickBtnClick, arg_2_0)
end

function var_0_0.setData(arg_3_0, arg_3_1)
	arg_3_0.index = arg_3_1.index
	arg_3_0.handbookType = arg_3_1.handbookType
	arg_3_0.subType = arg_3_1.subType
	arg_3_0.onClickTabCallBack = arg_3_1.onClickTabCallBack
	arg_3_0.onClickTabContext = arg_3_1.onClickTabContext
	arg_3_0.isLast = arg_3_1.isLast

	RedDotController.instance:addRedDot(arg_3_0.go_redDot, RedDotEnum.DotNode.SurvivalHandbookAmplifier, arg_3_0.subType)
	gohelper.setActive(arg_3_0.image_Line, not arg_3_0.isLast)

	arg_3_0.txt_Common.text = SurvivalHandbookModel.instance:getTabTitleBySubType(arg_3_0.handbookType, arg_3_0.subType)
	arg_3_0.select_txt_Common.text = SurvivalHandbookModel.instance:getTabTitleBySubType(arg_3_0.handbookType, arg_3_0.subType)

	local var_3_0 = SurvivalHandbookModel.instance:getTabImageBySubType(arg_3_0.handbookType, arg_3_0.subType)

	UISpriteSetMgr.instance:setSurvivalSprite(arg_3_0.image_Icon, var_3_0)
	UISpriteSetMgr.instance:setSurvivalSprite(arg_3_0.select_image_Icon, var_3_0)
end

function var_0_0.onClickBtnClick(arg_4_0)
	if arg_4_0.onClickTabCallBack then
		arg_4_0.onClickTabCallBack(arg_4_0.onClickTabContext, arg_4_0)
	end
end

function var_0_0.setSelect(arg_5_0, arg_5_1)
	arg_5_0.isSelect = arg_5_1

	gohelper.setActive(arg_5_0.go_Selected, arg_5_0.isSelect)
end

return var_0_0
