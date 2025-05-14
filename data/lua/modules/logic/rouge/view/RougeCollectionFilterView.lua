module("modules.logic.rouge.view.RougeCollectionFilterView", package.seeall)

local var_0_0 = class("RougeCollectionFilterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gobase = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/layoutgroup/#go_base")
	arg_1_0._gobaseContainer = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/layoutgroup/#go_base/#go_baseContainer")
	arg_1_0._gorareItem = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/layoutgroup/#go_base/#go_baseContainer/#go_rareItem")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "container/Scroll View/Viewport/layoutgroup/#go_base/#go_baseContainer/#go_rareItem/#image_icon")
	arg_1_0._goextra = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/layoutgroup/#go_extra")
	arg_1_0._goextraContainer = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/layoutgroup/#go_extra/#go_extraContainer")
	arg_1_0._goextraItem = gohelper.findChild(arg_1_0.viewGO, "container/Scroll View/Viewport/layoutgroup/#go_extra/#go_extraContainer/#go_extraItem")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/#btn_reset")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/#btn_confirm")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnresetOnClick(arg_5_0)
	tabletool.clear(arg_5_0._baseBtnSelectMap)
	tabletool.clear(arg_5_0._extraBtnSelectMap)
	arg_5_0:BuildCollectionTagList()
	arg_5_0:BuildCollectionTypeList()
end

function var_0_0._btnconfirmOnClick(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.confirmCallback

	if var_6_0 then
		local var_6_1 = arg_6_0.viewParam and arg_6_0.viewParam.confirmCallbackObj

		var_6_0(var_6_1, arg_6_0._baseBtnSelectMap, arg_6_0._extraBtnSelectMap)
	end

	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._extraBtnMap = arg_7_0:getUserDataTb_()
	arg_7_0._baseBtnMap = arg_7_0:getUserDataTb_()
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:onInit()
end

function var_0_0.onInit(arg_10_0)
	arg_10_0:BuildSelectMap()
	arg_10_0:BuildCollectionTagList()
	arg_10_0:BuildCollectionTypeList()
end

function var_0_0.BuildSelectMap(arg_11_0)
	if arg_11_0.viewParam.baseSelectMap then
		arg_11_0._baseBtnSelectMap = arg_11_0.viewParam.baseSelectMap
	else
		arg_11_0._baseBtnSelectMap = {}
	end

	if arg_11_0.viewParam.extraSelectMap then
		arg_11_0._extraBtnSelectMap = arg_11_0.viewParam.extraSelectMap
	else
		arg_11_0._extraBtnSelectMap = {}
	end
end

function var_0_0.BuildCollectionTagList(arg_12_0)
	local var_12_0 = RougeCollectionConfig.instance:getCollectionBaseTags()

	GoHelperExtend.CreateObjList(arg_12_0, arg_12_0.refreshBaseTagBtn, var_12_0, arg_12_0._gobaseContainer, arg_12_0._gorareItem)
end

local var_0_1 = "#B6B2A8"
local var_0_2 = "#ECA373"

function var_0_0.refreshBaseTagBtn(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if not arg_13_0._baseBtnMap[arg_13_3] then
		arg_13_0._baseBtnMap[arg_13_3] = arg_13_0:getUserDataTb_()
		arg_13_0._baseBtnMap[arg_13_3].tagId = arg_13_2.id
		arg_13_0._baseBtnMap[arg_13_3].goUnselected = gohelper.findChild(arg_13_1, "unselected")
		arg_13_0._baseBtnMap[arg_13_3].goselected = gohelper.findChild(arg_13_1, "selected")
		arg_13_0._baseBtnMap[arg_13_3].txtname = gohelper.findChildText(arg_13_1, "tagText")
		arg_13_0._baseBtnMap[arg_13_3].imagetagicon = gohelper.findChildImage(arg_13_1, "#image_icon")
		arg_13_0._baseBtnMap[arg_13_3].btnclick = gohelper.findChildButtonWithAudio(arg_13_1, "click")

		arg_13_0._baseBtnMap[arg_13_3].btnclick:AddClickListener(arg_13_0.onClickBaseBtnItem, arg_13_0, arg_13_0._baseBtnMap[arg_13_3])
	end

	local var_13_0 = arg_13_0._baseBtnSelectMap[arg_13_2.id] or false

	gohelper.setActive(arg_13_0._baseBtnMap[arg_13_3].goUnselected, not var_13_0)
	gohelper.setActive(arg_13_0._baseBtnMap[arg_13_3].goselected, var_13_0)

	arg_13_0._baseBtnMap[arg_13_3].txtname.text = tostring(arg_13_2.name)

	SLFramework.UGUI.GuiHelper.SetColor(arg_13_0._baseBtnMap[arg_13_3].txtname, var_13_0 and var_0_2 or var_0_1)
	UISpriteSetMgr.instance:setRougeSprite(arg_13_0._baseBtnMap[arg_13_3].imagetagicon, arg_13_2.iconUrl)
end

function var_0_0.onClickBaseBtnItem(arg_14_0, arg_14_1)
	local var_14_0 = not (arg_14_0._baseBtnSelectMap[arg_14_1.tagId] or false)

	arg_14_0._baseBtnSelectMap[arg_14_1.tagId] = var_14_0 and true or nil

	gohelper.setActive(arg_14_1.goUnselected, not var_14_0)
	gohelper.setActive(arg_14_1.goselected, var_14_0)
	SLFramework.UGUI.GuiHelper.SetColor(arg_14_1.txtname, var_14_0 and var_0_2 or var_0_1)
end

function var_0_0.BuildCollectionTypeList(arg_15_0)
	local var_15_0 = RougeCollectionConfig.instance:getCollectionExtraTags()

	GoHelperExtend.CreateObjList(arg_15_0, arg_15_0.refreshExtraTagBtn, var_15_0, arg_15_0._goextraContainer, arg_15_0._goextraItem)
end

function var_0_0.refreshExtraTagBtn(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if not arg_16_0._extraBtnMap[arg_16_3] then
		arg_16_0._extraBtnMap[arg_16_3] = arg_16_0:getUserDataTb_()
		arg_16_0._extraBtnMap[arg_16_3].typeId = arg_16_2.id
		arg_16_0._extraBtnMap[arg_16_3].goUnselected = gohelper.findChild(arg_16_1, "unselected")
		arg_16_0._extraBtnMap[arg_16_3].goselected = gohelper.findChild(arg_16_1, "selected")
		arg_16_0._extraBtnMap[arg_16_3].txtname = gohelper.findChildText(arg_16_1, "tagText")
		arg_16_0._extraBtnMap[arg_16_3].imagetagicon = gohelper.findChildImage(arg_16_1, "#image_icon")
		arg_16_0._extraBtnMap[arg_16_3].btnclick = gohelper.findChildButtonWithAudio(arg_16_1, "click")

		arg_16_0._extraBtnMap[arg_16_3].btnclick:AddClickListener(arg_16_0.onClickExtraBtnItem, arg_16_0, arg_16_0._extraBtnMap[arg_16_3])
	end

	local var_16_0 = arg_16_0._extraBtnSelectMap[arg_16_2.id] or false

	gohelper.setActive(arg_16_0._extraBtnMap[arg_16_3].goUnselected, not var_16_0)
	gohelper.setActive(arg_16_0._extraBtnMap[arg_16_3].goselected, var_16_0)

	arg_16_0._extraBtnMap[arg_16_3].txtname.text = tostring(arg_16_2.name)

	SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._extraBtnMap[arg_16_3].txtname, var_16_0 and var_0_2 or var_0_1)
	UISpriteSetMgr.instance:setRougeSprite(arg_16_0._extraBtnMap[arg_16_3].imagetagicon, arg_16_2.iconUrl)
end

function var_0_0.onClickExtraBtnItem(arg_17_0, arg_17_1)
	local var_17_0 = not arg_17_0._extraBtnSelectMap[arg_17_1.typeId]

	arg_17_0._extraBtnSelectMap[arg_17_1.typeId] = var_17_0 and true or nil

	gohelper.setActive(arg_17_1.goUnselected, not var_17_0)
	gohelper.setActive(arg_17_1.goselected, var_17_0)
	SLFramework.UGUI.GuiHelper.SetColor(arg_17_1.txtname, var_17_0 and var_0_2 or var_0_1)
end

function var_0_0.releaseAllClickListeners(arg_18_0)
	if arg_18_0._baseBtnMap then
		for iter_18_0, iter_18_1 in pairs(arg_18_0._baseBtnMap) do
			iter_18_1.btnclick:RemoveClickListener()
		end
	end

	if arg_18_0._extraBtnMap then
		for iter_18_2, iter_18_3 in pairs(arg_18_0._extraBtnMap) do
			iter_18_3.btnclick:RemoveClickListener()
		end
	end
end

function var_0_0.onClose(arg_19_0)
	return
end

function var_0_0.onDestroyView(arg_20_0)
	arg_20_0:releaseAllClickListeners()
end

return var_0_0
